Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DE3C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709AD61102
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbhHELBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbhHELBe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 07:01:34 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE8AC061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 04:01:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id p5so5989729wro.7
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 04:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I5a4ZMPpE5NneFN7if1q1E5/qmqcUWthNzI7dfmzKkg=;
        b=a+Ww0bpLSz+UCwS2d9JJwL+kSyEs6sPrJf4Zo0H67zKhL30bv2A7AnI7Fi4HUcdsCm
         AxX2QZOHAKMH7okrOMmnG0qBNbmveoEAy0IYO7uRnlmasVbTDpzChSY5z2bRxo6c/tTI
         mIBK0J9CXMEv1gY+gZmQQW7lX5XcKqr9V+7hnZxdoW9HKE6MN5gRQ7HT3af5n/1CKfn8
         tgmx/lPE7gGJS+j0Cf4LrB5kMwhqv9Db+zJUFbmj7zFCE1Io93oE9sLIAxVOCRZKCc7l
         vM2s+9JIfF6XCRpmbliq9itE2GZ+wrqXLsTwCMMbHfieV/BXpNsserNTAQJk6NY0J2P/
         adhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I5a4ZMPpE5NneFN7if1q1E5/qmqcUWthNzI7dfmzKkg=;
        b=SimBqon9wEOYP4jmFBY+K4W8xu78xpDbwkQh8O31lCwstWfeEzT/J31DSdILVxA7UL
         GhouzUOeR6VwV+OiWo6UoPA905JE+wITMvwvGPFnpreDbUnTHryJp0vQFAAxjYxjxns1
         XsniC3B5hhdMZhuhabsIxTvXZCsis1/Js3DxjgYv4zKpwRuYuP30KW9mIh+FIbiKPW4q
         Qy+DOr7ny9hzXPXyp5O7Zer2J1DxYxP+wwleS6vrCAq4TnguosZBH3qLwM/rC+XJryF3
         GDAyOPJA0dMoAMWhUPgzRszz66dWlOom22iPoOsqqIhmqQZjVBnP5OWOJW9gM61bQkkm
         crNA==
X-Gm-Message-State: AOAM533MuS80JPJ4ENt6daddS0lMpBHGVyxSXa+bc9Mxh+OIwG1C7EdX
        vBkwoDh/qnoza0tNvUJPmc/ZJazAH1OZXw==
X-Google-Smtp-Source: ABdhPJwNN/fM0eT0WmdBi/F7UOnsUrKRtX9Dz3gh6gdARCvHrinj1+FPaPvsgO5ewkn4umm0M7LwtA==
X-Received: by 2002:adf:e60c:: with SMTP id p12mr4507335wrm.285.1628161278131;
        Thu, 05 Aug 2021 04:01:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i10sm8836641wmq.21.2021.08.05.04.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 04:01:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] midx: don't provide a total for QSORT() progress
Date:   Thu,  5 Aug 2021 13:01:12 +0200
Message-Id: <patch-v2-2.3-8e67712c48-20210805T105720Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.635.g0ab9d6d3b5a
In-Reply-To: <cover-v2-0.3-0000000000-20210805T105720Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com> <cover-v2-0.3-0000000000-20210805T105720Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The quicksort algorithm can be anywhere between O(n) and O(n^2), so
providing a "num objects" as a total means that in some cases we're
going to go past 100%.

This fixes a logic error in 5ae18df9d8e (midx: during verify group
objects by packfile to speed verification, 2019-03-21), which in turn
seems to have been diligently copied from my own logic error in the
commit-graph.c code, see 890226ccb57 (commit-graph write: add
itermediate progress, 2019-01-19).

That commit-graph code of mine was removed in
1cbdbf3bef7 (commit-graph: drop count_distinct_commits() function,
2020-12-07), so we don't need to fix that too.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 midx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 321c6fdd2f..cad78d71fc 100644
--- a/midx.c
+++ b/midx.c
@@ -1292,7 +1292,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 
 	if (flags & MIDX_PROGRESS)
 		progress = start_sparse_progress(_("Sorting objects by packfile"),
-						 m->num_objects);
+						 0);
 	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
 	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
 	stop_progress(&progress);
-- 
2.33.0.rc0.635.g0ab9d6d3b5a

