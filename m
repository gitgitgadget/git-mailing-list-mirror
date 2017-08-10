Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACE74208BD
	for <e@80x24.org>; Thu, 10 Aug 2017 18:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbdHJSuV (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:50:21 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36975 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752713AbdHJSuT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:50:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id p13so1407058pfd.4
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 11:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jLagN08j3xAei1tFTFABT9QC9gm4NfD3TSoq6+HNI94=;
        b=qAh/olpV/DHF2AaoMM2R7LxA5e9cS+uxgdv8dsJqGp7n8eYgLvuXmMgPX+HOlMMLYV
         rqeBSwLGNhe9kHGLujYsag4cA6antNC/WZOFCXR93TNxgEfI2x24HxoaOemQjaRlgHkx
         LYv0e8ATZ13znd8w2yPcJqyOvMeA4aQqZOFF+uHkStnB+AG/UFx5f82Ap2izV4zWD831
         T/YTi5+1GKXLIwL7ZY1kW+axguE8c9v62op75PtaUUCYryhrrKT7FCZ9s41Ji891XDPe
         TQ9fEvLOJLFGI05PofDxwPFeyUYuQT6l8Z6X0bDY20wgOr10w3Bc4ly4SiTyTvryzdhE
         X9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jLagN08j3xAei1tFTFABT9QC9gm4NfD3TSoq6+HNI94=;
        b=DKPGvUWJamg+c6sCsRfVnX3/Gapgcx0MsYiNS1w3bF5Ijog5ZUqGVc0cX4XxfOewBD
         cjNIj5k+Xd3VLzoG8mgjSCO3E+csrZ0vcdMHI3bJuxpCU7gII/tq2hQ9stKae1/sIqsa
         awtchrJySWr6NPiSfTrxj4rSzJY1FW4f0zAuelnxlYBvX0xSB/I6FMom7sHjKzK5tUz8
         eugudX1KwcLm65oBkBk2RE/pSgCFZGFdauEXYZPULVHok6yky3qstXeS/o18IGOgk/Z0
         NpC1meWWRlNhT6IqlBCRSrthi6a6Z87Yd2TSS+RXM3vxEdPM4cSjEUB2Li7FqpN8S0GJ
         gatw==
X-Gm-Message-State: AHYfb5gWwNX4MrPInQETYdQdSstI2RmZnrksNPJsSJiExHNhJUy6XfmL
        eEg8urBFhzSlvSMrrqhafw==
X-Received: by 10.84.224.76 with SMTP id a12mr14446592plt.382.1502391018813;
        Thu, 10 Aug 2017 11:50:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:8010:1::162])
        by smtp.gmail.com with ESMTPSA id j63sm7498299pge.88.2017.08.10.11.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Aug 2017 11:50:18 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     git@vger.kernel.org
Cc:     sxlijin@gmail.com, bmwill@google.com, gitster@pobox.com,
        peff@peff.net, Jameson Miller <jamill@microsoft.com>
Subject: [PATCH v1 1/1] dir: teach status to show ignored directories
Date:   Thu, 10 Aug 2017 14:49:36 -0400
Message-Id: <20170810184936.239542-2-jamill@microsoft.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170810184936.239542-1-jamill@microsoft.com>
References: <20170810184936.239542-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach Git to optionally show ignored directories when showing all
untracked files. The git status command exposes the options to report
ignored and/or untracked files. However, when reporting all untracked
files (--untracked-files=all), all individual ignored files are reported
as well. It is not currently possible to get the reporting behavior of
the --ignored flag, while also reporting all untracked files. This
change exposes a flag to report all untracked files while not showing
individual files in ignored directories.

Motivation:
Our application (Visual Studio) needs all untracked files listed
individually, but does not need all ignored files listed individually.
Reporting all ignored files can affect the time it takes for status
to run. For a representative repository, here are some measurements
showing a large perf improvement for this scenario:

| Command | Reported ignored entries | Time (s) |
| ------- | ------------------------ | -------- |
| 1       | 0                        | 1.3      |
| 2       | 1024                     | 4.2      |
| 3       | 174904                   | 7.5      |
| 4       | 1046                     | 1.6      |

