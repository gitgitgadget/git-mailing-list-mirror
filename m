Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F114C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiKCQmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiKCQkk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26624F12
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:38:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id 13so6849685ejn.3
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/xDaYMl0SbEPwulEBpU7e3Xj6ZrQC21MhK40aoEgzQ=;
        b=DaADxJBk/pDXY7LGSNdQGSEsy+4vWch2ujqLruxQpMC8YsMsdx/lqueJKIZrWEXaXW
         9I17vbvzk4or8ZgRvOIsrbvD8VWde4Wliv3fweTxZ2ABuAD0/j4kSkVtaJMpwenIFME5
         byD0BuRJ7k5jHrTJT8MxgVeg31XJbSgvWJFU07WP42yiWJMROA8qaR0DoyUqxkCbjOf+
         zgRktUK1FyQNfyq2RDPfNYOeZFMAImHYSeyxaDdJ4VszYM2XPuiWP78U/ZHMXwnBoRyT
         hB5WgaVb/O1GJAyOqXGUB+SmVVtt1KAL/kp4dKnMpbj8U0Mh3G4bdG9sEleQnCgKSKcz
         +Hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/xDaYMl0SbEPwulEBpU7e3Xj6ZrQC21MhK40aoEgzQ=;
        b=0C2mE95Z2kN2tBKNKwggWToFCqSnPKYQ1WjCIYjJlmXdSremmUXTqG5wP1LB6aV7+i
         Og/0k5Qgvtp7EqIaJou+lU/1QprRTBrsBo5tkeN00i5e5zOA+7oum8hWuR++BexE95/4
         EFoVup8DjzHds00QhVASE5pZErAEYSTS7Teactigy9oyh6tLEFpGZXPj/eGtLqjhSt9x
         Gs4iRhwfCOdRQHI9/j3Ga2mwpmNTI2uFuCVFvTno35gSvaVRyX7Mw00HOVoK4RL3TcKN
         3vN4NgC7UaLrwIhKkk8fwmKrpLyTFIJaHzOU/+iBp/CPmRl312AoLAbM9bNIJPDJnnns
         10gg==
X-Gm-Message-State: ACrzQf2xrDmbi59tfvak+HhV3Hi+4qnOzri/JHoSSYfZnrtqink/dEyC
        ENggU5KWjTjp7UEDu8/qNTJiMOrBWoME+Q==
X-Google-Smtp-Source: AMsMyM4PvwyS15K5nD5vyW0ZnuiJON7aPMZMGpPVxxuxe3h4bk0VGCLpzDcyiSiUrC3uZdOzw0SMBQ==
X-Received: by 2002:a17:906:5d10:b0:7ad:e132:bb85 with SMTP id g16-20020a1709065d1000b007ade132bb85mr19157109ejt.367.1667493490383;
        Thu, 03 Nov 2022 09:38:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078d38cda2b1sm666188ejc.202.2022.11.03.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:38:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/14] cmake: don't copy chainlint.pl to build directory
Date:   Thu,  3 Nov 2022 17:37:54 +0100
Message-Id: <patch-v4-04.14-0f0eb2a76c7-20221103T160255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com> <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When [1] made this copy of "chainlint.sed" the script was invoked in
the test-lib.sh as:

	[...] sed -f "$GIT_BUILD_DIR/t/chainlint.sed" [...]

But when [2] replaced "chainlint.sed" with a "chainlint.pl" it also
replaced that "$GIT_BUILD_DIR" with "$TEST_DIRECTORY", invoking it as:

	"$PERL_PATH" "$TEST_DIRECTORY/chainlint.pl" "$0"

So this line could have been deleted in [2] but wasn't. Let's do that
now.

1. 7f5397a07c6 (cmake: support for testing git when building out of
   the source tree, 2020-06-26)
2. 23a14f30166 (test-lib: replace chainlint.sed with chainlint.pl,
   2022-09-01)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 484b1988a7e..a900aff9960 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1108,7 +1108,6 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
 	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
 		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
 	#misc copies
-	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.pl DESTINATION ${CMAKE_BINARY_DIR}/t/)
 	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
 	file(GLOB mergetools "${CMAKE_SOURCE_DIR}/mergetools/*")
 	file(COPY ${mergetools} DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
-- 
2.38.0.1451.g86b35f4140a

