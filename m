Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9197FA3741
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 03:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiJ0D2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 23:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiJ0D1c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 23:27:32 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180D5FBCD0
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bs21so83829wrb.4
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2iR4yz3ZdzMd5FYaqFH3QIi+apMWjRG1HiZsMwgQ68=;
        b=b+3GkP7eEbrBK+OuFuh+FfcqUybO98+2NVm0u1Ci1xNrDsjgdLKMJTjVdqh8acVIPn
         779kajH3RcFEoapL7WrFi9Qug7yDx7rJqyqtLeCsli/Sh1Uu5GZHrmdsvnIvVgAPtnpA
         NP9bMuQ4HKqkqyp+En2AHUcjfJJSMC2JYliaBI9vd8pjW/ucejuT/3bPZz46xI8FoKD0
         gNOFpHDUTR17FN4Cz20KZa6W11znoZN9fxxcEFxPSne6kLSTHLm6kBQSThn7QCDK+/iL
         4nlTtxV43bWnqSS51qN2ondq/tNgykvTt5qkAEqyVXoV8g1tlSEH/TD8qeuDlxD47s8q
         CjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2iR4yz3ZdzMd5FYaqFH3QIi+apMWjRG1HiZsMwgQ68=;
        b=62EGgilbr85P4v9dSaA0GWhiZvOYQMwfr0w8I6yQNN4jCXwUlrctb0sYsiDo528hFr
         3WoFTNEZ8rZln6YqoBEasfrLGiujGmSG3RSJyWfUmdY3LPkJQfXS8mbg1dZRlJdBq4mY
         mlS/V7XIwWHBnv39WZ8nlFhkY+SwT/ktShRP52639XiY3IwaqEDFsgNcZHSOqcOeMnK+
         O+EHXH1LQanEEsaRpYVyPsXpCFl+SUYlJeX9ozkGI9E4y/Ni9gzr+1xOoad5MkV29xgX
         N0GrW4IRzuT7d8UcJFG2H27LtXm0WG7de/Yz7FFkAHo6piIVjmuWX3brrDiDxbK6WNNO
         /jSQ==
X-Gm-Message-State: ACrzQf0zOSbzBiS6e5bNy2adiPOV8w+vnWK1kcq0me4K5q0vlRHk8zXp
        K26UraEQGyWDoFc4WT5gYkSUwd6sOXZd8A==
X-Google-Smtp-Source: AMsMyM4Alise7s4e4HkQI7ubLBCWlk4peN1Z0l3mSDwGnYWGZWgJO2/9fTsYfm/js8TFRqRkdEhBKQ==
X-Received: by 2002:a5d:4910:0:b0:235:ab9b:33a2 with SMTP id x16-20020a5d4910000000b00235ab9b33a2mr24897260wrq.58.1666841228540;
        Wed, 26 Oct 2022 20:27:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hn2-20020a05600ca38200b003c6d0f8c377sm236828wmb.7.2022.10.26.20.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 20:27:07 -0700 (PDT)
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
Subject: [PATCH v2 09/11] cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
Date:   Thu, 27 Oct 2022 05:26:50 +0200
Message-Id: <patch-v2-09.11-9f5276d79c9-20221027T032622Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1250.ge066ede4da3
In-Reply-To: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The rationale for adding "--no-bin-wrappers" and "--no-chain-lint" in
2ea1d8b5563 (cmake: make it easier to diagnose regressions in CTest
runs, 2022-10-18) was those options slowed down the tests considerably
on Windows.

But since f31b6244950 (Merge branch 'yw/cmake-updates', 2022-06-07)
and with the preceding commits cmake and ctest are not
Windows-specific anymore.

So let's set those same options by default on Windows, but do so with
the set() facility. As noted in cmake's documentation[1] this
integrates nicely with e.g. cmake-gui.

On *nix we don't set any custom options. The change in 2ea1d8b5563
didn't discuss why Windows should have divergent defaults with "cmake"
and "make", but such reasons presumably don't apply on *nix. I for one
am happy with the same defaults as the tests have when running via the
Makefile.

