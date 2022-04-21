Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFDFC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391376AbiDUS2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391348AbiDUS1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:27:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64C34B437
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso6414011wme.5
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXHpyYHpqYmeqD3dRDb1GfL1xBghdzRo2jWukUDkt34=;
        b=lp2rEV3685ANEG+VsaUfnM5pCojL40mXwLhiVmDpglFKSzEqPv5Ibj7SHVKqbaVRri
         mJkcs+6hnePb1h0fTvSNpjpUuKF4/IpJA/LB1xsqBNdSA8wkWVHKDoLFgArRu8mSdecV
         kJ5N8NWcmI8k7sG0bxl7TprNPNsm8QFLtDnF88AfCHG8hJ5RAEu66PVx8AsWXyJIMAIL
         hTYnZB86Yah6Ii5VyGP9lhtFB990kq/g4RZkOh+MZOT0wjzXbNxlE4vrkGAoLYByJfVv
         TpDn5rOJjyJ36QYnB+xOa9Wv8MbQmRF2LXTbj3qv6KgUwdgrv8+0PQwiRYZzdpft2Grw
         X1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXHpyYHpqYmeqD3dRDb1GfL1xBghdzRo2jWukUDkt34=;
        b=Qofxxg+AVlQz8zTd4Z5/EDrEAUWPzLxD9KAAKHXe6HQVmaaNPyt8bY/PC/30GeH9w8
         j/3drpY1VmOTMJ38iHhVQ5ykSVbn8qKccLDFPAqARe9TvPy/5LsOBexATB6YAxHdvFtF
         BpZN/5sxy3viu8NIzNiM0B545IR5LYIX86859lCF6Gr3YmKtpFKbt7xdcs0ychPI7ody
         NSoLbrPWC7CArJZ5EQ0eAIrba8PKr2TcSFgFyjbhfzrMONx7GPK8oY4ACI/enPDqdTbH
         27FD3gxwTxZJquoOi/CvrQS0JOq/E/XazMgYdGdTuj7+r/LtsEKKT/B7HQNl4pJtibYz
         x+XA==
X-Gm-Message-State: AOAM533V2q2Sn2Xf+CRiCrJLmV+qtXjwQNyR5Qj2hgwnekGXW0gl3EcA
        ver2KOBPAlbkQIqg8i5j6BZc25dlKncVcA==
X-Google-Smtp-Source: ABdhPJz+sFkV4tVak6BBYzomJY8GDUl23cZSUyIJzFN1efrVUzyXZycDUakqmUi08eZxJERjW1tc5Q==
X-Received: by 2002:a1c:cc01:0:b0:37b:dcc8:7dfd with SMTP id h1-20020a1ccc01000000b0037bdcc87dfdmr600893wmb.134.1650565435265;
        Thu, 21 Apr 2022 11:23:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:54 -0700 (PDT)
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
Subject: [PATCH v5 21/29] CI: pre-select test slice in Windows & VS tests
Date:   Thu, 21 Apr 2022 20:23:16 +0200
Message-Id: <patch-v5-21.29-0c7cd9d64ba-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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
2.36.0.879.g3659959fcca

