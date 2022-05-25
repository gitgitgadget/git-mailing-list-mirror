Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B82AC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241527AbiEYL0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiEYL0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:26:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BE2972B6
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso3149290wmn.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Z15Ou0oa6mXu5Sx/V3eSZLPmK9tsdZ3chiYA1dOtEs=;
        b=QmGJNAuQFWDGNICRyApWPQ+iYHmVxW3jFhKBWQTom7j4QpDyCf712DMvxKZphmQHaO
         1WGOzJA9QthrB0OvatRUBjQGjucnsei8X27UwC5sA8tbKhdGX8YhF0wqf/ls0UcPq0oD
         Ux7ZJoZHuJP6rH7pjeg+QD/iN9IC3sX4igoQLClh23DyMrczkO9WsWvTgLiQ6SbSmhu6
         Bm8yJEhDfDe7tDbLRB+KSkpWBJkSZXoZGl8t1jWErHYrb2M5wZjy3z+q5xLgMkw82RpU
         CwQW4SoXMEodUNu/zOK3SkGK57mW+wtBMXR4hPOkz8YcObJaLXNa9DxNhIIWQKuZ4D0E
         n+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Z15Ou0oa6mXu5Sx/V3eSZLPmK9tsdZ3chiYA1dOtEs=;
        b=YVq5pnHvQz0gfvkcnit1LAys59FjOZSukIQx0mzv3DAOG9TLyOCvgqqDDFWPDVLS+Z
         anFO/amGt/DY9xDRIocsKxjJ0Xe431v5nrqmx9qvFpp1XMRGTXBkGbQtXej7rOUQGN+s
         jFtOafHRx18pIrfeFyK2gf7VIeZ7dzfK/ly68UF0Vp3CYtQrboBqEwxwg8nfH7NvBqD6
         ZcT7x2Z/3N8w2TwWj1WPRMVOfKdwwYFwfwCNAtq89p016iM58V6gyq4GIynCivkWUtxW
         YzqYLd60kM9PdfdhKrsvSO6QaSVNTSLtJ4VRNhGIXMh08pxjkfkPDdsPJTGnctHfNMBc
         7GRg==
X-Gm-Message-State: AOAM530mkAUbtPsa+M83SFKeMkTSMC8bR/bQMKTkW9NHCFvX0X7nbQVb
        sLWSeb7A1OncD4HDpjX8A0HYdBFV0cd3SA==
X-Google-Smtp-Source: ABdhPJx2e66bbq+bK7poOwwNQUSE7I1xTwRm7FebBSZE8YmFDw5G7xeA/ZfxKHg/OJknETA3HWqu4w==
X-Received: by 2002:a05:600c:3b2a:b0:397:3e63:3db8 with SMTP id m42-20020a05600c3b2a00b003973e633db8mr7651148wms.40.1653477980018;
        Wed, 25 May 2022 04:26:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0020d0dfcd10asm1851095wrh.65.2022.05.25.04.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:26:19 -0700 (PDT)
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
Subject: [PATCH v6 00/14] CI: js/ci-github-workflow-markup rebased on "use $GITHUB_ENV"
Date:   Wed, 25 May 2022 13:25:49 +0200
Message-Id: <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
References: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This non-RFC re-roll of [1] is based on the just-re-rolled [2]
(hereafter "base") and proposes to replace [3]. It incorporates the
relevant parts of [3] that were new in that re-roll.

Before getting into the details it's helpful to open the following
links:

  master: https://github.com/avar/git/actions/runs/2377697338
  js: https://github.com/avar/git/actions/runs/2377281297
  base: https://github.com/avar/git/actions/runs/2377257487
  this: https://github.com/avar/git/actions/runs/2383110429
  this with 'raw': https://github.com/avar/git/actions/runs/2383134850

These are all versions of the relevant branches in play with the same
commit on top to trigger CI failures. The "master" and "base" are the
same as those noted in [2], the "js" is [3] (but rebased on master),
and "this" is this topic. The "this with 'raw'" is this topic, but
configured to omit the new GitHub CI Markdown output (see 13/14 and
14/14).

