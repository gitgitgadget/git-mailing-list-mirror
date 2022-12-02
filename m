Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15451C4167B
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiLBL3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbiLBL3D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:29:03 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9939DD427D
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:28:53 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id b2so10862024eja.7
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klqt4pFTvtsab84HkdF3r4z1w00T//BupVriqNyqGb4=;
        b=hDRUAdDEfTQwxX1nHGc1AawvlqwzsuiHiNuc6+97TCDEQJh01CdMR1pwl920DfzoYG
         T9IFowOy+TyVIeHhDFJljMSHA3WaKri6aerb9hxfl2u1TnAzYv180G5Bgbyl+fKCtuKD
         2fw74NenyjVb0z2m0Sjur4Qq8dpI64hm4X4J7Icyf5Zwn4SHJeiTziXy0ddlICUAEOBQ
         tVbbcAN7YnEbWYHPXy8S+j+QQr3MeChtRJ4Ho5QIp2y/v5XnQ8DC762KiA3L4689dgpn
         SylIQ1Ia2zU2cXtSI9cfF75xc3DT/5y/nBd/oq8Tr3Mb4YC4s64W+UWxpwsLdtLA3fb7
         msKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klqt4pFTvtsab84HkdF3r4z1w00T//BupVriqNyqGb4=;
        b=pnkf6wgYHIZ6vg4EXz8agz2YGq5LjR8QubnwOWMrGvYzdoEq3dBzuqvCUeUrYlGfWM
         /OgKydCHWQZuegBzzdx31ffEVUIr/wKDERIbrg3FL/iwVk8eidqrI9SFdLT2pm3TKP3p
         9yIm1nTOBs600N0zKtGm9Go7fXE8VfFrblDLEYKKxBQ+16NXDaVcgUTWR3BP/Xs9rTMT
         kJVxTQTElF7MD2jWOoY/loZ4PM3ztx6yFAmxaw49nmqXIg8nqr+gPIknzn8TWO2bk6jL
         MCY+CaH09/LAhBMJuK6swqAWV8aVAhQDADBbuVnn4Mqo7p/vRnM0rv0InTHtgiD0eyfa
         ppOA==
X-Gm-Message-State: ANoB5pn7FLUVHzNZ9vEQ08gyblHF4m1DotGwaEMW/fchsehFz38hU4MG
        D/JERJbQ/AB/huAxfoSs34lZJljJ4xUaMw==
X-Google-Smtp-Source: AA0mqf7U5/7uSbRkxxHpEqAVMrqENTQnbHZpvGigzsN8IT+uW9KYH23+bh41tKnzaT/PQ7m4zxYFbA==
X-Received: by 2002:a17:906:d295:b0:7c0:aff1:f1b6 with SMTP id ay21-20020a170906d29500b007c0aff1f1b6mr5942069ejb.418.1669980531634;
        Fri, 02 Dec 2022 03:28:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b004611c230bd0sm2850780edy.37.2022.12.02.03.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:28:50 -0800 (PST)
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
Subject: [PATCH v5 10/15] cmake: optionally be able to run tests before "ctest"
Date:   Fri,  2 Dec 2022 12:28:31 +0100
Message-Id: <patch-v5-10.15-529e18f7f72-20221202T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com> <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since [1] the "cmake" build has had support for running the tests
manually from the "t/" directory once we've built with "cmake", but
only after a one-off run of "ctest".

I.e. we create the build recipe via "cmake" and build with
e.g. "make", but after doing so would get:

	$ (cd t && ./t0071-sort.sh)
	error: GIT-BUILD-OPTIONS missing (has Git been built?).

The recently added amendment to this of using a "GIT-BUILD-DIR"[2]
didn't change these semantics. After we did a one-off run of "ctest"
we'd be able to run the tests without "ctest":

	$ ctest --test-dir contrib/buildsystems/out -R t0071
	[...]
	100% tests passed, 0 tests failed out of 1
	[...]
	$ (cd t && ./t0071-sort.sh)
	ok 1 - DEFINE_LIST_SORT_DEBUG
	# passed all 1 test(s)
	1..1

This change optionally closes that gap, and allows for more sensible
behavior. Due to concerns about existing MS Visual Studio users
relying on some of these edge cases this is being made optional, with
the default of the new "GIT_CTEST_SETS_BUILD_DIR" being "ON" on
Windows (i.e. the old behavior), and "OFF" elsewhere.

