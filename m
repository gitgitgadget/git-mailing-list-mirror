Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29491F609
	for <e@80x24.org>; Thu, 29 Nov 2018 00:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeK2Lbv (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 06:31:51 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:35773 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeK2Lbv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 06:31:51 -0500
Received: by mail-it1-f202.google.com with SMTP id c128so732384itc.0
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 16:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZLuqkGrLiTIYewnlFyaBCvPHouaz9uz0Q6SHtl0RwhQ=;
        b=NkUh+kdKcEA+4u4JPNfEBM+qDoApmbBjZowmOQ1Jf3ET/yCwzHr89gzepbeqbgZAze
         BucWXyNQCs3EkWp01GpiVRV59dtxQDyFZoBU+fRWpk1poZbpxYd1Tq3KMPjz4uC7jcOA
         HZFrhIM9hw5+0pzv+imK3TE0Ll3o7+tBKGzkYxllFjgROIUJvdXTfgEW30893C5imVuS
         XkS3zChnRLVUZchMysE5Owpv1gMntyQF9b24hgGk+Jeje6eQrbnehmpdaxx8RMs4HAE3
         AyHSdInh3ZnxySqJj4Bz47A3xy1MMIbEg0yR4G8T/yikBGmDnIjoXWifeKnK5ircb76K
         6PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZLuqkGrLiTIYewnlFyaBCvPHouaz9uz0Q6SHtl0RwhQ=;
        b=O01Ic75sM+P8PaD8S/nfTZ/MJT08uXLxzFtEv0etVZRy5egj1jNJoq715v1qBe4hWt
         CglvK0vHNBk4+P5YkQklKa57/UJzBGq+FiypsgIBcgGtWvqy8Oc4dVV0F2jqpqXCKw3s
         FtHmRyfTOfibpUz1XknPyhAsIxjXNFmR818qUXnbzsMkFsLiAYOFgBah6WJbHdsNBq/k
         7ZFR3ZNkrTTFQ7B024epnQKCt4FQev4g021FXmHAmCpmbGEuTb5xJCdecRW8hzVA6xU1
         O2R3prhcR8Pn/FnywM7wwZt87v4O2MVxykLyOEMqW9ucllv+pxfxpat/bOQQcKcgMaPk
         xzAg==
X-Gm-Message-State: AA+aEWYbg1N2Zq2ajD2rhkKhwe5D2brCAoS6/dOoZ+aOcj4E8Ya0v1G4
        XxrPVLgBCF0ZF+EuHsJ5eQdafQdP5JhUUIp37Lqi7fuWF++165ywKaOIHWlnVZsHHYNdSmeLXkf
        sT3pgxgjFCL95pBuujPiLRvG5unTtjHJu+0SGLr4Z4vFAwaPgOIMV+/s8M833
X-Google-Smtp-Source: AFSGD/W+AQyS+fD4DlV3dx04TFl0V7Me6u/x/K1XJTZgSiWN0HYDTkl8ypJq+HkGLfk3/G0s25DihTBcW/jP
X-Received: by 2002:a24:6504:: with SMTP id u4mr4032527itb.25.1543451302147;
 Wed, 28 Nov 2018 16:28:22 -0800 (PST)
Date:   Wed, 28 Nov 2018 16:27:56 -0800
In-Reply-To: <20181129002756.167615-1-sbeller@google.com>
Message-Id: <20181129002756.167615-10-sbeller@google.com>
Mime-Version: 1.0
References: <20181129002756.167615-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
Subject: [PATCH 9/9] fetch: try fetching submodules if needed objects were not fetched
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when git-fetch is asked to recurse into submodules, it dispatches
a plain "git-fetch -C <submodule-dir>" (with some submodule related options
such as prefix and recusing strategy, but) without any information of the
remote or the tip that should be fetched.

But this default fetch is not sufficient, as a newly fetched commit in
the superproject could point to a commit in the submodule that is not
in the default refspec. This is common in workflows like Gerrit's.
When fetching a Gerrit change under review (from refs/changes/??), the
commits in that change likely point to submodule commits that have not
been merged to a branch yet.

Try fetching a submodule by object id if the object id that the
superproject points to, cannot be found.

builtin/fetch used to only inspect submodules when they were fetched
"on-demand", as in either on/off case it was clear whether the submodule
needs to be fetched. However to know whether we need to try fetching the
object ids, we need to identify the object names, which is done in this
function check_for_new_submodule_commits(), so we'll also run that code
in case the submodule recursion is set to "on".

The submodule checks were done only when a ref in the superproject
changed, these checks were extended to also be performed when fetching
into FETCH_HEAD for completeness, and add a test for that too.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c             |  11 +-
 submodule.c                 | 206 +++++++++++++++++++++++++++++++-----
 t/t5526-fetch-submodules.sh |  86 +++++++++++++++
 3 files changed, 265 insertions(+), 38 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e0140327aa..91f9b7d9c8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -763,9 +763,6 @@ static int update_local_ref(struct ref *ref,
 			what = _("[new ref]");
 		}
 
-		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-		    (recurse_submodules != RECURSE_SUBMODULES_ON))
-			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref(msg, ref, 0);
 		format_display(display, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
@@ -779,9 +776,6 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-		    (recurse_submodules != RECURSE_SUBMODULES_ON))
-			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref("fast-forward", ref, 1);
 		format_display(display, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
@@ -794,9 +788,6 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-		    (recurse_submodules != RECURSE_SUBMODULES_ON))
-			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref("forced-update", ref, 1);
 		format_display(display, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
@@ -892,6 +883,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				ref->force = rm->peer_ref->force;
 			}
 
