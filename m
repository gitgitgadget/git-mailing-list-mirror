Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E068C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 11:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451B06008E
	for <git@archiver.kernel.org>; Fri, 21 May 2021 11:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhEUMBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 08:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhEUMBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 08:01:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F49C061763
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z85-20020a1c7e580000b029017a76f3afbaso4476700wmc.2
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tnv8/RvaEXbX/IGlvdgT6jdK85+oA3TpgnT3UjIuqEE=;
        b=DJqtuulIFMaJcv0NaYeeZl/Bkav4zmMRilPcwbZQ87dkUgyUskvZ1K8vPo+brB+ZKa
         JXGd7jXu675i64jeuD6KIVGsh9eFLh6z/pwsTxv3mtPx0YbMVSMZnzZ2tnDagYycpPOJ
         pmtgWqe7UlWJC42S58x/cSqcNIpp7i+EzHNhyOj/psYsqyifLZtjxaI0ee194rgFVyhZ
         FpA1TN4miIqTMiKkKt/uhahnc/XBqXbMhw/8guIUrxRbvOgDUzhaiXgrEr1Z268kAysD
         Jf64AMfMh8lTtmLFrnVcWavOkIUq8qTDPJvpBqaLS3Ii+hqWojmYMXQ28lH+/RHq9sqJ
         8HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tnv8/RvaEXbX/IGlvdgT6jdK85+oA3TpgnT3UjIuqEE=;
        b=Wfire/EACSOTVqgt2NYbZhBLnQkx9Bm/45+bbFfrb5RjdbOgkBt/Uf8aVShagyq0k9
         x6VtmnAGjrhj25XIQTlsQKhdGZEvJg5fPqgMGE/BO/oin7rHBb4BN9/+5frrGRLlhiFY
         lGfDZtKL6RBW7khtZ1rZsFLmIAi7VLHgDlnuPb8JOg50GB+sz5NinhW6Dr5Mza2fEW2F
         kRaUBMUGhKPo9BbW23MOaqSK8JhuuP8IhhqgIhJs8vwKg7vM/ukU6ReoiyTSe9ZUkxI/
         5O1+qQ4FIT79CMEgFCo2TSeO0PZUv/qGgCEOUhWQt6U9sPWcVVos40eDHJAcGjZZFZ+1
         2Eqw==
X-Gm-Message-State: AOAM532hHrPvj+BdkkpNEjQ/imUB9ZuVsQIOAuZxoMb9GyMgKmwxti9o
        h83g7JUs9+prN5qm+u4E1ov7WA7VkHo=
X-Google-Smtp-Source: ABdhPJz0G0WVQVtUu3BQA3mcFIeyJL7VZA5mvq56PsPPeYnkPkvF6zHYDQf+H1gPrFaK4WIrMzxoCg==
X-Received: by 2002:a7b:c7ca:: with SMTP id z10mr8603617wmk.185.1621598384327;
        Fri, 21 May 2021 04:59:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8sm1858651wry.55.2021.05.21.04.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:59:44 -0700 (PDT)
Message-Id: <5a2ed3d1d701b11c241bf3855db3bb35f5e93994.1621598382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
References: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
        <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 May 2021 11:59:30 +0000
Subject: [PATCH v4 01/12] sparse-index: skip indexes with unmerged entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sparse-index format is designed to be compatible with merge
conflicts, even those outside the sparse-checkout definition. The reason
is that when converting a full index to a sparse one, a cache entry with
nonzero stage will not be collapsed into a sparse directory entry.

However, this behavior was not tested, and a different behavior within
convert_to_sparse() fails in this scenario. Specifically,
cache_tree_update() will fail when unmerged entries exist.
convert_to_sparse_rec() uses the cache-tree data to recursively walk the
tree structure, but also to compute the OIDs used in the
sparse-directory entries.

Add an index scan to convert_to_sparse() that will detect if these merge
conflict entries exist and skip the conversion before trying to update
the cache-tree. This is marked as NEEDSWORK because this can be removed
with a suitable update to cache_tree_update() or a similar method that
can construct a cache-tree with invalid nodes, but still allow creating
the nodes necessary for creating sparse directory entries.

It is possible that in the future we will not need to make such an
update, since if we do not expand a sparse-index into a full one, this
conversion does not need to happen. Thus, this can be deferred until the
merge machinery is made to integrate with the sparse-index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c                           | 18 ++++++++++++++++++
 t/t1092-sparse-checkout-compatibility.sh | 22 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/sparse-index.c b/sparse-index.c
index 6f21397e2ee0..1b49898d0cb7 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -125,6 +125,17 @@ int set_sparse_index_config(struct repository *repo, int enable)
 	return res;
 }
 
+static int index_has_unmerged_entries(struct index_state *istate)
+{
+	int i;
+	for (i = 0; i < istate->cache_nr; i++) {
+		if (ce_stage(istate->cache[i]))
+			return 1;
+	}
+
+	return 0;
+}
+
 int convert_to_sparse(struct index_state *istate)
 {
 	int test_env;
@@ -161,6 +172,13 @@ int convert_to_sparse(struct index_state *istate)
 		return -1;
 	}
 
+	/*
+	 * NEEDSWORK: If we have unmerged entries, then stay full.
+	 * Unmerged entries prevent the cache-tree extension from working.
+	 */
+	if (index_has_unmerged_entries(istate))
+		return 0;
+
 	if (cache_tree_update(istate, 0)) {
 		warning(_("unable to update cache-tree, staying full"));
 		return -1;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 12e6c453024f..4f2f09b53a32 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -352,6 +352,28 @@ test_expect_success 'merge with outside renames' '
 	done
 '
 
+# Sparse-index fails to convert the index in the
+# final 'git cherry-pick' command.
+test_expect_success 'cherry-pick with conflicts' '
+	init_repos &&
+
+	write_script edit-conflict <<-\EOF &&
+	echo $1 >conflict
+	EOF
+
+	test_all_match git checkout -b to-cherry-pick &&
+	run_on_all ../edit-conflict ABC &&
+	test_all_match git add conflict &&
+	test_all_match git commit -m "conflict to pick" &&
+
+	test_all_match git checkout -B base HEAD~1 &&
+	run_on_all ../edit-conflict DEF &&
+	test_all_match git add conflict &&
+	test_all_match git commit -m "conflict in base" &&
+
+	test_all_match test_must_fail git cherry-pick to-cherry-pick
+'
+
 test_expect_success 'clean' '
 	init_repos &&
 
-- 
gitgitgadget

