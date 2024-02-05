-- initialize and install lazynvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
})
end

vim.opt.rtp:prepend(lazypath)

-- specify and install plugins
require("lazy").setup({
  {'nvim-telescope/telescope.nvim', 
      tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' } 
  },
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig'},
  {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  },
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},
  {'neoclide/coc.nvim', branch = 'release'},
  {
      'folke/tokyonight.nvim',
      lazy = false,
      priority = 1000,
      opts = {}
  }
})

-- initialize plugins
require('telescope').setup{}
local lsp_zero = require('lsp-zero')

-- color
vim.cmd("colorscheme tokyonight-night")

-- initialize and configure LSP

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('lspconfig').pyright.setup{}

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"


local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        if opts.desc then
            opts.desc = "keymaps.lua: " .. opts.desc
        end
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- remap keys
vim.g.mapleader = " "
map("n", "<leader>q", ":xa<cr>", {})
map("n", "<C-S>", ":w<cr>", {})
map("n", "<C-l>", ":bn<cr>")
map("n", "<C-h>", ":bp<cr>")
map("i", "<C-S>", "<esc>:w<cr>i")
map("n", "<leader>w", ":w<cr>:bw<cr>")
map("n", "<leader>v", ":e ~/.config/nvim/init.lua<cr>")
map("n", "<leader>r", ":e ~/.config/nvim/vimrc.vim<cr>")
map("n", "<leader>s", ":source ~/.config/nvim/init.lua<cr>")
map("n", "<leader>x", ":Sex<cr>")
map("n", "<leader>f", "<cmd>Telescope find_files<cr>")
map("n", "<leader>g", "<cmd>Telescope live_grep<cr>")
map("i", "<TAB>", 'pumvisible() ? "\\<C-n>" : "\\<TAB>"', {expr = true, silent = true})
map("i", "<S-TAB>", 'pumvisible() ? "\\<C-p>" : "\\<C-h>"', {expr = true, silent = true})
