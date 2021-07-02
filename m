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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78EAC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3DD3613F3
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 10:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhGBKHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 06:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhGBKHp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 06:07:45 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D49C061764
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 03:05:12 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 110-20020a9d0a770000b0290466fa79d098so9524510otg.9
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 03:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNZbnlBliDxYg5tRXEJZ7XZcKtaQENCNCbDrFAvkEE0=;
        b=IfMQ30mCBC8g19Z8xvlk/dQ+reTwkBNrSUH5Kk+oPjUP1DwsQ4oVF+75156rew65qC
         hkL+NFj/2mBS1J4RMkU0hhWqrlD4GhUoK6hamFsc7v23yWsuKw30wlxUtyExcdSIZRzW
         u8J9UmwTDpCFlW4HXnmJVTscK16dl6LfBcl3U9iDWrMEV0wn52ZhwTg7D6nLQ9s+QHLk
         TciFjVvUgBJdRT0DuYneYBtzyamCqsrAzjNAXCXKfumd2rO/011VyonE9u7c9+vIVboZ
         Qp4jTC1KgFAw2wP7Lv2/bQIDymoIFS9w9WI+NNmSWQIJCjFqDQN8wAUUG55XfEpGaKEJ
         06Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNZbnlBliDxYg5tRXEJZ7XZcKtaQENCNCbDrFAvkEE0=;
        b=TTtaG/oZchEGYy7bZoHzKmttb5k7pUnKdlA+gX1twGdxDbhG9XhJaPPNPzWkCG8rNS
         ftEL+1D3hg0CQN61LLMHJEZZdngvZ/aMqQ8eo4YAbqD8cjjkL8AT+qD+RuVx/GFI/sGE
         /DDBmHauLMZvjCHWrLiu0JT9fyv8SjqzDgwpDHiMr7W/mQKoMpTrDd7mdjxHU7s/r+/M
         Bn7HfpnmT+/O+Clpfd1vUJw+mxuAK+XEyYaHiram2fRAS2e6zRgr5Fd9H+MRjR5xH0FU
         wBO0pfWXFfO/rDwBHijV7nttYoevVSuclQDY8yhcntsfWNtc/8Bt/xrAm9oh8IbFPCNE
         uzCA==
X-Gm-Message-State: AOAM5326CuUgj32aKEnjkJ6aRc9VKyQlXsKZvG/yce9EaXnQ/K8k/fsG
        aUW229EECRnhqjiNONvMWgmzuJZ0lCJMvw==
X-Google-Smtp-Source: ABdhPJzZ3s6as3WZSocZhEeceBj+DKcPK5JsKcDmHFmcHBq2sF+hw7Il/CL0Q0ZRKTfCEp1fWtt8/w==
X-Received: by 2002:a05:6830:99:: with SMTP id a25mr3660043oto.19.1625220311997;
        Fri, 02 Jul 2021 03:05:11 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id c97sm261464otb.56.2021.07.02.03.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 03:05:11 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/5] config: trivial style fix
Date:   Fri,  2 Jul 2021 05:05:03 -0500
Message-Id: <20210702100506.1422429-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.94.g4574ca548c
In-Reply-To: <20210702100506.1422429-1-felipe.contreras@gmail.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index f9c400ad30..dc896c434e 100644
--- a/config.c
+++ b/config.c
@@ -3482,7 +3482,7 @@ const char *current_config_origin_type(void)
 	int type;
 	if (current_config_kvi)
 		type = current_config_kvi->origin_type;
-	else if(cf)
+	else if (cf)
 		type = cf->origin_type;
 	else
 		BUG("current_config_origin_type called outside config callback");
-- 
2.32.0.94.g4574ca548c

