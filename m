Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC49C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3417661166
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349069AbhIIBL1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 21:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348992AbhIIBLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 21:11:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AFEC061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 18:10:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso171052wmi.5
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 18:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=atz5YvkpaYU5ftvnFbIOSkz/cMePbWWY6xkV8tze44E=;
        b=KIyyyL9oSwv67Df2olV42kKx/KhTZgRP9kWEXCvyugyQC0PD/sgwHobY+9qO5n+j5s
         lxSv4A+DhnB5eeGpTwmlUTBwdwUCojoNJapn/ctviKSOVqgB1IuJRmwoXx5BDEitYYXM
         PzSYdmpQsyEiI5ejBbJ0qn/q4NoysuUUwJqyngzzOH6g4hlfIZv/hDWz/20I7V0dNK5X
         pWvYlouCStkkhsXjSiBVtWiireQeS+1ij/ViQoGe/+K3fKsWi6NXiD5NifOKUeMx4FBB
         JhSOftoDtm2u/JqTal/IqsTcVk/R0aDjfX0xWRZl2yh50S5tdiurmCwd8P1kcLy0EyM4
         9ZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atz5YvkpaYU5ftvnFbIOSkz/cMePbWWY6xkV8tze44E=;
        b=dSRnw7IkQLR7OoIdwQ5WFk41hSHBBQYHJLuT5UMgRnHbkx7az1KfxQ9vxs8R1gTAZo
         iwp3zo7YWTltZ48r0PAZoXFNK2Mmksc/q/oucgZIvYXV1sSBV2rPc9E2IGHKVtkLxWCy
         hFVgxehvmtIs4WM2UGuTBeu80OOzi7wkxNB99AHsxKa2CDFX+wG2eHFKkKz4VpF4w0nX
         7VIfTnefXtiV7L1i6mAZG2tFboKytUdVoqNEeJHfBdhb4LEZNtgQsnGsYnIm8dD1zIM8
         4FL6b52IiqQ+XzUmJV8xlG4UjbhW/hXWIpLBrEN0MdRXRtX4PD2n1AeHuVY+//uARLXp
         HQcg==
X-Gm-Message-State: AOAM532MqEfNckkZ73q4+wRFV29m2mVr8uXUDvnJUBVSalm3ZVcvM4Xj
        K1r8STqY6/VEu2igNNJxx6z2g5Drqlmh4g==
X-Google-Smtp-Source: ABdhPJwjtwLG0zdM3vxAPuejVDlYK8MnPKtKL37viQanqy2JaYhhCZnyVfJgaaoQ4CSa7tbXaMVVSQ==
X-Received: by 2002:a7b:c405:: with SMTP id k5mr204036wmi.87.1631149815470;
        Wed, 08 Sep 2021 18:10:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k4sm187422wrm.74.2021.09.08.18.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 18:10:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/2] commit-graph: fix bogus counter in "Scanning merged commits" progress line
Date:   Thu,  9 Sep 2021 03:10:11 +0200
Message-Id: <patch-v4-1.2-4cc3923089d-20210909T010722Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.gdc3f7a2a6c7
In-Reply-To: <cover-v4-0.2-00000000000-20210909T010722Z-avarab@gmail.com>
References: <cover-v3-0.2-00000000000-20210823T102722Z-avarab@gmail.com> <cover-v4-0.2-00000000000-20210909T010722Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>

The final value of the counter of the "Scanning merged commits"
progress line is always one less than its expected total, e.g.:

  Scanning merged commits:  83% (5/6), done.

This happens because while iterating over an array the loop variable
is passed to display_progress() as-is, but while C arrays (and thus
the loop variable) start at 0 and end at N-1, the progress counter
must end at N. Fix this by passing 'i + 1' to display_progress(), like
most other callsites do.

There's an RFC series to add a GIT_TEST_CHECK_PROGRESS=1 mode[1] which
catches this issue in the 'fetch.writeCommitGraph' and
'fetch.writeCommitGraph with submodules' tests in
't5510-fetch.sh'. The GIT_TEST_CHECK_PROGRESS=1 mode is not part of
this series, but future changes to progress.c may add it or similar
assertions to catch this and similar bugs elsewhere.

1. https://lore.kernel.org/git/20210620200303.2328957-1-szeder.dev@gmail.com/

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 00614acd65d..46170592204 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2125,7 +2125,7 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 
 	ctx->num_extra_edges = 0;
 	for (i = 0; i < ctx->commits.nr; i++) {
-		display_progress(ctx->progress, i);
+		display_progress(ctx->progress, i + 1);
 
 		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
 			  &ctx->commits.list[i]->object.oid)) {
-- 
2.33.0.825.gdc3f7a2a6c7

