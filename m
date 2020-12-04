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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23B9C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD5222597
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgLDGR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgLDGRz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:17:55 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBA1C08E864
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:16:51 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id y74so5000585oia.11
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3SnoBkZ3kSMVpgqZ5NeBlt0BY1cD/WY+UmHuiONhlg8=;
        b=JtSqslYsoffpflZm0ApWPcu51TvKPSUhChaDgbunjFt2yyDGo236bBXDMaiYrntfuP
         h+xPuE2wkMkqr3BDwUCsPzIm0x3H84s1qU9RMMziXbwiXqudULvx6eeXtW0UH76u9SWn
         U/RFknE86y17iqMxRTfb/B+VO+U0ZR8ChviHq1XcGuJYbTFMfhZ3/Nab1aM698mPzj2E
         FT4Oq1GI6McaxV444WtBAk5Jwo3AmINeNhyBdkpWLaLWZmyg5WsBws61EOiqceAQ8Twk
         2AEeMefz4K9G4n3+qYixVUsyyaU+mZ684e2eckDP7qJBHwH5HEw2tgRYshsiyzSQQen3
         h/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SnoBkZ3kSMVpgqZ5NeBlt0BY1cD/WY+UmHuiONhlg8=;
        b=i3a9LNhk8kMlPXCqAtC0ovqyKNBts4kww1df5AtHBrXna9VwpHsaEu/oLGwQJ8t4U5
         qIYmC1rQcYbRngY3JcRaYD/eKKmyIAzKHaqiwzIJwgV2x1IoOWqXOcWkU/eOCGy/mQBE
         Vgbx8BkSaYueK+s8MNbyf6yIhCGUKGHD4jBb9KGNn37HazjThCqwfvYnk6uwUKielBcF
         Y6F32Gm1TEvLPx8MjLnBVEDq4wlJEqPFNDTrSx/OvF1/LhIY1/AhHUyHRwyHLR+KvqXB
         fNoRwboj1evRT/sn2HhTmmp+YdDFxpLFiAy5pLfyAo/zTEficKvFCrMUedUm4pi/gEF1
         6lAA==
X-Gm-Message-State: AOAM533iyoVh8IJmv0THR1smNRcTLC9TD6DvdVwVjFlaMztHzwNppenY
        imDHSFnBoCjZs4DR+cdVp7rUbgIw6eIKmg==
X-Google-Smtp-Source: ABdhPJxma9e/N3Is5VBDYO0UIfIcJwZoHqTXHdkCmHRuHOiL7cShb3/W9DXACijVWDtTALDsQXdUsQ==
X-Received: by 2002:aca:aa47:: with SMTP id t68mr2095695oie.15.1607062611145;
        Thu, 03 Dec 2020 22:16:51 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id c1sm429364ots.68.2020.12.03.22.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:16:50 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 14/14] test: pull-options: revert unnecessary changes
Date:   Fri,  4 Dec 2020 00:16:23 -0600
Message-Id: <20201204061623.1170745-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204061623.1170745-1-felipe.contreras@gmail.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit d18c950a69 changed these tests, but it's unclear why. Probably
because earlier versions of the patch series died instead of printing a
warning.

Cc: Alex Henrie <alexhenrie24@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5521-pull-options.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index db1a381cd9..1a4fe2583a 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -11,10 +11,10 @@ test_expect_success 'setup' '
 	 git commit -m one)
 '
 
-test_expect_success 'git pull -q --no-rebase' '
+test_expect_success 'git pull -q' '
 	mkdir clonedq &&
 	(cd clonedq && git init &&
-	git pull -q --no-rebase "../parent" >out 2>err &&
+	git pull -q "../parent" >out 2>err &&
 	test_must_be_empty err &&
 	test_must_be_empty out)
 '
@@ -30,10 +30,10 @@ test_expect_success 'git pull -q --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull --no-rebase' '
+test_expect_success 'git pull' '
 	mkdir cloned &&
 	(cd cloned && git init &&
-	git pull --no-rebase "../parent" >out 2>err &&
+	git pull "../parent" >out 2>err &&
 	test -s err &&
 	test_must_be_empty out)
 '
@@ -46,10 +46,10 @@ test_expect_success 'git pull --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull -v --no-rebase' '
+test_expect_success 'git pull -v' '
 	mkdir clonedv &&
 	(cd clonedv && git init &&
-	git pull -v --no-rebase "../parent" >out 2>err &&
+	git pull -v "../parent" >out 2>err &&
 	test -s err &&
 	test_must_be_empty out)
 '
@@ -62,25 +62,25 @@ test_expect_success 'git pull -v --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull -v -q --no-rebase' '
+test_expect_success 'git pull -v -q' '
 	mkdir clonedvq &&
 	(cd clonedvq && git init &&
-	git pull -v -q --no-rebase "../parent" >out 2>err &&
+	git pull -v -q "../parent" >out 2>err &&
 	test_must_be_empty out &&
 	test_must_be_empty err)
 '
 
-test_expect_success 'git pull -q -v --no-rebase' '
+test_expect_success 'git pull -q -v' '
 	mkdir clonedqv &&
 	(cd clonedqv && git init &&
-	git pull -q -v --no-rebase "../parent" >out 2>err &&
+	git pull -q -v "../parent" >out 2>err &&
 	test_must_be_empty out &&
 	test -s err)
 '
 test_expect_success 'git pull --cleanup errors early on invalid argument' '
 	mkdir clonedcleanup &&
 	(cd clonedcleanup && git init &&
-	test_must_fail git pull --no-rebase --cleanup invalid "../parent" >out 2>err &&
+	test_must_fail git pull --cleanup invalid "../parent" >out 2>err &&
 	test_must_be_empty out &&
 	test -s err)
 '
-- 
2.29.2

