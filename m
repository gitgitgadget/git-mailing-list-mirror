Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56E6820451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbcLMXPq (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:15:46 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34804 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbcLMXPo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:15:44 -0500
Received: by mail-pf0-f173.google.com with SMTP id c4so312800pfb.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 15:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xU0rt3y1faZrkKS8A016aVo9uMYmPU1/Hi+xMvzdQrE=;
        b=PXbsHBGsy2eLVfhLavhkILvnzTQT9qDkQMBztOYzqqlV1rgucX+PxzSZK3PlhJJNzi
         et2hyjI7EJl5OwZajF9L+twksBvyHIS8FAJd8pArOuzqwnHkKKm6+wYYnxxnA1/sjsRf
         2G3bzYImEa91DBXzZ+bQDpvbIuecq0BshH6HU3YCwN9OU5yFQVcHFzicForiojCPylHx
         le/ZqsWQByguL7jNWdWGD79uPJo1FH8sJCze+NOnMoV4d+hISBIMg75nng8UzOvuo2sT
         rO/X2wveUlo9UP3FkGDr7FUtqmFJCudl3zROZMBtKJ4PD6Cbo1siHF5ls18mhbKVI3ZY
         nZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xU0rt3y1faZrkKS8A016aVo9uMYmPU1/Hi+xMvzdQrE=;
        b=chlYpRtTBpPWsXw4uTEfhoPXVC0SoJWeU6976UDcM6kJN5fkiMV18TB+Qock/P4Rri
         kqbIYwgjt4ucQLUD1Vmk/wMiFRgC8uTdcYmIltBSv0TkFWknwl6JslOr4NS2wz+alrdN
         j6ledyN+miCDiKokalgnVdVtK2HTwXPReTmqFYad61kTFQyV8T1/A+9gfBBqpQmPLimr
         pVXrBpkJOidXFwsbQIxhzGfcB9COxsn4Rd6XSNR/VHwt7p/coIkSsDuufA8hlhNXuV+h
         ynecEjfUEr8PXQ1A2X4m+s7k3bLVfmupDN3vMeeok8r0TaZE4qEowr1lc3Gqvv9a3iNi
         xszQ==
X-Gm-Message-State: AKaTC01mgR8vZSMglFXaKDcasMfu8DUL8Gcqzjh3gxj8tsvL+xHR+fHVUsmmcOPicpDQjlAD
X-Received: by 10.99.242.5 with SMTP id v5mr177266452pgh.181.1481670879089;
        Tue, 13 Dec 2016 15:14:39 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id c15sm82308567pfd.36.2016.12.13.15.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 15:14:37 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 00/16] pathspec cleanup
Date:   Tue, 13 Dec 2016 15:14:14 -0800
Message-Id: <1481670870-66754-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Differences in v3:
* more readable strip submodule slash helper function which conforms to git's
  style guide. [14/16]
* instead of having create_simply() use struct pathspec directly, remove the
  struct path_simplify entirely and use struct pathspec directly in both
  simplify_away() and exclude_matches_pathspec(). [02/16]
* small style issues corrected from v2. [15/16]

Brandon Williams (16):
  mv: remove use of deprecated 'get_pathspec()'
  dir: remove struct path_simplify
  dir: convert fill_directory to use the pathspec struct interface
  ls-tree: convert show_recursive to use the pathspec struct interface
  pathspec: remove the deprecated get_pathspec function
  pathspec: copy and free owned memory
  pathspec: remove unused variable from unsupported_magic
  pathspec: always show mnemonic and name in unsupported_magic
  pathspec: simpler logic to prefix original pathspec elements
  pathspec: factor global magic into its own function
  pathspec: create parse_short_magic function
  pathspec: create parse_long_magic function
  pathspec: create parse_element_magic helper
  pathspec: create strip submodule slash helpers
  pathspec: small readability changes
  pathspec: rename prefix_pathspec to init_pathspec_item

 Documentation/technical/api-setup.txt |   2 -
 builtin/ls-tree.c                     |  16 +-
 builtin/mv.c                          |  50 ++--
 cache.h                               |   1 -
 dir.c                                 | 166 +++++-------
 pathspec.c                            | 476 +++++++++++++++++++---------------
 pathspec.h                            |   5 +-
 7 files changed, 369 insertions(+), 347 deletions(-)

--- interdiff on 'origin/bw/pathspec-cleanup'

