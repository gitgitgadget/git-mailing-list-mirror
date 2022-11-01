Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEBBC433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiKAWwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKAWwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:52:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CA11FFBA
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:52:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r14so23896632edc.7
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 15:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5xW6N7/nMUpG1e7BVOv1btDovF1oSv1iu9OhV4y0N4=;
        b=hNA+wIq5fJM7NCYMvSU6fCH0NgQ7AiC99Ng4pESqkmarwfJdcm3QsajWtWfxTpph4V
         S5cjca5qfaPsn9N/4papikqmhpHPayoXN+M58YKnQ1aakD5qDMJb7291dtM0G8qBfhmH
         MBuwZi+y2oY846R2uwKxedHq6Xv67+Nc9mOlyuftGe54rvdQht7fF3up/1MpneOnPeKr
         rtTK4rSH7jnRjYxQp72vOrHOeDF4fK5Be8NRkqRUvOATz2Gn1eiDmHQ9r23ZYhezD5tQ
         Y9S8f1N+Mx+BmO58qc3Z/a3Zmg9CoRo7qw3hFu9sxTRvlxzDdcDXdS7Lmbwix6wIDfTZ
         2ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5xW6N7/nMUpG1e7BVOv1btDovF1oSv1iu9OhV4y0N4=;
        b=0/q6KUG24L03JRxkou48o6qejO7By3cfNUMthdUOaq8LlVbtSFjhg0yOm6FTJxMeM7
         wcgVxte7E0V8EzePnlPDvEGtSxyQOIwd29YbgroH1dnYt7rDrKIb9L2wBbqIEfSV/fzv
         wBJ2bMVY8zndBabu1dV54Y15kWykhRPJtJLFguGORrin5fpakuyE0oV4omO3K2XAX5T/
         gV9N04AOBIpMfPCJba7iF0U/PTebtqf+USDklFrEiv7GXaiKSZnvZ2Oyb5uOHaO9IpqK
         +EkUm2dJjwvYVYiLg5E3L4w36sjblNBzpuoV1lxhM8bIyOC1LLRxBLy/urtI51Zs5mVs
         57Uw==
X-Gm-Message-State: ACrzQf266aKWybjf7013RnR1ODfVup5KhdBhlYm0Y6obKXcbu/iuAzwW
        BBegBxeVYu2KEF/CL9A990xpqvx2PFO/4Q==
X-Google-Smtp-Source: AMsMyM4LGJo36Tf4v/0yQYZ8FRZE/jvuBPPEzHga/zHfuL1bngHGJNIT8wrnoxjiNNXBmsv4ch0VLw==
X-Received: by 2002:aa7:d40e:0:b0:463:3844:f160 with SMTP id z14-20020aa7d40e000000b004633844f160mr15910463edq.296.1667343120394;
        Tue, 01 Nov 2022 15:52:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x20-20020aa7d6d4000000b004580862ffdbsm5012689edr.59.2022.11.01.15.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:51:59 -0700 (PDT)
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
Subject: [PATCH v3 12/12] CI: add a "linux-cmake-test" to run cmake & ctest on linux
Date:   Tue,  1 Nov 2022 23:51:36 +0100
Message-Id: <patch-v3-12.12-c27f620dfa3-20221101T225022Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
References: <cover-v2-00.11-00000000000-20221027T032622Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com>
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
index bd6f75b8e0f..68c2e134646 100644
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
2.38.0.1280.g8136eb6fab2

