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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84ABC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAFB76121D
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFGMgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhFGMg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:36:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373FBC0617A6
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 05:34:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so5781927wmg.4
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FVckP3j8w+mKO74ehu59pvxVbH22LOdegvSLJiu2gdA=;
        b=LdNtViATQxrBu59oTwZjDXjmhzDesc8cvTqEf5n85CigvtOAfjBPGgxVxKyZHDLILe
         fJKISqWxNVU0rXvyo0Wg/i3uVpLmnHG8uLufA/06/3jVyHutLP8dJJ6P+00A843fZO7T
         7tS/+y0AXckYWHbN3fv5XJ9JSGTy3o6bmt/gNipM9AXBJ68mKwa3pOSUfj9FBtwxyL3x
         Gmb18adZFPdnF/QAzvBbj8fY3j4RPb3QCWlleEHoXG5TviyXNdaDbLbRzDThX9l1NIDq
         jJIrcgtlFzbPoU3W/o61NKUmMZ0B9batEzUNMd+fASDpHcDfut0PeAZ81m/qMHRRbuG6
         27kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FVckP3j8w+mKO74ehu59pvxVbH22LOdegvSLJiu2gdA=;
        b=OS0N5ycBnVveBG33VteaCBhl7a4q76P+fTvsZVwD1sRvOMwMvI0gTy/zgx3nOy5pjz
         jrxmBftWJhkLAUjqPaP31WP2OzOaB+YaEC+5jZKqy2XbO+mYzCFw41Uv8i+Ja7iI25sy
         p9AuadcJTqCWPz8CV0SxNv5RpotYhTOsvGk7HoRu30jOR0CsMJBf359YWoWcqLiYhuNx
         YA9PNCDAa4TorpyiXltglyoTCTE9KEIgxPxqd39/YBj3fG0F/T7m3hMivFnTnk/FMxjP
         8AUFiArAMtRYlOn5LYoCkDSOC9NoWTgoRTGXB/h1CVHTDb0htKUw2p67P2rO+grJnhOH
         P1fQ==
X-Gm-Message-State: AOAM531AtXgrCxguYSVFZOwhIKPzX6TR4n8MqRto8u154pGxwqjE8Hmk
        kd/JqlJBHMtrQzDg6mahMZNJHmyZLSg=
X-Google-Smtp-Source: ABdhPJybEI0hXLaraqbkQrHmixv+nku7Uioa/epRgBnYYc7Lj9v+nTh7npERRUPtwblXcbo3b2YRoQ==
X-Received: by 2002:a05:600c:1d1a:: with SMTP id l26mr9800930wms.189.1623069261262;
        Mon, 07 Jun 2021 05:34:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7sm15925764wrs.23.2021.06.07.05.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:34:20 -0700 (PDT)
Message-Id: <0c0a765dde80c75499c661d518a40a250b9809c5.1623069253.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
        <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 12:34:10 +0000
Subject: [PATCH v5 12/14] status: use sparse-index throughout
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
index cf0c36d1dcb2..e529da7beadd 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1404,6 +1404,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_status_usage, builtin_status_options);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	status_init_config(&s, git_status_config);
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
diff --git a/read-cache.c b/read-cache.c
index 29ffa9ac5db9..f80e26831b36 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1578,8 +1578,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	 */
 	preload_index(istate, pathspec, 0);
 	trace2_region_enter("index", "refresh", NULL);
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(istate);
+
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;
@@ -1594,6 +1593,13 @@ int refresh_index(struct index_state *istate, unsigned int flags,
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
index f6b124e0500f..099dc2bf440f 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -508,12 +508,17 @@ test_expect_success 'sparse-index is expanded and converted back' '
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

