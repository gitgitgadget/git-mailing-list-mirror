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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C89C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BAB60FEA
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhGTUBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbhGTTeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:34:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E77C0613E0
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o30-20020a05600c511eb029022e0571d1a0so241528wms.5
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RvvnRwo1YQanCRaIT8C+DPSrYl16RvceDnNq1bSckRM=;
        b=F53EutLrNah01quYiYNnT61j9H6Cx5FJ+pmx2GDwZmoRsBfoRIUMgasVA0HAYu1gf2
         AnxCok12NpWb6esClgEKLYnbRaf0zbZI+CbziaVsB1uaDJg/QB0PxvdxWVk808DHOhOh
         PjbF+GGkS4gQm/OStkjDCHSmkFc39p/XJMg4JjPfg4c3iQnrsoE0Mcr2XyL0uAisJ/E2
         M52V852VzSb4VURVsfFuL3G6tk34rDRbv1Z8UwrSiih+oLZkpjkeiBgJXaV4I0EqZcCo
         yQacKpnruwH8zHKmIbZmlf+e8w54/5kU/prQd7KDzuHMkjhfkUInf2a8OPPNBC/BbYyI
         EDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RvvnRwo1YQanCRaIT8C+DPSrYl16RvceDnNq1bSckRM=;
        b=Y/yl5g/7yTz9US81LWoJ1VJ4cXtlBpNT3pDNGsNZ42bs+CsGO0rcMx0D/8IxzusJzX
         SkAOONuHOQ6zGcX28umpRXfMkQ8zkyPrJinPV2XH78hw+YaIksmd81Rrmu2urDicP44u
         rc0Rcjfc11z4l+Xkl3wZyWh5e+hW76grpEDnZJPQWFBr0hp3d7PD5nsL4ii+tXhBTG/n
         aWlt3L/J+umckTjTD+BjBGERF7JxRzm4UQgYVKevGjUuAvyPaF/PQZzhPhCQxbdZjo4b
         7KAm2WD7YSPktpJA5mUVS6Iw3KfCWAREJz0pIulMPnG/FWD1Hur4WV6qHfRqdUdllZpN
         rCDQ==
X-Gm-Message-State: AOAM530ApisiTDWg3V1zvt0df7sf2aJ8OA3UR4jyyLT22mAotIgBeRJI
        DXO3yFDHx/6rgnwwCHNtmdssni4hoGc=
X-Google-Smtp-Source: ABdhPJyGqPtA5oJLcVCw7Bsvc99aVJ/rYg44ThYMGz2QbQaavJWoVZpqSX0zd1XRp9u8wS+N1E0Uow==
X-Received: by 2002:a05:600c:3510:: with SMTP id h16mr784921wmq.65.1626812083983;
        Tue, 20 Jul 2021 13:14:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm23831061wrq.88.2021.07.20.13.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 13:14:43 -0700 (PDT)
Message-Id: <cd94f820052c948e522f947a05797ebaf1907121.1626812081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
        <pull.973.v2.git.1626812081.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 20:14:37 +0000
Subject: [PATCH v2 3/7] commit: integrate with sparse-index
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

Update 'git commit' to allow using the sparse-index in memory without
expanding to a full one. The only place that had an ensure_full_index()
call was in cache_tree_update(). The recursive algorithm for
update_one() was already updated in 2de37c536 (cache-tree: integrate
with sparse directory entries, 2021-03-03) to handle sparse directory
entries in the index.

Most of this change involves testing different command-line options that
allow specifying which on-disk changes should be included in the commit.
This includes no options (only take currently-staged changes), -a (take
all tracked changes), and --include (take a list of specific changes).
To simplify testing that these options do not expand the index, update
the test that previously verified that 'git status' does not expand the
index with a helper method, ensure_not_expanded().

This allows 'git commit' to operate much faster when the sparse-checkout
cone is much smaller than the full list of files at HEAD.

