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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44BAC11F67
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE956613B7
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 13:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbhGNNPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 09:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239442AbhGNNPr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 09:15:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C63C0613EF
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u1so3206669wrs.1
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vkBG3zN44i+FdrsDi5dSGrT6FLW50r0aY5gy7B8IZtg=;
        b=gRFJKJujz64QhlT2BrG9zOTRaXDTuupMc1Z9wG/Z5iu32rkuVDbbP/e02H9wS7Y/A1
         3l1ZNA1hOeKmvalo+YdeeTWfYS0RFtEslQ0oZe5VfM/2q3AYtVnpvmJWRNwYCHHRq6lR
         cMYvSwiN1V/o9vD+U3ie3z+Hxh70yOftZASk5Xr9b5PeWIDxY1FQQ/3DEpOzbtxsPH08
         1MEHzbQPYd+ipcOb8l4RYoUBxht9unRB+dmIfIlz2WF+VF7+UzZum7cuYRCw31zDOt+g
         31igH9dmVg1H+LLLdKHi5AxgoKxxNfiEuoIeagOP0oBJwW3BipdHslTaOy436V0Uf5NN
         ZdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vkBG3zN44i+FdrsDi5dSGrT6FLW50r0aY5gy7B8IZtg=;
        b=MlXcuTRiWiQU+uIG+RZ25hp1udXqg8WVjSTmzJjs6357i+2G0u7JjkGDaJgGriJUPm
         dyUBJL/HXPMkZsFWxgh2QcLum2rwtnMzgUHJqc5N7M8aWVM4I1/ZqmT4MMPu7ebFXd2K
         ohTpaCIa1F1RCZmZOf5AQ8OTIoer89cAkcn1vioMVK/WqIj3pEqAly2u1HN8Vpj/LnJ5
         qDlg0sRW6eoJE1udBmVsT/nACpBkQRewfazYt0nzaa8CEvXertEfqWWmKjHdL8fVFtlp
         K7p46uiofpWkGhBlJFDL2yreRZtoxTnp2bcP1AG9eqCWwR1L0/NlWR3OjC9htLACdqmG
         f2lA==
X-Gm-Message-State: AOAM532rvXvFJxFJuYxuhOd5H8WntPkT/ajW945vcApd64NSOiGdMZ0D
        2wIkfItnV9A3uZBVn2sAu4CAGf5ciuM=
X-Google-Smtp-Source: ABdhPJwqx+OrE+Z/saSwt0LJgLDfLKCplUbDfOjZSeZ/ptSdM86GB1xDmuNwN7Bj4zfbRGXhOSix1Q==
X-Received: by 2002:adf:d0d0:: with SMTP id z16mr13220325wrh.29.1626268373719;
        Wed, 14 Jul 2021 06:12:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r19sm2783411wrg.74.2021.07.14.06.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 06:12:53 -0700 (PDT)
Message-Id: <ad1715e3319b988fc6979970892a9f9c6ff5bf4a.1626268360.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
References: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
        <pull.932.v9.git.1626268360.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jul 2021 13:12:37 +0000
Subject: [PATCH v9 13/16] status: use sparse-index throughout
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

By testing 'git -c core.fsmonitor= status -uno', we can check for the
simplest index operations that can be made sparse-aware. The necessary
implementation details are already integrated with sparse-checkout, so
modify command_requires_full_index to be zero for cmd_status().

In refresh_index(), we loop through the index entries to refresh their
stat() information. However, sparse directories have no stat()
information to populate. Ignore these entries.

This allows 'git status' to no longer expand a sparse index to a full
one. This is further tested by dropping the "-uno" option and adding an
untracked file into the worktree.

The performance test p2000-sparse-checkout-operations.sh demonstrates
these improvements:

Test                                  HEAD~1           HEAD
-----------------------------------------------------------------------------
2000.2: git status (full-index-v3)    0.31(0.30+0.05)  0.31(0.29+0.06) +0.0%
2000.3: git status (full-index-v4)    0.31(0.29+0.07)  0.34(0.30+0.08) +9.7%
2000.4: git status (sparse-index-v3)  2.35(2.28+0.10)  0.04(0.04+0.05) -98.3%
2000.5: git status (sparse-index-v4)  2.35(2.24+0.15)  0.05(0.04+0.06) -97.9%

Note that since HEAD~1 was expanding the sparse index by parsing trees,
it was artificially slower than the full index case. Thus, the 98%
improvement is misleading, and instead we should celebrate the 0.34s to
0.05s improvement of 85%. This is more indicative of the peformance
gains we are expecting by using a sparse index.

Note: we are dropping the assignment of core.fsmonitor here. This is not
necessary for the test script as we are not altering the config any
other way. Correct integration with FS Monitor will be validated in
later changes.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit.c                         |  3 +++
 read-cache.c                             | 10 ++++++++--
 t/t1092-sparse-checkout-compatibility.sh | 13 +++++++++----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 190d215d43b..12f51db158a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1510,6 +1510,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_status_usage, builtin_status_options);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	status_init_config(&s, git_status_config);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
diff --git a/read-cache.c b/read-cache.c
index 0c3ac3cefc0..6a1337cc905 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1585,8 +1585,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	 */
 	preload_index(istate, pathspec, 0);
 	trace2_region_enter("index", "refresh", NULL);
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(istate);
+
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;
@@ -1601,6 +1600,13 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		if (ignore_skip_worktree && ce_skip_worktree(ce))
 			continue;
 
+		/*
+		 * If this entry is a sparse directory, then there isn't
+		 * any stat() information to update. Ignore the entry.
+		 */
+		if (S_ISSPARSEDIR(ce->ce_mode))
+			continue;
+
 		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
 			filtered = 1;
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 375b0d35565..751f397cc7f 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -511,12 +511,17 @@ test_expect_success 'sparse-index is expanded and converted back' '
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
 		git -C sparse-index -c core.fsmonitor="" reset --hard &&
 	test_region index convert_to_sparse trace2.txt &&
-	test_region index ensure_full_index trace2.txt &&
+	test_region index ensure_full_index trace2.txt
+'
 
-	rm trace2.txt &&
+test_expect_success 'sparse-index is not expanded' '
+	init_repos &&
+
+	rm -f trace2.txt &&
+	echo >>sparse-index/untracked.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index -c core.fsmonitor="" status -uno &&
-	test_region index ensure_full_index trace2.txt
+		git -C sparse-index status &&
+	test_region ! index ensure_full_index trace2.txt
 '
 
 test_done
-- 
gitgitgadget

