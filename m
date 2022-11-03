Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3289C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 16:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiKCQnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiKCQkn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 12:40:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E228821B5
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 09:38:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a67so3866203edf.12
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAVLOwCBtzJOqIfrff4zvty1t/pH+V3DoeHIWhXCOQY=;
        b=IT6WyEO1TzjMaN8em6Gh/AwVjHpHLOj+BtT16B530IcKxveR5VVVxdeAMYSbp+v1sY
         7N/JDR7YC5lx4xQsj3uenaRTp84Gcu7jHUcihDsmc3jiWhoJTEVynHn82n581VPeMKMX
         +7a8qLQJ+AG1uKeBHshHm9vcAan6zNoDiRbM0g61P9tC3jPOEhJyg6rz9aIYO32iarOa
         CuCmao/HCwF6cgZOaObFN+6vM53l4jiU/T3Qc6xOL24h77XKmYMTweg91ngtGbE2Rkbu
         W9DbMze4xB+SPByE1Sd6+IsMFL+1V7o5nKd6jO+GCyqnFEFPHxv4c8iJg74PVllOZe7+
         1bKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAVLOwCBtzJOqIfrff4zvty1t/pH+V3DoeHIWhXCOQY=;
        b=zNafl/DpDzBZeSGJB1U+xv4sTL3J/ci1brSlDWWyxK4JwUmsNcTsgwSRpGT7R3FPd+
         vebVUBmmiqlC6rjXN1I+mGOqmhElAEaeef8uPLyjL706ldw3Bxn+2+lWOqokh32dzty8
         S6v2WyiOUvoaHad2JodEKPUpGaS4BCdM/a5ae15fp1SpXXQ/P2M1JU+9fgGLH6ze3PXn
         5MlqVGL899iEQ3q2YMfZFQRnl0Xuyc53XZAXPGVcl9GQcBFEn4u0BYR0nCpeO3RrwnqW
         ovFoA+qSLzdFLwrLusn6u6Hyan8r/14ERnbxBUAfBl3e7voL/IToyxQMin+0SvhiWArE
         9e5Q==
X-Gm-Message-State: ACrzQf21L3y1e4+D4bJp4bJC2xfUaSKPzChj5RNDaRM7A7bsJaKlBaPs
        /fxSHpOKoQWkAPBOdqoBQ2MTNF/u546mPA==
X-Google-Smtp-Source: AMsMyM6Cq4PWwVUFcfF4ZEl4aEneuZ3mZlsCvRDkZ86px3Qjn61xOSLNa799kkV/yezpSHH+YgDxlQ==
X-Received: by 2002:a05:6402:5244:b0:461:d97e:5271 with SMTP id t4-20020a056402524400b00461d97e5271mr31910568edd.227.1667493500186;
        Thu, 03 Nov 2022 09:38:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b0078d38cda2b1sm666188ejc.202.2022.11.03.09.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:38:19 -0700 (PDT)
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
Subject: [PATCH v4 14/14] CI: add a "linux-cmake-test" to run cmake & ctest on linux
Date:   Thu,  3 Nov 2022 17:38:04 +0100
Message-Id: <patch-v4-14.14-277028678c8-20221103T160255Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20221101T225022Z-avarab@gmail.com> <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
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
2.38.0.1451.g86b35f4140a