Here are the relevant lines from p2000-sparse-operations.sh:

Test                                      HEAD~1           HEAD
----------------------------------------------------------------------------------
2000.14: git commit -a -m A (full-v3)     0.35(0.26+0.06)  0.36(0.28+0.07) +2.9%
2000.15: git commit -a -m A (full-v4)     0.32(0.26+0.05)  0.34(0.28+0.06) +6.3%
2000.16: git commit -a -m A (sparse-v3)   0.63(0.59+0.06)  0.04(0.05+0.05) -93.7%
2000.17: git commit -a -m A (sparse-v4)   0.64(0.59+0.08)  0.04(0.04+0.04) -93.8%

It is important to compare the full-index case to the sparse-index case,
so the improvement for index version v4 is actually an 88% improvement in
this synthetic example.

In a real repository with over two million files at HEAD and 60,000
files in the sparse-checkout definition, the time for 'git commit -a'
went from 2.61 seconds to 134ms. I compared this to the result if the
index only contained the paths in the sparse-checkout definition and
found the theoretical optimum to be 120ms, so the out-of-cone paths only
add a 12% overhead.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit.c                         |  3 ++
 cache-tree.c                             |  2 -
 t/t1092-sparse-checkout-compatibility.sh | 47 ++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 12f51db158a..0bc64892505 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1682,6 +1682,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	status_init_config(&s, git_commit_config);
 	s.commit_template = 1;
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
diff --git a/cache-tree.c b/cache-tree.c
index 45e58666afc..577b18d8811 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -461,8 +461,6 @@ int cache_tree_update(struct index_state *istate, int flags)
 	if (i)
 		return i;
 
-	ensure_full_index(istate);
-
 	if (!istate->cache_tree)
 		istate->cache_tree = cache_tree();
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index cabbd42e339..d3e34d0acac 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -262,6 +262,34 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
+test_expect_success 'commit including unstaged changes' '
+	init_repos &&
+
+	write_script edit-file <<-\EOF &&
+	echo $1 >$2
+	EOF
+
+	run_on_all ../edit-file 1 a &&
+	run_on_all ../edit-file 1 deep/a &&
+
+	test_all_match git commit -m "-a" -a &&
+	test_all_match git status --porcelain=v2 &&
+
+	run_on_all ../edit-file 2 a &&
+	run_on_all ../edit-file 2 deep/a &&
+
+	test_all_match git commit -m "--include" --include deep/a &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git commit -m "--include" --include a &&
+	test_all_match git status --porcelain=v2 &&
+
+	run_on_all ../edit-file 3 a &&
+	run_on_all ../edit-file 3 deep/a &&
+
+	test_all_match git commit -m "--amend" -a --amend &&
+	test_all_match git status --porcelain=v2
+'
+
 test_expect_success 'status/add: outside sparse cone' '
 	init_repos &&
 
@@ -514,14 +542,25 @@ test_expect_success 'sparse-index is expanded and converted back' '
 	test_region index ensure_full_index trace2.txt
 '
 
-test_expect_success 'sparse-index is not expanded' '
-	init_repos &&
-
+ensure_not_expanded () {
 	rm -f trace2.txt &&
 	echo >>sparse-index/untracked.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index status &&
+		git -C sparse-index "$@" &&
 	test_region ! index ensure_full_index trace2.txt
+}
+
+test_expect_success 'sparse-index is not expanded' '
+	init_repos &&
+
+	ensure_not_expanded status &&
+	ensure_not_expanded commit --allow-empty -m empty &&
+	echo >>sparse-index/a &&
+	ensure_not_expanded commit -a -m a &&
+	echo >>sparse-index/a &&
+	ensure_not_expanded commit --include a -m a &&
+	echo >>sparse-index/deep/deeper1/a &&
+	ensure_not_expanded commit --include deep/deeper1/a -m deeper
 '
 
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
-- 
gitgitgadget

