Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6BCC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 10:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiBXKJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiBXKJg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 05:09:36 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE6128A111
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:09:00 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d5-20020a623605000000b004e01ccd08abso1081518pfa.10
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jMKFFMj25zrRdrj/VKq4uwdhmkhAO9UMRLTmQPqt2tU=;
        b=n1ZL6MCee0yoExu89Dzs+M82uezz4UW/J718DRkEeK4tTvQg2wdMJ2C/UBPME6GzeL
         XcjNHNYY2uNb7URGwQjf5/byWxdTCKq9x2ejLPRSFUWVVzUDrBeVPU3ymmQj0WniHWHU
         QfZbJxkqBLY1wBk4f1vF4GEkuIArnWUCIouXpFfbqVFMY9pRU4XPV/7gQ/02ollqIwES
         gNnvDOrloo6NpGQKIqQJU+IznRE3DnvuJKeEs1/c9M0GScCSrnHUMkOswoMnWFnj0zdr
         i5kW+LOemp46biwkbLwCzMEatbGKHrtpJte7JBRIUnnbYkc8MK80FdP6rcFDnFopomZE
         lQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jMKFFMj25zrRdrj/VKq4uwdhmkhAO9UMRLTmQPqt2tU=;
        b=YVDZ8liiRQ9OyOuhbWjjgwXyvAIh0cj7PpZ5Z7AWWvTD46oCeQ3hqp2OoblT1cfl6G
         6MUAPiUORi7smVSEUAc8DiMHpaZ7sfdlPf/Gha3e+SSiigpbfN2jYu2O4jgqYxfs315y
         LfObTN1UtVvzFP5vpy3UrQYfYquJG0U7vfLKKNs/Z78p1WhEtZSje4qExwJ72tUViN9Y
         tp8fqk9hBv+uErXjr5Os/ufW/Q3HlzMYsVtNOQwiLY1H5uHWHRznjaqrMipMy+7rOgz3
         WdElKLhQ0GS15nnBPJO48INfd16juYBkosHKfdJy2qdiwfPWxsCoJ5OPFlT2f48vevGq
         7guw==
X-Gm-Message-State: AOAM533tracxvvJ9hwy/ttzAXuec/3r/aGiHAvMvNywMbpSRpiSK1fKl
        FP/9st0hWn9xwp7J/VdZ38Ls1RMLwNNrGcQUJC/rXGH8+0arbKCy0xVzAmBbJ/zBBlIx6OaQQ3F
        vcz8GJjKtNC1S4V8GwO32IvXnlaokR7Qc5/gziJysOZUtjcweNIZ7d4qdhGxr1hA=
X-Google-Smtp-Source: ABdhPJxgkKi5sxuvSFhI7kIP9okH9A8vR/8GTsqqS7WeckM0UIeIq+jP3tJ0MzzeCtMIsyj76pFZlQ16OzjP9w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:ab08:b0:1b9:c59:82c3 with SMTP id
 m8-20020a17090aab0800b001b90c5982c3mr13622946pjq.95.1645697340075; Thu, 24
 Feb 2022 02:09:00 -0800 (PST)
Date:   Thu, 24 Feb 2022 18:08:36 +0800
In-Reply-To: <20220224100842.95827-1-chooglen@google.com>
Message-Id: <20220224100842.95827-5-chooglen@google.com>
Mime-Version: 1.0
References: <20220215172318.73533-1-chooglen@google.com> <20220224100842.95827-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v3 04/10] submodule: make static functions read submodules
 from commits
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future commit will teach "fetch --recurse-submodules" to fetch
unpopulated submodules. To prepare for this, teach the necessary static
functions how to read submodules from superproject commits using a
"treeish_name" argument (instead of always reading from the index and
filesystem) but do not actually change where submodules are read from.
Submodules will be read from commits when we fetch unpopulated
submodules.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5ace18a7d9..4f3300f2cb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -932,6 +932,7 @@ struct has_commit_data {
 	struct repository *repo;
 	int result;
 	const char *path;
+	const struct object_id *super_oid;
 };
 
 static int check_has_commit(const struct object_id *oid, void *data)
@@ -940,7 +941,7 @@ static int check_has_commit(const struct object_id *oid, void *data)
 	struct repository subrepo;
 	enum object_type type;
 
-	if (repo_submodule_init(&subrepo, cb->repo, cb->path, null_oid())) {
+	if (repo_submodule_init(&subrepo, cb->repo, cb->path, cb->super_oid)) {
 		cb->result = 0;
 		goto cleanup;
 	}
@@ -968,9 +969,15 @@ static int check_has_commit(const struct object_id *oid, void *data)
 
 static int submodule_has_commits(struct repository *r,
 				 const char *path,
+				 const struct object_id *super_oid,
 				 struct oid_array *commits)
 {
-	struct has_commit_data has_commit = { r, 1, path };
+	struct has_commit_data has_commit = {
+		.repo = r,
+		.result = 1,
+		.path = path,
+		.super_oid = super_oid
+	};
 
 	/*
 	 * Perform a cheap, but incorrect check for the existence of 'commits'.
@@ -1017,7 +1024,7 @@ static int submodule_needs_pushing(struct repository *r,
 				   const char *path,
 				   struct oid_array *commits)
 {
-	if (!submodule_has_commits(r, path, commits))
+	if (!submodule_has_commits(r, path, null_oid(), commits))
 		/*
 		 * NOTE: We do consider it safe to return "no" here. The
 		 * correct answer would be "We do not know" instead of
@@ -1277,7 +1284,7 @@ static void calculate_changed_submodule_paths(struct repository *r,
 		if (!path)
 			continue;
 
-		if (submodule_has_commits(r, path, commits)) {
+		if (submodule_has_commits(r, path, null_oid(), commits)) {
 			oid_array_clear(commits);
 			*name->string = '\0';
 		}
@@ -1402,12 +1409,13 @@ static const struct submodule *get_non_gitmodules_submodule(const char *path)
 }
 
 static struct fetch_task *fetch_task_create(struct repository *r,
-					    const char *path)
+					    const char *path,
+					    const struct object_id *treeish_name)
 {
 	struct fetch_task *task = xmalloc(sizeof(*task));
 	memset(task, 0, sizeof(*task));
 
-	task->sub = submodule_from_path(r, null_oid(), path);
+	task->sub = submodule_from_path(r, treeish_name, path);
 	if (!task->sub) {
 		/*
 		 * No entry in .gitmodules? Technically not a submodule,
@@ -1439,11 +1447,12 @@ static void fetch_task_release(struct fetch_task *p)
 }
 
 static struct repository *get_submodule_repo_for(struct repository *r,
-						 const char *path)
+						 const char *path,
+						 const struct object_id *treeish_name)
 {
 	struct repository *ret = xmalloc(sizeof(*ret));
 
-	if (repo_submodule_init(ret, r, path, null_oid())) {
+	if (repo_submodule_init(ret, r, path, treeish_name)) {
 		free(ret);
 		return NULL;
 	}
@@ -1464,7 +1473,7 @@ static int get_next_submodule(struct child_process *cp,
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		task = fetch_task_create(spf->r, ce->name);
+		task = fetch_task_create(spf->r, ce->name, null_oid());
 		if (!task)
 			continue;
 
@@ -1487,7 +1496,7 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		task->repo = get_submodule_repo_for(spf->r, task->sub->path);
+		task->repo = get_submodule_repo_for(spf->r, task->sub->path, null_oid());
 		if (task->repo) {
 			struct strbuf submodule_prefix = STRBUF_INIT;
 			child_process_init(cp);
-- 
2.33.GIT

