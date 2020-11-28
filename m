Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799F1C83019
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE3421D40
	for <git@archiver.kernel.org>; Sat, 28 Nov 2020 22:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpcgRBTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389093AbgK1Vtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733039AbgK1TFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Nov 2020 14:05:09 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C78C094242
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 22:44:43 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id i2so7734063wrs.4
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 22:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eeBNxfU5jIL7EMpNWaf1fxb4+qyUPE6QFDCAw+D28eM=;
        b=GpcgRBTKJlCqr3sT7TwkMXCyY0eOfn+fH3rUAEdbd+nTGEPmOh4OjHA3Y7ukfwoI+2
         HnI9rAPlzzvV4rdtYUMknQ+8h2NjdoK3H+qMJGdVmWU2R8/PDL8GJLSV5dF9Ue4CV/qY
         p5eMr1cGhhobhetDym+WSGtGWn95okCs8oEUKQchqiX9U+9jM5D21qMR7swuXr/fpdu/
         YW4aDiSVYpIIswZCZ61f1pW7LYzAe729h8xup+D06MGzMwOuCdfsEEEDyMQ59CCYfhkv
         neb9MqRidzy6nABUcnGcCG+UM0ddCgxxNfpgxZwrerXo/hywjIHHkPmvk68E9lEstU8r
         Q4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eeBNxfU5jIL7EMpNWaf1fxb4+qyUPE6QFDCAw+D28eM=;
        b=ISqYVHXUscm0m+lOz8T4h8EVwqVGBfl8hvKUh/91kg4GePR6YiXwMqYkY5hkMu6kaq
         FLbhVUnC8ahWZMKobvuyo3sFx6z6duN1ufwpH87yVTR83YOMnHAWsyhWY0F+qP0B8Eld
         PbWyQcQzdC6VsiRyv0/iXMshf8zyOfAEbOxKBcjQSdaRcZFCB/G0KjC7CNKEOC1zavHB
         iZUZMuP48e68Y1ZIHmihOiT9dpbUIUQj7puDXbB+9giKbCOXrX3tSuN7jCheIo6TKhux
         bPOU1GfiatoBjjVwK84w3ThagrWRPtvi5wXumI+ZrEJ3eSXwiYA+cKbk0833cQpO4PP/
         LDWQ==
X-Gm-Message-State: AOAM530Ld2HtfbbzcQga1E5JrfgmA9EbYxwpVNKKe9keUY25DWRHL0bw
        sPAvQVwb7J31UgTh+H3nfZr42zrziZQ=
X-Google-Smtp-Source: ABdhPJx0Bz0USgWsvIgwbES94MUV6ilNhuZCZZe1j1cPG2CysitUfG1JfNfeuRRhNyvPCq0aZppc7w==
X-Received: by 2002:adf:a39e:: with SMTP id l30mr15176128wrb.195.1606545881685;
        Fri, 27 Nov 2020 22:44:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm18891348wro.90.2020.11.27.22.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 22:44:41 -0800 (PST)
Message-Id: <94719a3462ce77e490188b5b96211aec7d67dada.1606545878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.801.git.1606545878.gitgitgadget@gmail.com>
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Nov 2020 06:44:34 +0000
Subject: [PATCH 2/6] fixup! reftable: utility functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Let's not forget our CMake configuration.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index df539a44fa..f3a2fd3561 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -591,6 +591,12 @@ parse_makefile_for_sources(libxdiff_SOURCES "XDIFF_OBJS")
 list(TRANSFORM libxdiff_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(xdiff STATIC ${libxdiff_SOURCES})
 
+#reftable
+parse_makefile_for_sources(reftable_SOURCES "REFTABLE_OBJS")
+
+list(TRANSFORM reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
+add_library(reftable STATIC ${reftable_SOURCES})
+
 if(WIN32)
 	if(NOT MSVC)#use windres when compiling with gcc and clang
 		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
@@ -613,7 +619,7 @@ endif()
 #link all required libraries to common-main
 add_library(common-main OBJECT ${CMAKE_SOURCE_DIR}/common-main.c)
 
-target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES})
+target_link_libraries(common-main libgit xdiff reftable ${ZLIB_LIBRARIES})
 if(Intl_FOUND)
 	target_link_libraries(common-main ${Intl_LIBRARIES})
 endif()
@@ -848,11 +854,15 @@ if(BUILD_TESTING)
 add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
 target_link_libraries(test-fake-ssh common-main)
 
+#reftable-tests
+parse_makefile_for_sources(test-reftable_SOURCES "REFTABLE_TEST_OBJS")
+list(TRANSFORM test-reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
+
 #test-tool
 parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
 
 list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/t/helper/")
-add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES})
+add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES} ${test-reftable_SOURCES})
 target_link_libraries(test-tool common-main)
 
 set_target_properties(test-fake-ssh test-tool
-- 
gitgitgadget

