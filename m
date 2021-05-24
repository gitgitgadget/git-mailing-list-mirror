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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEFCC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC84610C7
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhEXHyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 03:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhEXHyi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 03:54:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB44C061756
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso10889853wmh.4
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uaVkme/NdOkhzzrlmY82ejiFPLnrDxis0DwYi9zGQh8=;
        b=fUOgEIRAca6qO/hRKgzyN5+hhWld5hPJ6LFVY70Kwp+XD37tUtGgevRgeYYlUZ1elG
         MUY6hq2FMG7Sri9yuZnunKZj1gWt1T/rtN/kM4ZPu5oF8l+X7lJm5e5l03FkRWWslJtA
         C0LUWmctFhQ8jIDJZGzAa+p2lO5FUo5q6rS7FdB1HuX4i7fVBLAcPmV6vFppMwx+ObPR
         j0oAufeLLt5t4wHoq2qVynXuTj/R/CmBsWEf+ah9l0/UfKj8wD2tpjjfT6Z9OCUJG8TC
         KDmF7vCpnsXXEia0HCqHH4wtesBrWYeDEeKZnk+nl5a1shVbDOzYq7UVLgT/rHBzqEzf
         MuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uaVkme/NdOkhzzrlmY82ejiFPLnrDxis0DwYi9zGQh8=;
        b=TrTt32g2ZKwucmkuhkyBQjV4rmTdMnILrnqMhroezXiqLQOx/33q2JpHjXAT3BrhUU
         U2pA9LgEXUIQd44PHhkfKvgj/oF8b8I7bAxfg3jhW5xnZTqoFDkq5QJ3B64fswPZMc/W
         53TL8Xg48ZARBBIrvPy1wS4rAjjvTsxgAxFGqtrlFO+JhXNXTN51uhQJXCw09lKJZmce
         z8k4HBfS7eW2XzdwceUk7CJVoH4fqxHgbpz1PYJ7vzDTcMj5ZUdzozNQQp/4g0yCbq/C
         dMk3BHjYBVjbCl93nxOXwhh4QUilH7zZfIram75TSMYOt9tVfAPeexu8qNfL8UiSG6Lq
         obNw==
X-Gm-Message-State: AOAM5332ML3zQO36H47XT5npN46z+6N271tAv3+i9njM6hIPnrY0JTFA
        15+RzFqSjHJg1piVTH0Yh+u4/gqnkgNifOPQ
X-Google-Smtp-Source: ABdhPJysNWzjCPdkSMAJoecHuclGllLVvbz1cG6RiF0q3RRGE3fOtKbs/Hyvh82Hr++gRCL6g4PKvw==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr18652653wml.168.1621842787550;
        Mon, 24 May 2021 00:53:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u126sm8540459wmb.9.2021.05.24.00.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:53:07 -0700 (PDT)
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
Subject: [PATCH v4 02/13] send-email tests: test for boolean variables without a value
Date:   Mon, 24 May 2021 09:52:51 +0200
Message-Id: <patch-02.13-d27f3b48f85-20210524T074932Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.385.g46e826f1e55
In-Reply-To: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com> <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
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
index 65b30353719..6bf79c816a6 100755
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
2.32.0.rc1.385.g46e826f1e55

