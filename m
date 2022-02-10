Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12EBC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 04:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiBJEmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 23:42:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiBJEmC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 23:42:02 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF9A1A8
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 20:42:02 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id hi22-20020a17090b30d600b001b8b33cf0efso3359517pjb.1
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 20:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=szfxtG21KRnDWftifsRjdD8enTYjbmRO82Wb0Ej+5s8=;
        b=Cpd5P4tC0qZkHlYbw4h4fQFg59FIFMyEeXrijPCi5PW8Rk2RgKNStOzrYjNjeTez/2
         llaICbxvA1/rSfVp+c1xJj94ZbxMkk+4oWbf0IC9m1yU+tXmzAnmiACSgs9WAI8aPR3C
         28dc5hX/1F+Zsvvrhc082sK7Vj2CSDoTjUYAp76rgNSKmlj0Bvp1KsX3FaHH88IONb77
         IWbJbzsOQIEOwEEzeLt4MzmzZAvc7YVxuYh0WAepGD8MHTzI0NoKeMu5kexUgywDPJcT
         ZCuD7IFjKGBdbPMidRGSk7x99qMMAKbx6Xzan6X47FC7wMGidOx53OEMczaRu/VoNaV0
         TFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=szfxtG21KRnDWftifsRjdD8enTYjbmRO82Wb0Ej+5s8=;
        b=MgNPy1YarlalqXZavvZlOtFX+gEGlxTd4rEJn9HnM8fs0FmGav91UITLBhfqqFbILF
         zp0ebsS1Q6WikLdziTO6g7AtoDP4i9+ZYXmPf77l0VsH05jQT+Z+nVBrPcIRxcdDRUVQ
         3O/koZyq9g/lPYsLHD1Uv4A6ZLA9ZqPUchbEH1vljSYAHrfaFGP3xdY+KGAS2hxD3CEO
         fk69FimdDGWUocUjHlWQV3+JfHBN5iCHGtOwOykOqXM8pLodjqvaiun+l1zTMQnXpd7+
         l+LLLAzTgvJuIwY5nILnyqpUPeyZL0xTw7N2K2z5iSaNValoXl4fzM/qpEXSMnDogctH
         XExA==
X-Gm-Message-State: AOAM533UtP6CdNXXT6qFyan9FdJUBD23QA7zMeFSOcBVdhWbdEnWAYUl
        A6Hbxl6vISD5eruxKN+1vkWZXM3BvzDzDwfOFlpn0y1B7+jcjz+mk9+rOZmXhnVa+j19OPkBsHR
        pFDbwxwIuGgKPAQVN9Muyk+XiWkumXcIR8cXE16hvm0nmKovv3aGuUx/TqHSDZRY=
X-Google-Smtp-Source: ABdhPJy/T1nRIa25IjKQk7g8gyLOcpeoYRNK8OwxLQUOv7cxz19MsktuMnRM5tAG6owqJ+qwcYPc4c7doTk4Xg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4c8e:: with SMTP id
 my14mr214594pjb.0.1644468121936; Wed, 09 Feb 2022 20:42:01 -0800 (PST)
Date:   Thu, 10 Feb 2022 12:41:47 +0800
In-Reply-To: <20220210044152.78352-1-chooglen@google.com>
Message-Id: <20220210044152.78352-4-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 3/8] submodule: make static functions read submodules from commits
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future commit will teach "fetch --recurse-submodules" to fetch
unpopulated submodules. Prepare for this by teaching the necessary
static functions to read submodules from superproject commits instead of
the index and filesystem. Then, store the necessary fields (path and
super_oid), and use them in "fetch --recurse-submodules" where possible.

As a result, "git fetch" now reads changed submodules using the
`.gitmodules` and path from super_oid's tree (which is where "git fetch"
actually noticed the changed submodule) instead of the filesystem.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/submodule.c b/submodule.c
index e2405c9f15..d4227ac22d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -811,6 +811,16 @@ static const char *default_name_or_path(const char *path_or_name)
  * member of the changed submodule string_list_item.
  */
 struct changed_submodule_data {
+	/*
+	 * The first superproject commit in the rev walk that points to the
+	 * submodule.
+	 */
+	const struct object_id *super_oid;
+	/*
+	 * Path to the submodule in the superproject commit referenced
+	 * by 'super_oid'.
+	 */
+	char *path;
 	/* The submodule commits that have changed in the rev walk. */
 	struct oid_array *new_commits;
 };
