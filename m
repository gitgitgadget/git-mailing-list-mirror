Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA0B207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755673AbdEETyG (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:54:06 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33438 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdEETyD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:54:03 -0400
Received: by mail-pf0-f178.google.com with SMTP id q20so7143144pfg.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C3PmfaSStyS2aOmmStkEwwX5KzWjEjOKcoZnbnFJjn8=;
        b=jEL/uRSJErnLeWohnXPNydcSYqOKs/rDLq20bBkGdxV9rOmEKlAdHs4cGo8VidMfEP
         6YEZ7bN0f4aASJBxbIf9LzAg5DAbzYDNf+nUtMY+gxpwBKsgWO0sE3XLFqZOaLh1UJKb
         BN2hn2ltTldPN2TZI1cJmdQJX0YHIsNS9Ad1fByaq4aGDsNNfILz2+lXzQrbC7kumyjz
         VylfBhN+u+1bIpBRjQ+3TH+UmPHmqdEnXmjAUjOm06tgyKKJpWkJjyguxt2ypl8VOju1
         Q5hkrwSAkKmLENYGCYAAl2+B0g8m3nLeY1DjFblZFTMyZwjbpPdcmfDWEwpPATAY/CDz
         C2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C3PmfaSStyS2aOmmStkEwwX5KzWjEjOKcoZnbnFJjn8=;
        b=BaVXrTWIAo9Shhd0bPOoDEXh8zSaCiOprsXkAR4b2HOSYl/2FCBDUz+8X/IryI+PRO
         8mFtc0781cozF1K97JvWxXe7nhSG/AhYmRIVpewutb+VycdA6prDQTPMxC6M56d4tnmy
         o2IJBnsRckCfer8+nRdG7PzD1zH8GsVhG4OolGpMnIutRHZbyj9HXdAhPhyiSEExpYAz
         hZOdwjqz8FPZoWajsgUlW/UyQWSeNwIORN/UvwRZOlwyQRUGwp7mQwoqy50oTJ7wFlXI
         2mlOJroA4NG49Dgzm9FXMRrYzTtJi9H6DieS2I2mJliJXtPdYJTZJYDBTbs1RzEK2tMH
         Fa0w==
X-Gm-Message-State: AN3rC/5pWErtM/RJSxCEaxWoDjF76YrKcrT7ykclguFqRBKEO6SCsQSW
        sIbc6adqB3/RaFs0
X-Received: by 10.98.53.134 with SMTP id c128mr18740505pfa.252.1494014042723;
        Fri, 05 May 2017 12:54:02 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm12395967pfb.24.2017.05.05.12.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 12:54:01 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 12/14] dir: convert read_directory_recursive to take an index
Date:   Fri,  5 May 2017 12:53:32 -0700
Message-Id: <20170505195334.121856-13-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170505195334.121856-1-bmwill@google.com>
References: <20170505195334.121856-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c | 52 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/dir.c b/dir.c
index f08d30ee4..3318ebbcb 100644
--- a/dir.c
+++ b/dir.c
@@ -46,7 +46,8 @@ struct cached_dir {
 };
 
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
-	const char *path, int len, struct untracked_cache_dir *untracked,
+	struct index_state *istate, const char *path, int len,
+	struct untracked_cache_dir *untracked,
 	int check_only, const struct pathspec *pathspec);
 static int get_dtype(struct dirent *de, struct index_state *istate,
 		     const char *path, int len);
