Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19050C4161D
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB6361166
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbhELRo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347769AbhELR3n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 13:29:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428FAC06174A
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d11so24426664wrw.8
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T2Wc+qGui5R3S+fz9nrVYTg7kI8koX4nP8maaIStcus=;
        b=qXRdOIkxuZei4HXtsW+VlxeG01w8Oy1KO8OoUEUXwhFfDLaxTUBj/JEx7JY+bFVjS2
         1Scw9Jm3NC8Xyjrlh0soCDfwTb2yiCiii+/Ep7f56HSJrC5iCtC9u4DL6kgBf8SB1kne
         shduQiUJb5V/CUeWb6q3b609XdCKfF7goVW0mbsCE/5B5e5AYJ74tieRN2k4JlTfWJv5
         WIWJ4Pi42TOHmvpSGZ4FocX65XKqdDSgiJQZXrUz+m6p6ezw3AMbFmArugKvcDqxtOjC
         dmvaFs1pVNjsJdn2eQv4uS9k+HeCCiJ7tnFFtWuDPUbpUi2Sv2U6/1pCRl4BpPSMIZrw
         IG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T2Wc+qGui5R3S+fz9nrVYTg7kI8koX4nP8maaIStcus=;
        b=FIx5dgr01H/0ArmNws1asKr+8EzQTOOi36SpFm6MwW85vJ0f2RgxcL3Krqi7dt10KG
         IOMW7l4ooSjHrp98f5XAwGKN1NbeFuexJ9KJbFvlfdjQMVkRq3T9QlnRCC7GwqUoMdtJ
         iCZwegMTpIDi6us71m+NtMZszSMmIzJ4wajmw/DtL7ixs1tgep+e4HvCE6jKlZy6m6hr
         Rh530P/7n4f3oDeSI3U113IauyofvFFQ65lUYXEqQVlRBVHYaddMOUWgQt6ozggtCXHo
         eyfWrZ1bypeWoKCiYEGgYXPR9aN4mChc7hTiRrpSAXW+dAmNpY/3T4SYeEDVSjE13nYS
         JYTQ==
X-Gm-Message-State: AOAM533vl8NOC+t1wcbcQvQlxKnj5/WhwpfsxGAds8jGfgwquQn/z9+K
        rVWCoZY4Ba8Wgjqa9sUZ0BSEtVXxeD4=
X-Google-Smtp-Source: ABdhPJzmiJ0ddH8FE5SKUQkAZWsxVbVz3nPW+tnlJfOiMUw6bAOqkKPx8tVRKi+5v7rEByToMetknw==
X-Received: by 2002:adf:e9c2:: with SMTP id l2mr45541705wrn.323.1620840513051;
        Wed, 12 May 2021 10:28:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11sm297225wrm.62.2021.05.12.10.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:28:32 -0700 (PDT)
Message-Id: <b7c6176560bda67e146d0402f927180dace534a2.1620840502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
        <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 May 2021 17:28:22 +0000
Subject: [PATCH v5 9/9] dir: introduce readdir_skip_dot_and_dotdot() helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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
 dir.c              | 26 +++++++++++++++++---------
 dir.h              |  2 ++
 entry.c            |  5 +----
 notes-merge.c      |  5 +----
 object-file.c      |  4 +---
 packfile.c         |  5 +----
 rerere.c           |  4 +---
 worktree.c         | 12 +++---------
 11 files changed, 31 insertions(+), 45 deletions(-)

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
index 877145349381..ae28249e0f0b 100644
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
index 4794c822b47f..66c8518947dd 100644
--- a/dir.c
+++ b/dir.c
@@ -59,6 +59,18 @@ void dir_init(struct dir_struct *dir)
 	memset(dir, 0, sizeof(*dir));
 }
 
+struct dirent *
+readdir_skip_dot_and_dotdot(DIR *dirp)
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
@@ -2341,7 +2353,7 @@ static int read_cached_dir(struct cached_dir *cdir)
 	struct dirent *de;
 
 	if (cdir->fdir) {
-		de = readdir(cdir->fdir);
+		de = readdir_skip_dot_and_dotdot(cdir->fdir);
 		if (!de) {
 			cdir->d_name = NULL;
 			cdir->d_type = DT_UNKNOWN;
@@ -2940,11 +2952,9 @@ int is_empty_dir(const char *path)
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
@@ -2984,10 +2994,8 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
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
index 22c67907f689..a704e466afd5 100644
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
index 2dc94ba5cc2a..6da589696770 100644
--- a/entry.c
+++ b/entry.c
@@ -57,12 +57,9 @@ static void remove_subtree(struct strbuf *path)
 
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
index 8668345d9309..7c8f1b7202ca 100644
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
