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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DAFC47080
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C7A6128A
	for <git@archiver.kernel.org>; Sun, 23 May 2021 08:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhEWI5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 04:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhEWI5v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 04:57:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62109C06138A
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a4so25331926wrr.2
        for <git@vger.kernel.org>; Sun, 23 May 2021 01:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YG+mJZgA876oHyPSj8cYG7ZzeIbk3a63/EZuYLPqS/8=;
        b=TyEdBAKkyCoDjWF6DPb7kWZ1L453SSQOARrAwr5sKbml+LGPsp8IpIcMuBWzTAgVMD
         mHk8r9+cFAcgIXSC5S0rTGZVb2sBsXuzG6Uj/c7tO2UN/+wmVs4OhkIKDZTA3CKdjBO2
         s7uI4/bymos1sXjiQPD6sUf8nqgXWogRbqZUEnEDzsLVh9KKrWhN1GNz7In2Xv8/Az5B
         IRHoJjbkIInJnkdv3yYbCJX/ddGohCr69UULGs9k4ugRAQkmV1dLRo4g5yIovtPQmglr
         BBAzkhfuhso3g5JRQ9jokk0A2oEL8SMMH4aeNpdPIBGAVYmzCTHBeqMgjR3jyfdxCJEM
         sPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YG+mJZgA876oHyPSj8cYG7ZzeIbk3a63/EZuYLPqS/8=;
        b=B5hfp4o5nWQOJ4NueDJ03+0BBVwbAl/MokLkHXXSZV3V4ARQ7QWifmyUMY0N+syvvV
         sJUFjwXJFdk7ariZ1aisQOa53aOpr4D2U3qoc1paLlJhCEqybmF4fXMLpoVT7tyV61SW
         OU/G925wpTbLAzjSQ7Biz1c7XjtBNeQnRFzmQRWXjKUZUXt5jx/1AUQ1viQbIU9tpfMb
         7JkPBdcjhDXV1mxGC2XLKDZRxL3yDUcU7k37YNsCnJbGPbZ3cyYVB1rAY+pmwC3y8Z8g
         owIixmuCb7e5VLo0r/NA7sZt6aX00LgW1Aa13cXzdjvbTwYjZ1SLH6X+5nX3ePQyVVXk
         tF9A==
X-Gm-Message-State: AOAM530LLqVmTelhu+dOfoiqF2pL1WYrMLPhIjNzT77NSXYhwzoHpJac
        ykY1W50HUwqBf5ss9nleBfrr/aUHx4UYsu/l
X-Google-Smtp-Source: ABdhPJyG0sHwO89jeY5Ri/eAUeWT2DWsTTtt9r5/fMRUi8jQBSofDt+rsBp2uQayRQsOh+hbFijmuA==
X-Received: by 2002:adf:f647:: with SMTP id x7mr16712921wrp.107.1621760182807;
        Sun, 23 May 2021 01:56:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15sm9577839wrt.54.2021.05.23.01.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 01:56:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/13] send-email tests: test for boolean variables without a value
Date:   Sun, 23 May 2021 10:56:07 +0200
Message-Id: <patch-02.13-707c2ca556-20210523T085231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g05cb3eebfc
In-Reply-To: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com> <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Git.pm code does its own Perl-ifying of boolean variables, let's
ensure that empty values = true for boolean variables, as in the C
code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9001-send-email.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 65b3035371..6bf79c816a 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1349,6 +1349,16 @@ test_expect_success $PREREQ 'sendemail.identity: bool variable fallback' '
 	! grep "X-Mailer" stdout
 '
 
+test_expect_success $PREREQ 'sendemail.identity: bool variable without a value' '
+	git -c sendemail.xmailer \
+		send-email \
+		--dry-run \
+		--from="nobody@example.com" \
+		$patches >stdout &&
+	grep "To: default@example.com" stdout &&
+	grep "X-Mailer" stdout
+'
+
 test_expect_success $PREREQ '--no-to overrides sendemail.to' '
 	git send-email \
 		--dry-run \
@@ -2073,6 +2083,18 @@ test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer=true' '
 	do_xmailer_test 1 "--xmailer"
 '
 
+test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer' '
+	test_when_finished "test_unconfig sendemail.xmailer" &&
+	cat >>.git/config <<-\EOF &&
+	[sendemail]
+		xmailer
+	EOF
+	test_config sendemail.xmailer true &&
+	do_xmailer_test 1 "" &&
+	do_xmailer_test 0 "--no-xmailer" &&
+	do_xmailer_test 1 "--xmailer"
+'
+
 test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer=false' '
 	test_config sendemail.xmailer false &&
 	do_xmailer_test 0 "" &&
@@ -2080,6 +2102,13 @@ test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer=false' '
 	do_xmailer_test 1 "--xmailer"
 '
 
+test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer=' '
+	test_config sendemail.xmailer "" &&
+	do_xmailer_test 0 "" &&
+	do_xmailer_test 0 "--no-xmailer" &&
+	do_xmailer_test 1 "--xmailer"
+'
+
 test_expect_success $PREREQ 'setup expected-list' '
 	git send-email \
 	--dry-run \
-- 
2.32.0.rc0.406.g05cb3eebfc

