Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8811EC433FE
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC4161131
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhIOUhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhIOUho (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 16:37:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03204C061575
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i23so5876002wrb.2
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8h4thXFqHesJICrs185v4px0m1XRMJGNG6dP8TLer6A=;
        b=H+Bq7H2IRD4ZhLcC1a69GOZgkDzzFL9rnZbHfYAc8AFgO3vBOhiEhbL9eg9nOQX8dn
         /aLOzYoGW3x1B3TIq/bXtMTefsdFfUDlYJFPg66vLHABolJoP7rr/zXjtVLs5pFWDCbq
         WBf7CBFZAO7Vh98o6g+0cK9mPc2JuURU9gpZT+x+6RZ3VZ+ESjiad+8HlWeI2khd9DpE
         HC8+pZlMCPoT6uNz5WEoGfvQzx08gi17ys/JaBcAk4yaiHENU22RW9m5kRtWpcYLI97/
         yPRxYiSAs+86B+CMvfZLfiIbHpRv2t3PQDcFkouYomMLv4Gh5iLDpJXrTnCxuv6RAe52
         TGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8h4thXFqHesJICrs185v4px0m1XRMJGNG6dP8TLer6A=;
        b=wVclT4aYClVaocXzGIU/CWPSIPgJqNV8selBOhbqe7wueH3o9iP7dOFqioi7/quXJf
         B708VJSVFdMuXqXTvIwkJ9rKjKDYI6Cb/096lExsD70CkmvLAQIOgMHww2bbU9nZYXV7
         6LQzk3oTfR4Jc7vRcYwh2so0EUK/TFylUE6jaY7ny7+VmtP6vwi+HN6l/MCL8s7qNGQe
         Z4A1wF4pEst7UW7UCfoZmdqLJ8QoyAneHTSqDpXsLVIwlnoclN4MMYMEACLoA9vpKLHY
         QH1cILw2KZqjfTb1KdzL6TEm6oAh/BkJFZywcttGHYUN/MOfr5I/JNpOZIqZeaTmwXZF
         ptBw==
X-Gm-Message-State: AOAM533hD5QchssCWTa5ULRec9961stm1gxwz/yCMfDbjeE2d1vDviZt
        Ha9h6tRYSJmGWYZnluX/hIN060jIERU=
X-Google-Smtp-Source: ABdhPJyb3qFdGWbObeCZcDlr/DgaaA97K5f0rEoNLEc3SqPXxO4XF0MugsGabT7/BgNhGjgor0MDFQ==
X-Received: by 2002:adf:fd92:: with SMTP id d18mr2169418wrr.28.1631738179632;
        Wed, 15 Sep 2021 13:36:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y197sm484309wmc.18.2021.09.15.13.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:36:19 -0700 (PDT)
Message-Id: <5f557caee004f22cee33e8753063f0315459d7e1.1631738177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Sep 2021 20:36:11 +0000
Subject: [PATCH 1/7] trace2: fix memory leak of thread name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Do not leak the thread name (contained within the thread context) when
a thread terminates.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 067c23755fb..7da94aba522 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -95,6 +95,7 @@ void tr2tls_unset_self(void)
 
 	pthread_setspecific(tr2tls_key, NULL);
 
+	strbuf_release(&ctx->thread_name);
 	free(ctx->array_us_start);
 	free(ctx);
 }
-- 
gitgitgadget