Having these open allows us to compare the output and performance of
these different proposed CI topics. Here clicking on e.g. linux-sha256
(which has a verbose test failure) will on these topics on in the
Chrome debugger[4].

  master: https://github.com/avar/git/runs/6573058614?check_suite_focus=true
  262 ms  Loading
  3977 ms  Scripting
  1632 ms  Rendering
  641 ms  Painting
  934 ms  System
  920 ms  Idle
  8366 ms  Total

  js: https://github.com/avar/git/runs/6571972194?check_suite_focus=true
  170 ms  Loading
  12934 ms  Scripting
  7364 ms  Rendering
  6940 ms  Painting
  5489 ms  System
  5940 ms  Idle
  38836 ms  Total

  base: https://github.com/avar/git/runs/6571804381?check_suite_focus=true
  215 ms  Loading
  3270 ms  Scripting
  1171 ms  Rendering
  649 ms  Painting
  941 ms  System
  731 ms  Idle
  6976 ms  Total

  this: https://github.com/avar/git/runs/6588407676?check_suite_focus=true
  201 ms  Loading
  9192 ms  Scripting
  6104 ms  Rendering
  5553 ms  Painting
  4684 ms  System
  6184 ms  Idle
  31917 ms  Total

  this with 'raw': https://github.com/avar/git/runs/6588579493?check_suite_focus=true
  173 ms  Loading
  3036 ms  Scripting
  1110 ms  Rendering
  617 ms  Painting
  1028 ms  System
  714 ms  Idle
  6678 ms  Total

As noted in previous performance testing [5] what these results
indicate is that the more output you put under GitHub CI's "groups"
the slower it will get. With the "js" variant in particular it can be
seen to struggle to render as you're watching it.

It's faster with "this" because there's less rendering to be done. Due
to the changes in the "base" topic to make "make" and "make test"
top-level commands we can run there's less data in the step where we
need to print failures in detail.

So re: [6] this shows how the two serieses are complimentary and make
the overall CI UX better when combined than stand-alone.

Changes since the RFC v5:

 * Incorporated the v3[3] of js/ci-github-workflow-markup.

 * Applied fix-up to get rid of broken
   ci/print-test-failures-github.sh (which didn't exist anymore)

 * The v5 of this series had an issue where we'd "zoom in" on the
   "make test" output, instead of the new GitHub CI markdown
   output. We now combine the best of both worlds. We'll have a "make
   test" and "ci/print-test-failures.sh" steps, both of which fail,
   but we'll "zoom in" on the latter, which contains the new output.

 * As before this series applied some DRY principles to the code [7]
   proposed to add, i.e. the "handle_failed_tests" was a
   near-duplication of the code in
   ci/print-test-failures-github.sh. The 01-03/14 here allow us to
   unify the two & share the code instead.

   My RFC v5 had some options we didn't need (--exit-code and
   --no-exit-code) that I removed. It furthermore defaults to "auto"
   discovering if we should emit the GitHub CI *.markup output based
   on if we find those files in t/test-results, which as we'll see in
   13-14/14 makes configuring the output simpler.

 * Due to the above and other changes here being smaller the "ci: make
   it easier to find failed tests' logs in the GitHub workflow" here
   is now a squashed version of changes done in several steps in
   [3]. We now add the ability to emit GitHub CI markup in one commit,
   and enable it in another.

 * In the latest "js" topic the "ok" tests were skipped, but we'd
   still include "skip" tests, i.e. "not ok .. TODO" tests. These
   should be considered "ok" for the purposes of the output, so a new
   09/14 here excludes them too.

 * An updated commit message for 10/14 notes a subtle and presumably
   unintended side-effect/bug in "ci(github): avoid printing test case
   preamble twice" new in the v3 of [3]. In tweaking the *.markup
   files we also change the output in the *.out files (i.e. the raw
   logs).

   You thus won't get the same output in *.out (the raw logs) with the
   new output.

 * New 13/14 and 14/14 commits here make the CI output type
   configurable using the same "ci-config" method we use for the
   existing "check-ref". As explained in 14/14 this is what I'm using
   to produce "this with 'raw'" output the same commit as "this". I
   push to a branch whose name ends with "_CI_OUT_RAW".

   This allows users (such as me, or per 13/14 probably SZEDER too) to
   configure our output to avoid this GitHub markdown in our
   ci-config.

 * As 13/14 argues for I think a better thing to do would be to avoid
   14/14 for now and take this series without making the new "github"
   output the default.

   But in the interest of not conflating that with this proposed
   re-roll 14/14 changes the default from "raw" to "github" again,
   thus making the output [3] is proposing the default here too.

   We can always revert 14/14 later if we think that was premature,
   which as shown there is now a one-line change.

To continue from the last note above: This series also allows for
combining the new & old output in a way where we can have our cake &
eat it too. If we load the "this" output and "zoom in" on the failed
"make test" step instead of the subsequent "ci/print-test-failures.sh"
step we'll load the page in around 1/6 the time, or:

  this (zoomed in on 'make test'): https://github.com/avar/git/runs/6588407676?check_suite_focus=true#step:7:1437
  149 ms  Loading
  2559 ms  Scripting
  934 ms  Rendering
  591 ms  Painting
  845 ms  System
  605 ms  Idle
  5684 ms  Total

