Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3EDC433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbiEIR7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239818AbiEIR7G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:59:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4545A2CCD28
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:55:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l18so28291934ejc.7
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kf0HIQpPjHK6hHCwQGpWaMNze/VI/WAp8JC/tUqyk9Y=;
        b=Zz2E6nCvfyaewuTz0fILolrynWHHVLa692S+UuqDYm82G2hyiEjumya1NX59nHO91D
         zv3x2Zd1gC6HVfDbCbbhRe7/yeszCpfbfZ1im9KTZD+nwEhWDXGIQFzMNOj0Qxn3TiHR
         gnWPkfypfHlkvjfeLgTiJqN8jUZ/ULbQR8hYYGuW2KWAvcIlx8OauZ6CbpDPGNKZr8Tt
         dbwztwbZPMBHvfZQsrsV6B/lUHgl1iTwqZQIxGCNUtb4wPNA1VQ2k64pBSFiyq8RFHtc
         prlKsKnwhJ1/pjdOm0DnP/B1+HWTUC9IM0g0mzwhExEPHboKsMvafJO9pOwHRf5JMPRc
         23bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kf0HIQpPjHK6hHCwQGpWaMNze/VI/WAp8JC/tUqyk9Y=;
        b=unIP37mg2lsZlv1T72gaw993jgqxPu0NFEs3f1amKXHw69hWBu613lqIvPV7kMiHV8
         FIaCmom46gFmwKEac52LIcLN0zc5Exdf1rwm8Y+vs7LLAaRrlpj0biK6Ld2CB41TTzD8
         6T4nLTt/f7PMShnG0pEB79tQLpLemaArsCXCgbBV4TWwL9jtRT+EIKCBPKMeuPaAdWgq
         BRmlnMT7fGDuKKZ77gxdgstH50ugmr8/uuLZJXqQR1YJxGiVOKGvBb0gi9xZF/Yv5A1w
         bHzJG/CoEe1CXt62Eaz47H//A1Z9HYUOzdf+2KjjT2ndp8oS/Z5q68/n1yRwXfxZ0ohd
         ++vg==
X-Gm-Message-State: AOAM5315N3s9UOILMTHrkQH+Yek1WRSrJFSWfjIMGlBteireRwYNowz0
        GZjRzAnw+uhy/JKW40XA0hE4emXAxRk=
X-Google-Smtp-Source: ABdhPJwHYmjyJ0NC8OBKxY8Pz9FkXmd6F7UkG3vfXzSijmebgcDVAJ3YCfkgYQ0s8S+FZjQ8DvpVhQ==
X-Received: by 2002:a17:907:7f1f:b0:6fa:2704:c601 with SMTP id qf31-20020a1709077f1f00b006fa2704c601mr6427949ejc.496.1652118909578;
        Mon, 09 May 2022 10:55:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm6552883edt.73.2022.05.09.10.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:55:09 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, avarab@gmail.com,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [PATCH v2 10/15] dir-iterator: refactor dir_iterator_advance()
Date:   Mon,  9 May 2022 20:51:54 +0300
Message-Id: <20220509175159.2948802-11-kioplato@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify dir_iterator_advance() by converting from iterative to
recursive implementation. This conversion makes dir-iterator more
maintainable for the following reasons:
  * dir-iterator iterates the file-system, which is a tree structure.
    Traditionally, tree traversals, in textbooks, lectures and online
    sources are implemented recursively and not iteratively. Therefore
    it helps reduce mental load for readers, since it's easier to follow
    as it reminds of the same tree traversals we use on tree structures.
  * recursion requires one less indentation depth because we get rid of
    the while loop and instead recurse, using the program's stack.
  * in each recursive step a set of instructions are executed and
    recursion lays out the code structurally in a better way, such that
    these instructions stand out symmetrically for each recursive step.

This makes dir-iterator easier to work with, understand and introduce
new functionality, like post-order on some directory entries, because it
reminds us of the same operations we use to traverse tree structures.

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 dir-iterator.c | 223 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 146 insertions(+), 77 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index b17e9f970a..3adcfbc966 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -7,8 +7,7 @@ struct dir_iterator_level {
 	DIR *dir;
 
 	/*
-	 * The length of the directory part of path at this level
-	 * (including a trailing '/'):
+	 * The length of the directory part of path at this level.
 	 */
 	size_t prefix_len;
 };
