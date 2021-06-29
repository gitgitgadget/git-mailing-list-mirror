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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2D4C11F65
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BDD61CEB
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhF2CPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhF2CPi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:15:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB02DC061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:13:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y3so4308660wrq.3
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JKN67tv2Als0pC/pVRxM3lKN49x/Ibl77IIvVabOAvA=;
        b=k+alzN/vu2leZSbjbJKS5lAocR5F6EXmcZFOpQNg6qkLs4/dVw5mGWcmJNFf7oXc6Q
         iwGAgXosW5nUWyYLOAd/SD2OhiF4oFC+2YnFsyqMLMvdmQ+9pUPr62gIC4QHbs3V7qqx
         19bMcOBB60mSKLBmcIqRJXZwojHC7f/Za5cJ7JlY7EuzbCrFurciZ72y1OFBSu/orduV
         CKoKtRpp/SAjhYBM0nN0H7gDNgzI/Ps/6/NlVCRdfn5I0ocu2w2vaJlRzkj4o0Nv+Tf8
         8TYCEcgngppM1wAKJMV5mcULe2/3BQSsn+hOEM6FEDdwV8JYHqeShNrIFwA9ZecfMMAm
         k63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JKN67tv2Als0pC/pVRxM3lKN49x/Ibl77IIvVabOAvA=;
        b=IpKXxgz9IgLX0addM1lw0MIXS6+3lvBRhvgcfnLbXtrh0AOFBjkD7/NiUYAWtcr/0k
         rxCMtdbpjf9IMJfVJdUngNXU3VCn5hij6wZWcSzD7iULYgpM2SI2Fb8ieHinHUh8iKNY
         nnN+Y5csiWw6iA+dDVoTn6D3t6S7eo02y3Rvp/+cwZ7GTybX5EGL8NZC3PIHAO+eX5z2
         IzBtbVg1ZkSz4gFD49LjWMOT5yP0Yo6lhdpsIHKlrcraEA3qLF2dhV8lL3XV5HG0vmqh
         iuEjyiBUcJ1k93A49yY9+Q42+MOjiDKvvJYQ5Fm9mC24RvETzIBH4dORA9K3cGDlvn4i
         WnYA==
X-Gm-Message-State: AOAM532wEGmeZqtGDwQimEdZ7r1mNeJPG1kDKa5A7vY7RT7SaPFNt9xT
        fpQh2d0QJ7JF8giOisRRvJgsX/+hiw0=
X-Google-Smtp-Source: ABdhPJyh1phAIjHOo4jR4Of39oIifCgeIizUUwjP2zt2z+c3/bx2u1InGFLj62ucUEWmAp3Cy7cg8A==
X-Received: by 2002:a05:6000:120e:: with SMTP id e14mr10795080wrx.139.1624932789520;
        Mon, 28 Jun 2021 19:13:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm16652243wrv.82.2021.06.28.19.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:13:09 -0700 (PDT)
Message-Id: <413babe6e774eb4e09b091532219980e1cca94cb.1624932786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.1624932786.gitgitgadget@gmail.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:13:04 +0000
Subject: [PATCH 3/5] commit: integrate with sparse-index
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
index df217a2d10b..11c6dc8ec1f 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -275,6 +275,34 @@ test_expect_success 'add, commit, checkout' '
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
 
@@ -535,14 +563,25 @@ test_expect_success 'sparse-index is expanded and converted back' '
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
 
 test_expect_success 'reset mixed and checkout orphan' '
-- 
gitgitgadget

