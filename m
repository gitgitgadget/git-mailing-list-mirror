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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EE4C432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC4B6137F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 10:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbhHWKaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 06:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbhHWKa3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 06:30:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16716C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:29:47 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g138so10186203wmg.4
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t359ZFyd2mVFV8TRkqLU/JZAZeEiZ6Uymddz19FIZ4I=;
        b=fGWzLu0LpXF4Pmg2aBVY3N/8TM6aeG1XIX4hkV0z2meMWV51xyLkGDmt+ypfHtfBp8
         xJ9gwBG9uxktPEmbK8ElERnr9l4ywkocI8pMDDjd9tWo3BKX2Z9bkCb0nm0UsiDxxDCB
         0e14CAmugDuejOum9w4EFeOJJYDwf2CpsHZTW9z7ku4RH2Kpf+m0OX9i2mDu0MOvDnCT
         Z9tVkPt5LaMvXnOoAQw5rFFel0wBc6xPOLsdc84qBh6yCYjVXhTBQWaTxHHReneNPsxM
         /+0T19YRHTbbhxHBnPpUV/8iueeGAf3y3C3HO4F6Nv75srKHk00VaLxagJeZlhOSUKSn
         xkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t359ZFyd2mVFV8TRkqLU/JZAZeEiZ6Uymddz19FIZ4I=;
        b=rJ6yWaU2acwDNz29gyhZvVwWBlYyppupq8Wpjglw28uOgbMvFrd8Bb/qkOMGvprBFS
         235S7Kv6qWYk3MzGVCG5FMc3dZfpXzTUtlb29HnbRHap/SUoHvfK7ueRHBdmnPLioA4T
         9ikRlMb6GAqPch5sYfSYYFt0i62+nGpT4fW1D4obhrZvjpZtu1fW3yyfOC74cgj6ryKe
         ZI85ZQ1hkuFSkFD8CaPo25wRtBbsVTqz2EIInc8OZavcbd5OlwPuCMPRYx0GGRny1hcJ
         mjVVpl7gieYX13GJr/lbg998j+9EIa1Q5JCVG5epPv9CQsExRp3f1CJqlfZj1zuzI6pm
         Thbw==
X-Gm-Message-State: AOAM5323LCyEwNDctEjWXdMCCzKBGN0fBfUV1lBet6uMCjsIK/4Jxt7f
        GSyT/bxTcTCM6PexqfKxrkeGrzcLvnWybEQG
X-Google-Smtp-Source: ABdhPJwBXFjoUibYsRZ0cba2YC+h21eDOWKXsbT9vvb9986ePRu7BT6zlZpFO6bJyCMcI0bZ3UF4pg==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr15689984wmc.150.1629714585400;
        Mon, 23 Aug 2021 03:29:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y14sm14814383wrs.29.2021.08.23.03.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 03:29:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/2] commit-graph: fix bogus counter in "Scanning merged commits" progress line
Date:   Mon, 23 Aug 2021 12:29:40 +0200
Message-Id: <patch-v3-1.2-443374551ad-20210823T102722Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.663.gfcc3c7013a8
In-Reply-To: <cover-v3-0.2-00000000000-20210823T102722Z-avarab@gmail.com>
References: <cover-v2-0.3-0000000000-20210805T105720Z-avarab@gmail.com> <cover-v3-0.2-00000000000-20210823T102722Z-avarab@gmail.com>
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
index 3860a0d8477..9d18c1d87d9 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2096,7 +2096,7 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 
 	ctx->num_extra_edges = 0;
 	for (i = 0; i < ctx->commits.nr; i++) {
-		display_progress(ctx->progress, i);
+		display_progress(ctx->progress, i + 1);
 
 		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
 			  &ctx->commits.list[i]->object.oid)) {
-- 
2.33.0.632.g78310755cd0

