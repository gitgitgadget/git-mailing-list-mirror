From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 10/17] Add git-ls, a user friendly version of ls-files
 and more
Date: Wed, 26 Mar 2014 16:16:50 -0400
Message-ID: <CAPig+cQfUnJ+pDsJbO8WgPtu2_+U46DD-A5jKSPo33gCu3vFKw@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 21:16:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSuFt-0001qt-Ve
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 21:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141AbaCZUQx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 16:16:53 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:45289 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030AbaCZUQv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 16:16:51 -0400
Received: by mail-yh0-f51.google.com with SMTP id f10so2617073yha.24
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 13:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ZdC6tLgaoFM6gNLhqWecpeYlxh76N1WSPskJvnVdss4=;
        b=joDstYsDSTDS0tl5F8Etn3KIX631l5D3zM7SnCgjHNpy5sD5awBiYRuKKnXKysPDIR
         iV/p1wVyAvHc5C1G4V2cgJmqrw0Iwg3wLuY8h8AP3NQIVzw1ZpJMiD6lSTtvcASeH0K2
         uA5B62KOZSnRsQgaouAfFhPHqcWCdihjhwnD3Kya/wAjhfMxFaS9ub3QEJiCH0USbZDr
         peJwIeur178BCF2diZdARO5atheA68gX9773YVMBDNRII6mw+dA9lr84JF6KAK9JUK67
         kn25VcB7r9D7drzIvNB4obaeFUkr+5koU/qlQz8kY4zSSymxLav/nmKZuhQ820zSGaGW
         VPtw==
X-Received: by 10.236.177.100 with SMTP id c64mr8267056yhm.30.1395865011039;
 Wed, 26 Mar 2014 13:16:51 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 26 Mar 2014 13:16:50 -0700 (PDT)
In-Reply-To: <1395841697-11742-11-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: RkKeWF7WaNc1_s2NeS6TkxRCKq8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245222>

