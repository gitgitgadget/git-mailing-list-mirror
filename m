Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E860C46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 06:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjAJGSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 01:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjAJGRt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 01:17:49 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484FE1C90F
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 22:17:44 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v10so14746625edi.8
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 22:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kft42KdAS5kQUVt8Sur19lC8rR+RERTHrxepCIsAj28=;
        b=BXC9MqxPhDbyNY9djnK0BDDaMVWAO1CXmff5ysJ9gLY7oswkwjE/f03+VLYXoHLGPS
         Je7KHkuAOq7vy1SGDrr1EVh6PeOVf2SsD49WWMar4hUU8qhlNfVbucTTLXNAA6cyDmfV
         2GwWKhbrExyUHl8ho085RkfYVDsSTJsba+HctyStARtfWjeey2BN1gf22DvUYwSeofQC
         SvZvtCn/SVlE6YDa8gS+HZeJ62LGRFEB9I04JvUqBWYfGmDTUBZNTrAdvYGi5r7xSMsT
         iHW5WHSv+aGSoX4GOrHt+smHpcC+anyAl8XblHPg6hAHiyH/8Rj17wQ7RrJAN0v7dD9V
         /8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kft42KdAS5kQUVt8Sur19lC8rR+RERTHrxepCIsAj28=;
        b=lcIXl3liEz4rf9PBCAokoD+zBbGR4JoUYQx66KzqSZbCFlze96mF3BZEwiRSmG6Y5d
         PrQrWFPIjYOywI6QvWfSU0V4l6AamVaiQQLZeaeynlcMhyJHcamOtZqg+hWEk0je9ieR
         ss/KyY0BCBMRNM/qc6cKg0twZUE7ys4Rmb58m7bmZgmXd/lXEwgc3N7NyeSjVQM0X5Kt
         sPA7szVBwIDxXfnWGXLh6Cw+oRA6xzOKXhGpVT6rkVZXgopeqe8QuIjrlk2hGwV6A1AK
         IjC0IbL56tnTGpyWuiIaBLGFrVSvSPlnHDZ/DTku9LmfLDgJq0WV4K8fbFFFGOZwlPY7
         j6Dg==
X-Gm-Message-State: AFqh2koWj/IiDgKQJAfmjWIxfh/x+kwb1E5mfwhSrSjdYNaG9/ATQi1o
        FSTPcUUFZ2NLfV8P7PiAqOXMaHOjlw88Ww==
X-Google-Smtp-Source: AMrXdXvDDSprLChYEqf0HVC1xXVe0NtjClYzVRJtE+bh8fXGbIno7jtbpBq3nrcL2Dq3uj/3W4mjog==
X-Received: by 2002:a05:6402:f02:b0:498:8c60:d7d7 with SMTP id i2-20020a0564020f0200b004988c60d7d7mr8388480eda.40.1673331462431;
        Mon, 09 Jan 2023 22:17:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k16-20020a05640212d000b0048b4e2aaba0sm4555601edx.34.2023.01.09.22.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 22:17:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] treewide: always have a valid "index_state.repo" member
Date:   Tue, 10 Jan 2023 07:17:33 +0100
Message-Id: <patch-5.5-b3b0e592101-20230110T060340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "repo" member was added to "the_index" in [1] the
repo_read_index() was made to populate it, but the unpopulated
"the_index" variable didn't get the same treatment.

Let's do that in initialize_the_repository() when we set it up, and
likewise for all of the current callers initialized an empty "struct
index_state".

This simplifies code that needs to deal with "the_index" or a custom
"struct index_state", we no longer need to second-guess this part of
the "index_state" deep in the stack. A recent example of such
second-guessing is the "istate->repo ? istate->repo : the_repository"
code in [2]. We can now simply use "istate->repo".

For "fsmonitor-settings.c" we can remove the initialization of a NULL
"r" argument to "the_repository". This was added back in [3], and was
needed at the time for callers that would pass us the "r" from an
"istate->repo". Before this change such a change to
"fsmonitor-settings.c" would segfault all over the test suite (e.g. in
t0002-gitfile.sh).

