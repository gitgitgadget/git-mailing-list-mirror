Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68221C55179
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105A52192A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqAQvo8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750248AbgJWOAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750244AbgJWOAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 10:00:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D3AC0613D2
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d3so1692031wma.4
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WacbeA7HEoF6yYPhnvR0GMDR3Bko+fpf0Jw246MFhU0=;
        b=gqAQvo8ENfs9XikWR5fGE4+XCv49YjaCPkaS071kbW+irfUJDP2qLuQQ1MHYwmImSu
         HWCDqemTqFtu/4e19EFHpjPhyz/MY5d2p9VbPnN3j+ovK5HWLDhy3Mv5q5plqocGzM5M
         ROCxN/KVv2ligWOHZhYGzS06trq4yw12XdUeKBqn1cNR+AwaI3jdd6XIXw2iWidlJUZy
         4RWtjZ0D69meMt7NwIf1AVna//mQy9On4qSMS9FvbwSvVmCFTqONhRSLgGNuItY9DJT5
         ziVR4WIZbII5XTUWU9jv9Xel9N0L93X+FvJT/QcK0Vnw4hSkYol8+ppqJHGT+0IGFReR
         2tCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WacbeA7HEoF6yYPhnvR0GMDR3Bko+fpf0Jw246MFhU0=;
        b=mdUBfYoyU7b9JYWBi9hZ6L3bsSqiCaiodHL0E9IPH8WuJHaxMKMkmwwAEh3cmhZRfv
         BhBKPerwtn/UprouUOrYxiWEnuf0/hPlemoj8EmFb1Rauq+sN4TdTkayV+m9VmeXch+a
         bQsNSMRH4vJZyGA+TmU6yp1UU5YzbPcgxuoQumaqffASCcnpcgsQuo6JJl1aev5GC4HA
         Q9jfeJBybQYCME4IQZlM90Xn1G6UlYjMMV8w8Hu7OfvCLNpmmZeLhuwmniXGhMEqCt5M
         +oMegCYZK5DdSv2CUCmWNgLck4wtTUenZpUKsQ3EtesNX8WSwnnO7wlnSaUxCJJY0xbG
         Sj0A==
X-Gm-Message-State: AOAM531rP+bNGoXLN114qex9t+5p2JjZw/zOdeU9+vkGmATT9fd0WIJZ
        Nsw15mVQBBUAQXJQ0LYrnMmgfrlLN2Y=
X-Google-Smtp-Source: ABdhPJzdcz5BEiOSM0xCZiIEIp5i9Ld2WueSFZCh7WE51JIIp8p4Kvnblko/h4OTOjKrw2DKnENHLw==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr2339303wmc.57.1603461614220;
        Fri, 23 Oct 2020 07:00:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5sm4115552wrb.21.2020.10.23.07.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 07:00:13 -0700 (PDT)
Message-Id: <8db960009d071ee3247c972dfceacdf02b3a3dd0.1603461606.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 14:00:04 +0000
Subject: [PATCH v2 7/9] t9902: prepare a test for the upcoming default branch
 name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We need to adjust a test that uses a prefix of the default branch name,
to accommodate for `main` being used soon.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9902-completion.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7b7bc6e4bd..0badcf829b 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1055,13 +1055,13 @@ test_expect_success 'teardown after filtering matching refs' '
 	git -C otherrepo branch -D matching/branch-in-other
 '
 
-test_expect_success '__git_refs - for-each-ref format specifiers in prefix' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH '__git_refs - for-each-ref format specifiers in prefix' '
 	cat >expected <<-EOF &&
 	evil-%%-%42-%(refname)..master
 	EOF
 	(
-		cur="evil-%%-%42-%(refname)..mas" &&
-		__git_refs "" "" "evil-%%-%42-%(refname).." mas >"$actual"
+		cur="evil-%%-%42-%(refname)..mai" &&
+		__git_refs "" "" "evil-%%-%42-%(refname).." mai >"$actual"
 	) &&
 	test_cmp expected "$actual"
 '
-- 
gitgitgadget

