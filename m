Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F009AC433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 17:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242481AbiBORYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 12:24:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242476AbiBORYF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 12:24:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CE4DB4BD
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:23:54 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i205-20020a2522d6000000b00622c778ac7cso14651554ybi.3
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 09:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3zCaOJUSDmEdWokesmEQSHK4M8N82lefIJd6zevwVPs=;
        b=OpRBRe+HHmRvSGg+JydPLjAgsYkvK9IxI6Svs7KO44rO/tApCglpD6IVtYMm77a19X
         Q1J4JSpOngEQyEp+h3bEAvi0VGxiJSXlZjCAPxMhJuxQ0jJxUGJTOALLylKC68ivdXS4
         QD4JOr5AH/CzwgRYiWvmSZrHUjMUXuZMnsJ0c+7pxhP2UfmebDxUQ2JRzvdDQhCK23nU
         r4ecYrOw5R2EElQDUXv4jrZF1vF8ORJ7pJGKmGB9/d8ddWbmTtlyTB1XHcacXfXWNlxJ
         LOssJflq+yiaF+zOFsKI4PXQHVcdsRkclSYU49icDXD68hIeadj5e5gP8nEGbwVrjvyp
         4D4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3zCaOJUSDmEdWokesmEQSHK4M8N82lefIJd6zevwVPs=;
        b=un/EsbAoUg8mIkjLZEopH0X+HBgj6wPbOyCJ/rm4WrBXd96rId0mQ5HKV6rBhT/7SZ
         Jlw2JgQeaY/Ni0KhAHv85+b3wB8XpwtjhGYVKWKCHLut6YgYk3Cx2vlm8KmSRk9W7R39
         opx7NwiZNEkzQyavAY4/s00BB+fxbKn4PF/RhG2wymyHn51DofxT+0cBfWfNw/SsNUsC
         RAKCYYvQkH5QqoWT8a0rCPvYGvJ4HyAV0mPopLQcZ/GqufVH2HTouixfcaCaK6Kucl15
         Mum2h1AdLAQ+6O4ppqG8lAzmRwo3uZfjG3Wg6+fAsnKAbD2h0QDPZ/c26Z2S7mE/Qwzv
         Uv+A==
X-Gm-Message-State: AOAM5319wsswhhJ3yf/9BJOBaYN1yxXmRbNPSdHOYsuM0ou5d60Kinay
        NM7L1CsIsKOkFXP6ARD9FJnDOTQ14xsTQ9ONymqJniszSnT39uzKjr5tBnIr8JvxIWzTLeZS6w2
        SV8w23hpER/UuyWYZ6R89G1LxkaSUfxaEz2pFUadUtuYnlaOPfF/0uw+zjoxqk3Y=
X-Google-Smtp-Source: ABdhPJyGor97RmG8WpOK0FffZcOX5UT8V+aGrOY1MCulAWs+BqBxtlrLT5x4u8uXScd9vs0jzjUQI/icanIoRA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:904:: with SMTP id
 4mr2243422ybj.326.1644945833843; Tue, 15 Feb 2022 09:23:53 -0800 (PST)
Date:   Wed, 16 Feb 2022 01:23:12 +0800
In-Reply-To: <20220215172318.73533-1-chooglen@google.com>
Message-Id: <20220215172318.73533-4-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <20220215172318.73533-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v2 3/9] submodule: make static functions read submodules from commits
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
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

The changed function signatures follow repo_submodule_init()'s argument
order, i.e. "path" then "treeish_name". Where needed, reorder the
arguments of functions that already take "path" and "treeish_name" to be
consistent with this convention.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5ace18a7d9..7032dcabb8 100644
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
@@ -968,9 +969,10 @@ static int check_has_commit(const struct object_id *oid, void *data)
 
 static int submodule_has_commits(struct repository *r,
 				 const char *path,
+				 const struct object_id *super_oid,
 				 struct oid_array *commits)
 {
-	struct has_commit_data has_commit = { r, 1, path };
+	struct has_commit_data has_commit = { r, 1, path, super_oid };
 
 	/*
 	 * Perform a cheap, but incorrect check for the existence of 'commits'.
@@ -1017,7 +1019,7 @@ static int submodule_needs_pushing(struct repository *r,
 				   const char *path,
 				   struct oid_array *commits)
 {
-	if (!submodule_has_commits(r, path, commits))
+	if (!submodule_has_commits(r, path, null_oid(), commits))
 		/*
 		 * NOTE: We do consider it safe to return "no" here. The
 		 * correct answer would be "We do not know" instead of
@@ -1277,7 +1279,7 @@ static void calculate_changed_submodule_paths(struct repository *r,
 		if (!path)
 			continue;
 
-		if (submodule_has_commits(r, path, commits)) {
+		if (submodule_has_commits(r, path, null_oid(), commits)) {
 			oid_array_clear(commits);
 			*name->string = '\0';
 		}
@@ -1402,12 +1404,13 @@ static const struct submodule *get_non_gitmodules_submodule(const char *path)
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
@@ -1439,11 +1442,12 @@ static void fetch_task_release(struct fetch_task *p)
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
@@ -1464,7 +1468,7 @@ static int get_next_submodule(struct child_process *cp,
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		task = fetch_task_create(spf->r, ce->name);
+		task = fetch_task_create(spf->r, ce->name, null_oid());
 		if (!task)
 			continue;
 
@@ -1487,7 +1491,7 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		task->repo = get_submodule_repo_for(spf->r, task->sub->path);
+		task->repo = get_submodule_repo_for(spf->r, task->sub->path, null_oid());
 		if (task->repo) {
 			struct strbuf submodule_prefix = STRBUF_INIT;
 			child_process_init(cp);
-- 
2.33.GIT

