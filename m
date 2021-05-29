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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0002C4708F
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADFC761222
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhE2Hqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhE2Hqo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:44 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4999BC061761
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:08 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so5725571otc.12
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tceBuoCFUwo1siRa1V6py7p/7P77mQLvcOKr4454YM=;
        b=IWxpuY9YC4yuhCQg0IW2TVup7zgvjQFYhImUXwVL7RbD1LYS1qu/ZE8IbyxIzGcI7D
         +oisL8Yh9RssHCugBeeCxoCW5U9Ss9lMyzvUze+pzF+r3engXZizhEQgZR84DLkma/9U
         RPykJ8yrCste6FlTMOUU2w21Z0oM/KO+dWIvzmdpdjSGFVxsW5iNCbdKqGOq6joZYExV
         0PrRTwvclCO5c7ikQwTDxZd9pjRxEjHYWvTYMKalnM2CEBHnE4ygfKMZGxQU+8B4+WS9
         N3oH2ieiSmI6cRe6WGkFQxFNMTkZbtGG04jNH0M0TbiLdt0AOyppsKnvIcfr4yIOk2ol
         qksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tceBuoCFUwo1siRa1V6py7p/7P77mQLvcOKr4454YM=;
        b=bxs7e7WGMn0AHwCEUeK3udOvwfNbCOGZ38GZDjhKtJ7sI2coXQtg/rDD6nKRBU6e5B
         Vw05tJBbatQR8BkRaOQemzMDfvIvcZRMKglc1wx3h0he15RPnG5ioIzzmST+MkAaFaXb
         rAtfkTg4wueu700S39FfaFSVyHycYCb0C2z7q6/KsYjHt3+4seMnicFyYnoKlsT3yj1B
         viRZVJwiqXU1rPJcM4UrIjWzH8iHk/6F7dXEjEIv4n3eeylXwWOefqEF0eFYi2OWDZgo
         tCkRiy8q3GxMzNDMFVfYh3tdKJ/WE/Y0Jomb1rCtlbj0T4+ztq2EncrsKDyHsecbWSm/
         7iZw==
X-Gm-Message-State: AOAM532tDL6LR1gkFI+6BljEwmZMcGpoff37V46QGo1uzTGdO8zVFpvf
        E8nSyzO6sn6knXKAg853UfT05RmLn7jVMg==
X-Google-Smtp-Source: ABdhPJzXbzrUWCKnvZllfA7n3ggvd3SCVund+ILsXvcSX6o790EGBG4V2wvtDpajDztOUCAo9zaLCg==
X-Received: by 2002:a9d:30c3:: with SMTP id r3mr10012288otg.292.1622274307407;
        Sat, 29 May 2021 00:45:07 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id n11sm1639438oom.1.2021.05.29.00.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:45:07 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/15] push: only get the branch when needed
Date:   Sat, 29 May 2021 02:44:48 -0500
Message-Id: <20210529074458.1916817-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index a2abacf64d..4b3a14278a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -243,7 +243,7 @@ static int is_workflow_triangular(struct remote *remote)
 
 static void setup_default_push_refspecs(struct remote *remote)
 {
-	struct branch *branch = branch_get(NULL);
+	struct branch *branch;
 	int triangular = is_workflow_triangular(remote);
 
 	switch (push_default) {
@@ -258,6 +258,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 	default:
 	}
 
+	branch = branch_get(NULL);
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
 
-- 
2.32.0.rc0

