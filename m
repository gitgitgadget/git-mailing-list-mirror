Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B548C433E1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE7161A2B
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhCZPfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhCZPfd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 11:35:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1712C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:35:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k8so6074372wrc.3
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ADwqeOfjCj0oXTWy7vxp4DBpBLJGBL7Fc1zFsEqdKTE=;
        b=eGoOp0zEm67bUZoi9jHCFAthB1xD0u5zal6YxEQ8NFhJQme/TeVM1Oyzh7Jn3OXAdx
         XJvyo/953s6g3c4FpJj4r8ksnL1VrF0Uuc8Tk0N97O0OMv8F8j+bqUswBtlHqw3ogLtU
         eo9WoS3UX7tsVjuwmvIMiXJUJugTfh65VRC8L/+Q2vBWg2vwx0V/pLx507ZgPBFIfxu9
         XmZIqGpjliNZa7GkCe1JWlosFoHCjkFLhozNvamo3dlf4MVY2vXt3k5h6D1TVCH0Mzz4
         w6J1GQ80UQaNjmHWpuT/5sZThEUU2Hbz7l80G1ilmI2MRj/Vw+PDc5UluK2LNhmlKzyI
         1ELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ADwqeOfjCj0oXTWy7vxp4DBpBLJGBL7Fc1zFsEqdKTE=;
        b=RzEF96iFgpDLS6/duLSQRG5V0VidqTEf2X+7UGT9N82IkIjJWfQguXDZ3Kyu9dMyCB
         nDRQ7zVNcJ105n1wIndz2QDrwjW5bzKBnqkPkkw9eNbWxh89zDJoCXHUIsbCIUw6JVMq
         cH7zbSA9SP12KFLpyyJI8gzr2Rr2m1dlXD3eqBXWrcBj1VfxoOvXDoL/4GNTb0N5INLQ
         yuYt2tzQ3WEoUKxqhrGrvgB70dESyHvR1Xl44Ds331ZqzfkCeQqHQ7fpkDKQxcPgIJwy
         FfbUsQTnxaHXtzlCVK83qCAHrHP3LiVSU8DDgXH/U4TjmGb5l/XTZTY6eKVchPw7vbLM
         eQdw==
X-Gm-Message-State: AOAM532bULaPS1C3O34N+vx/fJDhslD6XZraFcvMfnaOGjNTnmEZ4y1I
        RuJInONPmwBF0dibsriVIdM5tingg1Q=
X-Google-Smtp-Source: ABdhPJxKiT+X0JHMunzTGFznfGQNl+FXdKcXp1iFP+J/YWvUlZlpXSpV0FmEfP1yVVKtPFEhdSRriw==
X-Received: by 2002:adf:efc7:: with SMTP id i7mr14928516wrp.182.1616772931569;
        Fri, 26 Mar 2021 08:35:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b131sm11313563wmb.34.2021.03.26.08.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:35:31 -0700 (PDT)
Message-Id: <pull.915.v2.git.1616772930098.gitgitgadget@gmail.com>
In-Reply-To: <pull.915.git.1616701733901.gitgitgadget@gmail.com>
References: <pull.915.git.1616701733901.gitgitgadget@gmail.com>
From:   "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Mar 2021 15:35:29 +0000
Subject: [PATCH v2] cache-tree.c: remove implicit dependency on the_repository
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Chinmoy <chinmoy12c@gmail.com>,
        Chinmoy Chakraborty <chinmoy12c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chinmoy Chakraborty <chinmoy12c@gmail.com>

This kills the_repository dependency in cache_tree_update(),
but for unpack_trees(), they still assume the_repository
(which also means the_index).

Unfortunately the widespread use of unpack_trees() will make
it hard to make the conversion now.

The `update_main_cache_tree()` method uses `cache_tree_update(r, r->index, flags)`.
`r->index` is easily deduced from `r` but the signature of `cache_tree_update()`
is not changed to take `struct repository *` instead of `struct index_state *`
because there can be temporary indexes. Therefore, one might want to update
the cache tree for an index other than `r->index`.

