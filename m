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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8EBC433E0
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 19:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D2661A39
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 19:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhCYTtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 15:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCYTs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 15:48:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7E8C06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 12:48:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c8so3463006wrq.11
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 12:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/mhlDtWgyzr0SPTD0uwgpoBlXewxPGypcM5mkC9EG24=;
        b=OzFm1WPfDZJh9qlGjl4eEGwg+a05hqlX7YRxd10fyiAus34pvNSqQTlAWwbpKGG9AB
         yOfBlNORMbkSU5C2HXKzZek03ruBkuyO563kttBgeEEW3nel/Qwgj+ys89Nuhy2XY1sF
         6l0vVRcxRHQHMNRjrW+LhwwKect4uAZ/HqnqvNAAcOnG5rvgZWCmD37v38ePmpZySAmu
         Q5wL+CTkLoVR+UhTHjgiOL9xehErSC0gF8/DsE9IK8RxtCM5zr8EMxy3C9S0gw/zLkOw
         zg2fUXNcxaH1E3fcUAPjLrE7dw2sVBIzr+swVhQOydP7KVNQT/HvTnQSkVvt8y/ezUFz
         Dqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/mhlDtWgyzr0SPTD0uwgpoBlXewxPGypcM5mkC9EG24=;
        b=jIAjUDzqpsB6aiqkJzgKxmjJgHLXqMKqao4jU/Uadt8alnJcZ4Y4pos5pKgVhiMrHP
         Tg3SdhKX2jsAm/bmj5JqCShVa4ILFB4uV2jTiNOZZ25Fb57NJUbX4J5kbxn5xVAv1LJG
         3xMHHTBkUaMp+Szisd5aEHOiVA1O/r1cM/REnCmBI0TPrWfHTj+mILBV6beoEnmbhA/s
         FSVwJDntycEeab0tTn7vhcxOt5U5O7U5LUIHDvt9Vi+TDsiI12vcrDc5Pqvvusxpxfiz
         z+qYbmtKf955tjkldRa3ZMedFddrySrLm3vNLuzjvT5U1Bya4FghOK1gx4u9wznvm6/p
         FfFQ==
X-Gm-Message-State: AOAM533Ob9ThyGHhRKP8iRhyaR6mSaT7q4BU++QtE1pVeEtih/FHKBHG
        PAYGV2NTYe4KBGXbvzx4BFJvE52elq8=
X-Google-Smtp-Source: ABdhPJx63BKX7WX+y2wqtrUi64g6GEw+lsh+UvaaKNmMHS4eutosVLY5a2mJjVWw5OTTtGr7if1fbQ==
X-Received: by 2002:adf:f8cd:: with SMTP id f13mr10365593wrq.27.1616701735493;
        Thu, 25 Mar 2021 12:48:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m15sm8308014wrp.96.2021.03.25.12.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:48:55 -0700 (PDT)
Message-Id: <pull.915.git.1616701733901.gitgitgadget@gmail.com>
From:   "Chinmoy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Mar 2021 19:48:53 +0000
Subject: [PATCH] cache-tree.c: remove implicit dependency on the_repository
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-915%2Fchinmoy12c%2Fissue_379-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-915/chinmoy12c/issue_379-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/915

 builtin/checkout.c              |  3 ++-
 cache-tree.c                    | 12 ++++++------
 cache-tree.h                    |  6 ++++--
 sequencer.c                     |  6 +++---
 t/helper/test-dump-cache-tree.c |  2 +-
 unpack-trees.c                  | 14 ++++++++------
 6 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2d6550bc3c86..3bc630ef64e7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -684,6 +684,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	int ret;
 	struct lock_file lock_file = LOCK_INIT;
 	struct tree *new_tree;
+	struct repository *r = the_repository;
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(NULL) < 0)
@@ -822,7 +823,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	}
 
 	if (!cache_tree_fully_valid(active_cache_tree))
-		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
+		cache_tree_update(r, r->index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
diff --git a/cache-tree.c b/cache-tree.c
index add1f0771317..7ce33dc87cf7 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -433,7 +433,7 @@ static int update_one(struct cache_tree *it,
 	return i;
 }
 
-int cache_tree_update(struct index_state *istate, int flags)
+int cache_tree_update(struct repository *r, struct index_state *istate, int flags)
 {
 	int skip, i;
 
@@ -446,10 +446,10 @@ int cache_tree_update(struct index_state *istate, int flags)
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
@@ -638,7 +638,7 @@ static int write_index_as_tree_internal(struct object_id *oid,
 		cache_tree_valid = 0;
 	}
 
-	if (!cache_tree_valid && cache_tree_update(index_state, flags) < 0)
+	if (!cache_tree_valid && cache_tree_update(the_repository, index_state, flags) < 0)
 		return WRITE_TREE_UNMERGED_INDEX;
 
 	if (prefix) {
@@ -746,13 +746,13 @@ void prime_cache_tree(struct repository *r,
 		      struct index_state *istate,
 		      struct tree *tree)
 {
-	trace2_region_enter("cache-tree", "prime_cache_tree", the_repository);
+	trace2_region_enter("cache-tree", "prime_cache_tree", r);
 	cache_tree_free(&istate->cache_tree);
 	istate->cache_tree = cache_tree();
 
 	prime_cache_tree_rec(r, istate->cache_tree, tree);
 	istate->cache_changed |= CACHE_TREE_CHANGED;
-	trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
+	trace2_region_leave("cache-tree", "prime_cache_tree", r);
 }
 
 /*
diff --git a/cache-tree.h b/cache-tree.h
index 8efeccebfc9f..80cc38f176c2 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -33,7 +33,7 @@ void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
 int cache_tree_fully_valid(struct cache_tree *);
-int cache_tree_update(struct index_state *, int);
+int cache_tree_update(struct repository *, struct index_state *, int);
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
index 848204d3dc3f..dee2d2aac5d6 100644
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
index 9af8e796b338..54bf9a7300b8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1574,12 +1574,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
 	int free_pattern_list = 0;
+	struct repository *r = the_repository;
 
 	if (len > MAX_UNPACK_TREES)
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 
 	trace_performance_enter();
-	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
+	trace2_region_enter("unpack_trees", "unpack_trees", r);
 
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
@@ -1654,9 +1655,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
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
@@ -1724,9 +1725,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
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
@@ -1742,7 +1744,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 done:
 	if (free_pattern_list)
 		clear_pattern_list(&pl);
-	trace2_region_leave("unpack_trees", "unpack_trees", the_repository);
+	trace2_region_leave("unpack_trees", "unpack_trees", r);
 	trace_performance_leave("unpack_trees");
 	return ret;
 

base-commit: 142430338477d9d1bb25be66267225fb58498d92
-- 
gitgitgadget
