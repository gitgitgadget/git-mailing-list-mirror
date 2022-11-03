Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9147C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiKCQnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiKCQkk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF721CFFB
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:38:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v17so3902042edc.8
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjgA2nekThCX86dwm1zp7HlT1jswPpiDzIpfqQaCO9k=;
        b=bDK9koq/WwIaAN3IQpR+qzFdxNHwaa9Ek9ZgLHGLLmnAhTWCCFblNY3bVQ5Zi3aR2/
         1yqsa0sPBqDm3w/VcQUT9U8jc7KOuxJex6FrhJhHj7fQ8IZSZhkc/V5vAWwww7UDJpmq
         nHO1JbfbhZ/lyU45kj/LdILwF63VKis/BXtVj3+RWF10O76WprPtHZVrRt1S0Znv81mr
         2pKiNAvP1imJL8sod6bvgAZJrqricvje3AQWk+hg5xm+/K8nBFoGAXeQr0Hg1SHaFz8i
         LXN2m0HrV8HhuUvGeu3Yk+U4PUs3v4C2s1qBpdiY/L7rC4FGASDVqvgvLmyLynnh2MOn
         xJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjgA2nekThCX86dwm1zp7HlT1jswPpiDzIpfqQaCO9k=;
        b=WFVqKtqJ7/Vr0OyCrGkYE1DwheZwfG6Soh1KyYFs5EbBcyLGZIdXutqg2gQ0l847V1
         oyyRRtoW7nDBLmERXyqpNwJEPO0R3tUqmgHasWZJOFzNIW4mMOqHJG4G3QdkW3JvLYrP
         VBvTnSxC4dMgASD314O4k8RrmECS8Xcds+tWXA5l27PbqIzlf9eJNhvxwYMekb1xBjs/
         8Q3+v86zaWNcAjDhsP+vXzJYoFRMYypbMxYd93+pAXEIdzzvLrB1/mnqABjfmThhWddQ
         DGkn7KleUgUrfMkRfMTZZJBOIdlExOa4tnhXU2fvKqsd3LKC3GqG0nBXQFYiiX95x/Tc
         ukfw==
X-Gm-Message-State: ACrzQf0uM8gITiN+Bm/7G7eIzvQAAU/z801lmiAgv3m4Bmm7o1K/OBQk
        BJ1ykjU+pmjyPKQhpU5kFWD7NEwzR0s+Vg==
X-Google-Smtp-Source: AMsMyM5AUacTbd4hhwJSE/g6orN1EqoCbVqOfvEfIVd2t6zxhu3evo/7otbQdAOFFSLMJge4sNbKTg==
X-Received: by 2002:aa7:d9d1:0:b0:461:9556:23e6 with SMTP id v17-20020aa7d9d1000000b00461955623e6mr32331473eds.25.1667493495600;
        Thu, 03 Nov 2022 09:38:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078d38cda2b1sm666188ejc.202.2022.11.03.09.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:38:14 -0700 (PDT)
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
Subject: [PATCH v4 09/14] Makefile + cmake: use environment, not GIT-BUILD-DIR
Date:   Thu,  3 Nov 2022 17:37:59 +0100
Message-Id: <patch-v4-09.14-6187ded42db-20221103T160255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com> <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the method used to have building with "cmake" followed by
running the tests manually work without creating inter-dependency issues with the Makefile.

Per ee9e66e4e76 (cmake: avoid editing t/test-lib.sh, 2022-10-18) and
the surrounding discussion the goal of that change was to have
building with cmake and:

	(cd t && ./t0001-init.sh)

Work, to do so we need some way to make the test-lib.sh aware that we
have a build in contrib/buildsystems/out. The downside of doing it via
the GIT-BUILD-DIR facility in ee9e66e4e76 is:

