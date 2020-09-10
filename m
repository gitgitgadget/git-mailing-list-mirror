Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F96C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996AF207DE
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXZy9Z2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgIJTFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgIJTEt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 15:04:49 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E15C061798
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:04:13 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id q8so4199142lfb.6
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kO9q9kW9UN3frhajJtx1JcSBjIZpukmwshqHlQdrHUo=;
        b=hXZy9Z2hY8DpULOhY8dlB/Dml737OXDDdgC6i4DnXZGJDOKGFZBtWn+8+LT+EruIOB
         hHpoOcC83sniW+NJEsN+k31gCIe73moI6KP8WEeqal5SSIuB/H6o/UCyXo+bIm1Di5uQ
         lK5JlKyDoWoVL4QFy5yviYLi811HcStNSUs7LMX87JUmZmurOdWPTMcVKpi74rymeXC5
         MJfq9YrJ6DqgxWqpLNw6qMHnOFOHjEVS/pIldxU2T+NqpLhVi1i0vQTA38FQC29d+QJ6
         xJjPeBk2XBRw9uzXhaL6ragZ9w6pO3Ewa/xXz3rQJ9jCPDqNBsEad8QwLx6KcAiOsTM+
         iP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kO9q9kW9UN3frhajJtx1JcSBjIZpukmwshqHlQdrHUo=;
        b=hl1sFYJ6feZCm7q7t9+kW82gmPqhPbWmoi8/ZRq7VLK8Cj/NCEOtKk94LdqMwn3Tv9
         5IVgIMaHMUlRhL94MlRV7onBrVwjKrmai7L8AadW0UCT256fuMprF3NibT5jVahT5Ct+
         ts0VTHImXRhj6dAHVTGZjktdJ7wysK7HNhaJBCgQ2L1CRJquyq/Droc28rn7LDQ2OxnE
         ihE8HM2hyoyUt65XjPG5DaaSks85MH9rzxx+kqItmJ21mujoARjfpZa+p4obJh8WBR0i
         zpeROU1VkKfAm15oNpp3Shti+5NnjPdj4dDFPzWyUQMEmX/iwasAmrfaaFai+aSw6WOX
         pYxw==
X-Gm-Message-State: AOAM530m5YYpBDzfNCi6fIF69o+OCa8t4YyEwkhq2oWIyq/3Mfo6yDoi
        cFOCqx/j5TkIvHTbjbvJdGK3aCnQN7I=
X-Google-Smtp-Source: ABdhPJwF/eZ2CnqlKf3HVk449VfneilJmYGJoDgg9wleHCTIiLsl/dEUtqr2nS5jCHnJYdEaoKg4nQ==
X-Received: by 2002:a19:834a:: with SMTP id f71mr5052331lfd.59.1599764650798;
        Thu, 10 Sep 2020 12:04:10 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id v11sm1549815lfg.39.2020.09.10.12.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:04:10 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/8] worktree: rename copy-pasted variable
Date:   Thu, 10 Sep 2020 21:03:40 +0200
Message-Id: <6d913ea3e0c30cc1dbcff05974b5d990797e8dc2.1599762679.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1599762679.git.martin.agren@gmail.com>
References: <cover.1599762679.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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
index 050f22dd65..a2d0d20564 100644
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

