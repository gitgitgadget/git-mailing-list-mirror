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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD14FC47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3EED610A8
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhEaTx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhEaTx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:53:28 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEB5C06138E
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:42 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so12077747oto.0
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=McPziOCQHzAjrbbNGE5pKs4zaSi25jfHamrn0TD08MA=;
        b=Sn0ymddCWYummtbIZRaQxguoYgjSNwOVuMCb3PxFfWT5CZWK/uOEmK8GYce+eSXas4
         Fc7stV5Ei23JL2YiVmgFlVWr1iDffpovwgAWZbKBH1LxheCuTRaug3vCOVUyxnweTlff
         EmG6ZSDPQ1Ke9c1BwWvob/AkXLR4B97XSyoSkq+SKQ+YnAc1mtZ4N8VMSCgwvM7mTzpG
         0W7XZ6PXT5pRdizQKrNlN44W3yy3u+QnQrpTLx8oR4FW9AGEZ4hQY107SiQER0kgYZ2R
         D/zCOLZ6Wa2FKCuJiup6CrOtrIRvXDWMkL1Wa0fUiHgX/FLy6DJkMZroZp5YLKC5de1/
         E94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=McPziOCQHzAjrbbNGE5pKs4zaSi25jfHamrn0TD08MA=;
        b=NzvlbAuCVhg/QzuUgmPflnWIpu6WhGzyGcaeNhnzNBDuPEB4gWj2+hxIyZjiKdhzXS
         z/JeEPC/VqU7Op7RPwwRM/l0gHxau0VGly17LzTxUOHbvwYPusT2uY+qAAt04byBCS5L
         DLhGPVFpCX3CW+lLg8Iy+rcAjAQjcWgjQVCTBkesuUA8fmywUAXf8QdZIgrI3ghnAll3
         Xol2rOMPLoffmRC7Atbaq/MOtrKT01pjTo5rTNLd8jSXyvF1dLPWXXkyZ+5A160tBe6Q
         ofiEzHzB+C3JeDxGcTVd1foDej5oI3RKXAPoTYVLNvDQ6kOmqQ60KQAIAhT+vcZeAM4i
         P6rw==
X-Gm-Message-State: AOAM5336FFvLHamNjmxJfnTFegjoRwhycnnx1HRhs5bYhu22kCZphRxL
        qqkMHYsdrpQGedUCE+84+lcogOdBx1R/IA==
X-Google-Smtp-Source: ABdhPJwTMaqga7DiRx2aZUWBBQpPOfYaS9n1GmdF9LGgbJb9ZrUnrsgunFwL/U4EbWD+BedVwwnCuw==
X-Received: by 2002:a05:6830:15c9:: with SMTP id j9mr17325124otr.73.1622490702056;
        Mon, 31 May 2021 12:51:42 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id z9sm2998790oog.25.2021.05.31.12.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:51:41 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 10/13] push: remove redundant check
Date:   Mon, 31 May 2021 14:51:21 -0500
Message-Id: <20210531195124.218325-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531195124.218325-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
 <20210531195124.218325-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If fetch_remote is NULL (i.e. the branch remote is invalid), then it
can't possibly be same as remote, which can't be NULL.

The check is redundant, and so is the extra variable.

Also, fix the Yoda condition: we want to check if remote is the same as
the branch remote, not the other way around.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index b5e951bf59..aa22d6a8e5 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -204,8 +204,7 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 
 static int is_same_remote(struct remote *remote)
 {
-	struct remote *fetch_remote = remote_get(NULL);
-	return (!fetch_remote || fetch_remote == remote);
+	return remote == remote_get(NULL);
 }
 
 static void setup_default_push_refspecs(struct remote *remote)
-- 
2.32.0.rc0

