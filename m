Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE69AC433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A144921D7F
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGqxr7Vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388626AbgJSWrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 18:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388622AbgJSWrm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 18:47:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC10FC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:47:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s9so1468111wro.8
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0cKnq3ai3qJJvReanp+IwPBsXPj7SOWushngrvWxycE=;
        b=fGqxr7Vc3U9+ww1Q3udBdiQORK/LflUHzMOJSxXxZnBMcP2/hdFQYg/bkZJ2LTj8c/
         oI0+rCN7qrrff2/V9trceP6evYBPNSDc245u9CaCYcQ0Vf7SNTAITaoX3g2sGtOlPg1I
         M9LsZ1/WcE7cB/sN8HOlm+bFlvEfqdlhJOcdFmCQxXGZMNeWVASE3unfz3sCQNavpQsP
         mDpMHtglbU3BP8IS5N34dH4bQK+IvUhyEbjKQoj+2ruDwO38mUIMZDXf54rbg6VC63v9
         Rh0xENkv9pxT75Y1qHKPYLXzaCdkTmPF4oYSx4COSnx597kadzXb49clMPhy/l8LqMpO
         swJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0cKnq3ai3qJJvReanp+IwPBsXPj7SOWushngrvWxycE=;
        b=Hhe/EZny4BYian+f3NKreycNZOFNAV2gNlwv+TZXqBr9cu/t0yd2cTWBagpI0TFJF3
         +BBwSnV4B98L/72z0n35HjdVxXbo4ET9+62zJ54SPVqZHwb0ijJbKUpMbmMaml8cqXj+
         mtYNnDPLMSCGnQgSd2j011LYzzxoqTo6bZfmB42WfY+4GHpaf4xsXEkpZYSrAqa0wRZG
         t3C++Uo5ngUoH5qJC2CfMf7kLevMNOWzx3RxayKh6Mb2BtVkrbfZ7PZdjzEnHinItb3B
         f7npbrXshp98us5lhnM8vzen5GzevKl1UYWgQ1R5DmhvNTnRuH/5kPD0jRUQ8NI4CG8F
         jvBg==
X-Gm-Message-State: AOAM530u86EIGJhVAZMMnH0Q9AZ6+v6L89uo5vnlbgAW6SjXdQXfRcLh
        NPwJy/uuGtRcjG5mNRbT6WsifMAf5ZE=
X-Google-Smtp-Source: ABdhPJwJZxGodtYNVCahb4j/79z7Yf8qrfOcfYHp2jPKnVW17qeCSiqK14W3UNESWlTQFcUNrdSvDg==
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr1673639wrx.10.1603147659575;
        Mon, 19 Oct 2020 15:47:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5sm1531412wrb.21.2020.10.19.15.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 15:47:39 -0700 (PDT)
Message-Id: <cba03dd40bc6af965eb33eba87ea490588dc6bcc.1603147657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
References: <pull.756.v2.git.1603143316.gitgitgadget@gmail.com>
        <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
From:   "Alex Vandiver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 22:47:31 +0000
Subject: [PATCH v3 1/7] fsmonitor: use fsmonitor data in `git diff`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>,
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
 diff-lib.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index f95c6de75f..d2d31b9f82 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -97,6 +97,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
 
+	refresh_fsmonitor(istate);
+
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
 	entries = istate->cache_nr;
@@ -197,8 +199,17 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		if (ce_uptodate(ce) || ce_skip_worktree(ce))
 			continue;
 
-		/* If CE_VALID is set, don't look at workdir for file removal */
-		if (ce->ce_flags & CE_VALID) {
+		/*
+		 * When CE_VALID is set (via "update-index --assume-unchanged"
+		 * or via adding paths while core.ignorestat is set to true),
+		 * the user has promised that the working tree file for that
+		 * path will not be modified.  When CE_FSMONITOR_VALID is true,
+		 * the fsmonitor knows that the path hasn't been modified since
+		 * we refreshed the cached stat information.  In either case,
+		 * we do not have to stat to see if the path has been removed
+		 * or modified.
+		 */
+		if (ce->ce_flags & (CE_VALID | CE_FSMONITOR_VALID)) {
 			changed = 0;
 			newmode = ce->ce_mode;
 		} else {
-- 
gitgitgadget

