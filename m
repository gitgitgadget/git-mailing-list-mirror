From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/21] nd/list-files updates
Date: Sun, 25 Jan 2015 19:37:35 +0700
Message-ID: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:26:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMHF-00017e-Hk
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbbAYM0u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:26:50 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34394 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbbAYM0r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:26:47 -0500
Received: by mail-pd0-f179.google.com with SMTP id v10so6814523pde.10
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Aay1VtNVCdfys+GpnCYQkO0l4rrB0sYmBPTHOaQ+FEw=;
        b=MRUexeYuN1oUviDPmycMuHvRHlZZPyy5Lj8+/4241LZ6bzu5bRJOYgkThqtQLRXJws
         kJZiPy/EunTKjnklgzx2GDq0KqLccL+79Q5tEU2c4luiwatN5LfMLOdKkbgoq4crosG4
         DS5sGCVnjPQBbeqt2BtpHt8a5hszBecJtnvT5L5Y8Bqn2IQ5pBtg/bF1bjy/PUbQhqlf
         mvahCzkKns/LJloq9xlERiUscxapZYI5m9n8ZVerNn6MG1nzPSkx8PKZuepoZ7WYq2hc
         3LD6z2+50FqbsnhM6NmYfVbxWLH8r2hw1WLkn42fMm84hIuD6mcl6t+e3Yszb7EjocG/
         Bf9w==
X-Received: by 10.70.41.231 with SMTP id i7mr26110603pdl.102.1422188807349;
        Sun, 25 Jan 2015 04:26:47 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id fo8sm7101050pdb.74.2015.01.25.04.26.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:26:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:38:11 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262997>

Changes since 'pu' version:

 - refresh_index() in 09/21 is set not to show "XXX: needs merge"
   messages, cluttering "list-files -u" output
 - new patch 10/21 to add a default alias 'ls' to 'list-files',
   of course overridable by the user
 - fix "list-files -u" not showing anything because
   show_files_compact in 16/21 ignores show_unmerged flag
 - directory listing in 17/21 is rewritten to work filtering
   (e.g. -m, -M...)
 - new patch 21/21 adds tests for the series

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (21):
  ls_colors.c: add $LS_COLORS parsing code
  ls_colors.c: parse color.ls.* from config file
  ls_colors.c: add a function to color a file name
  ls_colors.c: highlight submodules like directories
  ls-files: buffer full item in strbuf before printing
  ls-files: add --color to highlight file names
  ls-files: add --column
  ls-files: support --max-depth
  list-files: a user friendly version of ls-files and more
  list-files: make alias 'ls' default to 'list-files'
  list-files: -u does not imply showing stages
  list-files: add -R/--recursive short for --max-depth=3D-1
  list-files: add -1 short for --no-column
  list-files: add -t back
  list-files: sort output and remove duplicates
  list-files: do not show duplicate cached entries
  list-files: show directories as well as files
  list-files: add -F/--classify
  list-files -F: show submodules with the new indicator '&'
  list-files: -M aka diff-cached
  t3080: tests for git-list-files

Total diff against 'pu' is something like this

-- 8< --
diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
index c57129b..223f6fd 100644
--- a/Documentation/git-list-files.txt
+++ b/Documentation/git-list-files.txt
@@ -14,7 +14,8 @@ DESCRIPTION
 -----------
 List files (by default in current working directory) that are in the
 index. Depending on the chosen options, maybe only modified files in
-working tree are shown, or untracked files...
+working tree are shown, or untracked files... The builtin alias "ls"
+is set to "list-files".
=20
 OPTIONS
 -------
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 02a9ac1..b04c712 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -213,6 +213,37 @@ static void show_killed_files(struct dir_struct *d=
ir)
 	}
 }
