set number
set ai
set laststatus=2
set cursorline
set cmdheight=2
set wildignorecase
set signcolumn=yes    " 画面左端にサイン列を常に表示
set showtabline=2     " タブ毎に常にタブラインを表示
set tabstop=2         " タブを2文字分にする
set expandtab         " タブの代わりに半角スペースを使用
set shiftwidth=2      " インデントを半角スペース2文字にする
set hlsearch          " 文字列検索のハイライト
set ignorecase        " 文字列検索で大文字・小文字を区別しない
set smartcase         " 文字列検索で大文字を含んでいたらignorecaseを上書きし、大文字・小文字を区別する
set incsearch         " インクリメンタルサーチ
set noswapfile        " スワップファイル(.swp)を生成しない
set nobackup          " バックアップファイル(~)を生成しない
set noundofile        " undoファイル(.un~)を生成しない
set encoding=utf-8    " Vim内部で使われる文字エンコーディングにutf-8にする
set wildmenu          " コマンドラインでTAB補完時に候補メニューを表示
nmap <silent> <F3> :<C-u>nohlsearch<CR><Esc>
nmap j gj
nmap k gk
nmap <F4> :<c-u>Fern . -drawer -stay -keep -toggle -reveal=%<cr>
inoremap <silent> jj <ESC>
syntax on

augroup signcolumn_bg_none
  autocmd!
  " colorscheme読み込み後、サイン列の背景色をNONEにする ※Windows Terminal側の色を使いたいため
  autocmd VimEnter,ColorScheme * highlight SignColumn guibg=NONE ctermbg=NONE
augroup END

" プラグインの管理(jetpackでの管理)
call jetpack#begin()
  " bootstrap
  Jetpack 'tani/vim-jetpack', { 'opt': 1 }
  Jetpack 'cohama/lexima.vim'
  Jetpack 'vim-jp/vimdoc-ja'
  Jetpack 'itchyny/lightline.vim'
  Jetpack 'leafgarland/typescript-vim'
  Jetpack 'junegunn/fzf.vim'
  Jetpack 'prabirshrestha/vim-lsp'
  Jetpack 'mattn/vim-lsp-settings'
  Jetpack 'prabirshrestha/asyncomplete.vim'
  Jetpack 'prabirshrestha/asyncomplete-lsp.vim'
" ファイル構造をツリー状で表示してくれるやつ
" なんか重いので一旦使用中止
"  Jetpack 'lambdalisue/fern.vim'
"  Jetpack 'lambdalisue/nerdfont.vim'
"  Jetpack 'lambdalisue/fern-renderer-nerdfont.vim'
"  Jetpack 'lambdalisue/fern-git-status.vim'
"  Jetpack 'lambdalisue/glyph-palette.vim'
  Jetpack 'junegunn/fzf', { 'do': {-> fzf#install()} }
" 入力補完()がうざいので使用中止
"  Jetpack 'neoclide/coc.nvim', { 'branch': 'release' }
"  Jetpack 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
  Jetpack 'vlime/vlime', { 'rtp': 'vim' }
  Jetpack 'dracula/vim', { 'as': 'dracula' }
  Jetpack 'tpope/vim-fireplace', { 'for': 'clojure' }
call jetpack#end()

" タブとステータスラインに色を付ける
if !has('gui_running')
  set t_Co=256
endif

" Fernアイコンに色をつける
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END
" Fernアイコンサイズ

let g:fern#default_hidden=1 " 隠しファイルを表示する
let g:fern#renderer = 'nerdfont'
let g:fern#renderer#nerdfont#indent_markers = 1

" lspの設定
let g:lsp_diagnostics_enabled = 1                        " Diagnosticsを有効にする
let g:lsp_diagnostics_echo_cursor = 1                    " カーソル下のエラー、警告、情報、ヒントを画面下部のコマンドラインに表示
let g:lsp_diagnostics_echo_delay = 50                    " Diagnosticsの表示の遅延を50msに設定
let g:lsp_diagnostics_float_cursor = 1                   " カーソル下のエラー、警告、情報、ヒントをフロート表示
let g:lsp_diagnostics_signs_enabled = 1                  " 画面左端のサイン列にエラー、警告、情報、ヒントのアイコンを表示
let g:lsp_diagnostics_signs_delay = 50                   " Diagnosticsのサイン列の表示の遅延を50msに設定
let g:lsp_diagnostics_signs_insert_mode_enabled = 0      " 挿入モード時、Diagnosticsのサイン列を表示しない
let g:lsp_diagnostics_highlights_delay = 50              " Diagnosticsの指摘箇所自体の文字ハイライト表示の遅延を50msに設定
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0 " 挿入モード時、Diagnosticsの指摘箇所自体の文字ハイライトを表示しない
let g:lsp_document_code_action_signs_enabled = 0         " 画面左端のサイン列にコードアクションのアイコン非表示

" asyncomplete.vimの設定を追加
let g:asyncomplete_popup_delay = 100 " 補完メニューを開く際の遅延を100msに設定
imap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