Commands:
 1) status
 2) status --ignored
 3) status --ignored --untracked-files=all
 4) status --ignored --untracked-files=all --show-ignored-directory

This changes exposes a --show-ignored-directory flag to the git status
command. This flag is utilized when running git status with the
--ignored and --untracked-files options to not list ignored individual
ignored files contained in directories that match an ignore pattern.

Part of the perf improvement comes from the tweak to
read_directory_recursive to stop scanning the file system after it
encounters the first file. When a directory is ignored, all it needs to
determine is if the directory is empty or not. The logic currently keeps
scanning the file system until it finds an untracked file. However, as
the directory is ignored, all the contained contents are also marked
excluded. For ignored directories that contain a large number of files,
this can take some time.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 Documentation/git-status.txt                      |   5 +
 Documentation/technical/api-directory-listing.txt |   6 +
 builtin/commit.c                                  |   4 +
 dir.c                                             |  48 +++++-
 dir.h                                             |   3 +-
 t/t7519-status-show-ignored-directory.sh          | 189 ++++++++++++++++++++++
 wt-status.c                                       |   4 +
 wt-status.h                                       |   1 +
 8 files changed, 253 insertions(+), 7 deletions(-)
 create mode 100755 t/t7519-status-show-ignored-directory.sh

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index d47f198f15..48ebe18571 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -100,6 +100,11 @@ configuration variable documented in linkgit:git-config[1].
 --ignored::
 	Show ignored files as well.
 
+--show-ignored-directory::
+    Show directories that are ignored, instead of individual files.
+    Does not recurse into excluded directories when listing all
+    untracked files.
+
 -z::
 	Terminate entries with NUL, instead of LF.  This implies
 	the `--porcelain=v1` output format if no other format is given.
diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
index 6c77b4920c..a9816df44c 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -33,6 +33,12 @@ The notable options are:
 	Similar to `DIR_SHOW_IGNORED`, but return ignored files in `ignored[]`
 	in addition to untracked files in `entries[]`.
 
+`DIR_SHOW_IGNORED_DIRECTORY`:::
+
+	If this is set, non-empty directories that match an ignore pattern are
+	returned. The individual files contained in ignored directories are not
+	included.
+
 `DIR_KEEP_UNTRACKED_CONTENTS`:::
 
 	Only has meaning if `DIR_SHOW_IGNORED_TOO` is also set; if this is set, the
diff --git a/builtin/commit.c b/builtin/commit.c
index 8e93802511..9fcf77ae3a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1333,6 +1333,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
 
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
+	static int show_ignored_directory = 0;
 	static struct wt_status s;
 	int fd;
 	struct object_id oid;
@@ -1362,6 +1363,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		  N_("ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		OPT_COLUMN(0, "column", &s.colopts, N_("list untracked files in columns")),
+		OPT_BOOL(0, "show-ignored-directory", &show_ignored_directory,
+		N_("Only show directories that match an ignore pattern name.")),
 		OPT_END(),
 	};
 
@@ -1394,6 +1397,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	s.ignore_submodule_arg = ignore_submodule_arg;
 	s.status_format = status_format;
 	s.verbose = verbose;
+	s.show_ignored_directory = show_ignored_directory;
 
 	wt_status_collect(&s);
 
diff --git a/dir.c b/dir.c
index ae6f5c9636..b17dfd53bf 100644
--- a/dir.c
+++ b/dir.c
@@ -49,7 +49,7 @@ struct cached_dir {
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	struct index_state *istate, const char *path, int len,
 	struct untracked_cache_dir *untracked,
-	int check_only, const struct pathspec *pathspec);
+	int check_only, int stop_at_first_file, const struct pathspec *pathspec);
 static int get_dtype(struct dirent *de, struct index_state *istate,
 		     const char *path, int len);
 
@@ -1389,6 +1389,21 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	case index_nonexistent:
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
 			break;
