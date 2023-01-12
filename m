Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9663CC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjALM4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjALMzk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:55:40 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215154FCEB
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:55:37 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso3883834wmb.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReENqZdE52nj1P0rpk69hqc9ZhFuKeYOzynpi04oeSo=;
        b=kT40PYGPbrhk3w0LtfvrIIWST+udVRFmkSaLricKAL7hSZ1ySF3C4vcQX5ziym2qzi
         MR7gRmWrcXdWozlqO0okTUUS43mFYMoZBV+M3/etqvxI+SeoSdDI/pubf62wfZ15ULxL
         +ISjOl0NxHsfUYep2qpYDj02IPiIznx7IZDcvJLzMB1LG7XmeRSGPlydly67p7NPKfAG
         bBNMT4e/gsK8MYo9xTqUqlSrmnMaQ5L6szicELhJP2HjgMIBQsiCPLN32HQ2+Zeq1CWA
         vWv1s/PAfZzbPIzf4GqrILGiNSsO8ge2pp58OeCrpBe+gbrbLhVdTwvbptB2eCTnMIyi
         8HVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReENqZdE52nj1P0rpk69hqc9ZhFuKeYOzynpi04oeSo=;
        b=rkJpOni6oKJObAuKTOk/i7RNOBSJrawYj/fB9NT3fA72wGqE6vr9FBciUyoDftL7Xy
         VxBTE11gUselVGR8rAXSDl8aBP56DoIGYQXJ2Tw1IB4gHU9zKUs0lwRfJ/UVeOoBQYrv
         Ma+V2Aon+fUj5Qb788RMd0lZBf2JeBW1LVURuqimc9MWT8QPFvVLWVQXAvTKEbQkoOmJ
         Vy5gcQZ959fRE1vYKujtFLTTXMTt1wTSNEOcIHk3aRxS/rIFvHBEtUIEJNdug7q1WdLY
         xvaCSjiQo2NJ4S4Wuckcd0amrbPtuwsAMZcu2IShimL+vmnFKslhTleB2Gee2jMud4b5
         exlw==
X-Gm-Message-State: AFqh2ko5Jsq/rWasLMRr7OGDb9jrgVZeXOgzMXqf9g1zciU8syYE6rcp
        4n78ZrzWZYTHyr6AcJAdVkq60BvGzjDlrA==
X-Google-Smtp-Source: AMrXdXu6htg02w/tmzBURGF+8rFvvUaAeCyj9PBNY0shag5miMGy4anY188OkaMAhbdA/h6fF6NuxA==
X-Received: by 2002:a05:600c:3485:b0:3d0:761b:f86 with SMTP id a5-20020a05600c348500b003d0761b0f86mr54756786wmq.28.1673528136002;
        Thu, 12 Jan 2023 04:55:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b003d9fba3c7a4sm8462473wmg.16.2023.01.12.04.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:55:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] cache API: add a "INDEX_STATE_INIT" macro/function, add release_index()
Date:   Thu, 12 Jan 2023 13:55:27 +0100
Message-Id: <patch-v2-5.6-ae256efe94a-20230112T124842Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1205.g2ca064edc27
In-Reply-To: <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we'll see in a subsequent commit we'll get advantages from always
initializing the "repo" member of the "struct index_state". To make
that easier let's introduce an initialization macro & function.

The various ad-hoc initialization of the structure can then be changed
over to it, and we can remove the various "0" assignments in
discard_index() in favor of calling index_state_init() at the end.

While not strictly necessary, let's also change the CALLOC_ARRAY() of
various "struct index_state *" to use an ALLOC_ARRAY() followed by
index_state_init() instead.

We're then adding the release_index() function and converting some
callers (including some of these allocations) over to it if they
either won't need to use their "struct index_state" again, or are just
about to call index_state_init().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 apply.c                   |  2 +-
 builtin/difftool.c        |  2 +-
 builtin/sparse-checkout.c |  1 +
 builtin/stash.c           | 16 ++++++++--------
 builtin/worktree.c        |  2 +-
 cache.h                   | 13 +++++++++++++
 merge-recursive.c         |  2 +-
 read-cache.c              | 31 ++++++++++++++++++-------------
 repository.c              |  6 ++++--
 revision.c                |  2 +-
 split-index.c             |  3 ++-
 unpack-trees.c            |  2 +-
 12 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/apply.c b/apply.c
