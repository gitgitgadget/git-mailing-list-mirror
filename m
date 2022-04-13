Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71EAC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbiDMTzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbiDMTyk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3A350E1A
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c10so4157371wrb.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GGxnsA1f0mYbf6/nSP5mRjqeCTrc3gj+EPjqTur0rVQ=;
        b=dA3NIcogDLsZ1kL60oNrK7juuwk6/MYpS6fyMHQmIkc8fAwhSnp5ofNl05C32kjbbg
         nJ88qbznxJVRYBS7FqVajORINcT6vefhHHtgqgNYEwlwUjbArH2Bq5ohfyluzZUUB8lN
         /f2IKaRjy/i85dT9sB8reWCgar9y03GOGvZun21ECjZckVivA8I7Q6ZIYo8ObJ+BPfxz
         KLrtz/kAl3u9D5oPLQpaGBRHmorvUEfaNhxJ+LUMBK23F73bcCBXQrSlpLmkp/LExYgY
         9anPbrqxd2pQgEnXciSqKxTeZgblFeELgastXEzaM1GAemSWoTEley3DbSszM1dO5+rD
         utHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GGxnsA1f0mYbf6/nSP5mRjqeCTrc3gj+EPjqTur0rVQ=;
        b=kuYpdlXvS+QPyAhyVENFH3FJ07v7MJMzWp4tw833YTXX6Pv7tFeKwEJdMXKX9S4Thk
         4PC0WuR9EP9zUpkEo0n2xZADpXV168vVx6zzFEg2atmzE1QJfSAlIjAN+lVSSxe8RfaS
         N5069SCmle1Ww16IEsgzwFwzjFU8A1b20HnLP1KKizY6WkSQmJ1vR7uQznBK2W4+CPMw
         Mjs5gysT89pfyJJcPUbK3QWVmDkvo/1b3ticzWcF0n8ptFZiZWKel21VkEmwIbNhMSI9
         N/VhCHZ0ZjQryeXbeUuydsEbRL366YRor8n1+TINNJo+cMAkWfclWXL0X/RI5f6d7Rvi
         w/vw==
X-Gm-Message-State: AOAM532VWC+A7DO6K7mfE3s7J+/5qhl0XDDVbm76dC3gGw+VXV//xlUY
        S2Kc6r6WSqdW1BJvBflOCcyXlTrqsSm/cQ==
X-Google-Smtp-Source: ABdhPJzqDyvEdjP375xVEE7DZlbAXN1K8mylIxc+lDOLDbQF2M0owk4Wst3ZzSZWYNReS2CE4dvJlQ==
X-Received: by 2002:adf:cd87:0:b0:207:b0ad:6d8 with SMTP id q7-20020adfcd87000000b00207b0ad06d8mr331905wrj.111.1649879534847;
        Wed, 13 Apr 2022 12:52:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:14 -0700 (PDT)
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
Subject: [PATCH v3 21/29] CI: pre-select test slice in Windows & VS tests
Date:   Wed, 13 Apr 2022 21:51:34 +0200
Message-Id: <patch-v3-21.29-16ac7f5c210-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
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
2.36.0.rc2.843.g193535c2aa7

