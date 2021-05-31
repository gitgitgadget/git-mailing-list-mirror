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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B6DC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535B761263
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhEaTec (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhEaTe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:34:27 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A746CC061760
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:45 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso11998498otu.10
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m9c/HJ7Sy0ScaPhRt42O0eYelD2BiaK2jTOgIvBXfFQ=;
        b=AHtXkFH5XymbmpgsmmSXgbzHK0ZItSWskDdWEG6bogvV3Om45tVsoye+2ZHdgEWx24
         I6VjNjjI4AcZVnupG36Brpc+51vH+823RWOhlo0KKtrHrewGQjW687wb9HsQKOeGxM6f
         J9tp6rojerz1cku6REVcpxnjC1DHtSIZEbNcwLR9x9wOR9KvABlPKNCjM7FFb55cXQxw
         ZEFdTkF8U9pfe9uYaVLflBo1OSYsiof71JllDsSgBpyJ90+bORy9mEDiG0otN1JxK/qT
         2C8rreJW5VSwP0rPlxFb993oazSHx340A1Ba2TQsgJwTRx9YU6QQFwOV64n8GtOqt+2a
         +ZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m9c/HJ7Sy0ScaPhRt42O0eYelD2BiaK2jTOgIvBXfFQ=;
        b=l3iu+6+kmrD/JZ23BbwihSl8OQXOJrBV8nuo2bCj0NhyGPZ4/8qypoJ8e+gc0+PLRI
         rcyzIHn0iIJZRgKAom2DNBJe47EhNXclM7uqfe1VzTMm03gmFphW0zv9Hs7cjC1RWqqC
         /melJ6y/oTVeEHIjIqLwJe2WDw+2PXq9Q029/ORm+y+UK6YGQQ3b3B1U51zbXF+NPq5k
         Ia5LO2zANYouFH0XDaiDFsLmFUPcaRSFFAEl+t8TOZdDYuiFAnoa3ruDnK0VHPmm6SFp
         Y9GBnVAWIBhZ9gV7uCu3nvf0XL51WzWuU4K186deSKYevNZ+yoWDFVyvDmk5H3p5uwuD
         JsUA==
X-Gm-Message-State: AOAM5325T6eibV/cTyAM8y/FGqWcCjKEUm7lOONAe3+9y94cSPAf9agF
        Zzge3DR2/vt2bbHWxU1gCTuHa99Ty2AJDA==
X-Google-Smtp-Source: ABdhPJyH37dQKgyy3S3wkUYY0kwyi8xGXTXFoWVV/nhcnMQHzb0aF5gPPVYfQX9TmpRHABd5VSDg9Q==
X-Received: by 2002:a9d:68d7:: with SMTP id i23mr9012729oto.136.1622489564841;
        Mon, 31 May 2021 12:32:44 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r85sm856569oor.38.2021.05.31.12.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:32:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/7] push: hedge code of default=simple
Date:   Mon, 31 May 2021 14:32:32 -0500
Message-Id: <20210531193237.216726-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531193237.216726-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
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
index 06406353ce..48c38fe25a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -223,6 +223,14 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
 }
 
+static void setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
+{
+	if (!same_remote)
+		setup_push_current(remote, branch);
+	else
+		setup_push_upstream(remote, branch, same_remote, 1);
+}
+
 static int is_same_remote(struct remote *remote)
 {
 	struct remote *fetch_remote = remote_get(NULL);
@@ -242,10 +250,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
-		if (!same_remote)
-			setup_push_current(remote, branch);
-		else
-			setup_push_upstream(remote, branch, same_remote, 1);
+		setup_push_simple(remote, branch, same_remote);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-- 
2.32.0.rc0

