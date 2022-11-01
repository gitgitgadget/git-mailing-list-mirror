Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1136BC4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiKAWv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiKAWvx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:51:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029121A20A
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:51:53 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id d26so40797315eje.10
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQSrY8WaDHJcl/mMaYriCNAqT3frrtPcfpu4U1DidN0=;
        b=AjsseNnjqTB/K9ChreV4uo7PO4lFhxDu8KxwvOBsjSoK3AlBVhtAnW1ACVu06rIkjL
         KIxjzaJ8A3M7+X9wmXF6kL7k1SI1kXLwODp9p8QMNsEN/pQy68q21vo85KeUG5GEd1ej
         vSnePxKvDPoHTTVJb4zEu1vV0Ez9yOsYb9pgoGWVGwugGzqc6vKw0vNKMSjXHz2uI0ia
         J4XEQTe99dQluFivn0spF/vmZrv9reftppW0EquG3c2JFQcGMktQ3IThM+dgtmg6Cel1
         wbsDAw2GySqEg2D06f51JZCO9ZxLPFnMjIsO7QHAkeTlBBfTth1F4+5wpqFNlSOrcaay
         YTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQSrY8WaDHJcl/mMaYriCNAqT3frrtPcfpu4U1DidN0=;
        b=6/IPXDuZIJy0w03RGuTLjiaccN3GDdTHC0LxieE8ivi+06ote6eBekgKOiutC+5eXl
         OAXlVQtV0hXrnEl0J1YOUNll+O7/3Em0vRVLOxAEmBcqQDgYjwe1idP5ymttxYbtxcua
         aabHL9VnooTpc5S3uZINdUHrmHu3xQ3QhoJB++WTwHj5jqSCmG6EfHOEh0x2S3p+jFLf
         edZXoMia3v9qHCsn7Q3wbbKBMoMJzvU6JD9la9I6HaYtmzzbi9tIEoMxrQ9pKG19hVvw
         mXMNjMvan75m4HyhvahdiSXb7SXl1h+2rPvdDvPz28JNfcLpCxWfFRsfIpSoEQnsdB0F
         HOPA==
X-Gm-Message-State: ACrzQf0aCKdH/xJ3ti5W/aNYAiz6heFHGZfI7Io6EGLVsE0/6SMg2yI5
        9RC9KtItfm7cmRRuMdE02UDwA2TC6xzicw==
X-Google-Smtp-Source: AMsMyM4XyQf+umOPqXuNMNMVNS7bpVjHBbO/q665Mt9Hac4tOLgRUxZoC4FdkZ2G/TnijLQ0wxAyog==
X-Received: by 2002:a17:906:6b90:b0:7ad:b6d3:3394 with SMTP id l16-20020a1709066b9000b007adb6d33394mr17641086ejr.497.1667343111302;
        Tue, 01 Nov 2022 15:51:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7d6d4000000b004580862ffdbsm5012689edr.59.2022.11.01.15.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:51:50 -0700 (PDT)
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
Subject: [PATCH v3 03/12] cmake: don't copy chainlint.pl to build directory
Date:   Tue,  1 Nov 2022 23:51:27 +0100
Message-Id: <patch-v3-03.12-3bfa873e792-20221101T225022Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
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
index 7bc123da315..dd46ad25fb7 100644
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
2.38.0.1280.g8136eb6fab2

