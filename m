From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 09/18] Add git-list-files, a user friendly version of ls-files and more
Date: Sun, 30 Mar 2014 20:56:00 +0700
Message-ID: <1396187769-30863-10-git-send-email-pclouds@gmail.com>
References: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
 <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:56:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUGE5-00038W-Cu
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbaC3N4g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 09:56:36 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:38248 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbaC3N4e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:56:34 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so6818547pdj.18
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 06:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uR39qsWIAVtcNXklW2saA+HZD+Ncg17xCAF/NdP3/cU=;
        b=CsbBDZtGwJqYlYMdJT0xPgCNM49+CdOkEzxVPJmuCDu7HnQqTtXC32k5iJU/czNBdd
         qU0EhzBwW5y02AJNFK8ho1chB0JR5U5WCbEoMMaz6zN1GkAEoRijDhlAgLhhK4loHnsV
         Vci0twccKbJOz18g0GxrybHAifvrsEEg+rOShsGVERFMYr6mX8yRHZ7Fd7f4d1DnTB0k
         7rv8tquCoMAyW50iP7zofnTToDGCtwX3OKOvw7sx6aOJevHB6sHk+JBoB9njx85hp1TR
         aW68qqK9W6ayXCUyAj4bgejKwwyq+nRlPifXHXuAAeMaXJH9yXS3QUJW8N1ywKonM4/n
         pygg==
X-Received: by 10.66.163.164 with SMTP id yj4mr19600374pab.91.1396187793762;
        Sun, 30 Mar 2014 06:56:33 -0700 (PDT)
Received: from lanh ([115.73.202.240])
        by mx.google.com with ESMTPSA id it4sm37317662pbc.39.2014.03.30.06.56.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 06:56:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Mar 2014 20:57:30 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245472>

This is more user friendly version of ls-files:

* it's automatically colored and columnized
* it refreshes the index like all porcelain commands
* it defaults to non-recursive behavior like ls
* :(glob) is on by default so '*.c' means a.c but not a/b.c, use
  '**/*.c' for that.
* auto pager

The name 'ls' is not taken. It is left for the user to make an alias
with better default options.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                             |  1 +
 Documentation/config.txt               | 10 +++++
 Documentation/git-list-files.txt (new) | 80 ++++++++++++++++++++++++++=
++++++++
 Makefile                               |  1 +
 builtin/ls-files.c                     | 69 ++++++++++++++++++++++++++=
+--
 command-list.txt                       |  1 +
 git.c                                  |  1 +
 7 files changed, 159 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/git-list-files.txt

diff --git a/.gitignore b/.gitignore
index dc600f9..faeac5d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -75,6 +75,7 @@
 /git-init
 /git-init-db
 /git-instaweb
+/git-list-files
 /git-log
 /git-ls-files
 /git-ls-remote
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6bca55e..e07e8bc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -909,6 +909,12 @@ color.status.<slot>::
 	to red). The values of these variables may be specified as in
 	color.branch.<slot>.
=20
+color.list-files::
+	A boolean to enable/disable color in the output of
+	linkgit:git-list-files[1]. May be set to `always`, `false` (or
+	`never`) or `auto` (or `true`), in which case colors are used
+	only when the output is to a terminal. Defaults to false.
+
 color.ls.<slot>::
 	Use customized color for file name colorization. If not set
 	and the environment variable LS_COLORS is set, color settings
@@ -981,6 +987,10 @@ column.clean::
 	Specify the layout when list items in `git clean -i`, which always
 	shows files and directories in columns. See `column.ui` for details.
=20
+column.list-files::
+	Specify whether to output tag listing in `git list-files` in columns.
+	See `column.ui` for details.
+
 column.status::
 	Specify whether to output untracked files in `git status` in columns.
 	See `column.ui` for details.
diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
new file mode 100644
index 0000000..3039e1e
--- /dev/null
+++ b/Documentation/git-list-files.txt
@@ -0,0 +1,80 @@
+git-list-files(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-list-files - List files
+
+SYNOPSIS
+--------
+[verse]
+'git list-files [options] [<pathspec>...]
+
+DESCRIPTION
+-----------
+List files (by default in current working directory) that are in the
+index. Depending on the chosen options, maybe only modified files in
+working tree are shown, or untracked files...
+
+OPTIONS
+-------
+-c::
+--cached::
+	Show cached files (default)
+
+-d::
+--deleted::
+	Show cached files that are deleted on working directory
+
+-m::
+--modified::
+	Show cached files that have modification on working directory
+
+-o::
+--others::
+	Show untracked files (and only unignored ones unless -i is
+	specified)
+
+-i::
+--ignored::
+	Show only ignored files. When showing files in the index,
+	print only those matched by an exclude pattern. When showing
+	"other" files, show only those matched by an exclude pattern.
+
+-u::
+--unmerged::
+	Show unmerged files
+
+--color[=3D<when>]::
+--no-color::
+	Color file names. The value must be `always`, `never`, or
+	`auto`. `--no-color` is equivalent to
+	`--color=3Dnever`. `--color` is equivalent to
+	`--color=3Dauto`. See configuration variable `color.list-files`
+	for the default settings.
+
+--column[=3D<options>]::
+--no-column::
+	Display files in columns. See configuration variable column.ui
+	for option syntax. `--column` and `--no-column` without options
+	are equivalent to 'always' and 'never' respectively.
+
+--max-depth=3D<depth>::
+	For each <pathspec> given on command line, descend at most <depth>
+	levels of directories. A negative value means no limit.
+	This option is ignored if <pathspec> contains active wildcards.
+	In other words if "a*" matches a directory named "a*",
+	"*" is matched literally so --max-depth is still effective.
+	The default is `--max-depth=3D0`.
+
+<pathspec>::
+	Files to show. :(glob) magic is enabled and recursion disabled
+	by default.
+
+SEE ALSO
+--------
+linkgit:git-ls-files[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index f6a6e14..6104e05 100644
--- a/Makefile
+++ b/Makefile
@@ -584,6 +584,7 @@ BUILT_INS +=3D git-cherry-pick$X
 BUILT_INS +=3D git-format-patch$X
 BUILT_INS +=3D git-fsck-objects$X
 BUILT_INS +=3D git-init$X
+BUILT_INS +=3D git-list-files$X
 BUILT_INS +=3D git-merge-subtree$X
 BUILT_INS +=3D git-show$X
 BUILT_INS +=3D git-stage$X
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 130bed0..0ae07b0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -31,6 +31,7 @@ static int line_terminator =3D '\n';
 static int debug_mode;
 static int use_color;
 static unsigned int colopts;
+static int porcelain;
=20
 static const char *prefix;
 static int max_prefix_len;
@@ -459,6 +460,11 @@ static const char * const ls_files_usage[] =3D {
 	NULL
 };
=20
+static const char * const ls_usage[] =3D {
+	N_("git list-files [options] [<file>...]"),
+	NULL
+};
+
 static int option_parse_z(const struct option *opt,
 			  const char *arg, int unset)
 {
@@ -500,6 +506,17 @@ static int option_parse_exclude_standard(const str=
uct option *opt,
 	return 0;
 }
=20
+static int git_ls_config(const char *var, const char *value, void *cb)
+{
+	if (starts_with(var, "column."))
+		return git_column_config(var, value, "list-files", &colopts);
+	if (!strcmp(var, "color.list-files")) {
+		use_color =3D git_config_colorbool(var, value);
+		return 0;
+	}
+	return git_color_default_config(var, value, cb);
+}
+
 int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
 	int require_work_tree =3D 0, show_tag =3D 0, i;
@@ -568,21 +585,61 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *cmd_prefix)
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
 		OPT_END()
 	};
+	struct option builtin_ls_options[] =3D {
+		OPT_BOOL('c', "cached", &show_cached,
+			N_("show cached files (default)")),
+		OPT_BOOL('d', "deleted", &show_deleted,
+			N_("show cached files that are deleted on working directory")),
+		OPT_BOOL('m', "modified", &show_modified,
+			N_("show cached files that have modification on working directory")=
),
+		OPT_BOOL('o', "others", &show_others,
+			N_("show untracked files")),
+		OPT_BIT('i', "ignored", &dir.flags,
+			N_("show ignored files"),
+			DIR_SHOW_IGNORED),
+		OPT_BOOL('u', "unmerged", &show_unmerged,
+			N_("show unmerged files")),
+		OPT__COLOR(&use_color, N_("show color")),
+		OPT_COLUMN(0, "column", &colopts, N_("show files in columns")),
+		{ OPTION_INTEGER, 0, "max-depth", &max_depth, N_("depth"),
+			N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
+			NULL, 1 },
+		OPT__ABBREV(&abbrev),
+		OPT_END()
+	};
+	struct option *options;
+	const char * const *help_usage;
=20
+	if (!strcmp(argv[0], "list-files")) {
+		help_usage =3D ls_usage;
+		options =3D builtin_ls_options;
+		porcelain =3D 1;
+	} else {
+		help_usage =3D ls_files_usage;
+		options =3D builtin_ls_files_options;
+	}
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(ls_files_usage, builtin_ls_files_options);
+		usage_with_options(help_usage, options);
=20
 	memset(&dir, 0, sizeof(dir));
 	prefix =3D cmd_prefix;
 	if (prefix)
 		prefix_len =3D strlen(prefix);
-	git_config(git_default_config, NULL);
+
+	if (porcelain) {
+		setenv(GIT_GLOB_PATHSPECS_ENVIRONMENT, "1", 1);
+		exc_given =3D 1;
+		setup_standard_excludes(&dir);
+		use_color =3D -1;
+		max_depth =3D 0;
+		git_config(git_ls_config, NULL);
+	} else
+		git_config(git_default_config, NULL);
=20
 	if (read_cache() < 0)
 		die("index file corrupt");
=20
-	argc =3D parse_options(argc, argv, prefix, builtin_ls_files_options,
-			ls_files_usage, 0);
+	argc =3D parse_options(argc, argv, prefix, options, help_usage, 0);
 	el =3D add_exclude_list(&dir, EXC_CMDL, "--exclude option");
 	for (i =3D 0; i < exclude_list.nr; i++) {
 		add_exclude(exclude_list.items[i].string, "", 0, el, --exclude_args)=
;
@@ -661,6 +718,10 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
 			die("ls-files --with-tree is incompatible with -s or -u");
 		overlay_tree_on_cache(with_tree, max_prefix);
 	}
+	if (porcelain) {
+		refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
+		setup_pager();
+	}
 	show_files(&dir);
 	if (show_resolve_undo)
 		show_ru_info();
diff --git a/command-list.txt b/command-list.txt
index cf36c3d..bfaca46 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -63,6 +63,7 @@ git-index-pack                          plumbingmanip=
ulators
 git-init                                mainporcelain common
 git-instaweb                            ancillaryinterrogators
 gitk                                    mainporcelain
+git-list-files                          mainporcelain
 git-log                                 mainporcelain common
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
diff --git a/git.c b/git.c
index 9efd1a3..8b46e92 100644
--- a/git.c
+++ b/git.c
@@ -380,6 +380,7 @@ static struct cmd_struct commands[] =3D {
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
+	{ "list-files", cmd_ls_files, RUN_SETUP },
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
--=20
1.9.1.345.ga1a145c
