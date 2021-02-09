Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B625C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675E564E15
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhBIRf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhBIReb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:34:31 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE9DC061788
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:33:13 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e9so10141820plh.3
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xEhyEIlYwlK26W71yk2CEwFm0W2E5wUKebCHmRDaATg=;
        b=R903VfZeY15ipjahcEmIgut6S7hNcu/9ctdbsxVmpoJnLI5EoOSCYnDbMIwuYLtVJ5
         dIti8IsKDEpV10zlLbLAH/yY/eHnnNBaJH1WjFxHeI6WBoRKnM9kOvknttQYea1TeTYz
         JzA3dvOUPEHPqjDzxMCh0FL8nUujGA0BlFc/LwyydnSVC4Tt1+hP2h5smz9UfepJ395X
         NrlLQ6rohzHBJviFE+wH9KvUToKfIkZBoB0rO++kN+QDLaX9q7NEz7Qx8wmDOYNkCXV0
         +NLARZRhUN31yXqH/wANjalofUhBNMUkx9irw737LdzdSm/hfF4Kx+kiqefCYiB9IEBq
         1msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xEhyEIlYwlK26W71yk2CEwFm0W2E5wUKebCHmRDaATg=;
        b=bxcPMw/uPQijAyxA2JOV+2rlY/eJ52ydDd6PcuEKQo+lLb4laQ+bYYbyQtWy3d51N+
         LuPtQdx9CVlXpwwwmkdDl0Rh5E+dKZ9slKvPwej7luj08KIC/t6df70WocEtv59/wvew
         aC6YUfJlExpHTQwjbjwXrUbQHht3umNR97+N9mL6W+zt9xShEh6yhNjkqTwU0i+njRRl
         Z2e9hEPOBfIriLh9+G8VB9KelF1XMBX5IIRj6/UdyPYb1xC8Pa53txYiu2pQFOxLmwfm
         UecCMSYZ00Q/R4IGb/50G+1gR0x8vFGR0snODcUsxZuQvic4VQXrkh/OdSmQ+hAs3sbh
         Bj7g==
X-Gm-Message-State: AOAM533Fd8gdF6lOr2bOTjuk1+rnFwpbw17tsMCyxVmIu6Ai4QPgxyah
        RMgfG5O54waxO8XEMSiDrm02sI9vySsaFA==
X-Google-Smtp-Source: ABdhPJwMtEpFbcqP57VcN+VPMnayA9PSkBIyEzS3+TS8g7EMYJcMJr2SjbJ7I7Xvh/7A1lcoLCxGuA==
X-Received: by 2002:a17:902:e886:b029:de:57b2:da69 with SMTP id w6-20020a170902e886b02900de57b2da69mr22208095plg.65.1612891992256;
        Tue, 09 Feb 2021 09:33:12 -0800 (PST)
Received: from localhost.localdomain ([47.9.143.68])
        by smtp.gmail.com with ESMTPSA id g3sm20682607pfo.149.2021.02.09.09.33.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:33:11 -0800 (PST)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 05/10] t7001: remove whitespace after redirect operators
Date:   Tue,  9 Feb 2021 23:02:49 +0530
Message-Id: <20210209173254.17712-6-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209173254.17712-1-shubhunic@gmail.com>
References: <20210209173254.17712-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to Documentation/CodingGuidelines, there should be no
whitespace after redirect operators. So, we should remove these
whitespaces after redirect operators.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index a4a14a3b2e..02fbc90dea 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -156,9 +156,9 @@ test_expect_success "Michael Cassar's test case" '
 	rm -fr .git papers partA &&
 	git init &&
 	mkdir -p papers/unsorted papers/all-papers partA &&
-	echo a > papers/unsorted/Thesis.pdf &&
-	echo b > partA/outline.txt &&
-	echo c > papers/unsorted/_another &&
+	echo a >papers/unsorted/Thesis.pdf &&
+	echo b >partA/outline.txt &&
+	echo c >papers/unsorted/_another &&
 	git add papers partA &&
 	T1=$(git write-tree) &&
 
-- 
2.25.1

