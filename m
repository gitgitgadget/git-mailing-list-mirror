Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B89C4167E
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiCYTke (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiCYTjo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:39:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EADA154480
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:12:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id k10so10317043edj.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GrBOjazPoOy9bBn9XQWMC8zyaup1dZC3OgfdBghoBg8=;
        b=jumi3t455x3rEsycTdGYCXwheyvIGY2DQ252gYYeR8Zry7933iszJqoQBkX12gCAGo
         N83H78/3gPHRSFoFMCRtJquCmAYnO2Yh2GrtAaAkLnnbE1ElCl+iGJdLEGMcfdaNdH+4
         MVeqknAuQyw1mkdlwMKnBc/mupDV2G8gwSuG8LzAWTcptgHf2xoGZDY8fdTW0tgz26bd
         yx5W5vjV0moAbruzg+/eBNalBlWrF15s0r79ae2s952+Zql6H85eD4ONO8B9a1TBciZl
         8B4dHzfVOOzaCmz3ENLwJfoG4ZVWzFxkwQLsQuQlDZTN4AYcccU3lA0p1ZQUwRlvKPXH
         eIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GrBOjazPoOy9bBn9XQWMC8zyaup1dZC3OgfdBghoBg8=;
        b=I6ULNwrMPpjwPWUnHG/WQ1P3qQvXfhKx8E7viQdLZFTBY2jHg5oFGYCmoJH1fblUPr
         Nz0LuykvZUpQMIy8adz2vdyZlpZY9aasBFVMkxZo+pIWZwtbO6HsYEIZsR2ustixfynV
         ENMjiF4qeSPY5/8GyEUbShX3unLQnRSrSB56Woh7hgp4W7VnAYH9uILXznqfqbm4FuMD
         U9Sf7TMlFX0ACt6nMGRalo1NZAaGMv1QoFnRtAL7Ys5G00gCjFg5MjSTcUvaWzCQtKzT
         RF/xGaO09bePIOun/Oc5BoGmRJ835Ff41IOx1xYHe8LMIZ3/VnEF/W95kX+q+G9zGOO6
         zOvA==
X-Gm-Message-State: AOAM5338w8YIaGb7HqqCXeuK6UW4NZleWxTFa8otq4IMuPJUStwSgASn
        5G4k2t7U8j7sZtPH80d/XWi9WF7Djp3cOQ==
X-Google-Smtp-Source: ABdhPJwHbHOUVGMEQyeqw6SOHoPGlHOLB4i9qS4kHT1zj+/Ty/Zzk6607bmVUN66ijGonlqqTwKOFA==
X-Received: by 2002:a05:6000:1042:b0:203:f651:30ae with SMTP id c2-20020a056000104200b00203f65130aemr10047239wrx.543.1648233498874;
        Fri, 25 Mar 2022 11:38:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:18 -0700 (PDT)
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
Subject: [PATCH v2 00/25] CI: run "make [test]" directly, use $GITHUB_ENV
Date:   Fri, 25 Mar 2022 19:37:51 +0100
Message-Id: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of my improvements my series to simplify the CI setup a lot
(see diffstat), much of it was dealing with constraints that went away
with Travis et al. CI for this series (OSX runners failing for
unrelated reasons):

    https://github.com/avar/git/actions/runs/2040223909

For a much more detailed summary of how the output looks before/after
see v1[].

This series heavily conflicts with Johannes's
js/ci-github-workflow-markup in "seen", but in the v1 I suggested
basing that series on top of this one, because it can benefit a lot
from these simplifications.

I'll reply to this series with a proposed rebasing of that series on
top of this one, which allows for removing almost all of its changes
to "ci/" with no harm to its end-goals, i.e. the splitting up of
"make" and "make test" output is something it'll get for free from
this series.

Junio: Since that series has been stalled on still-outstanding
performance issues for a couple of months I was hoping we could queue
this instead, and perhaps in addition if Johannes approves of the
proposed re-roll on top of his.

There's some forward progress on the performance issues (this[2] reply
of Victoria Dye's from yesterday), but fully resolving those will
probably take a bit...

Whereas even though this one is relatively large I don't think there's
anything controversial here. The one concern that's been raised has
been Johannes's objection to removing some of the dead Azure code
(which was needed to move forward here). I asked how he'd prefer to
move forward with that in [3], but there hasn't been a reply to that
in >1 month.

I think just removing it is OK, we can always bring it back if needed,
and doing so is actually going to be simpler on top of this since the
CI is now less special, and leans more heavily on the logic of our
normal build process.

1. https://lore.kernel.org/git/cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com
2. https://lore.kernel.org/git/6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com/
3. https://lore.kernel.org/git/220222.86y2236ndp.gmgdl@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (25):
  CI: run "set -ex" early in ci/lib.sh
  CI: make "$jobname" explicit, remove fallback
  CI: remove more dead Travis CI support
  CI: remove dead "tree skipping" code
  CI: remove unused Azure ci/* code
  CI: don't have "git grep" invoke a pager in tree content check
  CI: have "static-analysis" run a "make ci-static-analysis" target
  CI: have "static-analysis" run "check-builtins", not "documentation"
  CI: move p4 and git-lfs variables to ci/install-dependencies.sh
  CI: consistently use "export" in ci/lib.sh
  CI: export variables via a wrapper
  CI: remove "run-build-and-tests.sh", run "make [test]" directly
  CI: check ignored unignored build artifacts in "win[+VS] build" too
  CI: invoke "make artifacts-tar" directly in windows-build
  CI: split up and reduce "ci/test-documentation.sh"
  CI: combine ci/install{,-docker}-dependencies.sh
  CI: move "env" definitions into ci/lib.sh
  ci/run-test-slice.sh: replace shelling out with "echo"
  CI: pre-select test slice in Windows & VS tests
  CI: only invoke ci/lib.sh as "steps" in main.yml
  CI: narrow down variable definitions in --build and --test
  CI: add more variables to MAKEFLAGS, except under vs-build
  CI: set CC in MAKEFLAGS directly, don't add it to the environment
  CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
  CI: don't use "set -x" in "ci/lib.sh" output

 .github/workflows/main.yml            | 100 +++++---
 Makefile                              |  31 ++-
 ci/check-directional-formatting.bash  |   2 +-
 ci/check-unignored-build-artifacts.sh |  20 ++
 ci/install-dependencies.sh            |  53 ++++-
 ci/install-docker-dependencies.sh     |  22 --
 ci/lib-ci-type.sh                     |  10 +
 ci/lib-tput.sh                        |   2 +
 ci/lib.sh                             | 316 +++++++++++++-------------
 ci/make-test-artifacts.sh             |  12 -
 ci/mount-fileshare.sh                 |  25 --
 ci/print-test-failures.sh             |  16 +-
 ci/run-build-and-tests.sh             |  54 -----
 ci/run-docker-build.sh                |  66 ------
 ci/run-docker.sh                      |  47 ----
 ci/run-static-analysis.sh             |  32 ---
 ci/run-test-slice.sh                  |  17 --
 ci/select-test-slice.sh               |  10 +
 ci/test-documentation.sh              |  37 +--
 ci/util/extract-trash-dirs.sh         |  50 ----
 shared.mak                            |   1 +
 21 files changed, 346 insertions(+), 577 deletions(-)
 create mode 100755 ci/check-unignored-build-artifacts.sh
 delete mode 100755 ci/install-docker-dependencies.sh
 create mode 100644 ci/lib-ci-type.sh
 create mode 100644 ci/lib-tput.sh
 delete mode 100755 ci/make-test-artifacts.sh
 delete mode 100755 ci/mount-fileshare.sh
 delete mode 100755 ci/run-build-and-tests.sh
 delete mode 100755 ci/run-docker-build.sh
 delete mode 100755 ci/run-docker.sh
 delete mode 100755 ci/run-static-analysis.sh
 delete mode 100755 ci/run-test-slice.sh
 create mode 100755 ci/select-test-slice.sh
 delete mode 100755 ci/util/extract-trash-dirs.sh

Range-diff against v1:
 1:  970849a227f =  1:  4addbd70213 CI: run "set -ex" early in ci/lib.sh
 2:  eda7fb18064 =  2:  b23aa99fd37 CI: make "$jobname" explicit, remove fallback
 3:  3ee32815cf3 =  3:  eec15a95879 CI: remove more dead Travis CI support
 4:  c81c1b3f504 =  4:  73c894f1665 CI: remove dead "tree skipping" code
 5:  4738a22a36d =  5:  b5e6d538554 CI: remove unused Azure ci/* code
 6:  59e4f41e86c =  6:  a4b9febbdca CI: don't have "git grep" invoke a pager in tree content check
 7:  836ef20fdcc !  7:  5d46d5b34c9 CI: have "static-analysis" run a "make ci-static-analysis" target
    @@ .github/workflows/main.yml: jobs:
          if: needs.ci-config.outputs.enabled == 'yes'
     
      ## Makefile ##
    -@@ Makefile: ifndef V
    - 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
    - 	QUIET_RC       = @echo '   ' RC $@;
    - 	QUIET_SPATCH   = @echo '   ' SPATCH $<;
    -+	QUIET_CHECK    = @echo '   ' CHECK $@;
    - 	QUIET_SUBDIR0  = +@subdir=
    - 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
    - 			 $(MAKE) $(PRINT_DIR) -C $$subdir
     @@ Makefile: coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard contrib/c
      # See contrib/coccinelle/README
      coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pending.cocci))
    @@ ci/run-static-analysis.sh (deleted)
     -
     -make hdr-check ||
     -exit 1
    +
    + ## shared.mak ##
    +@@ shared.mak: ifndef V
    + 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
    + 	QUIET_RC       = @echo '   ' RC $@;
    + 	QUIET_SPATCH   = @echo '   ' SPATCH $<;
    ++	QUIET_CHECK    = @echo '   ' CHECK $@;
    + 
    + ## Used in "Documentation/Makefile"
    + 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
 8:  95cd496868e =  8:  81e06f13d84 CI: have "static-analysis" run "check-builtins", not "documentation"
 9:  a1d0796259e =  9:  3be91c26d44 CI: move p4 and git-lfs variables to ci/install-dependencies.sh
10:  b6a61a786c5 = 10:  9dc148341ba CI: consistently use "export" in ci/lib.sh
11:  f2fcee5d6e4 = 11:  e9c7ba492e8 CI: export variables via a wrapper
12:  dfd823f2e7d = 12:  86d5a48d59a CI: remove "run-build-and-tests.sh", run "make [test]" directly
13:  46459fff296 = 13:  649ad1ae249 CI: check ignored unignored build artifacts in "win[+VS] build" too
14:  aecd3ebaafe = 14:  b1b5b083389 CI: invoke "make artifacts-tar" directly in windows-build
15:  4f1564af70f = 15:  dfa91ac8938 CI: split up and reduce "ci/test-documentation.sh"
16:  868613a5b06 = 16:  ba4ed216769 CI: combine ci/install{,-docker}-dependencies.sh
17:  5d854e8ff36 = 17:  b5e89a33340 CI: move "env" definitions into ci/lib.sh
18:  a6106525b7f = 18:  571f4d0f441 ci/run-test-slice.sh: replace shelling out with "echo"
19:  e9c6c4dd293 = 19:  2edea06ee4d CI: pre-select test slice in Windows & VS tests
20:  40d86e8c1dc = 20:  ef9daa6882f CI: only invoke ci/lib.sh as "steps" in main.yml
21:  abf9c504740 = 21:  44e3ace5fbe CI: narrow down variable definitions in --build and --test
22:  9f4c2798a82 = 22:  5f56b922e08 CI: add more variables to MAKEFLAGS, except under vs-build
23:  8a8b7ecf16b ! 23:  b45b7cec94e CI: stop over-setting the $CC variable
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    CI: stop over-setting the $CC variable
    +    CI: set CC in MAKEFLAGS directly, don't add it to the environment
     
    -    As detailed in 2c8921db2b8 (travis-ci: build with the right compiler,
    -    2019-01-17) the reason we started using $CC in $MAKEFLAGS as opposed
    -    to setting it in the environment was due to Travis CI clobbering $CC
    -    in the environment.
    +    Rather than pass a "$CC" and "$CC_PACKAGE" in the environment to be
    +    picked up in ci/lib.sh let's instead have ci/lib.sh itself add it
    +    directly to MAKEFLAGS.
     
    -    We don't need to set it unconditionally to accomplish that, but rather
    -    just have it set for those jobs that need them. E.g. the "win+VS
    -    build" job confusingly has CC=gcc set, even though it builds with
    -    MSVC.
    +    Setting CC=gcc by default made for confusing trace output, and since a
    +    preceding change to carry it and others over across "steps" in the
    +    GitHub CI it's been even more misleading.  E.g. the "win+VS build" job
    +    confusingly has CC=gcc set, even though it builds with MSVC.
    +
    +    Let's instead reply on the Makefile default of CC=cc, and only
    +    override it for those jobs where it's needed. This does mean that
    +    we'll need to set it for the "pedantic" job, which previously relied
    +    on the default CC=gcc in case "clang" become the default on that
    +    platform.
     
         This partially reverts my 707d2f2fe86 (CI: use "$runs_on_pool", not
         "$jobname" to select packages & config, 2021-11-23), i.e. we're now
    @@ ci/lib.sh: linux-TEST-vars)
      	setenv --test GIT_TEST_DEFAULT_HASH sha256
      	;;
      pedantic)
    ++	CC=gcc
    + 	# Don't run the tests; we only care about whether Git can be
    + 	# built.
    + 	setenv --build DEVOPTS pedantic
     @@ ci/lib.sh: linux-musl)
      	MAKEFLAGS="$MAKEFLAGS GIT_TEST_UTF8_LOCALE=C.UTF-8"
      	;;
24:  d7b472b4a52 = 24:  06bf8d9f61b CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
25:  08a9776c259 = 25:  6dc96ba8b82 CI: don't use "set -x" in "ci/lib.sh" output
-- 
2.35.1.1517.g20a06c426a7

