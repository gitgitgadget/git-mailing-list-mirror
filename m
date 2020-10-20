Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D1DC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6F422250
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuCQCO1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407557AbgJTNlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407508AbgJTNlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 09:41:09 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77C3C061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n6so2179782wrm.13
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0cKnq3ai3qJJvReanp+IwPBsXPj7SOWushngrvWxycE=;
        b=YuCQCO1gX3ngO3LQD2boPSNkp6FOGW4TVqmC+AISi/l8F+9WcrbstnqztEsV/lHxEU
         LaURfbt1aokvdJDJVip9JbrDHDTGCZFrJu5geGN9DicIfhFpPROhk+xzWKEs/oDzDlI3
         2qsvBoyVgQ5ITuL90jlDO4UZY77u1CY7W4Mk65AEC8YmyTSf76YW4X8hXrl+3554Ouji
         wDd/qMh6rbNBZCFBW0xHnL0WnySmsrSkSw9cIkfxYKkLmT7V1vElisz/oyZk/0iXds5u
         isF/+3Jy9iiDrjTBTUl9HR+DHIX1GbG7dQuUtuXG76qnfcK6fUC6dyInmLylFmoHgha8
         8i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0cKnq3ai3qJJvReanp+IwPBsXPj7SOWushngrvWxycE=;
        b=j5hmH5f4WfAdekvjGie0VIvdAYcp2OXamDP6VG7Kx6TmA6ERaIVSYrWLByNxxWz41V
         Xn/mEid1TlMOUutOFmYZv22G0j5+aAYyE8SFKkuKkeiq5yKWrZIicydZvp18x0QZ8DrG
         Hl2z9Uon7rky+4pTDj9MKSK07tv7FKQUgb6gkcYlXq3BNfE5YKxCeNdSjSLoBfkQZjOt
         NW5mFA5yvB2M9H+e9FjUh8ydYqYcm+z7HPERBzDaKVV/xt983bMeyYX8KeG8k8qJqVC6
         kzAXHncvp9RRNWXWPAzbIuguC1ilMs/LQjR4WyBcrk6KRXcvdEHkUtl57pvuNhkInuZM
         WGnQ==
X-Gm-Message-State: AOAM533xPOjKgKcIqbPDSb352yLBl0GioT2WUK+4vNHj9UPDiFtNx14R
        Hx2wkWDRO60Ri9prvMubODz/OWPC+zc=
X-Google-Smtp-Source: ABdhPJyAdybaULnBV489nPAL82quggQ+8Erv0hyjDV/9khz07bmZnqxPqwOR+Y7suA6ESSdcGJjawQ==
X-Received: by 2002:adf:f88a:: with SMTP id u10mr3608762wrp.1.1603201267101;
        Tue, 20 Oct 2020 06:41:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g144sm3051985wmg.30.2020.10.20.06.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 06:41:06 -0700 (PDT)
Message-Id: <cba03dd40bc6af965eb33eba87ea490588dc6bcc.1603201264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
References: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
        <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
From:   "Alex Vandiver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Oct 2020 13:40:58 +0000
Subject: [PATCH v4 1/7] fsmonitor: use fsmonitor data in `git diff`
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