This commit also fixes the `sparse-index.c` file in which
the `convert_to_sparse()` and `ensure_full_index()`
method use `cache_tree_update()`.

Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
---
    Replace the_repository with r
    
    There are multiple files that try to reference the repository and
    the_index directly. To follow a more object-oriented convention these
    references should be replaced with r and index and passed through
    functions.
    
    Signed-off-by: Chinmoy Chakraborty chinmoy12c@gmail.com
    
    
    Related issue
    =============
    
    #379
    
    cc: Derrick Stolee stolee@gmail.com
    
    
    Changes since v1
    ================
    
     * Fixed the sparse-index.c file in which the convert_to_sparse() and
       ensure_full_index() method use cache_tree_update().

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-915%2Fchinmoy12c%2Fissue_379-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-915/chinmoy12c/issue_379-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/915

Range-diff vs v1:

 1:  7df6968b576f ! 1:  c9c2fbdc2bd1 cache-tree.c: remove implicit dependency on the_repository
     @@ Commit message
          because there can be temporary indexes. Therefore, one might want to update
          the cache tree for an index other than `r->index`.
      
     +    This commit also fixes the `sparse-index.c` file in which
     +    the `convert_to_sparse()` and `ensure_full_index()`
     +    method use `cache_tree_update()`.
     +
          Signed-off-by: Chinmoy Chakraborty <chinmoy12c@gmail.com>
      
       ## builtin/checkout.c ##
     @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
       
       	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
       	if (read_cache_preload(NULL) < 0)
     +@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
     + 				return 1;
     + 			old_tree = get_commit_tree(old_branch_info->commit);
     + 
     +-			if (repo_index_has_changes(the_repository, old_tree, &sb))
     ++			if (repo_index_has_changes(r, old_tree, &sb))
     + 				die(_("cannot continue with staged changes in "
     + 				      "the following files:\n%s"), sb.buf);
     + 			strbuf_release(&sb);
     +@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
     + 			 */
     + 
     + 			add_files_to_cache(NULL, NULL, 0);
     +-			init_merge_options(&o, the_repository);
     ++			init_merge_options(&o, r);
     + 			o.verbosity = 0;
     +-			work = write_in_core_index_as_tree(the_repository);
     ++			work = write_in_core_index_as_tree(r);
     + 
     + 			ret = reset_tree(new_tree,
     + 					 opts, 1,
      @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
       	}
       
     @@ cache-tree.c: int cache_tree_update(struct index_state *istate, int flags)
       	if (i < 0)
       		return i;
      @@ cache-tree.c: static int write_index_as_tree_internal(struct object_id *oid,
     + 					int flags,
     + 					const char *prefix)
     + {
     ++	struct repository *r = the_repository;
     ++
     + 	if (flags & WRITE_TREE_IGNORE_CACHE_TREE) {
     + 		cache_tree_free(&index_state->cache_tree);
       		cache_tree_valid = 0;
       	}
       
      -	if (!cache_tree_valid && cache_tree_update(index_state, flags) < 0)
     -+	if (!cache_tree_valid && cache_tree_update(the_repository, index_state, flags) < 0)
     ++	if (!cache_tree_valid && cache_tree_update(r, index_state, flags) < 0)
       		return WRITE_TREE_UNMERGED_INDEX;
       
       	if (prefix) {
     -@@ cache-tree.c: void prime_cache_tree(struct repository *r,
     - 		      struct index_state *istate,
     - 		      struct tree *tree)
     - {
     --	trace2_region_enter("cache-tree", "prime_cache_tree", the_repository);
     -+	trace2_region_enter("cache-tree", "prime_cache_tree", r);
     - 	cache_tree_free(&istate->cache_tree);
     - 	istate->cache_tree = cache_tree();
     - 
     - 	prime_cache_tree_rec(r, istate->cache_tree, tree);
     - 	istate->cache_changed |= CACHE_TREE_CHANGED;
     --	trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
     -+	trace2_region_leave("cache-tree", "prime_cache_tree", r);
     - }
     - 
     - /*
      
       ## cache-tree.h ##
      @@ cache-tree.h: void cache_tree_write(struct strbuf *, struct cache_tree *root);
     @@ cache-tree.h: void cache_tree_write(struct strbuf *, struct cache_tree *root);
       
       int cache_tree_fully_valid(struct cache_tree *);
      -int cache_tree_update(struct index_state *, int);
     -+int cache_tree_update(struct repository *, struct index_state *, int);
     ++int cache_tree_update(struct repository *r, struct index_state *, int);
       void cache_tree_verify(struct repository *, struct index_state *);
       
       /* bitmasks to write_index_as_tree flags */
     @@ sequencer.c: static int is_index_unchanged(struct repository *r)
       
       	return oideq(cache_tree_oid, get_commit_tree_oid(head_commit));
      
     + ## sparse-index.c ##
     +@@ sparse-index.c: int set_sparse_index_config(struct repository *repo, int enable)
     + int convert_to_sparse(struct index_state *istate)
     + {
     + 	int test_env;
     ++	struct repository *r= the_repository;
     ++
     + 	if (istate->split_index || istate->sparse_index ||
     + 	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
     + 		return 0;
     +@@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
     + 		return -1;
     + 	}
     + 
     +-	if (cache_tree_update(istate, 0)) {
     ++	if (cache_tree_update(r, istate, 0)) {
     + 		warning(_("unable to update cache-tree, staying full"));
     + 		return -1;
     + 	}
     +@@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
     + 
     + 	/* Clear and recompute the cache-tree */
     + 	cache_tree_free(&istate->cache_tree);
     +-	cache_tree_update(istate, 0);
     ++	cache_tree_update(r, istate, 0);
     + 
     + 	istate->sparse_index = 1;
     + 	trace2_region_leave("index", "convert_to_sparse", istate->repo);
     +@@ sparse-index.c: void ensure_full_index(struct index_state *istate)
     + 	int i;
     + 	struct index_state *full;
     + 	struct strbuf base = STRBUF_INIT;
     ++	struct repository *r = the_repository;
     + 
     + 	if (!istate || !istate->sparse_index)
     + 		return;
     +@@ sparse-index.c: void ensure_full_index(struct index_state *istate)
     + 
     + 	/* Clear and recompute the cache-tree */
     + 	cache_tree_free(&istate->cache_tree);
     +-	cache_tree_update(istate, 0);
     ++	cache_tree_update(r, istate, 0);
     + 
     + 	trace2_region_leave("index", "ensure_full_index", istate->repo);
     + }
     +
       ## t/helper/test-dump-cache-tree.c ##
      @@ t/helper/test-dump-cache-tree.c: int cmd__dump_cache_tree(int ac, const char **av)
       		die("unable to read index file");
     @@ t/helper/test-dump-cache-tree.c: int cmd__dump_cache_tree(int ac, const char **a
       }
      
       ## unpack-trees.c ##
     -@@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
     +@@ unpack-trees.c: static int verify_absent(const struct cache_entry *,
     +  */
     + int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
     + {
     +-	struct repository *repo = the_repository;
     ++	struct repository *r = the_repository;
     + 	int i, ret;
       	static struct cache_entry *dfc;
       	struct pattern_list pl;
     - 	int free_pattern_list = 0;
     -+	struct repository *r = the_repository;
     - 
     - 	if (len > MAX_UNPACK_TREES)
     +@@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
       		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
       
       	trace_performance_enter();
      -	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
      +	trace2_region_enter("unpack_trees", "unpack_trees", r);
       
     - 	if (!core_apply_sparse_checkout || !o->update)
     - 		o->skip_sparse_checkout = 1;
     +-	prepare_repo_settings(repo);
     +-	if (repo->settings.command_requires_full_index) {
     ++	prepare_repo_settings(r);
     ++	if (r->settings.command_requires_full_index) {
     + 		ensure_full_index(o->src_index);
     + 		ensure_full_index(o->dst_index);
     + 	}
      @@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
       		}
       


 builtin/checkout.c              |  9 +++++----
 cache-tree.c                    | 10 ++++++----
 cache-tree.h                    |  6 ++++--
 sequencer.c                     |  6 +++---
 sparse-index.c                  |  9 ++++++---
 t/helper/test-dump-cache-tree.c |  2 +-
 unpack-trees.c                  | 19 ++++++++++---------
 7 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0e6639052001..b2ec561d52a2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -684,6 +684,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	int ret;
 	struct lock_file lock_file = LOCK_INIT;
 	struct tree *new_tree;
+	struct repository *r = the_repository;
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(NULL) < 0)
@@ -768,7 +769,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 				return 1;
 			old_tree = get_commit_tree(old_branch_info->commit);
 
-			if (repo_index_has_changes(the_repository, old_tree, &sb))
+			if (repo_index_has_changes(r, old_tree, &sb))
 				die(_("cannot continue with staged changes in "
 				      "the following files:\n%s"), sb.buf);
 			strbuf_release(&sb);
@@ -787,9 +788,9 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 */
 
 			add_files_to_cache(NULL, NULL, 0);
-			init_merge_options(&o, the_repository);
+			init_merge_options(&o, r);
 			o.verbosity = 0;
-			work = write_in_core_index_as_tree(the_repository);
+			work = write_in_core_index_as_tree(r);
 
 			ret = reset_tree(new_tree,
 					 opts, 1,
@@ -822,7 +823,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	}
 
 	if (!cache_tree_fully_valid(active_cache_tree))
-		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
+		cache_tree_update(r, r->index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
diff --git a/cache-tree.c b/cache-tree.c
index 11bf1fcae6e1..011cfd01c565 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -452,7 +452,7 @@ static int update_one(struct cache_tree *it,
 	return i;
 }
 
-int cache_tree_update(struct index_state *istate, int flags)
+int cache_tree_update(struct repository *r, struct index_state *istate, int flags)
 {
 	int skip, i;
 
@@ -467,10 +467,10 @@ int cache_tree_update(struct index_state *istate, int flags)
 		istate->cache_tree = cache_tree();
 
 	trace_performance_enter();
-	trace2_region_enter("cache_tree", "update", the_repository);
+	trace2_region_enter("cache_tree", "update", r);
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
-	trace2_region_leave("cache_tree", "update", the_repository);
+	trace2_region_leave("cache_tree", "update", r);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
 		return i;
@@ -654,12 +654,14 @@ static int write_index_as_tree_internal(struct object_id *oid,
 					int flags,
 					const char *prefix)
 {
+	struct repository *r = the_repository;
+
 	if (flags & WRITE_TREE_IGNORE_CACHE_TREE) {
 		cache_tree_free(&index_state->cache_tree);
 		cache_tree_valid = 0;
 	}
 
-	if (!cache_tree_valid && cache_tree_update(index_state, flags) < 0)
+	if (!cache_tree_valid && cache_tree_update(r, index_state, flags) < 0)
 		return WRITE_TREE_UNMERGED_INDEX;
 
 	if (prefix) {
diff --git a/cache-tree.h b/cache-tree.h
index 8efeccebfc9f..b905a738b71a 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -33,7 +33,7 @@ void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
 int cache_tree_fully_valid(struct cache_tree *);
-int cache_tree_update(struct index_state *, int);
+int cache_tree_update(struct repository *r, struct index_state *, int);
 void cache_tree_verify(struct repository *, struct index_state *);
 
 /* bitmasks to write_index_as_tree flags */
@@ -62,9 +62,11 @@ static inline int write_cache_as_tree(struct object_id *oid, int flags, const ch
 
 static inline int update_main_cache_tree(int flags)
 {
+	struct repository *r = the_repository;
+
 	if (!the_index.cache_tree)
 		the_index.cache_tree = cache_tree();
-	return cache_tree_update(&the_index, flags);
+	return cache_tree_update(r, r->index, flags);
 }
 #endif
 
diff --git a/sequencer.c b/sequencer.c
index d2332d3e1787..b0fad54ae5a4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -677,10 +677,10 @@ static int do_recursive_merge(struct repository *r,
 	return !clean;
 }
 
-static struct object_id *get_cache_tree_oid(struct index_state *istate)
+static struct object_id *get_cache_tree_oid(struct repository *r, struct index_state *istate)
 {
 	if (!cache_tree_fully_valid(istate->cache_tree))
-		if (cache_tree_update(istate, 0)) {
+		if (cache_tree_update(r, istate, 0)) {
 			error(_("unable to update cache tree"));
 			return NULL;
 		}
@@ -710,7 +710,7 @@ static int is_index_unchanged(struct repository *r)
 	if (parse_commit(head_commit))
 		return -1;
 
-	if (!(cache_tree_oid = get_cache_tree_oid(istate)))
+	if (!(cache_tree_oid = get_cache_tree_oid(r, istate)))
 		return -1;
 
 	return oideq(cache_tree_oid, get_commit_tree_oid(head_commit));
diff --git a/sparse-index.c b/sparse-index.c
index 56313e805d9d..0638b66204e6 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -135,6 +135,8 @@ int set_sparse_index_config(struct repository *repo, int enable)
 int convert_to_sparse(struct index_state *istate)
 {
 	int test_env;
+	struct repository *r= the_repository;
+
 	if (istate->split_index || istate->sparse_index ||
 	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
 		return 0;
@@ -169,7 +171,7 @@ int convert_to_sparse(struct index_state *istate)
 		return -1;
 	}
 
-	if (cache_tree_update(istate, 0)) {
+	if (cache_tree_update(r, istate, 0)) {
 		warning(_("unable to update cache-tree, staying full"));
 		return -1;
 	}
@@ -183,7 +185,7 @@ int convert_to_sparse(struct index_state *istate)
 
 	/* Clear and recompute the cache-tree */
 	cache_tree_free(&istate->cache_tree);
-	cache_tree_update(istate, 0);
+	cache_tree_update(r, istate, 0);
 
 	istate->sparse_index = 1;
 	trace2_region_leave("index", "convert_to_sparse", istate->repo);
@@ -224,6 +226,7 @@ void ensure_full_index(struct index_state *istate)
 	int i;
 	struct index_state *full;
 	struct strbuf base = STRBUF_INIT;
+	struct repository *r = the_repository;
 
 	if (!istate || !istate->sparse_index)
 		return;
@@ -287,7 +290,7 @@ void ensure_full_index(struct index_state *istate)
 
 	/* Clear and recompute the cache-tree */
 	cache_tree_free(&istate->cache_tree);
-	cache_tree_update(istate, 0);
+	cache_tree_update(r, istate, 0);
 
 	trace2_region_leave("index", "ensure_full_index", istate->repo);
 }
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 6a3f88f5f5d4..e6d57f9900f6 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -64,6 +64,6 @@ int cmd__dump_cache_tree(int ac, const char **av)
 		die("unable to read index file");
 	istate = the_index;
 	istate.cache_tree = another;
-	cache_tree_update(&istate, WRITE_TREE_DRY_RUN);
+	cache_tree_update(the_repository, &istate, WRITE_TREE_DRY_RUN);
 	return dump_cache_tree(active_cache_tree, another, "");
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index 0b888dab2246..e6bf576e174a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1571,7 +1571,7 @@ static int verify_absent(const struct cache_entry *,
  */
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
-	struct repository *repo = the_repository;
+	struct repository *r = the_repository;
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
@@ -1581,10 +1581,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 
 	trace_performance_enter();
-	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
+	trace2_region_enter("unpack_trees", "unpack_trees", r);
 
-	prepare_repo_settings(repo);
-	if (repo->settings.command_requires_full_index) {
+	prepare_repo_settings(r);
+	if (r->settings.command_requires_full_index) {
 		ensure_full_index(o->src_index);
 		ensure_full_index(o->dst_index);
 	}
@@ -1662,9 +1662,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		}
 
 		trace_performance_enter();
-		trace2_region_enter("unpack_trees", "traverse_trees", the_repository);
+		trace2_region_enter("unpack_trees", "traverse_trees", r);
 		ret = traverse_trees(o->src_index, len, t, &info);
-		trace2_region_leave("unpack_trees", "traverse_trees", the_repository);
+		trace2_region_leave("unpack_trees", "traverse_trees", r);
 		trace_performance_leave("traverse_trees");
 		if (ret < 0)
 			goto return_failed;
@@ -1732,9 +1732,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		move_index_extensions(&o->result, o->src_index);
 		if (!ret) {
 			if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
-				cache_tree_verify(the_repository, &o->result);
+				cache_tree_verify(r, &o->result);
 			if (!cache_tree_fully_valid(o->result.cache_tree))
-				cache_tree_update(&o->result,
+				cache_tree_update(r,
+						  &o->result,
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);
 		}
@@ -1750,7 +1751,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 done:
 	if (free_pattern_list)
 		clear_pattern_list(&pl);
-	trace2_region_leave("unpack_trees", "unpack_trees", the_repository);
+	trace2_region_leave("unpack_trees", "unpack_trees", r);
 	trace_performance_leave("unpack_trees");
 	return ret;
 

base-commit: 2e85e4c16a11f3ffa9bf5a433a72618331e1fb70
-- 
gitgitgadget