The resulting behavior differences are the following:

	|---+----+-----|
	|   | ON | OFF |
	|---+----+-----|
	| A | N  | Y   |
	| B | N  | Y   |
	| C | Y  | Y   |
	| D | Y  | N   |
	| E | N  | Y   |
	|---+----+-----|
	A. Can manually run tests before ctest?
	B. Manually run tests point to latest cmake build?...
	C. Manually run tests point to latest "ctest"'d build?
        D. "git" picked at ctest start time?
        E. "git" picked at test start time?

On "D" and "E": Because GIT_CTEST_SETS_BUILD_DIR=ON relies on the
global "GIT-BUILD-DIR" when using "ctest" it cannot be used to run
concurrent tests for two different builds from the same source
directory.

But as noted in [3] existing users using Visual Studio may be relying
on some of these edge cases, so let's make this optional on Windows,
but switch the default to this new discover method on other platforms.

1. 7f5397a07c6 (cmake: support for testing git when building out of
   the source tree, 2020-06-26)
2. ee9e66e4e76 (cmake: avoid editing t/test-lib.sh, 2022-10-18)
3. https://lore.kernel.org/git/663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 38 ++++++++++++++++++++++++-----
 t/test-lib.sh                       |  3 ++-
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 5b3fb93120d..866bdc1914a 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1115,12 +1115,33 @@ if(USE_VCPKG)
 	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 endif()
 
-#Make the tests work when building out of the source tree
-get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
-if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
-	#Setting the build directory in test-lib.sh before running tests
-	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
-		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
+set(GIT_CTEST_SETS_BUILD_DIR_DOC "find cmake build dir via ctest-set GIT-BUILD-DIR?")
+if(DEFINED ENV{GIT_CTEST_SETS_BUILD_DIR})
+	set(GIT_CTEST_SETS_BUILD_DIR "$ENV{GIT_CTEST_SETS_BUILD_DIR}"
+		CACHE BOOL GIT_CTEST_SETS_BUILD_DIR_DOC)
+elseif(WIN32)
+	set(GIT_CTEST_SETS_BUILD_DIR "ON" CACHE BOOL GIT_CTEST_SETS_BUILD_DIR_DOC)
+else()
+	set(GIT_CTEST_SETS_BUILD_DIR "OFF" CACHE BOOL GIT_CTEST_SETS_BUILD_DIR_DOC)
+endif()
+if(GIT_CTEST_SETS_BUILD_DIR)
+	message(STATUS "Enabling manual runs of t/* tests once ctest writes CMAKE-BUILD-DIR")
+else()
+	message(STATUS "Enabling manual runs of t/* tests via cmake build dir discovery")
+endif()
+
+# When using GIT_CTEST_SETS_BUILD_DIR, running the tests from the "t/"
+# directory will only work once "ctest" has been run, as we write to
+# "GIT-BUILD-DIR" from the optional "ctest" invocation following the
+# "cmake"
+if(GIT_CTEST_SETS_BUILD_DIR)
+	get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
+	if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
+		file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
+			"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
+	endif()
+else()
+	file(WRITE "${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR" "${CMAKE_BINARY_DIR}")
 endif()
 
 file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
@@ -1130,6 +1151,11 @@ foreach(tsh ${test_scipts})
 	add_test(NAME ${tsh}
 		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
+if(NOT GIT_CTEST_SETS_BUILD_DIR)
+	set_property(TEST ${tsh} APPEND PROPERTY ENVIRONMENT
+		GIT_TEST_PREFER_BUILD_DIR_ENV="Yes, ignore GIT-BUILD-DIR"
+		GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR})
+endif()
 endforeach()
 
 # This test script takes an extremely long time and is known to time out even
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a1b5c7c6ce1..36a9a32db05 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -51,7 +51,8 @@ fi
 # For CMake the top-level source directory is different from our build
 # directory. With the top-level Makefile they're the same.
 GIT_SOURCE_DIR="$GIT_BUILD_DIR"
-if test ! -x "$GIT_BUILD_DIR/git" &&
+if test -z "$GIT_TEST_PREFER_BUILD_DIR_ENV" &&
+	test ! -x "$GIT_BUILD_DIR/git" &&
 	test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
 then
 	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
-- 
2.39.0.rc1.981.gf846af54b4b

