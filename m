Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8826C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiCYTa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiCYT3v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:29:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAF21F6F11
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:04:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qx21so17127340ejb.13
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7TByr+d93IZgtNqap7dx3shDraUYaThYPoxU85wjtKc=;
        b=Bly22zFlJzAE76x3d91ZNtzfzi3TzbLjKWj/Ty/YbDLs+5JQB6Cy5YC2MgM0h1pBg0
         aMSdIMcQaPGrmzW/I8AF1gaq6kyv4VeWuL0cDK5IGkBhX4MjPQaaMrpL4GdqRwsHdw5D
         hEr0BUZmR7Yiz2h2mF3Vjit1y7OZOnoRS1iag4+szAsnpMtcPvCYckRP19oJgJd2VeYB
         RVgLDsxk/ksAMLGU3Mci1L6h+6+ZgrpIJRXpOPpEStj/19gKmQMUGLSS16zS+ORN5kJ8
         vOYxzztMmTJOdP0biN1grJbdYB0t/fbKLuTvP/aiE4xxTKVTbybxBqNU3FzkWrs/beUN
         MxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7TByr+d93IZgtNqap7dx3shDraUYaThYPoxU85wjtKc=;
        b=henGvV9PIozk2tubC2jNojUo5Nj/QNTZsoQkA079tKvnp+Dy8Wa4zf80f2qk6f67Ux
         aSVWKNFWy2XTobM4H5azANJucxAJtGWc+ul8+ZtE3TFxlVpzwml/HgaSVOGDbHJFls5Q
         YCmnylT4Uqkgduivi4bFcPgp/8ljSoyLuPlAQbnOMFbvFbluMMP4+oejQRPEKCzFOQYu
         3mX0sdDXA+cgW0BWR6Gzn0asjreRiPgmUDv+gwOQrl7JmY3YpOFLaBiinZOmIHT1NwKh
         gZJgCTPA67liv22JSAfu+5RoNkOqd657dMoN0CJzI+vd8IzQ1/vNOgMwhC5HslBRcILe
         ffUw==
X-Gm-Message-State: AOAM532qOxh86lLvEURidlpq2nSYmLbJ+yMPNXtnXcc2IVuoE3U5+ocm
        r+v4O9URNwqsIOB/wUB2pQaYd+AKZgc98Q==
X-Google-Smtp-Source: ABdhPJyMJZ1gP7DE1sjhoYWtfjMHmwBbjCDgG7N0Uo72d7GjA24trDAzcM2lRLDQQfNLa0DZ+WVCpA==
X-Received: by 2002:a05:6000:1848:b0:204:e92:5af6 with SMTP id c8-20020a056000184800b002040e925af6mr10227419wri.180.1648233516889;
        Fri, 25 Mar 2022 11:38:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 19/25] CI: pre-select test slice in Windows & VS tests
Date:   Fri, 25 Mar 2022 19:38:10 +0100
Message-Id: <patch-v2-19.25-2edea06ee4d-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preceding commits the tests have been changed to do their setup via
$GITHUB_ENV in one step, and to then have subsequent steps that re-use
that environment.

Let's change the "test slice" tests added in b819f1d2cec (ci:
parallelize testing on Windows, 2019-01-29) to do the same. These
tests select 10% of the tests to run in 10 "test slices". Now we'll
select those in a step that immediately precedes the testing step, and
then simply invoke "make -C t -e".

This has the advantage that the tests to be run are now listed in the
standard "Run" drop-down at the start of the "test" step.

Since the "T" variable in "t/Makefile" doesn't normally accept
overrides from the environment we need to invoke "make" with the "-e"
option (a.k.a. "--environment-overrides"). We could also make $(T) in
t/Makefile be a "?=" assigned variable, but this way works, and is
arguably clearer as it's more obvious that we're injecting a special
list of tests that override the normal behavior of that Makefile.

Note that we cannot run the top-level "make test" here, because of how
the Windows CI builds git, i.e. either via CMake or some option that
would cause "make test" to recompile git itself. Instead we run "make
-C t [...]".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml                     | 10 ++++++++--
 ci/{run-test-slice.sh => select-test-slice.sh} |  4 ++--
 2 files changed, 10 insertions(+), 4 deletions(-)
 rename ci/{run-test-slice.sh => select-test-slice.sh} (57%)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fe37e0f1b36..1e13718b989 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -124,9 +124,12 @@ jobs:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - run: ci/lib.sh
       shell: bash
+    - name: select tests
+      run: . /etc/profile && ci/select-test-slice.sh ${{matrix.nr}} 10
+      shell: bash
     - name: test
       shell: bash
-      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
+      run: . /etc/profile && make -C t -e
     - name: ci/print-test-failures.sh
       if: failure()
       shell: bash
@@ -210,9 +213,12 @@ jobs:
       run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
     - run: ci/lib.sh
       shell: bash
+    - name: select tests
+      run: . /etc/profile && ci/select-test-slice.sh ${{matrix.nr}} 10
+      shell: bash
     - name: test
       shell: bash
-      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
+      run: . /etc/profile && make -C t -e
     - name: ci/print-test-failures.sh
       if: failure()
       shell: bash
diff --git a/ci/run-test-slice.sh b/ci/select-test-slice.sh
similarity index 57%
rename from ci/run-test-slice.sh
rename to ci/select-test-slice.sh
index 1de6a18ca47..ec602f8a053 100755
--- a/ci/run-test-slice.sh
+++ b/ci/select-test-slice.sh
@@ -1,10 +1,10 @@
 #!/bin/sh
 #
-# Test Git in parallel
+# Select a portion of the tests for testing Git in parallel
 #
 
 . ${0%/*}/lib.sh
 
 tests=$(echo $(cd t && ./helper/test-tool path-utils slice-tests "$1" "$2" \
 	t[0-9]*.sh))
-make --quiet -C t T="$tests"
+echo T="$tests" >>$GITHUB_ENV
-- 
2.35.1.1517.g20a06c426a7

