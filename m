Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5102C433FE
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 03:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiJ0D24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 23:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiJ0D1v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 23:27:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56BA14DF0B
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so3134684wme.5
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 20:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X63LWQc5c1PVG18jZVFHMRPSEwMB3FxiDwMCYw/WQ9o=;
        b=KVcgQKF6Ga2ZOZv1Tgv4VngZiFwgfhh71wjVhpMtdtbT+1XQWf6jNZ9+H0OtLB2dNC
         UiI7bw8AE9kdpn5bl8HaiohkCnhQCr3aRzrgiBaNPrTNKirbkKHfz8JQmfLhKwxZ4cGK
         KNSvgKxMTlKib+vo6JmRrXOFu4YTNRkV4slPu3yp0+vBC7AHwfcBgdZ6qNEPRWrm0cZq
         yEk+DfjK11kZXI5siRkOvBD7mYZ0/8409KWI+cX7HxIkcoKEUA8VOH5pVN/mDMR17a+5
         jhtezHx2geTW2iNjPShhou+6sM49mGh+JgRrYuWQkGUVDpmfOYs54GFbn5N2R8OyzoTv
         WhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X63LWQc5c1PVG18jZVFHMRPSEwMB3FxiDwMCYw/WQ9o=;
        b=MRnriGQisU2CxLjCvWMtBH9f1FE+ED6/THpilZKj7ySavaIBB8Acow88pt/cJ+3kwP
         aQuGiKrFJRlopUCkubs4hAnHvLdZfPDtiiAzsBUagZrP+aQuMS4P0+UBZGI0Qq9WiQsg
         8PN2SiNzJNcnMyBYqxv+ktaXdIhEs6cSVFO4yneRN5fxUmPaza/DZru9TfKRWKT2CSGv
         1Vdo3xIy9ulTDJadQjgbe8ALCpfokqpSB+o097yynWbMSvAfIJLQ5XGTuP2Onr8h2nuO
         nKlqa1YOnuvlPFdFa/6OXzZbJIxg3nipxzSAl+QcB/76cNPGh/kwQ67Nxyr0VaB+Egqf
         WPBg==
X-Gm-Message-State: ACrzQf0hnUp10muTmMY0xMfMfD3Hz6w4EQA/p7i21GEuv3X7aTHkpJMA
        ArhXfQXQAku51b3CAWm59TxGsH0x/bvHPQ==
X-Google-Smtp-Source: AMsMyM4Qfs9cPyx1iCwVtvMZjPFRwlewzZWs+ByCBG66iVfxvIwQUuwSEOHmHkk9nNOY7YgcxVFBwA==
X-Received: by 2002:a05:600c:3542:b0:3c6:e509:b051 with SMTP id i2-20020a05600c354200b003c6e509b051mr4130439wmq.142.1666841230891;
        Wed, 26 Oct 2022 20:27:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hn2-20020a05600ca38200b003c6d0f8c377sm236828wmb.7.2022.10.26.20.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 20:27:09 -0700 (PDT)
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
Subject: [PATCH v2 11/11] CI: add a "linux-cmake-test" to run cmake & ctest on linux
Date:   Thu, 27 Oct 2022 05:26:52 +0200
Message-Id: <patch-v2-11.11-158a41ca7a4-20221027T032622Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1250.ge066ede4da3
In-Reply-To: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com>
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
index 831f4df56c5..f15c77c1ed1 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -238,6 +238,9 @@ jobs:
             os: ubuntu
             cc_package: gcc-8
             pool: ubuntu-latest
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
2.38.0.1250.ge066ede4da3

