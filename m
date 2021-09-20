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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3357FC4727C
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1938D6124C
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348115AbhIUCWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbhIUBvz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:51:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55DDC0386C7
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:09:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w29so33983740wra.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 16:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FVXQq1j43TFhFUc+YP1fgFv6CFKstbnD0H9uw1sPm9E=;
        b=OK7l5anXvxsBeTKuSv8Ave5vLKiTmzZJCAkrJrrlZvdtgxPdIVnUlSJJw9Ixtmz6TK
         7g5r8cYtWNzuIn91NLxtkUOncLMp3B2xIg68+GRvWXPzOckdNTssmb/YagnEmMcaQCmx
         A8qVIMQ0ABqHSLWDMGhkbZuJ225CquqG95qOnPI2SNeISzPh+6qOj1xf6VFoiu/sypdN
         Zjhy84uutcjx8OXST0RcIcWt0dQtDCXU6HhnUYYk+cRIB76dBtMNKSLWTx7JZ/F1X81b
         W7+447S0fjBW418xeQGslTqNx4mCfvtIOWMAbT8M0lWmKcuwEbASbjCBUuXAZFoUQyQZ
         kyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FVXQq1j43TFhFUc+YP1fgFv6CFKstbnD0H9uw1sPm9E=;
        b=Pax5UMvOjPrezeQUIbUp2Ge0lEilnmcYwuyYe02ygtcVwpfXDpgXKuIEI6TXwpXDXO
         moPNxUGm8N1UprJiUHe0bEOqTMyASx39hip305T0eJ4RtTEb/Dtd/ZNb4rSM7WglPIeM
         0+gTMgEZ6bC+MjANr/w8oOcGGWMpAI6jDilsjVEE0brNvLaMrqEMtQbbTYuBgZeGHGwH
         iGMv0zygl6X6EpmKcitFLJqt7tSGWYv6qXXcJDkdstBZ2xN88Z8q9EvTpVe5chXi0hk1
         sm2mpa6XzSmD6p8yrXPhgqWDbgI3WDfGoG6K3eAcuhHwWem883ITSCUIGAe+lTyGpedy
         zuoQ==
X-Gm-Message-State: AOAM530fzH5uwg7kZ8ogs0Ca/JQfmVkPRLh/yGjS94u3h6ZR/rSMf3ez
        r/B5ubUslOvghnECvdo8AL7RF1e5hAopwA==
X-Google-Smtp-Source: ABdhPJziKmaOt8xz1wN3OIIRx54MdpIh/1c4yg4h6jhiweB/7bkFBhQ/X4/2HYISmCpmWHKFvYDuEw==
X-Received: by 2002:a1c:ed10:: with SMTP id l16mr1415514wmh.8.1632179382217;
        Mon, 20 Sep 2021 16:09:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm10409154wru.30.2021.09.20.16.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:09:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/8] progress.c: add temporary variable from progress struct
Date:   Tue, 21 Sep 2021 01:09:27 +0200
Message-Id: <patch-v2-6.8-d4e9ff1de73-20210920T225701Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a temporary "progress" variable for the dereferenced p_progress
pointer to a "struct progress *". Before 98a13647408 (trace2: log
progress time and throughput, 2020-05-12) we didn't dereference
"p_progress" in this function, now that we do it's easier to read the
code if we work with a "progress" struct pointer like everywhere else,
instead of a pointer to a pointer.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/progress.c b/progress.c
index 1fade5808de..1ab7d19deb8 100644
--- a/progress.c
+++ b/progress.c
@@ -331,15 +331,16 @@ void stop_progress(struct progress **p_progress)
 	finish_if_sparse(*p_progress);
 
 	if (*p_progress) {
+		struct progress *progress = *p_progress;
 		trace2_data_intmax("progress", the_repository, "total_objects",
 				   (*p_progress)->total);
 
 		if ((*p_progress)->throughput)
 			trace2_data_intmax("progress", the_repository,
 					   "total_bytes",
-					   (*p_progress)->throughput->curr_total);
+					   progress->throughput->curr_total);
 
-		trace2_region_leave("progress", (*p_progress)->title, the_repository);
+		trace2_region_leave("progress", progress->title, the_repository);
 	}
 
 	stop_progress_msg(p_progress, _("done"));
-- 
2.33.0.1098.gf02a64c1a2d

