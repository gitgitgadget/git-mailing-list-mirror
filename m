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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F210DC4708D
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED35613B5
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhE1UML (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 16:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhE1UME (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 16:12:04 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AE8C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:28 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id p24-20020a05683019d8b0290399e8a3aa60so103290otp.7
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MND7CxXkCpWVTkvEAF445hC0TfdUYtEVoVLeQZV/beU=;
        b=Nv6O9otp6vzbafN3Bs1pi3eTcalS6azvGZFiCvUI/dGvdnY5wj+s6sPGKWX2etjEIP
         dm1JVsYwt/6C80Dgq6P+krZuSEBN9NMEUsfPKB/TKKF4bnFZ/b8UQOAcq7inbQ7/UCMh
         mKO4mXJ/39qiTBQVPgUTok06OGKHh7lw76oeSwRSD93LUMvClkf2FV7GSJYLInrrfEE8
         FP4lDBwYdP7lC8OLp/7iQMPTj7ESacKQAnyl9Vxh1i4F0O0AuGPkyenwKxsXU1eHa9BZ
         Am6qmMBTBzV6gkB8jwfbHgvzX4iBGY28UupKoPaa36WxbStJ8oQy0zqE1ugasoLOD80g
         b/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MND7CxXkCpWVTkvEAF445hC0TfdUYtEVoVLeQZV/beU=;
        b=oyFZLc1vMtH/3gaiQNGNGLDxCgC206F8zOqA1zqQv0+3o3Iapg9RsKW8RaAiE9qL66
         cDVjft268/y7rcjPQCfLTkIUfPBQOh9YMA+dwW1d4ojTnFCMCLGxcNh90GZbCksz2aHb
         scCPSvnJl1OBdVZKn5yQ9oqFWfLtnIYp2apLn7OGRh9+hIUgIa95OsT1oF7zhiPd+qsS
         XWItoNZB4rfkedeP3BbhHBXe4ERkk5zyZlmOLSufizHeiQnN/tV26PGXrDx1INlGRwNT
         yOZyUwtIAPBA8/uimgWmCKWZKSWsHCDWn65jZg5pwaz1K09TVSPzRWAZ15JlusiYKKwq
         bKSQ==
X-Gm-Message-State: AOAM532f0OUXyqSZNbS3XPupkQaL9XeH2x3Ilfs5mOpZFX/V1/vkw1RS
        tSbh8NRflEtDoDQuGJ9KOPo92cGG5Rh5LQ==
X-Google-Smtp-Source: ABdhPJwqyFtpqOGlryJx1yQ6GhGwRCALBshpdpLea0QKz8sTQn6OLeSeAhKxDLYEhsHlILbiZgNEpA==
X-Received: by 2002:a05:6830:22d3:: with SMTP id q19mr8520732otc.258.1622232627611;
        Fri, 28 May 2021 13:10:27 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id b18sm1335517otk.62.2021.05.28.13.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:10:27 -0700 (PDT)
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
Subject: [PATCH 07/11] push: remove redundant check
Date:   Fri, 28 May 2021 15:10:10 -0500
Message-Id: <20210528201014.2175179-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210528201014.2175179-1-felipe.contreras@gmail.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If fetch_remote is NULL (i.e. the branch remote is invalid), then it
can't possibly be same as remote, which can't be NULL.

The check is redundant, and so is the extra variable.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 2d6358f776..f008cd624f 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -237,8 +237,7 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
 
 static int is_workflow_triangular(struct remote *remote)
 {
-	struct remote *fetch_remote = remote_get(NULL);
-	return (fetch_remote && fetch_remote != remote);
+	return remote_get(NULL) != remote;
 }
 
 static void setup_default_push_refspecs(struct remote *remote)
-- 
2.32.0.rc0

