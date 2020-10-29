Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD49C4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4604E20738
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Ttnh5huH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgJ2CRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgJ2CPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:15:09 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23812C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:09 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j62so1012810qtd.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qpm6EArRg7SgnxY3wam0r9u11oAoI0DtEfc6A6pwOa0=;
        b=Ttnh5huHGmK04apzifY0+a+LybCtJx/jPkGuGbFRb5LPHihOLnnvuHvBL1ZO3etsLa
         FF+OpdfIwgUe3NLQmyTCseSRjfIOJ2V8FAmvtI7zmjNuyHYV5i/GZUQcuDhhtDyziMhV
         cjPOik6N3Pfah6dKhzLMRxrs1W8fw0CtVAE0CMiiOh1UpC9nWyCQ6SnYH8JtkMWHEZAe
         S+14iaDMbb8It3qqY/AqdkWD76u2tEQcRTLVclSXLflwZxclZNFEDn1js3yT4qMRZD0+
         oOyfVxMVUU8iLKdKBI7lsG1MNt9vp0JX9Ol+Hkebn6NoNUT+iohnMHwQzPC97YoigXUA
         zcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qpm6EArRg7SgnxY3wam0r9u11oAoI0DtEfc6A6pwOa0=;
        b=dKMjY3P8Vkvc58vgIO0xt+k4CtM+K/p33uefRDDnMdXYiqpar2SrYa/SmELsQA2M21
         iUxdkDVwQ9iaHwOGvniqXewIbLRUrF4fcgF1mtxEvx23GrhXHZHnIOTuvYu5EYVRVTIF
         w2LBiCDwN+9gjDovBbUaHgkUobPf7VjEZ4aOPgBJCsSi3V5/vqW+KzldrPGhZlGZHWHk
         yJEo/CL+3cZskSWDyeg/nQ7SpnSXKEVc244qNGsUeRZp1a+8vlj2b9fV4Pzc+D1dKXGR
         1Mk0s4F33gMd39J5oANsDfe3IB7ks5AgY7Ad1R8nqgwLKbjVFW+xjUJNOr6fORMT2cJ0
         A+kw==
X-Gm-Message-State: AOAM530uBnV5qsKMKXdUYhjQeO4+DXkJUnkFWGu8t/vlutluYz18UxHW
        xZK8hWkg5oQ87f2a/4OuRaIgM+W7lsHgHQ==
X-Google-Smtp-Source: ABdhPJw53734gghQp2SKVcWMobKaDFN4bGKMaoXjG9gGE3T5o6OjdHJD+wYGakWDG/H4Vvs27IA7PA==
X-Received: by 2002:aed:2746:: with SMTP id n64mr1642042qtd.212.1603937707476;
        Wed, 28 Oct 2020 19:15:07 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:15:06 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v3 00/19] Parallel Checkout (part I)
Date:   Wed, 28 Oct 2020 23:14:37 -0300
Message-Id: <cover.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600814153.git.matheus.bernardino@usp.br>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was some semantic conflicts between this series and
jk/checkout-index-errors, so I rebased my series on top of that.

Also, I'd please ask reviewers to confirm that my descriptor
redirection in git_pc() (patch 17) is correct, as I'm not very 
familiar with the test suite descriptors.

Main changes since v2:

Patch 10:
  - Squashed Peff's patch removing an useless function parameter.

Patch 11:
  - Valgrind used to complain about send_one_item() passing
    uninitialized bytes to a syscall (write(2)). The referred bytes come
    from the unused positions on oid->hash[], when the hash is SHA-1.
    Since the workers won't use these bytes, there is no real harm. But
    the warning could cause confusion and even get in the way of
    detecting real errors, so I replaced the oidcpy() call with
    hashcpy().

