Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F657C10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 19:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F953206E6
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 19:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdqK3Vdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCFTDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:03:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38003 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCFTDY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 14:03:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id t11so3608683wrw.5
        for <git@vger.kernel.org>; Fri, 06 Mar 2020 11:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ofn1JNXuv3OylaEmTMzUn8cJEc8hW3pMfkKO94Pmv5w=;
        b=bdqK3VdjIRZffYruaszR0JJaYYcXtAQ2KW90w9bp6BzuOHhYaphv8WmEYVogVRFpAA
         sLG+57YbGO5lEVPNibMQHam0LXVGZBEpI/ZbmQb1dAE10SZ2hxJ7H6kNp63TB5Y61Swo
         BjMqtQ4iaaaKsUTqZ9dIbq9hM2g9MJy4wYqDrmtowl+tunjajTutmINoWYb1HdEkTxxZ
         MjZHGFP+fFMmcjKkV6+JPakUvC4uCD46pXrjxT9HKBgaY8EwfFypvwHhxZxwO2dK1qff
         FHIPInJnFTFVxb1JQfnNd6evtPD3vyFSZieUsPixlEFFpjSepuWTjZCQJk1+cauu+78s
         bxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ofn1JNXuv3OylaEmTMzUn8cJEc8hW3pMfkKO94Pmv5w=;
        b=AsOuW5oYbJY/VuM/s+u6F4G58uWKmBm1VEuyUQ9vt7TARifCGMVFgC4BUwgmYGpbJV
         aYx+eF/CG2WYc79LBHTM098c/T9YgGpAcVjTXpRGvMS9KIk87XN+JO1W9Gmv89rQp+0N
         3twDJB8Is4qfYoFyw0lnKYjbtFXe2YdF7Hk2XgDqie69xtumlLaiOHAuYCDjg0jbhu0p
         jlckVFy4mTvNsUvt1s5SXpZW0fDlDTslfVBDW17MsP7FHkJe+6PsWN0Q5twumg6gGEZ9
         4la7OT/+/jDQYAhpwAF689hXsGy3PYzIOUmgBXxMAaD/hgLxdO9V5726KTg/PQ/uZV3G
         9B1A==
X-Gm-Message-State: ANhLgQ1ACHnqVXrGBvMaGbgAOOle3vjcMhI8icdOSIDvhr+tq2336xZk
        Pu8JCmU7f9Ry/lBIDQfIdmstlzeu
X-Google-Smtp-Source: ADFU+vtrOdytv3DO9pzoLcFrzyOmur24FRL+k7n9xtYPM8SmLeB7cMJxAu41+Dg+FwdvMZvzxyr9RQ==
X-Received: by 2002:a5d:4ac8:: with SMTP id y8mr5270090wrs.272.1583521400256;
        Fri, 06 Mar 2020 11:03:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm15357440wmc.27.2020.03.06.11.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 11:03:19 -0800 (PST)
Message-Id: <59af49ad9f6b2ffc87e350f9bc00d233f2a9010f.1583521396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.575.git.1583521396.gitgitgadget@gmail.com>
References: <pull.575.git.1583521396.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Mar 2020 19:03:15 +0000
Subject: [PATCH 3/4] real_path_if_valid(): remove unsafe API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

This commit continues the work started with previous commit.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 abspath.c   | 10 ----------
 cache.h     |  1 -
 setup.c     |  2 +-
 sha1-file.c | 13 ++++---------
 submodule.c |  7 ++++---
 worktree.c  |  8 ++++++--
 6 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/abspath.c b/abspath.c
index d34026bfeb8..6f15a418bb6 100644
--- a/abspath.c
+++ b/abspath.c
@@ -202,16 +202,6 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 	return retval;
 }
 
