Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173BAC4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiKCQnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiKCQkk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5A21CFFC
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:38:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f5so6818164ejc.5
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiFs/z4Z7wyI5gt4mCxTJ6XDUNqyjEmZLGsHGSWN1ac=;
        b=RkV1Ob/mGuW+3pg5NYd0lb9aQkFi4e15jLZmKvCNK+/jsSzA6db7ik12tm8hHUSy3A
         /g8nZki+8D7zTPr6XwKzvcdRscWtEh6Jxj1wCZsjEpVyNdVsN7GiW5LWUt3VJ3IO/TnH
         gYEyz0xEuLudwbHhK7CizZQj6H9YkQy7ObTKuCjo0xMJo4mODOlazsj+o7gjChFWuL6x
         /J93GBy8vMAuhRzM3NptKjvlhxuwUfnqHv8sgrMvC//o0e48htdQFM6ss5Oc3n4k2n0m
         Y9JyTlFOS/5BSF32vIioS2RD4CYJsv6usGkHWk+6P69Ys9E43rh1zuRWxwCo51bAym3F
         tvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiFs/z4Z7wyI5gt4mCxTJ6XDUNqyjEmZLGsHGSWN1ac=;
        b=5Klvty6xJv7YrrrvW5lIeHswMGHOeA9rRe8DKXJZn71NGFjScXznCaYHIqqOc5/S9I
         Yf7iHlLdTmghvjzP9gqRIyoMykNaaD4qX1TWWM5QumwdrffjLh72LkEyLiLx9ivd0z7u
         NiXxohyjn7SmnIL2mucVOzvFJjYPbOqC4P88wHeAY5+9dOOY1SQKbobRRZYjjWw1fUaa
         1l28MpuUd07AUf75MspGnQfcs9jjjmIKptiQ97EsOhc/oG7ZUDtocqmSV1ic7eqAq/WB
         ftrkFJqYswcQgwXIwn1F3RHMw+A7+zfuhsFhnT3ZS3hUBTex7qXzE986UY8QFiRe7WVQ
         RRjQ==
X-Gm-Message-State: ACrzQf2II9x6+Ot4AqN5B83QRPeGm4zVnMN5GDGNcp5yHVS5QoE4oAHk
        pnJHRNffxPVxC+dmzO+jtJ2JvsGAQuMiQg==
X-Google-Smtp-Source: AMsMyM4Z7CQNIucKL9XsuiXaGcZ3Zj3YQNO9AYh+s0Mof1ySfDOSOeiLGIhqpRxeLUdQqO1yVBKHZA==
X-Received: by 2002:a17:906:5dae:b0:78e:3109:36d1 with SMTP id n14-20020a1709065dae00b0078e310936d1mr30291890ejv.470.1667493496583;
        Thu, 03 Nov 2022 09:38:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078d38cda2b1sm666188ejc.202.2022.11.03.09.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:38:15 -0700 (PDT)
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
Subject: [PATCH v4 10/14] cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
Date:   Thu,  3 Nov 2022 17:38:00 +0100
Message-Id: <patch-v4-10.14-3ea4a61698e-20221103T160255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com> <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
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
index b9759be4f72..4a832404da6 100644
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
 
@@ -1119,10 +1150,25 @@ endif()
 
 file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
 
+if(DEFINED ENV{GIT_TEST_OPTS})
+	set(GIT_TEST_OPTS "$ENV{GIT_TEST_OPTS}"
+		CACHE STRING "test options, see t/README")
+	message(STATUS "Using user-selected test options: ${GIT_TEST_OPTS}")
+elseif(WIN32)
+	set(GIT_TEST_OPTS "--no-bin-wrappers --no-chain-lint -vx"
+		CACHE STRING "test options, see t/README")
+	message(STATUS "Using Windowns-specific default test options: ${GIT_TEST_OPTS}")
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
 	set_property(TEST ${tsh} APPEND PROPERTY ENVIRONMENT
 		GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR})
-- 
2.38.0.1451.g86b35f4140a

