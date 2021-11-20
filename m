Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A86C433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 03:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhKTDbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 22:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhKTDbq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 22:31:46 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3180C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:28:43 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso11937922wml.1
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 19:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1dLMAqyVBszau66IU35qGqOK4yolALnlQaWj0bptO9w=;
        b=AKMC2fa9QYlffv2U2FQUpkx49nMYNCjpiwahSpLbFJfVrWwCt/wzN6iTKfMnYPPGw6
         VBGdfJhh+upXB/wefK1SubAKqrQlvXsW+yY/0zdzE9/b2DGf+K+/pW0rqms7r7T0GKRs
         iZTWKAf0jgkVPPF6WTES6/M6tEoNZiFHp3ANVga96H3wxg/4GyJJuwVz2p3DvXm9dVNk
         DPeTsfDJj0ipZpS1e6tkaABJ3i6LIvxbgt0/guftP5jBG6zFRXW88m4ICJuNqtrUTxW6
         OR0/adGjzSsQnOVPvfai56P4fEciM7HZ0F8rYyQDKNSIiWl8J7pMr2cY6hSxWJmoEr8b
         9NOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1dLMAqyVBszau66IU35qGqOK4yolALnlQaWj0bptO9w=;
        b=AknZNhiC3EfBsMvZjUIrMsjIEVd3BSio6Vr8K+y/XxEB7RIl/j1XYMorvq7udO34j5
         cxu+W8KO0sE+bPyW/sGJiqWxkfcbkF1aOxcUNyVbgSGf08rI5pnagQpxyodoC+bzQVWj
         wbYUloY07S7GnEX/Zd2WxasDJz3Budx2YWCPWxjScN1GCFT8ILgIpYoH8byjen3CMK3o
         pt2NseAJ3YWRL4dsyd0lJV/PLXPLEnvSmm0QqBBv7gVPykWChpt/cSht+fxOSiWYakTC
         lpKIoYU7I5n1Vmw+IUegrH4RsjXxwNh9Fip2iKlNGv4h4XSizyKteohyHEgkbmnLzbdP
         1dpQ==
X-Gm-Message-State: AOAM533RO0jHvdDHs83hRRC4CzkssoNMWc/8A4VMPsoAaDNEov4S6i3L
        7UKgLUT8ufq1g6io6tCxL7yZQq5INKsw7g==
X-Google-Smtp-Source: ABdhPJyhcZTaUbzU2FjyJ+MkrWV/6CGOwmeh4GNTEyB95fmC5RVK0D86W60Sryr12izc7iFgCmt0sw==
X-Received: by 2002:a05:600c:1549:: with SMTP id f9mr6293190wmg.118.1637378921868;
        Fri, 19 Nov 2021 19:28:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12sm1560623wmq.12.2021.11.19.19.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 19:28:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] CI: Remove Travis CI, shorten names for GH tooltips, split jobs
Date:   Sat, 20 Nov 2021 04:28:30 +0100
Message-Id: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.gcc3243ae16c
In-Reply-To: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I thought I'd submit a smaller change to just address the GitHub CI
name truncation in tooltips (now 2/6), but part of the feedback was
why we needed to update Travis CI code, and can't we split up the
"default" job etc.

So here's a larger series I'd initially peeled v1[1] from a WIP
version of.

The end-state is that the job names are shorter, and some are now
split up, before:

    https://github.com/git/git/runs/4214600139

After:

    https://github.com/avar/git/runs/4271369035

1. https://lore.kernel.org/git/cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (6):
  CI: remove Travis CI support
  CI: use shorter names that fit in UX tooltips
  CI: rename the "Linux32" job to lower-case "linux32"
  CI: use "$runs_on_pool", not "$jobname" to select packages & config
  CI: don't run "make test" twice in one job
  CI: run "documentation" via run-build-and-test.sh

 .github/workflows/main.yml        | 44 ++++++++++++++++++++--
 .travis.yml                       | 60 ------------------------------
 README.md                         |  2 +-
 ci/install-dependencies.sh        | 35 ++++++++---------
 ci/install-docker-dependencies.sh |  2 +-
 ci/lib.sh                         | 62 ++++++++-----------------------
 ci/print-test-failures.sh         | 10 -----
 ci/run-build-and-tests.sh         | 47 +++++++++++++++--------
 ci/run-docker-build.sh            | 11 +-----
 ci/run-docker.sh                  |  4 +-
 ci/test-documentation.sh          | 39 ++++++++-----------
 11 files changed, 123 insertions(+), 193 deletions(-)
 delete mode 100644 .travis.yml