This change has wider eventual implications for
"fsmonitor-settings.c". The reason the other lazy loading behavior in
it is required (starting with "if (!r->settings.fsmonitor) ..." is
because of the previously passed "r" being "NULL".

I have other local changes on top of this which move its configuration
reading to "prepare_repo_settings()" in "repo-settings.c", as we could
now start to rely on it being called for our "r". But let's leave all
of that for now, and narrowly remove this particular part of the
lazy-loading.

1. 1fd9ae517c4 (repository: add repo reference to index_state,
   2021-01-23)
2. ee1f0c242ef (read-cache: add index.skipHash config option,
   2023-01-06)
3. 1e0ea5c4316 (fsmonitor: config settings are repository-specific,
   2022-03-25)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 apply.c                   |  2 +-
 builtin/difftool.c        |  2 +-
 builtin/sparse-checkout.c |  1 +
 builtin/stash.c           |  8 ++++----
 builtin/worktree.c        |  2 +-
 fsmonitor-settings.c      | 14 --------------
 fsmonitor.c               |  2 +-
 merge-recursive.c         |  2 +-
 read-cache.c              | 10 ++--------
 repository.c              |  2 ++
 revision.c                |  2 +-
 sparse-index.c            |  9 ---------
 split-index.c             |  1 +
 unpack-trees.c            |  1 +
 14 files changed, 17 insertions(+), 41 deletions(-)

diff --git a/apply.c b/apply.c
index 85822280476..47bc6598573 100644
--- a/apply.c
+++ b/apply.c
@@ -4105,7 +4105,7 @@ static int preimage_oid_in_gitlink_patch(struct patch *p, struct object_id *oid)
 static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 {
 	struct patch *patch;
-	struct index_state result = { NULL };
+	struct index_state result = { .repo = state->repo };
 	struct lock_file lock = LOCK_INIT;
 	int res;
 
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 1f9d4324df5..ff29906f64a 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -361,7 +361,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	struct hashmap symlinks2 = HASHMAP_INIT(pair_cmp, NULL);
 	struct hashmap_iter iter;
 	struct pair_entry *entry;
-	struct index_state wtindex = { 0 };
+	struct index_state wtindex = { .repo = the_repository };
 	struct checkout lstate, rstate;
 	int err = 0;
 	struct child_process cmd = CHILD_PROCESS_INIT;
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 58a22503f04..6f0ea71ebb1 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -217,6 +217,7 @@ static int update_working_directory(struct pattern_list *pl)
 	o.head_idx = -1;
 	o.src_index = r->index;
 	o.dst_index = r->index;
+	o.result.repo = r;
 	o.skip_sparse_checkout = 0;
 	o.pl = pl;
 
diff --git a/builtin/stash.c b/builtin/stash.c
index bb0fd861434..a4ff967ea59 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1137,7 +1137,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	int ret = 0;
 	struct strbuf untracked_msg = STRBUF_INIT;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct index_state istate = { NULL };
+	struct index_state istate = { .repo = the_repository };
 
 	cp_upd_index.git_cmd = 1;
 	strvec_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
@@ -1176,7 +1176,7 @@ static int stash_staged(struct stash_info *info, struct strbuf *out_patch,
 {
 	int ret = 0;
 	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
-	struct index_state istate = { NULL };
+	struct index_state istate = { .repo = the_repository };
 
 	if (write_index_as_tree(&info->w_tree, &istate, the_repository->index_file,
 				0, NULL)) {
@@ -1209,7 +1209,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 	int ret = 0;
 	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
 	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
-	struct index_state istate = { NULL };
+	struct index_state istate = { .repo = the_repository };
 	char *old_index_env = NULL, *old_repo_index_file;
 
 	remove_path(stash_index_path.buf);
@@ -1271,7 +1271,7 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	struct rev_info rev;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
 	struct strbuf diff_output = STRBUF_INIT;
-	struct index_state istate = { NULL };
+	struct index_state istate = { .repo = the_repository };
 
 	init_revisions(&rev, NULL);
 	copy_pathspec(&rev.prune_data, ps);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 591d659faea..fd66fb4c165 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -923,7 +923,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 
 static void validate_no_submodules(const struct worktree *wt)
 {
-	struct index_state istate = { NULL };
+	struct index_state istate = { .repo = the_repository };
 	struct strbuf path = STRBUF_INIT;
 	int i, found_submodules = 0;
 
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index ee63a97dc51..899bfe9c813 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -143,8 +143,6 @@ static void lookup_fsmonitor_settings(struct repository *r)
 
 enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
 {
-	if (!r)
-		r = the_repository;
 	if (!r->settings.fsmonitor)
 		lookup_fsmonitor_settings(r);
 
@@ -153,8 +151,6 @@ enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
 
 const char *fsm_settings__get_hook_path(struct repository *r)
 {
-	if (!r)
-		r = the_repository;
 	if (!r->settings.fsmonitor)
 		lookup_fsmonitor_settings(r);
 
@@ -174,8 +170,6 @@ void fsm_settings__set_ipc(struct repository *r)
 	 * Caller requested IPC explicitly, so avoid (possibly
 	 * recursive) config lookup.
 	 */
-	if (!r)
-		r = the_repository;
 	if (!r->settings.fsmonitor)
 		r->settings.fsmonitor = alloc_settings();
 
@@ -197,8 +191,6 @@ void fsm_settings__set_hook(struct repository *r, const char *path)
 	 * Caller requested hook explicitly, so avoid (possibly
 	 * recursive) config lookup.
 	 */
-	if (!r)
-		r = the_repository;
 	if (!r->settings.fsmonitor)
 		r->settings.fsmonitor = alloc_settings();
 
@@ -210,8 +202,6 @@ void fsm_settings__set_hook(struct repository *r, const char *path)
 
 void fsm_settings__set_disabled(struct repository *r)
 {
-	if (!r)
-		r = the_repository;
 	if (!r->settings.fsmonitor)
 		r->settings.fsmonitor = alloc_settings();
 
@@ -223,8 +213,6 @@ void fsm_settings__set_disabled(struct repository *r)
 void fsm_settings__set_incompatible(struct repository *r,
 				    enum fsmonitor_reason reason)
 {
-	if (!r)
-		r = the_repository;
 	if (!r->settings.fsmonitor)
 		r->settings.fsmonitor = alloc_settings();
 
@@ -235,8 +223,6 @@ void fsm_settings__set_incompatible(struct repository *r,
 
 enum fsmonitor_reason fsm_settings__get_reason(struct repository *r)
 {
-	if (!r)
-		r = the_repository;
 	if (!r->settings.fsmonitor)
 		lookup_fsmonitor_settings(r);
 
diff --git a/fsmonitor.c b/fsmonitor.c
index 08af00c7387..a5b9e75437b 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -304,7 +304,7 @@ void refresh_fsmonitor(struct index_state *istate)
 	char *buf;
 	unsigned int i;
 	int is_trivial = 0;
-	struct repository *r = istate->repo ? istate->repo : the_repository;
+	struct repository *r = istate->repo;
 	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
 	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 2fd0aa96875..a63d2e330d5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -412,7 +412,7 @@ static int unpack_trees_start(struct merge_options *opt,
 {
 	int rc;
 	struct tree_desc t[3];
-	struct index_state tmp_index = { NULL };
+	struct index_state tmp_index = { .repo = opt->repo };
 
 	memset(&opt->priv->unpack_opts, 0, sizeof(opt->priv->unpack_opts));
 	if (opt->priv->call_depth)
diff --git a/read-cache.c b/read-cache.c
index 78e38b0da28..3f018874926 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2300,8 +2300,6 @@ static void set_new_index_sparsity(struct index_state *istate)
 	 * If the index's repo exists, mark it sparse according to
 	 * repo settings.
 	 */
-	if (!istate->repo)
-		return;
 	prepare_repo_settings(istate->repo);
 	if (!istate->repo->settings.command_requires_full_index &&
 	    is_sparse_index_allowed(istate, 0))
@@ -2330,8 +2328,6 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
 		if (!must_exist && errno == ENOENT) {
-			if (!istate->repo)
-				istate->repo = the_repository;
 			set_new_index_sparsity(istate);
 			return 0;
 		}
@@ -2433,9 +2429,6 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	trace2_data_intmax("index", the_repository, "read/cache_nr",
 			   istate->cache_nr);
 
-	if (!istate->repo)
-		istate->repo = the_repository;
-
 	/*
 	 * If the command explicitly requires a full index, force it
 	 * to be full. Otherwise, correct the sparsity based on repository
@@ -2501,6 +2494,7 @@ int read_index_from(struct index_state *istate, const char *path,
 		discard_index(split_index->base);
 	else
 		CALLOC_ARRAY(split_index->base, 1);
+	split_index->base->repo = istate->repo;
 
 	base_oid_hex = oid_to_hex(&split_index->base_oid);
 	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
@@ -2929,7 +2923,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	int ieot_entries = 1;
 	struct index_entry_offset_table *ieot = NULL;
 	int nr, nr_threads;
-	struct repository *r = istate->repo ? istate->repo : the_repository;
+	struct repository *r = istate->repo;
 
 	f = hashfd(tempfile->fd, tempfile->filename.buf);
 
diff --git a/repository.c b/repository.c
index 3427085fd6d..fdebc8c597c 100644
--- a/repository.c
+++ b/repository.c
@@ -28,6 +28,8 @@ void initialize_the_repository(void)
 	the_repo.remote_state = remote_state_new();
 	the_repo.parsed_objects = parsed_object_pool_new();
 
+	the_index.repo = the_repository;
+
 	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
 }
 
diff --git a/revision.c b/revision.c
index 100e5ad5110..785be1eb3bf 100644
--- a/revision.c
+++ b/revision.c
@@ -1813,7 +1813,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
-		struct index_state istate = { NULL };
+		struct index_state istate = { .repo = revs->repo };
 
 		if (wt->is_current)
 			continue; /* current index already taken care of */
diff --git a/sparse-index.c b/sparse-index.c
index 86e3b99870b..147a13386a4 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -128,9 +128,6 @@ int is_sparse_index_allowed(struct index_state *istate, int flags)
 	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
 
-	if (!istate->repo)
-		istate->repo = the_repository;
-
 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
 		int test_env;
 
@@ -327,9 +324,6 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 			pl = NULL;
 	}
 
-	if (!istate->repo)
-		istate->repo = the_repository;
-
 	/*
 	 * A NULL pattern set indicates we are expanding a full index, so
 	 * we use a special region name that indicates the full expansion.
@@ -552,9 +546,6 @@ void expand_to_path(struct index_state *istate,
 	if (!istate->sparse_index)
 		return;
 
-	if (!istate->repo)
-		istate->repo = the_repository;
-
 	in_expand_to_path = 1;
 
 	/*
diff --git a/split-index.c b/split-index.c
index 9d0ccc30d00..7815ca9f33e 100644
--- a/split-index.c
+++ b/split-index.c
@@ -91,6 +91,7 @@ void move_cache_to_base_index(struct index_state *istate)
 	}
 
 	CALLOC_ARRAY(si->base, 1);
+	si->base->repo = istate->repo;
 	si->base->version = istate->version;
 	/* zero timestamp disables racy test in ce_write_index() */
 	si->base->timestamp = istate->timestamp;
diff --git a/unpack-trees.c b/unpack-trees.c
index 2381cd7cac4..e8f25bbdce7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1906,6 +1906,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	}
 
 	memset(&o->result, 0, sizeof(o->result));
+	o->result.repo = o->src_index->repo;
 	o->result.initialized = 1;
 	o->result.timestamp.sec = o->src_index->timestamp.sec;
 	o->result.timestamp.nsec = o->src_index->timestamp.nsec;
-- 
2.39.0.1195.gabc92c078c4

