Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4D4C47089
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiLFCJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiLFCJd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:09:33 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0DE2409E
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:09:32 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z92so18411015ede.1
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBNq0+RjJrOOIuKDQS0E58sMfJXH2MZVTOPteojgxi0=;
        b=T1nUlrGUmU8qgXcPLItdmhTI3xwJICTtx0x5sJAMlP045FkVCSt4H2gt7Fh3U8GQri
         ZnKIbic09eiFpo6JD4SMnkB4+Rgt4pIv/igAiSITRe0SH8TT/D+tFMxtJsANa0+8W5m5
         azozUrGOimBn/3DfrRuQg3rVSd1uiHBmfsB9lrc3mfmB+YMCU/MMp4q5Wz++S9Pk7P9Y
         epAqbud/eO75dHvKhXSdouRIZa+rxHjcsRcWXh83gz2iDAItCrtmrXmUvN0tPCh9XtS0
         FFvrNmFfDCbITv9hRvqv8Y20x1VGva1VBXylZnmEWrZzx0Y3RDQhW58awlAFGfcQgijV
         9ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBNq0+RjJrOOIuKDQS0E58sMfJXH2MZVTOPteojgxi0=;
        b=3q76xqWMu7aTTJ/tXocOBZppA6NeFSlmzB47tVN9LF8tUaONZ8ydzTBTQomhWi9jk1
         J7ND3Z6tDhStULhwnu7gZbkdXqh7hTtYCbAV3lSlt4ajmEDNBVo2H9D0QbqP98nJhJYV
         SZXnk2NaUQ4g4YzDc/J1XewfkZiUmnIADXu0E3rPsVpL+PRB8lXZdJt/bbH7Gs8CvnIb
         JuJt7seXGx8e/BXLgctjkQcotOF7IwYUJfJTv4MBsk1cwzMC9u9k8tw5YFnyq513QRPs
         dWk3fuaV0R0yY64lv3BaZGf2WwSk3ACj16NzLQXluD91OoqOcef52jS+vXCDPlLo1kws
         OnFA==
X-Gm-Message-State: ANoB5pn52Pk2OkfHSYOLfLeM5Z0Tw7EJqgQ5x3B8PFh4sHPOAe1iVGYV
        ygDc+hJhRaGPCYUBrx2v0CI54CCxY6E55A==
X-Google-Smtp-Source: AA0mqf48G9FvkSoxcIixDl472D9ggom4OVdKU3z68mlZ2Wnl5QbVSx/EmJZ06tqubEhOXo7IR+AmIw==
X-Received: by 2002:aa7:dbc3:0:b0:461:6b61:81ae with SMTP id v3-20020aa7dbc3000000b004616b6181aemr75332826edt.62.1670292571471;
        Mon, 05 Dec 2022 18:09:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6966186ejm.178.2022.12.05.18.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:09:30 -0800 (PST)
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
Subject: [PATCH v6 04/15] cmake: don't copy chainlint.pl to build directory
Date:   Tue,  6 Dec 2022 03:09:02 +0100
Message-Id: <patch-v6-04.15-7b7850c00ee-20221206T001617Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.1006.gb4c675778ba
In-Reply-To: <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
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
index 80290edd72a..c641e9349c9 100644
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
2.39.0.rc1.1006.gb4c675778ba

