Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AE6C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047E822EBE
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 19:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbhAWT7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 14:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAWT7E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 14:59:04 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0659C0613D6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:23 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 6so8375959wri.3
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 11:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VNwHDx/owv/iw0AULzqRDsjmoZuBpRiDxJMwBI85Ozc=;
        b=rn1JIF5mlYAb1p7LqO8EmQ2WuNegHFc/WqTci/6x5VK3VS1JbU4hXNYL4XJCm8UmOQ
         qsPN5BnAT8QYYHpho7cPSiz7g7U5GUoYdXfEK0u/BnxQFWRjjDwsahIqpAFYVsb5cd+p
         STkvCYFpmCAnF/Wsfqa0yBMsqiNEaf6+Gu/9tSSL2iu3t3TbMKhnfL76HFsLZvfMR9YL
         JJxHmJTZa+4b8R9Fqcd8cLscPB35tLRxmgmcY3IxHsepfHcFSUQP9g9EuzMGcWhlnjQp
         UZBvvWD3bOCrR/AiUoRbP1xWKDkw+9kNeWr2GTGFAS0cFEGU2krR8ioi5X8CK5x8rIwA
         CKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VNwHDx/owv/iw0AULzqRDsjmoZuBpRiDxJMwBI85Ozc=;
        b=bs9HI2X0nFjN5QD6aGGaTw7Tr5yn0Xrgx8lDmte5hkLmmzRNZ2qo40GfL1AxX0wnUu
         wAnwr/v0hBOw4pXI21NdHZkGaeVw9ZCQ2Jx0YNMFG4LNOpemK0uA8niDreDBVp8l+24n
         fP0suGv9iNg2gimOrdKhtc3gr8xb9Kb/iVnv2lmpqUPUaMR8hnt87SpKsT4h8yPqso8V
         Afr5OU8SQSrqGb+NrZOyfzJ/xnvIAVRL0HmqCGR1Kk7N8j0mCg5QnpIJIXU5qoS4B9z3
         lxmExak2lbvZVaGrAXGwNbd9n2NqVviu6oyy5h9kRllypy8ZYaG71ZmfQPtL1mhQW0MK
         uOeg==
X-Gm-Message-State: AOAM531zpnOrnijkuAt7B8qcOYRF3jN9KZq9Za1yjYxE4dJJHhURA+Sx
        3kKUglMPUAJ2+wZ2KrbouCQ+6S7nNNc=
X-Google-Smtp-Source: ABdhPJxKFO4YxLP6wfZjgh4pUBvX2grXcLfGlAnuxk8hlEYNDgf8HAQIHk+V+SZgIyeYaGsECo2eKQ==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr10451169wrq.352.1611431902113;
        Sat, 23 Jan 2021 11:58:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4sm4663879wrn.12.2021.01.23.11.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 11:58:21 -0800 (PST)
Message-Id: <bdc8ecca3d2a2fbdb1d8bf10222382c14986aa56.1611431899.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
        <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jan 2021 19:58:11 +0000
Subject: [PATCH v3 1/9] cache-tree: clean up cache_tree_update()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <stolee@gmail.com>,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Make the method safer by allocating a cache_tree member for the given
index_state if it is not already present. This is preferrable to a
BUG() statement or returning with an error because future callers will
want to populate an empty cache-tree using this method.

Callers can also remove their conditional allocations of cache_tree.

Also drop local variables that can be found directly from the 'istate'
parameter.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/checkout.c |  3 ---
 cache-tree.c       | 17 +++++++++--------
 sequencer.c        |  3 ---
 unpack-trees.c     |  2 --
 4 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index c9ba23c2794..2d6550bc3c8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -821,9 +821,6 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		}
 	}
 
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
-
 	if (!cache_tree_fully_valid(active_cache_tree))
 		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
 
diff --git a/cache-tree.c b/cache-tree.c
index 3f1a8d4f1b7..60b6aefbf51 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -436,16 +436,20 @@ static int update_one(struct cache_tree *it,
 
 int cache_tree_update(struct index_state *istate, int flags)
 {
-	struct cache_tree *it = istate->cache_tree;
-	struct cache_entry **cache = istate->cache;
-	int entries = istate->cache_nr;
-	int skip, i = verify_cache(cache, entries, flags);
+	int skip, i;
+
+	i = verify_cache(istate->cache, istate->cache_nr, flags);
 
 	if (i)
 		return i;
+
+	if (!istate->cache_tree)
+		istate->cache_tree = cache_tree();
+
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", the_repository);
-	i = update_one(it, cache, entries, "", 0, &skip, flags);
+	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
+		       "", 0, &skip, flags);
 	trace2_region_leave("cache_tree", "update", the_repository);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
@@ -635,9 +639,6 @@ static int write_index_as_tree_internal(struct object_id *oid,
 		cache_tree_valid = 0;
 	}
 
-	if (!index_state->cache_tree)
-		index_state->cache_tree = cache_tree();
-
 	if (!cache_tree_valid && cache_tree_update(index_state, flags) < 0)
 		return WRITE_TREE_UNMERGED_INDEX;
 
diff --git a/sequencer.c b/sequencer.c
index 8909a467700..aa3e4c81cf0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -679,9 +679,6 @@ static int do_recursive_merge(struct repository *r,
 
 static struct object_id *get_cache_tree_oid(struct index_state *istate)
 {
-	if (!istate->cache_tree)
-		istate->cache_tree = cache_tree();
-
 	if (!cache_tree_fully_valid(istate->cache_tree))
 		if (cache_tree_update(istate, 0)) {
 			error(_("unable to update cache tree"));
diff --git a/unpack-trees.c b/unpack-trees.c
index af6e9b9c2fd..a810b79657e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1726,8 +1726,6 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		if (!ret) {
 			if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
 				cache_tree_verify(the_repository, &o->result);
-			if (!o->result.cache_tree)
-				o->result.cache_tree = cache_tree();
 			if (!cache_tree_fully_valid(o->result.cache_tree))
 				cache_tree_update(&o->result,
 						  WRITE_TREE_SILENT |
-- 
gitgitgadget

