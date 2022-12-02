Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC45C47088
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiLBLaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiLBL30 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:29:26 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C29D4ADB
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:28:59 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id o13so10901781ejm.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1Psm3lDoog0dN99rejp3AlgVW2FEZFKeDr3zfKv4+Y=;
        b=TjmFGhF4ynmcub2H1kyU2JKAEzCj45Zducac+/s83tuCWYvsF++eFI2NeF2/9rBFsR
         FVPYQztjy1LIDkB0s+pbpdSjt2bA6vLeum/Or07r+kU2R1PG2kOHd3aNS7CwWSE4FGr/
         RMxjaWdLEym6KNNpVJPhIlSfn+aDKM7GunvcFqqxvg4b/b3RLxIwXRTDZ58vUV2khTWO
         adCyXdSNxuiNflr+ogmQu3SGoJH1jCF/zHQEczPs+WocfZt++gKoI+YdB04hPN/q9TVS
         tadVqu1laiqtoU0Z8Buhx+TRbvhIXdDy7nXLbwbFYX0GA6sviR6Yuek+seBXuNowSUIr
         qdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1Psm3lDoog0dN99rejp3AlgVW2FEZFKeDr3zfKv4+Y=;
        b=SXEP6EaOYbGhNhCHQbsxVRh25HNr0hECS8G1da0r7hvCaeAQn+sa4Hb2eStfIja2nh
         u12NAn9flgAnUtllwvXT3x0OVyDty4IhFvPrr57BxIyNbAYwXVY7NrtMFJxWUi5PyoYh
         HBAjDGkd/ipoB5KAjci3R+/mDRWIy8v6IkwVSErqw3kwaq0oT2h26KXWsldNeXTTbLRQ
         uhbMQkUjUkaXYmosfr7pv++DPwR/Azegv9zcxRKlAkwFw5nEt3h0K8YS8CYG/cJUOhS1
         qeoT/Eh/2m/3AmXguqRtaLMWuloFkKVJuiJFk15BWlRZFz6dEgnxDIuKSpimgFXYurG0
         GxtQ==
X-Gm-Message-State: ANoB5pnH9/1pOjNyhbrHRJnLuV6mRbC6MFqXHpNX+oDmuhxrahySLJFP
        QrVbnFeHrD2aEJozx5RJRZseu9rzWX/SUw==
X-Google-Smtp-Source: AA0mqf7o4OgjBmTk3aOP7TYl8CFkcAn09RoIVxpJujIu6I92SUVvQjv9ruAlom0vaI6z/XqkvMxQvQ==
X-Received: by 2002:a17:906:b28f:b0:7ad:a942:4d6b with SMTP id q15-20020a170906b28f00b007ada9424d6bmr58787896ejz.379.1669980537791;
        Fri, 02 Dec 2022 03:28:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b004611c230bd0sm2850780edy.37.2022.12.02.03.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:28:57 -0800 (PST)
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
Subject: [PATCH v5 15/15] CI: add a "linux-cmake-test" to run cmake & ctest on linux
Date:   Fri,  2 Dec 2022 12:28:36 +0100
Message-Id: <patch-v5-15.15-a6f343b6221-20221202T110947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com> <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since [1] the "cmake" build method should work properly on Linux, but
as seen in preceding commits there were various bugs in it, which are
hopefully now all fixed.

To ensure that it doesn't break again let's add a "linux-cmake-ctest"
target to build and test "cmake" on Linux, in addition to that we'll
also run the tests with "ctest" instead of "make" or "prove", so we
can assert that testing with that method works..

This also stress tests running "cmake" (and "ctest") out of a build
directory that isn't the top-level. The "vs-build" job uses "cmake"
since [2], but clobbers the top-level "Makefile" and builds in the
top-level directory.

That was the reason for why we didn't spot that various tests still
required missing "mergetools/*" etc, which was fixed by using
"$GIT_SOURCE_DIR" in a preceding commit.

Since the "ci/lib.sh" already creates and exports a
GIT_TEST_OPTS="..." we'll pick that up in our CI, see the preceding
commit. Because we pass the "--verbose-log -x
--github-workflow-markup" in the GitHub CI as a result the interaction
with "handle_failed_tests" here works correctly. I.e. on failure we'll
have saved "t/test-results/*.{exit,out,markup}" files relevant to the
failing test(s).

1. f31b6244950 (Merge branch 'yw/cmake-updates', 2022-06-07)
2. 4c2c38e800f (ci: modification of main.yml to use cmake for vs-build
   job, 2020-06-26)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml |  3 +++
 ci/run-build-and-tests.sh  | 13 +++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 9afacfa0b33..3657ba66c5e 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -236,6 +236,9 @@ jobs:
             cc: gcc
             cc_package: gcc-8
             pool: ubuntu-20.04
+          - jobname: linux-cmake-ctest
+            cc: gcc
+            pool: ubuntu-latest
           - jobname: osx-clang
             cc: clang
             pool: macos-latest
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 8ebff425967..a3ae5ff3972 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -45,10 +45,19 @@ pedantic)
 	;;
 esac
 
-group Build make
+mc=
+if test "$jobname" = "linux-cmake-ctest"
+then
+	cb=contrib/buildsystems
+	group CMake cmake -S "$cb" -B "$cb/out"
+	mc="-C $cb/out"
+fi
+
+group Build make $mc
+
 if test -n "$run_tests"
 then
-	group "Run tests" make test ||
+	group "Run tests" make $mc test ||
 	handle_failed_tests
 fi
 check_unignored_build_artifacts
-- 
2.39.0.rc1.981.gf846af54b4b

