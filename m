Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AFCB20754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761451AbdADSFn (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:05:43 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33877 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756985AbdADSEW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:22 -0500
Received: by mail-pg0-f51.google.com with SMTP id y62so177752582pgy.1
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NdefsS1cbf8EDweNDiJS2mDKc85vu1p8CuIygJuRBE4=;
        b=HAHD+d/ytGlNi0N5Nx/HEnZTpWuiMw0hO4tAoz3OmOCmdTR2YlJeDwI/LAGercOext
         iGrgwbQUlMoJFB6UAxDDQEhVPlZ5eE25NijHmhVuxTkaX3KkMy57IbLdA+ofNBLFkhWu
         QCEvarFpXFYKJYj9jDRI4Zmd5Oa82iFEO0x6qfI1b8Ao+Oaxsp4MiAk6BmdpCXFMnmke
         F1P7ltWvC097UByUkIrSAVvk798/XWq50L+gaEvL1pU66hMsM6x7ytXVHmBJTTrmiOKg
         dLpiTyL1zet8rAqYWxk+4oBafgEu/zmkm2HGFIf7hXZW64t5azgKjxJM/vOfgv3tMaH2
         QFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NdefsS1cbf8EDweNDiJS2mDKc85vu1p8CuIygJuRBE4=;
        b=Z0pjp5qzkd1YIgd8EfbZVHC0HLK1ErKIM9TkCl5Ho1Cm4NoeBT5X9jwLe8xEY7p7bK
         TFcFsdatrLgdSI4Ie2KefCOdjCVgr88Yv+QppuzE4W2vnzarWWacQ0b573J4x3Ybvt2k
         MYdvT25zX3oRDfE/0XOpAhBP9DkLeQlEV3v09qEV2/uFBCP9dZBWF3jDijfUIJa5Ha47
         2Gjf8rVQ1IaFKpvdbj6DJKsEF4XnEndyivJz5lUvC6zXQ1UtlTQdprZ1WXLPKaiT6htY
         hjgt4yI02PEg0zdtAkEzBwT+dS7u1CKONSkooMVbzZgwZyaKLe6Db00UiGfYDhljKPVM
         /+nw==
X-Gm-Message-State: AIkVDXLvxFdZ2Wt0f9mLNLokg/pVcu13ZEjckDc7xuLAJoGq4wbtkv3iCj/pw2cAjt4F+Vc4
X-Received: by 10.84.254.1 with SMTP id b1mr5078753plm.114.1483553061918;
        Wed, 04 Jan 2017 10:04:21 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:20 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 02/16] dir: remove struct path_simplify
Date:   Wed,  4 Jan 2017 10:03:57 -0800
Message-Id: <20170104180411.150000-3-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
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
 dir.c | 179 ++++++++++++++++++++++++++++--------------------------------------
 1 file changed, 76 insertions(+), 103 deletions(-)

diff --git a/dir.c b/dir.c
index bfa8c8a9a..9ae454dde 100644
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
@@ -1349,24 +1344,33 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
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
+	GUARD_PATHSPEC(pathspec,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_MAXDEPTH |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB |
+		       PATHSPEC_ICASE |
+		       PATHSPEC_EXCLUDE);
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
@@ -1380,19 +1384,33 @@ static int simplify_away(const char *path, int pathlen, const struct path_simpli
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
+	GUARD_PATHSPEC(pathspec,
+		       PATHSPEC_FROMTOP |
+		       PATHSPEC_MAXDEPTH |
+		       PATHSPEC_LITERAL |
+		       PATHSPEC_GLOB |
+		       PATHSPEC_ICASE |
+		       PATHSPEC_EXCLUDE);
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
@@ -1460,7 +1478,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  struct untracked_cache_dir *untracked,
 					  struct strbuf *path,
 					  int baselen,
-					  const struct path_simplify *simplify,
+					  const struct pathspec *pathspec,
 					  int dtype, struct dirent *de)
 {
 	int exclude;
@@ -1512,7 +1530,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	case DT_DIR:
 		strbuf_addch(path, '/');
 		return treat_directory(dir, untracked, path->buf, path->len,
-				       baselen, exclude, simplify);
+				       baselen, exclude, pathspec);
 	case DT_REG:
 	case DT_LNK:
 		return exclude ? path_excluded : path_untracked;
@@ -1524,7 +1542,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 					   struct cached_dir *cdir,
 					   struct strbuf *path,
 					   int baselen,
-					   const struct path_simplify *simplify)
+					   const struct pathspec *pathspec)
 {
 	strbuf_setlen(path, baselen);
 	if (!cdir->ucd) {
@@ -1541,7 +1559,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 		 * with check_only set.
 		 */
 		return read_directory_recursive(dir, path->buf, path->len,
-						cdir->ucd, 1, simplify);
+						cdir->ucd, 1, pathspec);
 	/*
 	 * We get path_recurse in the first run when
 	 * directory_exists_in_index() returns index_nonexistent. We
@@ -1556,23 +1574,23 @@ static enum path_treatment treat_path(struct dir_struct *dir,
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
@@ -1703,7 +1721,7 @@ static void close_cached_dir(struct cached_dir *cdir)
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 				    const char *base, int baselen,
 				    struct untracked_cache_dir *untracked, int check_only,
-				    const struct path_simplify *simplify)
+				    const struct pathspec *pathspec)
 {
 	struct cached_dir cdir;
 	enum path_treatment state, subdir_state, dir_state = path_none;
@@ -1719,7 +1737,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 
 	while (!read_cached_dir(&cdir)) {
 		/* check how the file or directory should be treated */
-		state = treat_path(dir, untracked, &cdir, &path, baselen, simplify);
+		state = treat_path(dir, untracked, &cdir, &path,
+				   baselen, pathspec);
 
 		if (state > dir_state)
 			dir_state = state;
@@ -1731,8 +1750,9 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
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
@@ -1756,7 +1776,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
 				((dir->flags & DIR_COLLECT_IGNORED) &&
 				exclude_matches_pathspec(path.buf, path.len,
-					simplify)))
+							 pathspec)))
 				dir_add_ignored(dir, path.buf, path.len);
 			break;
 
@@ -1787,36 +1807,9 @@ static int cmp_name(const void *p1, const void *p2)
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
@@ -1840,9 +1833,9 @@ static int treat_leading_path(struct dir_struct *dir,
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
@@ -2010,33 +2003,14 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
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
@@ -2044,9 +2018,8 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const stru
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

