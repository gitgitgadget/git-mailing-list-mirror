Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28383C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 19:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbiGNTkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 15:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiGNTj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 15:39:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2292420F50
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:39:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r14so3935978wrg.1
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tfasHUWNduBN3/2XN7utFeLDw794UNhxpTsbzqhW7lk=;
        b=MfYubzP4u/6rLfM2EIOyWl7K3nPCUT7YkSqCJso5hMO+rmmMM3xD0hDGEbsjmop/lC
         FCxjk4/DJtihovzdq5OeHbzDWR4uKxnQQzUO1HgMESDy2d8yP3LKl8oJ8qSqHfyh4u59
         1wT6PIag8A40M2FAvvFTH5FbnZ1N0PQtjStKuEHMzEep0iuF5Q2MdIhqSW3j99dP36Bc
         Xu86uL1fCEhK1S5WMJM7xB9RTqRmkU5rWtnt869G6FM5tawkGD+elzv8zkAAhAOQYILH
         KHDu9fN6R8f6cQdYadAztySJT6DQ4Wgu48RqAwf8bpYrxWIMxIAVxJWoLyCEOi1GO0FU
         YlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tfasHUWNduBN3/2XN7utFeLDw794UNhxpTsbzqhW7lk=;
        b=msOBa5+IbPawsW7EhvmL4WVKx63HY4+yZca/CxtvWJ5Pr8hm5dWVuspjEc6HaG9PSk
         jxCbB1szgcqawj8b/ps7rlkacw6d/B7WSOgn54Z3ceD8ypoPw0NnbFnZ1MmS3J2wroW9
         sT82Wst1HtMyIuR1tV2Obs/V7zUfp1QgbVmR1KwysBcOP42Tt6lkubZnQ/I7kjnLO110
         3JV3/DYe4Bp0ci484uOQHkrUwqIVZOzbsASxKgYX7yELA6p5DjyyCJB3OG5wGvwvZpmF
         B7U6BUEeOAUBK3JfPByS6m3DsHOHYjpvZIXc+osNCQdEb5dkX314gpTHEECAz4+OS6iV
         +xkg==
X-Gm-Message-State: AJIora9CCmcRXRTUuBNNzh+TSBTg12Ey6E+IyV+3v3mlZf88yv5HYLTs
        1bTnryOzlw37OPY3jvOyFE45ZhPWlSFjkQ==
X-Google-Smtp-Source: AGRyM1tj1QZd4Qc5lIERSNmk4UsliTP6V+XW9Fb6vZJqwZZpAmYqJl6Qckf2gWgZ30khCW/zXP/0gw==
X-Received: by 2002:a05:6000:2a7:b0:21d:bbda:4fcd with SMTP id l7-20020a05600002a700b0021dbbda4fcdmr9697667wry.316.1657827591670;
        Thu, 14 Jul 2022 12:39:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600018c900b0021dac657337sm2145145wrq.75.2022.07.14.12.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 12:39:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/10] ci: make it easy to run locally, part 1
Date:   Thu, 14 Jul 2022 21:39:37 +0200
Message-Id: <cover-00.10-00000000000-20220714T193808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.996.g651fc6e809f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series extracted from the much larger series to run CI in
"steps"[1] submitted in the last cycle, and rebased on CI work that's
happened in-tree since then.

At the end of this series the "ci/run-static-analysis.sh" has been
extracted to a "make ci-static-analysis", target, which the CI then
runs. The introduction of "setenv" and some of the structures here is
larger than strictly necessary to get to that point, but as seen in
[1] is in service of the larger goal of making CI less of a special
snowflake.

The eventual goal down the line is to be able to trivially run local
tests "as in CI", to the extent that's possible. Obviously we can't
easily run the OSX CI locally on a Linux box, but it's now a needless
hassle to set up e.g. the same environment variables as various CI
jobs require before they run "make" or "make test".

This series starts out by removing some dead Travis CI code, the
removal of the Azure bits of CI code has been ejected, as Johannes is
planning to re-use it[2]. Per earlier discussions I'm not sure exactly
what parts he had in mind to keep[3], but I've made an educated guess
here.

Passing CI for this series can be seen at [4].

