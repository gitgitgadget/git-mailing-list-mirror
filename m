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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBDCC43214
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19E8613B1
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbhHXVzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238427AbhHXVzh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:55:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBCEC0613D9
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d26so13020504wrc.0
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6HCoPYtcBbJ9xM1NNoK+33bRxbv+GCQNtrBdX/Nmx8k=;
        b=ULe7DZQ1WUZG2X60LzZ0S7qrA7d6kKENVz0AISfXe7KJ/wFDSDt1WXWP+gV5fR+Pxp
         G2qQF8Qhx9iHgmzixcQwR4MQe8QKvCHkxShNxfaemAm5F/HA4R2jLGKMq1csVIHHpUiV
         ultYPffxv3oYRj8fchjcFJvFlEjvHj1YyNi2Iz8eEYgqMW1WkMxTwQQXHO0YuXhE27C0
         9IxwNzhlyAlEEiuweboHFnbQJB1aWo5Jpm6Z1uesbLPlXThqz7WNyCJUwMJaS3K9S8Cy
         ECxzMX9T1E+e6Im/mtN/J88UFykVhVjDVU7wPASfLSi3Zbf9123oumev0qm5N1+drfYp
         PoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6HCoPYtcBbJ9xM1NNoK+33bRxbv+GCQNtrBdX/Nmx8k=;
        b=DJLcmPYmgsNLQ8IjWYhYBMGso+B39MQqL0vvMAs79ufUXpbnnPLKmPDW4PBSfQbmWy
         cJsoat2a4vN3HTgtgbXjykdRz9gsLPXBC2ZNEgdzIm0cy7mMMssJWiWNBeaOfmHGQInO
         9nA352ynaLOLVFSmkofntYkvLw5KjAaPRGM1twla4E2wCP+9Lu/73aBgaerzgGB0PNbp
         f0HPO/dVED2D8VInHYtr3xm2lVG1rQNptr1+9EDFISJQ8x7Fg6XQ6otdyu3YfnTtAyXQ
         ahzFogb3Zo/Z6YTqCBGZu7neDU73XiVbiWWs0Ge0z9gR9KKUAVfXdL3B0GRfN0hp5qX1
         N+Aw==
X-Gm-Message-State: AOAM532DASz/1dnGnNkrv2mIj6gcOd/7whvmnPP4r9BCzfQk9LtqYe1s
        XA4/Lt+5BV3Wyj0cMOv6v1nooUXxCiE=
X-Google-Smtp-Source: ABdhPJwLG3/LbR4E1t9iPApbpI6EOGLYu2U0rAez5SYmqtLJcpYmneD1ZX2v0UA9nwJ8HTQU8NZ/Tw==
X-Received: by 2002:adf:e68e:: with SMTP id r14mr21817125wrm.395.1629842091072;
        Tue, 24 Aug 2021 14:54:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4sm18621530wro.97.2021.08.24.14.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:54:50 -0700 (PDT)
Message-Id: <f1764f9ed187a2f383bd8269e198192fe0486bda.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:54:40 +0000
Subject: [PATCH 08/13] add: prevent adding sparse conflict files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When a merge results in a conflict outside of the sparse-checkout cone,
the conflicted file is written to the working tree and the index entry
loses the SKIP_WORKTREE bit. This allows users to add the file to the
index without realizing that the file might leave the working tree in a
later Git command.

Block this behavior, but keep in mind that the user can override the
failure using the '--sparse' option.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 pathspec.c                               | 2 +-
 t/t1091-sparse-checkout-builtin.sh       | 4 +++-
 t/t1092-sparse-checkout-compatibility.sh | 6 +++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 0e6e60fdc5a..ddeeba79114 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -71,7 +71,7 @@ char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec)
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
-		if (ce_skip_worktree(ce))
+		if (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate))
 		    ce_path_match(istate, ce, pathspec, seen);
 	}
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index e0f31186d89..b6efdb3c52f 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -406,7 +406,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged stat
 	git -C unmerged sparse-checkout disable
 '
 
-test_expect_success 'sparse-checkout reapply' '
+test_expect_failure 'sparse-checkout reapply' '
 	git clone repo tweak &&
 
 	echo dirty >tweak/deep/deeper2/a &&
@@ -438,6 +438,8 @@ test_expect_success 'sparse-checkout reapply' '
 	test_i18ngrep "warning.*The following paths are unmerged" err &&
 	test_path_is_file tweak/folder1/a &&
 
+	# NEEDSWORK: We are asking to update a file outside of the
+	# sparse-checkout cone, but this is no longer allowed.
 	git -C tweak add folder1/a &&
 	git -C tweak sparse-checkout reapply 2>err &&
 	test_must_be_empty err &&
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 1e7799fd76a..65998e664a9 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -518,9 +518,8 @@ test_expect_success 'merge with conflict outside cone' '
 	test_all_match git status --porcelain=v2 &&
 
 	# 2. Add the file with conflict markers
-	# NEEDSWORK: Even though the merge conflict removed the
-	# SKIP_WORKTREE bit from the index entry for folder1/a, we should
-	# warn that this is a problematic add when --sparse is not set.
+	test_sparse_match test_must_fail git add folder1/a &&
+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_all_match git add --sparse folder1/a &&
 	test_all_match git status --porcelain=v2 &&
 
@@ -528,6 +527,7 @@ test_expect_success 'merge with conflict outside cone' '
 	#    accept conflict markers as resolved content.
 	run_on_all mv folder2/a folder2/z &&
 	test_sparse_match test_must_fail git add folder2 &&
+	test_i18ngrep "Disable or modify the sparsity rules" sparse-checkout-err &&
 	test_all_match git add --sparse folder2 &&
 	test_all_match git status --porcelain=v2 &&
 
-- 
gitgitgadget