=20
+static int show_as_directory(const struct cache_entry *ce)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *p;
+
+	strbuf_add(&sb, ce->name, ce_namelen(ce));
+	while (sb.len && (p =3D strrchr(sb.buf, '/')) !=3D NULL) {
+		struct strbuf sb2 =3D STRBUF_INIT;
+		strbuf_setlen(&sb, p - sb.buf);
+		if (!match_pathspec(&pathspec, sb.buf, sb.len,
+				    max_prefix_len, NULL, 1))
+			continue;
+		write_name(&sb2, sb.buf);
+		if (want_color(use_color)) {
+			struct strbuf sb3 =3D STRBUF_INIT;
+			color_filename(&sb3, ce->name, sb2.buf, S_IFDIR, 1);
+			strbuf_release(&sb2);
+			sb2 =3D sb3;
+		}
+		if (show_tag)
+			strbuf_insert(&sb2, 0, tag_cached, strlen(tag_cached));
+		if (show_indicator)
+			append_indicator(&sb2, S_IFDIR);
+		strbuf_fputs(&sb2, strbuf_detach(&sb, NULL), NULL);
+		strbuf_release(&sb2);
+		return 1;
+	}
+	strbuf_release(&sb);
+	return 0;
+}
+
 static void write_ce_name(struct strbuf *sb, const struct cache_entry =
*ce)
 {
 	struct strbuf quoted =3D STRBUF_INIT;
@@ -230,16 +261,31 @@ static void write_ce_name(struct strbuf *sb, cons=
t struct cache_entry *ce)
 static void show_ce_entry(const char *tag, const struct cache_entry *c=
e)
 {
 	static struct strbuf sb =3D STRBUF_INIT;
-	int len =3D max_prefix_len;
+	int len =3D max_prefix_len, saved_max_depth;
=20
 	if (len >=3D ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of pref=
ix");
=20
+	if (show_dirs) {
+		/* ignore depth to catch dirs that contain matched entries */
+		saved_max_depth =3D pathspec.max_depth;
+		pathspec.max_depth =3D -1;
+	}
+
 	if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
 			    len, ps_matched,
 			    S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode)))
 		return;
=20
+	if (show_dirs) {
+		pathspec.max_depth =3D saved_max_depth;
+		if (strchr(ce->name, '/') &&
+		    !match_pathspec(&pathspec, ce->name, ce_namelen(ce),
+				    prefix_len, NULL, 1) &&
+		    show_as_directory(ce))
+			return;
+	}
+
 	if (tag && *tag && show_valid_bit &&
 	    (ce->ce_flags & CE_VALID)) {
 		static char alttag[4];
@@ -348,7 +394,7 @@ static void show_files(struct dir_struct *dir)
 				(ce_skip_worktree(ce) ? tag_skip_worktree : tag_cached), ce);
 		}
 	}