+			if (recurse_submodules != RECURSE_SUBMODULES_OFF)
+				check_for_new_submodule_commits(&rm->old_oid);
 
 			if (!strcmp(rm->name, "HEAD")) {
 				kind = "";
diff --git a/submodule.c b/submodule.c
index d1b6646f42..1ce944a737 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1231,8 +1231,14 @@ struct submodule_parallel_fetch {
 	int result;
 
 	struct string_list changed_submodule_names;
+
+	/* The submodules to fetch in */
+	struct fetch_task **oid_fetch_tasks;
+	int oid_fetch_tasks_nr, oid_fetch_tasks_alloc;
 };
-#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }
+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
+		  STRING_LIST_INIT_DUP, \
+		  NULL, 0, 0}
 
 static int get_fetch_recurse_config(const struct submodule *submodule,
 				    struct submodule_parallel_fetch *spf)
@@ -1259,6 +1265,73 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
 	return spf->default_option;
 }
 
+struct fetch_task {
+	struct repository *repo;
+	const struct submodule *sub;
+	unsigned free_sub : 1; /* Do we need to free the submodule? */
+
+	/* fetch specific oids if set, otherwise fetch default refspec */
+	struct oid_array *commits;
+};
+
+/**
+ * When a submodule is not defined in .gitmodules, we cannot access it
+ * via the regular submodule-config. Create a fake submodule, which we can
+ * work on.
+ */
+static const struct submodule *get_non_gitmodules_submodule(const char *path)
+{
+	struct submodule *ret = NULL;
+	const char *name = default_name_or_path(path);
+
+	if (!name)
+		return NULL;
+
+	ret = xmalloc(sizeof(*ret));
+	memset(ret, 0, sizeof(*ret));
+	ret->path = name;
+	ret->name = name;
+
+	return (const struct submodule *) ret;
+}
+
+static struct fetch_task *fetch_task_create(struct repository *r,
+					    const char *path)
+{
+	struct fetch_task *task = xmalloc(sizeof(*task));
+	memset(task, 0, sizeof(*task));
+
+	task->sub = submodule_from_path(r, &null_oid, path);
+	if (!task->sub) {
+		/*
+		 * No entry in .gitmodules? Technically not a submodule,
+		 * but historically we supported repositories that happen to be
+		 * in-place where a gitlink is. Keep supporting them.
+		 */
+		task->sub = get_non_gitmodules_submodule(path);
+		if (!task->sub) {
+			free(task);
+			return NULL;
+		}
+
+		task->free_sub = 1;
+	}
+
+	return task;
+}
+
+static void fetch_task_release(struct fetch_task *p)
+{
+	if (p->free_sub)
+		free((void*)p->sub);
+	p->free_sub = 0;
+	p->sub = NULL;
+
+	if (p->repo)
+		repo_clear(p->repo);
+	FREE_AND_NULL(p->repo);
+}
+
 static struct repository *get_submodule_repo_for(struct repository *r,
 						 const struct submodule *sub)
 {
@@ -1286,39 +1359,32 @@ static struct repository *get_submodule_repo_for(struct repository *r,
 static int get_next_submodule(struct child_process *cp,
 			      struct strbuf *err, void *data, void **task_cb)
 {
-	int ret = 0;
 	struct submodule_parallel_fetch *spf = data;
 
 	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
-		struct strbuf submodule_prefix = STRBUF_INIT;
+		int recurse_config;
 		const struct cache_entry *ce = spf->r->index->cache[spf->count];
 		const char *default_argv;
-		const struct submodule *submodule;
-		struct repository *repo;
-		struct submodule default_submodule = SUBMODULE_INIT;
+		struct fetch_task *task;
 
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		submodule = submodule_from_path(spf->r, &null_oid, ce->name);
-		if (!submodule) {
-			const char *name = default_name_or_path(ce->name);
-			if (name) {
-				default_submodule.path = name;
-				default_submodule.name = name;
-				submodule = &default_submodule;
-			}
-		}
+		task = fetch_task_create(spf->r, ce->name);
+		if (!task)
+			continue;
+
+		recurse_config = get_fetch_recurse_config(task->sub, spf);
 
-		switch (get_fetch_recurse_config(submodule, spf))
+		switch (recurse_config)
 		{
 		default:
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
-			if (!submodule ||
+			if (!task->sub ||
 			    !string_list_lookup(
 					&spf->changed_submodule_names,
-					submodule->name))
+					task->sub->name))
 				continue;
 			default_argv = "on-demand";
 			break;
@@ -1329,11 +1395,11 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
-		repo = get_submodule_repo_for(spf->r, submodule);
-		if (repo) {
+		task->repo = get_submodule_repo_for(spf->r, task->sub);
+		if (task->repo) {
+			struct strbuf submodule_prefix = STRBUF_INIT;
 			child_process_init(cp);
-			cp->dir = xstrdup(repo->gitdir);
+			cp->dir = task->repo->gitdir;
 			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
 			cp->git_cmd = 1;
 			if (!spf->quiet)
@@ -1343,12 +1409,22 @@ static int get_next_submodule(struct child_process *cp,
 			argv_array_pushv(&cp->args, spf->args.argv);
 			argv_array_push(&cp->args, default_argv);
 			argv_array_push(&cp->args, "--submodule-prefix");
+
+			strbuf_addf(&submodule_prefix, "%s%s/",
+						       spf->prefix,
+						       task->sub->path);
 			argv_array_push(&cp->args, submodule_prefix.buf);
 
-			repo_clear(repo);
-			free(repo);
-			ret = 1;
+			spf->count++;
+			*task_cb = task;
+
+			strbuf_release(&submodule_prefix);
+			return 1;
 		} else {
+
+			fetch_task_release(task);
+			free(task);
+
 			/*
 			 * An empty directory is normal,
 			 * the submodule is not initialized
@@ -1361,12 +1437,38 @@ static int get_next_submodule(struct child_process *cp,
 					    ce->name);
 			}
 		}
+	}
+
+	if (spf->oid_fetch_tasks_nr) {
+		struct fetch_task *task =
+			spf->oid_fetch_tasks[spf->oid_fetch_tasks_nr - 1];
+		struct strbuf submodule_prefix = STRBUF_INIT;
+		spf->oid_fetch_tasks_nr--;
+
+		strbuf_addf(&submodule_prefix, "%s%s/",
+			    spf->prefix, task->sub->path);
+
+		child_process_init(cp);
+		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+		cp->git_cmd = 1;
+		cp->dir = task->repo->gitdir;
+
+		argv_array_init(&cp->args);
+		argv_array_pushv(&cp->args, spf->args.argv);
+		argv_array_push(&cp->args, "on-demand");
+		argv_array_push(&cp->args, "--submodule-prefix");
+		argv_array_push(&cp->args, submodule_prefix.buf);
+
+		/* NEEDSWORK: have get_default_remote from submodule--helper */
+		argv_array_push(&cp->args, "origin");
+		oid_array_for_each_unique(task->commits,
+					  append_oid_to_argv, &cp->args);
+
+		*task_cb = task;
 		strbuf_release(&submodule_prefix);
-		if (ret) {
-			spf->count++;
-			return 1;
-		}
+		return 1;
 	}
+
 	return 0;
 }
 
@@ -1374,20 +1476,66 @@ static int fetch_start_failure(struct strbuf *err,
 			       void *cb, void *task_cb)
 {
 	struct submodule_parallel_fetch *spf = cb;
+	struct fetch_task *task = task_cb;
 
 	spf->result = 1;
 
+	fetch_task_release(task);
 	return 0;
 }
 
+static int commit_exists_in_sub(const struct object_id *oid, void *data)
+{
+	struct repository *subrepo = data;
+
+	enum object_type type = oid_object_info(subrepo, oid, NULL);
+
+	return type != OBJ_COMMIT;
+}
+
 static int fetch_finish(int retvalue, struct strbuf *err,
 			void *cb, void *task_cb)
 {
 	struct submodule_parallel_fetch *spf = cb;
+	struct fetch_task *task = task_cb;
+
+	struct string_list_item *it;
+	struct oid_array *commits;
 
 	if (retvalue)
 		spf->result = 1;
 
+	if (!task || !task->sub)
+		BUG("callback cookie bogus");
+
+	/* Is this the second time we process this submodule? */
+	if (task->commits)
+		return 0;
+
+	it = string_list_lookup(&spf->changed_submodule_names, task->sub->name);
+	if (!it)
+		/* Could be an unchanged submodule, not contained in the list */
+		goto out;
+
+	commits = it->util;
+	oid_array_filter(commits,
+			 commit_exists_in_sub,
+			 task->repo);
+
+	/* Are there commits we want, but do not exist? */
+	if (commits->nr) {
+		task->commits = commits;
+		ALLOC_GROW(spf->oid_fetch_tasks,
+			   spf->oid_fetch_tasks_nr + 1,
+			   spf->oid_fetch_tasks_alloc);
+		spf->oid_fetch_tasks[spf->oid_fetch_tasks_nr] = task;
+		spf->oid_fetch_tasks_nr++;
+		return 0;
+	}
+
+out:
+	fetch_task_release(task);
+
 	return 0;
 }
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 6c2f9b2ba2..8a016272bc 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -600,4 +600,90 @@ test_expect_success "fetch new commits when submodule got renamed" '
 	test_cmp expect actual
 '
 
+test_expect_success "fetch new submodule commits on-demand outside standard refspec" '
+	# add a second submodule and ensure it is around in downstream first
+	git clone submodule sub1 &&
+	git submodule add ./sub1 &&
+	git commit -m "adding a second submodule" &&
+	git -C downstream pull &&
+	git -C downstream submodule update --init --recursive &&
+
+	git checkout --detach &&
+
+	C=$(git -C submodule commit-tree -m "new change outside refs/heads" HEAD^{tree}) &&
+	git -C submodule update-ref refs/changes/1 $C &&
+	git update-index --cacheinfo 160000 $C submodule &&
+	test_tick &&
+
+	D=$(git -C sub1 commit-tree -m "new change outside refs/heads" HEAD^{tree}) &&
+	git -C sub1 update-ref refs/changes/2 $D &&
+	git update-index --cacheinfo 160000 $D sub1 &&
+
+	git commit -m "updated submodules outside of refs/heads" &&
+	E=$(git rev-parse HEAD) &&
+	git update-ref refs/changes/3 $E &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules origin refs/changes/3:refs/heads/my_branch &&
+		git -C submodule cat-file -t $C &&
+		git -C sub1 cat-file -t $D &&
+		git checkout --recurse-submodules FETCH_HEAD
+	)
+'
+
+test_expect_success 'fetch new submodule commits on-demand in FETCH_HEAD' '
+	# depends on the previous test for setup
+
+	C=$(git -C submodule commit-tree -m "another change outside refs/heads" HEAD^{tree}) &&
+	git -C submodule update-ref refs/changes/4 $C &&
+	git update-index --cacheinfo 160000 $C submodule &&
+	test_tick &&
+
+	D=$(git -C sub1 commit-tree -m "another change outside refs/heads" HEAD^{tree}) &&
+	git -C sub1 update-ref refs/changes/5 $D &&
+	git update-index --cacheinfo 160000 $D sub1 &&
+
+	git commit -m "updated submodules outside of refs/heads" &&
+	E=$(git rev-parse HEAD) &&
+	git update-ref refs/changes/6 $E &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules origin refs/changes/6 &&
+		git -C submodule cat-file -t $C &&
+		git -C sub1 cat-file -t $D &&
+		git checkout --recurse-submodules FETCH_HEAD
+	)
+'
+
+test_expect_success 'fetch new submodule commits on-demand without .gitmodules entry' '
+	# depends on the previous test for setup
+
+	git config -f .gitmodules --remove-section submodule.sub1 &&
+	git add .gitmodules &&
+	git commit -m "delete gitmodules file" &&
+	git checkout -B master &&
+	git -C downstream fetch &&
+	git -C downstream checkout origin/master &&
+
+	C=$(git -C submodule commit-tree -m "yet another change outside refs/heads" HEAD^{tree}) &&
+	git -C submodule update-ref refs/changes/7 $C &&
+	git update-index --cacheinfo 160000 $C submodule &&
+	test_tick &&
+
+	D=$(git -C sub1 commit-tree -m "yet another change outside refs/heads" HEAD^{tree}) &&
+	git -C sub1 update-ref refs/changes/8 $D &&
+	git update-index --cacheinfo 160000 $D sub1 &&
+
+	git commit -m "updated submodules outside of refs/heads" &&
+	E=$(git rev-parse HEAD) &&
+	git update-ref refs/changes/9 $E &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules origin refs/changes/9 &&
+		git -C submodule cat-file -t $C &&
+		git -C sub1 cat-file -t $D &&
+		git checkout --recurse-submodules FETCH_HEAD
+	)
+'
+
 test_done
-- 
2.20.0.rc1.387.gf8505762e3-goog