Patch 16:
  - Replaced use of the non-portable '\+' in grep with '..*' (in
    t/lib-parallel-checkout.sh).

  - Properly quoted function parameters in t/lib-parallel-checkout.sh,
    as Jonathan pointed out.

  - In t2080, dropped tests that used git.git as test data, and added
    two more tests to check clone with parallel-checkout using the
    artificial repo already created for other tests.

  - No longer skip clone tests when GIT_TEST_DEFAULT_HASH is sha256. A
    bug in clone used to make the tests fail with this configuration set
    to this value, but the bug was fixed in 47ac970309 ("builtin/clone:
    avoid failure with GIT_DEFAULT_HASH", 2020-09-20).

Patch 17:
  - The test t2081-parallel-checkout-collisions.sh had a bug in which
    the filter options were being wrongly passed to git. These options
    were conditionally defined through a shell variable, for which the
    quoting was wrong. This should have made the test fail but, in fact,
    another bug (using the arithmetic operator `-eq` for strings), was
    preventing the problematic section from ever running. These bugs are
    now fixed, and the test script was also simplified, by making use of
    the lib-parallel-checkout.sh and eliminating the helper function.

  - Use "$TEST_ROOT/logger_script" instead of "../logger_script", to be
    on the safe side.


Jeff Hostetler (4):
  convert: make convert_attrs() and convert structs public
  convert: add [async_]convert_to_working_tree_ca() variants
  convert: add get_stream_filter_ca() variant
  convert: add conv_attrs classification

Matheus Tavares (15):
  entry: extract a header file for entry.c functions
  entry: make fstat_output() and read_blob_entry() public
  entry: extract cache_entry update from write_entry()
  entry: move conv_attrs lookup up to checkout_entry()
  entry: add checkout_entry_ca() which takes preloaded conv_attrs
  unpack-trees: add basic support for parallel checkout
  parallel-checkout: make it truly parallel
  parallel-checkout: support progress displaying
  make_transient_cache_entry(): optionally alloc from mem_pool
  builtin/checkout.c: complete parallel checkout support
  checkout-index: add parallel checkout support
  parallel-checkout: add tests for basic operations
  parallel-checkout: add tests related to clone collisions
  parallel-checkout: add tests related to .gitattributes
  ci: run test round with parallel-checkout enabled

 .gitignore                              |   1 +
 Documentation/config/checkout.txt       |  21 +
 Makefile                                |   2 +
 apply.c                                 |   1 +
 builtin.h                               |   1 +
 builtin/checkout--helper.c              | 142 ++++++
 builtin/checkout-index.c                |  22 +-
 builtin/checkout.c                      |  21 +-
 builtin/difftool.c                      |   3 +-
 cache.h                                 |  34 +-
 ci/run-build-and-tests.sh               |   1 +
 convert.c                               | 121 +++--
 convert.h                               |  68 +++
 entry.c                                 | 102 ++--
 entry.h                                 |  54 ++
 git.c                                   |   2 +
 parallel-checkout.c                     | 638 ++++++++++++++++++++++++
 parallel-checkout.h                     | 103 ++++
 read-cache.c                            |  12 +-
 t/README                                |   4 +
 t/lib-encoding.sh                       |  25 +
 t/lib-parallel-checkout.sh              |  46 ++
 t/t0028-working-tree-encoding.sh        |  25 +-
 t/t2080-parallel-checkout-basics.sh     | 170 +++++++
 t/t2081-parallel-checkout-collisions.sh |  98 ++++
 t/t2082-parallel-checkout-attributes.sh | 174 +++++++
 unpack-trees.c                          |  22 +-
 27 files changed, 1758 insertions(+), 155 deletions(-)
 create mode 100644 builtin/checkout--helper.c
 create mode 100644 entry.h
 create mode 100644 parallel-checkout.c
 create mode 100644 parallel-checkout.h
 create mode 100644 t/lib-encoding.sh
 create mode 100644 t/lib-parallel-checkout.sh
 create mode 100755 t/t2080-parallel-checkout-basics.sh
 create mode 100755 t/t2081-parallel-checkout-collisions.sh
 create mode 100755 t/t2082-parallel-checkout-attributes.sh

Range-diff against v2:
 1:  b9d2a329d3 =  1:  dfc3e0fd62 convert: make convert_attrs() and convert structs public
 2:  313c3bcbeb =  2:  c5fbd1e16d convert: add [async_]convert_to_working_tree_ca() variants
 3:  29bbdb78e9 =  3:  c77b16f694 convert: add get_stream_filter_ca() variant
 4:  a1cf5df961 =  4:  18c3f4247e convert: add conv_attrs classification
 5:  25b311745a =  5:  2caa2c4345 entry: extract a header file for entry.c functions
 6:  dbee09e936 =  6:  bfa52df9e2 entry: make fstat_output() and read_blob_entry() public
 7:  b61b5c44f0 =  7:  91ef17f533 entry: extract cache_entry update from write_entry()
 8:  667ad0dea7 =  8:  81e03baab1 entry: move conv_attrs lookup up to checkout_entry()
 9:  4ddb34209e =  9:  e1b886f823 entry: add checkout_entry_ca() which takes preloaded conv_attrs
10:  af0d790973 ! 10:  2bdc13664e unpack-trees: add basic support for parallel checkout
    @@ parallel-checkout.c (new)
     +}
     +
     +static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
    -+			       const char *path, struct checkout *state)
    ++			       const char *path)
     +{
     +	int ret;
     +	struct stream_filter *filter;
    @@ parallel-checkout.c (new)
     +		goto out;
     +	}
     +
    -+	if (write_pc_item_to_fd(pc_item, fd, path.buf, state)) {
    ++	if (write_pc_item_to_fd(pc_item, fd, path.buf)) {
     +		/* Error was already reported. */
     +		pc_item->status = PC_ITEM_FAILED;
     +		goto out;
11:  991169488b ! 11:  096e543fd2 parallel-checkout: make it truly parallel
    @@ Documentation/config/checkout.txt: will checkout the '<something>' branch on ano
     +	The number of parallel workers to use when updating the working tree.
     +	The default is one, i.e. sequential execution. If set to a value less
     +	than one, Git will use as many workers as the number of logical cores
    -+	available. This setting and checkout.thresholdForParallelism affect all
    -+	commands that perform checkout. E.g. checkout, switch, clone, reset,
    -+	sparse-checkout, read-tree, etc.
    ++	available. This setting and `checkout.thresholdForParallelism` affect
    ++	all commands that perform checkout. E.g. checkout, clone, reset,
    ++	sparse-checkout, etc.
     ++
     +Note: parallel checkout usually delivers better performance for repositories
     +located on SSDs or over NFS. For repositories on spinning disks and/or machines
    @@ parallel-checkout.c: static void write_pc_item(struct parallel_checkout_item *pc
     +
     +	fixed_portion = (struct pc_item_fixed_portion *)data;
     +	fixed_portion->id = pc_item->id;
    -+	oidcpy(&fixed_portion->oid, &pc_item->ce->oid);
     +	fixed_portion->ce_mode = pc_item->ce->ce_mode;
     +	fixed_portion->crlf_action = pc_item->ca.crlf_action;
     +	fixed_portion->ident = pc_item->ca.ident;
     +	fixed_portion->name_len = name_len;
     +	fixed_portion->working_tree_encoding_len = working_tree_encoding_len;
    ++	/*
    ++	 * We use hashcpy() instead of oidcpy() because the hash[] positions
    ++	 * after `the_hash_algo->rawsz` might not be initialized. And Valgrind
    ++	 * would complain about passing uninitialized bytes to a syscall
    ++	 * (write(2)). There is no real harm in this case, but the warning could
    ++	 * hinder the detection of actual errors.
    ++	 */
    ++	hashcpy(fixed_portion->oid.hash, pc_item->ce->oid.hash);
     +
     +	variant = data + sizeof(*fixed_portion);
     +	if (working_tree_encoding_len) {
12:  7ceadf2427 = 12:  9cfeb4821c parallel-checkout: support progress displaying
13:  f13b4c17f4 = 13:  da99b671e6 make_transient_cache_entry(): optionally alloc from mem_pool
14:  d7885a1130 = 14:  d3d561754a builtin/checkout.c: complete parallel checkout support
15:  1cf9b807f7 ! 15:  ee34c6e149 checkout-index: add parallel checkout support
    @@ builtin/checkout-index.c
      #define CHECKOUT_ALL 4
      static int nul_term_line;
     @@ builtin/checkout-index.c: int cmd_checkout_index(int argc, const char **argv, const char *prefix)
    - 	int prefix_length;
      	int force = 0, quiet = 0, not_new = 0;
      	int index_opt = 0;
    + 	int err = 0;
     +	int pc_workers, pc_threshold;
      	struct option builtin_checkout_index_options[] = {
      		OPT_BOOL('a', "all", &all,
    @@ builtin/checkout-index.c: int cmd_checkout_index(int argc, const char **argv, co
      	for (i = 0; i < argc; i++) {
      		const char *arg = argv[i];
     @@ builtin/checkout-index.c: int cmd_checkout_index(int argc, const char **argv, const char *prefix)
    + 		strbuf_release(&buf);
    + 	}
    + 
    +-	if (err)
    +-		return 1;
    +-
      	if (all)
      		checkout_all(prefix, prefix_length);
      
     +	if (pc_workers > 1) {
    -+		/* Errors were already reported */
    -+		run_parallel_checkout(&state, pc_workers, pc_threshold,
    -+				      NULL, NULL);
    ++		err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
    ++					     NULL, NULL);
     +	}
    ++
    ++	if (err)
    ++		return 1;
     +
      	if (is_lock_file_locked(&lock_file) &&
      	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
16:  64b41d537e ! 16:  05299a3cc0 parallel-checkout: add tests for basic operations
    @@ Commit message
         for symlinks in the leading directories and the abidance to --force.
     
         Note: some helper functions are added to a common lib file which is only
    -    included by t2080 for now. But it will also be used by another
    -    parallel-checkout test in a following patch.
    +    included by t2080 for now. But it will also be used by other
    +    parallel-checkout tests in the following patches.
     
         Original-patch-by: Jeff Hostetler <jeffhost@microsoft.com>
         Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
    @@ t/lib-parallel-checkout.sh (new)
     +
     +# Runs `git -c checkout.workers=$1 -c checkout.thesholdForParallelism=$2 ${@:4}`
     +# and checks that the number of workers spawned is equal to $3.
    ++#
     +git_pc()
     +{
     +	if test $# -lt 4
     +	then
     +		BUG "too few arguments to git_pc()"
    -+	fi
    ++	fi &&
     +
     +	workers=$1 threshold=$2 expected_workers=$3 &&
    -+	shift && shift && shift &&
    ++	shift 3 &&
     +
     +	rm -f trace &&
     +	GIT_TRACE2="$(pwd)/trace" git \
     +		-c checkout.workers=$workers \
     +		-c checkout.thresholdForParallelism=$threshold \
     +		-c advice.detachedHead=0 \
    -+		$@ &&
    ++		"$@" &&
     +
     +	# Check that the expected number of workers has been used. Note that it
    -+	# can be different than the requested number in two cases: when the
    -+	# quantity of entries to be checked out is less than the number of
    -+	# workers; and when the threshold has not been reached.
    ++	# can be different from the requested number in two cases: when the
    ++	# threshold is not reached; and when there are not enough
    ++	# parallel-eligible entries for all workers.
     +	#
    -+	local workers_in_trace=$(grep "child_start\[.\+\] git checkout--helper" trace | wc -l) &&
    ++	local workers_in_trace=$(grep "child_start\[..*\] git checkout--helper" trace | wc -l) &&
     +	test $workers_in_trace -eq $expected_workers &&
     +	rm -f trace
     +}
    @@ t/lib-parallel-checkout.sh (new)
     +# Verify that both the working tree and the index were created correctly
     +verify_checkout()
     +{
    -+	git -C $1 diff-index --quiet HEAD -- &&
    -+	git -C $1 diff-index --quiet --cached HEAD -- &&
    -+	git -C $1 status --porcelain >$1.status &&
    -+	test_must_be_empty $1.status
    ++	git -C "$1" diff-index --quiet HEAD -- &&
    ++	git -C "$1" diff-index --quiet --cached HEAD -- &&
    ++	git -C "$1" status --porcelain >"$1".status &&
    ++	test_must_be_empty "$1".status
     +}
     
      ## t/t2080-parallel-checkout-basics.sh (new) ##
    @@ t/t2080-parallel-checkout-basics.sh (new)
     +. ./test-lib.sh
     +. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
     +
    -+# NEEDSWORK: cloning a SHA1 repo with GIT_TEST_DEFAULT_HASH set to "sha256"
    -+# currently produces a wrong result (See
    -+# https://lore.kernel.org/git/20200911151717.43475-1-matheus.bernardino@usp.br/).
    -+# So we skip the "parallel-checkout during clone" tests when this test flag is
    -+# set to "sha256". Remove this when the bug is fixed.
    -+#
    -+if test "$GIT_TEST_DEFAULT_HASH" = "sha256"
    -+then
    -+	skip_all="t2080 currently don't work with GIT_TEST_DEFAULT_HASH=sha256"
    -+	test_done
    -+fi
    -+
    -+R_BASE=$GIT_BUILD_DIR
    -+
    -+test_expect_success 'sequential clone' '
    -+	git_pc 1 0 0 clone --quiet -- $R_BASE r_sequential &&
    -+	verify_checkout r_sequential
    -+'
    -+
    -+test_expect_success 'parallel clone' '
    -+	git_pc 2 0 2 clone --quiet -- $R_BASE r_parallel &&
    -+	verify_checkout r_parallel
    -+'
    -+
    -+test_expect_success 'fallback to sequential clone (threshold)' '
    -+	git -C $R_BASE ls-files >files &&
    -+	nr_files=$(wc -l <files) &&
    -+	threshold=$(($nr_files + 1)) &&
    -+
    -+	git_pc 2 $threshold 0 clone --quiet -- $R_BASE r_sequential_fallback &&
    -+	verify_checkout r_sequential_fallback
    -+'
    -+
    -+# Just to be paranoid, actually compare the contents of the worktrees directly.
    -+test_expect_success 'compare working trees from clones' '
    -+	rm -rf r_sequential/.git &&
    -+	rm -rf r_parallel/.git &&
    -+	rm -rf r_sequential_fallback/.git &&
    -+	diff -qr r_sequential r_parallel &&
    -+	diff -qr r_sequential r_sequential_fallback
    -+'
    -+
     +# Test parallel-checkout with different operations (creation, deletion,
     +# modification) and entry types. A branch switch from B1 to B2 will contain:
     +#
    @@ t/t2080-parallel-checkout-basics.sh (new)
     +	verify_checkout various_sequential_fallback
     +'
     +
    -+test_expect_success SYMLINKS 'compare working trees from checkouts' '
    -+	rm -rf various_sequential/.git &&
    -+	rm -rf various_parallel/.git &&
    -+	rm -rf various_sequential_fallback/.git &&
    -+	diff -qr various_sequential various_parallel &&
    -+	diff -qr various_sequential various_sequential_fallback
    ++test_expect_success SYMLINKS 'parallel checkout on clone' '
    ++	git -C various checkout --recurse-submodules B2 &&
    ++	git_pc 2 0 2 clone --recurse-submodules various various_parallel_clone  &&
    ++	verify_checkout various_parallel_clone
    ++'
    ++
    ++test_expect_success SYMLINKS 'fallback to sequential checkout on clone (threshold)' '
    ++	git -C various checkout --recurse-submodules B2 &&
    ++	git_pc 2 100 0 clone --recurse-submodules various various_sequential_fallback_clone &&
    ++	verify_checkout various_sequential_fallback_clone
    ++'
    ++
    ++# Just to be paranoid, actually compare the working trees' contents directly.
    ++test_expect_success SYMLINKS 'compare the working trees' '
    ++	rm -rf various_*/.git &&
    ++	rm -rf various_*/d/.git &&
    ++
    ++	diff -r various_sequential various_parallel &&
    ++	diff -r various_sequential various_sequential_fallback &&
    ++	diff -r various_sequential various_parallel_clone &&
    ++	diff -r various_sequential various_sequential_fallback_clone
     +'
     +
     +test_cmp_str()
17:  70708d3e31 ! 17:  3d140dcacb parallel-checkout: add tests related to clone collisions
    @@ Commit message
         Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
    + ## t/lib-parallel-checkout.sh ##
    +@@ t/lib-parallel-checkout.sh: git_pc()
    + 		-c checkout.workers=$workers \
    + 		-c checkout.thresholdForParallelism=$threshold \
    + 		-c advice.detachedHead=0 \
    +-		"$@" &&
    ++		"$@" 2>&8 &&
    + 
    + 	# Check that the expected number of workers has been used. Note that it
    + 	# can be different from the requested number in two cases: when the
    +@@ t/lib-parallel-checkout.sh: git_pc()
    + 	local workers_in_trace=$(grep "child_start\[..*\] git checkout--helper" trace | wc -l) &&
    + 	test $workers_in_trace -eq $expected_workers &&
    + 	rm -f trace
    +-}
    ++} 8>&2 2>&4
    + 
    + # Verify that both the working tree and the index were created correctly
    + verify_checkout()
    +
      ## t/t2081-parallel-checkout-collisions.sh (new) ##
     @@
     +#!/bin/sh
     +
    -+test_description='parallel-checkout collisions'
    ++test_description='parallel-checkout collisions
    ++
    ++When there are path collisions during a clone, Git should report a warning
    ++listing all of the colliding entries. The sequential code detects a collision
    ++by calling lstat() before trying to open(O_CREAT) the file. Then, to find the
    ++colliding pair of an item k, it searches cache_entry[0, k-1].
    ++
    ++This is not sufficient in parallel checkout since:
    ++
    ++- A colliding file may be created between the lstat() and open() calls;
    ++- A colliding entry might appear in the second half of the cache_entry array.
    ++
    ++The tests in this file make sure that the collision detection code is extended
    ++for parallel checkout.
    ++'
     +
     +. ./test-lib.sh
    ++. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
     +
    -+# When there are pathname collisions during a clone, Git should report a warning
    -+# listing all of the colliding entries. The sequential code detects a collision
    -+# by calling lstat() before trying to open(O_CREAT) the file. Then, to find the
    -+# colliding pair of an item k, it searches cache_entry[0, k-1].
    -+#
    -+# This is not sufficient in parallel-checkout mode since colliding files may be
    -+# created in a racy order. The tests in this file make sure the collision
    -+# detection code is extended for parallel-checkout. This is done in two parts:
    -+#
    -+# - First, two parallel workers create four colliding files racily.
    -+# - Then this exercise is repeated but forcing the colliding pair to appear in
    -+#   the second half of the cache_entry's array.
    -+#
    -+# The second item uses the fact that files with clean/smudge filters are not
    -+# parallel-eligible; and that they are processed sequentially *before* any
    -+# worker is spawned. We set a filter attribute to the last entry in the
    -+# cache_entry[] array, making it non-eligible, so that it is populated first.
    -+# This way, we can test if the collision detection code is correctly looking
    -+# for collision pairs in the second half of the array.
    ++TEST_ROOT="$PWD"
     +
     +test_expect_success CASE_INSENSITIVE_FS 'setup' '
    -+	file_hex=$(git hash-object -w --stdin </dev/null) &&
    -+	file_oct=$(echo $file_hex | hex2oct) &&
    ++	file_x_hex=$(git hash-object -w --stdin </dev/null) &&
    ++	file_x_oct=$(echo $file_x_hex | hex2oct) &&
     +
     +	attr_hex=$(echo "file_x filter=logger" | git hash-object -w --stdin) &&
     +	attr_oct=$(echo $attr_hex | hex2oct) &&
     +
    -+	printf "100644 FILE_X\0${file_oct}" >tree &&
    -+	printf "100644 FILE_x\0${file_oct}" >>tree &&
    -+	printf "100644 file_X\0${file_oct}" >>tree &&
    -+	printf "100644 file_x\0${file_oct}" >>tree &&
    ++	printf "100644 FILE_X\0${file_x_oct}" >tree &&
    ++	printf "100644 FILE_x\0${file_x_oct}" >>tree &&
    ++	printf "100644 file_X\0${file_x_oct}" >>tree &&
    ++	printf "100644 file_x\0${file_x_oct}" >>tree &&
     +	printf "100644 .gitattributes\0${attr_oct}" >>tree &&
     +
     +	tree_hex=$(git hash-object -w -t tree --stdin <tree) &&
     +	commit_hex=$(git commit-tree -m collisions $tree_hex) &&
     +	git update-ref refs/heads/collisions $commit_hex &&
     +
    -+	write_script logger_script <<-\EOF
    ++	write_script "$TEST_ROOT"/logger_script <<-\EOF
     +	echo "$@" >>filter.log
     +	EOF
     +'
     +
    -+clone_and_check_collision()
    -+{
    -+	id=$1 workers=$2 threshold=$3 expected_workers=$4 filter=$5 &&
    -+
    -+	filter_opts=
    -+	if test "$filter" -eq "use_filter"
    -+	then
    -+		# We use `core.ignoreCase=0` so that only `file_x`
    -+		# matches the pattern in .gitattributes.
    -+		#
    -+		filter_opts='-c filter.logger.smudge="../logger_script %f" -c core.ignoreCase=0'
    -+	fi &&
    -+
    -+	test_path_is_missing $id.trace &&
    -+	GIT_TRACE2="$(pwd)/$id.trace" git \
    -+		-c checkout.workers=$workers \
    -+		-c checkout.thresholdForParallelism=$threshold \
    -+		$filter_opts clone --branch=collisions -- . r_$id 2>$id.warning &&
    -+
    -+	# Check that checkout spawned the right number of workers
    -+	workers_in_trace=$(grep "child_start\[.\] git checkout--helper" $id.trace | wc -l) &&
    -+	test $workers_in_trace -eq $expected_workers &&
    -+
    -+	if test $filter -eq "use_filter"
    -+	then
    -+		#  Make sure only 'file_x' was filtered
    -+		test_path_is_file r_$id/filter.log &&
    ++for mode in parallel sequential-fallback
    ++do
    ++
    ++	case $mode in
    ++	parallel)		workers=2 threshold=0 expected_workers=2 ;;
    ++	sequential-fallback)	workers=2 threshold=100 expected_workers=0 ;;
    ++	esac
    ++
    ++	test_expect_success CASE_INSENSITIVE_FS "collision detection on $mode clone" '
    ++		git_pc $workers $threshold $expected_workers \
    ++			clone --branch=collisions . $mode 2>$mode.stderr &&
    ++
    ++		grep FILE_X $mode.stderr &&
    ++		grep FILE_x $mode.stderr &&
    ++		grep file_X $mode.stderr &&
    ++		grep file_x $mode.stderr &&
    ++		test_i18ngrep "the following paths have collided" $mode.stderr
    ++	'
    ++
    ++	# The following test ensures that the collision detection code is
    ++	# correctly looking for colliding peers in the second half of the
    ++	# cache_entry array. This is done by defining a smudge command for the
    ++	# *last* array entry, which makes it non-eligible for parallel-checkout.
    ++	# The last entry is then checked out *before* any worker is spawned,
    ++	# making it succeed and the workers' entries collide.
    ++	#
    ++	# Note: this test don't work on Windows because, on this system,
    ++	# collision detection uses strcmp() when core.ignoreCase=false. And we
    ++	# have to set core.ignoreCase=false so that only 'file_x' matches the
    ++	# pattern of the filter attribute. But it works on OSX, where collision
    ++	# detection uses inode.
    ++	#
    ++	test_expect_success CASE_INSENSITIVE_FS,!MINGW,!CYGWIN "collision detection on $mode clone w/ filter" '
    ++		git_pc $workers $threshold $expected_workers \
    ++			-c core.ignoreCase=false \
    ++			-c filter.logger.smudge="\"$TEST_ROOT/logger_script\" %f" \
    ++			clone --branch=collisions . ${mode}_with_filter \
    ++			2>${mode}_with_filter.stderr &&
    ++
    ++		grep FILE_X ${mode}_with_filter.stderr &&
    ++		grep FILE_x ${mode}_with_filter.stderr &&
    ++		grep file_X ${mode}_with_filter.stderr &&
    ++		grep file_x ${mode}_with_filter.stderr &&
    ++		test_i18ngrep "the following paths have collided" ${mode}_with_filter.stderr &&
    ++
    ++		# Make sure only "file_x" was filtered
    ++		test_path_is_file ${mode}_with_filter/filter.log &&
     +		echo file_x >expected.filter.log &&
    -+		test_cmp r_$id/filter.log expected.filter.log
    -+	else
    -+		test_path_is_missing r_$id/filter.log
    -+	fi &&
    -+
    -+	grep FILE_X $id.warning &&
    -+	grep FILE_x $id.warning &&
    -+	grep file_X $id.warning &&
    -+	grep file_x $id.warning &&
    -+	test_i18ngrep "the following paths have collided" $id.warning
    -+}
    -+
    -+test_expect_success CASE_INSENSITIVE_FS 'collision detection on parallel clone' '
    -+	clone_and_check_collision parallel 2 0 2
    -+'
    -+
    -+test_expect_success CASE_INSENSITIVE_FS 'collision detection on fallback to sequential clone' '
    -+	git ls-tree --name-only -r collisions >files &&
    -+	nr_files=$(wc -l <files) &&
    -+	threshold=$(($nr_files + 1)) &&
    -+	clone_and_check_collision sequential 2 $threshold 0
    -+'
    -+
    -+# The next two tests don't work on Windows because, on this system, collision
    -+# detection uses strcmp() (when core.ignoreCase=0) to find the colliding pair.
    -+# But they work on OSX, where collision detection uses inode.
    -+
    -+test_expect_success CASE_INSENSITIVE_FS,!MINGW,!CYGWIN 'collision detection on parallel clone w/ filter' '
    -+	clone_and_check_collision parallel-with-filter 2 0 2 use_filter
    -+'
    -+
    -+test_expect_success CASE_INSENSITIVE_FS,!MINGW,!CYGWIN 'collision detection on fallback to sequential clone w/ filter' '
    -+	git ls-tree --name-only -r collisions >files &&
    -+	nr_files=$(wc -l <files) &&
    -+	threshold=$(($nr_files + 1)) &&
    -+	clone_and_check_collision sequential-with-filter 2 $threshold 0 use_filter
    -+'
    ++		test_cmp ${mode}_with_filter/filter.log expected.filter.log
    ++	'
    ++done
     +
     +test_done
18:  ece38f0483 = 18:  b26f676cae parallel-checkout: add tests related to .gitattributes
19:  b4cb5905d2 ! 19:  641c61f9b6 ci: run test round with parallel-checkout enabled
    @@ t/lib-parallel-checkout.sh
     +
      # Runs `git -c checkout.workers=$1 -c checkout.thesholdForParallelism=$2 ${@:4}`
      # and checks that the number of workers spawned is equal to $3.
    - git_pc()
    -
    - ## t/t2081-parallel-checkout-collisions.sh ##
    -@@
    - test_description='parallel-checkout collisions'
    - 
    - . ./test-lib.sh
    -+. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
    - 
    - # When there are pathname collisions during a clone, Git should report a warning
    - # listing all of the colliding entries. The sequential code detects a collision
    + #
-- 
2.28.0

