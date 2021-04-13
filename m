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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8156CC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FCDF61206
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhDMOCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbhDMOCF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:02:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BA9C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so8245334wmg.0
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=igbZPETxXaQSENv8XIc9P3Kyj/wn+H2Pe1/dZBLGnEk=;
        b=Y2j+GqBsHJBYfSXrNF2LZYui9m3WdUJh3wXP6aRZCwuMx70NpyYKuIlX2l5V4Kn57e
         FNi6ztUFhWh3MB0cAzsBGbBZuY6fCPxH4XgjrgilKH+MDubdM2NnKGIDa/nRF/IK3QRW
         KNBoWZZC09qJ0rA7OQKg3GSpAzBfRnQLx2xTgMx4HueN4yUlcd2mdr7tivIEwWKhjrna
         A7doul5Ssg774O/mnDL3OG20tltSK0gLMwRKLxy0/4ICPaAtWXpps32V79uRmamljO8X
         doDdInx/UeUuEflt5nWcYxtSfZDoIh9xYqfR2Tb9mmh3LDvN89AZecZqOluc+WwuwDxo
         a45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=igbZPETxXaQSENv8XIc9P3Kyj/wn+H2Pe1/dZBLGnEk=;
        b=lOiQgAxnPPq0RjFlw4eaG5dwunMPi/JrCkxdPGjnx1bfXHQCjGc6dBiHgvqxuIKV+0
         +/Wp1lKp2kCekbliCqKNHlZgGhUBsj/O59hVFrWit6zYLLDMOU/iyW1w0jT1AKx38VQN
         gRZhgsBTzOsnP+w41U/0ka7EjDsLDgtIpIk9egSZQm53GRetESLXwrW/7kEHMRDmiZVk
         FQDjonRZWNwkHb706cQHljapjpmY0tyyyoEHidYQr/+CB2hSoECco9PiTmpf3AJjKtjy
         tcbeZ3YJo+iMy7oTpBU09QDrINyFsYCayd8jUR6mefRxXam+gyt7VVGjkNgKik3MR/Nr
         0l0w==
X-Gm-Message-State: AOAM531Iwl8WqY8Gi4LVxnyPDTK6iPig5d+CQd4BB7EkbphvVOQCYfUb
        BXiXLqA5uUv6ipWmv9orF4HoKHZO6Mo=
X-Google-Smtp-Source: ABdhPJznB4qIbEsQjk/uE6SpxPtCNvXkfn0lvjDYvCg4deZN9VL1fRNJxbJowDzMu7C0ZDjvc1TmWg==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr185728wmc.8.1618322503027;
        Tue, 13 Apr 2021 07:01:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b187sm2645687wmh.17.2021.04.13.07.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:01:42 -0700 (PDT)
Message-Id: <d7d4cad8be0b2a27a332a2796ba0dce92783355f.1618322497.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.git.1618322497.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 14:01:32 +0000
Subject: [PATCH 05/10] status: use sparse-index throughout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
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

By running the debugger for 'git status -uno' after that change, we find
two instances of ensure_full_index() that were added for extra safety,
but can be removed without issue.

In refresh_index(), we loop through the index entries. The
refresh_cache_ent() method copies the sparse directories into the
refreshed index without issue.

The loop within run_diff_files() skips things that are in stage 0 and
have skip-worktree enabled, so seems safe to disable ensure_full_index()
here.

This allows some cases of 'git status' to no longer expand a sparse
index to a full one, giving the following performance improvements for
p2000-sparse-checkout-operations.sh:

Test                                  HEAD~1           HEAD
-----------------------------------------------------------------------------
2000.2: git status (full-index-v3)    0.38(0.36+0.07)  0.37(0.31+0.10) -2.6%
2000.3: git status (full-index-v4)    0.38(0.29+0.12)  0.37(0.30+0.11) -2.6%
2000.4: git status (sparse-index-v3)  2.43(2.33+0.14)  0.04(0.05+0.04) -98.4%
2000.5: git status (sparse-index-v4)  2.44(2.35+0.13)  0.05(0.04+0.07) -98.0%

Note that since HEAD~1 was expanding the sparse index by parsing trees,
it was artificially slower than the full index case. Thus, the 98%
improvement is misleading, and instead we should celebrate the 0.37s to
0.05s improvement of 82%. This is more indicative of the peformance
gains we are expecting by using a sparse index.

Note: we are dropping the assignment of core.fsmonitor here. This is not
necessary for the test script as we are not altering the config any
other way. Correct integration with FS Monitor will be validated in
later changes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit.c                         |  3 +++
 read-cache.c                             |  2 --
 t/t1092-sparse-checkout-compatibility.sh | 12 ++++++++----
 3 files changed, 11 insertions(+), 6 deletions(-)

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
index 6308234b4838..83e6bdef7604 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1578,8 +1578,6 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	 */
 	preload_index(istate, pathspec, 0);
 	trace2_region_enter("index", "refresh", NULL);
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index e488ef9bd941..380a085f8ec4 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -449,12 +449,16 @@ test_expect_success 'sparse-index is expanded and converted back' '
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
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index -c core.fsmonitor="" status -uno &&
-	test_region index ensure_full_index trace2.txt
+		git -C sparse-index status -uno &&
+	test_region ! index ensure_full_index trace2.txt
 '
 
 test_done
-- 
gitgitgadget

