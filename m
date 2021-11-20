Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94648C433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 12:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhKTMNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 07:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhKTMNW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 07:13:22 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D35C061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 04:10:18 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 137so7332465wma.1
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 04:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/J/IuZLdt7Ve4oDwh4kS/YbXgCBUVU+ioHnMJuXeoDE=;
        b=hcRxS5WsksX/crIWLb4gJESxmfDr0l7iONd6xcVtM/GLYLMGQF6f4JvkBeCmvynYcH
         FlQl+0iqR9w7piXR8rtrmdAZCZYviTG9SIqKePkuQHi3ek0YzwBnjgwTOPB1AAgbf5LR
         5NeZr0WSTxSGsNy3PD3Dl6Kb0V5gtP1IMTSzaOyWqBdgn8MrIXSn8jJ2Gy1h9S+l1hiK
         gZ4eji4B3SKdldkMYVr/2ot5RAgGyfHUidKLLCFwA1dQJxZw9r2TGsFh0JeNTl9FfydR
         PkzTViNXGVYS7YO2wZ0m6wxct+uJ8ESEn1G6Dbzcmh1gDrRgV6h/Q9MlMm85gGiCD+Rz
         qPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/J/IuZLdt7Ve4oDwh4kS/YbXgCBUVU+ioHnMJuXeoDE=;
        b=dZzOHYRud3d7E5peTC/a/vYwD4G7omuC2ZXVk1LFpo66TC3NjKk4WZ1vkZe8qyGbBM
         A40jzJeg1P52WY1/+2PJhjr+O9oFPzoQ/ztsi9B5KFnrGFAZpPwH8MGqZf6hB4FxAKsC
         8D3GpQyUt5mDiakiXS3HtRiQrJl3TSWnp10Z5L1U12YYY+hBLw5pDz8WuWTZ3MaSjqTm
         1LnPkYVDvc2n6UNrB4XySj8lpbqIR9CmVv2xDfF90bSw67Kgn1phIDHpVQ82/+hsrMfe
         JZSuEb2TqXByoZ5ks9z+VdAUWnGjpoaM1Z072iFIxudTiBoWUSzVvD/gbTYROOIOSft6
         dfxw==
X-Gm-Message-State: AOAM5319LIGgjk5ogEQMfD0N/qcPSlZKwTD4Yi/FbQhAHl+hsfqDIQFb
        XIsl9viG3Dwvk+OmvbVaAJijSou3znbWX3Hr
X-Google-Smtp-Source: ABdhPJzzwhJwDOtoJL8WJqtp3t4Cgjyeznwg697YIxSlILz52xXS/AU+I8MM/v4YGaEutqvjlwm1PQ==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr9673708wmf.143.1637410216929;
        Sat, 20 Nov 2021 04:10:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m36sm3128221wms.25.2021.11.20.04.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 04:10:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/5] CI: Remove Travis CI, shorten names for GH tooltips, split jobs
Date:   Sat, 20 Nov 2021 13:10:06 +0100
Message-Id: <cover-v3-0.5-00000000000-20211120T115414Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.818.g0f23a581583
In-Reply-To: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An update to v3, now using the "pool" names instead of a new "os"
field for the job names. Before (on master):

    https://github.com/git/git/runs/4214600139

After:

    https://github.com/avar/git/actions/runs/1484426823

I peeled of the last "doc" patch based on Johannes's feedback. As with
the split-up TEST job we'll take more CPU time, but if we can run in
parallel take less wallclock time, but it's not really worth it for
the asciidoc/asciidoctor job with how long the install v.s. build/test
step takes (b.t.w. there was no change to "check-docs" running in
those jobs in v2).

1. https://lore.kernel.org/git/cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (5):
  CI: remove Travis CI support
  CI: use shorter names that fit in UX tooltips
  CI: rename the "Linux32" job to lower-case "linux32"
  CI: use "$runs_on_pool", not "$jobname" to select packages & config
  CI: don't run "make test" twice in one job

 .github/workflows/main.yml        | 26 ++++++++++++--
 .travis.yml                       | 60 -------------------------------
 README.md                         |  2 +-
 ci/install-dependencies.sh        | 33 ++++++++---------
 ci/install-docker-dependencies.sh |  2 +-
 ci/lib.sh                         | 60 ++++++++-----------------------
 ci/print-test-failures.sh         | 10 ------
 ci/run-build-and-tests.sh         | 26 +++++++-------
 ci/run-docker-build.sh            | 11 +-----
 ci/run-docker.sh                  |  4 +--
 10 files changed, 70 insertions(+), 164 deletions(-)
 delete mode 100644 .travis.yml

