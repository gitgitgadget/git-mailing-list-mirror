Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B103BC47082
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E2F613D1
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhE2HM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2HMz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:12:55 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3024C06174A
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:11:19 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso5675778otl.13
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8O61jYaktYVCtPUqpmmvoRMxB8a7kmLTJn6Va3fKmOE=;
        b=uZN7KJvRdm1sNYDOlXCQNPNG6u9GiwFYwAeQSUzLO8z4VZhytwRoRWZ5k24XFBOBJB
         kwVDHRQTU5HtA1di2mye/ExjtW3p0bZxpTE+o3xirJ3ve3bUpZk+lMaA7YwsJBhNHFl9
         wOY/AugVBP4mjb6kA+R/4zDNxp7IM5HzzmBlWKfKAhyNLNYzrbfxanYSOfIwdGcnMjfy
         3L6yDTLfzfOJs1Hth3lji9GAihNixkR2OI8WjgikcWVTnl/yA0dmYSlKNpyPE91Z2IxM
         9dy3XaNFz6L9KR4+FHU0yjw8HebfwJF/ruVamDRspqKIAPgni+zyYTAywZTkc0washhW
         oERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8O61jYaktYVCtPUqpmmvoRMxB8a7kmLTJn6Va3fKmOE=;
        b=KEXrLU/7+ithyeUrCT1sPWY9DzNv8/WdqZQgXi5XFXxiNvcmCJxLeDwKE46Z40Vw6T
         P6LbxB+WlZcFSjrMe46Nu+cIJeABMC13Jn5COGLZ7wz7NauIvX1wRHoPaWU3H43NlFoA
         WK0nHxwlIKImH7qRipCs8kmd5DuGxOyKZz6Tk3sNOCY3ZZnmwMmbjM+iRfJLib0t9Jwg
         eWvwvjfLlFt/uGdYxgKpCUBuItw8V8POcvnXtx2HeIxFqpIsEM+bVFvyycSgWm6QdoTX
         Eaqn/IoVOI3dXDb0J4dwPkgoLxg7uT9RVBmnXM8WdusU25uVBPWYyhRzqOcJSJyPRDDo
         7rxg==
X-Gm-Message-State: AOAM531Fh1Q+vQOCQe/lR8eMtvqc6Wg1KwkqdsbwKKFbY+MBhiFp45QU
        lM+S28IsbS3jlSlzsF1O31fUFSb5wYQvtQ==
X-Google-Smtp-Source: ABdhPJwL2IMZGz13mmeHuiALE3poL3iL25RpwMsfKvpaRIybfriowpUvp2c3KEfVt7XdOG0XuzdTaA==
X-Received: by 2002:a05:6830:1103:: with SMTP id w3mr9965292otq.6.1622272279169;
        Sat, 29 May 2021 00:11:19 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f2sm1615656otp.77.2021.05.29.00.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:11:18 -0700 (PDT)
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
Subject: [PATCH v2 1/6] push: hedge code of default=simple
Date:   Sat, 29 May 2021 02:11:10 -0500
Message-Id: <20210529071115.1908310-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`simple` is the most important mode so move the relevant code to its own
function to make it easier to see what it's doing.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 194967ed79..7045e4ef0c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -223,6 +223,14 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
 }
 
+static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
+{
+	if (triangular)
+		setup_push_current(remote, branch);
+	else
+		setup_push_upstream(remote, branch, triangular, 1);
+}
+
 static int is_workflow_triangular(struct remote *remote)
 {
 	struct remote *fetch_remote = remote_get(NULL);
@@ -242,10 +250,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
-		if (triangular)
-			setup_push_current(remote, branch);
-		else
-			setup_push_upstream(remote, branch, triangular, 1);
+		setup_push_simple(remote, branch, triangular);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-- 
2.32.0.rc0

