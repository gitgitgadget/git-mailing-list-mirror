Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA080C433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 21:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F7C2207BC
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 21:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC/8UL1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439458AbgJQVEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 17:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439450AbgJQVEl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 17:04:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CF0C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 14:04:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 13so6704981wmf.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7p7HYzVQTY1ynw8rjsFhzxNNXaJqnM6pIlRGWVFciSY=;
        b=MC/8UL1RYFr00X3Pc8kKR91bu9eHhxbf9YDpDSZAmws9jkvLDwhTao9h4Ml3C5J2WL
         xAIBB+JsQ4m0o3AcXrzlt2WVkcMAYEmZEHWkyrAj6QBbHQtJipEt8PXVOXNjGQFZoyjU
         1+qFyC+6LHr3f82Zg1JM6V0lVpSwLMXQ2XI/SmTNpSJBYKy2q2lf7l+Xycdcv7BRHzIg
         K2zSck5IUtEZfGAj/XTIXtw0uCkPWAXV1Dm1sdL60lOanVL1p824E9k+eC9cGk+AcyUE
         R/g+4b3f+slF9PyFWd56lFzUJqA+XYPMRADojntkcX3ZrwBHt/qVR2gHG/Ag7E1JFYO1
         eMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7p7HYzVQTY1ynw8rjsFhzxNNXaJqnM6pIlRGWVFciSY=;
        b=BT2y2svYFZfvulm/WYhUtTkD4sRVfWthE0OFIpnK3thZQkPQc2bO6wvPnxP+sW+W9M
         wnMwGDcsbjkWbBusavlxdotgdLifZKOB0YBxH7Exu3g58q8/YhP7mFYJx5uZ61H3trFc
         JtmDn93VpjMD06K/DNGXRqtIdjvP3qjfWxqr9JyeJIhXoKV+Yp1847080iFxscQ3XtzY
         K54+ElPHPOy8G/hn8z4MH53sr7qwOic0Lc4f3cIPIvjTom5hoCB7zwfKQnNn1DpNuwMi
         lrAgrbIfEEWEQBEQ3unrXE5SHn0Gs3HHzyDhcC/cBy3tPS0t7ILBsozdWv92zPffSJqm
         RS9w==
X-Gm-Message-State: AOAM5303RHpU/C7WhOW6J6m1+gxyABbBsECdcqhdWVfunmrH2qTF7zhS
        6al3AFARlbak3HKbeY7jtyuDY3fGGNQ=
X-Google-Smtp-Source: ABdhPJzNcgVKH2GN1f9rWUtT5pnbSjC1qk50jQz7hfn3k17zTLdYdm3RgsErkTYFMino8M5mOkdhOQ==
X-Received: by 2002:a1c:1f89:: with SMTP id f131mr10302542wmf.10.1602968679473;
        Sat, 17 Oct 2020 14:04:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm10526035wrm.2.2020.10.17.14.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 14:04:38 -0700 (PDT)
Message-Id: <13fd992a375e30e8c7b0953a128e149951dee0ea.1602968677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.git.1602968677.gitgitgadget@gmail.com>
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
From:   "Alex Vandiver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Oct 2020 21:04:33 +0000
Subject: [PATCH 1/4] fsmonitor: use fsmonitor data in `git diff`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Vandiver <alexmv@dropbox.com>

With fsmonitor enabled, the first call to match_stat_with_submodule
calls refresh_fsmonitor, incurring the overhead of reading the list of
updated files -- but run_diff_files does not respect the
CE_FSMONITOR_VALID flag.

Make use of the fsmonitor extension to skip lstat() calls on files
that fsmonitor judged as unmodified.

Notably, this change improves performance of the git shell prompt when
GIT_PS1_SHOWDIRTYSTATE is set.

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 diff-lib.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index f95c6de75f..b7ee1b89ef 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -97,6 +97,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
+	refresh_fsmonitor(istate);
+
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
 	entries = istate->cache_nr;
@@ -197,8 +199,19 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		if (ce_uptodate(ce) || ce_skip_worktree(ce))
 			continue;
 
-		/* If CE_VALID is set, don't look at workdir for file removal */
-		if (ce->ce_flags & CE_VALID) {
+		/*
+		 * If CE_VALID is set, the user has promised us that the workdir
+		 * hasn't changed compared to index, so don't stat workdir
+		 * for file removal
+		 *  eg - via git udpate-index --assume-unchanged
+		 *  eg - via core.ignorestat=true
+		 *
+		 * When using FSMONITOR:
+		 * If CE_FSMONITOR_VALID is set, then we know the metadata on disk
+		 * has not changed since the last refresh, and we can skip the
+		 * file-removal checks without doing the stat in check_removed.
+		 */
+		if (ce->ce_flags & CE_VALID || ce->ce_flags & CE_FSMONITOR_VALID) {
 			changed = 0;
 			newmode = ce->ce_mode;
 		} else {
-- 
gitgitgadget

