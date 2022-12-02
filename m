Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC017C4167B
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiLBL3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbiLBL2s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:28:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0104E98551
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:28:45 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x2so6130581edd.2
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/ZIiMuOEHCvswo/Pz/Lnw5lrFWYz6AyLH1clr/FB7o=;
        b=iOkzXQSUaQU1pdjESachtHIkDPIJUDC4YQb0ttRrx2Zy1YRqawWxMd8iVCg04yChik
         0wp6e0QmYMCQ8nJ+8YCRgSx2mgzmFnyakpQQ5FadiwAp7pu6BsWd1vF7uD3Zi549zi/g
         VMkNIcI3esdnnwpgQnz+OzCBdfPXIypsFPj6H7vdhxi+W5xzod9fMaaG7gG1RUyRkxEf
         uUQftulSkhALoAZpJed+tDRGvvLsr+PqUoe/gbzLWhycmWML08NXk76Y3o9EoyidNbwI
         WQ/jgaifs3WIo94F1tSC2b6BdjU1vNt7QhXOXCmw6ZCMl5Vxc53+9m4lQpE8I1NQLRXN
         7XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/ZIiMuOEHCvswo/Pz/Lnw5lrFWYz6AyLH1clr/FB7o=;
        b=g5Nd+L1oD/tvmzThYdM4XGI0az7EN+ByEX7HukQ3GAWpRIEiG/tNuoQAC+sfFWh0C5
         sTx+7mw3SlNRFdNGbuP2XOO9e9fZSZQwAozv03vzdY8XDEANcu5lSj8fB3gB3yT82JBg
         j+Y/Y8QTNNyA/3C99OJdl5nYrTx2jXmFo+M3tnq/ayLv8gXV6NnNrn8xMj2oUq/gccuV
         1fmAv4T1SDC5Y4MPdJACUrc/sAOtvY4b266kXmbYpleziPl6EnumXNxMvkzVlpyGOI5H
         3A35ywUU3r0BPFeepJ/ESU6m06njCh0i1WhXTrzd7jgTfaj01QqqJhMcbuw1NvthREOP
         AAGg==
X-Gm-Message-State: ANoB5plqTki0JWe+ao7p9aSJDkQ6QshvzQNITfMNZtG2JWMwXoDDtiKC
        uMR6fL+wJF6wd4z0y4oBBvTprrhaExlz3Q==
X-Google-Smtp-Source: AA0mqf4kJSeo40IL3/pFOlHlr7n6rNfbqSvH/IJ6ozIncIf4cRmsgcYdYIYElAyqOVdD4OnBqE+KfQ==
X-Received: by 2002:a05:6402:5:b0:459:cdb:92ad with SMTP id d5-20020a056402000500b004590cdb92admr46942426edu.77.1669980524122;
        Fri, 02 Dec 2022 03:28:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b004611c230bd0sm2850780edy.37.2022.12.02.03.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:28:43 -0800 (PST)
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
Subject: [PATCH v5 04/15] cmake: don't copy chainlint.pl to build directory
Date:   Fri,  2 Dec 2022 12:28:25 +0100
Message-Id: <patch-v5-04.15-e86245ffbab-20221202T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com> <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
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
2.39.0.rc1.981.gf846af54b4b

