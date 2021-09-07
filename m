Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F685C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 15:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C03760F5E
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 15:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345281AbhIGPep (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 11:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhIGPeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 11:34:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552A2C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 08:33:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n5so15072414wro.12
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 08:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUpKS1awo/D1p6UuyHDHajuV7AL/Z6lFj53LBuN2vXg=;
        b=D3fIQbRJ+uXhufZ44X1p6S8IFecSw2K81lNktfcZFSpKcyG5VcPWeKaC8RCGXR+K8Q
         CkW4tWVmWwZTWw8s40KpCh/mleNw6U/D/FpzUz1MQSboHo07p130YxkRgnnHvLCmi3fS
         u2eU+Ty8d1ViRE6cTcG+YY6zh3PNDAUGFVOXp03m/ogLsbsyBMFGrI7dRl9v5nGsyGrA
         5ULy3sbJ2/RljV17stJsh6hzLLmSIcM5RsDvZmcZXK1p0JOpCv+RIX5RagZpC8m2FTPs
         J0Lk//SoMSirmnwBOWAu36rYWnHHOfUT4O6tBIEeY1hO9ieDHE1uvlEWFGevIYuvfON1
         1AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUpKS1awo/D1p6UuyHDHajuV7AL/Z6lFj53LBuN2vXg=;
        b=7TgHNaSbvoxfk94S0/eCCVexOWkoduVwodbUu3Po4QreFlhPojA+mKKnVo+obrOMaw
         xDMwgHO0C2XOo+IlaD4HWkxZycEtZTtQrDAfxV11Wk6KJcQC7mdjWzMxdRqkSPKrAMrX
         YBUMLK2x4Jigg6guCiTVhi+kXxzRrweSJMeXG49qHc+MOq5R8TkZFiCgBVJN/bgFG2LO
         BQn543d5iodqXxq4BfxHa9aTTVzrZBtNScnB4NsQA3KheKKiqFdg9r4MagLLOg4P7zoZ
         5RiCOHpxMisza/Je9gird168BavtHEoL+3gxQO8xVUrURD37SjvRw6AMsrn/XDaj00Vb
         ewMw==
X-Gm-Message-State: AOAM5314Id7P/NNq0mA/H/syicg6D359R5anrxkfPAzdE+0EbALY3yaH
        wKzDQXFIPFZda6OMa6acLAf3GHYO+oH7GA==
X-Google-Smtp-Source: ABdhPJwvXEfSErxmFqnoCQvFEBsDoyq82KVPSu2SctGgy1rpuovHKK+n8g373NofhfXsHPm6TGRrcw==
X-Received: by 2002:a05:6000:1186:: with SMTP id g6mr2912872wrx.126.1631028815332;
        Tue, 07 Sep 2021 08:33:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t64sm2568799wma.48.2021.09.07.08.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 08:33:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/3] add a test mode for SANITIZE=leak, run it in CI
Date:   Tue,  7 Sep 2021 17:33:28 +0200
Message-Id: <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.818.gd2ef2916285
In-Reply-To: <cover-v3-0.8-00000000000-20210831T132546Z-avarab@gmail.com>
References: <cover-v3-0.8-00000000000-20210831T132546Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can compile git with SANITIZE=leak, and have had various efforts in
the past such as 31f9acf9ce2 (Merge branch 'ah/plugleaks', 2021-08-04)
to plug memory leaks, but have had no CI testing of it to ensure that
we don't get regressions. This series adds a GIT_TEST_* mode for
checking those regressions, and runs it in CI.

Since I submitted v2 the delta between origin/master..origin/seen
broke even t0001-init.sh when run under SANITIZE=leak, so this series
will cause test smoke on "seen".

That failure is due to a bug in es/config-based-hooks [1] and the
hn/reftable topic, i.e. these patches are legitimately catching
regressions in "seen" from day 1.

Changes since v3:

 * Much updated commit message

 * Re-arranged the t/README change to avoid a conflict with "seen".

 * Now testing OSX as well as Linux. Full CI passes on top of "master"
   on both: https://github.com/avar/git/runs/3535331215

 * I ejected the previous 4-8/8 patches of adding SANITIZE=leak
   annotations to various tests, let's focus on the test mode itself
   here and not overly distracting ourselves with whatever other
   regressions on "seen" those annotations might cause, I can submit
   those annotations later.

 * As noted in the updated commit message I didn't end up going with
   Jeff King's suggestion of supporting LSAN_OPTIONS directly, and
   fixing the "fd" the tests write to. All of those things can be
   extended or fixed later.

1. https://lore.kernel.org/git/8735qvyw0p.fsf@evledraar.gmail.com/ [1]

