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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C88C4320E
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 12:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A236108D
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 12:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240754AbhHZMX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 08:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhHZMXT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 08:23:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F49CC0613C1
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 05:22:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n5so4689368wro.12
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNJz5avtMIJ+OeVG8HmcBCdKlxUOQ0/obo8qjisRArY=;
        b=YR05l6dtOA+j3Q/Ytl4KU4HMzVEa9q4aUDnvb9V2gktKWRRIvS2qq9Mm6XjWJMHzfF
         1swGDH/l/nmhca1sryPgy+GbHUeSuImOQJei+S7bgstElvfSSqv2WTTGqmA1mDFaNX7B
         7YkUw7tRQBjAu2VIEb882Lg01XbSWOr+WmqGGI4qbMRDKoyr4el9rNBqrC0GENo8rSda
         fWn/PIgN4VhHobVeIkvt01A1UL7GNq6FD6FMKNN9kLonVr4uE3XYkgXAMaGsH3f0Iv4i
         +H6HeyftCHaZ8X0z22DE6PLHL5hhRdHwVd8r6vm+XRvU5ae1BITYyFyR/VkLPXNaOD1e
         LaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNJz5avtMIJ+OeVG8HmcBCdKlxUOQ0/obo8qjisRArY=;
        b=EK5V9FY8L304GCs5sJprGx5AaXL+BKkhTRVthhwhd6yOY4ZnDwlJzr9/ENXssnkZ7R
         7//PK1gR4VTG6j2jl2nsp2lrRinLvR3Xjyr815h71bFLJTk96U9GxGbKLHEB++zkAgV8
         xIgVbb1vgsMZbliDlnp2cHcwo9RC5986ja9rafO3lXL9fuDMJQYxdYyM1QAZ3sq6B3DF
         F0SpCl/40nQEJi6Y5h+KpQWwOZ2pnMBovYNf3nL+wgALVqVYpTb9ZhWaAxsnK5FG0/hA
         jo5Ep1kiyoc23u68dIA89DSqdJePglYdMOFI3fdwN2iI6tG40iT8asUvGw7K/NoF74eh
         XGWg==
X-Gm-Message-State: AOAM531zA14BfaWIlGHSkr3echEG6wOY4gSx77iCXsBHcTbL7l/D8ACo
        wSfSudLPPY5O282s80RCZEyoxjf112Y+JA==
X-Google-Smtp-Source: ABdhPJx3cGwraxD7G1+9OpUBpr0s6ZHYxEzYxq7ea54cTJVv6puJCYdssROsjoJZ+nYqEc1i+pOzog==
X-Received: by 2002:a5d:6483:: with SMTP id o3mr3589674wri.197.1629980550852;
        Thu, 26 Aug 2021 05:22:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z17sm2969885wrr.66.2021.08.26.05.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 05:22:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] tr2: do compiler enum check in trace2_collect_process_info()
Date:   Thu, 26 Aug 2021 14:22:23 +0200
Message-Id: <patch-v2-5.6-70fef093d8d-20210826T121820Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in 2f732bf15e6 (tr2: log parent process name,
2021-07-21) to use a switch statement without a "default" branch to
have the compiler error if this code ever drifts out of sync with the
members of the "enum trace2_process_info_reason".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 compat/linux/procinfo.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index bd01f017bc7..0b47d44990c 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -31,29 +31,30 @@ static void get_ancestry_names(struct strvec *names)
 
 void trace2_collect_process_info(enum trace2_process_info_reason reason)
 {
+	struct strvec names = STRVEC_INIT;
+
 	if (!trace2_is_enabled())
 		return;
 
-	if (reason == TRACE2_PROCESS_INFO_EXIT)
+	switch (reason) {
+	case TRACE2_PROCESS_INFO_EXIT:
 		/*
 		 * The Windows version of this calls its
 		 * get_peak_memory_info() here. We may want to insert
 		 * similar process-end statistics here in the future.
 		 */
-		return;
-
-	if (reason == TRACE2_PROCESS_INFO_STARTUP) {
+		break;
+	case TRACE2_PROCESS_INFO_STARTUP:
 		/*
 		 * NEEDSWORK: we could do the entire ptree in an array instead,
 		 * see compat/win32/trace2_win32_process_info.c.
 		 */
-		struct strvec names = STRVEC_INIT;
-
 		get_ancestry_names(&names);
 
 		if (names.nr)
 			trace2_cmd_ancestry(names.v);
 		strvec_clear(&names);
+		break;
 	}
 
 	return;
-- 
2.33.0.733.ga72a4f1c2e1