@@ -34,8 +33,9 @@ struct dir_iterator_int {
 	size_t levels_alloc;
 
 	/*
-	 * A stack of levels. levels[0] is the uppermost directory
-	 * that will be included in this iteration.
+	 * A stack of levels. levels[0] is the root directory.
+	 * It won't be included in the iteration, but iteration will happen
+	 * inside it's subdirectories.
 	 */
 	struct dir_iterator_level *levels;
 
@@ -43,36 +43,63 @@ struct dir_iterator_int {
 	unsigned int flags;
 };
 
+enum {
+	OK,
+	FAIL_ENOENT,
+	FAIL_NOT_ENOENT,
+};
+
 /*
  * Push a level in the iter stack and initialize it with information from
- * the directory pointed by iter->base->path. It is assumed that this
- * strbuf points to a valid directory path. Return 0 on success and -1
- * otherwise, setting errno accordingly and leaving the stack unchanged.
+ * the directory pointed by iter->base->path. Don't open the directory.
+ *
+ * Return 1 on success.
+ * Return 0 when `iter->base->path` isn't a directory.
  */
 static int push_level(struct dir_iterator_int *iter)
 {
 	struct dir_iterator_level *level;
 
+	if (!S_ISDIR(iter->base.st.st_mode))
+		return 0;
+
 	ALLOC_GROW(iter->levels, iter->levels_nr + 1, iter->levels_alloc);
 	level = &iter->levels[iter->levels_nr++];
 
-	if (!is_dir_sep(iter->base.path.buf[iter->base.path.len - 1]))
-		strbuf_addch(&iter->base.path, '/');
+	level->dir = NULL;
+
 	level->prefix_len = iter->base.path.len;
 
-	level->dir = opendir(iter->base.path.buf);
-	if (!level->dir) {
-		int saved_errno = errno;
-		if (errno != ENOENT) {
-			warning_errno("error opening directory '%s'",
-				      iter->base.path.buf);
-		}
-		iter->levels_nr--;
+	return 1;
+}
+
+/*
+ * Activate most recent pushed level. Stack is unchanged.
+ *
+ * Return values:
+ * OK on success.
+ * FAIL_ENOENT on failed exposure because entry does not exist.
+ * FAIL_NOT_ENOENT on failed exposure because of errno other than ENOENT.
+ */
+static int activate_level(struct dir_iterator_int *iter)
+{
+	struct dir_iterator_level *level = &iter->levels[iter->levels_nr - 1];
+	int saved_errno;
+
+	if (level->dir)
+		return OK;
+
+	if ((level->dir = opendir(iter->base.path.buf)) != NULL)
+		return OK;
+
+	saved_errno = errno;
+	if (errno != ENOENT) {
+		warning_errno("error opening directory '%s'", iter->base.path.buf);
 		errno = saved_errno;
-		return -1;
+		return FAIL_NOT_ENOENT;
 	}
-
-	return 0;
+	errno = saved_errno;
+	return FAIL_ENOENT;
 }
 
 /*
@@ -81,12 +108,10 @@ static int push_level(struct dir_iterator_int *iter)
  */
 static int pop_level(struct dir_iterator_int *iter)
 {
-	struct dir_iterator_level *level =
-		&iter->levels[iter->levels_nr - 1];
+	struct dir_iterator_level *level = &iter->levels[iter->levels_nr - 1];
 
 	if (level->dir && closedir(level->dir))
-		warning_errno("error closing directory '%s'",
-			      iter->base.path.buf);
+		warning_errno("error closing directory '%s'", iter->base.path.buf);
 	level->dir = NULL;
 
 	return --iter->levels_nr;
@@ -94,82 +119,119 @@ static int pop_level(struct dir_iterator_int *iter)
 
 /*
  * Populate iter->base with the necessary information on the next iteration
- * entry, represented by the given dirent de. Return 0 on success and -1
- * otherwise, setting errno accordingly.
+ * entry, represented by the given relative path to the lowermost directory,
+ * d_name.
+ *
+ * Return values:
+ * OK on successful exposure of the provided entry.
+ * FAIL_ENOENT on failed exposure because entry does not exist.
+ * FAIL_NOT_ENOENT on failed exposure because of errno other than ENOENT.
  */
-static int prepare_next_entry_data(struct dir_iterator_int *iter,
-				   struct dirent *de)
+static int expose_entry(struct dir_iterator_int *iter, char *d_name)
 {
-	int err, saved_errno;
+	int stat_err;
 
-	strbuf_addstr(&iter->base.path, de->d_name);
-	/*
-	 * We have to reset these because the path strbuf might have
-	 * been realloc()ed at the previous strbuf_addstr().
-	 */
-	iter->base.relative_path = iter->base.path.buf +
-				   iter->levels[0].prefix_len;
-	iter->base.basename = iter->base.path.buf +
-			      iter->levels[iter->levels_nr - 1].prefix_len;
+	strbuf_addch(&iter->base.path, '/');
+	strbuf_addstr(&iter->base.path, d_name);
 
 	if (iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS)
-		err = stat(iter->base.path.buf, &iter->base.st);
+		stat_err = stat(iter->base.path.buf, &iter->base.st);
 	else
-		err = lstat(iter->base.path.buf, &iter->base.st);
+		stat_err = lstat(iter->base.path.buf, &iter->base.st);
 
-	saved_errno = errno;
-	if (err && errno != ENOENT)
+	if (stat_err && errno != ENOENT) {
 		warning_errno("failed to stat '%s'", iter->base.path.buf);
+		return FAIL_NOT_ENOENT;
+	} else if (stat_err && errno == ENOENT) {
+		return FAIL_ENOENT;
+	}
 
-	errno = saved_errno;
-	return err;
+	/*
+	 * We have to reset relative path and basename because the path strbuf
+	 * might have been realloc()'ed at the previous strbuf_addstr().
+	 */
+
+	iter->base.relative_path =
+		iter->base.path.buf + iter->levels[0].prefix_len + 1;
+	iter->base.basename =
+		iter->base.path.buf + iter->levels[iter->levels_nr - 1].prefix_len + 1;
+
+	return OK;
 }
 
 int dir_iterator_advance(struct dir_iterator *dir_iterator)
 {
-	struct dir_iterator_int *iter =
-		(struct dir_iterator_int *)dir_iterator;
+	struct dir_iterator_int *iter = (struct dir_iterator_int *)dir_iterator;
+	struct dir_iterator_level *level = &iter->levels[iter->levels_nr - 1];
+	struct dirent *dir_entry = NULL;
+	int expose_err, activate_err;
+	/* For shorter code width-wise, more readable */
+	unsigned int PEDANTIC = iter->flags & DIR_ITERATOR_PEDANTIC;
 
-	if (S_ISDIR(iter->base.st.st_mode) && push_level(iter)) {
-		if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
-			goto error_out;
-		if (iter->levels_nr == 0)
+	/*
+	 * Attempt to open the directory of the last level if not opened yet.
+	 *
+	 * Remember that we ignore ENOENT errors so that the user of this API
+	 * can remove entries between calls to `dir_iterator_advance()`.
+	 * We care for errors other than ENOENT only when PEDANTIC is enabled.
+	 */
+
+	activate_err = activate_level(iter);
+
+	if (activate_err == FAIL_NOT_ENOENT && PEDANTIC) {
+		goto error_out;
+	} else if (activate_err != OK) {
+		--iter->levels_nr;
+
+		if (iter->levels_nr == 0)  /* Failed to open root directory */
 			goto error_out;
+
+		return dir_iterator_advance(dir_iterator);
 	}
 
-	/* Loop until we find an entry that we can give back to the caller. */
-	while (1) {
-		struct dirent *de;
-		struct dir_iterator_level *level =
-			&iter->levels[iter->levels_nr - 1];
+	strbuf_setlen(&iter->base.path, level->prefix_len);
+
+	errno = 0;
+	dir_entry = readdir(level->dir);
+
+	if (!dir_entry) {
+		if (errno) {
+			warning_errno("errno reading dir '%s'", iter->base.path.buf);
+			if (PEDANTIC)
+				goto error_out;
 
-		strbuf_setlen(&iter->base.path, level->prefix_len);
-		errno = 0;
-		de = readdir(level->dir);
-
-		if (!de) {
-			if (errno) {
-				warning_errno("error reading directory '%s'",
-					      iter->base.path.buf);
-				if (iter->flags & DIR_ITERATOR_PEDANTIC)
-					goto error_out;
-			} else if (pop_level(iter) == 0) {
+			return dir_iterator_advance(dir_iterator);
+		} else {
+			/*
+			 * Current directory has been iterated through.
+			 */
+
+			if (pop_level(iter) == 0)
 				return dir_iterator_abort(dir_iterator);
-			}
-			continue;
+
+			return dir_iterator_advance(dir_iterator);
 		}
+	}
 
-		if (is_dot_or_dotdot(de->d_name))
-			continue;
+	if (is_dot_or_dotdot(dir_entry->d_name))
+		return dir_iterator_advance(dir_iterator);
 
-		if (prepare_next_entry_data(iter, de)) {
-			if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
-				goto error_out;
-			continue;
-		}
+	/*
+	 * Successfully read entry from current directory level.
+	 */
 
-		return ITER_OK;
-	}
+	expose_err = expose_entry(iter, dir_entry->d_name);
+
+	if (expose_err == FAIL_NOT_ENOENT && PEDANTIC)
+		goto error_out;
+
+	if (expose_err == OK)
+		push_level(iter);
+
+	if (expose_err != OK)
+		return dir_iterator_advance(dir_iterator);
+
+	return ITER_OK;
 
 error_out:
 	dir_iterator_abort(dir_iterator);
@@ -207,6 +269,8 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)
 
 	strbuf_init(&iter->base.path, PATH_MAX);
 	strbuf_addstr(&iter->base.path, path);
+	/* expose_entry() appends dir seperator before exposing an entry */
+	strbuf_trim_trailing_dir_sep(&iter->base.path);
 
 	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
 	iter->levels_nr = 0;
@@ -226,6 +290,11 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)
 		goto error_out;
 	}
 
+	if (!push_level(iter)) {
+		saved_errno = ENOTDIR;
+		goto error_out;
+	}
+
 	return dir_iterator;
 
 error_out:
-- 
2.36.1

