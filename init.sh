#!/usr/bin/env bash

# Script para inicializar el entorno de contenedores Ubuntu
# Crea una red bridge y 3 contenedores conectados a ella

echo "🚀 Iniciando configuración de contenedores Ubuntu..."
echo ""

# Crear la red bridge
echo "📡 Creando red ubuntu_network..."
docker network create --driver bridge ubuntu_network

echo ""
echo "📥 Descargando imagen Ubuntu 22.04..."
docker pull ubuntu:22.04

echo ""
echo "🐳 Creando contenedores..."

# Crear contenedor m1
echo "  → Creando contenedor m1..."
docker run -dit --name m1 --hostname m1 --network ubuntu_network ubuntu:22.04 bash

# Crear contenedor m2
echo "  → Creando contenedor m2..."
docker run -dit --name m2 --hostname m2 --network ubuntu_network ubuntu:22.04 bash

# Crear contenedor m3
echo "  → Creando contenedor m3..."
docker run -dit --name m3 --hostname m3 --network ubuntu_network ubuntu:22.04 bash

echo ""
echo "✅ Configuración completada!"
echo ""
echo "📋 Contenedores creados:"
docker ps --filter "network=ubuntu_network" --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"

echo ""
echo "🌐 Red creada:"
docker network inspect ubuntu_network --format "Nombre: {{.Name}} | Driver: {{.Driver}} | Subnet: {{range .IPAM.Config}}{{.Subnet}}{{end}}"

echo ""
echo "💡 Para acceder a un contenedor usa:"
echo "   docker exec -it m1 bash"
echo "   docker exec -it m2 bash"
echo "   docker exec -it m3 bash"
