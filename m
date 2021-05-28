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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29500C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0F3613B6
	for <git@archiver.kernel.org>; Fri, 28 May 2021 09:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhE1JZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 05:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbhE1JZd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 05:25:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079F7C061760
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:23:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v23so249650wrd.10
        for <git@vger.kernel.org>; Fri, 28 May 2021 02:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sv7iNawyF3qxEolByD3bBsf8/A55eF52TTUmYN40oLo=;
        b=JuU3HncdvSTaMDPJns7Rwm9Rbavz2ATDYIHDwN8EpQR7Z5tTAlq2EnFPq8B/9i8S7g
         a+2aJTioj0hUdkrZB5Azeg0XIRwwgRxjVdnjRqVSRefHvhGR49nwlsEkanjxg3Aj5YAA
         i1kTwGw53HAM4D5UMtGhjlBLXE5jbc0jhn+nROgLGeFFjg/i/z6j/RIcXatfKuBNzdCt
         aU3leNvUcYtkwDSqM/aH0qXq/ZuZ14VySlWIXLFI0CGicIbA2I+R7tdE3WHMOH6ewJYs
         bAk2BDY2gRkGOzvDZ4+ZA2rRkOXbIgrMHSX7hvIRELaoCT9vtyvW4yj8fwZAXfxITa+g
         vAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sv7iNawyF3qxEolByD3bBsf8/A55eF52TTUmYN40oLo=;
        b=qqDXslrE54aC58+LeOY2c8+/rc2aU+gDc+WaGN5IFMylTFLF0mp29q5+BwcmwfBjks
         sPqL519N7NhXFj0lr+suGvBNKX4p84f29Cb5iw9IC7WlXJDomrZxIhFhe70QP4EdMmIE
         iPsNcBVZAbFQwELS5Dw+FyePQ8CyJxUFsNObXnjOorceRfpn7+Lk2uZu7TPD28nRqqnC
         n9uuH+xDZhWpixsILdUJtVgx5ULaMdgTKqNey6+0+taCqkpYF1znjB19y7eBBz8I+bGA
         47EciQ//AuWXGeTCcsXzOg0kh74Kg+ulDJKoW/ad/qoP5xFTBNUONvR3HnnaeZdMwSvE
         Kvwg==
X-Gm-Message-State: AOAM531vj76YeC4gwgGHES1vl9hAN9t6AR+iKYNldB0t7XcB9wHmQnjE
        aKXbbgm/wlpx/HhV5rHPtFI8wKYkouKW9A==
X-Google-Smtp-Source: ABdhPJz2hFPQtVsVRQg2ZaiNVlsI25w5FuqiwcSX4MoCVxI+X0l2SpM9w0i2DHVWDiFEXyMj4PsVmw==
X-Received: by 2002:adf:f7c4:: with SMTP id a4mr7612639wrq.20.1622193836350;
        Fri, 28 May 2021 02:23:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18sm5842009wmj.15.2021.05.28.02.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:23:55 -0700 (PDT)
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
Subject: [PATCH v5 02/13] send-email tests: test for boolean variables without a value
Date:   Fri, 28 May 2021 11:23:41 +0200
Message-Id: <patch-02.13-16277bd1082-20210528T092228Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.458.gd885d4f985c
In-Reply-To: <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com> <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
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
index 3b7540050ca..612de095fd7 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1368,6 +1368,16 @@ test_expect_success $PREREQ 'sendemail.identity: bool variable fallback' '
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
@@ -2092,6 +2102,18 @@ test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer=true' '
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
@@ -2099,6 +2121,13 @@ test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer=false' '
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
2.32.0.rc1.458.gd885d4f985c

