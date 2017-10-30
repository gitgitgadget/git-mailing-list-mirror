Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012C41FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 16:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932328AbdJ3Q3T (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 12:29:19 -0400
Received: from mout.web.de ([212.227.15.14]:50459 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752417AbdJ3Q3R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 12:29:17 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mdueb-1dnxYH0diP-00PeAq; Mon, 30
 Oct 2017 17:29:16 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/1] Introduce git add --renormalize .
Date:   Mon, 30 Oct 2017 17:29:13 +0100
Message-Id: <20171030162913.23164-1-tboegi@web.de>
X-Mailer: git-send-email 2.14.1.729.g59c0ea183a
In-Reply-To: <xmqqshejq9mn.fsf@gitster.mtv.corp.google.com>
References: <xmqqshejq9mn.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:h86sbp2LClxd/kNf1YUB4eUli3nerwMs/KAbgc7uoNV36egf7xD
 h/kxTGyu0lbeBaDolRu6RNR9LJ7uO9I3A6/WPttWY9Ug7/mU/TASWJ7GEl27wOVXVDw3sql
 5ZKQn/exsXqPThl6TDp3pRK4l771t4acgXesMxnc4Xb6UF+dUHO/BEb4Frhs7/WbYZoh8YH
 qgfSqUNqEbe5d02goelpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sDADCi6VYx4=:UNibHLovNhPezw0AbpYaaA
 o1trBrUYxe9gFyrKHGuHilr/POLipqPNfRER8LQsYadx53U83FS5Aem0onZBGWMh+g3UJ+cua
 7e8nRM27ZF4HLBRr0rmyk6gi2hOqGI3s5xiTxkZw2zW60h+IULZyTWlrOu0MRPQGX3DLerDoh
 cjPonuyLXiRhvsuQDdbTHjSxAtszbBzFTdSAZwAVPmTdi9cnSLQprEXCR4A40SpI+uFTfhJTj
 GmRvcT724tvMM7E4OXZcwaiTMMyqP/NWVgnC3QrQQf+I9RoF64XT952mw3RRtLE7UedDQDDye
 rCqsTN9YXXNdgOsfRkxPpFsm+FhjsxvCVdrRzWIPzhHFN/dE1/vZdGq1J8XtWRoH+kp3VeVJp
 CNsJ35lALGMr9dlD/5WGzEGBt1M6g5fWR4J8iCXQ+4AS+V5sRasShJk6MKHoQAYmQoj9Wm0p3
 HJVLXrfV1sWDwHWTEiCzlUPMGwZduEsHlaKtn4Xgc1zoxpME2cV5rcbnVGHVuC0dbGkHA1K82
 zp/M+SokdGGSxRo5pg5Ff3twDK4EYkHBHf6FV5OYqLsFfa/VaWTue8eBlkzNZVW3hOeCzht9c
 NKquc+2pXMLOZTt/m83KH6xmofLnXsekNgWvFwlGNY2fesYla8TElZ8jG9JL9KnJpL8OJtraw
 lbIW4RaOj7+0oEjGjUqvc7TU8In2YXRV1H+nJd6RpxxC5hXV/t4SUBUpKBuyagPJ9ATTiV9fG
 NxwOEqtvdHEvFp6+De3csAPV2WNj74jDXuLBQerhC3YPwYE7rPyt0sF0VzInBcCR8G1tfVNAK
 au7/gceVeZGHPNY2NdO+T7eHHpR3FPf/7EeoMbP6+Y1UhZX9xs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

Make it safer to normalize the line endings in a repository:
Files that had been commited with CRLF will be commited with LF.

The old way to normalize a repo was like this:
 # Make sure that there are not untracked files
 $ echo "* text=auto" >.gitattributes
 $ git read-tree --empty
 $ git add .
 $ git commit -m "Introduce end-of-line normalization"

The user must make sure that there are no untracked files,
otherwise they would have been added and tracked from now on.

The new "add ..renormalize" does not add untracked files:
 $ echo "* text=auto" >.gitattributes
 $ git add --renormalize .
 $ git commit -m "Introduce end-of-line normalization"

Note that "git add --renormalize <pathspec>" is the short form for
"git add -u --renormalize <pathspec>".

While add it, document that the same renormalization may be needed,
whenever a clean filter is added or changed.

Helped-By: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

Second version:
- Removed the global flag
- Make clearer that the clean filters may need renormalization
- commit message improved

Documentation/git-add.txt       |  8 +++++++-
 Documentation/gitattributes.txt |  6 ++++--
 builtin/add.c                   | 28 ++++++++++++++++++++++++++--
 cache.h                         |  1 +
 read-cache.c                    | 30 +++++++++++++++++++-----------
 sha1_file.c                     | 16 ++++++++++++++--
 t/t0025-crlf-renormalize.sh     | 30 ++++++++++++++++++++++++++++++
 7 files changed, 101 insertions(+), 18 deletions(-)
 create mode 100755 t/t0025-crlf-renormalize.sh

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index b700beaff5..09a08ce4c1 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
 	  [--edit | -e] [--[no-]all | --[no-]ignore-removal | [--update | -u]]
-	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing]
+	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
 	  [--chmod=(+|-)x] [--] [<pathspec>...]
 
 DESCRIPTION
