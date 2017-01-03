Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA30D1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 19:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760779AbdACTJI (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 14:09:08 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33464 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760541AbdACTI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 14:08:59 -0500
Received: by mail-pg0-f42.google.com with SMTP id g1so178517413pgn.0
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 11:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hnuPrKptDqW5Cphp7NurthdjcbSvij+w1A6eXrpO8hs=;
        b=R/s+IR8lRCv4LQR9JUPnLTzOHz91lC2BXCUd188OAIFbAjfEw2zSPILaRQOz+RVgkQ
         cKAtvECtc997oJeyQ7tv8EVIM47lCIPLW6zcNLj0/86dyuODdsQQfgXZN5MYJ2+dRaLq
         qBRFkynQEaj72JBTHO0Ty4W3J6F6Cn8Y63eC+NRDGBSTIEJUgNJGNhjabxZVfEm708aq
         uDNe6xE4XlYk6AFdpvKnJOeKSIkMFbnDIg25jy2JcI78sRJEfByQy2ZGaIrKhdBbLg3a
         keVFsyJGvAAs2GqElFyoN0a8vNn47whefLwgLokrDYKTmzGJUTn5wImIW8FFoYo+ORhp
         ZglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hnuPrKptDqW5Cphp7NurthdjcbSvij+w1A6eXrpO8hs=;
        b=RtXpQPXIOL5uAPLVrlVmjFdu5N1HWw7vRr0VfUlkOd9E6l+bjuQetiuDrzI0h8dXy4
         hXL3WNWZrswGXoAs3XCtE0F9lUQFdEjZBhO+Yl1K/vgSmIz3X1qBXRIspXEm1Wv2Q5Fj
         0AxsZeMvED9caf9YiPGL/STaMDqnX49ugXRobUMI0Mo5BgCbHFwzPFcV5+/W5CKhV716
         ERmOrTf7167w365ywt0nWKS5OISOT1JK6EQhEGUtAM3r0ISDMOgFeN/NuJMOXNGDSHQw
         hO7IaUbmkGGNrOyt0PiufndTcmyB3LpHBuPstoyI0+Lq7CKG6mqk1wuX0jO0FAXRTf3c
         7pkg==
X-Gm-Message-State: AIkVDXJMbpmVJbvMBB3IGLYdrjh4DU+YFTR6j4aVXRqCUrE0B65Ai6TUBmfdCyiIKeHb9991
X-Received: by 10.99.161.2 with SMTP id b2mr119373495pgf.2.1483468980573;
        Tue, 03 Jan 2017 10:43:00 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:42:59 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 02/16] dir: remove struct path_simplify
Date:   Tue,  3 Jan 2017 10:42:27 -0800
Message-Id: <20170103184241.128409-3-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
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
 dir.c | 181 +++++++++++++++++++++++++++++-------------------------------------
 1 file changed, 78 insertions(+), 103 deletions(-)

diff --git a/dir.c b/dir.c
index bfa8c8a9a..1df61f10f 100644
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
@@ -1349,24 +1344,34 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
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
+	if (pathspec)
+		GUARD_PATHSPEC(pathspec,
+			       PATHSPEC_FROMTOP |
+			       PATHSPEC_MAXDEPTH |
+			       PATHSPEC_LITERAL |
+			       PATHSPEC_GLOB |
+			       PATHSPEC_ICASE |
+			       PATHSPEC_EXCLUDE);
+
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
@@ -1380,19 +1385,34 @@ static int simplify_away(const char *path, int pathlen, const struct path_simpli
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
+	if (pathspec)
+		GUARD_PATHSPEC(pathspec,
+			       PATHSPEC_FROMTOP |
+			       PATHSPEC_MAXDEPTH |
+			       PATHSPEC_LITERAL |
+			       PATHSPEC_GLOB |
+			       PATHSPEC_ICASE |
+			       PATHSPEC_EXCLUDE);
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
@@ -1460,7 +1480,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  struct untracked_cache_dir *untracked,
 					  struct strbuf *path,
 					  int baselen,
-					  const struct path_simplify *simplify,
+					  const struct pathspec *pathspec,
 					  int dtype, struct dirent *de)
 {
 	int exclude;
@@ -1512,7 +1532,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	case DT_DIR:
 		strbuf_addch(path, '/');
 		return treat_directory(dir, untracked, path->buf, path->len,
-				       baselen, exclude, simplify);
+				       baselen, exclude, pathspec);
 	case DT_REG:
 	case DT_LNK:
 		return exclude ? path_excluded : path_untracked;
@@ -1524,7 +1544,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 					   struct cached_dir *cdir,
 					   struct strbuf *path,
 					   int baselen,
-					   const struct path_simplify *simplify)
+					   const struct pathspec *pathspec)
 {
 	strbuf_setlen(path, baselen);
 	if (!cdir->ucd) {
@@ -1541,7 +1561,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 		 * with check_only set.
 		 */
 		return read_directory_recursive(dir, path->buf, path->len,
-						cdir->ucd, 1, simplify);
+						cdir->ucd, 1, pathspec);
 	/*
 	 * We get path_recurse in the first run when
 	 * directory_exists_in_index() returns index_nonexistent. We
@@ -1556,23 +1576,23 @@ static enum path_treatment treat_path(struct dir_struct *dir,
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
@@ -1703,7 +1723,7 @@ static void close_cached_dir(struct cached_dir *cdir)
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 				    const char *base, int baselen,
 				    struct untracked_cache_dir *untracked, int check_only,
-				    const struct path_simplify *simplify)
+				    const struct pathspec *pathspec)
 {
 	struct cached_dir cdir;
 	enum path_treatment state, subdir_state, dir_state = path_none;
@@ -1719,7 +1739,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 
 	while (!read_cached_dir(&cdir)) {
 		/* check how the file or directory should be treated */
-		state = treat_path(dir, untracked, &cdir, &path, baselen, simplify);
+		state = treat_path(dir, untracked, &cdir, &path,
+				   baselen, pathspec);
 
 		if (state > dir_state)
 			dir_state = state;
@@ -1731,8 +1752,9 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
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
@@ -1756,7 +1778,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
 				((dir->flags & DIR_COLLECT_IGNORED) &&
 				exclude_matches_pathspec(path.buf, path.len,
-					simplify)))
+							 pathspec)))
 				dir_add_ignored(dir, path.buf, path.len);
 			break;
 
@@ -1787,36 +1809,9 @@ static int cmp_name(const void *p1, const void *p2)
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
@@ -1840,9 +1835,9 @@ static int treat_leading_path(struct dir_struct *dir,
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
@@ -2010,33 +2005,14 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
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
-	if (pathspec)
-		GUARD_PATHSPEC(pathspec,
-			       PATHSPEC_FROMTOP |
-			       PATHSPEC_MAXDEPTH |
-			       PATHSPEC_LITERAL |
-			       PATHSPEC_GLOB |
-			       PATHSPEC_ICASE |
-			       PATHSPEC_EXCLUDE);
-
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
@@ -2044,9 +2020,8 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const stru
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
2.11.0.390.gc69c2f50cf-goog

