Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E02C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93624610EA
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 21:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhD3Vlf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 17:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhD3Vld (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 17:41:33 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B98C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:44 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id gv2so25903759qvb.8
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 14:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2OQAN0QT7S5sxHkaC0c3fPwWyM6LpSQcsfKSc62hEE=;
        b=Ag0131Dpnp0qX+/5GvBARFxH1pqnPtV2h9o/SRIgl8IBA6hoUoK+0nLu/V3m9K3UtG
         H96KSi45+g+2ooyJSqgo/rDLnXroj4/b9FyYihUB7qgc4aIyxvnBoII0UM99z6bnNV4n
         kBFBFM93qWQQ+XPekvll2TFlStFKHmzU7oZkNjTP/enNNXYjrDqLM0FoVZWRZzVv6Q51
         oyuiXFG3wKpmPHaeUlWHfWuKRGS0wMhbAh/FtJA1M5J0nw/h2yJbwlt5ukJ6cceQ5rbN
         nxJixaA6hY6I8ehRiibnEMvDyUjLnVioznjy1L5G7oR8hHzNwPSu446CG/dtDdWizkk1
         OT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2OQAN0QT7S5sxHkaC0c3fPwWyM6LpSQcsfKSc62hEE=;
        b=i5e1L+MtP14AkJy622H62evsyMR5LlF3PCJdCTRHncadAPHOB4Mztf05QjdfRZ+ajs
         KscJhRyjFkrj8kKSYONQyI7QD9Yx46je5wzIG8Q1QHiLxPvYpk4G302SNPq6KFgu/Mn3
         jT9OMl5rU+VaQnsaIr5JbEvQk+OM8uhZLdSklsnpcB0g8WoJ7RDYEiNaTVPxIAnUQRHB
         8QJ8+aYsmI+m9XikNYyXlJoEtIbNswtU7ZYM0mm/jttaIcH3gUd9bsHhlsU1qADy5Gbn
         12KNB2c0T8NzxLLa3xkVp+miUyOWtjum/DiStgThoPS3ZoBfmVR3EdJifDD5UXd0ZStI
         WjNA==
X-Gm-Message-State: AOAM532TAEduzOvn1LKSs8GcB5aqlO8YEA6r/15ghc+Z1sMF02HuMjPL
        IPOJIbR1UgZ3XCrfvrQzSrpcQrCAT0G6Wg==
X-Google-Smtp-Source: ABdhPJyqz2p0Oc2ihlkTRlrVnetI95EOV0tG2TRJKIQUsgSf4bOw259MFtetHNYVWwfSLMuBYvGmNQ==
X-Received: by 2002:a05:6214:62a:: with SMTP id a10mr7853404qvx.5.1619818842695;
        Fri, 30 Apr 2021 14:40:42 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j13sm3123718qth.57.2021.04.30.14.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 14:40:42 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com, stolee@gmail.com
Subject: [PATCH v2 0/8] Parallel Checkout (part 3)
Date:   Fri, 30 Apr 2021 18:40:27 -0300
Message-Id: <cover.1619818517.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1619104091.git.matheus.bernardino@usp.br>
References: <cover.1619104091.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the last part of the parallel checkout series. It's based on
mt/parallel-checkout-part-2. This part adds parallel checkout support to
"git checkout-index" and "git checkout <pathspec>", and adds tests for
the parallel checkout framework.

Changes since v2:

Patch 2:
- Mentioned in the commit message which checkout mode the patch is
  adding parallel checkout support for (i.e. pathspec-limited mode).

Patch 4:

  t/lib-parallel-checkout.sh:
  - Added/improved usage message for the helper functions.
  - Renamed trace file in test_checkout_workers to avoid collisions.
  - At verify_checkout:

      * Used --ignore-submodules=none for the diff-index execution. (I
	hadn't noticed before that the default behavior changed to
	'untracked' on git v2.31.0.)

      * Removed the `diff-index --cached` check as it was redundant.
	We are already implicitly checking the index by asserting that
	`git status` is empty after the `git diff-index HEAD` check.

  t/t2080:
  - Used `test_ln_s_add`, to avoid requiring the SYMLINKS prereq in all
    tests but one.
  - Grouped the basic checkout/clone tests in a for loop to make make it
    easier to see what are the differences between then (i.e. the
    different cases they are testing).
  - Added more entry type changes in the branch switch used to check
    parallel checkout correctness.
  - Added a test to ensure submodules can also use parallel checkout.
  - Compare the working trees with `git diff --no-index` instead of
    `diff -r` to avoid following symlinks.

Patch 6:
- Split patch into two: one moving the helper functions from t0028 to
  lib-encoding.sh, and another actually adding the t2082 tests.

Matheus Tavares (8):
  make_transient_cache_entry(): optionally alloc from mem_pool
  builtin/checkout.c: complete parallel checkout support
  checkout-index: add parallel checkout support
  parallel-checkout: add tests for basic operations
  parallel-checkout: add tests related to path collisions
  t0028: extract encoding helpers to lib-encoding.sh
  parallel-checkout: add tests related to .gitattributes
  ci: run test round with parallel-checkout enabled

 builtin/checkout--worker.c              |   2 +-
 builtin/checkout-index.c                |  24 ++-
 builtin/checkout.c                      |  20 ++-
 builtin/difftool.c                      |   2 +-
 cache.h                                 |  11 +-
 ci/run-build-and-tests.sh               |   1 +
 parallel-checkout.c                     |  18 ++
 read-cache.c                            |  12 +-
 t/README                                |   4 +
 t/lib-encoding.sh                       |  25 +++
 t/lib-parallel-checkout.sh              |  45 +++++
 t/t0028-working-tree-encoding.sh        |  25 +--
 t/t2080-parallel-checkout-basics.sh     | 229 ++++++++++++++++++++++++
 t/t2081-parallel-checkout-collisions.sh | 162 +++++++++++++++++
 t/t2082-parallel-checkout-attributes.sh | 194 ++++++++++++++++++++
 unpack-trees.c                          |   2 +-
 16 files changed, 727 insertions(+), 49 deletions(-)
 create mode 100644 t/lib-encoding.sh
 create mode 100644 t/lib-parallel-checkout.sh
 create mode 100755 t/t2080-parallel-checkout-basics.sh
 create mode 100755 t/t2081-parallel-checkout-collisions.sh
 create mode 100755 t/t2082-parallel-checkout-attributes.sh

Range-diff against v1:
1:  f870040bfb = 1:  f870040bfb make_transient_cache_entry(): optionally alloc from mem_pool
2:  5e0dee7beb ! 2:  e2d82c4337 builtin/checkout.c: complete parallel checkout support
    @@ Metadata
      ## Commit message ##
         builtin/checkout.c: complete parallel checkout support
     
    -    There is one code path in builtin/checkout.c which still doesn't benefit
    -    from parallel checkout because it calls checkout_entry() directly,
    -    instead of unpack_trees(). Let's add parallel checkout support for this
    -    missing spot as well. Note: the transient cache entries allocated in
    -    checkout_merged() are now allocated in a mem_pool which is only
    -    discarded after parallel checkout finishes. This is done because the
    -    entries need to be valid when run_parallel_checkout() is called.
    +    Pathspec-limited checkouts (like `git checkout *.txt`) are performed by
    +    a code path that doesn't yet support parallel checkout because it calls
    +    checkout_entry() directly, instead of unpack_trees(). Let's add parallel
    +    checkout support for this code path too.
    +
    +    Note: the transient cache entries allocated in checkout_merged() are now
    +    allocated in a mem_pool which is only discarded after parallel checkout
    +    finishes. This is done because the entries need to be valid when
    +    run_parallel_checkout() is called.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
3:  6bf1db2fd8 = 3:  0fe1a5fabc checkout-index: add parallel checkout support
4:  46128ba8d8 ! 4:  f604c50dba parallel-checkout: add tests for basic operations
    @@ Commit message
         included by t2080 for now. But they will also be used by other
         parallel-checkout tests in the following patches.
     
    -    Original-patch-by: Jeff Hostetler <jeffhost@microsoft.com>
    -    Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
    +    Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## t/lib-parallel-checkout.sh (new) ##
     @@
    -+# Helpers for t208* tests
    ++# Helpers for tests invoking parallel-checkout
     +
     +set_checkout_config () {
     +	if test $# -ne 2
     +	then
    -+		BUG "set_checkout_config() requires two arguments"
    ++		BUG "usage: set_checkout_config <workers> <threshold>"
     +	fi &&
     +
     +	test_config_global checkout.workers $1 &&
    @@ t/lib-parallel-checkout.sh (new)
     +test_checkout_workers () {
     +	if test $# -lt 2
     +	then
    -+		BUG "too few arguments to test_checkout_workers()"
    ++		BUG "too few arguments to test_checkout_workers"
     +	fi &&
     +
    -+	expected_workers=$1 &&
    ++	local expected_workers=$1 &&
     +	shift &&
     +
    -+	rm -f trace &&
    -+	GIT_TRACE2="$(pwd)/trace" "$@" &&
    ++	local trace_file=trace-test-checkout-workers &&
    ++	rm -f "$trace_file" &&
    ++	GIT_TRACE2="$(pwd)/$trace_file" "$@" &&
     +
    -+	workers=$(grep "child_start\[..*\] git checkout--worker" trace | wc -l) &&
    ++	local workers=$(grep "child_start\[..*\] git checkout--worker" "$trace_file" | wc -l) &&
     +	test $workers -eq $expected_workers &&
    -+	rm -f trace
    ++	rm "$trace_file"
     +}
     +
     +# Verify that both the working tree and the index were created correctly
     +verify_checkout () {
    -+	git -C "$1" diff-index --quiet HEAD -- &&
    -+	git -C "$1" diff-index --quiet --cached HEAD -- &&
    ++	if test $# -ne 1
    ++	then
    ++		BUG "usage: verify_checkout <repository path>"
    ++	fi &&
    ++
    ++	git -C "$1" diff-index --ignore-submodules=none --exit-code HEAD -- &&
     +	git -C "$1" status --porcelain >"$1".status &&
     +	test_must_be_empty "$1".status
     +}
    @@ t/t2080-parallel-checkout-basics.sh (new)
     +. ./test-lib.sh
     +. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
     +
    -+# Test parallel-checkout with a branch switch containing file creations,
    -+# deletions, and modification; with different entry types. Switching from B1 to
    -+# B2 will have the following changes:
    ++# Test parallel-checkout with a branch switch containing a variety of file
    ++# creations, deletions, and modifications, involving different entry types.
    ++# The branches B1 and B2 have the following paths:
    ++#
    ++#      B1                 B2
    ++#  a/a (file)         a   (file)
    ++#  b   (file)         b/b (file)
    ++#
    ++#  c/c (file)         c   (symlink)
    ++#  d   (symlink)      d/d (file)
    ++#
    ++#  e/e (file)         e   (submodule)
    ++#  f   (submodule)    f/f (file)
    ++#
    ++#  g   (submodule)    g   (symlink)
    ++#  h   (symlink)      h   (submodule)
    ++#
    ++# Additionally, the following paths are present on both branches, but with
    ++# different contents:
    ++#
    ++#  i   (file)         i   (file)
    ++#  j   (symlink)      j   (symlink)
    ++#  k   (submodule)    k   (submodule)
     +#
    -+# - a (file):      modified
    -+# - e/x (file):    deleted
    -+# - b (symlink):   deleted
    -+# - b/f (file):    created
    -+# - e (symlink):   created
    -+# - d (submodule): created
    ++# And the following paths are only present in one of the branches:
     +#
    -+test_expect_success SYMLINKS 'setup repo for checkout with various types of changes' '
    ++#  l/l (file)         -
    ++#  -                  m/m (file)
    ++#
    ++test_expect_success 'setup repo for checkout with various types of changes' '
    ++	git init sub &&
    ++	(
    ++		cd sub &&
    ++		git checkout -b B2 &&
    ++		echo B2 >file &&
    ++		git add file &&
    ++		git commit -m file &&
    ++
    ++		git checkout -b B1 &&
    ++		echo B1 >file &&
    ++		git add file &&
    ++		git commit -m file
    ++	) &&
    ++
     +	git init various &&
     +	(
     +		cd various &&
    ++
     +		git checkout -b B1 &&
    -+		echo a >a &&
    -+		mkdir e &&
    -+		echo e/x >e/x &&
    -+		ln -s e b &&
    -+		git add -A &&
    ++		mkdir a c e &&
    ++		echo a/a >a/a &&
    ++		echo b >b &&
    ++		echo c/c >c/c &&
    ++		test_ln_s_add c d &&
    ++		echo e/e >e/e &&
    ++		git submodule add ../sub f &&
    ++		git submodule add ../sub g &&
    ++		test_ln_s_add c h &&
    ++
    ++		echo "B1 i" >i &&
    ++		test_ln_s_add c j &&
    ++		git submodule add -b B1 ../sub k &&
    ++		mkdir l &&
    ++		echo l/l >l/l &&
    ++
    ++		git add . &&
     +		git commit -m B1 &&
     +
     +		git checkout -b B2 &&
    -+		echo modified >a &&
    -+		rm -rf e &&
    -+		rm b &&
    -+		mkdir b &&
    -+		echo b/f >b/f &&
    -+		ln -s b e &&
    -+		git init d &&
    -+		test_commit -C d f &&
    -+		git submodule add ./d &&
    -+		git add -A &&
    ++		git rm -rf :^.gitmodules :^k &&
    ++		mkdir b d f &&
    ++		echo a >a &&
    ++		echo b/b >b/b &&
    ++		test_ln_s_add b c &&
    ++		echo d/d >d/d &&
    ++		git submodule add ../sub e &&
    ++		echo f/f >f/f &&
    ++		test_ln_s_add b g &&
    ++		git submodule add ../sub h &&
    ++
    ++		echo "B2 i" >i &&
    ++		test_ln_s_add b j &&
    ++		git -C k checkout B2 &&
    ++		mkdir m &&
    ++		echo m/m >m/m &&
    ++
    ++		git add . &&
     +		git commit -m B2 &&
     +
     +		git checkout --recurse-submodules B1
     +	)
     +'
     +
    -+test_expect_success SYMLINKS 'sequential checkout' '
    -+	cp -R various various_sequential &&
    -+	set_checkout_config 1 0 &&
    -+	test_checkout_workers 0 \
    -+		git -C various_sequential checkout --recurse-submodules B2 &&
    -+	verify_checkout various_sequential
    -+'
    ++for mode in sequential parallel sequential-fallback
    ++do
    ++	case $mode in
    ++	sequential)          workers=1 threshold=0 expected_workers=0 ;;
    ++	parallel)            workers=2 threshold=0 expected_workers=2 ;;
    ++	sequential-fallback) workers=2 threshold=100 expected_workers=0 ;;
    ++	esac
     +
    -+test_expect_success SYMLINKS 'parallel checkout' '
    -+	cp -R various various_parallel &&
    -+	set_checkout_config 2 0 &&
    -+	test_checkout_workers 2 \
    -+		git -C various_parallel checkout --recurse-submodules B2 &&
    -+	verify_checkout various_parallel
    -+'
    ++	test_expect_success "$mode checkout" '
    ++		repo=various_$mode &&
    ++		cp -R various $repo &&
     +
    -+test_expect_success SYMLINKS 'fallback to sequential checkout (threshold)' '
    -+	cp -R various various_sequential_fallback &&
    -+	set_checkout_config 2 100 &&
    -+	test_checkout_workers 0 \
    -+		git -C various_sequential_fallback checkout --recurse-submodules B2 &&
    -+	verify_checkout various_sequential_fallback
    -+'
    ++		# The just copied files have more recent timestamps than their
    ++		# associated index entries. So refresh the cached timestamps
    ++		# to avoid an "entry not up-to-date" error from `git checkout`.
    ++		# We only have to do this for the submodules as `git checkout`
    ++		# will already refresh the superproject index before performing
    ++		# the up-to-date check.
    ++		#
    ++		git -C $repo submodule foreach "git update-index --refresh" &&
     +
    -+test_expect_success SYMLINKS 'parallel checkout on clone' '
    -+	git -C various checkout --recurse-submodules B2 &&
    -+	set_checkout_config 2 0 &&
    -+	test_checkout_workers 2 \
    -+		git clone --recurse-submodules various various_parallel_clone &&
    -+	verify_checkout various_parallel_clone
    -+'
    ++		set_checkout_config $workers $threshold &&
    ++		test_checkout_workers $expected_workers \
    ++			git -C $repo checkout --recurse-submodules B2 &&
    ++		verify_checkout $repo
    ++	'
    ++done
     +
    -+test_expect_success SYMLINKS 'fallback to sequential checkout on clone (threshold)' '
    -+	git -C various checkout --recurse-submodules B2 &&
    -+	set_checkout_config 2 100 &&
    -+	test_checkout_workers 0 \
    -+		git clone --recurse-submodules various various_sequential_fallback_clone &&
    -+	verify_checkout various_sequential_fallback_clone
    -+'
    ++for mode in parallel sequential-fallback
    ++do
    ++	case $mode in
    ++	parallel)            workers=2 threshold=0 expected_workers=2 ;;
    ++	sequential-fallback) workers=2 threshold=100 expected_workers=0 ;;
    ++	esac
    ++
    ++	test_expect_success "$mode checkout on clone" '
    ++		repo=various_${mode}_clone &&
    ++		set_checkout_config $workers $threshold &&
    ++		test_checkout_workers $expected_workers \
    ++			git clone --recurse-submodules --branch B2 various $repo &&
    ++		verify_checkout $repo
    ++	'
    ++done
     +
     +# Just to be paranoid, actually compare the working trees' contents directly.
    -+test_expect_success SYMLINKS 'compare the working trees' '
    ++test_expect_success 'compare the working trees' '
     +	rm -rf various_*/.git &&
    -+	rm -rf various_*/d/.git &&
    ++	rm -rf various_*/*/.git &&
    ++
    ++	# We use `git diff` instead of `diff -r` because the latter would
    ++	# follow symlinks, and not all `diff` implementations support the
    ++	# `--no-dereference` option.
    ++	#
    ++	git diff --no-index various_sequential various_parallel &&
    ++	git diff --no-index various_sequential various_parallel_clone &&
    ++	git diff --no-index various_sequential various_sequential-fallback &&
    ++	git diff --no-index various_sequential various_sequential-fallback_clone
    ++'
     +
    -+	diff -r various_sequential various_parallel &&
    -+	diff -r various_sequential various_sequential_fallback &&
    -+	diff -r various_sequential various_parallel_clone &&
    -+	diff -r various_sequential various_sequential_fallback_clone
    ++# Currently, each submodule is checked out in a separated child process, but
    ++# these subprocesses must also be able to use parallel checkout workers to
    ++# write the submodules' entries.
    ++test_expect_success 'submodules can use parallel checkout' '
    ++	set_checkout_config 2 0 &&
    ++	git init super &&
    ++	(
    ++		cd super &&
    ++		git init sub &&
    ++		test_commit -C sub A &&
    ++		test_commit -C sub B &&
    ++		git submodule add ./sub &&
    ++		git commit -m sub &&
    ++		rm sub/* &&
    ++		test_checkout_workers 2 git checkout --recurse-submodules .
    ++	)
     +'
     +
     +test_expect_success 'parallel checkout respects --[no]-force' '
5:  71be08b895 ! 5:  eae6d3a1c1 parallel-checkout: add tests related to path collisions
    @@ Commit message
         checkout workers, both to avoid race conditions and to report colliding
         entries on clone.
     
    -    Original-patch-by: Jeff Hostetler <jeffhost@microsoft.com>
    -    Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
    +    Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
      ## parallel-checkout.c ##
    @@ parallel-checkout.c: void write_pc_item(struct parallel_checkout_item *pc_item,
     
      ## t/lib-parallel-checkout.sh ##
     @@ t/lib-parallel-checkout.sh: test_checkout_workers () {
    - 	shift &&
      
    - 	rm -f trace &&
    --	GIT_TRACE2="$(pwd)/trace" "$@" &&
    -+	GIT_TRACE2="$(pwd)/trace" "$@" 2>&8 &&
    + 	local trace_file=trace-test-checkout-workers &&
    + 	rm -f "$trace_file" &&
    +-	GIT_TRACE2="$(pwd)/$trace_file" "$@" &&
    ++	GIT_TRACE2="$(pwd)/$trace_file" "$@" 2>&8 &&
      
    - 	workers=$(grep "child_start\[..*\] git checkout--worker" trace | wc -l) &&
    + 	local workers=$(grep "child_start\[..*\] git checkout--worker" "$trace_file" | wc -l) &&
      	test $workers -eq $expected_workers &&
    - 	rm -f trace
    + 	rm "$trace_file"
     -}
     +} 8>&2 2>&4
      
-:  ---------- > 6:  9161cd1503 t0028: extract encoding helpers to lib-encoding.sh
6:  1dedfd994a ! 7:  bc584897e6 parallel-checkout: add tests related to .gitattributes
    @@ Commit message
         require external filters, are correctly smudge and written when
         parallel-checkout is enabled.
     
    -    Note: to avoid repeating code, some helper functions are extracted from
    -    t0028 into a common lib file.
    -
    -    Original-patch-by: Jeff Hostetler <jeffhost@microsoft.com>
    -    Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
    +    Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
    - ## t/lib-encoding.sh (new) ##
    -@@
    -+# Encoding helpers used by t0028 and t2082
    -+
    -+test_lazy_prereq NO_UTF16_BOM '
    -+	test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6
    -+'
    -+
    -+test_lazy_prereq NO_UTF32_BOM '
    -+	test $(printf abc | iconv -f UTF-8 -t UTF-32 | wc -c) = 12
    -+'
    -+
    -+write_utf16 () {
    -+	if test_have_prereq NO_UTF16_BOM
    -+	then
    -+		printf '\376\377'
    -+	fi &&
    -+	iconv -f UTF-8 -t UTF-16
    -+}
    -+
    -+write_utf32 () {
    -+	if test_have_prereq NO_UTF32_BOM
    -+	then
    -+		printf '\0\0\376\377'
    -+	fi &&
    -+	iconv -f UTF-8 -t UTF-32
    -+}
    -
    - ## t/t0028-working-tree-encoding.sh ##
    -@@ t/t0028-working-tree-encoding.sh: GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    - export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    - 
    - . ./test-lib.sh
    -+. "$TEST_DIRECTORY/lib-encoding.sh"
    - 
    - GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING
    - 
    --test_lazy_prereq NO_UTF16_BOM '
    --	test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6
    --'
    --
    --test_lazy_prereq NO_UTF32_BOM '
    --	test $(printf abc | iconv -f UTF-8 -t UTF-32 | wc -c) = 12
    --'
    --
    --write_utf16 () {
    --	if test_have_prereq NO_UTF16_BOM
    --	then
    --		printf '\376\377'
    --	fi &&
    --	iconv -f UTF-8 -t UTF-16
    --}
    --
    --write_utf32 () {
    --	if test_have_prereq NO_UTF32_BOM
    --	then
    --		printf '\0\0\376\377'
    --	fi &&
    --	iconv -f UTF-8 -t UTF-32
    --}
    --
    - test_expect_success 'setup test files' '
    - 	git config core.eol lf &&
    - 
    -
      ## t/t2082-parallel-checkout-attributes.sh (new) ##
     @@
     +#!/bin/sh
7:  3cc5b10081 ! 8:  1bc5c523c5 ci: run test round with parallel-checkout enabled
    @@ t/README: and "sha256".
     
      ## t/lib-parallel-checkout.sh ##
     @@
    - # Helpers for t208* tests
    + # Helpers for tests invoking parallel-checkout
      
     +# Parallel checkout tests need full control of the number of workers
     +unset GIT_TEST_CHECKOUT_WORKERS
-- 
2.30.1

