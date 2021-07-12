Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D9CC07E9C
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDB761206
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbhGLR7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbhGLR66 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:58:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D561C061797
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n4so1559198wms.1
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tFZIx+WwLaEcHap1rGQysKeAcWD7b272QogaBIbJLog=;
        b=VDVEOc4bQ4tPPsjHffCREdLCVpqX5sISmclR4l9TwEGMz5ic91m+jtvwWn9nfOYJqH
         0fG4fgFXjone3BKq7qJcuBd/v+JauNI4enR5B/gTfpDJnIbkv4hanVKlSwFrFIrsC9fa
         H4D6sJJrIxexpt21g1FwFwHmg6HuMAczjvMaJDwAFZnnlwavFJuMTVxqMsGLSkIaZnlJ
         eoIJoiG2wV6KGMEUCN5jg3q3AXr560+C/m8v4hG37Jh9tNADFKuop6H2CTVtLAiONjTT
         89Z3dMNpoMx2TUOUXaYW0FIGJ1WRag2l5rkMWOXvmCc2UhxCO1W0s4lWBUNmSP7kF6M8
         MPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tFZIx+WwLaEcHap1rGQysKeAcWD7b272QogaBIbJLog=;
        b=JO6j58tyTI2YWveD5M3/JJo0gA0VkRoklO2zmscmYLhpH8gzuEyMzLbEZ/vcW4HvYs
         KxqOdmMUu1fq0sAwQNRnCuUydF1y22cIBhbAJM0uIdkQCxs6q0nCCCJP142Q3HUwnuUT
         8oKQtjP4MM1IArlhLaDGCtHQicXdL2t5Z910FUQ2U9/V+FkhODHDn9nbkq2CESX3A5tA
         bPJsS5n1qPZQxbQ5YG9xMoBLZIygqw7aXva0DH6imWTy1SC65v05fG9zGm43ZLZfNIVX
         EaP+svt9+cokk1gamY1ZYsJIKhCWDJAhqbvk5s2QfN7R3lq4yTlFTg3wsjllKyh1jTtO
         eppw==
X-Gm-Message-State: AOAM5311d/HneNAKQkiV9z02WorXxpj/OJuZSgZqHVedbS/PaMWSefD5
        RfKR9sZ6xZdYCgwXxneQHrMH7tgCsW8=
X-Google-Smtp-Source: ABdhPJw31XCUsvdm7N3a9nH770PRfEze+eU1PUjpKiPylKQP4MHttwdvYWf+9A9oODboRpcV79KP9Q==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr485719wmq.0.1626112567311;
        Mon, 12 Jul 2021 10:56:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c125sm134053wme.36.2021.07.12.10.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:56:07 -0700 (PDT)
Message-Id: <bdc771cf37383896d546f592b6847d95d666672a.1626112556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
References: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
        <pull.932.v8.git.1626112556.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 17:55:56 +0000
Subject: [PATCH v8 15/15] fsmonitor: integrate with sparse index
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

If we need to expand a sparse-index into a full one, then the FS Monitor
bitmap is going to be incorrect. Ensure that we start fresh at such an
event.

While this is currently a performance drawback, the eventual hope of the
sparse-index feature is that these expansions will be rare and hence we
will be able to keep the FS Monitor data accurate across multiple Git
commands.

These tests are added to demonstrate that the behavior is the same
across a full index and a sparse index, but also that file modifications
to a tracked directory outside of the sparse cone will trigger
ensure_full_index().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c              |  7 ++++++
 t/t7519-status-fsmonitor.sh | 49 +++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/sparse-index.c b/sparse-index.c
index ef53bd2198b..53c8f711ccc 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -186,6 +186,10 @@ int convert_to_sparse(struct index_state *istate)
 	cache_tree_free(&istate->cache_tree);
 	cache_tree_update(istate, 0);
 
+	istate->fsmonitor_has_run_once = 0;
+	FREE_AND_NULL(istate->fsmonitor_dirty);
+	FREE_AND_NULL(istate->fsmonitor_last_update);
+
 	istate->sparse_index = 1;
 	trace2_region_leave("index", "convert_to_sparse", istate->repo);
 	return 0;
@@ -282,6 +286,9 @@ void ensure_full_index(struct index_state *istate)
 	istate->cache = full->cache;
 	istate->cache_nr = full->cache_nr;
 	istate->cache_alloc = full->cache_alloc;
+	istate->fsmonitor_has_run_once = 0;
+	FREE_AND_NULL(istate->fsmonitor_dirty);
+	FREE_AND_NULL(istate->fsmonitor_last_update);
 
 	strbuf_release(&base);
 	free(full);
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 637391c6ce4..deea88d4431 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -73,6 +73,7 @@ test_expect_success 'setup' '
 	expect*
 	actual*
 	marker*
+	trace2*
 	EOF
 '
 
@@ -383,4 +384,52 @@ test_expect_success 'status succeeds after staging/unstaging' '
 	)
 '
 
+# Usage:
+# check_sparse_index_behavior [!]
+# If "!" is supplied, then we verify that we do not call ensure_full_index
+# during a call to 'git status'. Otherwise, we verify that we _do_ call it.
+check_sparse_index_behavior () {
+	git status --porcelain=v2 >expect &&
+	git sparse-checkout init --cone --sparse-index &&
+	git sparse-checkout set dir1 dir2 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git status --porcelain=v2 >actual &&
+	test_region $1 index ensure_full_index trace2.txt &&
+	test_region fsm_hook query trace2.txt &&
+	test_cmp expect actual &&
+	rm trace2.txt &&
+	git sparse-checkout disable
+}
+
+test_expect_success 'status succeeds with sparse index' '
+	git reset --hard &&
+
+	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
+	check_sparse_index_behavior ! &&
+
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
+	EOF
+	git config core.fsmonitor .git/hooks/fsmonitor-test &&
+	check_sparse_index_behavior ! &&
+
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
+		printf "dir1/modified\0"
+	EOF
+	check_sparse_index_behavior ! &&
+
+	cp -r dir1 dir1a &&
+	git add dir1a &&
+	git commit -m "add dir1a" &&
+
+	# This one modifies outside the sparse-checkout definition
+	# and hence we expect to expand the sparse-index.
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
+		printf "dir1a/modified\0"
+	EOF
+	check_sparse_index_behavior
+'
+
 test_done
-- 
gitgitgadget
