Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E917DC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbiEYKHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242014AbiEYKFH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:05:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B926E8FB
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:05 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e28so28782712wra.10
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Co9lpyAu/F+uSXVbhPWToK3DntcWRS98c1sNH7eopDQ=;
        b=hgtKJFnTIYp7hRv6Yh7/sNpobx08kJWbpzBzH4YFmpK9Hzz/pSrJaXqED/pB72JgCp
         27OppSfUyEyw/O+GB6aFmMeeFmr/ZRbyqAKH0SP1V5JIYNJg1JQ2zpX5uEdq79tKEuE5
         GkJCMR8gdH0pdWFbavI0eRdfMsTVzyEP9oDA8K8+J3VB6KiUQw3KojCHsXwGuCLBbDGE
         KseOjTkUfMFNWT5cRCyJ4xyC70NNiV3ufuIaZRjtBPl2YIw2Q03t0kbr+sQ0y+nocVSd
         qS4rYhiDgkwccoGrp+rAPFgREk/6OK7tnwF5erIhCEEQlVoi7XLTF8K+ymvLhorUxxHN
         VcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Co9lpyAu/F+uSXVbhPWToK3DntcWRS98c1sNH7eopDQ=;
        b=dNSyYqg/XCmbgm0VQ52G+dwiWDSl5rGkL/1yRLuZEqby6tw4TRTGP8ph5/RcS7M+Bi
         IJdroNmDGD6y3N85CGwg6JnadG0nJKULMrdairlgNbXQa5BvSCkNPneG2ub/EAIJxxvA
         G7PWFPhGpr0+HbmtJxhYMaSCUS9uq1HzDEm5OmEpL3IOJ8MlD75LB2TjkFHiXZXmZu0D
         6A5RFtFHRl6l4nLcpESQjBxlB6uyH+HtubiMe84/Dw1YtYn8GhKzBb0/1g7jWiZVFJ2Y
         yKsc/n7bpQMTB/YI9Z4PW3rN6b5VJXkoFo/pMj7EvCrkjBn8+rMotmvZpxwoHdzGVesN
         yFUg==
X-Gm-Message-State: AOAM530jEPLByI7VDm8J4WKNn00C3O3uLCTKAJMPDAMEcyxwvFYaEUYO
        9Ud24pGsaLGRUfxgJzY0Wvk0W/cW0l+y+Q==
X-Google-Smtp-Source: ABdhPJxw63FiSHGOMNq6muszkUNtJ9lEp5daVWANYueBfoKoj15UhGSfVg5MxjdxOgTMRE5E5HI/UQ==
X-Received: by 2002:a05:6000:1887:b0:20f:e0c4:1eca with SMTP id a7-20020a056000188700b0020fe0c41ecamr11181618wri.465.1653473103997;
        Wed, 25 May 2022 03:05:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:05:03 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 21/29] CI: pre-select test slice in Windows & VS tests
Date:   Wed, 25 May 2022 12:04:00 +0200
Message-Id: <patch-v6-21.29-1eeb2e8e7f0-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
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
 ci/{run-test-slice.sh => select-test-slice.sh} |  7 +++++--
 2 files changed, 13 insertions(+), 4 deletions(-)
 rename ci/{run-test-slice.sh => select-test-slice.sh} (50%)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 5f167ac5be6..83e0aa1f469 100644
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
similarity index 50%
rename from ci/run-test-slice.sh
rename to ci/select-test-slice.sh
index 1de6a18ca47..f59d8cadda5 100755
--- a/ci/run-test-slice.sh
+++ b/ci/select-test-slice.sh
@@ -1,10 +1,13 @@
 #!/bin/sh
 #
-# Test Git in parallel
+# Select a portion of the tests for testing Git in parallel
 #
 
 . ${0%/*}/lib.sh
 
 tests=$(echo $(cd t && ./helper/test-tool path-utils slice-tests "$1" "$2" \
 	t[0-9]*.sh))
-make --quiet -C t T="$tests"
+if test -n "$GITHUB_ENV"
+then
+	echo T="$tests" >>$GITHUB_ENV
+fi
-- 
2.36.1.1045.gf356b5617dd