1. https://lore.kernel.org/git/cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com/
2. https://lore.kernel.org/git/pull.1288.git.1657789234416.gitgitgadget@gmail.com/
3. https://lore.kernel.org/git/220609.86r13xsj00.gmgdl@evledraar.gmail.com/
4. https://github.com/avar/git/actions/runs/2671838770

Ævar Arnfjörð Bjarmason (10):
  CI: run "set -ex" early in ci/lib.sh
  CI: remove more dead Travis CI support
  CI: remove dead "tree skipping" code
  CI: make "$jobname" explicit, remove fallback
  CI/lib.sh: stop adding leading whitespace to $MAKEFLAGS
  CI: consistently use "export" in ci/lib.sh
  CI: export variables via a wrapper
  CI: don't have "git grep" invoke a pager in tree content check
  CI: have "static-analysis" run a "make ci-static-analysis" target
  CI: have "static-analysis" run "check-builtins", not "documentation"

 .github/workflows/main.yml           |  13 +-
 Makefile                             |  32 ++++-
 ci/check-directional-formatting.bash |   2 +-
 ci/lib.sh                            | 200 ++++++++++-----------------
 ci/print-test-failures.sh            |  39 ------
 ci/run-build-and-tests.sh            |  41 +++---
 ci/run-docker-build.sh               |  66 ---------
 ci/run-docker.sh                     |  47 -------
 ci/run-static-analysis.sh            |  34 -----
 ci/run-test-slice.sh                 |   5 -
 ci/test-documentation.sh             |   3 -
 ci/util/extract-trash-dirs.sh        |  50 -------
 shared.mak                           |   1 +
 13 files changed, 135 insertions(+), 398 deletions(-)
 delete mode 100755 ci/run-docker-build.sh
 delete mode 100755 ci/run-docker.sh
 delete mode 100755 ci/run-static-analysis.sh
 delete mode 100755 ci/util/extract-trash-dirs.sh

