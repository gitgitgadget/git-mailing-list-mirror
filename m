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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E55EC11F65
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66AD861C99
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhF2CHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhF2CHh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:07:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7B1C0617A8
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:05:04 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso1272092wmj.4
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VMrrM2aGM35t7+rKMf9/CmBSSph8xW2UJsNSqfFOQg4=;
        b=BnPqkR3VEqAtmlVMI2Sn5ID0Zh9A3cS6exoMrMizjR3mqhvHFOyATDXP2glyyhxZF+
         ElTVE9/e4diA/digjm2qP2E99Y/cyKQ9EbFWujSZdJVmiBdqjnrFaRh8VpbsKhzoCdqR
         6U1iqMcJUc1NWdKjBs8wqDRwhE22yS37efST5It2kHG9U3GoBSuLp6u/iR/Jt8xsxJez
         tM1nTzxd22axKRNT1VZHfv9ej89Yz5z3IdXp2iSBTxA6x+H9CKw2+sK1L82iF0jXEgYI
         9WBx+r6yprMpxJFYUXLMdvU/vPVo8I76j6utI3fUgZi4qXbXbRrVDzSjyOIvea+8NeqY
         /7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VMrrM2aGM35t7+rKMf9/CmBSSph8xW2UJsNSqfFOQg4=;
        b=HRqfVnlqtoQMxo7INnSz0uAs0+pE/dfobiT4GrdRx7Crlb08IEF5TWTUaQTme31hws
         yIdwLnwwCqAkvkBfmOIK9FshbEEl2lxgOPGxWFWpS/BDvlG8WE0UMsnwPZrArDbFx1yF
         o+igD9pDsbTtDZRRgfgXcuLReIyyCwIy8ZrSjb6g9EANBwOgoHN3BruXgqULC+8nXRd+
         pnyPAYmv38g0LCEwNdmWFZFVQ53dLiVLhEMW62yrumo3pEejWulX58sjhcfeXP8O8UpI
         T8dF28tgde3+549+YGlhnus62XILShpGmMIcXKeSF2ObS2fe849bvS/yK7bYHEdhup01
         Vnlw==
X-Gm-Message-State: AOAM533/G7aUxBtHWrQ9P9ucB9xtNcjne0yHwVP0YI96zvDblqss6oAO
        eMRTahIOq8kL6Pp6QJ25QU2gBaQ03Xg=
X-Google-Smtp-Source: ABdhPJxvTaCVEVQ0lDP6hkmAPrXh2cLfcsnE13EvlO9z+Ayzvi5IRvLtfISAicDH7PhNcOY4JJ8Jjg==
X-Received: by 2002:a7b:c7c8:: with SMTP id z8mr16506634wmk.110.1624932303158;
        Mon, 28 Jun 2021 19:05:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16sm7906242wmr.2.2021.06.28.19.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:05:02 -0700 (PDT)
Message-Id: <b4033a9bf364a45f9b75a58b17dfe8a6930fc992.1624932294.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
        <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:04:51 +0000
Subject: [PATCH v7 14/16] status: use sparse-index throughout
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
index 1b3c2eb408b..277c2970a03 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1584,8 +1584,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	 */
 	preload_index(istate, pathspec, 0);
 	trace2_region_enter("index", "refresh", NULL);
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(istate);
+
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;
@@ -1600,6 +1599,13 @@ int refresh_index(struct index_state *istate, unsigned int flags,
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
index d372932cd12..fed0440bafe 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -532,12 +532,17 @@ test_expect_success 'sparse-index is expanded and converted back' '
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