@@ -1362,12 +1363,13 @@ static enum exist_status directory_exists_in_index(struct index_state *istate,
  *  (c) otherwise, we recurse into it.
  */
 static enum path_treatment treat_directory(struct dir_struct *dir,
+	struct index_state *istate,
 	struct untracked_cache_dir *untracked,
 	const char *dirname, int len, int baselen, int exclude,
 	const struct pathspec *pathspec)
 {
 	/* The "len-1" is to strip the final '/' */
-	switch (directory_exists_in_index(&the_index, dirname, len-1)) {
+	switch (directory_exists_in_index(istate, dirname, len-1)) {
 	case index_directory:
 		return path_recurse;
 
@@ -1392,7 +1394,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 
 	untracked = lookup_untracked(dir->untracked, untracked,
 				     dirname + baselen, len - baselen);
-	return read_directory_recursive(dir, dirname, len,
+	return read_directory_recursive(dir, istate, dirname, len,
 					untracked, 1, pathspec);
 }
 
@@ -1536,16 +1538,17 @@ static int get_dtype(struct dirent *de, struct index_state *istate,
 
 static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  struct untracked_cache_dir *untracked,
+					  struct index_state *istate,
 					  struct strbuf *path,
 					  int baselen,
 					  const struct pathspec *pathspec,
 					  int dtype, struct dirent *de)
 {
 	int exclude;
-	int has_path_in_index = !!index_file_exists(&the_index, path->buf, path->len, ignore_case);
+	int has_path_in_index = !!index_file_exists(istate, path->buf, path->len, ignore_case);
 
 	if (dtype == DT_UNKNOWN)
-		dtype = get_dtype(de, &the_index, path->buf, path->len);
+		dtype = get_dtype(de, istate, path->buf, path->len);
 
 	/* Always exclude indexed files */
 	if (dtype != DT_DIR && has_path_in_index)
@@ -1572,10 +1575,10 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	if ((dir->flags & DIR_COLLECT_KILLED_ONLY) &&
 	    (dtype == DT_DIR) &&
 	    !has_path_in_index &&
-	    (directory_exists_in_index(&the_index, path->buf, path->len) == index_nonexistent))
+	    (directory_exists_in_index(istate, path->buf, path->len) == index_nonexistent))
 		return path_none;
 
-	exclude = is_excluded(dir, &the_index, path->buf, &dtype);
+	exclude = is_excluded(dir, istate, path->buf, &dtype);
 
 	/*
 	 * Excluded? If we don't explicitly want to show
@@ -1589,7 +1592,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		return path_none;
 	case DT_DIR:
 		strbuf_addch(path, '/');
-		return treat_directory(dir, untracked, path->buf, path->len,
+		return treat_directory(dir, istate, untracked, path->buf, path->len,
 				       baselen, exclude, pathspec);
 	case DT_REG:
 	case DT_LNK:
@@ -1600,6 +1603,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 static enum path_treatment treat_path_fast(struct dir_struct *dir,
 					   struct untracked_cache_dir *untracked,
 					   struct cached_dir *cdir,
+					   struct index_state *istate,
 					   struct strbuf *path,
 					   int baselen,
 					   const struct pathspec *pathspec)
@@ -1618,7 +1622,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 		 * to its bottom. Verify again the same set of directories
 		 * with check_only set.
 		 */
-		return read_directory_recursive(dir, path->buf, path->len,
+		return read_directory_recursive(dir, istate, path->buf, path->len,
 						cdir->ucd, 1, pathspec);
 	/*
 	 * We get path_recurse in the first run when
@@ -1632,6 +1636,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 static enum path_treatment treat_path(struct dir_struct *dir,
 				      struct untracked_cache_dir *untracked,
 				      struct cached_dir *cdir,
+				      struct index_state *istate,
 				      struct strbuf *path,
 				      int baselen,
 				      const struct pathspec *pathspec)
@@ -1640,7 +1645,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 	struct dirent *de = cdir->de;
 
 	if (!de)
-		return treat_path_fast(dir, untracked, cdir, path,
+		return treat_path_fast(dir, untracked, cdir, istate, path,
 				       baselen, pathspec);
 	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
 		return path_none;
@@ -1650,7 +1655,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 		return path_none;
 
 	dtype = DTYPE(de);
-	return treat_one_path(dir, untracked, path, baselen, pathspec, dtype, de);
+	return treat_one_path(dir, untracked, istate, path, baselen, pathspec, dtype, de);
 }
 
 static void add_untracked(struct untracked_cache_dir *dir, const char *name)
@@ -1781,9 +1786,9 @@ static void close_cached_dir(struct cached_dir *cdir)
  * Returns the most significant path_treatment value encountered in the scan.
  */
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
-				    const char *base, int baselen,
-				    struct untracked_cache_dir *untracked, int check_only,
-				    const struct pathspec *pathspec)
+	struct index_state *istate, const char *base, int baselen,
+	struct untracked_cache_dir *untracked, int check_only,
+	const struct pathspec *pathspec)
 {
 	struct cached_dir cdir;
 	enum path_treatment state, subdir_state, dir_state = path_none;
@@ -1791,7 +1796,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 
 	strbuf_add(&path, base, baselen);
 
-	if (open_cached_dir(&cdir, dir, untracked, &the_index, &path, check_only))
+	if (open_cached_dir(&cdir, dir, untracked, istate, &path, check_only))
 		goto out;
 
 	if (untracked)
@@ -1799,7 +1804,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 
 	while (!read_cached_dir(&cdir)) {
 		/* check how the file or directory should be treated */
-		state = treat_path(dir, untracked, &cdir, &path,
+		state = treat_path(dir, untracked, &cdir, istate, &path,
 				   baselen, pathspec);
 
 		if (state > dir_state)
@@ -1812,7 +1817,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 					      path.buf + baselen,
 					      path.len - baselen);
 			subdir_state =
-				read_directory_recursive(dir, path.buf,
+				read_directory_recursive(dir, istate, path.buf,
 							 path.len, ud,
 							 check_only, pathspec);
 			if (subdir_state > dir_state)
@@ -1834,18 +1839,18 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		switch (state) {
 		case path_excluded:
 			if (dir->flags & DIR_SHOW_IGNORED)
-				dir_add_name(dir, &the_index, path.buf, path.len);
+				dir_add_name(dir, istate, path.buf, path.len);
 			else if ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
 				((dir->flags & DIR_COLLECT_IGNORED) &&
 				exclude_matches_pathspec(path.buf, path.len,
 							 pathspec)))
-				dir_add_ignored(dir, &the_index, path.buf, path.len);
+				dir_add_ignored(dir, istate, path.buf, path.len);
 			break;
 
 		case path_untracked:
 			if (dir->flags & DIR_SHOW_IGNORED)
 				break;
-			dir_add_name(dir, &the_index, path.buf, path.len);
+			dir_add_name(dir, istate, path.buf, path.len);
 			if (cdir.fdir)
 				add_untracked(untracked, path.buf + baselen);
 			break;
@@ -1870,6 +1875,7 @@ static int cmp_name(const void *p1, const void *p2)
 }
 
 static int treat_leading_path(struct dir_struct *dir,
+			      struct index_state *istate,
 			      const char *path, int len,
 			      const struct pathspec *pathspec)
 {
@@ -1897,7 +1903,7 @@ static int treat_leading_path(struct dir_struct *dir,
 			break;
 		if (simplify_away(sb.buf, sb.len, pathspec))
 			break;
-		if (treat_one_path(dir, NULL, &sb, baselen, pathspec,
+		if (treat_one_path(dir, NULL, istate, &sb, baselen, pathspec,
 				   DT_DIR, NULL) == path_none)
 			break; /* do not recurse into it */
 		if (len <= baselen) {
@@ -2080,8 +2086,8 @@ int read_directory(struct dir_struct *dir, const char *path,
 		 * e.g. prep_exclude()
 		 */
 		dir->untracked = NULL;
-	if (!len || treat_leading_path(dir, path, len, pathspec))
-		read_directory_recursive(dir, path, len, untracked, 0, pathspec);
+	if (!len || treat_leading_path(dir, &the_index, path, len, pathspec))
+		read_directory_recursive(dir, &the_index, path, len, untracked, 0, pathspec);
 	QSORT(dir->entries, dir->nr, cmp_name);
 	QSORT(dir->ignored, dir->ignored_nr, cmp_name);
 	if (dir->untracked) {
-- 
2.13.0.rc1.294.g07d810a77f-goog