-	if (show_deleted || show_modified || show_diff_cached) {
+	if (show_deleted || show_modified) {
 		for (i =3D 0; i < active_nr; i++) {
 			const struct cache_entry *ce =3D active_cache[i];
 			struct stat st;
@@ -377,45 +423,6 @@ static void show_files(struct dir_struct *dir)
 	}
 }
=20
-static void show_directories(const struct cache_entry *ce)
-{
-	static const char *last_directory;
-	struct strbuf sb =3D STRBUF_INIT;
-	const char *p =3D ce->name + prefix_len;
-	const char *sep;
-
-	if (last_directory) {
-		int len =3D strlen(last_directory);
-		if (!strncmp(ce->name, last_directory, len) &&
-		    ce->name[len] =3D=3D '/')
-			p +=3D len + 1;
-	}
-
-	while (*p && (sep =3D strchr(p, '/'))) {
-		struct strbuf sb2 =3D STRBUF_INIT;
-		strbuf_reset(&sb);
-		strbuf_add(&sb, ce->name, sep - ce->name);
-		p =3D sep + 1;
-		if (!match_pathspec(&pathspec, sb.buf, sb.len,
-				    prefix_len, NULL, 1))
-			continue;
-		write_name(&sb2, sb.buf);
-		if (want_color(use_color)) {
-			struct strbuf sb3 =3D STRBUF_INIT;
-			color_filename(&sb3, ce->name, sb2.buf, S_IFDIR, 1);
-			strbuf_release(&sb2);
-			sb2 =3D sb3;
-		}
-		if (show_tag)
-			strbuf_insert(&sb2, 0, tag_cached, strlen(tag_cached));
-		if (show_indicator)
-			append_indicator(&sb2, S_IFDIR);
-		last_directory =3D strbuf_detach(&sb, NULL);
-		strbuf_fputs(&sb2, last_directory, NULL);
-		strbuf_release(&sb2);
-	}
-}
-
 static void show_files_compact(struct dir_struct *dir)
 {
 	int i;
@@ -430,14 +437,13 @@ static void show_files_compact(struct dir_struct =
*dir)
 		if (show_killed)
 			show_killed_files(dir);
 	}
-	if (!(show_cached || show_stage || show_deleted || show_modified))
+	if (!(show_cached || show_unmerged || show_deleted ||
+	      show_modified || show_diff_cached))
 		return;
 	for (i =3D 0; i < active_nr; i++) {
 		const struct cache_entry *ce =3D active_cache[i];
 		struct stat st;
 		int err, shown =3D 0;
-		if (show_dirs)
-			show_directories(ce);
 		if ((dir->flags & DIR_SHOW_IGNORED) &&
 		    !ce_excluded(dir, ce))
 			continue;
@@ -452,6 +458,15 @@ static void show_files_compact(struct dir_struct *=
dir)
 			show_ce_entry(tag_removed, ce);
 			shown =3D 1;
 		}
+		if (show_diff_cached && (ce->ce_flags & CE_MATCHED)) {
+			show_ce_entry(tag_diff_cached, ce);
+			shown =3D 1;
+			/*
+			 * if we don't clear, it'll confuse write_ce_name()
+			 * when show_ce_entry(tag_modified, ce) is called
+			 */
+			active_cache[i]->ce_flags &=3D ~CE_MATCHED;
+		}
 		if (show_modified && (err || ce_modified(ce, &st, 0))) {
 			show_ce_entry(tag_modified, ce);
 			shown =3D 1;
@@ -817,7 +832,6 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		use_color =3D -1;
 		max_depth =3D 0;
 		show_tag =3D -1;
-		show_dirs =3D 1;
 		git_config(git_ls_config, NULL);
 	} else
 		git_config(git_default_config, NULL);
@@ -866,6 +880,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		       prefix, argv);
 	pathspec.max_depth =3D max_depth;
 	pathspec.recursive =3D 1;
+	show_dirs =3D porcelain && max_depth !=3D -1;
+
=20
 	/* Find common prefix for all pathspec's */
 	max_prefix =3D common_prefix(&pathspec);
@@ -911,7 +927,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		overlay_tree_on_cache(with_tree, max_prefix);
 	}
 	if (porcelain) {
-		refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
+		refresh_index(&the_index, REFRESH_QUIET | REFRESH_UNMERGED, &pathspe=
c, NULL, NULL);
 		setup_pager();
 	}
 	if (show_diff_cached)
diff --git a/config.c b/config.c
index 15a2983..16209c6 100644
--- a/config.c
+++ b/config.c
@@ -40,6 +40,10 @@ static struct config_source *cf;
=20
 static int zlib_compression_seen;
