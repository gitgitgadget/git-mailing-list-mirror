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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3374C47082
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851B061222
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhE2HrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhE2Hq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:59 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B305C06174A
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:23 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id c3so6678182oic.8
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lcl1Afq70BkK4usgPKmXnlNk6B0W42mPK5LncaeVQW0=;
        b=dI0SWbfapRB/W1f6mj9vcsdqG7Yrb0bUSadZ01L93iPND7aXvnfQp0ahKHfxN7+2OD
         TMqSd977deM2A4i/CLaevOrBwiT6sSehwgQ/gtsE6PopZiCezNXzCvoyd42JgqssXK0e
         EfGH3N7mHCIrRGF1RUsCQPRhYHTpm4hTpVJBO3Lttp9D8DxwfPin0V7HhSMkWOP17S+4
         UVg5HDfzcFWBiqFAei+Hsj0McPMVlH7SlLUt2a4XTIYb6dc5RuvTLlAB2wGkRRtmWwMf
         cCCeEWA/cigNsU1J3Vg9CMhmz0YcsCK++oPmRtswTL9v8N+SbFXzDErr4us+TGBn4nG/
         Uyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lcl1Afq70BkK4usgPKmXnlNk6B0W42mPK5LncaeVQW0=;
        b=I1ZpMAn8AP/WuJof4Cr4k6Ch3yVudog1UH43cr/0ztItbgMflB8xeB6jIeekLwz9F/
         jqR6SWZSIzf1FjARypsZJNOU6jodbaiZQRRHZUVhjVfuQ0TBGgA82aZR5ZhwxKX+Lcgw
         jTRsO7BmAybZ0/0am+utjJpTuugao6HKP7Qv0I94RNlcSdrjX9LTDHlIvSqpxEFK2x/Q
         /fDan1QEPxf7h1XdQ+B57+ovu9qF04L6+Ea0Dojv+zCTYa2kdvFxUoCtbmuFglkpZnQ4
         88AHLVCSTuYlAo55DzmoqK+q85GTNvOFpc28caCkFsnRSTy2BBcEQm8Fz0WBcob1oadT
         A0hA==
X-Gm-Message-State: AOAM532jT2Q9JIx+FHDrz3NKrlZkq2Y11m6LCnVSyQr5Aio4bNKNQ6KX
        PxKxR6Exkdx5B+Ydu6d46YWAgiTS2NSZMw==
X-Google-Smtp-Source: ABdhPJyVaCwVGauB6Oc+0LX049sTY6W6Tt6ikZ+mZyDa3SEluPm29si68eCJspS/dncbTOvplpL6gA==
X-Received: by 2002:aca:ab50:: with SMTP id u77mr8440533oie.153.1622274322781;
        Sat, 29 May 2021 00:45:22 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a7sm1624945ooo.9.2021.05.29.00.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:45:22 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 15/15] push: rename !triangular to same_remote
Date:   Sat, 29 May 2021 02:44:58 -0500
Message-Id: <20210529074458.1916817-16-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The typical case is what git was designed for: distributed remotes.

It's only the atypical case--fetching and pushing to the same
remote--that we need to keep an eye on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 2f30a97b97..f1ac531252 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -206,7 +206,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 {
 	struct branch *branch;
 	const char *dst;
-	int triangular;
+	int same_remote;
 
 	switch (push_default) {
 	case PUSH_DEFAULT_MATCHING:
@@ -225,20 +225,20 @@ static void setup_default_push_refspecs(struct remote *remote)
 		die(_(message_detached_head_die), remote->name);
 
 	dst = branch->refname;
-	triangular = strcmp(remote->name, remote_for_branch(branch, NULL));
+	same_remote = !strcmp(remote->name, remote_for_branch(branch, NULL));
 
 	switch (push_default) {
 	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
-		if (triangular)
+		if (!same_remote)
 			break;
 		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
 			die_push_simple(branch, remote);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		if (triangular)
+		if (!same_remote)
 			die(_("You are pushing to remote '%s', which is not the upstream of\n"
 			      "your current branch '%s', without telling me what to push\n"
 			      "to update which remote branch."),
-- 
2.32.0.rc0