Ævar Arnfjörð Bjarmason (3):
  Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
  CI: refactor "if" to "case" statement
  tests: add a test mode for SANITIZE=leak, run it in CI

 .github/workflows/main.yml |  6 ++++++
 Makefile                   |  5 +++++
 ci/install-dependencies.sh |  6 +++---
 ci/lib.sh                  | 31 +++++++++++++++++++++----------
 ci/run-build-and-tests.sh  |  2 +-
 t/README                   |  7 +++++++
 t/t0000-basic.sh           |  1 +
 t/t0004-unwritable.sh      |  3 ++-
 t/test-lib.sh              | 21 +++++++++++++++++++++
 9 files changed, 67 insertions(+), 15 deletions(-)

Range-diff against v3:
1:  85619728d41 = 1:  bdfe2279271 Makefile: add SANITIZE=leak flag to GIT-BUILD-OPTIONS
2:  91c36b94eaa ! 2:  6aaa60e3759 CI: refactor "if" to "case" statement
    @@ Metadata
      ## Commit message ##
         CI: refactor "if" to "case" statement
     
    -    Refactor an "if" statement for "linux-gcc" to a "case" statement in
    -    preparation for another case being added to it, and do the same for
    -    the "osx-gcc" just below it for consistency.
    +    Refactor an "if" statement for "linux-gcc" and "osx-gcc" to a "case"
    +    statement in preparation for another case being added to them.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
