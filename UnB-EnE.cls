\NeedsTeXFormat{LaTeX2e}[1994/12/01]
\ProvidesClass{UnB-EnE}[2014/07/10 Classe para trabalhos do Departamento de Eng. El. FT/UnB]

%% ------------------------------------------------------------------------------------------
%% -- Contextualização do departamento 
%% ------------------------------------------------------------------------------------------
\def\@departamento{Departamento de Engenharia El\'etrica}
\def\@faculdade{Faculdade de Tecnologia}
\def\@universidade{Universidade de Bras\'ilia}
\def\@siglauni{UnB}
\def\@cidade{Bras\'ilia}
\def\@uf{DF}
\def\@cidadeuf{\@cidade--\@uf}
\def\@pais{Brasil}

%% ------------------------------------------------------------------------------------------
%% -- Definição de opções 
%% ------------------------------------------------------------------------------------------
\RequirePackage{xkeyval}

% -- Espaçamento de linhas
\newif\if@singlespacing
\newif\if@onehalfspacing
\newif\if@baselineskip
\DeclareOptionX{singlespacing}{\@singlespacingtrue \@onehalfspacingfalse}%
\DeclareOptionX{onehalfspacing}{\@onehalfspacingtrue \@singlespacingfalse}%
\DeclareOptionX{doublespacing}{\@singlespacingfalse \@onehalfspacingfalse}%
\DeclareOptionX{baselineskip}{\@baselineskiptrue}%

% -- Opções de curso/programa
\newif\if@posgraduacao\@posgraduacaofalse%
\DeclareOptionX{eletrica}{%
    \gdef\@nomecurso{Bacharelado em Engenharia El\'etrica}%
    \gdef\@mododeescrita{Monografia}%
}%

\DeclareOptionX{redes}{%
    \gdef\@nomecurso{Bacharelado em Engenharia de Redes de Comunica\c{c}\~oes}%
    \gdef\@mododeescrita{Monografia}%
}%

\DeclareOptionX{mecatronica}{%
    \gdef\@nomecurso{Bacharelado em Engenharia Mecatr\^onica}%
    \gdef\@mododeescrita{Monografia}%
}%

\DeclareOptionX{computacao}{%
    \gdef\@nomecurso{Bacharelado em Engenharia de Computa\c{c}\~ao}%
    \gdef\@mododeescrita{Monografia}%
}%

\def\@nomecurso{\@empty}%
\def\@assunto{Monografia (\@ifundefined{XeTeXversion}{Gradua\c{c}\~ao}{Graduação})}
\DeclareOptionX{mestrado}{
	\@posgraduacaotrue%
    \gdef\@nomecurso{Mestrado}%
    \gdef\@assunto{Disserta\c{c}\~ao (Mestrado)}%
    \gdef\@mododeescrita{Disserta\c{c}\~ao}%
}%

\newif\if@doutorado\@doutoradofalse%
\DeclareOptionX{doutorado}{%
	\@posgraduacaotrue
	\@doutoradotrue%
    \gdef\@nomecurso{Doutorado}%
    \gdef\@assunto{Tese de Doutorado}%
    \gdef\@mododeescrita{Tese}
}%

\DeclareOptionX{ppgee}{%
	\gdef\@nomeDoPrograma{Engenharia El\'etrica}%
}%

\DeclareOptionX{pgea}{%
	\gdef\@nomeDoPrograma{Engenharia de Sistemas Eletr\^onicos e de Automa\c{c}\~ao}%
}%

\newif\if@ppee\@ppeefalse%
\DeclareOptionX{ppee}{%
	\@ppeetrue%
	\gdef\@nomeDoPrograma{Engenharia El\'etrica}%
	\gdef\@nomecurso{Mestrado Profissional}%
}%

\newif\if@qualificacao\@qualificacaofalse%
\DeclareOptionX{qualificacao}{\@qualificacaotrue}%

% -- Modo de geração do PDF
\newif\if@ForScreenView%
\newif\if@LoadHyperref%
\DeclareOptionX{impressao}{\@ForScreenViewfalse\@LoadHyperreffalse}%
\DeclareOptionX{hyperref}[load]{\@ForScreenViewtrue%
	\def\@tempa{#1}\def\@tempb{load}\def\@tempc{config}%
	\ifx\@tempa\@tempb\@LoadHyperreftrue%
	\else%
		\ifx\@tempa\@tempc\@LoadHyperreffalse%
		\else%
			\ClassError{UnB-EnE}%
				{Valor invalido para opcao hyperref: #1}%
				{Valores validos: hyperref,hyperref=load,hyperref=config}%
		\fi%
	\fi%
}%

% -- Fontes
\def\fontelogo{\@ifundefined{XeTeXversion}{ua1}{Arial}}%
\DeclareOptionX{10pt}{\gdef\@fontsize{10pt}}%
\DeclareOptionX{11pt}{\gdef\@fontsize{11pt}}%
\DeclareOptionX{12pt}{\gdef\@fontsize{12pt}}%

% -- Estilos das páginas
\DeclareOptionX{prestyle}{\gdef\style@pretextual{#1}}
\DeclareOptionX{textstyle}{\gdef\style@textual{#1}}
\DeclareOptionX{chapstyle}{\gdef\style@chapter{#1}}

% -- Modo rascunho (draft)
\newif\if@draftthesis
\DeclareOptionX{draft}{\@draftthesistrue}

%% ------------------------------------------------------------------------------------------
%% -- Processamento de opções e classe-base 
%% ------------------------------------------------------------------------------------------

% -- Repassa opções desconhecidas
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{report}}

% -- Opções default
\ExecuteOptionsX{onehalfspacing,hyperref,prestyle=plain,textstyle=plain,chapstyle=plain}
\ProcessOptionsX\relax

\newcommand{\ifhyperref}[2]{\if@ForScreenView #1\else #2\fi}

% -- Define a seguinte macro apenas se estiver indefinida
\def\@defifundef#1#2{
	\begingroup\expandafter
		\ifx\csname #1\endcsname\relax%
			\expandafter\gdef\csname #1\endcsname{#2}%
		\fi
	\endgroup
}%

\if@draftthesis%
	\PassOptionsToPackage{headheight=13pt,margin={2cm,1.5cm}}{geometry}%
    \@singlespacingfalse \@onehalfspacingtrue % força onehalfspacing
    \@defifundef{@fontsize}{11pt}%
\else%
	\PassOptionsToPackage{headheight=15pt,vmargin={3cm,2cm}}{geometry}%
	\if@ForScreenView%
		\PassOptionsToPackage{hmargin={2.5cm,2.5cm}}{geometry}%
    \else%
		\PassOptionsToPackage{hmargin={3cm,2cm}}{geometry}%
    \fi%
    \@defifundef{@fontsize}{12pt}
\fi%

\LoadClass[\@fontsize]{report}

%% ------------------------------------------------------------------------------------------
%% -- Carrega pacotes requeridos 
%% ------------------------------------------------------------------------------------------
\RequirePackage[brazil,american]{babel}% idiomas
\RequirePackage[fixlanguage]{babelbib}% idioma das referências
\RequirePackage[utf8]{inputenc}% arquivos na codificação UTF-8
\RequirePackage[T1]{fontenc}% habilita busca com caracteres latinos
\RequirePackage{lmodern}% habilita busca com caracteres latinos
\RequirePackage{amsmath}% ambiente para equações
% -- xcolor é necessário para algum pacote não identificado. Relacionado ao AtBeginDocument e 
% \@conteudoPreTextual (se por o comando dentro do begin{document}, funciona)
\RequirePackage{xcolor}
\RequirePackage[figure,table]{totalcount}%

\@ifundefined{XeTeXversion}{%
	\PassOptionsToPackage{pdftex}{hyperref}%
	\RequirePackage{fixltx2e} % resolve defeitos do LaTeX
	\RequirePackage{relsize} % utilizada no \@logo
	\def\@textscale#1#2{\textscale{#1}{#2}}%
}{%
	\PassOptionsToPackage{xetex}{hyperref}%
	\def\@textscale#1#2{{\addfontfeatures{Scale=#1}#2}}%
}%

% -- TODO: substituir a instrução fixa pro parâmetro
\RequirePackage{graphicx}\graphicspath{{.}{img/}}%
\RequirePackage{boites}%
\RequirePackage[a4paper,includefoot]{geometry}%

% define o espaçamento pelo setspace
\if@baselineskip\else%
	\RequirePackage{setspace}%
\fi%

\PassOptionsToPackage{pdfdisplaydoctitle=true,pagebackref,linktocpage=true}{hyperref}%

\if@LoadHyperref%
	\RequirePackage[hidelinks]{hyperref}%
\fi%

\usepackage[acronym,nonumberlist]{glossaries}% carregar após o hyperref!
\makeglossaries%

\usepackage[tocindentauto]{tocstyle}% indentação de anexos na TOC
\usetocstyle{standard}%

% -- Para gerar o label {TotPaginas}
\RequirePackage{atbegshi}%
\newcounter{TotPaginas}%

%% ------------------------------------------------------------------------------------------
%% -- Adaptação da classe-base 
%% ------------------------------------------------------------------------------------------
\newcommand{\chapterformat}{% formatação de título de capítulos
	\Huge\bfseries%
}%

\newcommand{\chapteralign}{% alinhamento de título de capítulos
	\ClassError{UnB-EnE}
		{Comando \protect\pretextual\space nao foi chamado}
		{Nao pode haver titulos antes do comando \protect\pretextual}
}

%suporte para alinhamento e formatação configurável
\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \chapteralign \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \huge\bfseries \@chapapp\space \thechapter
        \par\nobreak
        \vskip 20\p@
    \fi
    \interlinepenalty\@M
    \chapterformat #1\par\nobreak
    \vskip 40\p@
  }}

\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \chapteralign
    \normalfont
    \interlinepenalty\@M
    \chapterformat  #1\par\nobreak
    \vskip 40\p@
  }}

%tira \MakeUppercase forçado nos cabeçalhos
\let\old@MakeUppercase\MakeUppercase
\let\old@markboth\markboth
\def\markboth#1#2{\def\MakeUppercase##1{##1}\old@markboth{#1}{#2}\let\MakeUppercase\old@MakeUppercase}
\let\old@markright\markright
\def\markright#1{\def\MakeUppercase##1{##1}\old@markright{#1}\let\MakeUppercase\old@MakeUppercase}

%evita órfãs/viúvas e quebras de nota de rodapé
\clubpenalty=9999
\widowpenalty=9999
\interfootnotelinepenalty=5000
\raggedbottom

%aproxima itens de lista
\def\changeitemsep{\setlength{\itemsep}{.5\itemsep}}
\let\old@enumerate=\enumerate
\def\enumerate{\old@enumerate%
\changeitemsep}
\let\old@itemize=\itemize
\def\itemize{\old@itemize%
\changeitemsep}

%espaçamento entre linhas de verse, quote e quotation
%deve ser simples e com fonte menor
\let\old@quote\quote
\let\old@endquote\endquote
\renewenvironment*{quote}
	{\old@quote\begin{singlespace}\small}
	{\end{singlespace}\old@endquote}

\let\old@quotation\quotation
\let\old@endquotation\endquotation
\renewenvironment*{quotation}
	{\old@quotation\begin{singlespace}\small}
	{\end{singlespace}\old@endquotation}

\let\old@verse\verse
\let\old@endverse\endverse
\renewenvironment*{verse}
	{\old@verse\begin{singlespace}\small}
	{\end{singlespace}\old@endverse}

%novo ambiente definition
\newcommand{\definitioname}{Defini\c{c}\~ao}
\newcounter{definition}
\newenvironment{definition}
	{\refstepcounter{definition}%
	\let\old@fboxsep\fboxsep\setlength{\fboxsep}{1em}%
	\vskip.5\fboxsep\breakbox%
	\noindent\textbf{\definitioname~\arabic{definition}\ \ }}
	{\endbreakbox\vskip.5\fboxsep%
	\setlength{\fboxsep}{\old@fboxsep}}


%table figures automáticas no ambiente #1
\newcommand{\SetTableFigures}[1]{
	\expandafter\let\csname old@#1\expandafter\endcsname\csname #1\endcsname
	\expandafter\let\csname old@end#1\expandafter\endcsname\csname end#1\endcsname
	\renewenvironment{#1}
	{\begingroup\@tablefigures\csname old@#1\endcsname}
	{\csname old@end#1\endcsname\endgroup}
}

%adiciona item ao sumario
\def\addtocchapter#1{
	\cleardoublepage
	\phantomsection %ajusta referencia hyperref
	\addcontentsline{toc}{chapter}{#1}
}

%configura a seção de referências
\expandafter\let\expandafter\@bibliography\csname bibliography\endcsname%
\renewcommand{\bibliography}[1]{%
	%renomeia a seção após influência maligna do Babel
	\renewcommand*{\bibname}
		{\@ifundefined{XeTeXversion}{Refer\^encias}{Referências}}
	\addtocchapter{\bibname}
	\singlespacing\@bibliography{#1}\defaultspacing}

%maketitle para gerar as páginas iniciais
\def\maketitle{%
	\if@ForScreenView\relax\else\capa\fi
	\pretextual\folharosto%
    \if@posgraduacao%
		\if@qualificacao%
		\else%
			\newpage\thispagestyle{empty}%
			\begin{picture}(0,0)\put(-90,-747){\includegraphics{doc/BDM.pdf}}\end{picture}%
			% \includepdf (comando adequado neste caso) precisa ser reconfigurado em modo pretextual, \includegraphics é uma solução rápida, mas ara isso usa valores arbitrários para posicionar a página.
			\clearpage%
		\fi%
	\fi%
	\newpage\folhaaprovacao%
}

%suporte hyperref para anexos
\ifhyperref{%
	\def\Hy@annexstring{annex}
	\let\HyOrg@anexos\anexos
	\def\anexos{%
		\gdef\theHchapter{\Roman{chapter}}%
		\xdef\Hy@chapapp{\Hy@annexstring}%
		\HyOrg@anexos
	}
}{}

%%
%% --- Macros/comandos auxiliares ---
%%
%%
%% --- Macros/comandos auxiliares ---
%%
\def\prof{\@ifnextchar[{\@prof@}{\@prof}}
\def\@prof#1{Prof.\ #1}
\def\@prof@[#1]#2{Prof.a\ #2}

\def\dr{\@ifnextchar[{\@dr@}{\@dr}}
\def\@dr#1{Dr.\ #1}
\def\@dr@[#1]#2{Dr.a\ #2}

%%

%%
%% --- Páginas do trabalho ---
%%

\def\@lskipoffset#1{%quebra linha segundo referencia
	\begingroup%
		\newskip\len@lskipoffset%referência de espaçamento
		\setlength{\len@lskipoffset}{-.275\len@uadesch}%
		\addtolength{\len@lskipoffset}{#1\len@uacaph}%
		\\[\len@lskipoffset]%
	\endgroup%
}
\newcommand*{\@logosize}{20}%tamanho da fonte utilizada (em pt)
\newcommand{\@logo}[1][positivo_cor]{%imprime o logo da UnB
	\begingroup%
		\newskip\len@brasiliaw%largura da palavra Brasilia
		\newskip\len@uadesch%URW Arial descender height
		\newskip\len@uacaph%URW Arial cap height
		%
		\begin{spacing}{0}%tira espaço entre linhas
        \@ifundefined{XeTeXversion}
	{\fontfamily{\fontelogo}}%
			{\fontspec{\fontelogo}}%
		\fontsize{\@logosize}{0}\bfseries\selectfont%
		\settodepth{\len@uadesch}{jgpy}\settoheight{\len@uacaph}{B}%desc & cap heights
		\settowidth{\len@brasiliaw}{Bras\'ilia}%
		\addtolength{\len@brasiliaw}{-.105em}%ajusta pequeno espaço em branco antes do B desta fonte
		\includegraphics[width=\len@brasiliaw]{#1}\\[.63\len@uacaph]%logo com a largura da palavra Brasilia
		\@universidade\@lskipoffset{.5}%
		\@textscale{.5}{\@faculdade}\@lskipoffset{.25}%
		\@textscale{.5}{\@departamento}%
		\end{spacing}%
	\endgroup
}

\newcommand\pretextual{%
	\renewcommand{\chapteralign}{\centering}
    \renewcommand{\chapterformat}{\Huge \bfseries \thispagestyle{\style@pretextual}}
	\cleardoublepage\pagenumbering{roman}
	\@pagestyle{\style@pretextual}
	\AtBeginShipout{\stepcounter{TotPaginas}}
}

\newcommand\textual{%
	\renewcommand{\chapteralign}{\raggedright}
    \renewcommand{\chapterformat}{\Huge \bfseries \thispagestyle{\style@chapter}}
	\cleardoublepage\pagenumbering{arabic}
	\@pagestyle{\style@textual}
}

\newcommand\postextual{%
	\renewcommand{\chapteralign}{\centering}

	%lining figures em section e subsection
	\renewcommand\thesection{\thechapter.\protect\textlinf{\arabic{section}}}
	\renewcommand\thesubsection{\thesection.\protect\textlinf{\arabic{subsection}}}
	\renewcommand\thesubsubsection{\thesubsection.\protect\textlinf{\arabic{subsubsection}}}

	%evita problema com bookmarksnumbered=true
	\pdfstringdefDisableCommands{\renewcommand*{\textlinf}[1]{##1}}
}

%definição do diretório para os fontes
\newcommand{\texpath}[1]{%
	\ifx&#1&%
		\gdef\@texpath{#1}%
	\else
		\gdef\@texpath{exemplos/tex}%
	\fi
}

%definição titulo e subtitulo do trabalho
\renewcommand*{\title}{\@dblarg\set@title}%
\newcommand*{\set@title}[2][]{%
	\xdef\@title{#1}
	\xdef\@maintitle{#2}
}
\newcommand*{\subtitle}{\@dblarg\set@subtitle}
\newcommand*{\set@subtitle}[2][]{%
	\gdef\@subtitle{#2}
	\xdef\@title{\expandafter{\@title}: #1}
}

%definicao de  palavras-chave - para cip e resumo/abstract
\newcommand*{\keywords}{\@dblarg\set@keywords}
\newcommand*{\set@keywords}[2][]{%
	\gdef\@keywords{#1}
	\gdef\@@keywords{#2}
}
\newcommand*{\palavraschave}{\@dblarg\set@palavraschave}
\newcommand*{\set@palavraschave}[2][]{%
	\gdef\@palavraschave{#1}
	\gdef\@@palavraschave{#2}
}

%data do trabalho
\def\diamesano#1#2#3{\def\@dia{#1}%
                     \def\@mes{#2}%
                     \def\@ano{#3}}

%definicao do autor
\newcommand{\autor}[2]{
	\def\primeiroautor{#1\ #2}% Único autor em ordem Prenome Nome
	\def\primeiroautorinv{#2,\ #1}% Único autor em ordem Nome, Prenome
	\author{\primeiroautor}
}

%definicao do coautor
\newcommand{\coautor}[2]{
	\if@posgraduacao
		\ClassError{UnB-EnE}
			{Comando \protect\coautor\space invalido para mestrado}
			{Apenas trabalhos de graduacao podem ter mais de um autor}
	\fi
	\@ifundefined{primeiroautor}{
		\ClassError{UnB-EnE}
			{Comando \protect\autor\space deve ser chamado antes de \protect\coautor\space}
			{O autor principal deve ser definido antes do secundario}
	}{}
	\def\segundoautor{#1\ #2}% Autor secundário em ordem Prenome Nome
	\def\segundoautorinv{#2,\ #1}% Autor secundário em ordem Nome, Prenome
	\author{\primeiroautor\\ \segundoautor}
}

%definicao do coordenador do curso
\def\coordenador{\@ifnextchar[%]
              {\at@coorda}%Se primeiro argumento opcional chama esta
              {\at@coordo}}%senão chama esta rotina

\def\at@coorda[#1]#2#3{\def\@sexocoordenador{Coordenadora}%
                        \def\@nomecoordenador{#2}%
                        \def\@filicoordenador{#3}}

\def\at@coordo#1#2{\def\@sexocoordenador{Coordenador}%
                        \def\@nomecoordenador{#1}%
                        \def\@filicoordenador{#2}}

%definicao do orientador
\def\orientador{\@ifnextchar[%]
              {\at@orienta}%Se primeiro argumento opcional chama esta
              {\at@oriento}}%senao chama esta rotina

\def\at@orienta[#1]#2#3{\def\@sexoorientador{Orientadora}%
                        \def\@nomeorientador{#2}%
                        \def\@filiorientador{#3}}

\def\at@oriento#1#2{\def\@sexoorientador{Orientador}%
                        \def\@nomeorientador{#1}%
                        \def\@filiorientador{#2}}

%definicao do coorientador
\newif\if@coorientador
\def\coorientador{\@coorientadortrue \@ifnextchar[%]
              {\at@coorienta}%Se primeiro argumento opcional chama esta
              {\at@cooriento}}%senao chama esta rotina

\def\at@coorienta[#1]#2#3{\def\@sexocoorientador{Coorientadora}%
                        \def\@nomecoorientador{#2}%
                        \def\@filicoorientador{#3}}%

\def\at@cooriento#1#2{\def\@sexocoorientador{Coorientador}%
                        \def\@nomecoorientador{#1}%
                        \def\@filicoorientador{#2}}%

% definicao da banca
% o orientador é sempre o primeiro membro da banca
% o coorientador, se existir, é o segundo membro da banca
% o quarto membro é opcional
\newif\if@quartomembro
\def\@defsegundomembro#1#2{\def\@nomedois{#1}\def\@filidois{#2}}
\def\@defterceiromembro#1#2{\def\@nometres{#1}\def\@filitres{#2}}
\def\@defquartomembro#1#2{\def\@nomequatro{#1}\def\@filiquatro{#2}\@quartomembrotrue}

% Se for doutorado, há um quinto membro
\newif\if@quintomembro\@quintomembrofalse%
\if@doutorado%
	\def\@defquintomembro#1#2{\def\@nomecinco{#1}\def\@filicinco{#2}}%
\fi%

\def\membrobanca#1#2{
	\ifx\@nomedois\undefined
		\@defsegundomembro{#1}{#2}
	\else
		\ifx\@nometres\undefined
			\@defterceiromembro{#1}{#2}
		\else
			\ifx\@nomequatro\undefined
				\@defquartomembro{#1}{#2}
			\else
                \if@doutorado%
                    \if@quintomembro%
                        \ClassError{UnB-EnE}%
                            {A banca deve ter no maximo 5 membros}%
                            {Lembre-se que orientador e coorientador ja fazem parte da banca}%
                    \else
                        \@defquintomembro{#1}{#2}%
                        \@quintomembrotrue%
                    \fi%
                \else%
                    \ClassError{UnB-EnE}%
                        {A banca deve ter 3 ou 4 membros}%
                        {Lembre-se que orientador e coorientador ja fazem parte da banca}%
                \fi%
			\fi
		\fi
	\fi
}

\newenvironment{paginatitulo}
	{\cleardoublepage\thispagestyle{empty}}
	{}

\newenvironment{agradecimentos}
	{\begin{paginatitulo}%
	\pdfbookmark{Agradecimentos}{acknowledgements}%
		\chapter*{Agradecimentos}}%
	{\end{paginatitulo}}

\renewenvironment{abstract}
	{\begin{paginatitulo}%
	\begin{otherlanguage*}{english}
	\pdfbookmark{Abstract}{abstract}%
		\chapter*{Abstract}}%
		{\vskip 15pt\noindent\textbf{Keywords:}\ \@@keywords%
	\end{otherlanguage*}
	\end{paginatitulo}}

\newenvironment{resumo}
	{\begin{paginatitulo}%
	\pdfbookmark{Resumo}{resumo}%
	\chapter*{Resumo}}%
		{\vskip 15pt\noindent\textbf{Palavras-chave:}\ \@@palavraschave%
    \end{paginatitulo}}

\newenvironment{dedicatoria}
	{\begin{paginatitulo}%
	\pdfbookmark{Dedicat\'oria}{dedication}%
		\chapter*{Dedicat\'oria}}%
	{\end{paginatitulo}}

\def\@printfulltitle{%
	\@ifundefined{@subtitle}{%
		\textbf{\Large \@title}%
	}{%
		\textbf{\Large\@maintitle\\[1ex]\large\@subtitle}%
	}\par%
}

\newcommand\capa{
  \begin{paginatitulo}%
	\onehalfspacing%
        \begin{center}%
             \@logo[contorno_preto]
             \null\vfill%
             \@printfulltitle%
             \vfill%
             {\large \@author}%
             \vfill%
            {\large \@cidade}\\
            {\large \@ano}%
       \end{center}%
	\defaultspacing%
  \end{paginatitulo}%
}

\newcommand\folharosto{%
	\begin{paginatitulo}%
		\onehalfspacing%
		\begin{center}%
			\@logo\vfill%
			\@printfulltitle\vfill%
			{\large\@author}\vfill%
			\@mododeescrita\ %
			\if@posgraduacao%
				\if@ppee%
					apresentada como requisito parcial para %
					\if@qualificacao{qualificação}\else{conclus\~ao}\fi~do\\%
				\else%
					apresentada como requisito parcial para\\
					\if@qualificacao{qualificação}\else{conclus\~ao}\fi~do %
				\fi%
				\@nomecurso\ em \@nomeDoPrograma%
			\else%
				apresentada como requisito parcial\\
				para conclus\~ao do \@nomecurso%
			\fi%
			\vfill%
			\@sexoorientador\\\@nomeorientador\\%
			\if@coorientador
				\vskip 1cm\@sexocoorientador\\\@nomecoorientador
			\fi
			\vfill%
			{\large\@cidade}\\
			{\large\@ano}%
		\end{center}%
		\defaultspacing%
	\end{paginatitulo}%
}

\newcommand\folhaaprovacao{%
	\begin{paginatitulo}%
		\onehalfspacing%
		\begin{center}%
			\@logo\vfill%
			\@printfulltitle\vfill%
			{\large\@author}\vfill%
			\@mododeescrita\ %
			\if@posgraduacao%
				\if@ppee%
					apresentada como requisito parcial para %
					\if@qualificacao{qualificação}\else{conclus\~ao}\fi~do\\%
				\else%
					apresentada como requisito parcial para\\
					\if@qualificacao{qualificação}\else{conclus\~ao}\fi~do %
				\fi%
				\@nomecurso\ em \@nomeDoPrograma%
			\else%
				apresentada como requisito parcial\\
				para conclus\~ao do \@nomecurso%
			\fi%
			\vfill%
			\@nomeorientador\ (\@sexoorientador)\\
			\@filiorientador\\[1cm]
			\if@quintomembro%
				\begin{tabular}{cc}
					\@nomedois & \@nometres\\
					\@filidois & \@filitres\\[1cm]%
					\@nomequatro & \@nomecinco\\%
					\@filiquatro & \@filicinco%
				\end{tabular}\\[1cm]
			\else%
				\begin{tabular}{cc}
					\@nomedois & \@nometres\\
					\@filidois & \@filitres%
				\end{tabular}\\[1cm]
				\if@quartomembro%
					\@nomequatro\\%
					\@filiquatro\\[1cm]
				\fi%
			\fi%
			\@nomecoordenador\\
			\@sexocoordenador \ do\ %
			\if@posgraduacao Programa de P\'{o}s-gradua\c{c}\~{a}o em \@nomeDoPrograma\else \@nomecurso\fi%
			\vfill%
			{\large \@cidade, \@dia\ de \@mes\ de \@ano}
		\end{center}%
		\defaultspacing%
	\end{paginatitulo}%
}

%%
%% --- Processamento de final e início do documento ---
%%
\AtEndDocument{%
	\if@PosTextualNaoIncluso\@conteudoPosTextual\fi%

	\addtocounter{page}{-1}%decrementa para depois . . .
    \ifhyperref{%
		\immediate\write\@mainaux{%
			\string\newlabel{TotPaginas}{{\arabic{TotPaginas}}{\thepage}{}{page.\thepage}{}}%
		}%
	}{%
		\immediate\write\@mainaux{%
			\string\newlabel{TotPaginas}{{\arabic{TotPaginas}}{\thepage}}%
		}%
	}
	\addtocounter{page}{1}% . . . incrementar de novo
}

\AtBeginDocument{%
	%define propriedades do PDF e carrega pacotes auxiliares
	\@ifpackageloaded{hyperref}{
	\hypersetup{
            pdftitle=\@title,
            pdfauthor=\@author,
            pdfsubject=\@assunto,
            pdfkeywords=\@palavraschave}
		\@ifpackageloaded{natbib}{
			%compatibilidade entre natbib e hyperref
		\RequirePackage{hypernat}
		}{}
		%posiciona melhor os links para captions
        \RequirePackage[all]{hypcap}
	}{
		\RequirePackage{nohyperref} %dummy macros for hyperref
		\RequirePackage{url} %permite quebra de linha em URLs
	}

	%controle do sumario de acordo com o estilo atual,
	%após hyperref carregado porque ele sobrescreve
	%o comando \addcontentsline
	\let\@addcontentsline\addcontentsline
	\def\@emptystr{empty}
	\def\@pagestyle#1{
		\let\@styletoset=#1%
		\pagestyle{\@styletoset}%
		%se estilo for empty, não adiciona ao TOC
		\ifx\@styletoset\@emptystr
			\renewcommand\addcontentsline[3]{\relax}
		\else
			\let\addcontentsline\@addcontentsline
		\fi
	}

	%traducoes para glossaries.sty
	\@ifpackageloaded{glossaries}{%
		\@ifundefined{XeTeXversion}{
			\addto\captionsbrazil{%
			\renewcommand*{\glossaryname}{Gloss\'ario}%
			\renewcommand*{\acronymname}{Lista de Abreviaturas e Siglas}%
			\renewcommand*{\entryname}{Entrada}%
			\renewcommand*{\descriptionname}{Descri\c{c}\~ao}%
			\renewcommand*{\symbolname}{S\'\imbolo}%
			\renewcommand*{\pagelistname}{Lista de p\'aginas}%
			\renewcommand*{\glssymbolsgroupname}{S\'imbolos}%
			\renewcommand*{\glsnumbersgroupname}{N\'umeros}}
		}{
			\addto\captionsbrazil{%
			\renewcommand*{\glossaryname}{Glossário}%
			\renewcommand*{\acronymname}{Lista de Abreviaturas e Siglas}%
			\renewcommand*{\entryname}{Entrada}%
			\renewcommand*{\descriptionname}{Descrição}%
			\renewcommand*{\symbolname}{Símbolo}%
			\renewcommand*{\pagelistname}{Lista de páginas}%
			\renewcommand*{\glssymbolsgroupname}{Símbolos}%
			\renewcommand*{\glsnumbersgroupname}{Números}}
		}
	}{}

	\@ifundefined{XeTeXversion}%
	{%suporte para fonte Adobe Minion Pro - pacote LaTeX
		\@ifpackageloaded{MinionPro}{}{%
			\newcommand{\figureversion}[1]{\relax}
		}
		\newenvironment{linfig}{\figureversion{lining}}{\figureversion{text}}%
		\newenvironment{tabfig}{\figureversion{tabular}}{\figureversion{proportional}}%
		\newcommand*{\textlinf}[1]{\figureversion{lining}#1\figureversion{text}}%
		\newcommand*{\texttabf}[1]{\figureversion{tabular}#1\figureversion{proportional}}%
		\newcommand*{\@tablefigures}{\figureversion{lining,tabular}}%
	}%
	{%suporte fontspec - XeTeX
 		\def\@textlinf{\protect\addfontfeatures{Numbers=Lining}}%
 		\def\@texttabf{\protect\addfontfeatures{Numbers=Monospaced}}%
		\newenvironment{linfig}{\bgroup\@textlinf}{\egroup}%
		\newenvironment{tabfig}{\bgroup\@texttabf}{\egroup}%
		\newcommand*{\textlinf}[1]{{\@textlinf #1}}%
		\newcommand*{\texttabf}[1]{{\@texttabf #1}}%
		\newcommand*{\@tablefigures}{\addfontfeature{Numbers={Lining,Monospaced}}}%
		\newcommand*{\slashedzero}{{\addfontfeature{Numbers={Lining,SlashedZero}}0}}%
	}%

	\if@baselineskip
		%para manter o valor inicial
		\newdimen\@oldbaseline

		%define o espaçamento pelo baselinekip
		\@oldbaseline=\baselineskip
		\newcommand{\setstretch}[1]{\setlength{\baselineskip}{#1\@oldbaseline}}
		\newcommand{\singlespacing}{\setstretch{1}}
		\newcommand{\onehalfspacing}{\setstretch{1.35}}
		\newcommand{\doublespacing}{\setstretch{1.7}}
	\fi

	\newcommand{\defaultspacing}{%
		\if@singlespacing\singlespacing%single spacing
			\else\if@onehalfspacing\onehalfspacing%one and half spacing
				\else\doublespacing%double spacing
			\fi%
		\fi}
	\defaultspacing% chamada inicial

	% Controle de membros da banca
	\ifx\@nometres\undefined%
        \ClassError{UnB-EnE}%
            {A banca deve ter pelo menos 3 membros}%
            {Lembre-se que orientador e coorientador ja fazem parte da banca}%
    \fi%
    \if@doutorado%
		\if@qualificacao%
		\else%
	        \if@quintomembro%
	        \else%
	            \ClassError{UnB-EnE}%
	                {A banca deve ter 5 membros}%
	                {Lembre-se que orientador e coorientador ja fazem parte da banca}%%
	        \fi%
	    \fi%
    \fi%

	\@conteudoPreTextual%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Novos Comandos %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\unbene}{\texttt{UnB-EnE}}%

\newcommand{\titulo}[1]{\title{#1}}%

\newcommand{\@erroSeNaoExiste}[1]{%
	\IfFileExists{#1}{}%
		{\ClassError{UnB-EnE}%
		{Arquivo "#1" nao encontrado.}
		{O arquivo "#1" eh necessário.}}%
}%

\newcommand{\@inputTeXFile}[1]{%
	\@erroSeNaoExiste{\@texpath/#1}%
	\input{\@texpath/#1}%
}%
\newcommand{\@IncluirSecao}[1]{%
	\begin{#1}%
		\@inputTeXFile{#1}%
	\end{#1}%
}%

\newcommand{\capitulo}[2]{%
	\chapter{#2}%
	\label{#1}%
	\@inputTeXFile{#1}%
}%

\newif\if@PosTextualNaoIncluso%
\@PosTextualNaoInclusotrue%

\newcounter{apendice}\setcounter{apendice}{0}%
\newcommand{\apendice}[2]{%
	\addtocounter{apendice}{1}%
	\ifnum\value{apendice}<2%
		\if@PosTextualNaoIncluso\@conteudoPosTextual\fi%
	    \appendix%
	    \addcontentsline{toc}{chapter}{\appendixname}%
	\fi%
	\capitulo{#1}{#2}%
}%

\newcounter{anexo}\setcounter{anexo}{0}%
\newcommand{\anexo}[2]{%
	\addtocounter{anexo}{1}%
	\ifnum\value{anexo}<2%
		\if@PosTextualNaoIncluso\@conteudoPosTextual\fi%
		\renewcommand{\appendixname}{Anexo}%
		\ifnum\value{apendice}<1\appendix\fi%
		\renewcommand{\thechapter}{\Roman{anexo}}%
	    \addcontentsline{toc}{chapter}{\appendixname}%
	\fi%
	\capitulo{#1}{#2}%
}%

\newcommand{\@listofacronyms}{%
	\@inputTeXFile{siglas}%
	\printglossary[type=\acronymtype]%
}%

\newcommand{\@conteudoPreTextual}{%
	\maketitle%
	\if@qualificacao\else%
		\@IncluirSecao{dedicatoria}%
		\@IncluirSecao{agradecimentos}%
	\fi%
	\@IncluirSecao{resumo}%
	\selectlanguage{american}%
	\@IncluirSecao{abstract}%
	\selectlanguage{brazil}%
    \selectbiblanguage{brazil}%
	\@erroSeNaoExiste{exemplos/bibliografia.bib}%

	\tableofcontents%
	\iftotalfigures\listoffigures\fi%
	\iftotaltables\listoftables\fi%
	\@listofacronyms%

	\textual%
}%

\newcommand{\@conteudoPosTextual}{%
	\@PosTextualNaoInclusofalse%
    \postextual%
	\bibliographystyle{babunsrt}%
    \bibliography{bibliografia}%
}%


\newcommand{\sigla}[2]{\newacronym{#1}{#1}{#2}}%

\newcommand{\@referencia}[2]{#1~\ref{#2}}%
\newcommand{\refCap}[1]{\@referencia{Capítulo}{#1}}%
\newcommand{\refCaps}[2]{\@referencia{Capítulos}{#1}\ a \ref{#2}}%
\newcommand{\refFig}[1]{\@referencia{Figura}{#1}}%
\newcommand{\refFigs}[2]{\@referencia{Figuras}{#1}\ a \ref{#2}}%
\newcommand{\refEq}[1]{\@referencia{Equação}{#1}}%
\newcommand{\refEqs}[2]{\@referencia{Equações}{#1}\ a \ref{#2}}%
\newcommand{\refTab}[1]{\@referencia{Tabela}{#1}}%
\newcommand{\refTabs}[2]{\@referencia{Tabelas}{#1}\ a \ref{#2}}%
\newcommand{\refApendice}[1]{\@referencia{Apêndice}{#1}}%
\newcommand{\refAnexo}[1]{\@referencia{Anexo}{#1}}%

\newcommand{\figuraBib}[6][!ht]{%
	\begin{figure}[#1]%
		\begin{center}%
			\includegraphics[#6]{#2}%
			\caption[#3.]{#3\ifx#4\empty\else~(Fonte: ~\cite{#4})\fi.\label{#5}}%
		\end{center}%
	\end{figure}%
}%
\newcommand{\figura}[5][!ht]{%
	\figuraBib[#1]{#2}{#3}{}{#4}{#5}%
}%

\newcommand{\equacao}[2]{%
	\begin{equation}%
		\label{#1}%
		\begin{gathered}%
			#2
		\end{gathered}%
	\end{equation}%
}%

\newcommand{\tabelaBib}[5]{%
	\begin{table}%
		\centering%
		\caption[#1.]{#1\ifx#2\empty\else~(Fonte: ~\cite{#2})\fi.\label{#3}}%
		\begin{tabular}{#4}%
			#5
		\end{tabular}%
	\end{table}%
}%

\newcommand{\tabela}[4]{%
	\tabelaBib{#1}{}{#2}{#3}{#4}%
}%


\endinput
