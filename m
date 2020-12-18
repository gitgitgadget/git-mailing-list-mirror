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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB71C2BBD5
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D51723B99
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgLRVLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgLRVLP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:11:15 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28029C061248
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:35 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id d8so3248077otq.6
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJnlbsKYM0chD/Gthl0v17QGOikKDyUWIw8ZTTLMq28=;
        b=XH7aZmenEMUyAqMgHNRnKUS6QahzX16fw1amWAeBXMqoVGfGgtM/vgCYBNP7TOfkEP
         4677MmPkY4RTuysmvUcGd1lidYM3Iiu/R6TO3nbEotIk86cBEC2KGCojS1LMfnsMeMj4
         bLI4hPvZDblPfNEZdyzsi5jtMBJ2Y9dhU9prLv6n1ZCml3lyqELQtJ/65sfmaHz4Aq1k
         5Q+uI8bQ5bcG972GeoAYcSH4GsKD93di7DlyPn2kkUlavD+Xyh6/OrZrLlxVQ8M8ybG7
         69venrLBXb7vPJDOXtNmNOL+VMq0K3ojnx2U3dKA/v/EwWJOTfDQ9aJR72t7iNDe+jct
         hnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJnlbsKYM0chD/Gthl0v17QGOikKDyUWIw8ZTTLMq28=;
        b=E63ydwnqbaZ/kJ30WeOS/7iVsWRpYzYHzP6XR1UK/ulszTC3QOvCAhn5KaWtgITOp8
         EgQFIPdmQWY26SzS3SFOv21sKa9Op+gxTBzGEZvtR36seYtVcOpliZniWxDGVGP1M8Gu
         mFGibP8DIMQQZNvoKD5urnLnI6w93+ODk2Rm7/E4jVWowrkvztLOwzAVnjhG8RSnae9R
         ka65nAdLbuhVRrMIpHXuiqyeyiZsR6PC6asXvxeUhjJvNR8pW8P3c3lZXW3UWpGcAda4
         Q9vJ34PmwqLiQUbk3tICD/e8NmGTkNzSZnsQGGgQDOGd2s2CslSVkNE2IYuQaemORmmj
         INDw==
X-Gm-Message-State: AOAM533eu4PottwZyioM1iBp3+HuDyhBv29kHCnwFJkYWJJmiYbEx8k4
        qkZWQaD42Pc6tT8mOykc4Fe5ClrU7/STuQ==
X-Google-Smtp-Source: ABdhPJzg2duQu7voba2GC/4E6hXr4sAnartrR9BZd8O4kEeS18eTDoJEJ3EVxUnpEHdYA1Kce7YNrQ==
X-Received: by 2002:a9d:4d8b:: with SMTP id u11mr4253591otk.13.1608325834376;
        Fri, 18 Dec 2020 13:10:34 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k63sm2000347oia.14.2020.12.18.13.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:10:33 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 04/13] pull: trivial cleanup
Date:   Fri, 18 Dec 2020 15:10:17 -0600
Message-Id: <20201218211026.1937168-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201218211026.1937168-1-felipe.contreras@gmail.com>
References: <20201218211026.1937168-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to store ran_ff. Now it's obvious from the conditionals.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 42cd6c38d8..21089e5a29 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1055,7 +1055,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	if (opt_rebase) {
 		int ret = 0;
-		int ran_ff = 0;
 
 		struct object_id newbase;
 		struct object_id upstream;
@@ -1070,11 +1069,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		if (can_ff) {
 			/* we can fast-forward this without invoking rebase */
 			opt_ff = "--ff-only";
-			ran_ff = 1;
 			ret = run_merge();
-		}
-		if (!ran_ff)
+		} else {
 			ret = run_rebase(&newbase, &upstream);
+		}
 
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
-- 
2.30.0.rc0