-/*
- * Resolve `path` into an absolute, cleaned-up path. The return value
- * comes from a shared buffer.
- */
-const char *real_path_if_valid(const char *path)
-{
-	static struct strbuf realpath = STRBUF_INIT;
-	return strbuf_realpath(&realpath, path, 0);
-}
-
 char *real_pathdup(const char *path, int die_on_error)
 {
 	struct strbuf realpath = STRBUF_INIT;
diff --git a/cache.h b/cache.h
index f6937793ec2..aa3f5ce718a 100644
--- a/cache.h
+++ b/cache.h
@@ -1314,7 +1314,6 @@ static inline int is_absolute_path(const char *path)
 int is_directory(const char *);
 char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
-const char *real_path_if_valid(const char *path);
 char *real_pathdup(const char *path, int die_on_error);
 const char *absolute_path(const char *path);
 char *absolute_pathdup(const char *path);
diff --git a/setup.c b/setup.c
index 19dded55788..d319f499d6b 100644
--- a/setup.c
+++ b/setup.c
@@ -888,7 +888,7 @@ static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_
 
 /*
  * A "string_list_each_func_t" function that canonicalizes an entry
- * from GIT_CEILING_DIRECTORIES using real_path_if_valid(), or
+ * from GIT_CEILING_DIRECTORIES using real_pathdup(), or
  * discards it if unusable.  The presence of an empty entry in
  * GIT_CEILING_DIRECTORIES turns off canonicalization for all
  * subsequent entries.
diff --git a/sha1-file.c b/sha1-file.c
index 616886799e5..f2b24654895 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -676,20 +676,15 @@ void add_to_alternates_memory(const char *reference)
 char *compute_alternate_path(const char *path, struct strbuf *err)
 {
 	char *ref_git = NULL;
-	const char *repo, *ref_git_s;
+	const char *repo;
 	int seen_error = 0;
 
-	ref_git_s = real_path_if_valid(path);
-	if (!ref_git_s) {
+	ref_git = real_pathdup(path, 0);
+	if (!ref_git) {
 		seen_error = 1;
 		strbuf_addf(err, _("path '%s' does not exist"), path);
 		goto out;
-	} else
-		/*
-		 * Beware: read_gitfile(), real_path() and mkpath()
-		 * return static buffer
-		 */
-		ref_git = xstrdup(ref_git_s);
+	}
 
 	repo = read_gitfile(ref_git);
 	if (!repo)
diff --git a/submodule.c b/submodule.c
index bad7a788c06..215c62580fc 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2173,7 +2173,7 @@ const char *get_superproject_working_tree(void)
 	static struct strbuf realpath = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
-	const char *one_up = real_path_if_valid("../");
+	struct strbuf one_up = STRBUF_INIT;
 	const char *cwd = xgetcwd();
 	const char *ret = NULL;
 	const char *subpath;
@@ -2188,10 +2188,11 @@ const char *get_superproject_working_tree(void)
 		 */
 		return NULL;
 
-	if (!one_up)
+	if (!strbuf_realpath(&one_up, "../", 0))
 		return NULL;
 
-	subpath = relative_path(cwd, one_up, &sb);
+	subpath = relative_path(cwd, one_up.buf, &sb);
+	strbuf_release(&one_up);
 
 	prepare_submodule_repo_env(&cp.env_array);
 	argv_array_pop(&cp.env_array);
diff --git a/worktree.c b/worktree.c
index e7bbf716f6b..2a340fa939b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -226,17 +226,21 @@ struct worktree *find_worktree(struct worktree **list,
 
 struct worktree *find_worktree_by_path(struct worktree **list, const char *p)
 {
+	struct strbuf wt_path = STRBUF_INIT;
 	char *path = real_pathdup(p, 0);
 
 	if (!path)
 		return NULL;
 	for (; *list; list++) {
-		const char *wt_path = real_path_if_valid((*list)->path);
+		strbuf_reset(&wt_path);
+		if (!strbuf_realpath(&wt_path, (*list)->path, 0))
+			continue;
 
-		if (wt_path && !fspathcmp(path, wt_path))
+		if (!fspathcmp(path, wt_path.buf))
 			break;
 	}
 	free(path);
+	strbuf_release(&wt_path);
 	return *list;
 }
 
-- 
gitgitgadget

