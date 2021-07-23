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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D05C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD0976056B
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhGWRU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGWRU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 13:20:27 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E4FC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:00:59 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t128so2736070oig.1
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PA2zRY0CkJyUSImrsQUDKhzZC5tYQmK+FLEZVq1LmXI=;
        b=HoflmpXJYcEPl7qOuzS935Sy7ir4ZIwherdQvwQcZYPTtkm8vxsWlqf8GIiUGyysZh
         D8WNDxmcJA/v+I2/fYslSYtJYiSC4wX2oGbU5OmPz+864zh94fZZnmoQnd+i7c6F+G4F
         6AktBykp0uVUso9pglmWpqxBVkrQuQ9vx40rP1xCy+HZSdj9QpEZtUHK+J4SpGGNTD9K
         qR4OcrvkgzGZNZbusrvYR44P3cQpABOMUGlwqfNiq39UVTNuDGe3CiLQt/qeyB3kHLQg
         rLz6CmCMmg33DptJQAsIX5giY3Nfvb1JhKnXyntbnbxC0qVyEwvygn5Z0CPgphXygpHr
         hA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PA2zRY0CkJyUSImrsQUDKhzZC5tYQmK+FLEZVq1LmXI=;
        b=kOLO9r+c90DKfyYXSrMDhfq16WSmZhjdkxVtSHSeLFjeiWmP53YzkJ/mdnXyL3jd1n
         683XMNeUxNlsElMy250RatBqdpptiGGHSCBtgtO/p3o1HNqGT3evX/fARSQzyLYkAUtV
         BJ/VHOHcHW/llPQB406EsDcWGKFfsmaV5rtZZem8RF1NfrbyFB5VDSgB/MNCwrM6QNSa
         giK9cyz1hclF81UJX2ZMKoPiBTS7QRhJTvUt9Q0cA6XKmFr5nuDaXH5iGiThYbyopSU7
         6jN71MlB51GViZ+K6m8HOABKzLzb/+nXzLFVPFk56bUYF4m9PQcZxWIqEoLFkNkycOff
         UTlA==
X-Gm-Message-State: AOAM531GQ2JUtFS0uxua2pXh4rA/irDvsPqmoNN4hgeA15GQfSt0HI4h
        cslriVC96sDluO/UQk2c2Nvl6frl5AwACA==
X-Google-Smtp-Source: ABdhPJwIJAp1wIv4iqzvQGHrWIXE5udEBwIvdkdZWeMxkgHpAJn90ltIHfV2gKCofXelFLXABRhe3A==
X-Received: by 2002:a05:6808:5a:: with SMTP id v26mr3867756oic.90.1627063257679;
        Fri, 23 Jul 2021 11:00:57 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id b11sm5773644oti.30.2021.07.23.11.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 11:00:57 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] bugreport: add quoted line prefixes
Date:   Fri, 23 Jul 2021 12:59:50 -0500
Message-Id: <20210723175950.64955-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.40.gb9b36f9b52
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With quoted line prefixes it's easier to distinguish what are the
standard questions, and what are the user responses.

Additionally it's easier for the reporter to visualize what has she
responded.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Lately I've seen a bunch of bug reports on the mailing list, but I find
it hard to parse the questions from the responses.

 builtin/bugreport.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 9915a5841d..10e55afe37 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -94,21 +94,21 @@ static const char * const bugreport_usage[] = {
 static int get_bug_template(struct strbuf *template)
 {
 	const char template_text[] = N_(
-"Thank you for filling out a Git bug report!\n"
-"Please answer the following questions to help us understand your issue.\n"
+"> Thank you for filling out a Git bug report!\n"
+"> Please answer the following questions to help us understand your issue.\n"
 "\n"
-"What did you do before the bug happened? (Steps to reproduce your issue)\n"
+"> What did you do before the bug happened? (Steps to reproduce your issue)\n"
 "\n"
-"What did you expect to happen? (Expected behavior)\n"
+"> What did you expect to happen? (Expected behavior)\n"
 "\n"
-"What happened instead? (Actual behavior)\n"
+"> What happened instead? (Actual behavior)\n"
 "\n"
-"What's different between what you expected and what actually happened?\n"
+"> What's different between what you expected and what actually happened?\n"
 "\n"
-"Anything else you want to add:\n"
+"> Anything else you want to add:\n"
 "\n"
-"Please review the rest of the bug report below.\n"
-"You can delete any lines you don't wish to share.\n");
+"> Please review the rest of the bug report below.\n"
+"> You can delete any lines you don't wish to share.\n");
 
 	strbuf_addstr(template, _(template_text));
 	return 0;
-- 
2.32.0.40.gb9b36f9b52

