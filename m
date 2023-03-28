Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD174C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjC1OAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjC1N7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2645C66F
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so7527726wmq.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CeMEwpMTkkvg6aJ9wOVnmX717PmvaqOPLKH9MnlQrA=;
        b=XapRNDDulD2Guad2/ZHnuzFWgFHCe/MzqJH9dGMppFnHnqFdLwLl2qlOJsYT7wiJ6i
         b9y4pLTWye5WpPo8pj/VdM1gHaBmkiYVZ4RHZ21rFxJwOuj8i4UNV8ZPVoPFt38RYTFy
         zed/2aqBLg9Ov75F0ve7Trw/RnkqvBcgt5EN73mGVbf774dUI4I7hQUBOvk7UQPX2fcY
         g9rqS1R2eYR4/wNalXY51pMXMEsUZYmw7uNQC9ZueJUCrQQ+Dv98OfilxiRCz4/guAk9
         YNtbMJnVlXb4lkMkN7n6kpzuUJeQXclwx00E1GOGDTsEk+dNd1rogM39pe5RwXtf/tTj
         L0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CeMEwpMTkkvg6aJ9wOVnmX717PmvaqOPLKH9MnlQrA=;
        b=aD8tKp4UWDM2pg7erA6Us6BJvcVEz7k5TvzM+88ErUgn/pcTszKle4U8RcLdpkNqfF
         oDO3QFcSoAK2eUVrs1x8EKy86zCpsDd6/To8mXi75cZ0DqggGKG8qABYyHb7lW6D28jL
         oz0eCtkXXMVF+3+A2bub19KiQbCR4x4H+gKjy5+U2LRazkgcrUHuvHPapSvOl43U9Zyq
         DturUMOG7eFBjQ3WZm8TQo9vrRbQPQE6rSUZ8dKyrYzIBX+kMciDSv6DUse59IxDdJKc
         vrAaTGuLAIRKeltZL/fUNf46GbHKbUCTLXjWIxWfH7MWS5YPiXSoc1PPQTkQCxmIWc1e
         b60g==
X-Gm-Message-State: AO0yUKUtmVbTfDyVdLbkVEqvAWxnKxhTtF8okaU214XhbliHWkm5O0kv
        3aILsKtEKPYXy8/NomG6jNmJjfzWkEsGDA==
X-Google-Smtp-Source: AK7set/T/DfyDirr8GGipn71S1Y/iOYqV8G3+vkTdFu3zAV12wDi42l6JqRmEy8PtAZO/+B/Nc3Nnw==
X-Received: by 2002:a7b:cd0d:0:b0:3ed:30cb:5569 with SMTP id f13-20020a7bcd0d000000b003ed30cb5569mr11196951wmj.20.1680011960125;
        Tue, 28 Mar 2023 06:59:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/17] cocci: apply the "promisor-remote.h" part of "the_repository.pending"
Date:   Tue, 28 Mar 2023 15:58:53 +0200
Message-Id: <patch-v2-12.17-8336b0321a8-20230328T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the part of "the_repository.pending.cocci" pertaining to
"promisor-remote.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c                              |  2 +-
 builtin/fetch.c                                 |  4 ++--
 builtin/gc.c                                    |  2 +-
 builtin/index-pack.c                            |  2 +-
 builtin/pack-objects.c                          |  2 +-
 builtin/repack.c                                |  2 +-
 cache-tree.c                                    |  4 ++--
 connected.c                                     |  4 ++--
 contrib/coccinelle/the_repository.cocci         | 10 ++++++++++
 contrib/coccinelle/the_repository.pending.cocci | 10 ----------
 diff.c                                          |  2 +-
 diffcore-break.c                                |  2 +-
 diffcore-rename.c                               |  4 ++--
 list-objects-filter-options.c                   |  7 ++++---
 merge-ort.c                                     |  2 +-
 packfile.c                                      |  2 +-
 promisor-remote.h                               | 15 ---------------
 unpack-trees.c                                  |  2 +-
 18 files changed, 32 insertions(+), 46 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index a7bcb55b40d..44d202aa55b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -796,7 +796,7 @@ static int batch_objects(struct batch_options *opt)
 		if (!memcmp(&data.info, &empty, sizeof(empty)))
 			data.skip_object_info = 1;
 
