Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66590C4708E
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 02:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiLFCKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 21:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiLFCKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 21:10:16 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F34224BF5
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 18:09:44 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m19so18326892edj.8
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 18:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXKj0L/ir8yHB/1jX+Bp4bkPo6AG2/dOPJzImBOqw2g=;
        b=VIB20vLxOcxQR/YoFqHDBrehBbY5qHZ2F/QzPEprvkG/Xd8kzVDQdXGbnZDZdeRX/J
         Nh3k3kCiPAtEtq75K9oA9vZ4Unh1IRnxg8APHKsgQQzCnpImeQujICAuHZoRBPyuS7Hj
         vGGixVtfbipFf42SRkJeNtgLcBnxmmga4AAO41GXf2Hf3tZle52qnbe35vbzs3CGNy8Q
         E4mgMiy61cZYSXgxdjK9W032LKj4qXXcnhXirLoyPHsJRrPRN38wae8Wv4Blh2SfU0nN
         AgoOfn7AnK2R2asINV7jIO6K21WmSf/P1PLRq58+Fuzxidc/o2Di7fS3mGnwmNtUSNHS
         0Ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXKj0L/ir8yHB/1jX+Bp4bkPo6AG2/dOPJzImBOqw2g=;
        b=IbNc4bCc3NjbP2hpTsw6S5N3enfT27bjgmg2VxzJZfwyRzG1cpf4UepIN0K56AkNk/
         1TIrYGTj9wufrdm8q+71MkVw6LVyn8sQv2vs+sxE63RnVWGgrYil2ofa3p1pJbhiAC3G
         BTcmwDphutpcXEuUsE/3hSkwK8w8fNt9wAv9BNXKFFlruPjjvxxO+zupiWMzWrvgQ3DN
         ASrvXkS2lSnqzWjSWP1dU4I4ZZJrElyIGLcaTZbMHFHm/WdklHi2XvcNkMq2tiUS0V5p
         /FB8mARe0iTjsYj9//05kCaK7LvrAPWoqdwZPGY/DGwChXwKq84+Ir/UrE4lDuC7c8YU
         uabA==
X-Gm-Message-State: ANoB5pkd3XNWWebUtBpxzu/LqZdPUMOanddtB1Q6kCs1qwkO7hxMroY1
        GIFgfJzjgEXMKMh/uEUFXR+P7f5EDjK89A==
X-Google-Smtp-Source: AA0mqf4qIHMHkP3mUqkZJh8duuxkS6Y12G87wj8XrdBWvmCWoRSY8jat6lCRp1z+Qf0N1rrlReyx2Q==
X-Received: by 2002:aa7:c756:0:b0:46b:7038:b1f9 with SMTP id c22-20020aa7c756000000b0046b7038b1f9mr28780094eds.306.1670292582418;
        Mon, 05 Dec 2022 18:09:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm6966186ejm.178.2022.12.05.18.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:09:41 -0800 (PST)
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
Subject: [PATCH v6 15/15] CI: add a "linux-cmake-test" to run cmake & ctest on linux
Date:   Tue,  6 Dec 2022 03:09:13 +0100
Message-Id: <patch-v6-15.15-917a884eb65-20221206T001617Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.1006.gb4c675778ba
In-Reply-To: <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
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
can assert that testing with that method works.

This also stress tests running "cmake" (and "ctest") out of a build
directory that isn't the top-level. The "vs-build" job uses "cmake"
since [2], but clobbers the top-level "Makefile" and builds in the
top-level directory.

That was the reason for why we didn't spot that various tests still
required missing "mergetools/*" etc, which was fixed by using
"$GIT_SOURCE_DIR" in a preceding commit.

Since the "ci/lib.sh" already creates and exports a
GIT_TEST_OPTS="..." we'll pick that up in our CI; see the preceding
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
 ci/run-build-and-tests.sh  | 11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

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
index 8ebff425967..339962bc7c1 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -12,6 +12,7 @@ esac
 
 run_tests=t
 
+mc=
 case "$jobname" in
 linux-gcc)
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
@@ -43,12 +44,18 @@ pedantic)
 	export DEVOPTS=pedantic
 	run_tests=
 	;;
+linux-cmake-ctest)
+	cb=contrib/buildsystems
+	group CMake cmake -S "$cb" -B "$cb/out"
+	mc="-C $cb/out"
+	;;
 esac
 
-group Build make
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
2.39.0.rc1.1006.gb4c675778ba

