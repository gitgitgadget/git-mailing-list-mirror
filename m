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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C51C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0EE76108E
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhE1UMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 16:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhE1UMB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 16:12:01 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F6DC061761
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:25 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so4658099oto.0
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hCVlMZmaZD9qdqc84YY4Mycvu+XQsMSNAHihq6hja7o=;
        b=UK0yDG639t91cIhVAIXFpRqgYVPt5ULHygfkATKGTqbUUr9a9ThoTLOrRjgSjw5h8Q
         eGZoOBmk6ZPdttnv45yNMzpzwr4PxExeboDayfmQ3/mvNUgVdYXTh89zsNRHJQJw9P2U
         ZT+FnTIL5ewM9eSVRBjKmZEqXRajORopIMwwKfzYzlksPSJWiocg9flK/qtZGmVEdluJ
         3OjD8/itYEYzUzIc65f5UONfyyCYBFC8GFSwF8UMwvH1BRGrDMeDsQ2CjKg/McMN5Pbr
         xeyMkXD/hFwMvec3WqVdrmzbZAqidKuU6ArULtIYBn7TZsY5rDly6k2cKWSijB1CNjBt
         evdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hCVlMZmaZD9qdqc84YY4Mycvu+XQsMSNAHihq6hja7o=;
        b=k1FUXXKrtG1W8/hsx55PeBEYRugL19Q+BVxMiCCzkrkg3w6SaQPliXD2eYXV6TJl/L
         HMXEaahxsIsfefNqr90luWNswqyWXI03x2+FeeWHmL96D47msoWPAxs2u3qK4cW/38fq
         FN7e/0zLRbCsK/nZaunXjsnMBssMRgpGMNYCQ42dIMU7J24FPuPbAzoTGPUwL+b1BG23
         F9jj7YbARl10YK/yPH7tI4FEMJ/2czRbsaEyGAfLpTKeaif6Yxr2+Yqn3psLRpoOPoXW
         jZMxx+9wuXG2zXACEd2g5GUF/zpLeFuy7OJGLmaDhaZRmg5469l2CWcifxT25HXCYzA8
         2u7A==
X-Gm-Message-State: AOAM530mD0V2+C8m9yyr4+aFbIIRUipUR/isj0FqQM8nRLAEgD75+8uK
        BSCZyCifnVW8U7cAWietIQc+DnyfGrHgbQ==
X-Google-Smtp-Source: ABdhPJxngiw6l3Ynma3FHUB8B95t1twcoxhMcMAiOUjTNYYTb88JHPAJSuL2WJd4h3g1XLhZ1u3LZQ==
X-Received: by 2002:a9d:453:: with SMTP id 77mr8778749otc.31.1622232624357;
        Fri, 28 May 2021 13:10:24 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f21sm1330981oou.24.2021.05.28.13.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:10:24 -0700 (PDT)
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
Subject: [PATCH 05/11] push: remove unused code in setup_push_upstream()
Date:   Fri, 28 May 2021 15:10:08 -0500
Message-Id: <20210528201014.2175179-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210528201014.2175179-1-felipe.contreras@gmail.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now it's not used for the simple mode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 73fe083682..0961826269 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -186,7 +186,7 @@ static const char message_detached_head_die[] =
 	   "    git push %s HEAD:<name-of-remote-branch>\n");
 
 static void setup_push_upstream(struct remote *remote, struct branch *branch,
-				int triangular, int simple)
+				int triangular)
 {
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
@@ -207,12 +207,6 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 		      "to update which remote branch."),
 		    remote->name, branch->name);
 
-	if (simple) {
-		/* Additional safety */
-		if (strcmp(branch->refname, branch->merge[0]->src))
-			die_push_simple(branch, remote);
-	}
-
 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
 }
 
@@ -271,7 +265,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream(remote, branch, triangular, 0);
+		setup_push_upstream(remote, branch, triangular);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-- 
2.32.0.rc0