-		if (has_promisor_remote())
+		if (repo_has_promisor_remote(the_repository))
 			warning("This repository uses promisor remotes. Some objects may not be loaded.");
 
 		read_replace_refs = 0;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0ee5d269768..4198e1c1a84 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2015,7 +2015,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * If no prior partial clone/fetch and the current fetch DID NOT
 	 * request a partial-fetch, do a normal fetch.
 	 */
-	if (!has_promisor_remote() && !filter_options.choice)
+	if (!repo_has_promisor_remote(the_repository) && !filter_options.choice)
 		return;
 
 	/*
@@ -2271,7 +2271,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			printf("%s\n", oid_to_hex(oid));
 		oidset_clear(&acked_commits);
 	} else if (remote) {
-		if (filter_options.choice || has_promisor_remote())
+		if (filter_options.choice || repo_has_promisor_remote(the_repository))
 			fetch_one_setup_partial(remote);
 		result = fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs);
 	} else {
diff --git a/builtin/gc.c b/builtin/gc.c
index a61d62bcf7b..a204b301ac4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -700,7 +700,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			strvec_push(&prune, prune_expire);
 			if (quiet)
 				strvec_push(&prune, "--no-progress");
-			if (has_promisor_remote())
+			if (repo_has_promisor_remote(the_repository))
 				strvec_push(&prune,
 					    "--exclude-promisor-objects");
 			prune_cmd.git_cmd = 1;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e823a73b357..6bd95f54d6e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1393,7 +1393,7 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		sorted_by_pos[i] = &ref_deltas[i];
 	QSORT(sorted_by_pos, nr_ref_deltas, delta_pos_compare);
 
-	if (has_promisor_remote()) {
+	if (repo_has_promisor_remote(the_repository)) {
 		/*
 		 * Prefetch the delta bases.
 		 */
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 068e6326c1d..bcf10d543f1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2080,7 +2080,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 
 	if (oid_object_info_extended(the_repository, &entry->idx.oid, &oi,
 				     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_LOOKUP_REPLACE) < 0) {
-		if (has_promisor_remote()) {
+		if (repo_has_promisor_remote(the_repository)) {
 			prefetch_to_pack(object_index);
 			if (oid_object_info_extended(the_repository, &entry->idx.oid, &oi,
 						     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_LOOKUP_REPLACE) < 0)
diff --git a/builtin/repack.c b/builtin/repack.c
index 87f73c8923a..ab4c55b50fc 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -903,7 +903,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strvec_push(&cmd.args, "--reflog");
 		strvec_push(&cmd.args, "--indexed-objects");
 	}
-	if (has_promisor_remote())
+	if (repo_has_promisor_remote(the_repository))
 		strvec_push(&cmd.args, "--exclude-promisor-objects");
 	if (!write_midx) {
 		if (write_bitmaps > 0)
diff --git a/cache-tree.c b/cache-tree.c
index d71b9befd9a..12206eeaa3c 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -242,7 +242,7 @@ int cache_tree_fully_valid(struct cache_tree *it)
 
 static int must_check_existence(const struct cache_entry *ce)
 {
-	return !(has_promisor_remote() && ce_skip_worktree(ce));
+	return !(repo_has_promisor_remote(the_repository) && ce_skip_worktree(ce));
 }
 
 static int update_one(struct cache_tree *it,
@@ -472,7 +472,7 @@ int cache_tree_update(struct index_state *istate, int flags)
 	if (!istate->cache_tree)
 		istate->cache_tree = cache_tree();
 
-	if (!(flags & WRITE_TREE_MISSING_OK) && has_promisor_remote())
+	if (!(flags & WRITE_TREE_MISSING_OK) && repo_has_promisor_remote(the_repository))
 		prefetch_cache_entries(istate, must_check_existence);
 
 	trace_performance_enter();
diff --git a/connected.c b/connected.c
index 39cb1e1074d..0b7be81237d 100644
--- a/connected.c
+++ b/connected.c
@@ -55,7 +55,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		strbuf_release(&idx_file);
 	}
 
-	if (has_promisor_remote()) {
+	if (repo_has_promisor_remote(the_repository)) {
 		/*
 		 * For partial clones, we don't want to have to do a regular
 		 * connectivity check because we have to enumerate and exclude
@@ -98,7 +98,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	strvec_push(&rev_list.args,"rev-list");
 	strvec_push(&rev_list.args, "--objects");
 	strvec_push(&rev_list.args, "--stdin");
-	if (has_promisor_remote())
+	if (repo_has_promisor_remote(the_repository))
 		strvec_push(&rev_list.args, "--exclude-promisor-objects");
 	if (!opt->is_deepening_fetch) {
 		strvec_push(&rev_list.args, "--not");
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index a325361f961..d5b644a8687 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -95,6 +95,16 @@
 |
 - approximate_object_count
 + repo_approximate_object_count
+// promisor-remote.h
+|
+- promisor_remote_reinit
++ repo_promisor_remote_reinit
+|
+- promisor_remote_find
++ repo_promisor_remote_find
+|
+- has_promisor_remote
++ repo_has_promisor_remote
 )
   (
 + the_repository,
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 9b426e49e66..e17a60198c5 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,17 +5,7 @@
 @@
 @@
 (
-// promisor-remote.h
-- promisor_remote_reinit
-+ repo_promisor_remote_reinit
-|
-- promisor_remote_find
-+ repo_promisor_remote_find
-|
-- has_promisor_remote
-+ repo_has_promisor_remote
 // refs.h
-|
 - dwim_ref
 + repo_dwim_ref
 // rerere.h
diff --git a/diff.c b/diff.c
index 81f115d32c9..b0a810fbee3 100644
--- a/diff.c
+++ b/diff.c
@@ -6885,7 +6885,7 @@ void diffcore_std(struct diff_options *options)
 	 * If no prefetching occurs, diffcore_rename() will prefetch if it
 	 * decides that it needs inexact rename detection.
 	 */
-	if (options->repo == the_repository && has_promisor_remote() &&
+	if (options->repo == the_repository && repo_has_promisor_remote(the_repository) &&
 	    (options->output_format & output_formats_to_prefetch ||
 	     options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
 		diff_queued_diff_prefetch(options->repo);
diff --git a/diffcore-break.c b/diffcore-break.c
index 0d4a14964d0..5462420bbbe 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -65,7 +65,7 @@ static int should_break(struct repository *r,
 	    oideq(&src->oid, &dst->oid))
 		return 0; /* they are the same */
 
-	if (r == the_repository && has_promisor_remote()) {
+	if (r == the_repository && repo_has_promisor_remote(the_repository)) {
 		options.missing_object_cb = diff_queued_diff_prefetch;
 		options.missing_object_data = r;
 	}
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 7e9ff96d435..8e2e7a3ad73 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -986,7 +986,7 @@ static int find_basename_matches(struct diff_options *options,
 			strintmap_set(&dests, base, i);
 	}
 
-	if (options->repo == the_repository && has_promisor_remote()) {
+	if (options->repo == the_repository && repo_has_promisor_remote(the_repository)) {
 		dpf_options.missing_object_cb = basename_prefetch;
 		dpf_options.missing_object_data = &prefetch_options;
 	}
@@ -1572,7 +1572,7 @@ void diffcore_rename_extended(struct diff_options *options,
 
 	/* Finish setting up dpf_options */
 	prefetch_options.skip_unmodified = skip_unmodified;
-	if (options->repo == the_repository && has_promisor_remote()) {
+	if (options->repo == the_repository && repo_has_promisor_remote(the_repository)) {
 		dpf_options.missing_object_cb = inexact_prefetch;
 		dpf_options.missing_object_data = &prefetch_options;
 	}
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 1d25a5737db..b82ba0a2e5b 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -343,7 +343,7 @@ void partial_clone_register(
 	char *filter_name;
 
 	/* Check if it is already registered */
-	if ((promisor_remote = promisor_remote_find(remote))) {
+	if ((promisor_remote = repo_promisor_remote_find(the_repository, remote))) {
 		if (promisor_remote->partial_clone_filter)
 			/*
 			 * Remote is already registered and a filter is already
@@ -371,14 +371,15 @@ void partial_clone_register(
 	free(filter_name);
 
 	/* Make sure the config info are reset */
-	promisor_remote_reinit();
+	repo_promisor_remote_reinit(the_repository);
 }
 
 void partial_clone_get_default_filter_spec(
 	struct list_objects_filter_options *filter_options,
 	const char *remote)
 {
-	struct promisor_remote *promisor = promisor_remote_find(remote);
+	struct promisor_remote *promisor = repo_promisor_remote_find(the_repository,
+								     remote);
 	struct strbuf errbuf = STRBUF_INIT;
 
 	/*
diff --git a/merge-ort.c b/merge-ort.c
index 607e2c263f1..dace4073a06 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4217,7 +4217,7 @@ static void prefetch_for_content_merges(struct merge_options *opt,
 	struct string_list_item *e;
 	struct oid_array to_fetch = OID_ARRAY_INIT;
 
-	if (opt->repo != the_repository || !has_promisor_remote())
+	if (opt->repo != the_repository || !repo_has_promisor_remote(the_repository))
 		return;
 
 	for (e = &plist->items[plist->nr-1]; e >= plist->items; --e) {
diff --git a/packfile.c b/packfile.c
index 2023df1b75b..53fcc0f44c9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2275,7 +2275,7 @@ int is_promisor_object(const struct object_id *oid)
 	static int promisor_objects_prepared;
 
 	if (!promisor_objects_prepared) {
-		if (has_promisor_remote()) {
+		if (repo_has_promisor_remote(the_repository)) {
 			for_each_packed_object(add_promisor_object,
 					       &promisor_objects,
 					       FOR_EACH_OBJECT_PROMISOR_ONLY |
diff --git a/promisor-remote.h b/promisor-remote.h
index df36eb08efc..2cb9eda9ea4 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -18,24 +18,9 @@ struct promisor_remote {
 };
 
 void repo_promisor_remote_reinit(struct repository *r);
-static inline void promisor_remote_reinit(void)
-{
-	repo_promisor_remote_reinit(the_repository);
-}
-
 void promisor_remote_clear(struct promisor_remote_config *config);
-
 struct promisor_remote *repo_promisor_remote_find(struct repository *r, const char *remote_name);
-static inline struct promisor_remote *promisor_remote_find(const char *remote_name)
-{
-	return repo_promisor_remote_find(the_repository, remote_name);
-}
-
 int repo_has_promisor_remote(struct repository *r);
-static inline int has_promisor_remote(void)
-{
-	return repo_has_promisor_remote(the_repository);
-}
 
 /*
  * Fetches all requested objects from all promisor remotes, trying them one at
diff --git a/unpack-trees.c b/unpack-trees.c
index a75fb9f05b4..8a284d8a4da 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -459,7 +459,7 @@ static int check_updates(struct unpack_trees_options *o,
 	if (should_update_submodules())
 		load_gitmodules_file(index, &state);
 
-	if (has_promisor_remote())
+	if (repo_has_promisor_remote(the_repository))
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
 		 * below.
-- 
2.40.0.rc1.1034.g5867a1b10c5

