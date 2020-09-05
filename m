Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06830C43461
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3922074B
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uVdybtNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgIETIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 15:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgIETIh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 15:08:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90166C061245
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 12:08:36 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t7so1566879pjd.3
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uG+rdFBgQ4d6bYL826YwKc7u6DJg+MMEMJJlHeoU3VI=;
        b=uVdybtNL0Zy+eebTEz9AmnCD41cpFOXQCON7p2vkTWdvfgpF7N7NqqM7VOYzchyuBf
         uhj3dRMSgGWe/UImnux49or3f6haK+lSxDdHwbkpqIGTkFFTLBbgeyZ3IaRM+WYvjfSl
         lMtJ+EcDf4oxBj+8Jy8pQvkETphq+NWreJ8k/Unmys87F5y5hB2dBFT+I1LDXVLQ+SV/
         OHE1BHjiyUiLY5bN5o3Jr/Y6TMV7z4XcJoBSx4gf+pJR6kdq1zs6//Ixxn2S5q7MP+2J
         RYoBDshJFbf28+9hj1uUDkG0leh//N82bGcah1ribb48Fzjh3V6zOxj9hLDz+XCF6HnE
         91FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uG+rdFBgQ4d6bYL826YwKc7u6DJg+MMEMJJlHeoU3VI=;
        b=L+UuaX8N4E+qwm/FYbKS2ZQEbbUTqzoxsb8QuxEMTNE9bJ7pVlxl+5mYfr4rwDtwke
         FJjfvkwSfw/MOMEhLxflXUaQCRY7E36BLsUJXivpMAIq/Rc8p+7RMcL1N9pVTOnFUjrX
         HmvTSaTqSKpo3dWICC/kK6cy7RuaclWuL0JRnBsRWKR6m75QGZmcGnopwzu1PoTXpe0t
         WX4/AGQ8ah8UwpLl08ymHefJExl2hoqJnylzKOHlH7GjkEyr7T9vDEz1LM6Gfic6Q/eK
         DQ9cb6LD04wosTo9mWkzsZgKnc8PS6Zw6KTMrjx1uoXuNol9Fy4gpEdhnkZWQ9+LMFjO
         9XNA==
X-Gm-Message-State: AOAM531/0VhmslsvslG3bqZJYM13/Oz293sf/wgBUD/TT5Ap2X8cw0zH
        YPa2QifX6geefM9yfNJYo53A42Pl8AM=
X-Google-Smtp-Source: ABdhPJyV11/Ir30gEdGk/YGRz8jWsp7CC9yAjpPOWOdwbXQAEsre1IKV7KwHxh8fIg02OJ3pw4+R3w==
X-Received: by 2002:a17:90a:9708:: with SMTP id x8mr1447815pjo.213.1599332915730;
        Sat, 05 Sep 2020 12:08:35 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id u5sm3045459pfh.215.2020.09.05.12.08.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 12:08:34 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/4] t4068: remove unnecessary >tmp
Date:   Sat,  5 Sep 2020 12:08:18 -0700
Message-Id: <80e9066a59524ededbb0d0191a93e6e3154c5623.1599332861.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.135.gc7877b767d
In-Reply-To: <cover.1599332861.git.liu.denton@gmail.com>
References: <cover.1599332861.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The many `git diff` invocations have a `>tmp` redirection even though
the file is not being used afterwards. Remove these unnecessary
redirections.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4068-diff-symmetric.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4068-diff-symmetric.sh b/t/t4068-diff-symmetric.sh
index 31d17a5af0..60c506c2b2 100755
--- a/t/t4068-diff-symmetric.sh
+++ b/t/t4068-diff-symmetric.sh
@@ -64,27 +64,27 @@ test_expect_success 'diff with two merge bases' '
 '
 
 test_expect_success 'diff with no merge bases' '
-	test_must_fail git diff br2...br3 >tmp 2>err &&
+	test_must_fail git diff br2...br3 2>err &&
 	test_i18ngrep "fatal: br2...br3: no merge base" err
 '
 
 test_expect_success 'diff with too many symmetric differences' '
-	test_must_fail git diff br1...master br2...br3 >tmp 2>err &&
+	test_must_fail git diff br1...master br2...br3 2>err &&
 	test_i18ngrep "usage" err
 '
 
 test_expect_success 'diff with symmetric difference and extraneous arg' '
-	test_must_fail git diff master br1...master >tmp 2>err &&
+	test_must_fail git diff master br1...master 2>err &&
 	test_i18ngrep "usage" err
 '
 
 test_expect_success 'diff with two ranges' '
-	test_must_fail git diff master br1..master br2..br3 >tmp 2>err &&
+	test_must_fail git diff master br1..master br2..br3 2>err &&
 	test_i18ngrep "usage" err
 '
 
 test_expect_success 'diff with ranges and extra arg' '
-	test_must_fail git diff master br1..master commit-D >tmp 2>err &&
+	test_must_fail git diff master br1..master commit-D 2>err &&
 	test_i18ngrep "usage" err
 '
 
-- 
2.28.0.rc0.135.gc7877b767d