3:  7e3577e4e3c ! 3:  fffbfc35c00 tests: add a test mode for SANITIZE=leak, run it in CI
    @@ Metadata
      ## Commit message ##
         tests: add a test mode for SANITIZE=leak, run it in CI
     
    -    While git can be compiled with SANITIZE=leak there has been no
    -    corresponding GIT_TEST_* mode for it, i.e. memory leaks have been
    -    fixed as one-offs without structured regression testing.
    +    While git can be compiled with SANITIZE=leak we have not run
    +    regression tests under that mode, memory leaks have only been fixed as
    +    one-offs without structured regression testing.
     
    -    This change add such a mode, and a new linux-SANITIZE=leak CI
    -    target. The test mode and CI target only runs a whitelist of
    -    known-good tests using a mechanism discussed below, to ensure that we
    -    won't add regressions to code that's had its memory leaks fixed.
    +    This change add CI testing for it. We'll now build with GCC under
    +    Linux and test t000[04]*.sh with SANITIZE=leak, and likewise with GCC
    +    on OSX. The new jobs are called "linux-SANITIZE=leak" and
    +    "osx-SANITIZE=leak".
     
         The CI target uses a new GIT_TEST_PASSING_SANITIZE_LEAK=true test
    -    mode. When running in that mode all tests except those that have opted
    -    themselves in to running by setting and exporting
    -    TEST_PASSES_SANITIZE_LEAK=true before sourcing test-lib.sh.
    +    mode. When running in that mode, we'll assert that we were compiled
    +    with SANITIZE=leak, and then skip all tests except those that we've
    +    opted-in by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
    +    test-lib.sh (see discussion in t/README).
     
    -    I'm adding a "test-pragma-SANITIZE=leak-ok.sh" wrapper for setting and
    -    exporting that variable, as the assignment/export boilerplate would
    -    otherwise get quite verbose and repetitive in subsequent commits.
    +    The tests using the "TEST_PASSES_SANITIZE_LEAK=true" setting can in
    +    turn make use of the "SANITIZE_LEAK" prerequisite, should they wish to
    +    selectively skip tests even under
    +    "GIT_TEST_PASSING_SANITIZE_LEAK=true". In a preceding commit we
    +    started doing this in "t0004-unwritable.sh" under SANITIZE=leak, now
    +    it'll combine nicely with "GIT_TEST_PASSING_SANITIZE_LEAK=true".
     
    -    The tests using the "test-pragma-SANITIZE=leak-ok.sh" pragma can in
    -    turn make use of the "SANITIZE_LEAK" prerequisite added in a preceding
    -    commit, should they wish to selectively skip tests even under
    -    "GIT_TEST_PASSING_SANITIZE_LEAK=true".
    -
    -    Now tests that don't set the "test-pragma-SANITIZE=leak-ok.sh" pragma
    -    will be skipped under GIT_TEST_PASSING_SANITIZE_LEAK=true:
    +    Now tests that don't set "TEST_PASSES_SANITIZE_LEAK=true" will be
    +    skipped under GIT_TEST_PASSING_SANITIZE_LEAK=true:
     
             $ GIT_TEST_PASSING_SANITIZE_LEAK=true ./t0001-init.sh
             1..0 # SKIP skip all tests in t0001 under SANITIZE=leak, TEST_PASSES_SANITIZE_LEAK not set
     
    -    In subsequents commit we'll conservatively add more
    -    TEST_PASSES_SANITIZE_LEAK=true annotations. The idea is that as memory
    -    leaks are fixed we can add more known-good tests to this CI target, to
    -    ensure that we won't have regressions.
    +    The intent is to add more TEST_PASSES_SANITIZE_LEAK=true annotations
    +    as follow-up change, but let's start small to begin with.
    +
    +    It would also be possible to implement a more lightweight version of
    +    this by only relying on setting "LSAN_OPTIONS". See
    +    <YS9OT/pn5rRK9cGB@coredump.intra.peff.net>[1] and
    +    <YS9ZIDpANfsh7N+S@coredump.intra.peff.net>[2] for a discussion of
    +    that. I've opted for this approach of adding a GIT_TEST_* mode instead
    +    because it's consistent with how we handle other special test modes.
    +
    +    Being able to add a "!SANITIZE_LEAK" prerequisite and calling
    +    "test_done" early if it isn't satisfied also means that we can more
    +    incrementally add regression tests without being forced to fix
    +    widespread and hard-to-fix leaks at the same time.
    +
    +    We have tests that do simple checking of some tool we're interested
    +    in, but later on in the script might be stressing trace2, or common
    +    sources of leaks like "git log" in combination with the tool (e.g. the
    +    commit-graph tests). To be clear having a prerequisite could also be
    +    accomplished by using "LSAN_OPTIONS" directly.
    +
    +    On the topi of "LSAN_OPTIONS": It would be nice to have a mode to
    +    aggregate all failures in our various scripts, see [2] for a start at
    +    doing that which sets "log_path" in "LSAN_OPTIONS". I've punted on
    +    that for now, it can be added later, and that proposed patch is also
    +    hindered by us wanting to test e.g. test-tool leaks (and by proxy, any
    +    API leaks they uncover), not just the "common-main.c" entry point.
     
         As of writing this we've got major regressions between master..seen,
         i.e. the t000*.sh tests and more fixed since 31f9acf9ce2 (Merge branch
    @@ Commit message
         936e58851a (Merge branch 'ah/plugleaks', 2021-05-07) for some of the
         past history of "one-off" SANITIZE=leak (and more) fixes.
     
    +    The reason for using gcc on OSX over the clang default is because
    +    it'll currently fail to build with:
    +
    +        clang: error: unsupported option '-fsanitize=leak' for target 'x86_64-apple-darwin19.6.0'
    +
    +    If that's sorted out in the future we might want to run that job with
    +    "clang" merely to make use of the default, and also to add some
    +    compiler variance into the mix. Both use the
    +    "AddressSanitizerLeakSanitizer" library[3], so in they shouldn't be
    +    have differently under GCC or clang.
    +
    +    1. https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer
    +    2. https://lore.kernel.org/git/YS9OT%2Fpn5rRK9cGB@coredump.intra.peff.net/
    +    3. https://lore.kernel.org/git/YS9ZIDpANfsh7N+S@coredump.intra.peff.net/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## .github/workflows/main.yml ##
    @@ .github/workflows/main.yml: jobs:
                  cc: gcc
                  pool: ubuntu-latest
     +          - jobname: linux-SANITIZE=leak
    ++            cc: gcc
     +            pool: ubuntu-latest
    ++          - jobname: osx-SANITIZE=leak
    ++            cc: gcc
    ++            pool: macos-latest
          env:
            CC: ${{matrix.vector.cc}}
            jobname: ${{matrix.vector.jobname}}
    @@ ci/install-dependencies.sh: UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl
      		sudo apt-get -q -y install gcc-8
      		;;
      	esac
    +@@ ci/install-dependencies.sh: linux-clang|linux-gcc)
    + 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
    + 	popd
    + 	;;
    +-osx-clang|osx-gcc)
    ++osx-clang|osx-gcc|osx-SANITIZE=leak)
    + 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
    + 	# Uncomment this if you want to run perf tests:
    + 	# brew install gnu-time
     
      ## ci/lib.sh ##
     @@ ci/lib.sh: export GIT_TEST_CLONE_2GB=true
    @@ ci/lib.sh: export GIT_TEST_CLONE_2GB=true
      		export CC=gcc-8
      		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
      		;;
    +@@ ci/lib.sh: linux-clang|linux-gcc)
    + 	GIT_LFS_PATH="$HOME/custom/git-lfs"
    + 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
    + 	;;
    +-osx-clang|osx-gcc)
    ++osx-clang|osx-gcc|osx-SANITIZE=leak)
    + 	case "$jobname" in
    +-	osx-gcc)
    ++	osx-gcc|osx-SANITIZE=leak)
    + 		export CC=gcc-9
    + 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
    + 		;;
     @@ ci/lib.sh: linux-musl)
      	;;
      esac
      
     +case "$jobname" in
    -+linux-SANITIZE=leak)
    ++linux-SANITIZE=leak|osx-SANITIZE=leak)
     +	export SANITIZE=leak
     +	export GIT_TEST_PASSING_SANITIZE_LEAK=true
     +	;;
    @@ ci/run-build-and-tests.sh: esac
      	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
      	make test
      	export GIT_TEST_SPLIT_INDEX=yes
    -@@ ci/run-build-and-tests.sh: linux-gcc)
    - 	export GIT_TEST_CHECKOUT_WORKERS=2
    - 	make test
    - 	;;
    --linux-clang)
    -+linux-clang|linux-SANITIZE=leak)
    - 	export GIT_TEST_DEFAULT_HASH=sha1
    - 	make test
    - 	export GIT_TEST_DEFAULT_HASH=sha256
     
      ## t/README ##
    -@@ t/README: GIT_TEST_CHECKOUT_WORKERS=<n> overrides the 'checkout.workers' setting
    - to <n> and 'checkout.thresholdForParallelism' to 0, forcing the
    - execution of the parallel-checkout code.
    +@@ t/README: excluded as so much relies on it, but this might change in the future.
    + GIT_TEST_SPLIT_INDEX=<boolean> forces split-index mode on the whole
    + test suite. Accept any boolean values that are accepted by git-config.
      
     +GIT_TEST_PASSING_SANITIZE_LEAK=<boolean> when compiled with
     +SANITIZE=leak will run only those tests that have whitelisted
    -+themselves as passing with no memory leaks. Do this by sourcing
    -+"test-pragma-SANITIZE=leak-ok.sh" before sourcing "test-lib.sh" itself
    -+at the top of the test script. This test mode is used by the
    -+"linux-SANITIZE=leak" CI target.
    ++themselves as passing with no memory leaks. Tests can be whitelisted
    ++by setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing
    ++"test-lib.sh" itself at the top of the test script. This test mode is
    ++used by the "linux-SANITIZE=leak" CI target.
     +
    - Naming Tests
    - ------------
    + GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
    + default to n.
      
     
      ## t/t0000-basic.sh ##
    @@ t/t0000-basic.sh: swapping compression and hashing order, the person who is maki
      modification *should* take notice and update the test vectors here.
      '
      
    -+. ./test-pragma-SANITIZE=leak-ok.sh
    ++TEST_PASSES_SANITIZE_LEAK=true
      . ./test-lib.sh
      
      try_local_xy () {
     
    + ## t/t0004-unwritable.sh ##
    +@@
    + 
    + test_description='detect unwritable repository and fail correctly'
    + 
    ++TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_expect_success setup '
    +
      ## t/test-lib.sh ##
     @@ t/test-lib.sh: then
      	test_done
      fi
      
    -+# Aggressively skip non-whitelisted tests when compiled with
    -+# SANITIZE=leak
    ++# skip non-whitelisted tests when compiled with SANITIZE=leak
     +if test -n "$SANITIZE_LEAK"
     +then
     +	if test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
    @@ t/test-lib.sh: then
      # Last-minute variable setup
      HOME="$TRASH_DIRECTORY"
      GNUPGHOME="$HOME/gnupg-home-not-used"
    -
    - ## t/test-pragma-SANITIZE=leak-ok.sh (new) ##
    -@@
    -+#!/bin/sh
    -+
    -+## This "pragma" (as in "perldoc perlpragma") declares that the test
    -+## will pass under GIT_TEST_PASSING_SANITIZE_LEAK=true. Source this
    -+## before sourcing test-lib.sh
    -+
    -+TEST_PASSES_SANITIZE_LEAK=true
    -+export TEST_PASSES_SANITIZE_LEAK
4:  0cd14d64165 < -:  ----------- tests: annotate t000*.sh with TEST_PASSES_SANITIZE_LEAK=true
5:  ed5f5705755 < -:  ----------- tests: annotate t001*.sh with TEST_PASSES_SANITIZE_LEAK=true
6:  2599016c4e7 < -:  ----------- tests: annotate t002*.sh with TEST_PASSES_SANITIZE_LEAK=true
7:  ddc4d6d2cf1 < -:  ----------- tests: annotate select t0*.sh with TEST_PASSES_SANITIZE_LEAK=true
8:  e611d2c23d9 < -:  ----------- tests: annotate select t*.sh with TEST_PASSES_SANITIZE_LEAK=true
-- 
2.33.0.818.gd2ef2916285

