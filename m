Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0955EC47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8C66108E
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhE1UMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 16:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhE1UMI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 16:12:08 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C762C06174A
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:31 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id v22so5422515oic.2
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x4XjHxg08SD9p40sFbkzukBSskBwvuPBvLL5utPg4jI=;
        b=Y1lt7R+H9KJ5O++zfZMij365gVkx+9xBZWDb9zGFEVQZwE/19xrx12jtEjhHg1TowT
         Ku4MBOmjnY7aawiWfYJF1Gbz8I7E7cP2kJ8qqEP2bd00xXt+UDYhvwwfADY5gGltWB3a
         Ti4aJV/evDaCZfpyr85magpIJVoN8S4dN1cZq0sZjT3gIE0RdYjdlAg7uAkP+Vx+3CPn
         0TCYRN2IL2oo6rvxbS041+W5U78sTLX0LaCn60Q0otkTyntXSJeOzAQVDCTXdMkGuacX
         GNb7vdT7YI+xaXowtEB1KoVKd11XnLCny43YAiU60b4N9i46nmsy6kEl6Qj8o/TR5qGu
         8EmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4XjHxg08SD9p40sFbkzukBSskBwvuPBvLL5utPg4jI=;
        b=kPXzswxdospM1ZW0VbUPrTqAn1+JnVCeM8XfAeX0ngvI9FMDrdbUXJHyYdaOOUuiDk
         4/iBg9E0F8nB63DL5Xqvg6e3dvf4tsGxVz/RSGLuKRqqcDsy/4Os1xT8iiO3XcIflcJB
         NxhQKt9c98b3yqt3Z+IUOEWSYxR5/shmlaNMEdpGKHSVpJCeVIY0dMbS0BzpUG7psQW2
         6sObMz+5meCH1uVsu/qZwOl2jEfa/khOdErmIiKfVCNLCfjtUszZV/oRNDFDKa0mVwo3
         ezGRb/d9F9A8u69BTGCXQA3wyerfGgOFVPKi7edCKmNr9SE5jb2rgfhjRVEjLEKm/Wzi
         0/wQ==
X-Gm-Message-State: AOAM530JuQE4ZBt+YoX1b+DlQzoZo9yBkbYjw4JUnPIaWZpSpO5F3mHZ
        7CPNwcId84BqkLpUjWgFFKTV+AC0v+Bctw==
X-Google-Smtp-Source: ABdhPJyMiS1T6YIabkKTIAxVxYMHklkyNqfh/rDt4O5DSAnaARkMks/gL3Lk52fE28/1pdaPlKum9A==
X-Received: by 2002:aca:6543:: with SMTP id j3mr7062017oiw.159.1622232630513;
        Fri, 28 May 2021 13:10:30 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a8sm89221otd.16.2021.05.28.13.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:10:30 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 09/11] push: remove trivial function
Date:   Fri, 28 May 2021 15:10:12 -0500
Message-Id: <20210528201014.2175179-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210528201014.2175179-1-felipe.contreras@gmail.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
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
index 2dda1724cc..8ecfbe8d63 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -235,15 +235,10 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
 }
 
-static int is_workflow_triangular(struct remote *remote)
-{
-	return remote != remote_get(NULL);
-}
-
 static void setup_default_push_refspecs(struct remote *remote)
 {
 	struct branch *branch = branch_get(NULL);
-	int triangular = is_workflow_triangular(remote);
+	int triangular = remote != remote_get(NULL);
 
 	switch (push_default) {
 	default:
-- 
2.32.0.rc0