index 85822280476..821fe411ec8 100644
--- a/apply.c
+++ b/apply.c
@@ -4105,7 +4105,7 @@ static int preimage_oid_in_gitlink_patch(struct patch *p, struct object_id *oid)
 static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 {
 	struct patch *patch;
-	struct index_state result = { NULL };
+	struct index_state result = INDEX_STATE_INIT;
 	struct lock_file lock = LOCK_INIT;
 	int res;
 
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 1f9d4324df5..758e7bd3b6a 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -361,7 +361,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	struct hashmap symlinks2 = HASHMAP_INIT(pair_cmp, NULL);
 	struct hashmap_iter iter;
 	struct pair_entry *entry;
-	struct index_state wtindex = { 0 };
+	struct index_state wtindex = INDEX_STATE_INIT;
 	struct checkout lstate, rstate;
 	int err = 0;
 	struct child_process cmd = CHILD_PROCESS_INIT;
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 58a22503f04..dc332c6d05f 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -217,6 +217,7 @@ static int update_working_directory(struct pattern_list *pl)
 	o.head_idx = -1;
 	o.src_index = r->index;
 	o.dst_index = r->index;
+	index_state_init(&o.result);
 	o.skip_sparse_checkout = 0;
 	o.pl = pl;
 
diff --git a/builtin/stash.c b/builtin/stash.c
index bb0fd861434..a5f13fb1e9f 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1137,7 +1137,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	int ret = 0;
 	struct strbuf untracked_msg = STRBUF_INIT;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
-	struct index_state istate = { NULL };
+	struct index_state istate = INDEX_STATE_INIT;
 
 	cp_upd_index.git_cmd = 1;
 	strvec_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
@@ -1165,7 +1165,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	}
 
 done:
-	discard_index(&istate);
+	release_index(&istate);
 	strbuf_release(&untracked_msg);
 	remove_path(stash_index_path.buf);
 	return ret;
@@ -1176,7 +1176,7 @@ static int stash_staged(struct stash_info *info, struct strbuf *out_patch,
 {
 	int ret = 0;
 	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
-	struct index_state istate = { NULL };
+	struct index_state istate = INDEX_STATE_INIT;
 
 	if (write_index_as_tree(&info->w_tree, &istate, the_repository->index_file,
 				0, NULL)) {
@@ -1199,7 +1199,7 @@ static int stash_staged(struct stash_info *info, struct strbuf *out_patch,
 	}
 
 done:
-	discard_index(&istate);
+	release_index(&istate);
 	return ret;
 }
 
@@ -1209,7 +1209,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 	int ret = 0;
 	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
 	struct child_process cp_diff_tree = CHILD_PROCESS_INIT;
-	struct index_state istate = { NULL };
+	struct index_state istate = INDEX_STATE_INIT;
 	char *old_index_env = NULL, *old_repo_index_file;
 
 	remove_path(stash_index_path.buf);
@@ -1260,7 +1260,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 	}
 
 done:
-	discard_index(&istate);
+	release_index(&istate);
 	remove_path(stash_index_path.buf);
 	return ret;
 }
@@ -1271,7 +1271,7 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	struct rev_info rev;
 	struct child_process cp_upd_index = CHILD_PROCESS_INIT;
 	struct strbuf diff_output = STRBUF_INIT;
-	struct index_state istate = { NULL };
+	struct index_state istate = INDEX_STATE_INIT;
 
 	init_revisions(&rev, NULL);
 	copy_pathspec(&rev.prune_data, ps);
@@ -1319,7 +1319,7 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	}
 
 done:
