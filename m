Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AC2C4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 04:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB21613CC
	for <git@archiver.kernel.org>; Thu, 27 May 2021 04:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhE0Ezh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 00:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbhE0Eze (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 00:55:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6710BC061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 21:54:01 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z130so1909424wmg.2
        for <git@vger.kernel.org>; Wed, 26 May 2021 21:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P7151K4V61vzADltVOc4YEKRtV4mpoiurigAaABdcUU=;
        b=t+KM92EWSY1Sf3rG66lX0Vwm0DgE/AjsuUXzjuSrgNhbeNjYF6s+FDcQNOO6y9kC3G
         /q5SrMQ/oB0zjDSTmiuD9Gzc+wzgw7j3ETYjFQzKZo3QGjLUc3vKNwJos5lpi0bFu9cf
         rnY4u5B4CGkZkLvfhlUjXUTWMWIcxPDbHDmspHgMYc4FkRB9Ls1KFP9NgVPHlobo01d1
         Z9EgawQtprb+EcV/40C6SP7qc4QaaJHAKaExA0Hmom1aJT7qXsK40VKByIZsuMe+WUch
         DVtNlU6cT2t0SXJDgXTFUi7XJ4Je/s5/4HM6dlPzjsAgB7FTmpt4twxyBmjO3VoiKVdr
         5flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P7151K4V61vzADltVOc4YEKRtV4mpoiurigAaABdcUU=;
        b=hSo4Ubq7CbHeXfTl3gx4npMEM9mk5SAg7GgIr+ZXnA2f8u0w5jcJ5e/FBpYEY7f7Wf
         RmkdffcltzpALX3hKoMYIe2r4HOC9KVxmbLODPyKUBrNQaRIgyrEcoWNxPG05DANUm3f
         B6GEA9Y6pQzKZheXSe7KPF27majMW0l+cCZs2rcSWZiYN7uOjVDpiI8IAUcQavBXHeXC
         4Pnf15PPPpl7Wcv2lZQgL4FNcAqFoXoICRgMIMvJqXWFjR2Uc2cjKco0Yiusj4xiKH/i
         vif2uuSXztFIzyuh7IIB3ROgIst4Hh37BzzqabU8r8YupjrfrTuc6yohaW8Zlc3uED2K
         /i4w==
X-Gm-Message-State: AOAM532M1NwwSrJjFuvDRi7UcB7tMiZw2faMy4xZqnaq544vJXy6PJ55
        tvRfchOINfq+KMEW/dCW/poVYpODvFI=
X-Google-Smtp-Source: ABdhPJxI76Xba5u+oARzGxmOvsHZq28YwvNTui+670yemet+2ZeycWSQDRdatfWXvO1bTIKvYnIptQ==
X-Received: by 2002:a05:600c:4e8c:: with SMTP id f12mr1434258wmq.187.1622091240016;
        Wed, 26 May 2021 21:54:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f20sm1436130wmh.41.2021.05.26.21.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 21:53:59 -0700 (PDT)
Message-Id: <970fad21c0286fb716b38a332f9704784aa6cf8f.1622091237.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.961.git.1622091237.gitgitgadget@gmail.com>
References: <pull.961.git.1622091237.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 May 2021 04:53:56 +0000
Subject: [PATCH 2/2] dir: introduce readdir_skip_dot_and_dotdot() helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Many places in the code were doing
    while ((d = readdir(dir)) != NULL) {
        if (is_dot_or_dotdot(d->d_name))
            continue;
        ...process d...
    }
Introduce a readdir_skip_dot_and_dotdot() helper to make that a one-liner:
    while ((d = readdir_skip_dot_and_dotdot(dir)) != NULL) {
        ...process d...
    }

This helper particularly simplifies checks for empty directories.

Also use this helper in read_cached_dir() so that our statistics are
consistent across platforms.  (In other words, read_cached_dir() should
have been using is_dot_or_dotdot() and skipping such entries, but did
not and left it to treat_path() to detect and mark such entries as
path_none.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c    |  4 +---
 builtin/worktree.c |  4 +---
 diff-no-index.c    |  5 ++---
 dir.c              | 25 ++++++++++++++++---------
 dir.h              |  2 ++
 entry.c            |  5 +----
 notes-merge.c      |  5 +----
 object-file.c      |  4 +---
 packfile.c         |  5 +----
 rerere.c           |  4 +---
 worktree.c         | 12 +++---------
 11 files changed, 30 insertions(+), 45 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 995053b79173..a1a57476153b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -189,10 +189,8 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	strbuf_complete(path, '/');
 
 	len = path->len;
-	while ((e = readdir(dir)) != NULL) {
+	while ((e = readdir_skip_dot_and_dotdot(dir)) != NULL) {
 		struct stat st;
-		if (is_dot_or_dotdot(e->d_name))
-			continue;
 
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1cd5c2016e3f..e081ca9befd1 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -118,10 +118,8 @@ static void prune_worktrees(void)
 	struct dirent *d;
 	if (!dir)
 		return;
-	while ((d = readdir(dir)) != NULL) {
+	while ((d = readdir_skip_dot_and_dotdot(dir)) != NULL) {
 		char *path;
-		if (is_dot_or_dotdot(d->d_name))
-			continue;
 		strbuf_reset(&reason);
 		if (should_prune_worktree(d->d_name, &reason, &path, expire))
 			prune_worktree(d->d_name, reason.buf);
diff --git a/diff-no-index.c b/diff-no-index.c
index 7814eabfe028..e5cc87837143 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -26,9 +26,8 @@ static int read_directory_contents(const char *path, struct string_list *list)
 	if (!(dir = opendir(path)))
 		return error("Could not open directory %s", path);
 
-	while ((e = readdir(dir)))
-		if (!is_dot_or_dotdot(e->d_name))
-			string_list_insert(list, e->d_name);
+	while ((e = readdir_skip_dot_and_dotdot(dir)))
+		string_list_insert(list, e->d_name);
 
 	closedir(dir);
 	return 0;
diff --git a/dir.c b/dir.c
index ff004b298b2a..b909cf9b03da 100644
--- a/dir.c
+++ b/dir.c
@@ -59,6 +59,17 @@ void dir_init(struct dir_struct *dir)
 	memset(dir, 0, sizeof(*dir));
 }
 
+struct dirent *readdir_skip_dot_and_dotdot(DIR *dirp)
+{
+	struct dirent *e;
+
+	while ((e = readdir(dirp)) != NULL) {
+		if (!is_dot_or_dotdot(e->d_name))
+			break;
+	}
+	return e;
+}
+
 int count_slashes(const char *s)
 {
 	int cnt = 0;
@@ -2332,7 +2343,7 @@ static int read_cached_dir(struct cached_dir *cdir)
 	struct dirent *de;
 
 	if (cdir->fdir) {
-		de = readdir(cdir->fdir);
+		de = readdir_skip_dot_and_dotdot(cdir->fdir);
 		if (!de) {
 			cdir->d_name = NULL;
 			cdir->d_type = DT_UNKNOWN;
@@ -2931,11 +2942,9 @@ int is_empty_dir(const char *path)
 	if (!dir)
 		return 0;
 
-	while ((e = readdir(dir)) != NULL)
-		if (!is_dot_or_dotdot(e->d_name)) {
-			ret = 0;
-			break;
-		}
+	e = readdir_skip_dot_and_dotdot(dir);
+	if (e)
+		ret = 0;
 
 	closedir(dir);
 	return ret;
@@ -2975,10 +2984,8 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	strbuf_complete(path, '/');
 
 	len = path->len;
-	while ((e = readdir(dir)) != NULL) {
+	while ((e = readdir_skip_dot_and_dotdot(dir)) != NULL) {
 		struct stat st;
-		if (is_dot_or_dotdot(e->d_name))
-			continue;
 
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
diff --git a/dir.h b/dir.h
index 70c750e3053d..6b3fac082945 100644
--- a/dir.h
+++ b/dir.h
@@ -342,6 +342,8 @@ struct dir_struct {
 	unsigned visited_directories;
 };
 
+struct dirent *readdir_skip_dot_and_dotdot(DIR *dirp);
+
 /*Count the number of slashes for string s*/
 int count_slashes(const char *s);
 
diff --git a/entry.c b/entry.c
index 7b9f43716f76..e3d3add30007 100644
--- a/entry.c
+++ b/entry.c
@@ -56,12 +56,9 @@ static void remove_subtree(struct strbuf *path)
 
 	if (!dir)
 		die_errno("cannot opendir '%s'", path->buf);
-	while ((de = readdir(dir)) != NULL) {
+	while ((de = readdir_skip_dot_and_dotdot(dir)) != NULL) {
 		struct stat st;
 
-		if (is_dot_or_dotdot(de->d_name))
-			continue;
-
 		strbuf_addch(path, '/');
 		strbuf_addstr(path, de->d_name);
 		if (lstat(path->buf, &st))
diff --git a/notes-merge.c b/notes-merge.c
index d2771fa3d43c..e9d6f86d3428 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -695,13 +695,10 @@ int notes_merge_commit(struct notes_merge_options *o,
 
 	strbuf_addch(&path, '/');
 	baselen = path.len;
-	while ((e = readdir(dir)) != NULL) {
+	while ((e = readdir_skip_dot_and_dotdot(dir)) != NULL) {
 		struct stat st;
 		struct object_id obj_oid, blob_oid;
 
-		if (is_dot_or_dotdot(e->d_name))
-			continue;
-
 		if (get_oid_hex(e->d_name, &obj_oid)) {
 			if (o->verbosity >= 3)
 				printf("Skipping non-SHA1 entry '%s%s'\n",
diff --git a/object-file.c b/object-file.c
index 624af408cdcd..77bdcfd21bc8 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2304,10 +2304,8 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	strbuf_addch(path, '/');
 	baselen = path->len;
 
-	while ((de = readdir(dir))) {
+	while ((de = readdir_skip_dot_and_dotdot(dir))) {
 		size_t namelen;
-		if (is_dot_or_dotdot(de->d_name))
-			continue;
 
 		namelen = strlen(de->d_name);
 		strbuf_setlen(path, baselen);
diff --git a/packfile.c b/packfile.c
index ea29f4ba7735..463d61c87761 100644
--- a/packfile.c
+++ b/packfile.c
@@ -813,10 +813,7 @@ void for_each_file_in_pack_dir(const char *objdir,
 	}
 	strbuf_addch(&path, '/');
 	dirnamelen = path.len;
-	while ((de = readdir(dir)) != NULL) {
-		if (is_dot_or_dotdot(de->d_name))
-			continue;
-
+	while ((de = readdir_skip_dot_and_dotdot(dir)) != NULL) {
 		strbuf_setlen(&path, dirnamelen);
 		strbuf_addstr(&path, de->d_name);
 
diff --git a/rerere.c b/rerere.c
index dee60dc6df63..d83d58df4fbc 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1190,13 +1190,11 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	if (!dir)
 		die_errno(_("unable to open rr-cache directory"));
 	/* Collect stale conflict IDs ... */
-	while ((e = readdir(dir))) {
+	while ((e = readdir_skip_dot_and_dotdot(dir))) {
 		struct rerere_dir *rr_dir;
 		struct rerere_id id;
 		int now_empty;
 
-		if (is_dot_or_dotdot(e->d_name))
-			continue;
 		if (!is_rr_cache_dirname(e->d_name))
 			continue; /* or should we remove e->d_name? */
 
diff --git a/worktree.c b/worktree.c
index f35ac40a84a5..237517baee67 100644
--- a/worktree.c
+++ b/worktree.c
@@ -128,10 +128,8 @@ struct worktree **get_worktrees(void)
 	dir = opendir(path.buf);
 	strbuf_release(&path);
 	if (dir) {
-		while ((d = readdir(dir)) != NULL) {
+		while ((d = readdir_skip_dot_and_dotdot(dir)) != NULL) {
 			struct worktree *linked = NULL;
-			if (is_dot_or_dotdot(d->d_name))
-				continue;
 
 			if ((linked = get_linked_worktree(d->d_name))) {
 				ALLOC_GROW(list, counter + 1, alloc);
@@ -486,13 +484,9 @@ int submodule_uses_worktrees(const char *path)
 	if (!dir)
 		return 0;
 
-	while ((d = readdir(dir)) != NULL) {
-		if (is_dot_or_dotdot(d->d_name))
-			continue;
-
+	d = readdir_skip_dot_and_dotdot(dir);
+	if (d != NULL)
 		ret = 1;
-		break;
-	}
 	closedir(dir);
 	return ret;
 }
-- 
gitgitgadget
