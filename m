Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26DBC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiJUJpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJUJo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:44:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAC13FF32
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:55 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n16-20020a05600c4f9000b003c17bf8ddecso3753675wmq.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQDigF109b8cAm4rjoF5g69waS8ol9dqqyjoTXbhZB0=;
        b=CqCG3mwd5RWOefO312iaQM1LHzxDo3Ta/PMpc70EwZyNv+FImfUQYQ15SYfLQsNORx
         onu19tc8vGoSdIH+cdoW8OylSg23QBtTbLOc3kT6C549pTnVFwS+D9dTq5uGvsffo9RE
         /wOBMFspM+oo1soJvhALrccgPyaw8ODWp3TCJhXALChrntJIISU+9zdejqqPNHTqmfD4
         P6YD9TDCdFQxXjoR3pIeWp8yuM/Z3tcL2g/MFw/F28lR1YHWnbWR4MiA7EAeQJlZ64ph
         IWH2ew6B8do/8nCz0KidDfoVkwX55PvDwoyu5aYW8zSYxMgjyA31W3zpaXOsOTnlGz2V
         C8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQDigF109b8cAm4rjoF5g69waS8ol9dqqyjoTXbhZB0=;
        b=PoqB/NuTad/0ytgMja0TFIcACEZQLX6khFzKlbIPB+PnlP+ylxdc7fKON2xFXDW3VL
         +6NRt3APK7crarwLFpXdiolkQzgrm1rUoN8Iy9hMHIV78PM2K61NPUk/Jo6B5NIbuuFi
         gG57Q8s52UsyWB4ojzhEFyBAFymy/K6MMvd8SHNZOe98pBiObzdR4GQ46u8fupa5iLCI
         HFEK0+hmCFhG7Ed+PldXV02y0t+qzJBUI5LsyzsIKHYAwURRhXl6ikzzGs2vUnZ9mSEE
         2UaLjR1fvCT4v8cf08n+XeVA8eAAX2DZafo7JRAeKWwKAnoiS7EYEIjEi3rGMY5RKGmR
         Wtww==
X-Gm-Message-State: ACrzQf24tPqnYhc6FfMfEdwdBEzEUOECF9NtgrE6nL9UwShfEFpk6lyp
        tpet9DQZqbI3yXSKDEIMymOaZQXWMMPiRg==
X-Google-Smtp-Source: AMsMyM5OsEMlD34Df4jkr8/uMFvEF72aPNJOorVUFnmBTeOtU3BXQJ9LKozQfkRwgKg9ZJ8bjMwDxg==
X-Received: by 2002:a05:600c:6023:b0:3c6:bd83:752f with SMTP id az35-20020a05600c602300b003c6bd83752fmr33473946wmb.35.1666345493779;
        Fri, 21 Oct 2022 02:44:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u6-20020adfeb46000000b002258235bda3sm18277768wrn.61.2022.10.21.02.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:44:53 -0700 (PDT)
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
Subject: [PATCH 9/9] CI: add a "linux-cmake-test" to run cmake & ctest on linux
Date:   Fri, 21 Oct 2022 11:44:22 +0200
Message-Id: <patch-9.9-b81f18dec61-20221021T091013Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1205.gcea0601d673
In-Reply-To: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
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
2.38.0.1205.gcea0601d673