Range-diff against v2:
1:  cc94a353ccb = 1:  96433bcc02f CI: remove Travis CI support
2:  73981cedee8 ! 2:  b09cd076aeb CI: use shorter names that fit in UX tooltips
    @@ Commit message
         looked before, [2] for a currently visible CI run using this commit,
         and [3] for the GitHub workflow syntax involved being changed here.
     
    -    Let's also add a field for the "os" and use it where appropriate, it's
    -    occasionally useful to know we're running on say ubuntu
    -    v.s. fedora (but the "-latest" suffix isn't very useful, that applies
    -    to almost all the jobs.
    +    Let's also use the existing "pool" field as before. It's occasionally
    +    useful to know we're running on say ubuntu v.s. fedora. The "-latest"
    +    suffix is useful to some[4], and since it's now at the end it doesn't
    +    hurt readability in the short view compared to saying "ubuntu" or
    +    "macos".
     
         1. https://github.com/git/git/tree/master/
    -    2. https://github.com/avar/git/tree/avar/ci-rm-travis-cleanup-ci-names-2
    +    2. https://github.com/avar/git/tree/avar/ci-rm-travis-cleanup-ci-names-3
         3. https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions
    +    3. https://lore.kernel.org/git/d9b07ca5-b58d-a535-d25b-85d7f12e6295@github.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ .github/workflows/main.yml: jobs:
              name: failed-tests-windows
              path: ${{env.FAILED_TEST_ARTIFACTS}}
        regular:
    -+    name: ${{matrix.vector.jobname}} (${{matrix.vector.os}})
    ++    name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})
          needs: ci-config
          if: needs.ci-config.outputs.enabled == 'yes'
          strategy:
    -@@ .github/workflows/main.yml: jobs:
    -         vector:
    -           - jobname: linux-clang
    -             cc: clang
    -+            os: ubuntu
    -             pool: ubuntu-latest
    -           - jobname: linux-gcc
    -             cc: gcc
    -+            os: ubuntu
    -             pool: ubuntu-latest
    -           - jobname: osx-clang
    -             cc: clang
    -+            os: osx
    -             pool: macos-latest
    -           - jobname: osx-gcc
    -             cc: gcc
    -+            os: osx
    -             pool: macos-latest
    -           - jobname: linux-gcc-default
    -             cc: gcc
    -+            os: ubuntu
    -             pool: ubuntu-latest
    -           - jobname: linux-leaks
    -             cc: gcc
    -+            os: ubuntu
    -             pool: ubuntu-latest
    -     env:
    -       CC: ${{matrix.vector.cc}}
     @@ .github/workflows/main.yml: jobs:
              name: failed-tests-${{matrix.vector.jobname}}
              path: ${{env.FAILED_TEST_ARTIFACTS}}
3:  002c183fff4 = 3:  fb1b0ecbadd CI: rename the "Linux32" job to lower-case "linux32"
4:  eca0ad08d4b ! 4:  54913e775c1 CI: use "$runs_on_pool", not "$jobname" to select packages & config
    @@ Commit message
     
      ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
    +             pool: ubuntu-latest
                - jobname: linux-gcc
                  cc: gcc
    -             os: ubuntu
     +            cc_package: gcc-8
                  pool: ubuntu-latest
                - jobname: osx-clang
                  cc: clang
    -@@ .github/workflows/main.yml: jobs:
    +             pool: macos-latest
                - jobname: osx-gcc
                  cc: gcc
    -             os: osx
     +            cc_package: gcc-9
                  pool: macos-latest
                - jobname: linux-gcc-default
5:  a113b8404ed ! 5:  877f27d847c CI: don't run "make test" twice in one job
    @@ Commit message
     
      ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
    +           - jobname: linux-clang
                  cc: clang
    -             os: ubuntu
                  pool: ubuntu-latest
     +          - jobname: linux-sha256
     +            cc: clang
    @@ .github/workflows/main.yml: jobs:
     +            pool: ubuntu-latest
                - jobname: linux-gcc
                  cc: gcc
    -             os: ubuntu
                  cc_package: gcc-8
                  pool: ubuntu-latest
     +          - jobname: linux-TEST-vars
    @@ .github/workflows/main.yml: jobs:
     +            pool: ubuntu-latest
                - jobname: osx-clang
                  cc: clang
    -             os: osx
    +             pool: macos-latest
     
      ## ci/run-build-and-tests.sh ##
     @@ ci/run-build-and-tests.sh: windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
6:  7c423c8283d < -:  ----------- CI: run "documentation" via run-build-and-test.sh
-- 
2.34.0.818.g0f23a581583