Range-diff against v1:
-:  ----------- > 1:  cc94a353ccb CI: remove Travis CI support
1:  26f80c87c8d ! 2:  73981cedee8 CI: use shorter names that fit in UX tooltips
    @@ Commit message
         commit view. I.e. when mouse-clicking on the passing or failing
         check-mark next to the commit subject.
     
    -    That description is truncated to 24 characters, with the 3 at the end
    -    being placed by "...".
    -
    -    E.g. the full job name (visible at [1]):
    -
    -        "regular (linux-gcc-default, gcc, ubuntu-latest)"
    -
    -    Will, when shown in the tool-tip be truncated to:
    -
    -        "CI/PR / regular (linu..."
    -
    -    There's then a further limit in the expanded view where the job names
    -    are observably truncated to 44 characters (including "..."). I.e.:
    -
    -        "regular (linux-gcc-default, gcc, ubuntu-l..."
    -
    -    With this change we shorten both the job names, and change the
    -    top-level "name" from "CI/PR" to "CI", since it will be used as a
    -    prefix in the tooltips. We also remove redundant or superfluous
    -    information from the name, e.g. "ubuntu-latest" isn't really needed
    -    for "linux-leaks", it'll suffice to say linux. For discovering what
    -    image runs that specifically we can consult main.yml itself.
    -
    -    The above "regular (linux-gcc-default, gcc, ubuntu-latest)" job name
    -    then becomes a 1=1 match to the "$jobname" used in
    -    "ci/run-build-and-tests.sh". A "( push" or " (pull_request" is then
    -    added implicitly as before (from the top-level "on" parameter in
    -    "main.yml"). In the tooltip we'll now show:
    -
    -        "CI / linux-leaks (pu..."
    -
    -    We then have no truncation in the expanded view. See [2] for a
    -    currently visible CI run using this commit, and [3] for the GitHub
    -    workflow syntax involved being changed here.
    -
    -    We could avoid even more truncation with more compact names,
    -    e.g. changing "linux" to "lin" or "lnx", but I didn't do that since
    -    any additional shortening seemed counterproductive, i.e. "w32" is a
    -    well-known way of referring to "Windows", but "lin" isn't). We could
    -    also shorten e.g. "::build" and "::test" to "+bld" and "+tst", but
    -    those seem similarly to be overly obtuse.
    +    These names are seemingly truncated to 17-20 characters followed by
    +    three dots ("..."). Since a "CI/PR / " prefix is added to them the job
    +    names looked like this before (windows-test and vs-test jobs omitted):
    +
    +        CI/PR / ci-config (p...
    +        CI/PR / windows-buil...
    +        CI/PR / vs-build (pu...
    +        CI/PR / regular (lin...
    +        CI/PR / regular (lin...
    +        CI/PR / regular (os...
    +        CI/PR / regular (os...
    +        CI/PR / regular (lin...
    +        CI/PR / regular (lin...
    +        CI/PR / dockerized (...
    +        CI/PR / dockerized (...
    +        CI/PR / dockerized (...
    +        CI/PR / static-anal...
    +        CI/PR / sparse (pu...
    +        CI/PR / documenta...
    +
    +    By omitting the "/PR" from the top-level name, and pushing the
    +    $jobname to the front we'll now instead get:
    +
    +        CI / config (push)
    +        CI / win build (push...
    +        CI / win+VS build (...
    +        CI / linux-clang (ub...
    +        CI / linux-gcc (ubun...
    +        CI / osx-clang (osx)...
    +        CI / osx-gcc (osx) (...
    +        CI / linux-gcc-defau...
    +        CI / linux-leaks (ub...
    +        CI / linux-musl (alp...
    +        CI / Linux32 (daald/...
    +        CI / pedantic (fedor...
    +        CI / static-analysis...
    +        CI / sparse (push)...
    +        CI / documentation
    +
    +    We then have no truncation in the expanded view. See [1] for how it
    +    looked before, [2] for a currently visible CI run using this commit,
    +    and [3] for the GitHub workflow syntax involved being changed here.
    +
    +    Let's also add a field for the "os" and use it where appropriate, it's
    +    occasionally useful to know we're running on say ubuntu
    +    v.s. fedora (but the "-latest" suffix isn't very useful, that applies
    +    to almost all the jobs.
     
         1. https://github.com/git/git/tree/master/
    -    2. https://github.com/avar/git/tree/avar/ci-shorter-names
    +    2. https://github.com/avar/git/tree/avar/ci-rm-travis-cleanup-ci-names-2
         3. https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ .github/workflows/main.yml: jobs:
                  }
      
        windows-build:
    -+    name: w32::build
    ++    name: win build
          needs: ci-config
          if: needs.ci-config.outputs.enabled == 'yes'
          runs-on: windows-latest
    @@ .github/workflows/main.yml: jobs:
              name: windows-artifacts
              path: artifacts
        windows-test:
    -+    name: w32::test
    ++    name: win test
          runs-on: windows-latest
          needs: [windows-build]
          strategy:
    @@ .github/workflows/main.yml: jobs:
              name: failed-tests-windows
              path: ${{env.FAILED_TEST_ARTIFACTS}}
        vs-build:
    -+    name: w32/VS::build
    ++    name: win+VS build
          needs: ci-config
          if: needs.ci-config.outputs.enabled == 'yes'
          env:
    @@ .github/workflows/main.yml: jobs:
              name: vs-artifacts
              path: artifacts
        vs-test:
    -+    name: w32/VS::test
    ++    name: win+VS test
          runs-on: windows-latest
          needs: vs-build
          strategy:
    @@ .github/workflows/main.yml: jobs:
              name: failed-tests-windows
              path: ${{env.FAILED_TEST_ARTIFACTS}}
        regular:
    -+    name: ${{matrix.vector.jobname}}
    ++    name: ${{matrix.vector.jobname}} (${{matrix.vector.os}})
          needs: ci-config
          if: needs.ci-config.outputs.enabled == 'yes'
          strategy:
    +@@ .github/workflows/main.yml: jobs:
    +         vector:
    +           - jobname: linux-clang
    +             cc: clang
    ++            os: ubuntu
    +             pool: ubuntu-latest
    +           - jobname: linux-gcc
    +             cc: gcc
    ++            os: ubuntu
    +             pool: ubuntu-latest
    +           - jobname: osx-clang
    +             cc: clang
    ++            os: osx
    +             pool: macos-latest
    +           - jobname: osx-gcc
    +             cc: gcc
    ++            os: osx
    +             pool: macos-latest
    +           - jobname: linux-gcc-default
    +             cc: gcc
    ++            os: ubuntu
    +             pool: ubuntu-latest
    +           - jobname: linux-leaks
    +             cc: gcc
    ++            os: ubuntu
    +             pool: ubuntu-latest
    +     env:
    +       CC: ${{matrix.vector.cc}}
     @@ .github/workflows/main.yml: jobs:
              name: failed-tests-${{matrix.vector.jobname}}
              path: ${{env.FAILED_TEST_ARTIFACTS}}
        dockerized:
    -+    name: ${{matrix.vector.jobname}} (docker)
    ++    name: ${{matrix.vector.jobname}} (${{matrix.vector.image}})
          needs: ci-config
          if: needs.ci-config.outputs.enabled == 'yes'
          strategy:
    -@@ .github/workflows/main.yml: jobs:
    -       matrix:
    -         vector:
    -         - jobname: linux-musl
    -+          os: alpine
    -           image: alpine
    -         - jobname: Linux32
    -+          os: ubuntu32
    -           image: daald/ubuntu32:xenial
    -         - jobname: pedantic
    -+          os: fedora
    -           image: fedora
    -     env:
    -       jobname: ${{matrix.vector.jobname}}
     @@ .github/workflows/main.yml: jobs:
            run: ci/install-dependencies.sh
          - run: make sparse
2:  9b8a3f0cdc4 ! 3:  002c183fff4 CI: rename the "Linux32" job to lower-case "linux32"
    @@ Commit message
     
      ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
    +         vector:
              - jobname: linux-musl
    -           os: alpine
                image: alpine
     -        - jobname: Linux32
     +        - jobname: linux32
    -           os: ubuntu32
    ++          os: ubuntu32
                image: daald/ubuntu32:xenial
              - jobname: pedantic
    -
    - ## .travis.yml ##
    -@@ .travis.yml: matrix:
    -       os: linux
    -       dist: trusty
    -       compiler:
    --    - env: jobname=Linux32
    -+    - env: jobname=linux32
    -       os: linux
    -       compiler:
    -       addons:
    +           image: fedora
     
      ## ci/install-docker-dependencies.sh ##
     @@
-:  ----------- > 4:  eca0ad08d4b CI: use "$runs_on_pool", not "$jobname" to select packages & config
-:  ----------- > 5:  a113b8404ed CI: don't run "make test" twice in one job
-:  ----------- > 6:  7c423c8283d CI: run "documentation" via run-build-and-test.sh
-- 
2.34.0.823.gcc3243ae16c