On Wed, Mar 26, 2014 at 9:48 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> This is more user friendly version of ls-files:
>
> * it's automatically colored and columnized
> * it refreshes the index like all porcelain commands
> * it defaults to non-recursive behavior like ls
> * :(glob) is on by default so '*.c' means a.c but not a/b.c, use
>   '**/*.c' for that.
> * auto pager
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  .gitignore                     |  1 +
>  Documentation/config.txt       | 10 ++++++
>  Documentation/git-ls.txt (new) | 82 ++++++++++++++++++++++++++++++++=
++++++++++
>  Makefile                       |  1 +
>  builtin.h                      |  1 +
>  builtin/ls-files.c             | 70 ++++++++++++++++++++++++++++++++=
++++
>  command-list.txt               |  1 +
>  git.c                          |  1 +
>  8 files changed, 167 insertions(+)
>  create mode 100644 Documentation/git-ls.txt
>
> diff --git a/.gitignore b/.gitignore
> index dc600f9..f91af81 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -76,6 +76,7 @@
>  /git-init-db
>  /git-instaweb
>  /git-log
> +/git-ls
>  /git-ls-files
>  /git-ls-remote
>  /git-ls-tree
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 6bca55e..87a6dcf 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -909,6 +909,12 @@ color.status.<slot>::
>         to red). The values of these variables may be specified as in
>         color.branch.<slot>.
>
> +color.ls::
> +       A boolean to enable/disable color in the output of
> +       linkgit:git-ls[1]. May be set to `always`, `false` (or
> +       `never`) or `auto` (or `true`), in which case colors are used
> +       only when the output is to a terminal. Defaults to false.
> +
>  color.ls.<slot>::
>         Use customized color for file name colorization. If not set
>         and the environment variable LS_COLORS is set, color settings
> @@ -981,6 +987,10 @@ column.clean::
>         Specify the layout when list items in `git clean -i`, which a=
lways
>         shows files and directories in columns. See `column.ui` for d=
etails.
>
> +column.ls::
> +       Specify whether to output tag listing in `git ls` in columns.
> +       See `column.ui` for details.
> +
>  column.status::
>         Specify whether to output untracked files in `git status` in =
columns.
>         See `column.ui` for details.
> diff --git a/Documentation/git-ls.txt b/Documentation/git-ls.txt
> new file mode 100644
> index 0000000..67ca522
> --- /dev/null
> +++ b/Documentation/git-ls.txt
> @@ -0,0 +1,82 @@
> +git-ls(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-ls - List files
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git ls' (--[cached|deleted|others|ignored|unmerged|modified])*
> +       (-[c|d|o|i|s|u|m])*

Don't you have [...] and (...) transposed? The way it's written, "-"
and "--" are valid optional arguments. You probably meant:

    [--(cached|deleted|x|y|z)]...
    [-(c|d|x|y|z)]...

> +       [options] [<pathspec>...]

However, you also have the generic [options] here, which covers all of
the above. It probably would make sense to just use [options] and drop
the enumerated list.

> +DESCRIPTION
> +-----------
> +List files (by default in current working directory) that are in the
> +index. Depending on the chosen options, maybe only modified files in
> +working tree are shown, or untracked files...
> +
> +OPTIONS
> +-------
> +-c::
> +--cached::
> +       Show cached files in the output (default)

"in the output" is superfluous. Perhaps drop it from each of the descri=
ptions.

> +-d::
> +--deleted::
> +       Show deleted files in the output

Is this showing only deleted file or including them in the list of
files otherwise displayed? It's not clear from the description. Same
question for the other options.

> +-m::
> +--modified::
> +       Show modified files in the output
> +
> +-o::
> +--others::
> +       Show other (i.e. untracked) files in the output
> +
> +-i::
> +--ignored::
> +       Show only ignored files in the output. When showing files in =
the
> +       index, print only those matched by an exclude pattern. When
> +       showing "other" files, show only those matched by an exclude
> +       pattern.
> +
> +-u::
> +--unmerged::
> +       Show unmerged files in the output (forces --stage)

This is the only mention of --stage in this document. Not sure what
it's trying to say.

> +--color[=3D<when>]::
> +       Color file names. The value must be always (default), never,
> +       or auto.

Same problem mentioned in the other patch. Default is "always"...

> +
> +--no-color::
> +       Turn off coloring, even when the configuration file gives the
> +       default to color output, same as `--color=3Dnever`. This is t=
he
> +       default.

But default is also "never".

> +
> +--column[=3D<options>]::
> +--no-column::
> +       Display files in columns. See configuration variable column.u=
i
> +       for option syntax.`--column` and `--no-column` without option=
s

Missing space after period.

More below.

> +       are equivalent to 'always' and 'never' respectively.
> +
> +--max-depth <depth>::
> +       For each <pathspec> given on command line, descend at most <d=
epth>
> +       levels of directories. A negative value means no limit.
> +       This option is ignored if <pathspec> contains active wildcard=
s.
> +       In other words if "a*" matches a directory named "a*",
> +       "*" is matched literally so --max-depth is still effective.
> +
> +<pathspec>::
> +       Files to show. :(glob) magic is enabled and recursion disable=
d
> +       by default.
> +
> +SEE ALSO
> +--------
> +linkgit:git-ls-files[1]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Makefile b/Makefile
> index f6a6e14..b0bc40a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -584,6 +584,7 @@ BUILT_INS +=3D git-cherry-pick$X
>  BUILT_INS +=3D git-format-patch$X
>  BUILT_INS +=3D git-fsck-objects$X
>  BUILT_INS +=3D git-init$X
> +BUILT_INS +=3D git-ls$X
>  BUILT_INS +=3D git-merge-subtree$X
>  BUILT_INS +=3D git-show$X
>  BUILT_INS +=3D git-stage$X
> diff --git a/builtin.h b/builtin.h
> index c47c110..177aa7d 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -75,6 +75,7 @@ extern int cmd_index_pack(int argc, const char **ar=
gv, const char *prefix);
>  extern int cmd_init_db(int argc, const char **argv, const char *pref=
ix);
>  extern int cmd_log(int argc, const char **argv, const char *prefix);
>  extern int cmd_log_reflog(int argc, const char **argv, const char *p=
refix);
> +extern int cmd_ls(int argc, const char **argv, const char *prefix);
>  extern int cmd_ls_files(int argc, const char **argv, const char *pre=
fix);
>  extern int cmd_ls_tree(int argc, const char **argv, const char *pref=
ix);
>  extern int cmd_ls_remote(int argc, const char **argv, const char *pr=
efix);
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 20ca3f2..74eb3c2 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -33,6 +33,7 @@ static int use_color;
>  static unsigned int colopts;
>  static int max_depth =3D -1;
>  static int show_tag;
> +static int porcelain;
>
>  static const char *prefix;
>  static int max_prefix_len;
> @@ -588,6 +589,10 @@ static int ls_files(const char **argv, const cha=
r *prefix)
>                         die("ls-files --with-tree is incompatible wit=
h -s or -u");
>                 overlay_tree_on_cache(with_tree, max_prefix);
>         }
> +       if (porcelain) {
> +               refresh_index(&the_index, REFRESH_QUIET, &pathspec, N=
ULL, NULL);
> +               setup_pager();
> +       }
>         show_files(&dir);
>         if (show_resolve_undo)
>                 show_ru_info();
> @@ -687,3 +692,68 @@ int cmd_ls_files(int argc, const char **argv, co=
nst char *cmd_prefix)
>                         ls_files_usage, 0);
>         return ls_files(argv, prefix);
>  }
> +
> +static const char * const ls_usage[] =3D {
> +       N_("git ls [options] [<file>...]"),
> +       NULL
> +};
> +
> +static int git_ls_config(const char *var, const char *value, void *c=
b)
> +{
> +       if (starts_with(var, "column."))
> +               return git_column_config(var, value, "ls", &colopts);
> +       if (!strcmp(var, "color.ls")) {
> +               use_color =3D git_config_colorbool(var, value);
> +               return 0;
> +       }
> +       return git_color_default_config(var, value, cb);
> +}
> +
> +int cmd_ls(int argc, const char **argv, const char *cmd_prefix)
> +{
> +       struct option builtin_ls_options[] =3D {
> +               OPT_BOOL('c', "cached", &show_cached,
> +                       N_("show cached files in the output (default)=
")),

Ditto regarding the unnecessary and repetitive "in the output".

> +               OPT_BOOL('d', "deleted", &show_deleted,
> +                       N_("show deleted files in the output")),
> +               OPT_BOOL('m', "modified", &show_modified,
> +                       N_("show modified files in the output")),
> +               OPT_BOOL('o', "others", &show_others,
> +                       N_("show other files in the output")),
> +               OPT_BIT('i', "ignored", &dir.flags,
> +                       N_("show ignored files in the output"),
> +                       DIR_SHOW_IGNORED),
> +               OPT_BOOL('u', "unmerged", &show_unmerged,
> +                       N_("show unmerged files in the output")),
> +               OPT__COLOR(&use_color, N_("show color")),
> +               OPT_COLUMN(0, "column", &colopts, N_("show files in c=
olumns")),
> +               { OPTION_INTEGER, 0, "max-depth", &max_depth, N_("dep=
th"),
> +                       N_("descend at most <depth> levels"), PARSE_O=
PT_NONEG,
> +                       NULL, 1 },
> +               OPT__ABBREV(&abbrev),
> +               OPT_END()
> +       };
> +
> +       if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
> +               usage_with_options(ls_usage, builtin_ls_options);
> +
> +       prefix =3D cmd_prefix;
> +       if (prefix)
> +               prefix_len =3D strlen(prefix);
> +       git_config(git_ls_config, NULL);
> +
> +       if (read_cache() < 0)
> +               die("index file corrupt");
> +
> +       /* default setup */
> +       porcelain =3D 1;
> +       setenv(GIT_GLOB_PATHSPECS_ENVIRONMENT, "1", 1);
> +       exc_given =3D 1;
> +       setup_standard_excludes(&dir);
> +       use_color =3D -1;
> +       max_depth =3D 0;
> +
> +       argc =3D parse_options(argc, argv, prefix, builtin_ls_options=
,
> +                            ls_usage, 0);
> +       return ls_files(argv, prefix);
> +}
> diff --git a/command-list.txt b/command-list.txt
> index cf36c3d..89e5cef 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -64,6 +64,7 @@ git-init                                mainporcela=
in common
>  git-instaweb                            ancillaryinterrogators
>  gitk                                    mainporcelain
>  git-log                                 mainporcelain common
> +git-ls                                  mainporcelain
>  git-ls-files                            plumbinginterrogators
>  git-ls-remote                           plumbinginterrogators
>  git-ls-tree                             plumbinginterrogators
> diff --git a/git.c b/git.c
> index 9efd1a3..682a81e 100644
> --- a/git.c
> +++ b/git.c
> @@ -381,6 +381,7 @@ static struct cmd_struct commands[] =3D {
>         { "init", cmd_init_db },
>         { "init-db", cmd_init_db },
>         { "log", cmd_log, RUN_SETUP },
> +       { "ls", cmd_ls, RUN_SETUP },
>         { "ls-files", cmd_ls_files, RUN_SETUP },
>         { "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
>         { "ls-tree", cmd_ls_tree, RUN_SETUP },
> --
> 1.9.1.345.ga1a145c
