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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0838EC11F65
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41C361CE5
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhF2CH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhF2CHY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:07:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA82C061760
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:04:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p8-20020a7bcc880000b02901dbb595a9f1so1277949wma.2
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cO98IPJ5A+rusUCsSXexJohE9wZWdkoHGqzHKeEQ398=;
        b=qfdOlKhb02L1895IRL2vetenfbM26wNgVXi0xpWs98dM4rKjA/AkQEESuWgID1HDYx
         nw1sabl/EWOoaSFEf3We8BwjJeWbWVK8LtHg1spNyBqY6cWyjr2MWlmqCBG4aRNkOAU3
         SZ5rjPDj8vPVACw4w6gVlxzL1Y7g10HyjhmC9EeLDmjJcSjXX/vl8crFo3Mmqa9AsWzj
         tm8N9LhRZRgHboLLl/iXMEOClVNqe+5Mwe9JQc+1S83PW+JVm/7TvYCiHYB9eG/B+94w
         y+DfQp3GEyU4Rh/q49SqWkKgGJpey3Upc3kzr+FpXN4nfcuST2I+miADUuyYAdJ+IawN
         hMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cO98IPJ5A+rusUCsSXexJohE9wZWdkoHGqzHKeEQ398=;
        b=MaH4bd1xLbFEyBJA0NOKAbp9X0VXbkJnusqDF89FqM4FWZF1ZHVjD2jIGxa8Pb/pHX
         Lqx6vu0KpEl+LetvtFGpwT1zwDnn1dUns5uw5fZSqO62wG5ZaOjy6GFqBc9dCYRm1kQ1
         VpWerbkIToqucIuyPthoCMNH8OYK8HiXp2gmJvft/SuvQ24YMeU5Iah1HNVEgI27Dw/k
         pwuERLjMJs2cnd7/NiKfG/NUh20WIam40iZdnw1Am9jjUeVFR7dvWHU0gkQsH6ti/lqx
         ntxe9uBJuiLvyY9w+/5GtfSnDWdcHW6PCZSspH4MZv2GUzLisQvKKLvWpbGMxvTGGAn9
         BN+A==
X-Gm-Message-State: AOAM5326H5lyEX0alESQfB77QCYDtpuMAiS354ygf8tGeFpuojXoOJ7O
        EgBdTB3jNIWm1fA3cqU6Ue50KI04bZ4=
X-Google-Smtp-Source: ABdhPJz3oPPMa0J0rRzjEPkmvtTdYULELTnGWYo42/swc8yFSXy33H/sCgFuuacZhxuVa4O/6vS5KA==
X-Received: by 2002:a1c:4c0c:: with SMTP id z12mr29894144wmf.0.1624932295647;
        Mon, 28 Jun 2021 19:04:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8sm15936589wri.91.2021.06.28.19.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:04:55 -0700 (PDT)
Message-Id: <2a4a7256304c44f168baf54ff1bdc191be67408f.1624932293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
        <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:04:38 +0000
Subject: [PATCH v7 01/16] sparse-index: skip indexes with unmerged entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
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
index affc4048f27..2c695930275 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -116,6 +116,17 @@ int set_sparse_index_config(struct repository *repo, int enable)
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
@@ -152,6 +163,13 @@ int convert_to_sparse(struct index_state *istate)
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
index e9a815ca7aa..ba2fd94adaf 100755
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

