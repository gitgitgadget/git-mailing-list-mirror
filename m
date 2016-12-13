Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFBBA20451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbcLMXPp (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:15:45 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34807 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbcLMXPo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:15:44 -0500
Received: by mail-pf0-f177.google.com with SMTP id c4so312960pfb.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 15:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cdd+jPdxljydMo7ixSsvLnNywtEfRe5naod1f8DHL4Q=;
        b=eprrvR1MQR8pp9ND5LbYV6Goeh9M19WlnyTFPppX3sr3FO/MpC1/q/rmevK2QD6Oe9
         z114n3xnmxCnaBvvuVVPDeSxX4U0j0h7E7jTJsh0suGH9WQ6kMmQ6TSvr+vN/BWL6Mg7
         KB2zqdLDKuiPbYawhXCM0sJr9W58RmCPwGtPJegz1CNw3dMyUNEp1Ifuhby3kplV6tT2
         9Z5J5vKvuzTsNdPO102z2mjsHseChV6OXQjvjshBiGiiAwCqVFDuCs3qHWFWpYT+jw6Q
         CdoEbjjlksHoisipeKkNTNLXUDh8OfQF2Pzx9lMrcZULiiKFkG5L6lyoUhOmOxEvXtdA
         /QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cdd+jPdxljydMo7ixSsvLnNywtEfRe5naod1f8DHL4Q=;
        b=Wr0PWakBvwwh2dUQVoPMMPdoJTN+vUS/RWuaCSAMlm+PKiQJUErJ6YuTNElJ/0sc2+
         fjv5Rkqh3UIV3+G+9g0uOf8AcYMYcJkgtvZ/cFwtGkDh4ActWMXoBzrNr1SkRq9cPcT7
         g0PwI3N3kc+KPnS7AsnBUbQifDg6YH0geA6LpPyx3WVgh8bbwXuCZoxR4oNBj9EbHFSe
         eQ+K9F4nLU4X5ftkxw26LK/feEvCJ0BiFvftOTko3yAO+aGPpFSYpKMIiDG8Ts8kBUbs
         qRJf9zF660lwREbBkc10tTtKrOaWbEtleKg4HiPn1oq6eMZXRTPg+3oLFcB/y7hQXMFc
         Xu7Q==
X-Gm-Message-State: AKaTC03P3j/a9xW1fFPC2NPQqwcQRj+XUTOc/h0GpT1FZ4wS09QTq7ff/N0KhQHkYNh9EwgR
X-Received: by 10.99.146.76 with SMTP id s12mr179201480pgn.8.1481670882590;
        Tue, 13 Dec 2016 15:14:42 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id c15sm82308567pfd.36.2016.12.13.15.14.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 15:14:41 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 02/16] dir: remove struct path_simplify
Date:   Tue, 13 Dec 2016 15:14:16 -0800
Message-Id: <1481670870-66754-3-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481670870-66754-1-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach simplify_away() and exclude_matches_pathspec() to handle struct
pathspec directly, eliminating the need for the struct path_simplify.

Also renamed the len parameter to pathlen in exclude_matches_pathspec()
to match the parameter names used in simplify_away().

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c | 154 ++++++++++++++++++++++++++----------------------------------------
 1 file changed, 60 insertions(+), 94 deletions(-)

