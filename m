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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB3CC433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D5B6008E
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhEUMB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 08:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbhEUMBR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 08:01:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A179CC061343
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z85-20020a1c7e580000b029017a76f3afbaso4476870wmc.2
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HVK7x9ytblDj8iy4lmiMNtwNDpdpLC/uAkky1UzqoLw=;
        b=XOqzglHtzCj+pcrP8LKvmXpTRnix7OchY+qr2x9x4iAd0hTCvdwPtJ+kffk/hHeCM4
         4esCUcZ8JqeE7Fy/oSMyZPHaRKCs2D+cht0FvpbK7tQLfumL+dUzk+KYWCvVU2hcRPUl
         2Y20COv4T9zrdQNCsJDFoPbRw52V/5MqqUjTil3qg6PBNvdJ2Q4rMOCr4aWRZdJa83sm
         ieyl+WNVwWTLOCs2AK7juqldrlnxfX655s7/PiMjJji2RNxEi/t0zUn4Xw3nIp1xTIWi
         43lNmgIdIlfvLkX+7t/8COfaQO4Yd8VP1dQTO1WAxS9K8P7Xu4V7iUcS0zS6ytiZJpyf
         CTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HVK7x9ytblDj8iy4lmiMNtwNDpdpLC/uAkky1UzqoLw=;
        b=cpVDncmpmqmffhAvUBF8VHP6tGzrPEgZEB3LmCDtUMyw5oQXhDScIY/uujBDxMyWyv
         Ebw11ZnSXlvRvV3KNhhplIn1vZA+KQWUx0l6Fa3Oo3ygD5vKmkOgUKnZg+Nb9yGP3Vke
         x8pgdsobNMrFF2XtFZKduAGuOFXFKh3xM4xN2llMRguSLHNqPC3xgp2KEZhB8e5PHQB8
         qqbffLYY6M8k2eAsZNckBU2GSi7p4ckfhic6lHmAk+dIoZQT0RXu07rvpHMrE1mCDaa9
         srvnrVXjunJr8UC9FYisQXxSx+kCoQXScQ+6yPbvqPV3/9hGF5jyp7Hry6aTmPxHYpJS
         WpTQ==
X-Gm-Message-State: AOAM532ZUUn+AuI8KZEqCZyUtHnCdHa7WC4nWIE/dvL+TJa/gcmpSsWo
        5YGEznQAdL/VFiR6BQVG3fjLp/e879Q=
X-Google-Smtp-Source: ABdhPJxypoZG8GqvNI/26TnZOmKwUo8eKGGwIhBe1I/utl78JUMuA+zLJ3wK2giQuKqG2zNMpQ0Tqg==
X-Received: by 2002:a7b:c1c6:: with SMTP id a6mr8556330wmj.189.1621598390284;
        Fri, 21 May 2021 04:59:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 61sm2032096wrm.52.2021.05.21.04.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:59:50 -0700 (PDT)
Message-Id: <584d4b559a91213287221b9731281431fc557627.1621598382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
References: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
        <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 May 2021 11:59:41 +0000
Subject: [PATCH v4 12/12] fsmonitor: integrate with sparse index
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
 t/t7519-status-fsmonitor.sh | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/sparse-index.c b/sparse-index.c
index b2b3fbd75050..32ba0d17ef7c 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -195,6 +195,10 @@ int convert_to_sparse(struct index_state *istate)
 	cache_tree_free(&istate->cache_tree);
 	cache_tree_update(istate, 0);
 
+	istate->fsmonitor_has_run_once = 0;
+	FREE_AND_NULL(istate->fsmonitor_dirty);
+	FREE_AND_NULL(istate->fsmonitor_last_update);
+
 	istate->sparse_index = 1;
 	trace2_region_leave("index", "convert_to_sparse", istate->repo);
 	return 0;
@@ -291,6 +295,9 @@ void ensure_full_index(struct index_state *istate)
 	istate->cache = full->cache;
 	istate->cache_nr = full->cache_nr;
 	istate->cache_alloc = full->cache_alloc;
+	istate->fsmonitor_has_run_once = 0;
+	FREE_AND_NULL(istate->fsmonitor_dirty);
+	FREE_AND_NULL(istate->fsmonitor_last_update);
 
 	strbuf_release(&base);
 	free(full);
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 45d025f96010..f70fe961902e 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -73,6 +73,7 @@ test_expect_success 'setup' '
 	expect*
 	actual*
 	marker*
+	trace2*
 	EOF
 '
 
@@ -383,4 +384,51 @@ test_expect_success 'status succeeds after staging/unstaging' '
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
