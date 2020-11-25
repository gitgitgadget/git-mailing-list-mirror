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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1334DC64E7A
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2DB42075A
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWm1OH1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgKYD3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYD3v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 22:29:51 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9901EC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:51 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id k3so958753otp.12
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3SnoBkZ3kSMVpgqZ5NeBlt0BY1cD/WY+UmHuiONhlg8=;
        b=cWm1OH1lNvVFAGDoQll0+qn1/DzDu6cvuiC/B2fPC5woOg8Vlw/qRH9i+BloZbJRW6
         nWO+f/tmFHTReWbPTyoRpb5LVTluwEcZXxGNMVKOgwCcGfDGF+KGTDq18ycVyjSBfveK
         2xg6O/wUKzAczEoatOjdI78YgJP99nK4GnwXYPouWjVD+14Tf+mvOcu8sZuTvAX0OqxI
         ujfCKSuWTk52cmJhxkQTTuqCM/Xa+2y2w6xqaWuh6CV89i+jHJx09z0fQ63wUv3vRdCs
         +j3wKdPtXWxPoaqedLvC6lWyzKhs1Eyawihz1XGnSYfzt78r8rES4Dqigq4KjSbt4g2j
         V+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SnoBkZ3kSMVpgqZ5NeBlt0BY1cD/WY+UmHuiONhlg8=;
        b=s4tT5MhbnmkA1qCUagCS08ACGZR2xBXSyqYJnK4fccLQNDmsQCrg2G4yqg6agK3Ux5
         XGG+53PNW4+SvqQbv/IBl9jU+jUVe/1i7DpvSWEc9KLyzWXSvY85mIgqD4Gq0kttYy1c
         mrDMM90iiff7bHZ6MT8oInFr4Es5hYBnDn8NejddEQ5K9owzLGMxb1qGbKOY7BzULDTO
         wEltCukIcZHMbGzJMxl3KE3YvIckIIM2cOCj+EgyT7wymm3OBx+HDyHgu00OHoxGl+vm
         ofV5ZjdiXNRST5fefFpYplOtv1vYYq9QKDTbytVk2KC0Gxze561Szb0sYIMeyQaIluNK
         p5RQ==
X-Gm-Message-State: AOAM530yRtEGb2r+FQj7Tn2WORH6OBdtNwfVV5N5neX8azExambL2NRg
        rQ5vTjEnZGdFG1r3cOR42qVoT6oH28GJqw==
X-Google-Smtp-Source: ABdhPJx4glDZmC+FnDJno0aDM+K889ZgqssqpIrbuBdJPrCpHCi4do4GhgtsnXMLCtHxVGrZrHxkTw==
X-Received: by 2002:a9d:eeb:: with SMTP id 98mr1423521otj.179.1606274990811;
        Tue, 24 Nov 2020 19:29:50 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id n62sm558647ota.74.2020.11.24.19.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 19:29:50 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 06/10] test: pull-options: revert unnecessary changes
Date:   Tue, 24 Nov 2020 21:29:34 -0600
Message-Id: <20201125032938.786393-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125032938.786393-1-felipe.contreras@gmail.com>
References: <20201125032938.786393-1-felipe.contreras@gmail.com>
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

