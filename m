Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6A1C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A652389F
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 13:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFoeiCPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgI0NQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 09:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgI0NQS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 09:16:18 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB346C0613D3
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:17 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b22so7971719lfs.13
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 06:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4j7jqVrpQS6vmAshehR1KBBcVzEimHU29GnLiCNjuQE=;
        b=uFoeiCPbJdCfu7BGhKeY2MmltObmrVbe7YMD6f6t6v3GAE92WgRLpaBV+QHSCb5EqU
         Jx+gkhBuieU0DxQPPNWmOIYSNrDsC9w6nhJOFPWAUlZGW59TG0WKgbCQDt5/RnCYI4J6
         rjfFTkmiafovfU3xoGTdmk66vo9TwXpW4EHlJf6nqfcB7a0PbuXMWV8qer7VKq51lBBG
         eOkiE8DNAKgAS/AF6bvnYsmAXEWFQLae9T9jJbf7nalinc9nZwXLE0939v/vIFYQLImg
         sLsxTDmWmVIiz8HViQuWTku5QTneBg0mXPoP2K6SSQVEXIC91MwoiPOkvpKVIF5EhrbK
         fiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4j7jqVrpQS6vmAshehR1KBBcVzEimHU29GnLiCNjuQE=;
        b=O6jyjLzU7t8fZmOwQtD2jnJ4YtYbU9b1f21NFnRikKjSLPIexJDDGe/KB5OD8HoUCb
         kgBEE0ZHhFiPtTpL25799KjzOOk77tG0YpjnVOUfrnPv5tanTQa7dGKCL1UbECpzGW8B
         QGc3lxd9HWt3DA7XMLuLNm+KMI217/PmXccLRfnqE8rZYnl5EFDIwUi8fiaEQpo0L6Ca
         8ia6ANfur7yweByaajkpuvktZjQdujTyRC/Dc+IckhMGlYmEu1F/amsDQtmyvIwvJeum
         BJtHaP7flOIiTHOm8mbWsTapXO/tN2rYMfowN1UhZnnr+1suOk0rZpjCPtWilx1jEiP8
         BAkA==
X-Gm-Message-State: AOAM5316zfYCdX/7BSYgwQCUic5/aG0uqL4FI7xJJE5q4wQdwCcBjCaG
        oqpJN3LHwec919z4ODxXN+2MqEeL4fE=
X-Google-Smtp-Source: ABdhPJzsfqX26nKYyU/5QDm1XMB9bj8r/DZs1DV1jSgPRNo6MU6JDg6Of0O8n/YCMSxqOjw6iqvwrg==
X-Received: by 2002:a19:ad08:: with SMTP id t8mr2285997lfc.41.1601212576062;
        Sun, 27 Sep 2020 06:16:16 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id o8sm2487616lfa.44.2020.09.27.06.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 06:16:15 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 6/7] worktree: rename copy-pasted variable
Date:   Sun, 27 Sep 2020 15:15:46 +0200
Message-Id: <70e6cea3312bf0a587e6614ae06fb5fab17163ba.1600281351.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1600281350.git.martin.agren@gmail.com>
References: <cover.1599762679.git.martin.agren@gmail.com> <cover.1600281350.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the commit message of 04a3dfb8b5 ("worktree.c: check whether branch
is bisected in another worktree", 2016-04-22) indicates, the function
`is_worktree_being_bisected()` is based on the older function
`is_worktree_being_rebased()`. This heritage can also be seen in the
name of the variable where we store our return value: It was never
adapted while copy-editing and remains as `found_rebase`.

Rename the variable to make clear that we're looking for a bisect(ion),
nothing else.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 worktree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/worktree.c b/worktree.c
index 5c9ecec466..b5702aa4eb 100644
--- a/worktree.c
+++ b/worktree.c
@@ -377,15 +377,15 @@ int is_worktree_being_bisected(const struct worktree *wt,
 			       const char *target)
 {
 	struct wt_status_state state;
-	int found_rebase;
+	int found_bisect;
 
 	memset(&state, 0, sizeof(state));
-	found_rebase = wt_status_check_bisect(wt, &state) &&
-		state.branch &&
-		starts_with(target, "refs/heads/") &&
-		!strcmp(state.branch, target + strlen("refs/heads/"));
+	found_bisect = wt_status_check_bisect(wt, &state) &&
+		       state.branch &&
+		       starts_with(target, "refs/heads/") &&
+		       !strcmp(state.branch, target + strlen("refs/heads/"));
 	wt_status_state_free_buffers(&state);
-	return found_rebase;
+	return found_bisect;
 }
 
 /*
-- 
2.28.0.277.g9b3c35fffd