Clicking on the "ci/print-test-failures.sh" will then take just as
long. I haven't implemented this as a configurable feature is just a
matter of making ci/print-test-failures.sh exit with 0 where it now
exits with 1 (as we always "zoom in" on the last failed step, which
then will be "make test").

For Junio:

If you eject js/ci-github-workflow-markup you'll get a minor conflict
(as before) with js/use-builtin-add-i, and a new conflict with
jx/l10n-workflow-change. The correct resolution is to "git rm
ci/run-build-and-tests.sh ci/run-static-analysis.sh" and apply this
diff on top:

	diff --git a/Makefile b/Makefile
	index b602bdaed4a..984b1a1905d 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -3625,3 +3625,4 @@ ci-static-analysis: ci-check-directional-formatting
	 ci-static-analysis: check-builtins
	 ci-static-analysis: check-coccicheck
	 ci-static-analysis: hdr-check
	+ci-static-analysis: check-pot
	diff --git a/ci/lib.sh b/ci/lib.sh
	index b148d3f209f..c6b17b4cb22 100755
	--- a/ci/lib.sh
	+++ b/ci/lib.sh
	@@ -282,7 +282,7 @@ linux-TEST-vars)
	 	setenv --test GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS 1
	 	setenv --test GIT_TEST_MULTI_PACK_INDEX 1
	 	setenv --test GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP 1
	-	setenv --test GIT_TEST_ADD_I_USE_BUILTIN 1
	+	setenv --test GIT_TEST_ADD_I_USE_BUILTIN 0
	 	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME master
	 	setenv --test GIT_TEST_WRITE_REV_INDEX 1
	 	setenv --test GIT_TEST_CHECKOUT_WORKERS 2


1. https://lore.kernel.org/git/RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com/
3. https://lore.kernel.org/git/pull.1117.v3.git.1653171536.gitgitgadget@gmail.com/
4. Version 101.0.4951.54 (Official Build) (64-bit). Opening the
   debugger in an empty tab (F12), going to "Performance" and
   recording a trace (Ctrl+E) (note: *not* Ctrl+Shift+E, as that would
   end it after network load, but before rendering is done & the page
   is ready to interact with).

   The "Total" times here are "real" and don't very with how fast I am
   to "stop" the trace (tested by leaving it lingering for a long
   time).
5. https://lore.kernel.org/git/220523.86ee0kzjix.gmgdl@evledraar.gmail.com/
6. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2205232040130.352@tvgsbejvaqbjf.bet/
7. https://lore.kernel.org/git/417f702a2454316f0bdc5b66eb16751272ff2989.1653171536.git.gitgitgadget@gmail.com/

Johannes Schindelin (6):
  tests: refactor --write-junit-xml code
  test(junit): avoid line feeds in XML attributes
  ci: optionally mark up output in the GitHub workflow
  ci(github): skip the logs of the successful test cases
  ci(github): mention where the full logs can be found
  ci: call `finalize_test_case_output` a little later

Victoria Dye (1):
  ci(github): avoid printing test case preamble twice

Ævar Arnfjörð Bjarmason (7):
  CI: don't "cd" in ci/print-test-failures.sh
  CI: don't include "test-results/" in ci/print-test-failures.sh output
  CI: stop setting FAILED_TEST_ARTIFACTS N times
  ci: make it easier to find failed tests' logs in the GitHub workflow
  ci(github): skip "skip" tests in --github-workflow-markup
  CI: make --github-workflow-markup ci-config, off by default
  CI: make the --github-workflow-markup "github" output the default

 .github/workflows/main.yml           |  24 +++++
 ci/lib.sh                            |  12 +++
 ci/print-test-failures.sh            | 100 ++++++++++++++++----
 t/test-lib-functions.sh              |   6 +-
 t/test-lib-github-workflow-markup.sh |  56 ++++++++++++
 t/test-lib-junit.sh                  | 132 +++++++++++++++++++++++++++
 t/test-lib.sh                        | 128 ++++----------------------
 7 files changed, 332 insertions(+), 126 deletions(-)
 create mode 100644 t/test-lib-github-workflow-markup.sh
 create mode 100644 t/test-lib-junit.sh

