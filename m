Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B40DEC873B
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 15:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjIGPYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjIGPVs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 11:21:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32DACE7
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 08:21:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a9d6b98845so340629066b.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 08:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100081; x=1694704881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwMKgStb0gtvCSRexFYqFykdGSWjbsq8NCIRN6CDTsY=;
        b=XbpNsfTEjFNzUUq02MBav3ktPQCVTF/bI0fdg/j1sPxPoU0QHGI37b3O8UPfKzbUek
         MPvZEXDWmSP8iF7RGYLH8XTAnuz6s6j7/WrDiWqvuoSTxFpPMaEuwFHxt0qUMMsrruEf
         tbL3Wp30fPf7QU5TjlcT/5/ik+5Arzk53mmnp7gxrkhq7x/utMenVdWMLR6Ssbpnkjo3
         sU0Zd2lyP1AGelvfMnWrZBgJFTWLpZAerNQHybgAU+uUTZstyUe/3uyHzeWqkxf0NRsL
         UMDpolsWxFFNmB6rMLXpTnKUcobpCkvodKNVCkgT81+lDM2Imlevxdb40jYuGmgV/ZIl
         hUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100081; x=1694704881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwMKgStb0gtvCSRexFYqFykdGSWjbsq8NCIRN6CDTsY=;
        b=eXuSOe6BJdSWeivsa9eY9660AriRXiKbrD+UW0Vi1yO7v5uL7eysjZTkk1Az12hOG3
         B6z2TQOGxLDwPcoz2zj1uKNVGBHV3H0bkV+i4pM70hIFTH7BPtSZGrqU0lzrf/NbNO8u
         grP0Ongxn4t0LqSONebrcqif9JjZt4EALhzfEsOKvUKeN+y6c8gznRUMUaC+v+tC2TxI
         o79EtmwxRhJ20SSgSvCJuNSAce9gB8N38wYATTyIqKRzlVwVAlPxxX/yHro3xCSPDwBG
         CAtU1N7CovLgrTiQ4BzrlUp6pfv9h06FMf7FkKKnUMQGNssLw2MAsM5dREESK+KO93Uo
         NPsw==
X-Gm-Message-State: AOJu0Yy99Jn6XX41L0j20Py6T/wTtQwaVaCeqDuZJQFVmdBwCOS+5zYL
        9XOlLw6yMNADab8jrd996lIufLtyuBY=
X-Google-Smtp-Source: AGHT+IE7GXLuvXJRB0xPye6DFSSzD49cWrjf8xjglMYcBJCD7hVUP8TfhXFYGuRtp9qkglfy36cm3w==
X-Received: by 2002:a5d:6852:0:b0:319:6e9e:bbdc with SMTP id o18-20020a5d6852000000b003196e9ebbdcmr1550198wrw.32.1694078844322;
        Thu, 07 Sep 2023 02:27:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:3385:ce2d:69dd:303e])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm22491522wro.43.2023.09.07.02.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:27:23 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 06/15] replay: don't simplify history
Date:   Thu,  7 Sep 2023 11:25:12 +0200
Message-ID: <20230907092521.733746-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.126.gcf8c984877
In-Reply-To: <20230907092521.733746-1-christian.couder@gmail.com>
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Let's set the rev walking options we need after calling
setup_revisions() instead of before. This makes it clearer which options
we need.

Also we don't want history simplification, as we want to deal with all
the commits in the affected range.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index c66888679b..4b1e501595 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -173,15 +173,6 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 	repo_init_revisions(the_repository, &revs, prefix);
 
-	revs.verbose_header = 1;
-	revs.max_parents = 1;
-	revs.cherry_mark = 1;
-	revs.limited = 1;
-	revs.reverse = 1;
-	revs.right_only = 1;
-	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
-	revs.topo_order = 1;
-
 	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
 
 	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
@@ -189,6 +180,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 
+	/* requirements/overrides for revs */
+	revs.reverse = 1;
+	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
+	revs.topo_order = 1;
+	revs.simplify_history = 0;
+
 	strvec_clear(&rev_walk_args);
 
 	if (prepare_revision_walk(&revs) < 0) {
-- 
2.42.0.126.gcf8c984877