Range-diff:
 1:  25cb08ad06c !  1:  905a9419267 CI: run "set -ex" early in ci/lib.sh
    @@ Metadata
      ## Commit message ##
         CI: run "set -ex" early in ci/lib.sh
     
    -    Change ci/lib.sh to run "set -ex" before it does anything else, before
    -    this we were omitting a few "export" commands in our trace output that
    -    happened before we enabled tracing.
    +    Change ci/lib.sh to run "set -e" before it does anything else, this
    +    help us to assert that we have no failing commands early on in the
    +    file.
    +
    +    While we're at it let's fix a stray typo in
    +    ecaba2ad4c0 (ci/run-build-and-tests: add some structure to the GitHub
    +    workflow output, 2022-05-21), which seemingly added "#" to the middle
    +    of a line while re-wrapping a comment.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ ci/lib.sh
      
     +# Set 'exit on error' for all CI scripts to let the caller know that
     +# something went wrong.
    -+# Set tracing executed commands, primarily setting environment variables
    -+# and installing dependencies.
    -+set -ex
    ++#
    ++# We'll enable "set -x" below for tracing executed commands, that will
    ++# help to show how environment variables are set and and dependencies
    ++# are installed.
    ++set -e
     +
    - skip_branch_tip_with_tag () {
    - 	# Sometimes, a branch is pushed at the same time the tag that points
    - 	# at the same commit as the tip of the branch is pushed, and building
    -@@ ci/lib.sh: export TERM=${TERM:-dumb}
    - # Clear MAKEFLAGS that may come from the outside world.
    - export MAKEFLAGS=
    + if test true != "$GITHUB_ACTIONS"
    + then
    + 	begin_group () { :; }
    +@@ ci/lib.sh: else
    + 	begin_group "CI setup"
    + fi
      
     -# Set 'exit on error' for all CI scripts to let the caller know that
     -# something went wrong.
    --# Set tracing executed commands, primarily setting environment variables
    --# and installing dependencies.
    --set -ex
    +-#
    +-# We already enabled tracing executed commands earlier. This helps by showing
    +-# how # environment variables are set and and dependencies are installed.
    +-set -e
     -
    - if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
    - then
    - 	CI_TYPE=azure-pipelines
    + skip_branch_tip_with_tag () {
    + 	# Sometimes, a branch is pushed at the same time the tag that points
    + 	# at the same commit as the tip of the branch is pushed, and building
 3:  234e248e831 !  2:  39ef9d2ab6e CI: remove more dead Travis CI support
    @@ ci/lib.sh: then
      	DONT_SKIP_TAGS=t
     @@ ci/lib.sh: then
      	export GIT_PROVE_OPTS="--timer --jobs 10"
    - 	export GIT_TEST_OPTS="--verbose-log -x"
    + 	export GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
      	MAKEFLAGS="$MAKEFLAGS --jobs=10"
     -	test windows != "$CI_OS_NAME" ||
     +	test Windows != "$RUNNER_OS" ||
    @@ ci/run-build-and-tests.sh
     -*) ln -s "$cache_dir/.prove" t/.prove;;
     -esac
     -
    - export MAKE_TARGETS="all test"
    + run_tests=t
      
      case "$jobname" in
     
    @@ ci/run-test-slice.sh
     -*) ln -s "$cache_dir/.prove" t/.prove;;
     -esac
     -
    - make --quiet -C t T="$(cd t &&
    + group "Run tests" make --quiet -C t T="$(cd t &&
      	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
    - 	tr '\n' ' ')"
    + 	tr '\n' ' ')" ||
     
      ## ci/util/extract-trash-dirs.sh (deleted) ##
     @@
 4:  36a6287ee9b !  3:  10ea16766f1 CI: remove dead "tree skipping" code
    @@ Commit message
         runs for already-tested commits/trees, 2020-10-08).
     
         This code hasn't been used since 4a6e4b96026 (CI: remove Travis CI
    -    support, 2021-11-23), and before that for the retired Azure pipeline
    -    support removed in 6081d3898fe (ci: retire the Azure Pipelines
    -    definition, 2020-04-11).
    +    support, 2021-11-23). At one point it was used for the now-removed
    +    Azure Pipelines support. That support was removed in 6081d3898fe (ci:
    +    retire the Azure Pipelines definition, 2020-04-11), but before in
    +    50b206371d2 (travis: remove the hack to build the Windows job on Azure
    +    Pipelines, 2019-02-28) the "save_good_tree" function had not been
    +    called by the Azure Pipelines code.
     
    -    This change is needed because this and subsequent commits are turning
    -    "ci/lib.sh" into a dumber library that'll only be tasked with setting
    -    variables for CI jobs, or for specific steps within those jobs. Now we
    -    don't need to worry about it potentially skipping the run on its own.
    +    Therefore even for those who'd like to resurrect the
    +    azure-pipelines.yml for occasional ad-hoc use (see the thread(s)
    +    starting at [1]) this change should be OK. This code was really only
    +    used for the now-removed Travis CI.
     
         This change also removes a subtle potential logic error introduced in
         0e7696c64db (ci: disallow directional formatting, 2021-11-04). The
    @@ Commit message
         removed. It appears to have been added to appease the subsequent
         'mkdir -p "$cache_dir"', which wasn't needed in GitHub CI.
     
    -    1. https://lore.kernel.org/git/patch-1.1-eec0a8c3164-20211217T000418Z-avarab@gmail.com/
    +    1. https://lore.kernel.org/git/220609.86r13xsj00.gmgdl@evledraar.gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## ci/lib.sh ##
    -@@ ci/lib.sh: then
    - 	exit 1
    +@@ ci/lib.sh: else
    + 	begin_group "CI setup"
      fi
      
     -skip_branch_tip_with_tag () {
    @@ ci/lib.sh: then
     -	exit 0
     -}
     -
    - check_unignored_build_artifacts ()
    - {
    + check_unignored_build_artifacts () {
      	! git ls-files --other --exclude-standard --error-unmatch \
    + 		-- ':/*' 2>/dev/null ||
     @@ ci/lib.sh: if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
      then
      	CI_TYPE=azure-pipelines
    @@ ci/lib.sh: then
     -	CI_JOB_ID="$GITHUB_RUN_ID"
      	CC="${CC_PACKAGE:-${CC:-gcc}}"
     -	DONT_SKIP_TAGS=t
    --
    --	cache_dir="$HOME/none"
    + 	handle_failed_tests () {
    + 		mkdir -p t/failed-test-artifacts
    + 		echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
    +@@ ci/lib.sh: then
    + 		return 1
    + 	}
      
    +-	cache_dir="$HOME/none"
    +-
      	export GIT_PROVE_OPTS="--timer --jobs 10"
    - 	export GIT_TEST_OPTS="--verbose-log -x"
    + 	export GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
    + 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
     @@ ci/lib.sh: else
      	exit 1
      fi
    @@ ci/lib.sh: else
     -skip_branch_tip_with_tag
     -skip_good_tree
     -
    - export DEVELOPER=1
    - export DEFAULT_TEST_TARGET=prove
    - export GIT_TEST_CLONE_2GB=true
    + if test -z "$jobname"
    + then
    + 	jobname="$CI_OS_NAME-$CC"
     
      ## ci/run-build-and-tests.sh ##
    -@@ ci/run-build-and-tests.sh: esac
    - # start running tests.
    - make $MAKE_TARGETS
    +@@ ci/run-build-and-tests.sh: then
    + 	handle_failed_tests
    + fi
      check_unignored_build_artifacts
     -
     -save_good_tree
     
      ## ci/run-static-analysis.sh ##
    -@@ ci/run-static-analysis.sh: fi
    - 
    - make hdr-check ||
    +@@ ci/run-static-analysis.sh: make hdr-check ||
      exit 1
    + 
    + make check-pot
     -
     -save_good_tree
     
 2:  1be7910c728 !  4:  5d1df78d0de CI: make "$jobname" explicit, remove fallback
    @@ Commit message
     
         This makes all of our CI jobs have an explicit $jobname, and removes
         the special-case of the Windows jobs implicitly setting one (that they
    -    don't currently use). In subsequent commits we'll use this new
    -    $jobname explicitly.
    +    don't currently use).
     
         This is a follow-up to my 25715419bf4 (CI: don't run "make test" twice
         in one job, 2021-11-23), since then all the jobs except the Windows
    @@ Commit message
         ci/lib.sh.
     
         Since we'll need this to run ci/lib.sh it makes sense to move the
    -    check to the top of the file. Subsequent commits will add more such
    -    assertions to it.
    +    check to the top of the file.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ .github/workflows/main.yml: jobs:
          needs: [windows-build]
          strategy:
     @@ .github/workflows/main.yml: jobs:
    -         path: ${{env.FAILED_TEST_ARTIFACTS}}
    -   vs-build:
    -     name: win+VS build
    -+    env:
    -+      jobname: vs-build
          needs: ci-config
          if: needs.ci-config.outputs.enabled == 'yes'
          env:
    ++      jobname: vs-build
    +       NO_PERL: 1
    +       GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
    +     runs-on: windows-latest
     @@ .github/workflows/main.yml: jobs:
              path: artifacts
        vs-test:
    @@ .github/workflows/main.yml: jobs:
     
      ## ci/lib.sh ##
     @@
    - # and installing dependencies.
    - set -ex
    + # are installed.
    + set -e
      
     +# Starting assertions
     +if test -z "$jobname"
    @@ ci/lib.sh
     +	exit 1
     +fi
     +
    - skip_branch_tip_with_tag () {
    - 	# Sometimes, a branch is pushed at the same time the tag that points
    - 	# at the same commit as the tip of the branch is pushed, and building
    -@@ ci/lib.sh: test -n "${DONT_SKIP_TAGS-}" ||
    - skip_branch_tip_with_tag
    - skip_good_tree
    + if test true != "$GITHUB_ACTIONS"
    + then
    + 	begin_group () { :; }
    +@@ ci/lib.sh: else
    + 	exit 1
    + fi
      
     -if test -z "$jobname"
     -then
 5:  66b0a383daf <  -:  ----------- CI: remove unused Azure ci/* code
 6:  d96333c1bd8 !  5:  ee36d4eb2a9 CI/lib.sh: stop adding leading whitespace to $MAKEFLAGS
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## ci/lib.sh ##
    -@@ ci/lib.sh: check_unignored_build_artifacts ()
    +@@ ci/lib.sh: handle_failed_tests () {
      # GitHub Action doesn't set TERM, which is required by tput
      export TERM=${TERM:-dumb}
      
    @@ ci/lib.sh: check_unignored_build_artifacts ()
     -export MAKEFLAGS=
     +export MAKEFLAGS=--jobs=$NPROC
      
    - if test "$GITHUB_ACTIONS" = "true"
    + if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
      then
    - 	CI_TYPE=github-actions
    - 	CC="${CC_PACKAGE:-${CC:-gcc}}"
    +@@ ci/lib.sh: then
    + 	# We are running in Azure Pipelines
    + 	CC="${CC:-gcc}"
    + 
    +-	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
    ++	export GIT_PROVE_OPTS="--timer --jobs $NPROC --state=failed,slow,save"
    + 	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
    +-	MAKEFLAGS="$MAKEFLAGS --jobs=10"
    + 	test Windows_NT != "$AGENT_OS" ||
    + 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
    + elif test true = "$GITHUB_ACTIONS"
    +@@ ci/lib.sh: then
    + 		return 1
    + 	}
      
     -	export GIT_PROVE_OPTS="--timer --jobs 10"
     +	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
    - 	export GIT_TEST_OPTS="--verbose-log -x"
    + 	export GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
     -	MAKEFLAGS="$MAKEFLAGS --jobs=10"
      	test Windows != "$RUNNER_OS" ||
      	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
11:  9655bae9e21 !  6:  7cbf8191105 CI: consistently use "export" in ci/lib.sh
    @@ Metadata
      ## Commit message ##
         CI: consistently use "export" in ci/lib.sh
     
    -    Change the "ci/lib.sh" script co consistently use "export", for
    +    Change the "ci/lib.sh" script to consistently use "export", for
         e.g. MAKEFLAGS we were exporting it, and then assigning to it, let's
         do it the other way around.
     
         Right now this doesn't matter, since we in
         e.g. "ci/install-dependencies.sh" source this file, and don't use
    -    something like "env(1)" to retrieve these variables. But in a
    -    subsequent commit we'll "export" these variables through a wrapper (to
    -    additionally write them to a GitHub CI-specific $GITHUB_ENV
    -    file). This change makes that subsequent change easier to read, as it
    -    won't need to do any control flow refactoring.
    +    something like "env(1)" to retrieve these variables.
    +
    +    But in a subsequent commit we'll "export" these variables through a
    +    wrapper (and to eventually write them to a GitHub CI-specific
    +    $GITHUB_ENV file). This change makes that subsequent change easier to
    +    read, as it won't need to do any control flow refactoring.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ ci/lib.sh: export TERM=${TERM:-dumb}
     -export MAKEFLAGS=--jobs=$NPROC
     +MAKEFLAGS=--jobs=$NPROC
      
    - if test "$GITHUB_ACTIONS" = "true"
    + if test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
      then
     @@ ci/lib.sh: then
    - 	CC="${CC_PACKAGE:-${CC:-gcc}}"
    + 	CC="${CC:-gcc}"
    + 
    + 	export GIT_PROVE_OPTS="--timer --jobs $NPROC --state=failed,slow,save"
    +-	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
    ++	GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
    + 	test Windows_NT != "$AGENT_OS" ||
    + 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
    ++	export GIT_TEST_OPTS
    + elif test true = "$GITHUB_ACTIONS"
    + then
    + 	CI_TYPE=github-actions
    +@@ ci/lib.sh: then
    + 	}
      
      	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
    --	export GIT_TEST_OPTS="--verbose-log -x"
    -+	GIT_TEST_OPTS="--verbose-log -x"
    +-	export GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
    ++	GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
      	test Windows != "$RUNNER_OS" ||
      	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
     +	export GIT_TEST_OPTS
    @@ ci/lib.sh: then
      	echo "Could not identify CI type" >&2
      	env >&2
     @@ ci/lib.sh: linux-leaks)
    - 	;;
      esac
      
    --MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
    -+export MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
    + MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
    ++export MAKEFLAGS
    + 
    + end_group
    + set -x
12:  2da0aa1d40e !  7:  e6805874eb9 CI: export variables via a wrapper
    @@ Commit message
         expose what variables we set in what CI "step", so having only the
         ones we actually use will improve readability.
     
    -    To that end call the "setenv" function with optional "--build",
    -    "--test" and "--all" parameters to indicate whether they're needed for
    -    building, testing or both.
    +    To that end call the "setenv" function with optional "--install",
    +    "--build", "--test" and "--all" parameters to indicate whether they're
    +    needed for building, testing or both.
     
         We currently ignore the "varname" parameter, but will make use of it in a
         subsequent commit. Adding it here reduces the needless churn, as we
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## ci/lib.sh ##
    -@@ ci/lib.sh: then
    - 	exit 1
    +@@ ci/lib.sh: else
    + 	begin_group "CI setup"
      fi
      
     +# Helper functions
    @@ ci/lib.sh: then
     +	while test $# != 0
     +	do
     +		case "$1" in
    ++		--install)
    ++			;;
     +		--build)
     +			;;
     +		--test)
    @@ ci/lib.sh: then
     +	val=$2
     +	shift 2
     +
    -+	eval "export $key=\"$val\""
    ++	eval "$key=\"$val\""
    ++	eval "export $key"
     +}
     +
    - check_unignored_build_artifacts ()
    - {
    + check_unignored_build_artifacts () {
      	! git ls-files --other --exclude-standard --error-unmatch \
    -@@ ci/lib.sh: check_unignored_build_artifacts ()
    + 		-- ':/*' 2>/dev/null ||
    +@@ ci/lib.sh: handle_failed_tests () {
      }
      
      # GitHub Action doesn't set TERM, which is required by tput
     -export TERM=${TERM:-dumb}
    -+setenv TERM ${TERM:-dumb}
    ++setenv --all TERM ${TERM:-dumb}
      
      # How many jobs to run in parallel?
      NPROC=10
     @@ ci/lib.sh: then
    + 	# We are running in Azure Pipelines
    + 	CC="${CC:-gcc}"
    + 
    +-	export GIT_PROVE_OPTS="--timer --jobs $NPROC --state=failed,slow,save"
    ++	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC --state=failed,slow,save"
    + 	GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
    + 	test Windows_NT != "$AGENT_OS" ||
    + 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
    +-	export GIT_TEST_OPTS
    ++	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
    + elif test true = "$GITHUB_ACTIONS"
    + then
      	CI_TYPE=github-actions
    - 	CC="${CC_PACKAGE:-${CC:-gcc}}"
    +@@ ci/lib.sh: then
    + 		return 1
    + 	}
      
     -	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
     +	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
    - 	GIT_TEST_OPTS="--verbose-log -x"
    + 	GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
      	test Windows != "$RUNNER_OS" ||
      	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
     -	export GIT_TEST_OPTS
    @@ ci/lib.sh: ubuntu-latest)
      	fi
      
     -	export GIT_TEST_HTTPD=true
    ++	setenv --test GIT_TEST_HTTPD true
    + 
    + 	# The Linux build installs the defined dependency versions below.
    + 	# The OS X build installs much more recent versions, whichever
    + 	# were recorded in the Homebrew database upon creating the OS X
    + 	# image.
    + 	# Keep that in mind when you encounter a broken OS X build!
    +-	export LINUX_P4_VERSION="16.2"
    +-	export LINUX_GIT_LFS_VERSION="1.5.2"
    ++	setenv --install LINUX_P4_VERSION "16.2"
    ++	setenv --install LINUX_GIT_LFS_VERSION "1.5.2"
    + 
    +-	P4_PATH="$HOME/custom/p4"
    +-	GIT_LFS_PATH="$HOME/custom/git-lfs"
    +-	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
    ++	setenv --install P4_PATH "$HOME/custom/p4"
    ++	setenv --install GIT_LFS_PATH "$HOME/custom/git-lfs"
    ++	setenv --all PATH "$GIT_LFS_PATH:$P4_PATH:$PATH"
     +	setenv --test GIT_TEST_HTTPD true
      	;;
      macos-latest)
    @@ ci/lib.sh: linux-musl)
      	;;
      esac
      
    --export MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
    -+setenv --all MAKEFLAGS "$MAKEFLAGS CC=${CC:-cc}"
    + MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
    +-export MAKEFLAGS
    ++setenv --all MAKEFLAGS "$MAKEFLAGS"
    + 
    + end_group
    + set -x
     
      ## ci/run-build-and-tests.sh ##
    -@@ ci/run-build-and-tests.sh: export MAKE_TARGETS="all test"
    +@@ ci/run-build-and-tests.sh: run_tests=t
      
      case "$jobname" in
      linux-gcc)
    @@ ci/run-build-and-tests.sh: export MAKE_TARGETS="all test"
     -	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
     -	export GIT_TEST_MULTI_PACK_INDEX=1
     -	export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
    --	export GIT_TEST_ADD_I_USE_BUILTIN=1
    +-	export GIT_TEST_ADD_I_USE_BUILTIN=0
     -	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     -	export GIT_TEST_WRITE_REV_INDEX=1
     -	export GIT_TEST_CHECKOUT_WORKERS=2
    @@ ci/run-build-and-tests.sh: export MAKE_TARGETS="all test"
     +	setenv --test GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS 1
     +	setenv --test GIT_TEST_MULTI_PACK_INDEX 1
     +	setenv --test GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP 1
    -+	setenv --test GIT_TEST_ADD_I_USE_BUILTIN 1
    ++	setenv --test GIT_TEST_ADD_I_USE_BUILTIN 0
     +	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME master
     +	setenv --test GIT_TEST_WRITE_REV_INDEX 1
     +	setenv --test GIT_TEST_CHECKOUT_WORKERS 2
    @@ ci/run-build-and-tests.sh: export MAKE_TARGETS="all test"
      	# built.
     -	export DEVOPTS=pedantic
     +	setenv --build DEVOPTS pedantic
    - 	export MAKE_TARGETS=all
    + 	run_tests=
      	;;
      esac
 7:  d0780ab4a96 =  8:  8bcaeb1dd79 CI: don't have "git grep" invoke a pager in tree content check
 8:  84e368736e2 !  9:  95b9c3797c0 CI: have "static-analysis" run a "make ci-static-analysis" target
    @@ Commit message
     
         But without those improvements being able to easily run a 1=1
         equivalent of the checks we do in CI during a local build is already
    -    an improvement. Subsequent commits will expand on this ability.
    +    an improvement.
     
         This change will also make the CI check faster, since we can take
    -    advantage of parallelism. The "make coccicheck" takes a very long
    -    time, and at the tail end we might only have one job pegging 100% of
    -    one CPU core for a long time. Now any extra cores will be free to run
    -    the rest of the targets under "ci-static-analysis".
    +    advantage of parallelism across these "make" invocations. The "make
    +    coccicheck" command in particular takes a long to finish its last job,
    +    at the end we might only have one job pegging 100% of one CPU
    +    core. Now any extra cores will be free to run the rest of the targets
    +    under "ci-static-analysis".
    +
    +    Because we're now going to invoke "make" directly from the CI recipe
    +    we'll need to amend the new "setenv" wrapper to write the "MAKEFLAGS"
    +    and other variables to "$GITHUB_ENV".
    +
    +    In my testing the "static-analysis" job runs in just over 10 minutes
    +    without this change, but this change cuts just over a minute off the
    +    runtime.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
    +     runs-on: ubuntu-18.04
          steps:
          - uses: actions/checkout@v2
    ++    - run: ci/lib.sh
    ++      env:
    ++        NO_CI_GROUPS: 1
          - run: ci/install-dependencies.sh
     -    - run: ci/run-static-analysis.sh
     -    - run: ci/check-directional-formatting.bash
    @@ Makefile: $(FUZZ_PROGRAMS): all
     +ci-static-analysis: ci-check-directional-formatting
     +ci-static-analysis: check-coccicheck
     +ci-static-analysis: hdr-check
    ++ci-static-analysis: check-pot
    +
    + ## ci/lib.sh ##
    +@@ ci/lib.sh: then
    + 	exit 1
    + fi
    + 
    +-if test true != "$GITHUB_ACTIONS"
    ++if test true != "$GITHUB_ACTIONS" || test -n "$NO_CI_GROUPS"
    + then
    + 	begin_group () { :; }
    + 	end_group () { :; }
    +@@ ci/lib.sh: setenv () {
    + 
    + 	eval "$key=\"$val\""
    + 	eval "export $key"
    ++	eval "export $key=\"$val\""
    ++	if test -n "$GITHUB_ENV"
    ++	then
    ++		echo "$key=$val" >>"$GITHUB_ENV"
    ++	fi
    + }
    + 
    + check_unignored_build_artifacts () {
     
      ## ci/run-static-analysis.sh (deleted) ##
     @@
    @@ ci/run-static-analysis.sh (deleted)
     -
     -make hdr-check ||
     -exit 1
    +-
    +-make check-pot
     
      ## shared.mak ##
     @@ shared.mak: ifndef V
    - 	QUIET_HDR      = @echo '   ' HDR $(<:hcc=h);
    - 	QUIET_RC       = @echo '   ' RC $@;
    - 	QUIET_SPATCH   = @echo '   ' SPATCH $<;
    + ## Used in "Makefile"
    + 	QUIET_CC       = @echo '   ' CC $@;
    + 	QUIET_AR       = @echo '   ' AR $@;
     +	QUIET_CHECK    = @echo '   ' CHECK $@;
    - 
    - ## Used in "Documentation/Makefile"
    - 	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
    + 	QUIET_LINK     = @echo '   ' LINK $@;
    + 	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
    + 	QUIET_LNCP     = @echo '   ' LN/CP $@;
 9:  1a9c98b909c ! 10:  5ef362505c1 CI: have "static-analysis" run "check-builtins", not "documentation"
    @@ Makefile: ci-check-directional-formatting:
     +ci-static-analysis: check-builtins
      ci-static-analysis: check-coccicheck
      ci-static-analysis: hdr-check
    + ci-static-analysis: check-pot
     
      ## ci/test-documentation.sh ##
     @@ ci/test-documentation.sh: filter_log () {
10:  e208a9ab1e2 <  -:  ----------- CI: move p4 and git-lfs variables to ci/install-dependencies.sh
13:  6e97633652e <  -:  ----------- CI: remove "run-build-and-tests.sh", run "make [test]" directly
14:  0488e29859b <  -:  ----------- CI: make ci/{lib,install-dependencies}.sh POSIX-compatible
15:  f7ac6c33044 <  -:  ----------- CI: check ignored unignored build artifacts in "win[+VS] build" too
16:  f89346f11eb <  -:  ----------- CI: invoke "make artifacts-tar" directly in windows-build
17:  7fa9c69e3ca <  -:  ----------- CI: split up and reduce "ci/test-documentation.sh"
18:  7925b2610fc <  -:  ----------- CI: combine ci/install{,-docker}-dependencies.sh
19:  b00abc07637 <  -:  ----------- CI: move "env" definitions into ci/lib.sh
20:  bb5960355fe <  -:  ----------- ci/run-test-slice.sh: replace shelling out with "echo"
21:  1eeb2e8e7f0 <  -:  ----------- CI: pre-select test slice in Windows & VS tests
22:  39979d9887d <  -:  ----------- CI: only invoke ci/lib.sh as "steps" in main.yml
23:  e2b3bf032d6 <  -:  ----------- CI: narrow down variable definitions in --build and --test
24:  c6f47d52823 <  -:  ----------- CI: add more variables to MAKEFLAGS, except under vs-build
25:  377460e8024 <  -:  ----------- CI: set CC in MAKEFLAGS directly, don't add it to the environment
26:  98e320d5e67 <  -:  ----------- CI: set SANITIZE=leak in MAKEFLAGS directly
27:  282b7c89a4f <  -:  ----------- CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
28:  7a208927819 <  -:  ----------- CI: don't use "set -x" in "ci/lib.sh" output
29:  4d8a8f3be07 <  -:  ----------- CI: make it easy to use ci/*.sh outside of CI
-- 
2.37.1.996.g651fc6e809f

