Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74514C4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJUJpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJUJo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:44:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0F75B114
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j7so4017779wrr.3
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8a07RweeAC4SY9M9CTA6fM/wGrBUzjtws6yKUa3toc=;
        b=KUE+BdAtTZLEUH75Nai1GLgfMkPmds/qaKCpjUcJvZEqrSEfCUhFZmVLpbKXyV+y/o
         8V/LB6ZMsmnNNcIWNiMqu2A0slvYOhJWXRYf00aJ67Y9tSIAAQsYQdhQPC9YYu1l2Ilc
         Upe1k7VJu1PA17x9aaGjgWKgdqodkS2WZvx+lk9R2zFMxz9YkDOyXd9XXftlpfNK0lgj
         KQ9U4e4hSSxrnUDic2AXjmWUKRhoHRcqVmQRgzKOSV7VmD+JOkvflojmFQjYOtpuUPqa
         AKmvRr1IU0/GzgE5dnaALEt7bZAESYsNQDOTRed2BWnUf/o11POBghw3VEmw2X1MqtrD
         L4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8a07RweeAC4SY9M9CTA6fM/wGrBUzjtws6yKUa3toc=;
        b=c34rkDFVoHc7woSvCh17DHrTvGVio5080cdCLiSo8YuT/YDnnIGbpkYDxyD1+1fxoU
         RRgi+q0OqQ/pJsAhGvl4CkaKFE4rMER/0ugOItvgnDXiTL02VmV9VIyTF2Zp9XfoLt0N
         jOXrPCTW38gWcV3wRBqe+fjaH/G8NsKo3FQ61TviEiDfm83U/qYHx77NRp3KiwZSAeUB
         9pUnuSBgxlpztg+P/5fFTTkj24Gf6k5tMic0xCvlXdnX+QM4o3VsdoYlj6fyLmQUQ+iS
         Un85rENdJQ3Qgyk7OlvB9rYsAs3seQCk1ouS2ZwRex+wx/a9gjggG+vYr+zffq5b8Ejn
         +rtw==
X-Gm-Message-State: ACrzQf3KwIj2TDYqyKAaLyx+5rB+HFiOLKD/L7HhfX+J18qNJk/BYW9g
        CUtV+HErujDJuyG7Y/zCjqVT6NbUiLyoWQ==
X-Google-Smtp-Source: AMsMyM5DzttYKCM2gXfEQ3LZ9w3tAzZQuGghHUIsREp1N1dUnRD6FJqwRiWffWA0M8hcoPA91bY2kQ==
X-Received: by 2002:adf:fac5:0:b0:235:af88:d8db with SMTP id a5-20020adffac5000000b00235af88d8dbmr5363310wrs.700.1666345490113;
        Fri, 21 Oct 2022 02:44:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u6-20020adfeb46000000b002258235bda3sm18277768wrn.61.2022.10.21.02.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:44:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 6/9] cmake: use GIT_TEST_BUILD_DIR instead of editing hack
Date:   Fri, 21 Oct 2022 11:44:19 +0200
Message-Id: <patch-6.9-45f1a4e6f93-20221021T091013Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1205.gcea0601d673
In-Reply-To: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cmake builds git in "contrib/buildsystems/out" it will create a
"t/" directory there containing only the "t/helper/test-tool", but for
running the tests with "cmake" it cd's to the "real" t/ directory, and
runs the tests from there.

To get the test-lib.sh to locate "git" and other binaries in
"../contrib/buildsystems/out/" rather than "../" we have since [1]
been editing the "GIT_BUILD_DIR" assignment in test-lib.sh in-place.

This has meant that when testing cmake we've had to "git reset --hard"
before running "make" again.

What this build infrastructure really wanted was some feature like the
"GIT_TEST_BUILD_DIR" variable added in the preceding commit, so let's
make use of it.

Even though "ctest" will work with this approach, one advantage of the
previous arrangement was that we could:

	A. Build with cmake
	B. cd t
	C. Run a test

And have the test itself know to locate and use the cmake binaries,
this workflow was documented in [2]. The "t/test-lib".sh modification
here is so that we can support this use-case.

As [3] notes "contrib/buildsystems/out" isn't just the directory that
happens to be documented in "contrib/buildsystems/CMakeLists.txt", but
the one that VS will use when building git.

To make it clear what's happening we emit a "setup: " from the
test-lib.sh to note that we used this fallback method:

	$ ./t0001-init.sh
	setup: had no ../git, but found & used cmake built git in ../contrib/buildsystems/out/git
	ok 1 - plain
	[...]

Note: the "On Windows[...]" part of this is lifted from [4].

1. 7f5397a07c6 (cmake: support for testing git when building out of
   the source tree, 2020-06-26)
2. f2f1250c47f (cmake (Windows): recommend using Visual Studio's
   built-in CMake support, 2020-09-30)
3. 3eccc7b99d4 (cmake: ignore files generated by CMake as run in
   Visual Studio, 2020-09-25)
4. https://lore.kernel.org/git/5b0c2a150e9fce1ca0284d65628b42ed5a7aad9a.1666090745.git.gitgitgadget@gmail.com/

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 15 +--------------
 t/test-lib.sh                       | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 725b3f2ac82..91b7009f4fd 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1080,25 +1080,12 @@ if(USE_VCPKG)
 	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 endif()
 
-#Make the tests work when building out of the source tree
-get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
-if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
-	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/CMakeCache.txt)
-	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_RELATIVE})
-	#Setting the build directory in test-lib.sh before running tests
-	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
-		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL REGEX \"GIT_BUILD_DIR=(.*)\")\n"
-		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSUME)\n"
-		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
-		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
-endif()
-
 file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
 
 #test
 foreach(tsh ${test_scipts})
 	add_test(NAME ${tsh}
-		COMMAND ${SH_EXE} ${tsh}
+		COMMAND env GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR} ${SH_EXE} ${tsh}
 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
 endforeach()
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 41b1ddc96ff..284b619708a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -47,9 +47,21 @@ fi
 # its build directory.
 GIT_SOURCE_DIR="${TEST_DIRECTORY%/t}"
 GIT_BUILD_DIR="$GIT_SOURCE_DIR"
+GIT_AUTO_CONTRIB_BUILDSYSTEMS_OUT=
 if test -n "$GIT_TEST_BUILD_DIR"
 then
 	GIT_BUILD_DIR="$GIT_TEST_BUILD_DIR"
+elif ! test -x "$GIT_BUILD_DIR/git" &&
+     test -x "$GIT_BUILD_DIR/contrib/buildsystems/out/git"
+then
+	GIT_BUILD_DIR="$GIT_SOURCE_DIR/contrib/buildsystems/out"
+	GIT_AUTO_CONTRIB_BUILDSYSTEMS_OUT=t
+	# On Windows, we must convert Windows paths lest they contain a colon
+	case "$(uname -s)" in
+	*MINGW*)
+		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
+		;;
+	esac
 fi
 
 if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
@@ -1630,6 +1642,13 @@ remove_trash_directory "$TRASH_DIRECTORY" || {
 	BAIL_OUT 'cannot prepare test area'
 }
 
+# Emitting this now because earlier we didn't have "say", but not in
+# anything using lib-subtest.sh
+if test -n "$GIT_AUTO_CONTRIB_BUILDSYSTEMS_OUT" && test -t 1
+then
+	say "setup: had no ../git, but found & used cmake built git in ../contrib/buildsystems/out/git"
+fi
+
 remove_trash=t
 if test -z "$TEST_NO_CREATE_REPO"
 then
-- 
2.38.0.1205.gcea0601d673

