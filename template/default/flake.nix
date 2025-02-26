{
  description = "Description for the project";

  inputs = {
    flake-modules-core.url = "github:hercules-ci/flake-modules-core";
    flake-modules-core.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, flake-modules-core, ... }:
    (flake-modules-core.lib.evalFlakeModule
      { inherit self; }
      {
        imports = [
          # To import a flake module
          # 1. Add foo to inputs
          # 2. Add foo as a parameter to the outputs function
          # 3. Add here: foo.flakeModule

        ];
        systems = [ "x86_64-linux" "aarch64-darwin" ];
        perSystem = system: { config, self', inputs', pkgs, ... }: {
          # Per-system attributes can be defined here. The self' and inputs'
          # module parameters provide easy access to attributes of the same
          # system.

          # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
          packages.hello = pkgs.hello;
        };
        flake = {
          # The usual flake attributes can be defined here, including system-
          # agnostic ones like nixosModule and system-enumerating ones, although
          # those are more easily expressed in perSystem.

        };
      }
    ).config.flake;
}
