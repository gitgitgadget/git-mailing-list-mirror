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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806D1C07E9C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC40613B6
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhGEMfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhGEMfj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:39 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3C4C06175F
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:33:02 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id s17so20658537oij.0
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PtO5XnfMe8RUxNKn6Gjps2RX8IziArLwFXFgMG4kYXo=;
        b=U4fzO4LOU9eYSYeoMlJ32SuCPp0TH08Pzn0sqIfWIjdhHt2U/uOaLAwIDaT93ZuhDR
         LndQ7Bo5FtL4AFn/zqJ/pg0GLmIhtvXdVSBMubUOwoRGUWy3NH+7+CDa0Jevv9KPkBJj
         IpZORDHVY6zbJr9kd/r7FwJLlPKX/G6iEUEiJLK+Qa5bMjBE1U9r6R0i6OoikO1FE/PQ
         xIKl86RRmTB+NTuKm1+8DVnGCVJPTnH345oaM2ygH7P8rrNAwddjzUc1U3zjjeF9+9cr
         o/qgicT9rjB3/TKDYwyDx8bEic7DZ9pA8cKwWprvK093MIqZs8mGtjp56P+2wcXnjR3K
         pTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PtO5XnfMe8RUxNKn6Gjps2RX8IziArLwFXFgMG4kYXo=;
        b=d763LFAfbqBpSGfaKAfHPS1fJFQaaEx7OFdYBTNwq5qTMbGlfJvpnDiiKTQyxKFf5I
         sqxP0V+Ti2BL0tj6iq8TTvFMBfIDbZOcQAhOGMaHeEkiDMwpSgcrjMjLFx750QHqXTgf
         rEqok5TFtW7Ft4b8KQ/IFmA2iTqDDq4IQctRZSFWsJWvSDnTSmyPALZ+RbouSVegl8b/
         icqKwo8obYwcS2psc99ysI6tq7s48H04xFog03Shm8yj1xWG5fTY17hSqC1I9suWEjB8
         wUY9te8NWZ/rOPpjrpsdC4gA5rXuUHOeCW4TmF0jj2OgeIZPSw3Bq+NvdJURfq2QXp8c
         qmvQ==
X-Gm-Message-State: AOAM532x/vK03yGuqTLP12fGkteGa3UlHgt2zZ4ar1mKScGGNEXffE3A
        yoTFxBKsVAedQfsjwyAFm75XrQTDJ52yCQ==
X-Google-Smtp-Source: ABdhPJz7VRM8iajcyi3ohk18ZxVW0W7pc6tZowBW1ok2Pl8DYp2lKcxVRVxcL57hCRq6dS+KduicMA==
X-Received: by 2002:a05:6808:14c8:: with SMTP id f8mr9812475oiw.7.1625488381251;
        Mon, 05 Jul 2021 05:33:01 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id u22sm1125069oie.26.2021.07.05.05.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:33:00 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 29/35] pull: reorganize mode conditionals
Date:   Mon,  5 Jul 2021 07:32:03 -0500
Message-Id: <20210705123209.1808663-30-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that everything is in place we can shuffle around the conditionals
so it's clearer what we are trying to do.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 295c13fbe8..cbc102ee45 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1114,12 +1114,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
 
-	if (mode == PULL_MODE_FAST_FORWARD && !can_ff)
-		die(_("The pull was not fast-forward, either merge or rebase.\n"));
-
-	if (!opt_rebase && !can_ff) {
-		if (opt_verbosity >= 0)
+	if (!can_ff) {
+		if (!mode && opt_verbosity >= 0)
 			show_advice_pull_non_ff();
+
+		if (mode == PULL_MODE_FAST_FORWARD)
+			die(_("The pull was not fast-forward, either merge or rebase.\n"));
 	}
 
 	if (opt_rebase >= REBASE_TRUE) {
-- 
2.32.0.36.g70aac2b1aa