- A "remove this file while at it" only fits into the Makefile
  dependency graph if we "FORCE" a shell command to be run, so doing it
  this way precludes speeding up the Makefile by e.g. making use of the
  "$(file)" function (for which I've got follow-up patches).

- If you build with make, then with cmake, and then e.g.:

	make -C t prove

  We'll run the tests against the cmake version of the tests, not the
  "make" built ones. It's important to get any subtle interaction
  between two conflicting build systems right.

Now we'll instead:

- Check if the top-level "git" exists, if not we'll look in
  "contrib/buildsystems/out/git", and when running interactively inform
  the user about the fallback being picked.

	$ ./t0001-init.sh
	setup: had no ../git, but found & used cmake built git in ../contrib/buildsystems/out/git
	ok 1 - plain
	[...]

- This also makes things more obvious on the cmake side, because we'll
  now use an environment variable to select the test environment, which
  ctest it notes in its verbose output, e.g.:

	[...]
	2: Test command: /bin/sh "/home/avar/g/git/contrib/buildsystems/../../t/t0001-init.sh" "--no-bin-wrappers" "--no-chain-lint" "-vx"
	2: Working Directory: /home/avar/g/git/contrib/buildsystems/../../t
	2: Environment variables:
	2:  GIT_TEST_BUILD_DIR=/home/avar/g/git/contrib/buildsystems/out
	[...]

   See [1] for the relevant cmake language references.

- We don't support an arbitrary build directory outside of
  "contrib/buildsystems/out". This is OK because the reason for doing
  this part is to support the workflow documented in [2].

  As [3] notes "contrib/buildsystems/out" isn't just the directory that
  happens to be documented in "contrib/buildsystems/CMakeLists.txt", but
  the one that VS will use when building git.

1. https://cmake.org/cmake/help/latest/command/set_property.html
   https://cmake.org/cmake/help/latest/manual/cmake-properties.7.html#test-properties
   https://cmake.org/cmake/help/latest/manual/cmake-language.7.html#cmake-language-lists
1. f2f1250c47f (cmake (Windows): recommend using Visual Studio's
   built-in CMake support, 2020-09-30)
2. 3eccc7b99d4 (cmake: ignore files generated by CMake as run in
   Visual Studio, 2020-09-25)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore                          |  1 -
 Makefile                            |  1 -
 contrib/buildsystems/CMakeLists.txt | 10 ++--------
 t/test-lib.sh                       | 16 ++++++++++++++--
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/.gitignore b/.gitignore
index cb0231fb401..62720c6135d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,4 @@
 /fuzz_corpora
-/GIT-BUILD-DIR
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
 /GIT-LDFLAGS
diff --git a/Makefile b/Makefile
index 4927379184c..36802fe45eb 100644
--- a/Makefile
+++ b/Makefile
@@ -3045,7 +3045,6 @@ else
 	@echo RUNTIME_PREFIX=\'false\' >>$@+
 endif
 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
-	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
 
 ### Detect Python interpreter path changes
 ifndef NO_PYTHON
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 5c51840887e..b9759be4f72 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1117,14 +1117,6 @@ if(USE_VCPKG)
 	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 endif()
 
-#Make the tests work when building out of the source tree
-get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
-if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
-	#Setting the build directory in test-lib.sh before running tests
-	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
-		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
-endif()
-
 file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
 
 #test
@@ -1132,6 +1124,8 @@ foreach(tsh ${test_scipts})
 	add_test(NAME ${tsh}
 		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
+	set_property(TEST ${tsh} APPEND PROPERTY ENVIRONMENT
+		GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR})
 endforeach()
 
 # This test script takes an extremely long time and is known to time out even
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 388774a0aa0..ce319c9963e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -51,12 +51,17 @@ fi
 # For CMake the top-level source directory is different from our build
 # directory. With the top-level Makefile they're the same.
 GIT_SOURCE_DIR="$GIT_BUILD_DIR"
+
+GIT_AUTO_CONTRIB_BUILDSYSTEMS_OUT=
 if test -n "$GIT_TEST_BUILD_DIR"
 then
 	GIT_BUILD_DIR="$GIT_TEST_BUILD_DIR"
-elif test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
+elif ! test -x "$GIT_BUILD_DIR/git" &&
+     test -x "$GIT_BUILD_DIR/contrib/buildsystems/out/git"
 then
-	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
+	GIT_BUILD_DIR="$GIT_SOURCE_DIR/contrib/buildsystems/out"
+	GIT_AUTO_CONTRIB_BUILDSYSTEMS_OUT=t
+
 	# On Windows, we must convert Windows paths lest they contain a colon
 	case "$(uname -s)" in
 	*MINGW*)
@@ -1637,6 +1642,13 @@ remove_trash_directory "$TRASH_DIRECTORY" || {
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
2.38.0.1451.g86b35f4140a