With the "message()" addition we'll emit this when running cmake:

	Generating hook-list.h
	-- Using user-selected test options: -vixd
	-- Configuring done
	-- Generating done
	-- Build files have been written to: /home/avar/g/git/contrib/buildsystems/out

Unfortunately cmake doesn't support a non-hacky way to pass variables
to ctest without re-running cmake itself, so when re-running tests via
cmake and wanting to change the test defaults we'll need:

	GIT_TEST_OPTS=-i cmake -S contrib/buildsystems -B contrib/buildsystems/out &&
	ctest --jobs=$(nproc) --test-dir contrib/buildsystems/out -R t0071 --verbose

1. https://cmake.org/cmake/help/latest/command/set.html#set-cache-entry

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 46 +++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 0bd4a36b2bf..35b12493cbc 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -49,7 +49,7 @@ To use this in Visual Studio:
 
 Open the worktree as a folder. Visual Studio 2019 and later will detect
 the CMake configuration automatically and set everything up for you,
-ready to build. You can then run the tests in `t/` via a regular Git Bash.
+ready to build. See "== Running the tests ==" below for running the tests.
 
 Note: Visual Studio also has the option of opening `CMakeLists.txt`
 directly; Using this option, Visual Studio will not find the source code,
@@ -74,6 +74,35 @@ empty(default) :
 
 NOTE: -DCMAKE_BUILD_TYPE is optional. For multi-config generators like Visual Studio
 this option is ignored
+
+== Running the tests ==
+
+Once we've built in "contrib/buildsystems/out" the tests can be run at
+the top-level (note: not the generated "contrib/buildsystems/out/t/"
+drectory). If no top-level build is found (as created with the
+Makefile) the t/test-lib.sh will discover the git in
+"contrib/buildsystems/out" on e.g.:
+
+	(cd t && ./t0001-init.sh)
+	setup: had no ../git, but found & used cmake built git in ../contrib/buildsystems/out/git
+	[...]
+
+The tests can also be run with ctest, e.g. after building with "cmake"
+and "make" or "msbuild" run, from the top-level e.g.:
+
+	ctest --test-dir contrib/buildsystems/out --jobs="$(nproc)"--output-on-failure
+
+Options can be passed by setting GIT_TEST_OPTIONS before invoking
+cmake. E.g. on a Linux system with systemd the tests can be sped up by
+using a ramdisk for the scratch files:
+
+	GIT_TEST_OPTS="--root=/run/user/$(id -u)/ctest" cmake -S contrib/buildsystems -B contrib/buildsystems/out
+	[...]
+	-- Using user-selected test options: --root=/run/user/1001/ctest
+
+Then running the tests with "ctest" (here with --jobs="$(nproc)"):
+
+	ctest --jobs=$(nproc) --test-dir contrib/buildsystems/out
 ]]
 cmake_minimum_required(VERSION 3.14)
 
@@ -1110,10 +1139,23 @@ endif()
 
 file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
 
+string(COMPARE NOTEQUAL "$ENV{GIT_TEST_OPTS}" "" HAVE_USER_GIT_TEST_OPTS)
+if(HAVE_USER_GIT_TEST_OPTS)
+	set(GIT_TEST_OPTS "$ENV{GIT_TEST_OPTS}")
+	message(STATUS "Using user-selected test options: ${GIT_TEST_OPTS}")
+elseif(WIN32)
+	set(GIT_TEST_OPTS "--no-bin-wrappers --no-chain-lint -vx")
+	message(STATUS "Using Windowns-specific default test options: ${GIT_TEST_OPTS}")
+else()
+	set(GIT_TEST_OPTS "")
+	message(STATUS "No custom test options selected, set e.g. GIT_TEST_OPTS=\"-vixd\"")
+endif()
+separate_arguments(GIT_TEST_OPTS)
+
 #test
 foreach(tsh ${test_scipts})
 	add_test(NAME ${tsh}
-		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
+		COMMAND ${SH_EXE} ${tsh} ${GIT_TEST_OPTS}
 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
        set_property(TEST ${tsh} APPEND PROPERTY ENVIRONMENT
 		    GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR})		
-- 
2.38.0.1250.ge066ede4da3

