Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A3CC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378333AbiBUOsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:48:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378321AbiBUOrb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FB45F80
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:07 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v12so27530417wrv.2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XiNkijEQsLOHcXv/fQRjmaFqvIzmZ+P0xzLPc9nIq7Q=;
        b=CqTaO2gtwKJ0erOd2u+ps3LRjAPXhlw2mwR00TgMhFXTvI0uHU8sNERN6PmXPoSO4T
         UoKmvh00yAe8jXFZJAr7z3LNoYNOepyt1tQpEozbS52jhz6+gmdf8n926zPHOoH9I4Fj
         xm5Nj1O5DTeody/KiU2+feY5q4T6crKQFKuXXnWpizGNiDzIsyDg1ucapnETk6I5dRrr
         r3f/Ct8bWE+a06KkppTLhvIXB2lWuCdIu0tTnCD1kydYKEFQvM/6t5LpXquZ3j2BcO46
         AB8VomWrKb+hPlBYLRqmcl314frD9uG/9CaxOPp1QiGXBqoXhYokeIcB6UFEuQlymCTL
         hjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XiNkijEQsLOHcXv/fQRjmaFqvIzmZ+P0xzLPc9nIq7Q=;
        b=oZMAdOiWU+7H+y23BwjtpKzWOAzhtUrrTuFpyyCO5BdU+Gq0R5pd9rUiv+tDfN2kDI
         swXghu2ozmrb0ZP8dVsDiNrUY5Grb68cyWQTEIk43PvZ3uhHT6GsQ+oQgO8qfnWAU6rs
         jbAm7u4k0vqxqUXInMYsQbx+10H8xSbktjzL6q9KpAz3NlpEc84k+8XHp8O4Mkpp1Msf
         T1nk/7dOqfCSahW3PpwM48bueVsaoQ8EpQoAzg+De4O5X9pshcKnADt13cDM7sFoTQjj
         Wd5iJrYXcpC2reih3kYG+kJu0O0dO7zvnLieF6PCN8TA87sLNJnmNi2PvpfdfnVYzGsI
         GBtA==
X-Gm-Message-State: AOAM5315XgCvQXJ020ws/XAO7mPJM3EAWtGXJrerGKrnvCc5MqaQucGh
        Mpub870V/MmQKwlCa7CzhEQigIIduo+vUg==
X-Google-Smtp-Source: ABdhPJwqo86IwrFyGgv33KoZ6XcVWvKrlfZta9NybuQiXhldXLFzJQWAjz1LuXMPvwwA/rWaYslq3w==
X-Received: by 2002:a05:6000:184d:b0:1ea:78a5:f9c8 with SMTP id c13-20020a056000184d00b001ea78a5f9c8mr1037252wri.439.1645454825482;
        Mon, 21 Feb 2022 06:47:05 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:47:04 -0800 (PST)
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
Subject: [PATCH 19/25] CI: pre-select test slice in Windows & VS tests
Date:   Mon, 21 Feb 2022 15:46:31 +0100
Message-Id: <patch-19.25-e9c6c4dd293-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
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
2.35.1.1132.ga1fe46f8690

