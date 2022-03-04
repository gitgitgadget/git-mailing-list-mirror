Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7228FC433FE
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbiCDA7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbiCDA7J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:59:09 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDE41201AD
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:58:14 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id t184-20020a6281c1000000b004e103c5f726so4087256pfd.8
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 16:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jMKFFMj25zrRdrj/VKq4uwdhmkhAO9UMRLTmQPqt2tU=;
        b=BrF9fDQqyYkef1lgYdFYq5Eom7uGqe/nhAvj6653Oqt+UD1zfTq84Zb15Zy1ETxHD7
         ydaOxPUpr4MkhJm1tznxucGCX/PeyaE77VYFsEU+4cORk+3ESpN+7q7/YXI+u5Mrwr3i
         gMlZAxYjywQr55tKsKhQdEWrRNcTNsf3kmbh1a4c7yARyxYRYNlUwtbyzHLO6ZRXIoBv
         K2xwlb93DwsGI9mEJT2lMNrwK/kCv7DkRALu+Ljx34KfGrILrFbRXi7S3WOhpA8XizTZ
         +CauBZnKrgnkPF60pbSuhfaSK4F6e/zwSskDh9T8UhUqbRymH1nbhQhRxd3auPER7u+b
         aXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jMKFFMj25zrRdrj/VKq4uwdhmkhAO9UMRLTmQPqt2tU=;
        b=xZYBvZuUvR5kUYWoRbfh9VVhG4z+CY9lNHmUfd0eN+NK8vQNVhHf+TI0f72tL15X9I
         eKILtSjGVWgTVX1lmxq2Zq9CkOTo7O2rybJoTm7PYnxk9oDpoOM/o5ywG87JD4Xcrc/G
         0elZy6nXAjgVIrTj1lit2iKcQXBRJNy2EbXMvRpxcLDV0XGAC556dPoayN88vmFpHf9Y
         PL8uug6K6jNP3GVSvkqWfNZmrjGJ4abgrTu9aDMMPdQQ+RCi4aDd+JixABj0TZT8aUbo
         ayQghQUS4hA+RQNm9fPsFweiQE7/luCVInCbenFrMaaYznNRc2/KuSW1cL+u/gOpTsp6
         c1AQ==
X-Gm-Message-State: AOAM530SAWOE97jcMaZ91DKoma0mAEW7bucf5KlXMrOMpWBt56TT8MMy
        jqzxxdfI3DeYX5J/k8qgX8Rv6j4FnpuzB/2uDy2u2xozfNtg0JrzGQJxOoPZilUfSkvxSD4n+AV
        HtVkgTXmWcO4a69nzutMzkJlFMXp26V/54W0B6370EgBdxHqXnZQe6dBUjI+pL/I=
X-Google-Smtp-Source: ABdhPJwJMYtzcKMQdrJMEj5hmm4yR3i3wS1+8uj3Kwzr8GKT8hu3BPongXUWZvaBS3PLMhpAUKSgfvOxYU49Vw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1646:b0:4f4:58f:b64 with SMTP id
 m6-20020a056a00164600b004f4058f0b64mr25132783pfc.47.1646355493648; Thu, 03
 Mar 2022 16:58:13 -0800 (PST)
Date:   Thu,  3 Mar 2022 16:57:51 -0800
In-Reply-To: <20220304005757.70107-1-chooglen@google.com>
Message-Id: <20220304005757.70107-5-chooglen@google.com>
Mime-Version: 1.0
References: <20220224100842.95827-1-chooglen@google.com> <20220304005757.70107-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 04/10] submodule: make static functions read submodules
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