diff --git a/dir.c b/dir.c
index a50b6f0..15f7c99 100644
--- a/dir.c
+++ b/dir.c
@@ -16,11 +16,6 @@
 #include "varint.h"
 #include "ewah/ewok.h"
 
-struct path_simplify {
-	int len;
-	const char *path;
-};
-
 /*
  * Tells read_directory_recursive how a file or directory should be treated.
  * Values are ordered by significance, e.g. if a directory contains both
@@ -50,7 +45,7 @@ struct cached_dir {
 
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	const char *path, int len, struct untracked_cache_dir *untracked,
-	int check_only, const struct path_simplify *simplify);
+	int check_only, const struct pathspec *pathspec);
 static int get_dtype(struct dirent *de, const char *path, int len);
 
 int fspathcmp(const char *a, const char *b)
@@ -1316,7 +1311,7 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
 static enum path_treatment treat_directory(struct dir_struct *dir,
 	struct untracked_cache_dir *untracked,
 	const char *dirname, int len, int baselen, int exclude,
-	const struct path_simplify *simplify)
+	const struct pathspec *pathspec)
 {
 	/* The "len-1" is to strip the final '/' */
 	switch (directory_exists_in_index(dirname, len-1)) {
@@ -1345,7 +1340,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	untracked = lookup_untracked(dir->untracked, untracked,
 				     dirname + baselen, len - baselen);
 	return read_directory_recursive(dir, dirname, len,
-					untracked, 1, simplify);
+					untracked, 1, pathspec);
 }
 
 /*
@@ -1353,24 +1348,25 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
  * reading - if the path cannot possibly be in the pathspec,
  * return true, and we'll skip it early.
  */