diff --git a/dir.c b/dir.c
index bfa8c8a..aadf073 100644
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
@@ -1312,7 +1307,7 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
 static enum path_treatment treat_directory(struct dir_struct *dir,
 	struct untracked_cache_dir *untracked,
 	const char *dirname, int len, int baselen, int exclude,
-	const struct path_simplify *simplify)
+	const struct pathspec *pathspec)
 {
 	/* The "len-1" is to strip the final '/' */
 	switch (directory_exists_in_index(dirname, len-1)) {
@@ -1341,7 +1336,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	untracked = lookup_untracked(dir->untracked, untracked,
 				     dirname + baselen, len - baselen);
 	return read_directory_recursive(dir, dirname, len,
-					untracked, 1, simplify);
+					untracked, 1, pathspec);
 }
 
 /*
@@ -1349,24 +1344,25 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
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
@@ -1380,19 +1376,25 @@ static int simplify_away(const char *path, int pathlen, const struct path_simpli
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
@@ -1460,7 +1462,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  struct untracked_cache_dir *untracked,
 					  struct strbuf *path,
 					  int baselen,
-					  const struct path_simplify *simplify,
+					  const struct pathspec *pathspec,
 					  int dtype, struct dirent *de)
 {
 	int exclude;
@@ -1512,7 +1514,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	case DT_DIR:
 		strbuf_addch(path, '/');
 		return treat_directory(dir, untracked, path->buf, path->len,
-				       baselen, exclude, simplify);
+				       baselen, exclude, pathspec);
 	case DT_REG:
 	case DT_LNK:
 		return exclude ? path_excluded : path_untracked;
@@ -1524,7 +1526,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 					   struct cached_dir *cdir,
 					   struct strbuf *path,
 					   int baselen,
-					   const struct path_simplify *simplify)
+					   const struct pathspec *pathspec)
 {
 	strbuf_setlen(path, baselen);
 	if (!cdir->ucd) {
@@ -1541,7 +1543,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 		 * with check_only set.
 		 */
 		return read_directory_recursive(dir, path->buf, path->len,
-						cdir->ucd, 1, simplify);
+						cdir->ucd, 1, pathspec);
 	/*
 	 * We get path_recurse in the first run when
 	 * directory_exists_in_index() returns index_nonexistent. We
@@ -1556,23 +1558,23 @@ static enum path_treatment treat_path(struct dir_struct *dir,
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
@@ -1703,7 +1705,7 @@ static void close_cached_dir(struct cached_dir *cdir)
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 				    const char *base, int baselen,
 				    struct untracked_cache_dir *untracked, int check_only,
-				    const struct path_simplify *simplify)
+				    const struct pathspec *pathspec)
 {
 	struct cached_dir cdir;
 	enum path_treatment state, subdir_state, dir_state = path_none;
@@ -1719,7 +1721,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 
 	while (!read_cached_dir(&cdir)) {
 		/* check how the file or directory should be treated */
-		state = treat_path(dir, untracked, &cdir, &path, baselen, simplify);
+		state = treat_path(dir, untracked, &cdir, &path,
+				   baselen, pathspec);
 
 		if (state > dir_state)
 			dir_state = state;
@@ -1731,8 +1734,9 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
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
@@ -1756,7 +1760,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
 				((dir->flags & DIR_COLLECT_IGNORED) &&
 				exclude_matches_pathspec(path.buf, path.len,
-					simplify)))
+							 pathspec)))
 				dir_add_ignored(dir, path.buf, path.len);
 			break;
 
@@ -1787,36 +1791,9 @@ static int cmp_name(const void *p1, const void *p2)
 	return name_compare(e1->name, e1->len, e2->name, e2->len);
 }
 
-static struct path_simplify *create_simplify(const char **pathspec)
-{
-	int nr, alloc = 0;
-	struct path_simplify *simplify = NULL;
-
-	if (!pathspec)
-		return NULL;
-
-	for (nr = 0 ; ; nr++) {
-		const char *match;
-		ALLOC_GROW(simplify, nr + 1, alloc);
-		match = *pathspec++;
-		if (!match)
-			break;
-		simplify[nr].path = match;
-		simplify[nr].len = simple_length(match);
-	}
-	simplify[nr].path = NULL;
-	simplify[nr].len = 0;
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
@@ -1840,9 +1817,9 @@ static int treat_leading_path(struct dir_struct *dir,
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
@@ -2010,14 +1987,11 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
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
@@ -2030,13 +2004,6 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const stru
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
 
-	/*
-	 * exclude patterns are treated like positive ones in
-	 * create_simplify. Usually exclude patterns should be a
-	 * subset of positive ones, which has no impacts on
-	 * create_simplify().
-	 */
-	simplify = create_simplify(pathspec ? pathspec->_raw : NULL);
 	untracked = validate_untracked_cache(dir, len, pathspec);
 	if (!untracked)
 		/*
@@ -2044,9 +2011,8 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const stru
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
-- 
2.8.0.rc3.226.g39d4020

