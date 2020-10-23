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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2469BC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD24520FC3
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHcar6wQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750256AbgJWOAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750244AbgJWOAR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 10:00:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37378C0613D4
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e2so1701529wme.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+G9Ybvk3PdGH/bvSc2WcFyK357mlVRLtv839GOt1vvE=;
        b=XHcar6wQ0cHfATJGINmcW2JNzY317QATuE4rA/UPhz6qLpE5FNQ2XTlX2If9x6bfkV
         uLUEoP7nIZheNd1L5REeR4zqu/sj5FZAyc036SYyIxyqSxcCnbLk3kLc9B6bljkDcYRH
         mCCK66IVHbZyMb6dU2NTmv9+o6U1GoqszVp1D7ZUc5OKCyRLC5c94pnwSHSNUYEqe2YB
         869xet/99hLwhcdwW3Oy1XmqA3kSPopvnmbSTeWRhkqCwXJK3nt6IaDHxFWvQkVUiAhC
         BuPHcAVNoTybz53fwmgox27hyISb239UTAFhvmLtZeOsgSfxnOlg7dK1W1RihBoKv24m
         yTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+G9Ybvk3PdGH/bvSc2WcFyK357mlVRLtv839GOt1vvE=;
        b=CyStmZFgcT/ZM60oi8jX5sM5ECvflHuJ+xT9Gwf3NQefOdvF2dGPsT2iZnN95y0Br5
         WPPrFQ1VR7tT3+x25oW2FQemEQaCRs58rW4+ythRNEe+r1xR4u66XL6TCr+0FB/6FQli
         DkskpXyxV+LB0xYxMu1G1AhuKUEVdsqKci98gvqYBqHyNav+j+q8v0PglSL4B4AAGbQ7
         Hst5C7sWnIPLgsC86t2dXgWWJ+o1B9Ye1eFAPXff5ifJTyBhEP6BwXpFD2jNyF8FfnM2
         reMnXH17/48gYbVA9obLEwyYwpXIfVWI8yaUcByP1/DxY2USh0ZUA7OQJ+B2bJq+u1Sl
         WWow==
X-Gm-Message-State: AOAM530E0gq9WXmwrOgOBTseW7sPQv7DqnR1ebb+mcKrMMPvjf6YqPFg
        OtMbgJPoR/5+MHBGsATi229xGHHXocU=
X-Google-Smtp-Source: ABdhPJxodBbKefhzQ9UWVSl5h/TQlW94idqwC7dtq72zDCeAEbtztXrXpeJhJXpyTh3MZ1qBHdRaSg==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr2413583wmr.179.1603461615843;
        Fri, 23 Oct 2020 07:00:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p21sm3555870wmc.28.2020.10.23.07.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 07:00:15 -0700 (PDT)
Message-Id: <e542010fdde91256566b7129e1526b749500842a.1603461606.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 14:00:06 +0000
Subject: [PATCH v2 9/9] t1400: prepare for `main` being default branch name
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

In addition to the trivial search-and-replace, there are three
non-trivial adjustments necessary.

Mark the respective test cases with the transitional prereq and make
those non-trivial adjustments early, to make this change easier to
review.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1400-update-ref.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 770e7be363..4c01e08551 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -585,10 +585,10 @@ test_expect_success 'stdin fails on unbalanced quotes' '
 	grep "fatal: badly quoted argument: \\\"master" err
 '
 
-test_expect_success 'stdin fails on invalid escape' '
-	echo "create $a \"ma\zter\"" >stdin &&
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'stdin fails on invalid escape' '
+	echo "create $a \"ma\zn\"" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: badly quoted argument: \\\"ma\\\\zter\\\"" err
+	grep "fatal: badly quoted argument: \\\"ma\\\\zn\\\"" err
 '
 
 test_expect_success 'stdin fails on junk after quoted argument' '
@@ -704,9 +704,9 @@ test_expect_success 'stdin succeeds with quoted argument' '
 	test_cmp expect actual
 '
 
-test_expect_success 'stdin succeeds with escaped character' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'stdin succeeds with escaped character' '
 	git update-ref -d $a &&
-	echo "create $a \"ma\\163ter\"" >stdin &&
+	echo "create $a \"ma\\151n\"" >stdin &&
 	git update-ref --stdin <stdin &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
-- 
gitgitgadget
