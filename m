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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D00C432BE
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC2A60ED8
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhHJTur (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 15:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhHJTun (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 15:50:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DE8C0613D3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q10so4585750wro.2
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 12:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=siV5lRTXPuRg8PtQx00TLBS2bGCepL9AAAoIBksPutM=;
        b=Am07ueTagsuq2yEXcTQYjhPaWv0NT+SKDCW8kXmXV9T6klU00pibqA5dGD/6nuf7rI
         JefOGxvwS2aWeQ2LRFjM6frVX59eC//hjcGwldlV9IQZGLcohZXN3JSOnsoiXKLR3apl
         09PxTvxnwMpPzffHV3X4ibT/e4ktRYMvqZ6uTaRMyR2xdxxmJkpuKcZwFtnV7tWS2qCi
         L0cseT7Jrd0br21o6rce5KuC7qN4bUw18IxMhVtyuUpwpyXJ2oUOLgS83U4hZ+49ZTdk
         qdXFKkF+RJgB/Kr6a692+L3qfgi/pqdvfthBo45vyabjJIsl67EKT8tDQo6QhLkmbHx2
         hzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=siV5lRTXPuRg8PtQx00TLBS2bGCepL9AAAoIBksPutM=;
        b=a5+64oXqFFOWwnM74OL8srfi55R8nCVkpEUsAKaX3sIlPq7Rg+OK3UTemASwxO1/jT
         UGOR/J71oPOL5Pv8ww0YNzkw3fiTeTA4nBHsYK6oH/VI7KaqlwhHX0IbPUyKPCPpYKbl
         HDdJmXUCCKgyEW4e88sB/iaxWby+PI3fpP9avifI6diNQqmsyrgrtvXmkLbV+9EXiRQP
         mXC06ShCOsVVCmfTYUPfhNDQfvi5TG13kaWxNmDjBl8sbTj9CyuO5nvdbZG4mAsi/U2K
         hoqOf4iMZGHkcpdW3i7xpuzU8SzDfcWlV/ffZFO2DG9P4v6OVX0Eg4dvJfYRWwpjj6Rm
         ZjZA==
X-Gm-Message-State: AOAM53122cu1ezx12LN8Sn5WzosfDxqR40vvOz6HfpCaEk2BF4LfjQeq
        tEALUZzgNLg0yoXFqgTYCHrXXtv2gFc=
X-Google-Smtp-Source: ABdhPJyJeB4QRYAAVGqSsJyea3UD+m4C4+jhJ+VwOgAOqwc3KQ9hclk8Z/7jXTDijotKQKuiK0p6CA==
X-Received: by 2002:adf:dc05:: with SMTP id t5mr2354572wri.326.1628625019555;
        Tue, 10 Aug 2021 12:50:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm13921974wrh.88.2021.08.10.12.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 12:50:19 -0700 (PDT)
Message-Id: <1dd73b36eb493fbd3f7a7c964e57179a4ae26523.1628625014.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
        <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Aug 2021 19:50:12 +0000
Subject: [PATCH v2 7/8] sparse-index: add SPARSE_INDEX_IGNORE_CONFIG flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The convert_to_sparse() method checks for the GIT_TEST_SPARSE_INDEX
environment variable or the "index.sparse" config setting before
converting the index to a sparse one. This is for ease of use since all
current consumers are preparing to compress the index before writing it
to disk. If these settings are not enabled, then convert_to_sparse()
silently returns without doing anything.

We will add a consumer in the next change that wants to use the sparse
index as an in-memory data structure, regardless of whether the on-disk
format should be sparse.

To that end, create the SPARSE_INDEX_IGNORE_CONFIG flag that will skip
these config checks when enabled. All current consumers are modified to
pass '0' in the new 'flags' parameter.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 read-cache.c   |  4 ++--
 sparse-index.c | 30 ++++++++++++++++--------------
 sparse-index.h |  3 ++-
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 9048ef9e905..f5d4385c408 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3069,7 +3069,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	int ret;
 	int was_full = !istate->sparse_index;
 
-	ret = convert_to_sparse(istate);
+	ret = convert_to_sparse(istate, 0);
 
 	if (ret) {
 		warning(_("failed to convert to a sparse-index"));
@@ -3182,7 +3182,7 @@ static int write_shared_index(struct index_state *istate,
 	int ret, was_full = !istate->sparse_index;
 
 	move_cache_to_base_index(istate);
-	convert_to_sparse(istate);
+	convert_to_sparse(istate, 0);
 
 	trace2_region_enter_printf("index", "shared/do_write_index",
 				   the_repository, "%s", get_tempfile_path(*temp));
diff --git a/sparse-index.c b/sparse-index.c
index 2efc9fd4910..532fd11787e 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -124,7 +124,7 @@ static int index_has_unmerged_entries(struct index_state *istate)
 	return 0;
 }
 
-int convert_to_sparse(struct index_state *istate)
+int convert_to_sparse(struct index_state *istate, int flags)
 {
 	int test_env;
 
@@ -135,20 +135,22 @@ int convert_to_sparse(struct index_state *istate)
 	if (!istate->repo)
 		istate->repo = the_repository;
 
-	/*
-	 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
-	 * index.sparse config variable to be on.
-	 */
-	test_env = git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
-	if (test_env >= 0)
-		set_sparse_index_config(istate->repo, test_env);
+	if (!(flags & SPARSE_INDEX_IGNORE_CONFIG)) {
+		/*
+		 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
+		 * index.sparse config variable to be on.
+		 */
+		test_env = git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
+		if (test_env >= 0)
+			set_sparse_index_config(istate->repo, test_env);
 
-	/*
-	 * Only convert to sparse if index.sparse is set.
-	 */
-	prepare_repo_settings(istate->repo);
-	if (!istate->repo->settings.sparse_index)
-		return 0;
+		/*
+		 * Only convert to sparse if index.sparse is set.
+		 */
+		prepare_repo_settings(istate->repo);
+		if (!istate->repo->settings.sparse_index)
+			return 0;
+	}
 
 	if (init_sparse_checkout_patterns(istate) < 0)
 		return 0;
diff --git a/sparse-index.h b/sparse-index.h
index 1115a0d7dd9..475f4f0f8da 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -2,7 +2,8 @@
 #define SPARSE_INDEX_H__
 
 struct index_state;
-int convert_to_sparse(struct index_state *istate);
+#define SPARSE_INDEX_IGNORE_CONFIG (1 << 0)
+int convert_to_sparse(struct index_state *istate, int flags);
 
 /*
  * Some places in the codebase expect to search for a specific path.
-- 
gitgitgadget