-	discard_index(&istate);
+	release_index(&istate);
 	release_revisions(&rev);
 	strbuf_release(&diff_output);
 	remove_path(stash_index_path.buf);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 591d659faea..311d6e90750 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -923,7 +923,7 @@ static int unlock_worktree(int ac, const char **av, const char *prefix)
 
 static void validate_no_submodules(const struct worktree *wt)
 {
-	struct index_state istate = { NULL };
+	struct index_state istate = INDEX_STATE_INIT;
 	struct strbuf path = STRBUF_INIT;
 	int i, found_submodules = 0;
 
diff --git a/cache.h b/cache.h
index 21ed9633b2a..be28fce12ac 100644
--- a/cache.h
+++ b/cache.h
@@ -360,6 +360,19 @@ struct index_state {
 	struct pattern_list *sparse_checkout_patterns;
 };
 
+/**
+ * A "struct index_state istate" must be initialized with
+ * INDEX_STATE_INIT or the corresponding index_state_init().
+ *
+ * If the variable won't be used again, use release_index() to free()
+ * its resources. If it needs to be used again use discard_index(),
+ * which does the same thing, but will use use index_state_init() at
+ * the end.
+ */
+#define INDEX_STATE_INIT { 0 }
+void index_state_init(struct index_state *istate);
+void release_index(struct index_state *istate);
+
 /* Name hashing */
 int test_lazy_init_name_hash(struct index_state *istate, int try_threaded);
 void add_name_hash(struct index_state *istate, struct cache_entry *ce);
diff --git a/merge-recursive.c b/merge-recursive.c
index 2fd0aa96875..0948b3ea961 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -412,7 +412,7 @@ static int unpack_trees_start(struct merge_options *opt,
 {
 	int rc;
 	struct tree_desc t[3];
-	struct index_state tmp_index = { NULL };
+	struct index_state tmp_index = INDEX_STATE_INIT;
 
 	memset(&opt->priv->unpack_opts, 0, sizeof(opt->priv->unpack_opts));
 	if (opt->priv->call_depth)
diff --git a/read-cache.c b/read-cache.c
index 25925c8c002..d191741f600 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2498,9 +2498,10 @@ int read_index_from(struct index_state *istate, const char *path,
 
 	trace_performance_enter();
 	if (split_index->base)
-		discard_index(split_index->base);
+		release_index(split_index->base);
 	else
-		CALLOC_ARRAY(split_index->base, 1);
+		ALLOC_ARRAY(split_index->base, 1);
+	index_state_init(split_index->base);
 
 	base_oid_hex = oid_to_hex(&split_index->base_oid);
 	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
@@ -2539,7 +2540,13 @@ int is_index_unborn(struct index_state *istate)
 	return (!istate->cache_nr && !istate->timestamp.sec);
 }
 
-void discard_index(struct index_state *istate)
+void index_state_init(struct index_state *istate)
+{
+	struct index_state blank = INDEX_STATE_INIT;
+	memcpy(istate, &blank, sizeof(*istate));
+}
+
+void release_index(struct index_state *istate)
 {
 	/*
 	 * Cache entries in istate->cache[] should have been allocated
@@ -2551,20 +2558,12 @@ void discard_index(struct index_state *istate)
 	validate_cache_entries(istate);
 
 	resolve_undo_clear_index(istate);
-	istate->cache_nr = 0;
-	istate->cache_changed = 0;
-	istate->timestamp.sec = 0;
-	istate->timestamp.nsec = 0;
 	free_name_hash(istate);
 	cache_tree_free(&(istate->cache_tree));
-	istate->initialized = 0;
-	istate->fsmonitor_has_run_once = 0;
-	FREE_AND_NULL(istate->fsmonitor_last_update);
-	FREE_AND_NULL(istate->cache);
-	istate->cache_alloc = 0;
+	free(istate->fsmonitor_last_update);
+	free(istate->cache);
 	discard_split_index(istate);
 	free_untracked_cache(istate->untracked);
-	istate->untracked = NULL;
 
 	if (istate->sparse_checkout_patterns) {
 		clear_pattern_list(istate->sparse_checkout_patterns);
@@ -2577,6 +2576,12 @@ void discard_index(struct index_state *istate)
 	}
 }
 
+void discard_index(struct index_state *istate)
+{
+	release_index(istate);
+	index_state_init(istate);
+}
+
 /*
  * Validate the cache entries of this index.
  * All cache entries associated with this index
diff --git a/repository.c b/repository.c
index 3427085fd6d..a5805fa33b1 100644
--- a/repository.c
+++ b/repository.c
@@ -302,8 +302,10 @@ int repo_read_index(struct repository *repo)
 {
 	int res;
 
-	if (!repo->index)
-		CALLOC_ARRAY(repo->index, 1);
+	if (!repo->index) {
+		ALLOC_ARRAY(repo->index, 1);
+		index_state_init(repo->index);
+	}
 
 	/* Complete the double-reference */
 	if (!repo->index->repo)
diff --git a/revision.c b/revision.c
index 100e5ad5110..fb090886f5b 100644
--- a/revision.c
+++ b/revision.c
@@ -1813,7 +1813,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
-		struct index_state istate = { NULL };
+		struct index_state istate = INDEX_STATE_INIT;
 
 		if (wt->is_current)
 			continue; /* current index already taken care of */
diff --git a/split-index.c b/split-index.c
index 9d0ccc30d00..a5b56c0c37f 100644
--- a/split-index.c
+++ b/split-index.c
@@ -90,7 +90,8 @@ void move_cache_to_base_index(struct index_state *istate)
 		mem_pool_combine(istate->ce_mem_pool, istate->split_index->base->ce_mem_pool);
 	}
 
-	CALLOC_ARRAY(si->base, 1);
+	ALLOC_ARRAY(si->base, 1);
+	index_state_init(si->base);
 	si->base->version = istate->version;
 	/* zero timestamp disables racy test in ce_write_index() */
 	si->base->timestamp = istate->timestamp;
diff --git a/unpack-trees.c b/unpack-trees.c
index 2381cd7cac4..d1d1b0f319e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1905,7 +1905,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		populate_from_existing_patterns(o, &pl);
 	}
 
-	memset(&o->result, 0, sizeof(o->result));
+	index_state_init(&o->result);
 	o->result.initialized = 1;
 	o->result.timestamp.sec = o->src_index->timestamp.sec;
 	o->result.timestamp.nsec = o->src_index->timestamp.nsec;
-- 
2.39.0.1205.g2ca064edc27