-static int simplify_away(const char *path, int pathlen, const struct path_simplify *simplify)
+static int simplify_away(const char *path, int pathlen,
+			 const struct pathspec *pathspec)
 {
-	if (simplify) {
-		for (;;) {
-			const char *match = simplify->path;
-			int len = simplify->len;
+	int i;
 
-			if (!match)
-				break;
-			if (len > pathlen)
-				len = pathlen;
-			if (!memcmp(path, match, len))
-				return 0;
-			simplify++;
-		}
-		return 1;
+	if (!pathspec || !pathspec->nr)
+		return 0;
+
+	for (i = 0; i < pathspec->nr; i++) {
+		const struct pathspec_item *item = &pathspec->items[i];
+		int len = item->nowildcard_len;
+
+		if (len > pathlen)
+			len = pathlen;
+		if (!ps_strncmp(item, item->match, path, len))
+			return 0;
 	}
-	return 0;
+
+	return 1;
 }
 
 /*
@@ -1384,19 +1380,25 @@ static int simplify_away(const char *path, int pathlen, const struct path_simpli
  *   2. the path is a directory prefix of some element in the
  *      pathspec
  */
-static int exclude_matches_pathspec(const char *path, int len,
-		const struct path_simplify *simplify)
-{
-	if (simplify) {
-		for (; simplify->path; simplify++) {
-			if (len == simplify->len
-			    && !memcmp(path, simplify->path, len))
-				return 1;
-			if (len < simplify->len
-			    && simplify->path[len] == '/'
-			    && !memcmp(path, simplify->path, len))
-				return 1;
-		}
+static int exclude_matches_pathspec(const char *path, int pathlen,
+				    const struct pathspec *pathspec)
+{
+	int i;
+
+	if (!pathspec || !pathspec->nr)
+		return 0;
+
+	for (i = 0; i < pathspec->nr; i++) {
+		const struct pathspec_item *item = &pathspec->items[i];
+		int len = item->nowildcard_len;
+
+		if (len == pathlen &&
+		    !ps_strncmp(item, item->match, path, pathlen))
+			return 1;
+		if (len > pathlen &&
+		    item->match[pathlen] == '/' &&
+		    !ps_strncmp(item, item->match, path, pathlen))
+			return 1;
 	}
 	return 0;
 }
@@ -1464,7 +1466,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  struct untracked_cache_dir *untracked,
 					  struct strbuf *path,
 					  int baselen,
-					  const struct path_simplify *simplify,
+					  const struct pathspec *pathspec,
 					  int dtype, struct dirent *de)
 {
 	int exclude;
@@ -1516,7 +1518,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	case DT_DIR:
 		strbuf_addch(path, '/');
 		return treat_directory(dir, untracked, path->buf, path->len,
-				       baselen, exclude, simplify);
+				       baselen, exclude, pathspec);
 	case DT_REG:
 	case DT_LNK:
 		return exclude ? path_excluded : path_untracked;
@@ -1528,7 +1530,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 					   struct cached_dir *cdir,
 					   struct strbuf *path,
 					   int baselen,
-					   const struct path_simplify *simplify)
+					   const struct pathspec *pathspec)
 {
 	strbuf_setlen(path, baselen);
 	if (!cdir->ucd) {
@@ -1545,7 +1547,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 		 * with check_only set.
 		 */
 		return read_directory_recursive(dir, path->buf, path->len,
-						cdir->ucd, 1, simplify);
+						cdir->ucd, 1, pathspec);
 	/*
 	 * We get path_recurse in the first run when
 	 * directory_exists_in_index() returns index_nonexistent. We
@@ -1560,23 +1562,23 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 				      struct cached_dir *cdir,
 				      struct strbuf *path,
 				      int baselen,
-				      const struct path_simplify *simplify)
+				      const struct pathspec *pathspec)
 {
 	int dtype;
 	struct dirent *de = cdir->de;
 
 	if (!de)
 		return treat_path_fast(dir, untracked, cdir, path,
-				       baselen, simplify);
+				       baselen, pathspec);
 	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
 		return path_none;
 	strbuf_setlen(path, baselen);
 	strbuf_addstr(path, de->d_name);
-	if (simplify_away(path->buf, path->len, simplify))
+	if (simplify_away(path->buf, path->len, pathspec))
 		return path_none;
 
 	dtype = DTYPE(de);
-	return treat_one_path(dir, untracked, path, baselen, simplify, dtype, de);
+	return treat_one_path(dir, untracked, path, baselen, pathspec, dtype, de);
 }
 
 static void add_untracked(struct untracked_cache_dir *dir, const char *name)
@@ -1707,7 +1709,7 @@ static void close_cached_dir(struct cached_dir *cdir)
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 				    const char *base, int baselen,
 				    struct untracked_cache_dir *untracked, int check_only,
-				    const struct path_simplify *simplify)
+				    const struct pathspec *pathspec)
 {
 	struct cached_dir cdir;
 	enum path_treatment state, subdir_state, dir_state = path_none;
@@ -1723,7 +1725,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 
 	while (!read_cached_dir(&cdir)) {
 		/* check how the file or directory should be treated */
-		state = treat_path(dir, untracked, &cdir, &path, baselen, simplify);
+		state = treat_path(dir, untracked, &cdir, &path,
+				   baselen, pathspec);
 
 		if (state > dir_state)
 			dir_state = state;
@@ -1735,8 +1738,9 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 					      path.buf + baselen,
 					      path.len - baselen);
 			subdir_state =
-				read_directory_recursive(dir, path.buf, path.len,
-							 ud, check_only, simplify);
+				read_directory_recursive(dir, path.buf,
+							 path.len, ud,
+							 check_only, pathspec);
 			if (subdir_state > dir_state)
 				dir_state = subdir_state;
 		}
@@ -1760,7 +1764,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
 				((dir->flags & DIR_COLLECT_IGNORED) &&
 				exclude_matches_pathspec(path.buf, path.len,
-					simplify)))
+							 pathspec)))
 				dir_add_ignored(dir, path.buf, path.len);
 			break;
 
@@ -1791,35 +1795,9 @@ static int cmp_name(const void *p1, const void *p2)
 	return name_compare(e1->name, e1->len, e2->name, e2->len);
 }
 
