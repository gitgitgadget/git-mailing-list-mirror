Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7630C11D24
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 03:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F77420722
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 03:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NX2IUo8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgBUDKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:10:42 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:50388 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgBUDKm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 22:10:42 -0500
Received: by mail-vk1-f202.google.com with SMTP id s205so358673vka.17
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 19:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U8Nsdkid7RbnpqUFBGQU90Ct03sT4mvr+XJoAuVVBjA=;
        b=NX2IUo8g/BFhqQ4vCj3+7uYZHCrta55KueEIIoYR80PToDdFrs/T5ABuCuzWDsrJYz
         16K0sOkubjASMYJeSxdAe+NZn/OMBIeArwIpO7uM6jxOE302uYVDGN9IVK1k9uMoDK3Y
         MozZ+n3XsjjqCfe7X39nuC+j9HIIM7gDvMzEZt0J6zy0m6jUC1qDNZU3qNrKTlFMkDmp
         PLAq1jfhuHruspfmWmM5dgp7O1dhR/fGDCCoGXbrpYnwm2REmamh0l/4duiIMdGmYMHz
         iwg6MSUtr653VA4YPWmFEyKZXlwtg+yxKib4HCZsB5dvO7g4h57Dy92EQrKoxezTj+mF
         0+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U8Nsdkid7RbnpqUFBGQU90Ct03sT4mvr+XJoAuVVBjA=;
        b=NPvd8s3t0hU3KStMzaGwbl7JGVrrUpmb6z26iR+166sv9+qaBM73UW7GIGZDqz7Gso
         kX1QuuPE6yn87lYdIGOdUYeM8qdLdZngQEDLHsSF8yqGYZuUDKWh+07LElOYraP9B3/h
         wJZIbuWsX1XFTT9D8tGbFfSss1pK9+csanzRoSguzUSDzesGRvraOg265PcvaSVOpzla
         9Pk9Zhvp3Vps/GLKQPnGE9G7NadgV5xsVKK8iBpiQiDvkvWav3SbyU7tEZ5JHEch0swW
         h4XfI8Yv8DjV8QzmrPLvxHwFiuht4TNBdQc6Q8EGsKgSgP0nj8xTAPtpxjijx+aSLGf0
         cmHw==
X-Gm-Message-State: APjAAAUxb7RroLdNixd48njwBniNVb2EiKeqddW/nIpzRFdGYQG67EiZ
        Rtgeq9lQaRLCmnofdgtaKtUYK3ZPEEIgJY9PXsh0EZMd/UHPp49y2F+Lqy023OUi0qNfaN22Tpy
        zFC4wNkuxoYlo0NCV7pCmMxYPVf8gWU8jPx5dYeofBV5LR+jtIk1aOPhxN7HmIOWAX+IPvfevzw
        ==
X-Google-Smtp-Source: APXvYqxwws9KrRRq9XLSsYyfwz63bQwhFp15+zB7iFNSaQcIdOlCmvb3cRr/wkguNe0yMEzgHfXnzmVoFZI+WosiPI4=
X-Received: by 2002:a1f:9d8a:: with SMTP id g132mr15957577vke.39.1582254639831;
 Thu, 20 Feb 2020 19:10:39 -0800 (PST)
Date:   Thu, 20 Feb 2020 19:10:26 -0800
In-Reply-To: <20200221031027.204486-1-emilyshaffer@google.com>
Message-Id: <20200221031027.204486-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200221031027.204486-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3 1/2] submodule--helper: use C99 named initializer
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start using a named initializer list for SUBMODULE_UPDATE_CLONE_INIT, as
the struct is becoming cumbersome for a typical struct initializer list.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/submodule--helper.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b6e4c79968..1737a91890 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1586,10 +1586,13 @@ struct submodule_update_clone {
 
 	int max_jobs;
 };
-#define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
-	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, 0, \
-	NULL, NULL, NULL, \
-	NULL, 0, 0, 0, NULL, 0, 0, 1}
+#define SUBMODULE_UPDATE_CLONE_INIT { \
+	.list = MODULE_LIST_INIT, \
+	.update = SUBMODULE_UPDATE_STRATEGY_INIT, \
+	.recommend_shallow = -1, \
+	.references = STRING_LIST_INIT_DUP, \
+	.max_jobs = 1 \
+}
 
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
-- 
2.25.0.265.gbab2e86ba0-goog