Range-diff against v5:
 1:  56910df26e7 =  1:  c10a11fdae8 CI: don't "cd" in ci/print-test-failures.sh
 3:  577a5be34f4 =  2:  1d07ca58322 CI: don't include "test-results/" in ci/print-test-failures.sh output
 4:  1482f840f64 !  3:  fdc5b534644 CI: stop setting FAILED_TEST_ARTIFACTS N times
    @@ ci/print-test-failures.sh: do
      			cp "t/test-results/${TEST_OUT}" t/failed-test-artifacts/
      			(
      				cd t &&
    -@@ ci/print-test-failures.sh: done
    - 
    - if test -n "$failed"
    - then
    +@@ ci/print-test-failures.sh: do
    + 		esac
    + 	fi
    + done
    ++
    ++if test -n "$failed"
    ++then
     +	if test -n "$GITHUB_ENV"
     +	then
     +		echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
     +	fi
    -+
    - 	if test -n "$exit_code"
    - 	then
    - 		exit 1
    ++fi
 6:  d9b7d5ddf5a =  4:  a75846a12f2 tests: refactor --write-junit-xml code
 7:  2d233bbdc22 =  5:  5b709dde86a test(junit): avoid line feeds in XML attributes
 8:  5dd43a1624b =  6:  f5b39f1660d ci: optionally mark up output in the GitHub workflow
 2:  caec0b1089a !  7:  e713ca6041b CI: add --exit-code to ci/print-test-failures.sh
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    CI: add --exit-code to ci/print-test-failures.sh
    +    ci: make it easier to find failed tests' logs in the GitHub workflow
     
    -    The ci/print-test-failures.sh scripts will exit 0 when there's failed
    -    tests, let's teach it --exit-code to have it exit non-zero in those
    -    cases.
    +    When investigating a test failure, the time that matters most is the
    +    time it takes from getting aware of the failure to displaying the output
    +    of the failing test case.
     
    +    You currently have to know a lot of implementation details when
    +    investigating test failures in the CI runs. The first step is easy: the
    +    failed job is marked quite clearly, but when opening it, the failed step
    +    is expanded, which in our case is the one running
    +    `make` or 'make test`. When failing in the latter we only show a
    +    high-level view of what went wrong: it prints the output of `prove`
    +    which merely tells the reader which test script failed, along with the failed
    +    test numbers.
    +
    +    To diagnose those failures in detail the user has then had to know
    +    that they should expand the subsequent "Run ci/print-test-failures.sh"
    +    step. Because that step always exits successfully it's not expanded by
    +    default (the GitHub CI only expands the last failing step), making it
    +    easy to miss that there is useful information hidden in there.
    +
    +    This change does a couple of things to improve the situation:
    +
    +     * We now make use of the "exit code" feature of
    +       ci/print-test-failures.sh added in a preceding commit, thus if "make
    +       test" fails we'll pick up that we have failing tests, and fail in
    +       ci/print-test-failures.sh too.
    +
    +       Note that we still exit successfully from ci/print-test-failures.sh
    +       if we don't have logs of any failed tests in t/test-results. Thus
    +       if we fail in "make" (i.e. when building), or even in "make test"
    +       in a way that doesn't yield a failed test (e.g. the t/Makefile
    +       itself failing) we'll correctly "zoom in" on the (hopefully
    +       failing) "make test" instead.
    +
    +       As before if there was no previously failed step the
    +       ci/print-test-failures.sh step is skipped entirely (see
    +       .github/workflows/main.yml)
    +
    +       To make the script DWYM the ci/print-test-failures.sh defaults to
    +       an "auto" mode. Thus since we turn on --github-workflow-markup in
    +       ci/lib.sh we'll write *.markup files, and will pick up on that in
    +       ci/print-test-failures.sh.
    +
    +       The "$github_workflow_markup" being "auto" (or "t") on failure is
    +       also what makes us exit non-zero. We could also add
    +       --[no-]exit-code arguments, but at this point we only need this for
    +       the "*.markup" mode, so let's leave that for now.
    +
    +       By having this be "auto" well pick up on whatever the GIT_TEST_OPTS
    +       setting is, which as we'll see in a subsequent commit will be
    +       useful if we'd like to configure the CI to emit it only some of the
    +       time.
    +
    +     * The ci/print-test-failures.sh now makes use of the GitHub markdown
    +       introduced for t/test-lib.sh in the preceding commit. I.e. in GitHub
    +       CI we'll now run with --github-workflow-markup in GIT_TEST_OPTS,
    +       which causes our "--verbose" output in
    +       "t/test-results/$TEST_OUT.markup" to be in the GitHub CI-specific
    +       Markdown format.
    +
    +    The new output is easier to read since it makes use of collapsible grouping.
    +    Initially, readers will see the high-level view of what actually happened.
    +    To drill down, the "group" for the specific failing test(s) can be expanded.
    +
    +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## ci/lib.sh ##
    +@@ ci/lib.sh: MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
    + case "$CI_TYPE" in
    + github-actions)
    + 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
    +-	GIT_TEST_OPTS="--verbose-log -x"
    ++	GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
    + 	test Windows != "$RUNNER_OS" ||
    + 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
    + 	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
    +
      ## ci/print-test-failures.sh ##
     @@ ci/print-test-failures.sh: set -e
      . ${0%/*}/lib-ci-type.sh
      . ${0%/*}/lib-tput.sh
      
    -+exit_code=
    ++github_workflow_markup=auto
    ++case "$CI_TYPE" in
    ++github-actions)
    ++	github_workflow_markup=t
    ++	;;
    ++esac
    ++
     +while test $# != 0
     +do
     +	case "$1" in
    -+	--exit-code)
    -+		exit_code=t
    ++	--github-workflow-markup)
    ++		github_workflow_markup=t
    ++		;;
    ++	--no-github-workflow-markup)
    ++		github_workflow_markup=
     +		;;
     +	*)
     +		echo "BUG: invalid $0 argument: $1" >&2
    @@ ci/print-test-failures.sh: set -e
      		TEST_NAME="${TEST_EXIT%.exit}"
      		TEST_NAME="${TEST_NAME##*/}"
      		TEST_OUT="${TEST_NAME}.out"
    -@@ ci/print-test-failures.sh: do
    - 		esac
    + 		TEST_MARKUP="${TEST_NAME}.markup"
    + 
    +-		echo "------------------------------------------------------------------------"
    +-		echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
    +-		echo "------------------------------------------------------------------------"
    +-		cat "t/test-results/${TEST_OUT}"
    ++		do_markup=
    ++		case "$github_workflow_markup" in
    ++		t)
    ++			do_markup=t
    ++			;;
    ++		auto)
    ++			if test -f "t/test-results/$TEST_MARKUP"
    ++			then
    ++				do_markup=t
    ++			fi
    ++			;;
    ++		esac
    ++
    ++		if test -n "$do_markup"
    ++		then
    ++			printf "\\e[33m\\e[1m=== Failed test: ${TEST_NAME} ===\\e[m\\n"
    ++			cat "t/test-results/$TEST_MARKUP"
    ++		else
    ++			echo "------------------------------------------------------------------------"
    ++			echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
    ++			echo "------------------------------------------------------------------------"
    ++			cat "t/test-results/${TEST_OUT}"
    ++		fi
    + 
    + 		trash_dir="trash directory.$TEST_NAME"
    + 		case "$CI_TYPE" in
    +@@ ci/print-test-failures.sh: then
    + 	then
    + 		echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
      	fi
    - done
     +
    -+if test -n "$failed"
    -+then
    -+	if test -n "$exit_code"
    -+	then
    ++	case "$github_workflow_markup" in
    ++	t|auto)
     +		exit 1
    -+	fi
    -+fi
    ++		;;
    ++	'')
    ++		exit 0
    ++		;;
    ++	esac
    + fi
 -:  ----------- >  8:  9c9fd24fffa ci(github): skip the logs of the successful test cases
 -:  ----------- >  9:  03d7b54d68b ci(github): skip "skip" tests in --github-workflow-markup
 -:  ----------- > 10:  90a152d79f9 ci(github): avoid printing test case preamble twice
 9:  877edff3b4d ! 11:  68eed85162b ci: use `--github-workflow-markup` in the GitHub workflow
    @@ Metadata
     Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
     
      ## Commit message ##
    -    ci: use `--github-workflow-markup` in the GitHub workflow
    +    ci(github): mention where the full logs can be found
     
    -    [Ævar: due to re-structuring on top of my series the {begin,end}_group
    -    in CI isn't needed at all to get "group" output for the test
    -    suite. This commit includes the now-squashed "ci/run-build-and-tests:
    -    add some structure to the GitHub workflow output":]
    -
    -    The current output of Git's GitHub workflow can be quite confusing,
    -    especially for contributors new to the project.
    -
    -    To make it more helpful, let's introduce some collapsible grouping.
    -    Initially, readers will see the high-level view of what actually
    -    happened (did the build fail, or the test suite?). To drill down, the
    -    respective group can be expanded.
    -
    -    Note: sadly, workflow output currently cannot contain any nested groups
    -    (see https://github.com/actions/runner/issues/802 for details),
    -    therefore we take pains to ensure to end any previous group before
    -    starting a new one.
    -
    -    [Ævar: The above comment isn't true anymore, as that limitation has
    -    been removed by basing this on my patches to run "make" and "make
    -    test" directly from the top-level of main.yml.
    -
    -    Those are now effectively their own "group", effectively giving this
    -    stage another group "level" to use. This means that the equivalent of
    -    "make test" won't be on the same level as an individual test failure.
    -
    -    We no longer take any pains to ensure balanced group output as a
    -    result (which was a caveat the previous ci/lib.sh implementation had
    -    to deal with., We just need to "cat" the generated *.markup]
    +    The full logs are contained in the `failed-tests-*.zip` artifacts that
    +    are attached to the failed CI run. Since this is not immediately
    +    obvious to the well-disposed reader, let's mention it explicitly.
     
    +    Suggested-by: Victoria Dye <vdye@github.com>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## ci/lib.sh ##
    -@@ ci/lib.sh: MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
    - case "$CI_TYPE" in
    - github-actions)
    - 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
    --	GIT_TEST_OPTS="--verbose-log -x"
    -+	GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
    - 	test Windows != "$RUNNER_OS" ||
    - 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
    - 	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
    -
      ## ci/print-test-failures.sh ##
     @@ ci/print-test-failures.sh: do
    - 		if test -n "$github_workflow_markup"
    + 		if test -n "$do_markup"
      		then
      			printf "\\e[33m\\e[1m=== Failed test: ${TEST_NAME} ===\\e[m\\n"
    -+			cat "t/test-results/$TEST_MARKUP"
    ++			echo "The full logs are in the artifacts attached to this run."
    + 			cat "t/test-results/$TEST_MARKUP"
      		else
      			echo "------------------------------------------------------------------------"
    - 			echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
    - 			echo "------------------------------------------------------------------------"
    -+			cat "t/test-results/${TEST_OUT}"
    - 		fi
    --		cat "t/test-results/${TEST_OUT}"
    - 
    - 		trash_dir="trash directory.$TEST_NAME"
    - 		case "$CI_TYPE" in
10:  6b278194f9a = 12:  11dab84b0dc ci: call `finalize_test_case_output` a little later
 5:  4291892fbd3 ! 13:  fbe0d99c6b3 ci: make it easier to find failed tests' logs in the GitHub workflow
    @@
      ## Metadata ##
    -Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
    +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    ci: make it easier to find failed tests' logs in the GitHub workflow
    -
    -    When investigating a test failure, the time that matters most is the
    -    time it takes from getting aware of the failure to displaying the output
    -    of the failing test case.
    -
    -    You currently have to know a lot of implementation details when
    -    investigating test failures in the CI runs. The first step is easy: the
    -    failed job is marked quite clearly, but when opening it, the failed step
    -    is expanded, which in our case is the one running
    -    `ci/run-build-and-tests.sh`. This step, most notably, only offers a
    -    high-level view of what went wrong: it prints the output of `prove`
    -    which merely tells the reader which test script failed.
    -
    -    The actually interesting part is in the detailed log of said failed
    -    test script. But that log is shown in the CI run's step that runs
    -    `ci/print-test-failures.sh`. And that step is _not_ expanded in the web
    -    UI by default. It is even marked as "successful", which makes it very
    -    easy to miss that there is useful information hidden in there.
    -
    -    Let's help the reader by showing the failed tests' detailed logs in the
    -    step that is expanded automatically, i.e. directly after the test suite
    -    failed.
    -
    -    This also helps the situation where the _build_ failed and the
    -    `print-test-failures` step was executed under the assumption that the
    -    _test suite_ failed, and consequently failed to find any failed tests.
    -
    -    An alternative way to implement this patch would be to source
    -    `ci/print-test-failures.sh` in the `handle_test_failures` function to
    -    show these logs. However, over the course of the next few commits, we
    -    want to introduce some grouping which would be harder to achieve that
    -    way (for example, we do want a leaner, and colored, preamble for each
    -    failed test script, and it would be trickier to accommodate the lack of
    -    nested groupings in GitHub workflows' output).
    -
    -    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    CI: make --github-workflow-markup ci-config, off by default
    +
    +    In preceding commits the --github-workflow-markup output was made the
    +    default under GitHub CI.
    +
    +    There's a few outstanding issues with that new output target however:
    +
    +    A. As noted in [1] it's much slower in some common cases, i.e. the
    +       page rendering time (under Firefox & Chrome debugging) goes from ~20s
    +       to on the order of 60-80s (less pronounced when not debugging, but
    +       still in that ballpark). See also [2] for tests on an earlier iteration
    +       of the series.
    +
    +    B. Preceding commits in this series to omit non-failing test output
    +       may have mitigated that somewhat, i.e. skipping "ok" and "skip" tests
    +       in the *.markup files (although [1] is a benchmark with that "ok"
    +       change).
    +
    +       Per [3] there are some CI users that prefer to see only the full
    +       verbose output, i.e. we can't in the general case assume that we
    +       can emit only the trace output for the failing test, and that's
    +       going to give us the information we need to debug the test. It
    +       might be failing because of earlier setup, or from trace output
    +       outside of any test (i.e. in the main body of the file).
    +
    +       Users such as [3] could still just consult the *.out output, but
    +       then we'd make them download the archive instead of viewing the
    +       output in the web UX.
    +
    +    C. Per B above and [3] an earlier change in this series modified
    +       the *.out output to change the *.out output inadvertently while trying
    +       to modify the *.markup output. See the commit message of "ci(github):
    +       avoid printing test case preamble twice" earlier in this series.
    +
    +    It thus make sense for now to make the "ci/print-test-failures.sh"
    +    output be the "raw" one. I.e. the *.out output we'd get before
    +    --github-workflow-markup was implemented.
    +
    +    To make it use ci/print-test-failures.sh we can create a
    +    "ci/config/print-test-failures-output-type" script on the "ci-config"
    +    branch that does e.g.:
    +
    +            #!/bin/sh
    +            echo github
    +
    +    That script will (like the existing "check-ref") get the ref as an
    +    argument, so we can in the future turn this on experimentally for
    +    "seen", and flip the default in the future. The script can also emit
    +    nothing to get whatever our idea is of the default (currently "raw").
    +
    +    Note the corresponding change to ci/print-test-failures.sh, i.e. we'll
    +    do the right thing vis-a-vis what we "zoom in" to depending on the
    +    setting. If it's "raw" we'd like a failed "make test" to "zoom in" to
    +    that step, if it's "github" we'd like the to open the subsequent
    +    "ci/print-test-failures.sh" step instead.
    +
    +    1. https://lore.kernel.org/git/220523.86ee0kzjix.gmgdl@evledraar.gmail.com/
    +    2. https://lore.kernel.org/git/220222.86tucr6kz5.gmgdl@evledraar.gmail.com/
    +    3. https://lore.kernel.org/git/20210309175249.GE3590451@szeder.dev/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
    +     runs-on: ubuntu-latest
    +     outputs:
    +       enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
    ++      print-test-failures-output-type: ${{ steps.print-test-failures-output-type.outputs.type }}
    +     steps:
    +       - name: try to clone ci-config branch
    +         run: |
    +@@ .github/workflows/main.yml: jobs:
    +             config-repo &&
    +           cd config-repo &&
    +           git checkout HEAD -- ci/config || : ignore
    ++      - id: print-test-failures-output-type
    ++        name: check what output type ci/print-test-failures.sh uses
    ++        run: |
    ++          type_default=raw
    ++          type=$type_default
    ++
    ++          if test -x config-repo/ci/config/print-test-failures-output-type
    ++          then
    ++            type=$(config-repo/ci/config/print-test-failures-output-type '${{ github.ref }}')
    ++            if test -z "$type"
    ++            then
    ++              type=$type_default
    ++            fi
    ++          fi
    ++          echo "::set-output name=type::$type"
    +       - id: check-ref
    +         name: check whether CI is enabled for ref
    +         run: |
    +@@ .github/workflows/main.yml: jobs:
    +     - uses: git-for-windows/setup-git-for-windows-sdk@v1
    +     - run: ci/lib.sh --test
            shell: bash
    -     - name: test
    ++      env:
    ++        GIT_CI_PTF_OUTPUT_TYPE: ${{needs.ci-config.outputs.print-test-failures-output-type}}
    +     - name: select tests
    +       run: . /etc/profile && ci/select-test-slice.sh ${{matrix.nr}} 10
            shell: bash
    --      run: . /etc/profile && make -C t -e
    --    - name: ci/print-test-failures.sh
    --      if: failure()
    --      shell: bash
    --      run: ci/print-test-failures.sh
    -+      run: . /etc/profile && make -C t -e || ci/print-test-failures.sh
    -     - name: Upload failed tests' directories
    -       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
    -       uses: actions/upload-artifact@v2
     @@ .github/workflows/main.yml: jobs:
    +       run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
    +     - run: ci/lib.sh --test
            shell: bash
    -     - name: test
    ++      env:
    ++        GIT_CI_PTF_OUTPUT_TYPE: ${{needs.ci-config.outputs.print-test-failures-output-type}}
    +     - name: select tests
    +       run: . /etc/profile && ci/select-test-slice.sh ${{matrix.nr}} 10
            shell: bash
    --      run: . /etc/profile && make -C t -e
    --    - name: ci/print-test-failures.sh
    --      if: failure()
    --      shell: bash
    --      run: ci/print-test-failures.sh
    -+      run: . /etc/profile && make -C t -e || ci/print-test-failures-github.sh
    -     - name: Upload failed tests' directories
    -       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
    -       uses: actions/upload-artifact@v2
     @@ .github/workflows/main.yml: jobs:
          - run: ci/lib.sh --build
          - run: make
          - run: ci/lib.sh --test
    --    - run: make test
    -+    - run: make test || ci/print-test-failures-github.sh
    ++      env:
    ++        GIT_CI_PTF_OUTPUT_TYPE: ${{needs.ci-config.outputs.print-test-failures-output-type}}
    +     - run: make test
            if: success()
    --    - run: ci/print-test-failures.sh
    --      if: failure()
    -     - name: Upload failed tests' directories
    -       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
    -       uses: actions/upload-artifact@v2
    +     - run: ci/print-test-failures.sh
     @@ .github/workflows/main.yml: jobs:
          - run: make
          - run: ci/lib.sh --test
            if: success() && matrix.vector.skip-tests != 'yes'
    --    - run: make test
    -+    - run: make test || ci/print-test-failures-github.sh
    ++      env:
    ++        GIT_CI_PTF_OUTPUT_TYPE: ${{needs.ci-config.outputs.print-test-failures-output-type}}
    +     - run: make test
            if: success() && matrix.vector.skip-tests != 'yes'
    --    - run: ci/print-test-failures.sh
    --      if: failure() && matrix.vector.skip-tests != 'yes'
    -     - name: Upload failed tests' directories
    -       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
    -       uses: actions/upload-artifact@v1
    +     - run: ci/print-test-failures.sh
    +
    + ## ci/lib.sh ##
    +@@ ci/lib.sh: if test -n "$GITHUB_ENV"
    + then
    + 	echo "CONFIG: GITHUB_ENV=$GITHUB_ENV" >&2
    + fi
    ++echo "CONFIG: GIT_CI_PTF_OUTPUT_TYPE=$GIT_CI_PTF_OUTPUT_TYPE" >&2
    + echo >&2
    + 
    + # Helper functions
    +@@ ci/lib.sh: MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
    + case "$CI_TYPE" in
    + github-actions)
    + 	setenv --test GIT_PROVE_OPTS "--timer --jobs $NPROC"
    +-	GIT_TEST_OPTS="--verbose-log -x --github-workflow-markup"
    ++	GIT_TEST_OPTS="--verbose-log -x"
    ++	if test -n "$GIT_CI_PTF_OUTPUT_TYPE"
    ++	then
    ++		# For later use in ci/print-test-failures.sh
    ++		setenv --test GIT_CI_PTF_OUTPUT_TYPE "$GIT_CI_PTF_OUTPUT_TYPE"
    ++
    ++		case "$GIT_CI_PTF_OUTPUT_TYPE" in
    ++		github)
    ++			GIT_TEST_OPTS="$GIT_TEST_OPTS --github-workflow-markup"
    ++			;;
    ++		esac
    ++	fi
    + 	test Windows != "$RUNNER_OS" ||
    + 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
    + 	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
     
      ## ci/print-test-failures.sh ##
     @@ ci/print-test-failures.sh: set -e
    - . ${0%/*}/lib-ci-type.sh
      . ${0%/*}/lib-tput.sh
      
    --exit_code=
    -+case "$CI_TYPE" in
    -+github-actions)
    -+	exit_code=t
    -+	github_workflow_markup=t
    -+	;;
    -+*)
    -+	exit_code=
    + github_workflow_markup=auto
    +-case "$CI_TYPE" in
    +-github-actions)
    ++case "$GIT_CI_PTF_OUTPUT_TYPE" in
    ++github)
    + 	github_workflow_markup=t
    + 	;;
    ++raw)
     +	github_workflow_markup=
     +	;;
    -+esac
    -+
    - while test $# != 0
    - do
    - 	case "$1" in
    - 	--exit-code)
    - 		exit_code=t
    - 		;;
    -+	--no-exit-code)
    -+		exit_code=
    -+		;;
    -+	--github-workflow-markup)
    -+		github_workflow_markup=t
    -+		;;
    -+	--no-github-workflow-markup)
    -+		github_workflow_markup=
    -+		;;
    - 	*)
    - 		echo "BUG: invalid $0 argument: $1" >&2
    - 		exit 1
    -@@ ci/print-test-failures.sh: do
    - 		TEST_OUT="${TEST_NAME}.out"
    - 		TEST_MARKUP="${TEST_NAME}.markup"
    - 
    --		echo "------------------------------------------------------------------------"
    --		echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
    --		echo "------------------------------------------------------------------------"
    -+		if test -n "$github_workflow_markup"
    -+		then
    -+			printf "\\e[33m\\e[1m=== Failed test: ${TEST_NAME} ===\\e[m\\n"
    -+		else
    -+			echo "------------------------------------------------------------------------"
    -+			echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
    -+			echo "------------------------------------------------------------------------"
    -+		fi
    - 		cat "t/test-results/${TEST_OUT}"
    + esac
      
    - 		trash_dir="trash directory.$TEST_NAME"
    + while test $# != 0
 -:  ----------- > 14:  0b02b186c87 CI: make the --github-workflow-markup "github" output the default
-- 
2.36.1.1045.gf356b5617dd