+		if (exclude &&
+			(dir->flags & DIR_SHOW_IGNORED_TOO) &&
+			(dir->flags & DIR_SHOW_IGNORED_DIRECTORY)) {
+
+			/*
+			 * This is an excluded directory, and we are only
+			 * showing the name of a excluded directory.
+			 * Check to see if there are any contained files
+			 * to determine if the directory is empty or not.
+			 */
+			if (read_directory_recursive(dir, istate, dirname, len,
+				untracked, 1, 1, pathspec) == path_excluded)
+				return path_excluded;
+			return path_none;
+		}
 		if (!(dir->flags & DIR_NO_GITLINKS)) {
 			unsigned char sha1[20];
 			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
@@ -1405,9 +1420,10 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	untracked = lookup_untracked(dir->untracked, untracked,
 				     dirname + baselen, len - baselen);
 	return read_directory_recursive(dir, istate, dirname, len,
-					untracked, 1, pathspec);
+					untracked, 1, 0, pathspec);
 }
 
+
 /*
  * This is an inexact early pruning of any recursive directory
  * reading - if the path cannot possibly be in the pathspec,
@@ -1633,7 +1649,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 		 * with check_only set.
 		 */
 		return read_directory_recursive(dir, istate, path->buf, path->len,
-						cdir->ucd, 1, pathspec);
+						cdir->ucd, 1, 0, pathspec);
 	/*
 	 * We get path_recurse in the first run when
 	 * directory_exists_in_index() returns index_nonexistent. We
@@ -1798,7 +1814,7 @@ static void close_cached_dir(struct cached_dir *cdir)
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	struct index_state *istate, const char *base, int baselen,
 	struct untracked_cache_dir *untracked, int check_only,
-	const struct pathspec *pathspec)
+	int stop_at_first_file, const struct pathspec *pathspec)
 {
 	struct cached_dir cdir;
 	enum path_treatment state, subdir_state, dir_state = path_none;
@@ -1832,12 +1848,32 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			subdir_state =
 				read_directory_recursive(dir, istate, path.buf,
 							 path.len, ud,
-							 check_only, pathspec);
+							 check_only, stop_at_first_file, pathspec);
 			if (subdir_state > dir_state)
 				dir_state = subdir_state;
 		}
 
 		if (check_only) {
+			if (stop_at_first_file) {
+				/*
+				 * In general, if we are stopping at the first found file,
+				 * We can only signal that a path of at least "excluded" was
+				 * found. If the first file we find is "excluded" - there might
+				 * be other untracked files later on that will not be searched.
+				 *
+				 * In current usage of this function, stop_at_first_file will
+				 * only be set when called from a directory that matches the
+				 * exclude pattern - there should be no untracked files -
+				 * all contents should be marked as excluded.
+				 */
+				if (dir_state == path_excluded)
+					break;
+				else if (dir_state > path_excluded) {
+					dir_state = path_excluded;
+					break;
+				}
+			}
+
 			/* abort early if maximum state has been reached */
 			if (dir_state == path_untracked) {
 				if (cdir.fdir)
@@ -2108,7 +2144,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		 */
 		dir->untracked = NULL;
 	if (!len || treat_leading_path(dir, istate, path, len, pathspec))
-		read_directory_recursive(dir, istate, path, len, untracked, 0, pathspec);
+		read_directory_recursive(dir, istate, path, len, untracked, 0, 0, pathspec);
 	QSORT(dir->entries, dir->nr, cmp_dir_entry);
 	QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
 
diff --git a/dir.h b/dir.h
index e3717055d1..b59eedf633 100644
--- a/dir.h
+++ b/dir.h
@@ -152,7 +152,8 @@ struct dir_struct {
 		DIR_COLLECT_IGNORED = 1<<4,
 		DIR_SHOW_IGNORED_TOO = 1<<5,
 		DIR_COLLECT_KILLED_ONLY = 1<<6,
-		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7
+		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7,
+		DIR_SHOW_IGNORED_DIRECTORY = 1<<8
 	} flags;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
diff --git a/t/t7519-status-show-ignored-directory.sh b/t/t7519-status-show-ignored-directory.sh
new file mode 100755
index 0000000000..3ff0a96cdf
--- /dev/null
+++ b/t/t7519-status-show-ignored-directory.sh
@@ -0,0 +1,189 @@
+#!/bin/sh
+#
+#
+
+test_description='git status collapse ignored'
+
+. ./test-lib.sh
+
+
+cat >.gitignore <<\EOF
+*.ign
+ignored_dir/
+!*.unignore
+EOF
+
+# commit initial ignore file
+test_expect_success 'setup initial commit and ignore file' '
+	git add . &&
+	test_tick &&
+	git commit -m "Initial commit"
+'
+
+cat >expect <<\EOF
+? expect
+? output
+! dir/ignored/ignored_1.ign
+! dir/ignored/ignored_2.ign
+! ignored/ignored_1.ign
+! ignored/ignored_2.ign
+EOF
+
+# Test status behavior on folder with ignored files
+test_expect_success 'setup folder with ignored files' '
+	mkdir -p ignored dir/ignored &&
+	touch ignored/ignored_1.ign ignored/ignored_2.ign \
+		dir/ignored/ignored_1.ign dir/ignored/ignored_2.ign
+'
+
+test_expect_success 'Verify behavior of status on folders with ignored files' '
+	test_when_finished "git clean -fdx" &&
+	git status --porcelain=v2 --ignored --untracked-files=all --show-ignored-directory >output &&
+	test_i18ncmp expect output
+'
+
+# Test status bahavior on folder with tracked and ignored files
+cat >expect <<\EOF
+? expect
+? output
+! dir/tracked_ignored/ignored_1.ign
+! dir/tracked_ignored/ignored_2.ign
+! tracked_ignored/ignored_1.ign
+! tracked_ignored/ignored_2.ign
+EOF
+
+test_expect_success 'setup folder with tracked & ignored files' '
+	mkdir -p tracked_ignored dir/tracked_ignored &&
+	touch tracked_ignored/tracked_1 tracked_ignored/tracked_2 \
+		tracked_ignored/ignored_1.ign tracked_ignored/ignored_2.ign \
+		dir/tracked_ignored/tracked_1 dir/tracked_ignored/tracked_2 \
+		dir/tracked_ignored/ignored_1.ign dir/tracked_ignored/ignored_2.ign &&
+
+	git add tracked_ignored/tracked_1 tracked_ignored/tracked_2 \
+		dir/tracked_ignored/tracked_1 dir/tracked_ignored/tracked_2 &&
+	test_tick &&
+	git commit -m "commit tracked files"
+'
+
+test_expect_success 'Verify status on folder with tracked & ignored files' '
+	git status --porcelain=v2 --ignored --untracked-files=all --show-ignored-directory >output &&
+	test_i18ncmp expect output
+'
+
+# Test status with modified paths
+cat >expect <<\EOF
+1 .M N... 100644 100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 tracked_ignored/tracked_1
+? expect
+? output
+! dir/tracked_ignored/ignored_1.ign
+! dir/tracked_ignored/ignored_2.ign
+! tracked_ignored/ignored_1.ign
+! tracked_ignored/ignored_2.ign
+EOF
+
+test_expect_success 'setup workdir with modified tracked files' '
+	echo 123 > tracked_ignored/tracked_1
+'
+
+test_expect_success 'Verify status on folder with tracked & ignored files' '
+	test_when_finished "git clean -fdx && git reset HEAD~1 --hard" &&
+	git status --porcelain=v2 --ignored --untracked-files=all --show-ignored-directory >output &&
+	test_i18ncmp expect output
+'
+
+# Test status behavior on folder with untracked and ignored files
+cat >expect <<\EOF
+? dir/untracked_ignored/untracked_1
+? dir/untracked_ignored/untracked_2
+? expect
+? output
+? untracked_ignored/untracked_1
+? untracked_ignored/untracked_2
+! dir/untracked_ignored/ignored_1.ign
+! dir/untracked_ignored/ignored_2.ign
+! untracked_ignored/ignored_1.ign
+! untracked_ignored/ignored_2.ign
+EOF
+
+test_expect_success 'setup folder with tracked & ignored files' '
+	mkdir -p untracked_ignored dir/untracked_ignored &&
+	touch untracked_ignored/untracked_1 untracked_ignored/untracked_2 \
+		untracked_ignored/ignored_1.ign untracked_ignored/ignored_2.ign \
+		dir/untracked_ignored/untracked_1 dir/untracked_ignored/untracked_2 \
+		dir/untracked_ignored/ignored_1.ign dir/untracked_ignored/ignored_2.ign
+'
+
+test_expect_success 'Verify status on folder with tracked & ignored files' '
+	test_when_finished "git clean -fdx" &&
+	git status --porcelain=v2 --ignored --untracked-files=all --show-ignored-directory >output &&
+	test_i18ncmp expect output
+'
+
+# Test status behavior on ignored folder
+cat >expect <<\EOF
+? expect
+? output
+! ignored_dir/
+EOF
+
+test_expect_success 'setup folder with tracked & ignored files' '
+	mkdir ignored_dir &&
+	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
+		ignored_dir/ignored_1.ign ignored_dir/ignored_2.ign
+'
+
+test_expect_success 'Verify status on folder with tracked & ignored files' '
+	test_when_finished "git clean -fdx" &&
+	git status --porcelain=v2 --ignored --untracked-files=all --show-ignored-directory >output &&
+	test_i18ncmp expect output
+'
+
+# Test status behavior on ignored folder with tracked file
+cat >expect <<\EOF
+? expect
+? output
+! ignored_dir/ignored_1
+! ignored_dir/ignored_1.ign
+! ignored_dir/ignored_2
+! ignored_dir/ignored_2.ign
+EOF
+
+test_expect_success 'setup folder with tracked & ignored files' '
+	mkdir ignored_dir &&
+	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
+		ignored_dir/ignored_1.ign ignored_dir/ignored_2.ign \
+		ignored_dir/tracked &&
+	git add -f ignored_dir/tracked &&
+	test_tick &&
+	git commit -m "Force add file in ignored directory"
+'
+
+test_expect_success 'Verify status on folder with tracked & ignored files' '
+	test_when_finished "git clean -fdx && git reset HEAD~1 --hard" &&
+	git status --porcelain=v2 --ignored --untracked-files=all --show-ignored-directory >output &&
+	test_i18ncmp expect output
+'
+
+# Test status with more complex paths -
+# ignored underneath an untracked folder
+cat >expect <<\EOF
+? expect
+? output
+? dir/dir/untracked/dir/untracked/a
+! dir/dir/untracked/dir/ignored/a.ign
+! dir/dir/untracked/dir/ignored_dir/
+EOF
+
+test_expect_success 'setup deeper folder structure for ignored and untracked' '
+	mkdir dir/dir/untracked/dir/ignored dir/dir/untracked/dir/ignored_dir \
+		dir/dir/untracked/dir/untracked &&
+	touch dir/dir/untracked/dir/ignored/a.ign dir/dir/untracked/dir/ignored_dir/a \
+	      dir/dir/untracked/dir/untracked/a
+'
+test_expect_success 'Verify status on slightly deeper folder structure' '
+	test_when_finished "git clean -fdx" &&
+	git status --porcelain=v2 --ignored --untracked-files=all --show-ignored-directory >output &&
+	test_i18ncmp expect output
+'
+
+test_done
diff --git a/wt-status.c b/wt-status.c
index 77c27c5113..c3d17490a4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -664,6 +664,10 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		dir.flags |= DIR_SHOW_IGNORED_TOO;
 	else
 		dir.untracked = the_index.untracked;
+
+	if (s->show_ignored_directory)
+		dir.flags |= DIR_SHOW_IGNORED_DIRECTORY;
+
 	setup_standard_excludes(&dir);
 
 	fill_directory(&dir, &the_index, &s->pathspec);
diff --git a/wt-status.h b/wt-status.h
index 64f4d33ea1..b9c1dffb92 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -72,6 +72,7 @@ struct wt_status {
 	int submodule_summary;
 	int show_ignored_files;
 	enum untracked_status_type show_untracked_files;
+	int show_ignored_directory;
 	const char *ignore_submodule_arg;
 	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
 	unsigned colopts;
-- 
2.11.0