-static struct path_simplify *create_simplify(const struct pathspec *pathspec)
-{
-	int i;
-	struct path_simplify *simplify = NULL;
-
-	if (!pathspec || !pathspec->nr)
-		return NULL;
-
-	ALLOC_ARRAY(simplify, pathspec->nr + 1);
-	for (i = 0; i < pathspec->nr; i++) {
-		const char *match;
-		match = pathspec->items[i].match;
-		simplify[i].path = match;
-		simplify[i].len = pathspec->items[i].nowildcard_len;
-	}
-	simplify[i].path = NULL;
-	simplify[i].len = 0;
-
-	return simplify;
-}
-
-static void free_simplify(struct path_simplify *simplify)
-{
-	free(simplify);
-}
-
 static int treat_leading_path(struct dir_struct *dir,
 			      const char *path, int len,
-			      const struct path_simplify *simplify)
+			      const struct pathspec *pathspec)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int baselen, rc = 0;
@@ -1843,9 +1821,9 @@ static int treat_leading_path(struct dir_struct *dir,
 		strbuf_add(&sb, path, baselen);
 		if (!is_directory(sb.buf))
 			break;
-		if (simplify_away(sb.buf, sb.len, simplify))
+		if (simplify_away(sb.buf, sb.len, pathspec))
 			break;
-		if (treat_one_path(dir, NULL, &sb, baselen, simplify,
+		if (treat_one_path(dir, NULL, &sb, baselen, pathspec,
 				   DT_DIR, NULL) == path_none)
 			break; /* do not recurse into it */
 		if (len <= baselen) {
@@ -2013,14 +1991,11 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 	return root;
 }
 
-int read_directory(struct dir_struct *dir, const char *path, int len, const struct pathspec *pathspec)
+int read_directory(struct dir_struct *dir, const char *path,
+		   int len, const struct pathspec *pathspec)
 {
-	struct path_simplify *simplify;
 	struct untracked_cache_dir *untracked;
 
-	/*
-	 * Check out create_simplify()
-	 */
 	if (pathspec)
 		GUARD_PATHSPEC(pathspec,
 			       PATHSPEC_FROMTOP |
@@ -2033,13 +2008,6 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const stru
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
 
-	/*
-	 * exclude patterns are treated like positive ones in
-	 * create_simplify. Usually exclude patterns should be a
-	 * subset of positive ones, which has no impacts on
-	 * create_simplify().
-	 */
-	simplify = create_simplify(pathspec);
 	untracked = validate_untracked_cache(dir, len, pathspec);
 	if (!untracked)
 		/*
@@ -2047,9 +2015,8 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const stru
 		 * e.g. prep_exclude()
 		 */
 		dir->untracked = NULL;
-	if (!len || treat_leading_path(dir, path, len, simplify))
-		read_directory_recursive(dir, path, len, untracked, 0, simplify);
-	free_simplify(simplify);
+	if (!len || treat_leading_path(dir, path, len, pathspec))
+		read_directory_recursive(dir, path, len, untracked, 0, pathspec);
 	QSORT(dir->entries, dir->nr, cmp_name);
 	QSORT(dir->ignored, dir->ignored_nr, cmp_name);
 	if (dir->untracked) {
diff --git a/pathspec.c b/pathspec.c
index cabc02e..d4efcf6 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -67,11 +67,11 @@ static struct pathspec_magic {
 	char mnemonic; /* this cannot be ':'! */
 	const char *name;
 } pathspec_magic[] = {
-	{ PATHSPEC_FROMTOP, '/', "top" },
+	{ PATHSPEC_FROMTOP,  '/', "top" },
 	{ PATHSPEC_LITERAL, '\0', "literal" },
-	{ PATHSPEC_GLOB,   '\0', "glob" },
-	{ PATHSPEC_ICASE,  '\0', "icase" },
-	{ PATHSPEC_EXCLUDE, '!', "exclude" },
+	{ PATHSPEC_GLOB,    '\0', "glob" },
+	{ PATHSPEC_ICASE,   '\0', "icase" },
+	{ PATHSPEC_EXCLUDE,  '!', "exclude" },
 };
 
 static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
@@ -260,13 +260,13 @@ static const char *parse_element_magic(unsigned *magic, int *prefix_len,
 
 static void strip_submodule_slash_cheap(struct pathspec_item *item)
 {
-	int i;
+	if (item->len >= 1 && item->match[item->len - 1] == '/') {
+		int i = cache_name_pos(item->match, item->len - 1);
 
-	if ((item->len >= 1 && item->match[item->len - 1] == '/') &&
-	    (i = cache_name_pos(item->match, item->len - 1)) >= 0 &&
-	    S_ISGITLINK(active_cache[i]->ce_mode)) {
-		item->len--;
-		item->match[item->len] = '\0';
+		if (i >= 0 && S_ISGITLINK(active_cache[i]->ce_mode)) {
+			item->len--;
+			item->match[item->len] = '\0';
+		}
 	}
 }
 
-- 
2.8.0.rc3.226.g39d4020

