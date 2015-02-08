From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/21] list-files: a user friendly version of ls-files and more
Date: Sun,  8 Feb 2015 16:01:27 +0700
Message-ID: <1423386099-19994-10-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:03:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNlu-000637-UC
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345AbbBHJDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:03:11 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:44819 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbbBHJDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:03:09 -0500
Received: by mail-pa0-f54.google.com with SMTP id kx10so11831663pab.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3cvO0LXTu2kJCvskbE52vdOtwz5bJjzZpVA296bMEVc=;
        b=iZiZ5DBZhjw/KqOczpDhKjdVabj5pWpsG0ZPnSR3oS2TbqBOhlLymXe0ZhuJ9+sO86
         yjy6mRoo1MJpKzR459BFgiBXYWaGb2q4VrMsWN9txBWdHUYvuIfu+w+t6J//45QRqJZm
         qlsNvVD9hOjUEk4AbPNnfyGKOmgOPwBEm6A7M3eZeNgPLFnLXHh05Rc+TNrXWjWbBClu
         tTTtwm6o9q3H/SNGs2Hkfpx3F6LTwU1hH6QriVUVeEmJ7YDVw5ndE6qZEsLOZlID7iTI
         vYbsfVAwZt/OGdjFwbWQC3aU86bXXDpHJfjjcQgcW+hzYCTSCqUZO16e7HnvGSk+CQsX
         VjLw==
X-Received: by 10.70.44.38 with SMTP id b6mr19396185pdm.33.1423386188645;
        Sun, 08 Feb 2015 01:03:08 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id k3sm12938816pde.79.2015.02.08.01.03.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:03:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:03:16 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263496>

This is more user friendly version of ls-files:

 * it's automatically colored and columnized
 * it refreshes the index like all porcelain commands
 * it defaults to non-recursive behavior like ls
 * :(glob) is on by default so '*.c' means a.c but not a/b.c, use
   '**/*.c' for that.
 * auto pager

The name 'ls' is not taken. It is left for the user to make an alias
with better default options.

Helped-by: Junio C Hamano <gitster@pobox.com>
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
index a052419..9727ecc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -76,6 +76,7 @@
 /git-init-db
 /git-interpret-trailers
 /git-instaweb
+/git-list-files
 /git-log
 /git-ls-files
 /git-ls-remote
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2290c47..2dc4788 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -940,6 +940,12 @@ color.status.<slot>::
 	to red). The values of these variables may be specified as in
 	color.branch.<slot>.
=20
+color.listFiles::
+	A boolean to enable/disable color in the output of
+	linkgit:git-list-files[1]. May be set to `always`, `false` (or
+	`never`) or `auto` (or `true`), in which case colors are used
+	only when the output is to a terminal. Defaults to false.
+
 color.ls.<slot>::
 	Use customized color for file name colorization. If not set
 	and the environment variable LS_COLORS is set, color settings
@@ -1012,6 +1018,10 @@ column.clean::
 	Specify the layout when list items in `git clean -i`, which always
 	shows files and directories in columns. See `column.ui` for details.
=20
+column.listFiles::
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
index 459121d..23a0751 100644
--- a/Makefile
+++ b/Makefile
@@ -587,6 +587,7 @@ BUILT_INS +=3D git-cherry-pick$X
 BUILT_INS +=3D git-format-patch$X
 BUILT_INS +=3D git-fsck-objects$X
 BUILT_INS +=3D git-init$X
+BUILT_INS +=3D git-list-files$X
 BUILT_INS +=3D git-merge-subtree$X
 BUILT_INS +=3D git-show$X
 BUILT_INS +=3D git-stage$X
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 09a6b8d..d55b5e7 100644
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
+		return git_column_config(var, value, "listfiles", &colopts);
+	if (!strcmp(var, "color.listfiles")) {
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
+		refresh_index(&the_index, REFRESH_QUIET | REFRESH_UNMERGED, &pathspe=
c, NULL, NULL);
+		setup_pager();
+	}
 	show_files(&dir);
 	if (show_resolve_undo)
 		show_ru_info();
diff --git a/command-list.txt b/command-list.txt
index f1eae08..32101de 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -64,6 +64,7 @@ git-init                                mainporcelain=
 common
 git-instaweb                            ancillaryinterrogators
 git-interpret-trailers                  purehelpers
 gitk                                    mainporcelain
+git-list-files                          mainporcelain
 git-log                                 mainporcelain common
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
diff --git a/git.c b/git.c
index 18fbf79..617c083 100644
--- a/git.c
+++ b/git.c
@@ -418,6 +418,7 @@ static struct cmd_struct commands[] =3D {
 	{ "init", cmd_init_db, NO_SETUP },
 	{ "init-db", cmd_init_db, NO_SETUP },
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP },
+	{ "list-files", cmd_ls_files, RUN_SETUP },
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
--=20
2.3.0.rc1.137.g477eb31
