#!/bin/bash

# Load environment variables
set -a
source .env
set +a

# Create directories
mkdir -p certs mysql-init

# Create MySQL init script
cat > mysql-init/init.sql << EOF
CREATE DATABASE IF NOT EXISTS \`${FLEET_MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${FLEET_MYSQL_USERNAME}'@'%' IDENTIFIED BY '${FLEET_MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${FLEET_MYSQL_DATABASE}\`.* TO '${FLEET_MYSQL_USERNAME}'@'%';
FLUSH PRIVILEGES;
EOF

# Start services
docker compose up -d

echo "FleetDM setup completed!"
echo "Access your instance at: https://fleetdm.techchandra.com"
