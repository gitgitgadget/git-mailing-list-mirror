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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B84C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC496128B
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhGNNPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhGNNPg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29D5C061760
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d12so3121284wre.13
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SXuTiAjtN9wBo6lUR7AGui1Mu+IT0oIRfVCid6w3noA=;
        b=lmCVSLrTDR/lG6Wkp4cYFSZQiTc9I839UA92fpkZD/iIX0CQCTvnfWOCFXwzZ5tlQr
         DrKjmRF43JM44DmsNOVTsSbYCLCelhy4E+aYeL8z1kQB0C9aPdxV1eI3SsvMOIoXpIcb
         iyc7ySnOK++SpAm+hYSslLAVe4EJk1du/PtoTpBWboABo8bLxtiWSUqQfYz6Ew0Zy0fP
         UQRurw9uRhYCi6XIA7xRW52kSbcR2gSo+g4I8YjiszfR7OnKdVosRwVkIQma0TDhGnXj
         Rkm205CwCWaIYr5/moTvdz9nrYc69/c8CubbfgWudccmKZHaNdRwGB0sY2wx7SXb6QMX
         dvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SXuTiAjtN9wBo6lUR7AGui1Mu+IT0oIRfVCid6w3noA=;
        b=Qlm4nssQ4rWDjRbBv58avLzdr4yHS1Z3ibeGTKi0w5uIBjlZu+tyT91Jan8nfmozax
         yUrdXoN1xvUUh6VdqYvJrycs4E6GDecNp8JWPdbi0TT8LfsAdx6p/K8OJ3erBEf3qP9G
         cvdFPUFqKJMaRwrOpGgj+UGzKj+pDHWjx3BlVQ7Mt6s41nM8URB55iNG57RuJWnVWR5+
         4aPSmdKm71SVnAfcwwcDIpGLPtu+bQhU6c78gbD9WPTNLecOpHCmPLKzW/xRjkmu6XHo
         6Wgo6G/pPC/H47YOeN3LKwGDckP3j+T8jarjHeYKMnfaOD08zKK3JeC44n2O8mAJyYnz
         PqOA==
X-Gm-Message-State: AOAM533lPv7Xr4DbY5OQlU2wF+os0g8vf0RPztcMSk72MiE4y10yVFMb
        VvBfOwDQjxHm2K9stmP4jBEzlTbdjYY=
X-Google-Smtp-Source: ABdhPJxVfoqy8aon7gid0jjcP2hZHUeCXHF46PDW5yD43VKNwT6lC1f6q5CfZ8mY6pTMNJXi5f0LIA==
X-Received: by 2002:adf:b305:: with SMTP id j5mr12643478wrd.11.1626268363392;
        Wed, 14 Jul 2021 06:12:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o22sm2097446wmc.18.2021.07.14.06.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:42 -0700 (PDT)
Message-Id: <ecab56fd57facf0ac8d5ec8abcb43cd509e6e303.1626268360.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:25 +0000
Subject: [PATCH v9 01/16] sparse-index: skip indexes with unmerged entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de, Bagas Sanjaya <bagasdotme@gmail.com>,
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

Reviewed-by: Elijah Newren <newren@gmail.com>
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
index d028b73eba1..b8617ceef71 100755
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