@@ -819,6 +829,7 @@ static void changed_submodule_data_clear(struct changed_submodule_data *cs_data)
 {
 	oid_array_clear(cs_data->new_commits);
 	free(cs_data->new_commits);
+	free(cs_data->path);
 }
 
 static void collect_changed_submodules_cb(struct diff_queue_struct *q,
@@ -869,6 +880,8 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 			cs_data = xcalloc(1, sizeof(struct changed_submodule_data));
 			/* NEEDSWORK: should we have oid_array_init()? */
 			cs_data->new_commits = xcalloc(1, sizeof(struct oid_array));
+			cs_data->super_oid = commit_oid;
+			cs_data->path = xstrdup(p->two->path);
 			item->util = cs_data;
 		}
 		oid_array_append(cs_data->new_commits, &p->two->oid);
@@ -944,6 +957,7 @@ struct has_commit_data {
 	struct repository *repo;
 	int result;
 	const char *path;
+	const struct object_id *super_oid;
 };
 
 static int check_has_commit(const struct object_id *oid, void *data)
@@ -952,7 +966,7 @@ static int check_has_commit(const struct object_id *oid, void *data)
 	struct repository subrepo;
 	enum object_type type;
 
-	if (repo_submodule_init(&subrepo, cb->repo, cb->path, null_oid())) {
+	if (repo_submodule_init(&subrepo, cb->repo, cb->path, cb->super_oid)) {
 		cb->result = 0;
 		goto cleanup;
 	}
@@ -980,9 +994,10 @@ static int check_has_commit(const struct object_id *oid, void *data)
 
 static int submodule_has_commits(struct repository *r,
 				 const char *path,
+				 const struct object_id *super_oid,
 				 struct oid_array *commits)
 {
-	struct has_commit_data has_commit = { r, 1, path };
+	struct has_commit_data has_commit = { r, 1, path, super_oid };
 
 	/*
 	 * Perform a cheap, but incorrect check for the existence of 'commits'.
@@ -1029,7 +1044,7 @@ static int submodule_needs_pushing(struct repository *r,
 				   const char *path,
 				   struct oid_array *commits)
 {
-	if (!submodule_has_commits(r, path, commits))
+	if (!submodule_has_commits(r, path, null_oid(), commits))
 		/*
 		 * NOTE: We do consider it safe to return "no" here. The
 		 * correct answer would be "We do not know" instead of
@@ -1280,7 +1295,7 @@ static void calculate_changed_submodule_paths(struct repository *r,
 		const struct submodule *submodule;
 		const char *path = NULL;
 
-		submodule = submodule_from_name(r, null_oid(), name->string);
+		submodule = submodule_from_name(r, cs_data->super_oid, name->string);
 		if (submodule)
 			path = submodule->path;
 		else
@@ -1289,7 +1304,7 @@ static void calculate_changed_submodule_paths(struct repository *r,
 		if (!path)
 			continue;
 
-		if (submodule_has_commits(r, path, cs_data->new_commits)) {
+		if (submodule_has_commits(r, path, cs_data->super_oid, cs_data->new_commits)) {
 			oid_array_clear(cs_data->new_commits);
 			*name->string = '\0';
 		}
@@ -1414,12 +1429,13 @@ static const struct submodule *get_non_gitmodules_submodule(const char *path)
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
@@ -1451,11 +1467,12 @@ static void fetch_task_release(struct fetch_task *p)
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
@@ -1476,7 +1493,7 @@ static int get_next_submodule(struct child_process *cp,
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		task = fetch_task_create(spf->r, ce->name);
+		task = fetch_task_create(spf->r, ce->name, null_oid());
 		if (!task)
 			continue;
 
@@ -1499,7 +1516,7 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		task->repo = get_submodule_repo_for(spf->r, task->sub->path);
+		task->repo = get_submodule_repo_for(spf->r, task->sub->path, null_oid());
 		if (task->repo) {
 			struct strbuf submodule_prefix = STRBUF_INIT;
 			child_process_init(cp);
-- 
2.33.GIT

