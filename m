Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A73C433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA3F22AED
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgLVADw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgLVADv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:03:51 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D40C0611CD
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:46 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w8so15694786ybj.14
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xksZ8TN+Bx5zxuwy/jMdxbToJEO3CXMa1+UlyOml024=;
        b=cXnu/3plmkjViH15W08V7wwwypVbR6t47iHNOv4igl3Cua4vXG7CmKx5r4cj+qjrlc
         d8wOK1zR4r2wjXMJYqRyCQBFC3W8LNfqMENUkvg0Z+F20AHZ5TOt/G5y2Q7UnkfRKPz+
         mFRKiRwtS7AByAaXkVXDWz69oGig+qVcMb9X6QmI3X2pEYb5tpLsVeMvalsFefNoatt6
         y/bNDhuAhjq/UUuCTXu3hp0725g3o+6huRiGkm0MTc1Dthh6yzS3j3Wvj95DDdcEGrHl
         dFaKnD/n96kRUlSU/3vHPWxnWlsHy2mvEOoEKFUnpEQfX3xHdliU7gkcbsK3u8QxlJON
         l3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xksZ8TN+Bx5zxuwy/jMdxbToJEO3CXMa1+UlyOml024=;
        b=oFJunwGbP+S1WbJpq0MyF/7WVSpQbuucv4jRmqdIMqjKmUAv6R4xNYAR+YEr7203EV
         EH0yGfa+gdh4YWxwltO6tYjDXlPj6LQUeszmtzTzLN1U0HHlploQ5vFyDjWBUUwmAuLy
         fEYWBxIKLg5Iz59Ru/w/IQJJSr/xOAZ6a1wKGdHg3yr71IPHgFKrDjL/mt3uA+86o7sP
         SjKUdNNALGFuEzGnIra/95IzOoMukVCGhB2WDltGZHd1v+LOj4F3Sr5jcgZ6P95cQx6r
         1An7/2ScUVd7OWw5FXn6i143xsdpTHHX06JbDcSj8u8gfaiaCEnz31FfXAv7Ri6V3bWY
         cOww==
X-Gm-Message-State: AOAM532j8wbHJzrtyIOHMOQFVerjsv841uK3zOSqMhwIu9cfRPn/SIO9
        nYxmXO2iieHhOJqZRXOVtchm7bdiohMtT4/YVMJMCrKQcH/sGs9m8wqLPcIXjYMQDSZp3TQDJTD
        cEmsAsy3ZLT3s/NQnp2JWFhULtNV1xTs5ViJkJvW6xNcyIFW+oJnl4FitCNqu9P33zVYGz9Avaw
        ==
X-Google-Smtp-Source: ABdhPJwyxhVhdtc6MQEaxr7gMbUVHRg13FR3GKmfdZri/AFaXJIkGahydwGCQNm1fs4NOUJxADBApQoqbrw44Tzkklg=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a5b:101:: with SMTP id
 1mr24847735ybx.507.1608595365912; Mon, 21 Dec 2020 16:02:45 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:02:14 -0800
In-Reply-To: <20201222000220.1491091-1-emilyshaffer@google.com>
Message-Id: <20201222000220.1491091-12-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v7 11/17] run-command: allow stdin for run_processes_parallel
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While it makes sense not to inherit stdin from the parent process to
avoid deadlocking, it's not necessary to completely ban stdin to
children. An informed user should be able to configure stdin safely. By
setting `some_child.process.no_stdin=1` before calling `get_next_task()`
we provide a reasonable default behavior but enable users to set up
stdin streaming for themselves during the callback.

`some_child.process.stdout_to_stderr`, however, remains unmodifiable by
`get_next_task()` - the rest of the run_processes_parallel() API depends
on child output in stderr.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 run-command.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index ea4d0fb4b1..80c8c97bc1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1683,6 +1683,9 @@ static int pp_start_one(struct parallel_processes *pp)
 	if (i == pp->max_processes)
 		BUG("bookkeeping is hard");
 
+	/* disallow by default, but allow users to set up stdin if they wish */
+	pp->children[i].process.no_stdin = 1;
+
 	code = pp->get_next_task(&pp->children[i].process,
 				 &pp->children[i].err,
 				 pp->data,
@@ -1694,7 +1697,6 @@ static int pp_start_one(struct parallel_processes *pp)
 	}
 	pp->children[i].process.err = -1;
 	pp->children[i].process.stdout_to_stderr = 1;
-	pp->children[i].process.no_stdin = 1;
 
 	if (start_command(&pp->children[i].process)) {
 		code = pp->start_failure(&pp->children[i].err,
-- 
2.28.0.rc0.142.g3c755180ce-goog

