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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22DFC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CD26127C
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhEaTxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhEaTx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:53:28 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8593BC06138F
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:44 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id b25so13301658oic.0
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8XK9cpcF7wdu7UmhfR9mf1LNs8M7THc6tpxy3SzJQSU=;
        b=kDkjqaSWzOdf8tZatmyBFlfACTu33MpGblwj3UYh/TdJYyKE9nf4AIC1a1Dh6qszgj
         bW5fedPBEMpOhMt2A5k7wXOR7HnsE2tLyUaZbAh9uVXSYeTNAdlE3+cugm0FgeGBKPhr
         Y7DCJoKdyHl+ZwM5Bdk6FaZ2v/3qL8BYac1kE0j507T5ijTcP/Ki1FA7N6XRY6fUmDp9
         0ZmJ9ZmF/eNBlmaH+yVncrD3dS/rx3sx/rKgMdspdiUtzF5PI3TyV2aS9RTienGp8eLa
         wFkD6pd6kOpCDTNmodvHvFB8BeAaHt4eQB71QHnyOdVVHcjytm5OfabVSC56V/lR2ZIZ
         Es9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XK9cpcF7wdu7UmhfR9mf1LNs8M7THc6tpxy3SzJQSU=;
        b=aaxKkQBrz38uTmdPp1rdEAbQu2CByBeArBMHAHwlIu11YPHcz7LoLdwmUwiDBCh0gh
         gHPhJgdkSY4Yw9UuqL/uDZHjnvF32ULvcy07/vS6Tm3NPqrS9uaymvsH+mi4scWEejLq
         uyNpDcP7WGetLadXnlDcHHwLN9XJ5UT9gYj3SQaIowGcI0PFnUru6Y/hO9+9sWuMNlOO
         p/vC01WW8Fi23kHoQxyrT4FaCqBFzKW+sjgdDulKlDRnRf05hnRnFW4flYp8fLSfv0Aa
         +qPRAzUw5HDaRGX4GGPa1lob6uel6Ks31VbgHiDzZzp7dImCnnK/kN1eT46eFh+z23eX
         CNsw==
X-Gm-Message-State: AOAM530Lc/fh9yTAFcn0Cd+9dpPNOv8VnYDfsXkLjAxA2SQrG2xjflu4
        hoDWl+n+LguP6iyoSJGbs5sUno0Uo1Yhlw==
X-Google-Smtp-Source: ABdhPJwYOU+I0qFxMKk1taQWnveI1iCxFipYO+lp+770pnVwFT4C7+/yEWCwi+kcnIAUUUtfWmslsg==
X-Received: by 2002:aca:48f:: with SMTP id 137mr454525oie.75.1622490703709;
        Mon, 31 May 2021 12:51:43 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m1sm3314170otq.12.2021.05.31.12.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:51:43 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/13] push: remove trivial function
Date:   Mon, 31 May 2021 14:51:22 -0500
Message-Id: <20210531195124.218325-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531195124.218325-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
 <20210531195124.218325-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's a single line that is used in a single place, and the variable has
the same name as the function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index aa22d6a8e5..a873f8da92 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -202,15 +202,10 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 	return branch->merge[0]->src;
 }
 
-static int is_same_remote(struct remote *remote)
-{
-	return remote == remote_get(NULL);
-}
-
 static void setup_default_push_refspecs(struct remote *remote)
 {
 	struct branch *branch;
-	int same_remote = is_same_remote(remote);
+	int same_remote = remote == remote_get(NULL);
 	const char *dst;
 
 	switch (push_default) {
-- 
2.32.0.rc0

