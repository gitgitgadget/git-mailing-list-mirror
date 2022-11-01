Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE22C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiKAWwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiKAWwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:52:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDD91FFAE
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:51:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 21so23915495edv.3
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVK5DBBDv1ozhx7OkD25A3x9cF2zX4fxWr48jUP/8dM=;
        b=JYvFlK5VKjBYM5ohF1+JpzLIlYP/kCgCFNzlbQi+UdEPNSaKGQ8QkfB50wVaaBbSWI
         iLDQbHnoHH0nxNQS8iMqRP6ocTAcvWNFWa3g5tuBG3aD0u4e8aKAaL3upWeJi0wHsKPs
         kaYWuF9pZOYfJyOe/iWV4iDpCFZR/kmtP8zbj8wa/Wpz3reI66s9hOo7cY87rWCXdr8y
         gnT2gjs6+6x3iVcaNxlWvk4kJ3Uo/jTUPVGPm27qK6hqSRhoZJzFCiLPpMZrqBKUo1/b
         i4l9E2XMJxd790/olE/oRSzcbICh5o2FsF9YheT4eXjt4UWDCaQLww+nWvp8UlSt5S65
         9jDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVK5DBBDv1ozhx7OkD25A3x9cF2zX4fxWr48jUP/8dM=;
        b=G0zAcgYZGibZKc8mwVFh4vBDojLT6f3T+KWKOwRgroeCRh3Psupce5VhcuQFzxp4GX
         oIs/L63mg8tyGkQm5WF+pACA6vm5hnDzP3zxUDUj11ZwS0rU9E58sOHwTPloU1wm3e4t
         yARW7gVXLBA575yR9Xmrro1Ze8XImqe7+G1WqWILr/wn95Rj8hf1vFVFFgfhbTjlD882
         i2C41aw0uETMyIr/4cis4QrTkWjjUYDCp1cMDzoF0MN7NK5mzLC2+U8EnGCVPALpdzaC
         samljOEyVzlBZU3ak47YAxQUAUzjLMOSVtf/nh3WizFDGptk7yT0RpRojo1HSuuDVzvd
         Oxzw==
X-Gm-Message-State: ACrzQf0hpk4lgAxKbs/SSdTqjXCsNocxCGB3AqArzxyVR4FmlFs6IjQ3
        BgNhNveIUgr0vipiiLpmyQMHQTjyj2podA==
X-Google-Smtp-Source: AMsMyM4GKZgWvCzjDbFtEPaytjVolHYEjk/4SmdhLUaxaC4rYGsTqt4yjyXFswWkXp4oAOVFBQni8w==
X-Received: by 2002:aa7:c859:0:b0:463:4b54:16a8 with SMTP id g25-20020aa7c859000000b004634b5416a8mr14413586edt.136.1667343117517;
        Tue, 01 Nov 2022 15:51:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7d6d4000000b004580862ffdbsm5012689edr.59.2022.11.01.15.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:51:56 -0700 (PDT)
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
Subject: [PATCH v3 09/12] cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
Date:   Tue,  1 Nov 2022 23:51:33 +0100
Message-Id: <patch-v3-09.12-8a660a2baa4-20221101T225022Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
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
index f0de37b35a1..6a3240d4ffa 100644
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
2.38.0.1280.g8136eb6fab2

