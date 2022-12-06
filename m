Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC68C47089
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiLFCKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiLFCJv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:09:51 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647FC24952
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:09:40 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so2751493ejb.13
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTSqo+LxeQPCVnjxi10OnM1T7dNPysU9WXkmP05tiR4=;
        b=KnHE5qv9oHqK32QNTkNWinHZSMNippFW9VPLRfCeL7xg8JdgcG7hbIzq1CAPbUelsw
         ZY2lCkqOy6tIHWqZiOlLDdKiiSAHezSzBuQoszx66FcCXcxGot/xOVncBQkD4m0AgFfd
         FVRsxRFrQ/9VFA3RcktFy9SXhXT12Tb+wT1cmKF1V/7f8i2cYakmi9qD0rZ5GstYUAGd
         lhv3dl+zJ4PuN03cgnEO8I9WMHH+57Nt3vIu9mlr9k5V+1GO73sAPA5xc/DvCae7lLer
         yQRpFb7GlGs7BxN3TMg3gnt0Z4ForO+vw1aJXo8Ifkms/jG+TUeqClB1I/Rf6M28vocw
         3CAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTSqo+LxeQPCVnjxi10OnM1T7dNPysU9WXkmP05tiR4=;
        b=aAAbqdHGu7NG+YYYLhK0vjJKhDmLNuvl0T9hxgueONh5cEfbcVxjisPa0GD1gUzCfC
         E5AcY4ZGS7stVV6p4qF0xaMKvI3yU3tP77u7U3SEndxJEutMXjim7v5t9upwt39FPA2c
         FBAvSvYl//znq/Uoiate3xpZ6dYvNq1iRKlZd8Jc38vpYbzxFp2meorjBPdaQ+qcjKR6
         LCWZr6a9o+YYD2QTRbE3jxSZOYI5zPgId/EClUGe+37UxoPW8T58uQEFQbXN0h+1MNH6
         qsaowEpPo5AHaMZkhPz4UeyJcP7k+3ZmfRqXuxGN8DEA4ipf3OIuIsArk61YnwdrppsD
         9Nsw==
X-Gm-Message-State: ANoB5plHfEac/Rxl1pva4M+8bWDMfAV8NeQ4x0mKjNBmCG1H3FpL6C45
        3BnRRYYS2WzsVaLRcf3WTv8tXBCSy16ANQ==
X-Google-Smtp-Source: AA0mqf55VPGRkQluxB0Yo/WzeHgdHoqryI85WKdnQwCtaaiD8lCLsw47jvh45DaTAhj7Z/0ZA9fALQ==
X-Received: by 2002:a17:907:7650:b0:781:e568:294f with SMTP id kj16-20020a170907765000b00781e568294fmr57989422ejc.447.1670292578571;
        Mon, 05 Dec 2022 18:09:38 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6966186ejm.178.2022.12.05.18.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:09:37 -0800 (PST)
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
Subject: [PATCH v6 11/15] cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
Date:   Tue,  6 Dec 2022 03:09:09 +0100
Message-Id: <patch-v6-11.15-e25992b16f1-20221206T001617Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.1006.gb4c675778ba
In-Reply-To: <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
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
the set(... CACHE <type> <docstring>) facility. As noted in cmake's
documentation[1] this integrates nicely with e.g. cmake-gui.

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

The "separate_arguments()" here will do the right thing for arguments
that don't contain whitespace, so e.g. the path to --root="" can't
have a space in it. There's supposedly a way to work around that with
separate_arguments(), but it requires features newer than our required
cmake version, so let's live with that edge case for now.

1. https://cmake.org/cmake/help/latest/command/set.html#set-cache-entry

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 50 +++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 385e4e9d772..034ab2c879a 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -32,7 +32,7 @@ To use this in Visual Studio:
 
 Open the worktree as a folder. Visual Studio 2019 and later will detect
 the CMake configuration automatically and set everything up for you,
-ready to build. You can then run the tests in `t/` via a regular Git Bash.
+ready to build. See "== Running the tests ==" below for running the tests.
 
 Note: Visual Studio also has the option of opening `CMakeLists.txt`
 directly; Using this option, Visual Studio will not find the source code,
@@ -76,6 +76,37 @@ empty(default) :
 
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
+	# "--test-dir" is new in cmake v3.20, so "(cd
+	# contrib/buildsystems/out && ctest ...)" on older versions.
+	ctest --test-dir contrib/buildsystems/out --jobs="$(nproc)"--output-on-failure
+
+Options can be passed by setting GIT_TEST_OPTIONS before invoking
+cmake. E.g. on a Linux system with systemd the tests can be sped up by
+using a ramdisk for the scratch files:
+
+	GIT_TEST_OPTS="--root=/dev/shm/$(id -u)/ctest" cmake -S contrib/buildsystems -B contrib/buildsystems/out
+	[...]
+	-- Using user-selected test options: --root=/dev/shm/<uid>/ctest
+
+Then running the tests with "ctest" (here with --jobs="$(nproc)"):
+
+	ctest --jobs=$(nproc) --test-dir contrib/buildsystems/out
 ]]
 cmake_minimum_required(VERSION 3.14)
 
@@ -1148,10 +1179,25 @@ endif()
 
 file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
 
+if(DEFINED ENV{GIT_TEST_OPTS})
+	set(GIT_TEST_OPTS "$ENV{GIT_TEST_OPTS}"
+		CACHE STRING "test options, see t/README")
+	message(STATUS "Using user-selected test options: ${GIT_TEST_OPTS}")
+elseif(WIN32)
+	set(GIT_TEST_OPTS "--no-bin-wrappers --no-chain-lint -vx"
+		CACHE STRING "test options, see t/README")
+	message(STATUS "Using Windows-specific default test options: ${GIT_TEST_OPTS}")
+else()
+	set(GIT_TEST_OPTS ""
+		CACHE STRING "test options, see t/README")
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
 if(NOT GIT_CTEST_SETS_BUILD_DIR)
 	set_property(TEST ${tsh} APPEND PROPERTY ENVIRONMENT
-- 
2.39.0.rc1.1006.gb4c675778ba

