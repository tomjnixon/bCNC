{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "nixpkgs/nixos-24.11";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      python = pkgs.python3;
    in
      rec {
        packages.bCNC = python.pkgs.buildPythonApplication rec {
          name = "bCNC";
          version = "0.9.15-git";

          src = ./.;

          dependencies = [
            python.pkgs.tkinter
            python.pkgs.pyserial
            python.pkgs.numpy
            python.pkgs.svgelements
            python.pkgs.pillow
            python.pkgs.opencv4
            # python.pkgs.shxparser
          ];
        };

        packages.default = packages.bCNC;
      }
    );
}
