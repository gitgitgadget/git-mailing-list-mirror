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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF67EC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92285613EB
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhENScr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 14:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbhENSch (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 14:32:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF176C06138B
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r12so192417wrp.1
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gu6GEJgKuJhO6OfWQXS55AAR+pJtihz9mG9qQegVuuA=;
        b=AnHNx2IRWamOduVnOTyuFXlCCbL+wLdma6oxVRwNyUnH7iDqxolm/tCFUiCM+cor/P
         wwkmKY8CwMHpU8mY1TmSf46EDdL7eZKFxXidxs2W/sxLexNWd7qH9bBMFCJMazn6MGlT
         DWsoYmFnrsCsk59hOeX2XsunIrZKvQCek8Y0JcYmqEzzOYXycLD1xkO/yPwi4+ZYh9PM
         IVzEvuDhz7dwTpnkmFuUE5V86DBuP35dHGIpscApf822GoyeuDrHiNysBFfZrPCG8bMY
         o6+8fS/eq1Xow19jvDzBfr5/ToCVRUf9swgMBhJQj2FkLdMh9ieiHpcdZ05IHYAOowyX
         oIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gu6GEJgKuJhO6OfWQXS55AAR+pJtihz9mG9qQegVuuA=;
        b=NDgRHyiC0i7TGjs1QRybUouERz/dwm26XjYVanW3kb+RrN8ar4HSyEWxQ0gYmTm3Sh
         EBVks+lumA1vk73nev3uGi6ytn7NTN1E0gofce0jbIpH711W+KkTg0qUQadVGDw0MFG6
         5GBM+V8pJ/jnTn4s8Sf8YU0ZxICWCpdSHIfYTy8cXyWphQ4C9yl0XWCpeFy+ynfrDvc6
         CkDzWsVRoR5h+EHcQLhF4MNIptEiEmiTHWKQVuEk9zKr21/dhYRMRTMiQSI51R1sndBk
         0wJzFOiwTsOUqlojacpO4aYjZdxA+C3JReOzrwUF3QHW+HKZ0BPQKfnf3Um7fUv646ts
         lYiA==
X-Gm-Message-State: AOAM532lfTAG38CkrpsKrJ4mnjdXoojq0IUdOFuu6aw53BIRyrIOjRu5
        ujxfiYGCQG+8OqalOEWBvKcmhjzhZxI=
X-Google-Smtp-Source: ABdhPJzI3oblZPG2BS+LJ1SVVWVN242tIeFMb9sB+YbHUuS+vve6Dz0N04kyuY62UapJ/XPssuD8qQ==
X-Received: by 2002:adf:f981:: with SMTP id f1mr21961781wrr.381.1621017082519;
        Fri, 14 May 2021 11:31:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r5sm1080637wrw.96.2021.05.14.11.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 11:31:21 -0700 (PDT)
Message-Id: <5b1ae369a7cd2700288a6719c496c149b4240d82.1621017072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
        <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 May 2021 18:31:09 +0000
Subject: [PATCH v3 10/12] status: use sparse-index throughout
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
index 34dae7fbcadd..59faf7381093 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -479,12 +479,17 @@ test_expect_success 'sparse-index is expanded and converted back' '
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