=20
+static const char *builtin_config =3D
+	"[alias]\n"
+	"	ls =3D list-files\n";
+
 /*
  * Default config_set that contains key-value pairs from the usual set=
 of config
  * config files (i.e repo specific .git/config, user wide ~/.gitconfig=
, XDG
@@ -1175,6 +1179,10 @@ int git_config_early(config_fn_t fn, void *data,=
 const char *repo_config)
=20
 	home_config_paths(&user_config, &xdg_config, "config");
=20
+	if (git_config_system())
+		git_config_from_buf(fn, "<builtin>", builtin_config,
+				    strlen(builtin_config), data);
+
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, =
0)) {
 		ret +=3D git_config_from_file(fn, git_etc_gitconfig(),
 					    data);
diff --git a/t/t3080-list-files.sh b/t/t3080-list-files.sh
new file mode 100755
index 0000000..6313dd9
--- /dev/null
+++ b/t/t3080-list-files.sh
@@ -0,0 +1,122 @@
+#!/bin/sh
+
+test_description=3D'git list-files test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir dir &&
+	touch file dir/file &&
+	git init gitlink &&
+	( cd gitlink && test_commit foo ) &&
+	git add file dir/file gitlink &&
+	git commit -qm1
+'
+
+test_expect_success 'LS_COLORS env variable' '
+	LS_COLORS=3D"rs=3D0:fi=3D31:di=3D32" \
+		git list-files --color=3Dalways | grep -v gitlink >actual &&
+	test_cmp "$TEST_DIRECTORY"/t3080/ls_colors actual
+'
+
+test_expect_success 'color.ls.*' '
+	test_config color.ls.file red &&
+	test_config color.ls.directory green &&
+	test_config color.ls.submodule yellow &&
+	git list-files --color=3Dalways >actual &&
+	test_cmp "$TEST_DIRECTORY"/t3080/color_ls actual
+'
+
+test_expect_success 'column output' '
+	COLUMNS=3D20 git list-files --column=3Dalways >actual &&
+	cat >expected <<-\EOF &&
+	dir      gitlink
+	file
+	EOF
+	test_cmp expected actual &&
+	git list-files -1 >actual &&
+	cat >expected <<-\EOF &&
+	dir
+	file
+	gitlink
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success '--max-depth' '
+	git list-files --max-depth=3D1 >actual &&
+	cat >expected <<-\EOF &&
+	dir/file
+	file
+	gitlink
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'recursive' '
+	git list-files -R >actual &&
+	cat >expected <<-\EOF &&
+	dir/file
+	file
+	gitlink
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'globbing' '
+	git list-files "f*" >actual &&
+	cat >expected <<-\EOF &&
+	file
+	EOF
+	test_cmp expected actual &&
+	git list-files "**/f*" >actual &&
+	cat >expected <<-\EOF &&
+	dir/file
+	file
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'no dups' '
+	echo dirty >>file &&
+	git list-files -m file >actual &&
+	echo "file" >expected &&
+	test_cmp expected actual &&
+	git list-files -cm file >actual &&
+	echo "C file" >expected &&
+	test_cmp expected actual &&
+	git list-files -tcm file >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--classify' '
+	git list-files -F >actual &&
+	cat >expected <<-\EOF &&
+	dir/
+	file
+	gitlink&
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'diff-cached' '
+	echo dirty >>file &&
+	git add file &&
+	git list-files -M >actual &&
+	echo "file" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'unmerged files' '
+	git ls-files --stage file >index-info &&
+	sed "s/ 0/ 2/;s/file/unmerged/" index-info | git update-index --index=
-info &&
+	sed "s/ 0/ 3/;s,file,dir/unmerged," index-info | git update-index --i=
ndex-info &&
+	git list-files -u >actual &&
+	cat >expected <<-\EOF &&
+	dir
+	unmerged
+	EOF
+	test_cmp expected actual
+'
+
+test_done
diff --git a/t/t3080/color_ls b/t/t3080/color_ls
new file mode 100644
index 0000000..47f77ad
--- /dev/null
+++ b/t/t3080/color_ls
@@ -0,0 +1,3 @@
+=1B[32mdir=1B[m
+=1B[31mfile=1B[m
+=1B[33mgitlink=1B[m
diff --git a/t/t3080/ls_colors b/t/t3080/ls_colors
new file mode 100644
index 0000000..423c016
--- /dev/null
+++ b/t/t3080/ls_colors
@@ -0,0 +1,2 @@
+=1B[32mdir=1B[m
+=1B[31mfile=1B[m
-- 8< --
--=20
2.2.0.84.ge9c7a8a
