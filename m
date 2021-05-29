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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94E8C4708F
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB7561222
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhE2HrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhE2Hqr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:47 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A817C061763
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:11 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so5725628otc.12
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3M9DVF3Kevb0rRWbnLO6lULos2KqkQTnkRkT+6t8to=;
        b=jTdvjOs0c2mDrlbNTbqy4jCzHXS0cUpgNq+l8/sgvjpdn7e9WRl+gDmey5fBefXZXQ
         8g0W3A9Td7TfwLnukZN+uR0cNmb+7SZVdZJGyZT0JEGIvBvSBnYX0OtT3g6Yhfd/51eF
         ishv6JuxyPSFTdBQQWcrsPBEF0UaYO3WLlCE9mSe5ZqzlFGnReXGHIKFdkBWNnBTWTtT
         x4S8bsLbutRoGSHX/pT3u1Xh2lyVXXb4O7dBRgjzXW+JzZgh79YcYgvbtqUeYZFaNag3
         uEKod4BWsBQNoL6Or0sAOhTUZqJrd2StlDCw5XU3REzTT0TRxVX6PjWXix/0IAE1cjsy
         fDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3M9DVF3Kevb0rRWbnLO6lULos2KqkQTnkRkT+6t8to=;
        b=HfzKXra0MqpfJyNSOZxXURsBHM1qPoRz5BdJC0jNAbNJj4bF0IMJMOjWIQf/PV50A7
         hS3eEPujIsFJrFRR/YyPY/5aG733U/6NvwicTpdUuOaqSnWXW7kFqTnPxxm8zUZ6Exqt
         YgsP5vVaWclHk7I4mPoXH0D9my8tZHkqrlFlZhmpMjRAS/x7bGyIi1GQqpm6idHJI9A0
         S/tLUfEMyuWRluUfVInpp5dvEzczOYlN9pbt//+aB2NCqghD60wwofmHPh9c4cQc/6gR
         d8j7PSmemsmstieOFVoApcL5QOx2DJ5JuLhiSP1u5JCFiAocAVzgIgY/DVjo29QVZDZ5
         Wf+A==
X-Gm-Message-State: AOAM530AgqULCG11A7BH4DQ1qH1xeslUnZCbU4q79GvrPt+yUuJc3+pR
        HOVL6RVT0mPgiCiquE6n0wZ8bdRXQ+2iXg==
X-Google-Smtp-Source: ABdhPJymWflDVCK53TfwSaah+Plhj/jgjgLTp1349IiWJO2JMZlQgJxHbIb/Cyh324a1dWtThcbkNA==
X-Received: by 2002:a05:6830:1d81:: with SMTP id y1mr10101178oti.24.1622274310300;
        Sat, 29 May 2021 00:45:10 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i11sm1719014otk.70.2021.05.29.00.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:45:09 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/15] push: trivial simplifications
Date:   Sat, 29 May 2021 02:44:50 -0500
Message-Id: <20210529074458.1916817-8-felipe.contreras@gmail.com>
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
 builtin/push.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 23b1908a5c..21968abf6e 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -205,14 +205,12 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 static const char *setup_push_upstream(struct remote *remote, struct branch *branch,
 	int triangular)
 {
-	const char *upstream_ref;
-	upstream_ref = get_upstream_ref(branch, remote->name);
 	if (triangular)
 		die(_("You are pushing to remote '%s', which is not the upstream of\n"
 		      "your current branch '%s', without telling me what to push\n"
 		      "to update which remote branch."),
 		    remote->name, branch->name);
-	return upstream_ref;
+	return get_upstream_ref(branch, remote->name);
 }
 
 static const char *setup_push_current(struct remote *remote, struct branch *branch)
@@ -222,15 +220,9 @@ static const char *setup_push_current(struct remote *remote, struct branch *bran
 
 static const char *setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
 {
-	if (!triangular) {
-		const char *upstream_ref;
-
-		upstream_ref = get_upstream_ref(branch, remote->name);
-
-		/* Additional safety */
-		if (strcmp(branch->refname, upstream_ref))
+	if (!triangular)
+		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
 			die_push_simple(branch, remote);
-	}
 	return branch->refname;
 }
 
-- 
2.32.0.rc0

