Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C972C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C69564F67
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhBCFtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 00:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhBCFtt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 00:49:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D92C06174A
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 21:49:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m13so22791792wro.12
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 21:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=J03thujzRk4ac3y6qW9ilzPAEj0kqJC5VyMDhlz5qnM=;
        b=N13oHSoOOcOTkrRQd5QE+ny31Nuut7nBOmSMEJDka1DqbkeHNf9CCyshLU1cfXOXeF
         r64W5mcQQaZF2E4EqilAg/Hjh6qLCHOAXDh6j0+5TEd3Qw7audzUD+yMlPFpHOTkZY/F
         QNMNltOPLatJ+a4wPfSMQ2zXXgQ6VTaUbiUI31BLWVPjIs58Mzk2hF6BvrOMqt4Xslv1
         f9xxXgKZh476D4Bp9EN3HJpopbg60XAqH1v/S4HiHaygrh89vT+NR2fluW4rNGUCDiH6
         bEsnSybzZBcCM0QB6sScyHUsQe/XMKwju15sEPYCzv7kHbssRA+gAxiVY1sKhclc4bnk
         nKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=J03thujzRk4ac3y6qW9ilzPAEj0kqJC5VyMDhlz5qnM=;
        b=ISxR1Wph3mQwZn0WJWwRpwToDQN/SctxRAybDL0ztUYwFl2wo7QP9hAVhP2WU63Mdk
         UofcsgRenUSYPIgPLBA1abqvD83fMWpzKucIbtkvQePbqzNPBByc1M24wuCdb4iuBcpi
         IK1NY4osqYOQXTmcWcwRG3+zdgvYeORSV7+7GUZaQdvuHD1Hhe9n86exbNBpCSPApMkM
         L6MWGEP+Pkks3O4IxFdWInTJXmr8rmihoIopY1jPyrciT6gwZoIza7fvn32F7XeJcK3b
         30gitMk2GQNbFcll28c6TeW/cNWxEat/qXcXno1pbPwG6TAuHr6loDJWJkGQlGxBIBUr
         V0CQ==
X-Gm-Message-State: AOAM530iQAYIBfuY6w9K/GwHwPLDoixenngA6Q8W+YwGk4zuhkd1c0tn
        q59s5TMxdEMas7CUdtXuKyIbsIvhRCg=
X-Google-Smtp-Source: ABdhPJzE7dvUaQlxel09jPnOVK8WLIEMc7L99+f32Jz7G6yVwxBpsSuQMTI8VAdtdZSrE2hSQ0F5lA==
X-Received: by 2002:adf:b60e:: with SMTP id f14mr1492648wre.99.1612331347441;
        Tue, 02 Feb 2021 21:49:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm1144312wma.19.2021.02.02.21.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 21:49:06 -0800 (PST)
Message-Id: <3e69857f37e12540f7986245b99916b68702217a.1612331345.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.842.git.1612331345.gitgitgadget@gmail.com>
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 05:49:04 +0000
Subject: [PATCH 1/2] diffcore-rename: no point trying to find a match better
 than exact
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Karsten Blees <blees@dcon.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

diffcore_rename() had some code to avoid having destination paths that
already had an exact rename detected from being re-checked for other
renames.  Source paths, however, were re-checked because we wanted to
allow the possibility of detecting copies.  But if copy detection isn't
turned on, then this merely amounts to attempting to find a
better-than-exact match, which naturally ends up being an expensive
no-op.  In particular, copy detection is never turned on by the merge
machinery.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:       14.263 s ±  0.053 s    14.119 s ±  0.101 s
    mega-renames:   5504.231 s ±  5.150 s  1802.044 s ±  0.828 s
    just-one-mega:   158.534 s ±  0.498 s    51.391 s ±  0.028 s

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 8fe6c9384bc..e3047da3aaf 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -463,6 +463,7 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_score *mx;
 	int i, j, rename_count, skip_unmodified = 0;
 	int num_destinations, dst_cnt;
+	int num_sources;
 	struct progress *progress = NULL;
 
 	trace2_region_enter("diff", "setup", options->repo);
@@ -532,12 +533,15 @@ void diffcore_rename(struct diff_options *options)
 	 * files still remain as options for rename/copies!)
 	 */
 	num_destinations = (rename_dst_nr - rename_count);
+	num_sources = rename_src_nr;
+	if (detect_rename != DIFF_DETECT_COPY)
+		num_sources -= rename_count;
 
 	/* All done? */
-	if (!num_destinations)
+	if (!num_destinations || !num_sources)
 		goto cleanup;
 
-	switch (too_many_rename_candidates(num_destinations, rename_src_nr,
+	switch (too_many_rename_candidates(num_destinations, num_sources,
 					   options)) {
 	case 1:
 		goto cleanup;
@@ -553,7 +557,7 @@ void diffcore_rename(struct diff_options *options)
 	if (options->show_rename_progress) {
 		progress = start_delayed_progress(
 				_("Performing inexact rename detection"),
-				(uint64_t)num_destinations * (uint64_t)rename_src_nr);
+				(uint64_t)num_destinations * (uint64_t)num_sources);
 	}
 
 	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_destinations),
@@ -573,6 +577,10 @@ void diffcore_rename(struct diff_options *options)
 			struct diff_filespec *one = rename_src[j].p->one;
 			struct diff_score this_src;
 
+			if (one->rename_used &&
+			    detect_rename != DIFF_DETECT_COPY)
+				continue;
+
 			if (skip_unmodified &&
 			    diff_unmodified_pair(rename_src[j].p))
 				continue;
@@ -594,7 +602,7 @@ void diffcore_rename(struct diff_options *options)
 		}
 		dst_cnt++;
 		display_progress(progress,
-				 (uint64_t)dst_cnt * (uint64_t)rename_src_nr);
+				 (uint64_t)dst_cnt * (uint64_t)num_sources);
 	}
 	stop_progress(&progress);
 
-- 
gitgitgadget

