Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F021AC433FE
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 03:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiJ0D1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 23:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiJ0D1D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 23:27:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61D2F973B
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id jb18so38909wmb.4
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+b/XP+agw/0T7AFp70dh1VWIQcmAsgkeXobWJllMAI=;
        b=LMcPsgIbBgurIOCrFJJsXAnZKneZhr3fvDnKCchZh1p81UynUK8cNXccMZ+MNM3hQX
         D0A1tPx8gKNEOZwmrBfB+pWTrYIONBHS8+6xR2VWrTjHnwwrj6iwrzIukVBshLVeVhqh
         wp6sI/1LgKh1M7mzyQi+dIpFIaexY0wjAF2weQ9aku2kKJFXr0/xKGTipOtCV89t2WSa
         0zQulyLk6IT07KfZhGjFhw4rEudEVJsDDowIXNmVeZlM1/3weU/txF2qLkZ3VL4FMwL0
         Cez8KYUkjV29sZd2lThTEyQAJOw/2YsAn6nqZ/s2/lZQMhJJw+9W5Mts6HqlGWt7zPRf
         y7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+b/XP+agw/0T7AFp70dh1VWIQcmAsgkeXobWJllMAI=;
        b=Tg2Y7JhJDIRgttKB2pY0x9G3rF/CvLvHcHHWlVOdZoAjimhUiDNC/7n42m1Q5ig9ko
         dieFqbUWZ+rUlyhlkiq77zgsHHhm/Uoze66V6aEPb2MPLzLCeZMoCOrjfqZa6tsj8T56
         gEpbMLifP2koY4qCubXNWKb8qQXcg1sZ+gULhhSOeos0jtk4xPbsbt9rIRoeghvIopd5
         jrv/bshTdiggSvMB+kadEnFU65k0suhuanPSOgXyOUjfINHVRxQ7XH+I4Z5eGbVX5I08
         vXEDhyE+L0Ed7YKKfxItZKmweqcoXwK9Yr51euKPEAmWqqxZ9thz8OEqfU8c1WFlEhQ+
         h8sA==
X-Gm-Message-State: ACrzQf1qeNBCIoS3kOltymvFrcUYD/oEdg/tG4AcXKfcT8CYhDXeXard
        YTwZpO5iT45WaPTeEexcG1HDM2C+q4cvfg==
X-Google-Smtp-Source: AMsMyM5Vj+Z3V42Ko6w3h8k0QnCKGFMxpsRAtBT1zbqei7SWNLVVvys/LU7U6yqdIzlvctNMw/WlkQ==
X-Received: by 2002:a05:600c:a04:b0:3b4:f20e:63f4 with SMTP id z4-20020a05600c0a0400b003b4f20e63f4mr4303461wmp.201.1666841221133;
        Wed, 26 Oct 2022 20:27:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hn2-20020a05600ca38200b003c6d0f8c377sm236828wmb.7.2022.10.26.20.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 20:27:00 -0700 (PDT)
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
Subject: [PATCH v2 03/11] cmake: don't copy chainlint.pl to build directory
Date:   Thu, 27 Oct 2022 05:26:44 +0200
Message-Id: <patch-v2-03.11-2d7d9742a73-20221027T032622Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1250.ge066ede4da3
In-Reply-To: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
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
index a76a3c46767..4db4997ff0c 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1106,7 +1106,6 @@ if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
 	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
 		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
 	#misc copies
-	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.pl DESTINATION ${CMAKE_BINARY_DIR}/t/)
 	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
 	file(GLOB mergetools "${CMAKE_SOURCE_DIR}/mergetools/*")
 	file(COPY ${mergetools} DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
-- 
2.38.0.1250.ge066ede4da3