@@ -175,6 +175,12 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	warning (e.g., if you are manually performing operations on
 	submodules).
 
+--renormalize::
+	Normalizes the line endings from CRLF to LF of tracked files.
+	This applies to files which are either "text" or "text=auto"
+	in .gitattributes (or core.autocrlf is true or input)
+	--renormalize implies -u
+
 --chmod=(+|-)x::
 	Override the executable bit of the added files.  The executable
 	bit is only changed in the index, the files on disk are left
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 4c68bc19d5..30687de81a 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -232,8 +232,7 @@ From a clean working directory:
 
 -------------------------------------------------
 $ echo "* text=auto" >.gitattributes
-$ git read-tree --empty   # Clean index, force re-scan of working directory
-$ git add .
+$ git add --renormalize .
 $ git status        # Show files that will be normalized
 $ git commit -m "Introduce end-of-line normalization"
 -------------------------------------------------
@@ -328,6 +327,9 @@ You can declare that a filter turns a content that by itself is unusable
 into a usable content by setting the filter.<driver>.required configuration
 variable to `true`.
 
+Note: Whenever the clean filter is changed, the repo should be renormalized:
+$ git add --renormalize .
+
 For example, in .gitattributes, you would assign the `filter`
 attribute for paths.
 
diff --git a/builtin/add.c b/builtin/add.c
index a648cf4c56..c42b50f857 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -26,6 +26,7 @@ static const char * const builtin_add_usage[] = {
 };
 static int patch_interactive, add_interactive, edit_interactive;
 static int take_worktree_changes;
+static int add_renormalize;
 
 struct update_callback_data {
 	int flags;
@@ -123,6 +124,25 @@ int add_files_to_cache(const char *prefix,
 	return !!data.add_errors;
 }
 
+static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
+{
+	int i, retval = 0;
+
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+
+		if (ce_stage(ce))
+			continue; /* do not touch unmerged paths */
+		if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
+			continue; /* do not touch non blobs */
+		if (pathspec && !ce_path_match(ce, pathspec, NULL))
+			continue;
+		retval |= add_file_to_cache(ce->name, flags | HASH_RENORMALIZE);
+	}
+
+	return retval;
+}
+
 static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec, int prefix)
 {
 	char *seen;
@@ -276,6 +296,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL('e', "edit", &edit_interactive, N_("edit current diff and apply")),
 	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files")),
 	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
+	OPT_BOOL(0, "renormalize", &add_renormalize, N_("renormalize EOL of tracked files (implies -u)")),
 	OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
 	OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all tracked and untracked files")),
 	{ OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
@@ -406,7 +427,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			  chmod_arg[1] != 'x' || chmod_arg[2]))
 		die(_("--chmod param '%s' must be either -x or +x"), chmod_arg);
 
-	add_new_files = !take_worktree_changes && !refresh_only;
+	add_new_files = !take_worktree_changes && !refresh_only && !add_renormalize;
 	require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
@@ -500,7 +521,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	plug_bulk_checkin();
 
