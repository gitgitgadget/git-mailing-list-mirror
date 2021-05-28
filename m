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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEDDC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948A06108E
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhE1UMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 16:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhE1UMH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 16:12:07 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E4AC061760
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:29 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so4585919otp.11
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uaw2PsITaX6kekMQc3Q0etgPrhdxsg93gJ/3LYFmizI=;
        b=dCTF31mWk4HdS2ccSmqdMCVsnnsGbWXQMdmTxvez/zrlTpXXyknvOt1Nt9ns6gv7YJ
         PhfG9rpRQ7bH7VOKJPVfKwcZcVWHRpAKkQXv7GiJTWb5E2FcHncYiEpc1WMjJMyKHpsX
         HpqFhbmPdOnGvoBFcAkvyhavTnmH1/qJRCCzdNjjh+6nJ9kydVASfZo+we/RLQm8Kmzi
         yiNMJzhweRnaeNuvzFtYcyKS4OT9MJsvq3Y24M6ow+hvIqMUb/IcOku46DhN6OQJHb+a
         fIFlNE4ZU9fJMmfFdaI1hgj4hbdJ9A4p/97PZL+8jhaqcOfVZebYjuQ5W3RW8IC4kGaf
         RnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uaw2PsITaX6kekMQc3Q0etgPrhdxsg93gJ/3LYFmizI=;
        b=KS9k3yDCyojyAKqMFLMxMlDBBnkPNeRsAI7tqsu6GBXQAreQtqeqj/co/EN8SwRdZm
         yax4414sPQvxorlVfcA/8oGEdqWfYDFp8hTHN/yy1teMTxFsSXaa6QFpYwn5UsdpVm9+
         d8HoRgSR2XGFLQ0q7SS5uTmma9Q3eOJPifM42wp5GHTEKJtvoxy+sUic5m4VPhP8Igtf
         PGpHunIGUbHmKJR3jcCP2AMJ9OlpCFWOiLC/tXiacrYsKvY/MNkDyBm9iOARk66TK4zd
         AR29jTLVcLVhXvVhHWDc5+DVccaT6ARH+9YOCgvyK+GlCyCpImoIFMDdmoUYXZz1AKz7
         wpDA==
X-Gm-Message-State: AOAM532Gb+0MMuK8qzqQWUD2hZqmT8KABWNLRm1t7QX6ZwGWs8kvGdjk
        YIhUgz7VK2lLREGh4QUaDutIsLaeQMX8kw==
X-Google-Smtp-Source: ABdhPJySGCviBb4uBsLgEyde+iPRTWjfUDQg5tD/oxGpR6wz7OU9ShrZNtC9Y/1PGpBNuBYazBk60A==
X-Received: by 2002:a9d:542:: with SMTP id 60mr8633277otw.143.1622232629078;
        Fri, 28 May 2021 13:10:29 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r2sm1329510otq.28.2021.05.28.13.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:10:28 -0700 (PDT)
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
Subject: [PATCH 08/11] push: fix Yoda condition
Date:   Fri, 28 May 2021 15:10:11 -0500
Message-Id: <20210528201014.2175179-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210528201014.2175179-1-felipe.contreras@gmail.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to check if remote is the same as the branch remote, not the
other way around.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index f008cd624f..2dda1724cc 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -237,7 +237,7 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
 
 static int is_workflow_triangular(struct remote *remote)
 {
-	return remote_get(NULL) != remote;
+	return remote != remote_get(NULL);
 }
 
 static void setup_default_push_refspecs(struct remote *remote)
-- 
2.32.0.rc0