-	exit_status |= add_files_to_cache(prefix, &pathspec, flags);
+	if (add_renormalize)
+		exit_status |= renormalize_tracked_files(&pathspec, flags);
+	else
+		exit_status |= add_files_to_cache(prefix, &pathspec, flags);
 
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
diff --git a/cache.h b/cache.h
index 6440e2bf21..3e63a74113 100644
--- a/cache.h
+++ b/cache.h
@@ -686,6 +686,7 @@ extern int ie_modified(const struct index_state *, const struct cache_entry *, s
 
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
+#define HASH_RENORMALIZE  4
 extern int index_fd(struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 extern int index_path(struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
diff --git a/read-cache.c b/read-cache.c
index 65f4fe8375..8acd3fcb93 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -631,13 +631,17 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 {
 	int size, namelen, was_same;
 	mode_t st_mode = st->st_mode;
-	struct cache_entry *ce, *alias;
+	struct cache_entry *ce, *alias = NULL;
 	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_RACY_IS_DIRTY;
 	int verbose = flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND);
 	int pretend = flags & ADD_CACHE_PRETEND;
 	int intent_only = flags & ADD_CACHE_INTENT;
 	int add_option = (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
 			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
+	int newflags = HASH_WRITE_OBJECT;
+
+	if (flags & HASH_RENORMALIZE)
+		newflags |= HASH_RENORMALIZE;
 
 	if (!S_ISREG(st_mode) && !S_ISLNK(st_mode) && !S_ISDIR(st_mode))
 		return error("%s: can only add regular files, symbolic links or git-directories", path);
@@ -678,19 +682,23 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	if (ignore_case) {
 		adjust_dirname_case(istate, ce->name);
 	}
+	if (!(flags & HASH_RENORMALIZE)) {
+		alias = index_file_exists(istate, ce->name,
+					  ce_namelen(ce), ignore_case);
+		if (alias &&
+		    !ce_stage(alias) &&
+		    !ie_match_stat(istate, alias, st, ce_option)) {
+			/* Nothing changed, really */
+			if (!S_ISGITLINK(alias->ce_mode))
+				ce_mark_uptodate(alias);
+			alias->ce_flags |= CE_ADDED;
 
-	alias = index_file_exists(istate, ce->name, ce_namelen(ce), ignore_case);
-	if (alias && !ce_stage(alias) && !ie_match_stat(istate, alias, st, ce_option)) {
-		/* Nothing changed, really */
-		if (!S_ISGITLINK(alias->ce_mode))
-			ce_mark_uptodate(alias);
-		alias->ce_flags |= CE_ADDED;
-
-		free(ce);
-		return 0;
+			free(ce);
+			return 0;
+		}
 	}
 	if (!intent_only) {
-		if (index_path(&ce->oid, path, st, HASH_WRITE_OBJECT)) {
+		if (index_path(&ce->oid, path, st, newflags)) {
 			free(ce);
 			return error("unable to index file %s", path);
 		}
diff --git a/sha1_file.c b/sha1_file.c
index 10c3a0083d..15abb184c2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -74,6 +74,18 @@ static struct cached_object *find_cached_object(const unsigned char *sha1)
 	return NULL;
 }
 
+
+static enum safe_crlf get_safe_crlf(unsigned flags)
+{
+	if (flags & HASH_RENORMALIZE)
+		return SAFE_CRLF_RENORMALIZE;
+	else if (flags & HASH_WRITE_OBJECT)
+		return safe_crlf;
+	else
+		return SAFE_CRLF_FALSE;
+}
+
+
 int mkdir_in_gitdir(const char *path)
 {
 	if (mkdir(path, 0777)) {
@@ -1680,7 +1692,7 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
 	if ((type == OBJ_BLOB) && path) {
 		struct strbuf nbuf = STRBUF_INIT;
 		if (convert_to_git(&the_index, path, buf, size, &nbuf,
-				   write_object ? safe_crlf : SAFE_CRLF_FALSE)) {
+				   get_safe_crlf(flags))) {
 			buf = strbuf_detach(&nbuf, &size);
 			re_allocated = 1;
 		}
@@ -1714,7 +1726,7 @@ static int index_stream_convert_blob(unsigned char *sha1, int fd,
 	assert(would_convert_to_git_filter_fd(path));
 
 	convert_to_git_filter_fd(&the_index, path, fd, &sbuf,
-				 write_object ? safe_crlf : SAFE_CRLF_FALSE);
+				 get_safe_crlf(flags));
 
 	if (write_object)
 		ret = write_sha1_file(sbuf.buf, sbuf.len, typename(OBJ_BLOB),
diff --git a/t/t0025-crlf-renormalize.sh b/t/t0025-crlf-renormalize.sh
new file mode 100755
index 0000000000..fb1ed631d2
--- /dev/null
+++ b/t/t0025-crlf-renormalize.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='CRLF renormalization'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git config core.autocrlf false &&
+	printf "LINEONE\nLINETWO\nLINETHREE"     >LF.txt &&
+	printf "LINEONE\r\nLINETWO\r\nLINETHREE" >CRLF.txt &&
+	printf "LINEONE\r\nLINETWO\nLINETHREE"   >CRLF_mix_LF.txt &&
+	git add . &&
+	git commit -m initial
+'
+
+test_expect_success 'renormalize CRLF in repo' '
+	echo "*.txt text=auto" >.gitattributes &&
+	git add --renormalize "*.txt" &&
+cat >expect <<EOF &&
+i/lf w/crlf attr/text=auto CRLF.txt
+i/lf w/lf attr/text=auto LF.txt
+i/lf w/mixed attr/text=auto CRLF_mix_LF.txt
+EOF
+	git ls-files --eol |
+	sed -e "s/	/ /g" -e "s/  */ /g" |
+	sort >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.14.1.729.g59c0ea183a

