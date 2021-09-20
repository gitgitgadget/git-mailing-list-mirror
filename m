Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8177C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8200B60E9B
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhIUC7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348662AbhIUC0b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A69C1E3266
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w17so24466857wrv.10
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VChHloUEaWOlrKvLqXZY/4hOTJitrriVgYa80li7NMI=;
        b=m77lnepbUDfwgkLBZb0sOtpMfIMXK/fTZF9rv7Q4Ioy0P3EmlB7h5Tm+EcyQCNiXiH
         jEvzSwLAoE7ukACTowVZt8aDAb2kjfsexT2pm9UdjBXoyW2j0ghrNpei3/VGpdRy0sEF
         kFrB4NUbRxKl4Wt5VkHlbYRpq/MnjmxbnW1RCfDl01DKdoVHC7hIQV4ccWZWKX/cAiHi
         KzZ0R4l6u9ddBeIAynwWlzsa7ORuFXs1mVUJT6Bkc2qq6Fcp6jzDiqZHJVMwidwxMibU
         4ozs6ZlZ7JNUAOzXWyozY4NvHJH5RSqKB7V5/EET0nNrjRw+VirHCqWUKWV32sGpuI1K
         Bbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VChHloUEaWOlrKvLqXZY/4hOTJitrriVgYa80li7NMI=;
        b=EPpP42lZZT+WDLsenK6itwi4LXoXsfgEjvQCgogMr8Vtx5LLzjp3PVO5V1ZeunKe7w
         jsEDTp2UeMVv8jkZcXN+juUe1mrXr7ZB98ZbWes7M1nvoNw7L6p4PTm1Aw7BBSHBGBog
         ZVzPFoPlhM2TOLMORNCuCf+HYLXaJtCCnpG0JgvA9vL2IxnWCoUzR0J+p+D7Ow2Qi1B6
         XIDkLJn4BGKBAN2FLtZ2dP8i7MM4AUWnjrz+XWhLRV4QfwxfqtchM5oMuu87aNRlHksh
         DpZu6gbJMroMPaybGoo5vSchF+L/lJPw09J4okcW1qsv0XbkDiTpnCiICDpNy5u/uYrM
         r8rw==
X-Gm-Message-State: AOAM530yg7LIH9YOWYeP/6U6+EXU0IMaNLnuEqOW7ZQgj/CnxkA2CXX+
        e9Zn+zEQ+U91GIxCVWk7gNWkT5uSaAVBww==
X-Google-Smtp-Source: ABdhPJz8ua3OMOHDoMDjwKtgnyB2pWJB+qlihcjotYvND8wHJhrj/cnEh3Ed2DSJ0wI5ZIBEfh4HLA==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr30619697wrq.61.1632164666433;
        Mon, 20 Sep 2021 12:04:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 00/17] fsck: lib-ify object-file.c & better fsck "invalid object" error reporting
Date:   Mon, 20 Sep 2021 21:04:04 +0200
Message-Id: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This improves fsck error reporting, see the examples in the commit
messages of 16/17 and 17/17. To get there I've lib-ified more things
in object-file.c and the general object APIs, i.e. now we'll return
error codes instead of calling die() in these cases.

v6 of this got a very detailed review from Taylor Blau (thanks a
lot!), for the v6 see:
https://lore.kernel.org/git/cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com/

This should address all of the things brought up, and more. After
leaving this series for a while I came up with ways to simplify it
even more, so now it's 17 instead of 22 patches!

So things like:

 * The move of functions from cache.h to object-store.h is gone, that
   still makes sense to do, but can be left for later.

 * A large part of the mid-series is squashed together and
   re-arranged, e.g. I moved the migration of unpack_loose_header() to
   to an enum earlier, which simplified later steps. The 15/17 rewrite
   of much of parse_loose_header() is now much simpler.

  * I attempted to address the comments about the tests with some
    for-loops and boilerplate-generated testing, maybe some of it's a
    bit too ugly, but it's both less copy/pasting now, and more cases
    (e.g. the "cat-file -p" case) are tested.

 * We now test for what happens/error reporting when we append garbage
   to a loose object.

 * Many more small changes / improvements / simplifications, see the
   range-diff below, but given its size perhaps a re-read is easier...

Ævar Arnfjörð Bjarmason (17):
  fsck tests: add test for fsck-ing an unknown type
  fsck tests: refactor one test to use a sub-repo
  fsck tests: test current hash/type mismatch behavior
  fsck tests: test for garbage appended to a loose object
  cat-file tests: move bogus_* variable declarations earlier
  cat-file tests: test for missing/bogus object with -t, -s and -p
  cat-file tests: add corrupt loose object test
  cat-file tests: test for current --allow-unknown-type behavior
  object-file.c: don't set "typep" when returning non-zero
  object-file.c: return -1, not "status" from unpack_loose_header()
  object-file.c: make parse_loose_header_extended() public
  object-file.c: simplify unpack_loose_short_header()
  object-file.c: use "enum" return type for unpack_loose_header()
  object-file.c: return ULHR_TOO_LONG on "header too long"
  object-file.c: stop dying in parse_loose_header()
  fsck: don't hard die on invalid object types
  fsck: report invalid object type-path combinations

 builtin/fast-export.c |   2 +-
 builtin/fsck.c        |  28 +++++-
 builtin/index-pack.c  |   2 +-
 builtin/mktag.c       |   3 +-
 cache.h               |  45 ++++++++-
 object-file.c         | 176 +++++++++++++++------------------
 object-store.h        |   7 +-
 object.c              |   4 +-
 pack-check.c          |   3 +-
 streaming.c           |  27 +++--
 t/oid-info/oid        |   2 +
 t/t1006-cat-file.sh   | 223 +++++++++++++++++++++++++++++++++++++++---
 t/t1450-fsck.sh       |  99 +++++++++++++++----
 13 files changed, 463 insertions(+), 158 deletions(-)

Range-diff against v6:
 2:  9072eef3be3 !  1:  752cef556c2 fsck tests: add test for fsck-ing an unknown type
    @@ t/t1450-fsck.sh: test_expect_success 'detect corrupt index file in fsck' '
      
     +test_expect_success 'fsck hard errors on an invalid object type' '
     +	git init --bare garbage-type &&
    -+	empty_blob=$(git -C garbage-type hash-object --stdin -w -t blob </dev/null) &&
    -+	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
    -+	cat >err.expect <<-\EOF &&
    -+	fatal: invalid object type
    -+	EOF
    -+	test_must_fail git -C garbage-type fsck >out.actual 2>err.actual &&
    -+	test_cmp err.expect err.actual &&
    -+	test_must_be_empty out.actual
    ++	(
    ++		cd garbage-type &&
    ++
    ++		empty=$(git hash-object --stdin -w -t blob </dev/null) &&
    ++		garbage=$(git hash-object --stdin -w -t garbage --literally </dev/null) &&
    ++
    ++		cat >err.expect <<-\EOF &&
    ++		fatal: invalid object type
    ++		EOF
    ++		test_must_fail git fsck >out 2>err &&
    ++		test_cmp err.expect err &&
    ++		test_must_be_empty out
    ++	)
     +'
     +
      test_done
 1:  ebe89f65354 !  2:  612003bdd2c fsck tests: refactor one test to use a sub-repo
    @@ Commit message
         teardown of a tests so we're not leaving corrupt content for the next
         test.
     
    -    We should instead simply use something like this test_create_repo
    -    pattern. It's both less verbose, and makes things easier to debug as a
    -    failing test can have their state left behind under -d without
    -    damaging the state for other tests.
    +    We can instead use the pattern of creating a named sub-repository,
    +    then we don't have to worry about cleaning up after ourselves, nobody
    +    will care what state the broken "hash-mismatch" repository is after
    +    this test runs.
     
    -    But let's punt on that general refactoring and just change this one
    -    test, I'm going to change it further in subsequent commits.
    +    See [1] for related discussion on various "modern" test patterns that
    +    can be used to avoid verbosity and increase reliability.
    +
    +    1. https://lore.kernel.org/git/87y27veeyj.fsf@evledraar.gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/t1450-fsck.sh: remove_object () {
     -	test_when_finished "remove_object $cmt" &&
     -	git update-ref refs/heads/bogus $cmt &&
     -	test_when_finished "git update-ref -d refs/heads/bogus" &&
    --
    --	test_must_fail git fsck 2>out &&
    --	test_i18ngrep "$sha.*corrupt" out
     +test_expect_success 'object with hash mismatch' '
     +	git init --bare hash-mismatch &&
     +	(
     +		cd hash-mismatch &&
    + 
    +-	test_must_fail git fsck 2>out &&
    +-	test_i18ngrep "$sha.*corrupt" out
     +		oid=$(echo blob | git hash-object -w --stdin) &&
     +		old=$(test_oid_to_path "$oid") &&
     +		new=$(dirname $old)/$(test_oid ff_2) &&
     +		oid="$(dirname $new)$(basename $new)" &&
    ++
     +		mv objects/$old objects/$new &&
     +		git update-index --add --cacheinfo 100644 $oid foo &&
     +		tree=$(git write-tree) &&
     +		cmt=$(echo bogus | git commit-tree $tree) &&
     +		git update-ref refs/heads/bogus $cmt &&
    ++
     +		test_must_fail git fsck 2>out &&
    -+		test_i18ngrep "$oid.*corrupt" out
    ++		grep "$oid.*corrupt" out
     +	)
      '
      
 3:  d442a309178 !  3:  1e40a4235e9 cat-file tests: test for missing object with -t and -s
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    cat-file tests: test for missing object with -t and -s
    +    fsck tests: test current hash/type mismatch behavior
     
    -    Test for what happens when the -t and -s flags are asked to operate on
    -    a missing object, this extends tests added in 3e370f9faf0 (t1006: add
    -    tests for git cat-file --allow-unknown-type, 2015-05-03). The -t and
    -    -s flags are the only ones that can be combined with
    -    --allow-unknown-type, so let's test with and without that flag.
    +    If fsck we move an object around between .git/objects/?? directories
    +    to simulate a hash mismatch "git fsck" will currently hard die() in
    +    object-file.c. This behavior will be fixed in subsequent commits, but
    +    let's test for it as-is for now.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## t/t1006-cat-file.sh ##
    -@@ t/t1006-cat-file.sh: test_expect_success '%(deltabase) reports packed delta bases' '
    - 	}
    + ## t/t1450-fsck.sh ##
    +@@ t/t1450-fsck.sh: test_expect_success 'object with hash mismatch' '
    + 	)
      '
      
    -+missing_oid=$(test_oid deadbeef)
    -+test_expect_success 'error on type of missing object' '
    -+	cat >expect.err <<-\EOF &&
    -+	fatal: git cat-file: could not get object info
    -+	EOF
    -+	test_must_fail git cat-file -t $missing_oid >out 2>err &&
    -+	test_must_be_empty out &&
    -+	test_cmp expect.err err &&
    ++test_expect_success 'object with hash and type mismatch' '
    ++	git init --bare hash-type-mismatch &&
    ++	(
    ++		cd hash-type-mismatch &&
     +
    -+	test_must_fail git cat-file -t --allow-unknown-type $missing_oid >out 2>err &&
    -+	test_must_be_empty out &&
    -+	test_cmp expect.err err
    -+'
    ++		oid=$(echo blob | git hash-object -w --stdin -t garbage --literally) &&
    ++		old=$(test_oid_to_path "$oid") &&
    ++		new=$(dirname $old)/$(test_oid ff_2) &&
    ++		oid="$(dirname $new)$(basename $new)" &&
     +
    -+test_expect_success 'error on size of missing object' '
    -+	cat >expect.err <<-\EOF &&
    -+	fatal: git cat-file: could not get object info
    -+	EOF
    -+	test_must_fail git cat-file -s $missing_oid >out 2>err &&
    -+	test_must_be_empty out &&
    -+	test_cmp expect.err err &&
    ++		mv objects/$old objects/$new &&
    ++		git update-index --add --cacheinfo 100644 $oid foo &&
    ++		tree=$(git write-tree) &&
    ++		cmt=$(echo bogus | git commit-tree $tree) &&
    ++		git update-ref refs/heads/bogus $cmt &&
     +
    -+	test_must_fail git cat-file -s --allow-unknown-type $missing_oid >out 2>err &&
    -+	test_must_be_empty out &&
    -+	test_cmp expect.err err
    ++		cat >expect <<-\EOF &&
    ++		fatal: invalid object type
    ++		EOF
    ++		test_must_fail git fsck 2>actual &&
    ++		test_cmp expect actual
    ++	)
     +'
     +
    - bogus_type="bogus"
    - bogus_content="bogus"
    - bogus_size=$(strlen "$bogus_content")
    + test_expect_success 'branch pointing to non-commit' '
    + 	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
    + 	test_when_finished "git update-ref -d refs/heads/invalid" &&
 5:  82db40ebf8a !  4:  854991c1543 rev-list tests: test for behavior with invalid object types
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    rev-list tests: test for behavior with invalid object types
    +    fsck tests: test for garbage appended to a loose object
     
    -    Fix a blindspot in the tests for the "rev-list --disk-usage" feature
    -    added in 16950f8384a (rev-list: add --disk-usage option for
    -    calculating disk usage, 2021-02-09) to test for what happens when it's
    -    asked to calculate the disk usage of invalid object types.
    +    There wasn't any output tests for this scenario, let's ensure that we
    +    don't regress on it in the changes that come after this.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## t/t6115-rev-list-du.sh ##
    -@@ t/t6115-rev-list-du.sh: check_du HEAD
    - check_du --objects HEAD
    - check_du --objects HEAD^..HEAD
    + ## t/t1450-fsck.sh ##
    +@@ t/t1450-fsck.sh: test_expect_success 'object with hash and type mismatch' '
    + 	)
    + '
      
    -+test_expect_success 'setup garbage repository' '
    -+	git clone --bare . garbage.git &&
    -+	garbage_oid=$(git -C garbage.git hash-object -t garbage -w --stdin --literally <one.t) &&
    -+	git -C garbage.git rev-list --objects --all --disk-usage &&
    ++test_expect_success POSIXPERM 'zlib corrupt loose object output ' '
    ++	git init --bare corrupt-loose-output &&
    ++	(
    ++		cd corrupt-loose-output &&
    ++		oid=$(git hash-object -w --stdin --literally </dev/null) &&
    ++		oidf=objects/$(test_oid_to_path "$oid") &&
    ++		chmod 755 $oidf &&
    ++		echo extra garbage >>$oidf &&
     +
    -+	# Manually create a ref because "update-ref", "tag" etc. have
    -+	# no corresponding --literally option.
    -+	echo $garbage_oid >garbage.git/refs/tags/garbage-tag &&
    -+	test_must_fail git -C garbage.git rev-list --objects --all --disk-usage
    ++		cat >expect.error <<-EOF &&
    ++		error: garbage at end of loose object '\''$oid'\''
    ++		error: unable to unpack contents of ./$oidf
    ++		error: $oid: object corrupt or missing: ./$oidf
    ++		EOF
    ++		test_must_fail git fsck 2>actual &&
    ++		grep ^error: actual >error &&
    ++		test_cmp expect.error error
    ++	)
     +'
     +
    - test_done
    + test_expect_success 'branch pointing to non-commit' '
    + 	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
    + 	test_when_finished "git update-ref -d refs/heads/invalid" &&
19:  ad1614dbb8d !  5:  fc93c2c2530 fsck: don't hard die on invalid object types
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    fsck: don't hard die on invalid object types
    +    cat-file tests: move bogus_* variable declarations earlier
     
    -    Change the error fsck emits on invalid object types, such as:
    -
    -        $ git hash-object --stdin -w -t garbage --literally </dev/null
    -        <OID>
    -
    -    From the very ungraceful error of:
    -
    -        $ git fsck
    -        fatal: invalid object type
    -        $
    -
    -    To:
    -
    -        $ git fsck
    -        error: hash mismatch for <OID_PATH> (expected <OID>)
    -        error: <OID>: object corrupt or missing: <OID_PATH>
    -        [ the rest of the fsck output here, i.e. it didn't hard die ]
    -
    -    We'll still exit with non-zero, but now we'll finish the rest of the
    -    traversal. The tests that's being added here asserts that we'll still
    -    complain about other fsck issues (e.g. an unrelated dangling blob).
    -
    -    To do this we need to pass down the "OBJECT_INFO_ALLOW_UNKNOWN_TYPE"
    -    flag from read_loose_object() through to parse_loose_header(). Since
    -    the read_loose_object() function is only used in builtin/fsck.c we can
    -    simply change it. See f6371f92104 (sha1_file: add read_loose_object()
    -    function, 2017-01-13) for the introduction of read_loose_object().
    -
    -    Why are we complaining about a "hash mismatch" for an object of a type
    -    we don't know about? We shouldn't. This is the bare minimal change
    -    needed to not make fsck hard die on a repository that's been corrupted
    -    in this manner. In subsequent commits we'll teach fsck to recognize
    -    this particular type of corruption and emit a better error message.
    +    Change the short/long bogus bogus object type variables into a form
    +    where the two sets can be used concurrently. This'll be used by
    +    subsequently added tests.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/fsck.c ##
    -@@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *path, void *data)
    - 	void *contents;
    - 	int eaten;
    + ## t/t1006-cat-file.sh ##
    +@@ t/t1006-cat-file.sh: test_expect_success '%(deltabase) reports packed delta bases' '
    + 	}
    + '
      
    --	if (read_loose_object(path, oid, &type, &size, &contents) < 0) {
    -+	if (read_loose_object(path, oid, &type, &size, &contents,
    -+			      OBJECT_INFO_ALLOW_UNKNOWN_TYPE) < 0) {
    - 		errors_found |= ERROR_OBJECT;
    - 		error(_("%s: object corrupt or missing: %s"),
    - 		      oid_to_hex(oid), path);
    -
    - ## object-file.c ##
    -@@ object-file.c: int read_loose_object(const char *path,
    - 		      const struct object_id *expected_oid,
    - 		      enum object_type *type,
    - 		      unsigned long *size,
    --		      void **contents)
    -+		      void **contents,
    -+		      unsigned int oi_flags)
    - {
    - 	int ret = -1;
    - 	void *map = NULL;
    -@@ object-file.c: int read_loose_object(const char *path,
    - 	git_zstream stream;
    - 	char hdr[MAX_HEADER_LEN];
    - 	struct object_info oi = OBJECT_INFO_INIT;
    -+	int allow_unknown = oi_flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
    - 	oi.typep = type;
    - 	oi.sizep = size;
    +-bogus_type="bogus"
    +-bogus_content="bogus"
    +-bogus_size=$(strlen "$bogus_content")
    +-bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
    ++test_expect_success 'setup bogus data' '
    ++	bogus_short_type="bogus" &&
    ++	bogus_short_content="bogus" &&
    ++	bogus_short_size=$(strlen "$bogus_short_content") &&
    ++	bogus_short_sha1=$(echo_without_newline "$bogus_short_content" | git hash-object -t $bogus_short_type --literally -w --stdin) &&
    ++
    ++	bogus_long_type="abcdefghijklmnopqrstuvwxyz1234679" &&
    ++	bogus_long_content="bogus" &&
    ++	bogus_long_size=$(strlen "$bogus_long_content") &&
    ++	bogus_long_sha1=$(echo_without_newline "$bogus_long_content" | git hash-object -t $bogus_long_type --literally -w --stdin)
    ++'
      
    -@@ object-file.c: int read_loose_object(const char *path,
    - 		git_inflate_end(&stream);
    - 		goto out;
    - 	}
    --	if (*type < 0)
    --		die(_("invalid object type"));
    -+	if (!allow_unknown && *type < 0) {
    -+		error(_("header for %s declares an unknown type"), path);
    -+		git_inflate_end(&stream);
    -+		goto out;
    -+	}
    + test_expect_success "Type of broken object is correct" '
    +-	echo $bogus_type >expect &&
    +-	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
    ++	echo $bogus_short_type >expect &&
    ++	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
    + 	test_cmp expect actual
    + '
      
    - 	if (*type == OBJ_BLOB && *size > big_file_threshold) {
    - 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
    -
    - ## object-store.h ##
    -@@ object-store.h: int read_loose_object(const char *path,
    - 		      const struct object_id *expected_oid,
    - 		      enum object_type *type,
    - 		      unsigned long *size,
    --		      void **contents);
    -+		      void **contents,
    -+		      unsigned int oi_flags);
    + test_expect_success "Size of broken object is correct" '
    +-	echo $bogus_size >expect &&
    +-	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
    ++	echo $bogus_short_size >expect &&
    ++	git cat-file -s --allow-unknown-type $bogus_short_sha1 >actual &&
    + 	test_cmp expect actual
    + '
    +-bogus_type="abcdefghijklmnopqrstuvwxyz1234679"
    +-bogus_content="bogus"
    +-bogus_size=$(strlen "$bogus_content")
    +-bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
      
    - /* Retry packed storage after checking packed and loose storage */
    - #define HAS_OBJECT_RECHECK_PACKED 1
    -
    - ## t/t1450-fsck.sh ##
    -@@ t/t1450-fsck.sh: test_expect_success 'detect corrupt index file in fsck' '
    - 	test_i18ngrep "bad index file" errors
    + test_expect_success "Type of broken object is correct when type is large" '
    +-	echo $bogus_type >expect &&
    +-	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
    ++	echo $bogus_long_type >expect &&
    ++	git cat-file -t --allow-unknown-type $bogus_long_sha1 >actual &&
    + 	test_cmp expect actual
      '
      
    --test_expect_success 'fsck hard errors on an invalid object type' '
    -+test_expect_success 'fsck error and recovery on invalid object type' '
    - 	git init --bare garbage-type &&
    - 	empty_blob=$(git -C garbage-type hash-object --stdin -w -t blob </dev/null) &&
    - 	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
    --	cat >err.expect <<-\EOF &&
    --	fatal: invalid object type
    --	EOF
    --	test_must_fail git -C garbage-type fsck >out.actual 2>err.actual &&
    --	test_cmp err.expect err.actual &&
    --	test_must_be_empty out.actual
    -+	test_must_fail git -C garbage-type fsck >out 2>err &&
    -+	grep -e "^error" -e "^fatal" err >errors &&
    -+	test_line_count = 2 errors &&
    -+	grep "error: hash mismatch for" err &&
    -+	grep "$garbage_blob: object corrupt or missing:" err &&
    -+	grep "dangling blob $empty_blob" out
    + test_expect_success "Size of large broken object is correct when type is large" '
    +-	echo $bogus_size >expect &&
    +-	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
    ++	echo $bogus_long_size >expect &&
    ++	git cat-file -s --allow-unknown-type $bogus_long_sha1 >actual &&
    + 	test_cmp expect actual
      '
      
    - test_done
 4:  0358273022f !  6:  051088aa114 cat-file tests: test that --allow-unknown-type isn't on by default
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    cat-file tests: test that --allow-unknown-type isn't on by default
    +    cat-file tests: test for missing/bogus object with -t, -s and -p
     
    -    Fix a blindspot in the tests for the --allow-unknown-type feature
    -    added in 39e4ae38804 (cat-file: teach cat-file a
    -    '--allow-unknown-type' option, 2015-05-03). We should check that
    -    --allow-unknown-type isn't on by default.
    +    When we look up a missing object with cat_one_file() what error we
    +    print out currently depends on whether we'll error out early in
    +    get_oid_with_context(), or if we'll get an error later from
    +    oid_object_info_extended().
     
    -    Before this change all the tests would succeed if --allow-unknown-type
    -    was on by default, let's fix that by asserting that -t and -s die on a
    -    "garbage" type without --allow-unknown-type.
    +    The --allow-unknown-type flag then changes whether we pass the
    +    "OBJECT_INFO_ALLOW_UNKNOWN_TYPE" flag to get_oid_with_context() or
    +    not.
    +
    +    The "-p" flag is yet another special-case in printing the same output
    +    on the deadbeef OID as we'd emit on the deadbeef_short OID for the
    +    "-s" and "-t" options, it also doesn't support the
    +    "--allow-unknown-type" flag at all.
    +
    +    Let's test the combination of the two sets of [-t, -s, -p] and
    +    [--{no-}allow-unknown-type] (the --no-allow-unknown-type is implicit
    +    in not supplying it), as well as a [missing,bogus] object pair.
    +
    +    This extends tests added in 3e370f9faf0 (t1006: add tests for git
    +    cat-file --allow-unknown-type, 2015-05-03).
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## t/oid-info/oid ##
    +@@ t/oid-info/oid: numeric		sha1:0123456789012345678901234567890123456789
    + numeric		sha256:0123456789012345678901234567890123456789012345678901234567890123
    + deadbeef	sha1:deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
    + deadbeef	sha256:deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef
    ++deadbeef_short	sha1:deadbeefdeadbeefdeadbeefdeadbeefdeadbee
    ++deadbee_short	sha256:deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbee
    +
      ## t/t1006-cat-file.sh ##
    -@@ t/t1006-cat-file.sh: bogus_content="bogus"
    - bogus_size=$(strlen "$bogus_content")
    - bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
    +@@ t/t1006-cat-file.sh: test_expect_success 'setup bogus data' '
    + 	bogus_long_sha1=$(echo_without_newline "$bogus_long_content" | git hash-object -t $bogus_long_type --literally -w --stdin)
    + '
      
    -+test_expect_success 'die on broken object under -t and -s without --allow-unknown-type' '
    -+	cat >err.expect <<-\EOF &&
    -+	fatal: invalid object type
    -+	EOF
    ++for arg1 in '' --allow-unknown-type
    ++do
    ++	for arg2 in -s -t -p
    ++	do
    ++		if test $arg1 = "--allow-unknown-type" && test "$arg2" = "-p"
    ++		then
    ++			continue
    ++		fi
    ++
     +
    -+	test_must_fail git cat-file -t $bogus_sha1 >out.actual 2>err.actual &&
    -+	test_cmp err.expect err.actual &&
    -+	test_must_be_empty out.actual &&
    ++		test_expect_success "cat-file $arg1 $arg2 error on bogus short OID" '
    ++			cat >expect <<-\EOF &&
    ++			fatal: invalid object type
    ++			EOF
     +
    -+	test_must_fail git cat-file -s $bogus_sha1 >out.actual 2>err.actual &&
    -+	test_cmp err.expect err.actual &&
    -+	test_must_be_empty out.actual
    -+'
    ++			if test "$arg1" = "--allow-unknown-type"
    ++			then
    ++				git cat-file $arg1 $arg2 $bogus_short_sha1
    ++			else
    ++				test_must_fail git cat-file $arg1 $arg2 $bogus_short_sha1 >out 2>actual &&
    ++				test_must_be_empty out &&
    ++				test_cmp expect actual
    ++			fi
    ++		'
    ++
    ++		test_expect_success "cat-file $arg1 $arg2 error on bogus full OID" '
    ++			if test "$arg2" = "-p"
    ++			then
    ++				cat >expect <<-EOF
    ++				error: unable to unpack $bogus_long_sha1 header
    ++				fatal: Not a valid object name $bogus_long_sha1
    ++				EOF
    ++			else
    ++				cat >expect <<-EOF
    ++				error: unable to unpack $bogus_long_sha1 header
    ++				fatal: git cat-file: could not get object info
    ++				EOF
    ++			fi &&
    ++
    ++			if test "$arg1" = "--allow-unknown-type"
    ++			then
    ++				git cat-file $arg1 $arg2 $bogus_short_sha1
    ++			else
    ++				test_must_fail git cat-file $arg1 $arg2 $bogus_long_sha1 >out 2>actual &&
    ++				test_must_be_empty out &&
    ++				test_cmp expect actual
    ++			fi
    ++		'
    ++
    ++		test_expect_success "cat-file $arg1 $arg2 error on missing short OID" '
    ++			cat >expect.err <<-EOF &&
    ++			fatal: Not a valid object name $(test_oid deadbeef_short)
    ++			EOF
    ++			test_must_fail git cat-file $arg1 $arg2 $(test_oid deadbeef_short) >out 2>err.actual &&
    ++			test_must_be_empty out
    ++		'
    ++
    ++		test_expect_success "cat-file $arg1 $arg2 error on missing full OID" '
    ++			if test "$arg2" = "-p"
    ++			then
    ++				cat >expect.err <<-EOF
    ++				fatal: Not a valid object name $(test_oid deadbeef)
    ++				EOF
    ++			else
    ++				cat >expect.err <<-\EOF
    ++				fatal: git cat-file: could not get object info
    ++				EOF
    ++			fi &&
    ++			test_must_fail git cat-file $arg1 $arg2 $(test_oid deadbeef) >out 2>err.actual &&
    ++			test_must_be_empty out &&
    ++			test_cmp expect.err err.actual
    ++		'
    ++	done
    ++done
     +
      test_expect_success "Type of broken object is correct" '
    - 	echo $bogus_type >expect &&
    - 	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
    -@@ t/t1006-cat-file.sh: bogus_content="bogus"
    - bogus_size=$(strlen "$bogus_content")
    - bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
    - 
    -+test_expect_success 'die on broken object with large type under -t and -s without --allow-unknown-type' '
    -+	cat >err.expect <<-EOF &&
    -+	error: unable to unpack $bogus_sha1 header
    -+	fatal: git cat-file: could not get object info
    -+	EOF
    -+
    -+	test_must_fail git cat-file -t $bogus_sha1 >out.actual 2>err.actual &&
    -+	test_cmp err.expect err.actual &&
    -+	test_must_be_empty out.actual &&
    -+
    -+	test_must_fail git cat-file -s $bogus_sha1 >out.actual 2>err.actual &&
    -+	test_cmp err.expect err.actual &&
    -+	test_must_be_empty out.actual
    -+'
    -+
    - test_expect_success "Type of broken object is correct when type is large" '
    - 	echo $bogus_type >expect &&
    - 	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
    + 	echo $bogus_short_type >expect &&
    + 	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
 6:  d1ffd21acc5 =  7:  20bd81c1af0 cat-file tests: add corrupt loose object test
 7:  22ab12c2282 !  8:  cd1d52b8a07 cat-file tests: test for current --allow-unknown-type behavior
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t1006-cat-file.sh ##
    -@@ t/t1006-cat-file.sh: test_expect_success 'die on broken object under -t and -s without --allow-unknow
    - 	test_must_be_empty out.actual
    - '
    +@@ t/t1006-cat-file.sh: do
    + 	done
    + done
      
     +test_expect_success '-e is OK with a broken object without --allow-unknown-type' '
    -+	git cat-file -e $bogus_sha1
    ++	git cat-file -e $bogus_short_sha1
     +'
     +
     +test_expect_success '-e can not be combined with --allow-unknown-type' '
    -+	test_expect_code 128 git cat-file -e --allow-unknown-type $bogus_sha1
    ++	test_expect_code 128 git cat-file -e --allow-unknown-type $bogus_short_sha1
     +'
     +
     +test_expect_success '-p cannot print a broken object even with --allow-unknown-type' '
    -+	test_must_fail git cat-file -p $bogus_sha1 &&
    -+	test_expect_code 128 git cat-file -p --allow-unknown-type $bogus_sha1
    ++	test_must_fail git cat-file -p $bogus_short_sha1 &&
    ++	test_expect_code 128 git cat-file -p --allow-unknown-type $bogus_short_sha1
     +'
     +
     +test_expect_success '<type> <hash> does not work with objects of broken types' '
     +	cat >err.expect <<-\EOF &&
     +	fatal: invalid object type "bogus"
     +	EOF
    -+	test_must_fail git cat-file $bogus_type $bogus_sha1 2>err.actual &&
    ++	test_must_fail git cat-file $bogus_short_type $bogus_short_sha1 2>err.actual &&
     +	test_cmp err.expect err.actual
     +'
     +
     +test_expect_success 'broken types combined with --batch and --batch-check' '
    -+	echo $bogus_sha1 >bogus-oid &&
    ++	echo $bogus_short_sha1 >bogus-oid &&
     +
     +	cat >err.expect <<-\EOF &&
     +	fatal: invalid object type
    @@ t/t1006-cat-file.sh: test_expect_success 'die on broken object under -t and -s w
     +	test_expect_code 128 git cat-file --batch --allow-unknown-type <bogus-oid &&
     +	test_expect_code 128 git cat-file --batch-check --allow-unknown-type <bogus-oid
     +'
    -+
    - test_expect_success "Type of broken object is correct" '
    - 	echo $bogus_type >expect &&
    - 	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
    -@@ t/t1006-cat-file.sh: test_expect_success "Size of broken object is correct" '
    - 	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
    - 	test_cmp expect actual
    - '
     +
     +test_expect_success 'the --allow-unknown-type option does not consider replacement refs' '
     +	cat >expect <<-EOF &&
    -+	$bogus_type
    ++	$bogus_short_type
     +	EOF
    -+	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
    ++	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
     +	test_cmp expect actual &&
     +
     +	# Create it manually, as "git replace" will die on bogus
     +	# types.
     +	head=$(git rev-parse --verify HEAD) &&
    ++	test_when_finished "rm -rf .git/refs/replace" &&
     +	mkdir -p .git/refs/replace &&
    -+	echo $head >.git/refs/replace/$bogus_sha1 &&
    ++	echo $head >.git/refs/replace/$bogus_short_sha1 &&
     +
     +	cat >expect <<-EOF &&
     +	commit
     +	EOF
    -+	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
    ++	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
     +	test_cmp expect actual
     +'
     +
    - bogus_type="abcdefghijklmnopqrstuvwxyz1234679"
    - bogus_content="bogus"
    - bogus_size=$(strlen "$bogus_content")
    + test_expect_success "Type of broken object is correct" '
    + 	echo $bogus_short_type >expect &&
    + 	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
 8:  38e4266772d =  9:  d9f5adfc74b object-file.c: don't set "typep" when returning non-zero
 9:  5b9278e7bb4 <  -:  ----------- cache.h: move object functions to object-store.h
16:  9e7dbfb4aa3 ! 10:  51d14bc9274 object-file.c: return -1, not "status" from unpack_loose_header()
    @@ Commit message
     
      ## object-file.c ##
     @@ object-file.c: int unpack_loose_header(git_zstream *stream,
    - 	status = git_inflate(stream, 0);
    - 	obj_read_lock();
    + 					       buffer, bufsiz);
    + 
      	if (status < Z_OK)
     -		return status;
     +		return -1;
      
    - 	/*
    - 	 * Check if entire header is unpacked in the first iteration.
    + 	/* Make sure we have the terminating NUL */
    + 	if (!memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
10:  b15ad53414b ! 11:  f43cfd8a5ed object-file.c: make parse_loose_header_extended() public
    @@ Commit message
         could simply use parse_loose_header_extended() there, but will leave
         the API in a better end state.
     
    +    It would be a better end-state to have already moved the declaration
    +    of these functions to object-store.h to avoid the forward declaration
    +    of "struct object_info" in cache.h, but let's leave that cleanup for
    +    some other time.
    +
    +    1. https://lore.kernel.org/git/patch-v6-09.22-5b9278e7bb4-20210907T104559Z-avarab@gmail.com/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## cache.h ##
    +@@ cache.h: char *xdg_cache_home(const char *filename);
    + int git_open_cloexec(const char *name, int flags);
    + #define git_open(name) git_open_cloexec(name, O_RDONLY)
    + int unpack_loose_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
    +-int parse_loose_header(const char *hdr, unsigned long *sizep);
    ++struct object_info;
    ++int parse_loose_header(const char *hdr, struct object_info *oi,
    ++		       unsigned int flags);
    + 
    + int check_object_signature(struct repository *r, const struct object_id *oid,
    + 			   void *buf, unsigned long size, const char *type);
    +
      ## object-file.c ##
     @@ object-file.c: static void *unpack_loose_rest(git_zstream *stream,
       * too permissive for what we want to check. So do an anal
    @@ object-file.c: static void *unpack_loose_rest(git_zstream *stream,
       */
     -static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
     -				       unsigned int flags)
    -+int parse_loose_header(const char *hdr,
    -+		       struct object_info *oi,
    ++int parse_loose_header(const char *hdr, struct object_info *oi,
     +		       unsigned int flags)
      {
      	const char *type_buf = hdr;
    @@ object-file.c: int read_loose_object(const char *path,
      		error(_("unable to parse header of %s"), path);
      		git_inflate_end(&stream);
     
    - ## object-store.h ##
    -@@ object-store.h: int for_each_packed_object(each_packed_object_fn, void *,
    - int unpack_loose_header(git_zstream *stream, unsigned char *map,
    - 			unsigned long mapsize, void *buffer,
    - 			unsigned long bufsiz);
    --int parse_loose_header(const char *hdr, unsigned long *sizep);
    -+int parse_loose_header(const char *hdr, struct object_info *oi,
    -+		       unsigned int flags);
    - int check_object_signature(struct repository *r, const struct object_id *oid,
    - 			   void *buf, unsigned long size, const char *type);
    - int finalize_object_file(const char *tmpfile, const char *filename);
    -
      ## streaming.c ##
     @@ streaming.c: static int open_istream_loose(struct git_istream *st, struct repository *r,
      			      const struct object_id *oid,
11:  326eb74545d <  -:  ----------- object-file.c: add missing braces to loose_object_info()
12:  4f829e9b727 ! 12:  50d938f7f3c object-file.c: simplify unpack_loose_short_header()
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## cache.h ##
    +@@ cache.h: char *xdg_cache_home(const char *filename);
    + 
    + int git_open_cloexec(const char *name, int flags);
    + #define git_open(name) git_open_cloexec(name, O_RDONLY)
    +-int unpack_loose_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
    ++
    ++/**
    ++ * unpack_loose_header() initializes the data stream needed to unpack
    ++ * a loose object header.
    ++ *
    ++ * Returns 0 on success. Returns negative values on error.
    ++ *
    ++ * It will only parse up to MAX_HEADER_LEN bytes unless an optional
    ++ * "hdrbuf" argument is non-NULL. This is intended for use with
    ++ * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
    ++ * reporting. The full header will be extracted to "hdrbuf" for use
    ++ * with parse_loose_header().
    ++ */
    ++int unpack_loose_header(git_zstream *stream, unsigned char *map,
    ++			unsigned long mapsize, void *buffer,
    ++			unsigned long bufsiz, struct strbuf *hdrbuf);
    + struct object_info;
    + int parse_loose_header(const char *hdr, struct object_info *oi,
    + 		       unsigned int flags);
    +
      ## object-file.c ##
     @@ object-file.c: void *map_loose_object(struct repository *r,
      	return map_loose_object_1(r, NULL, oid, size);
    @@ object-file.c: static int unpack_loose_short_header(git_zstream *stream,
     -	int status = unpack_loose_short_header(stream, map, mapsize,
     -					       buffer, bufsiz);
     -
    - 	if (status < Z_OK)
    - 		return status;
    - 
    +-	if (status < Z_OK)
    +-		return -1;
    +-
     -	/* Make sure we have the terminating NUL */
     -	if (!memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
     -		return -1;
    @@ object-file.c: static int unpack_loose_short_header(git_zstream *stream,
     -	int status;
     -
     -	status = unpack_loose_short_header(stream, map, mapsize, buffer, bufsiz);
    --	if (status < Z_OK)
    --		return -1;
    --
    - 	/*
    - 	 * Check if entire header is unpacked in the first iteration.
    - 	 */
    + 	if (status < Z_OK)
    + 		return -1;
    + 
    +@@ object-file.c: static int unpack_loose_header_to_strbuf(git_zstream *stream, unsigned char *map
      	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
      		return 0;
      
    @@ object-file.c: static int unpack_loose_short_header(git_zstream *stream,
      	 * buffer[0..bufsiz] was not large enough.  Copy the partial
      	 * result out to header, and then append the result of further
     @@ object-file.c: static int loose_object_info(struct repository *r,
    - 	unsigned long mapsize;
    - 	void *map;
    - 	git_zstream stream;
    -+	int hdr_ret;
      	char hdr[MAX_HEADER_LEN];
      	struct strbuf hdrbuf = STRBUF_INIT;
      	unsigned long size_scratch;
    @@ object-file.c: static int loose_object_info(struct repository *r,
     -		if (unpack_loose_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
     -			status = error(_("unable to unpack %s header with --allow-unknown-type"),
     -				       oid_to_hex(oid));
    --	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
    +-	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
     +
    -+	hdr_ret = unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
    -+				      allow_unknown ? &hdrbuf : NULL);
    -+	if (hdr_ret < 0) {
    ++	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
    ++				allow_unknown ? &hdrbuf : NULL) < 0)
      		status = error(_("unable to unpack %s header"),
      			       oid_to_hex(oid));
    - 	}
    + 	if (status < 0)
     @@ object-file.c: int read_loose_object(const char *path,
      		goto out;
      	}
    @@ object-file.c: int read_loose_object(const char *path,
      		goto out;
      	}
     
    - ## object-store.h ##
    -@@ object-store.h: int for_each_object_in_pack(struct packed_git *p,
    - int for_each_packed_object(each_packed_object_fn, void *,
    - 			   enum for_each_object_flags flags);
    - 
    -+/**
    -+ * unpack_loose_header() initializes the data stream needed to unpack
    -+ * a loose object header.
    -+ *
    -+ * Returns 0 on success. Returns negative values on error.
    -+ *
    -+ * It will only parse up to MAX_HEADER_LEN bytes unless an optional
    -+ * "hdrbuf" argument is non-NULL. This is intended for use with
    -+ * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
    -+ * reporting. The full header will be extracted to "hdrbuf" for use
    -+ * with parse_loose_header().
    -+ */
    - int unpack_loose_header(git_zstream *stream, unsigned char *map,
    - 			unsigned long mapsize, void *buffer,
    --			unsigned long bufsiz);
    -+			unsigned long bufsiz, struct strbuf *hdrbuf);
    - int parse_loose_header(const char *hdr, struct object_info *oi,
    - 		       unsigned int flags);
    - int check_object_signature(struct repository *r, const struct object_id *oid,
    -
      ## streaming.c ##
     @@ streaming.c: static int open_istream_loose(struct git_istream *st, struct repository *r,
      				 st->u.loose.mapped,
13:  90489d9e6ec <  -:  ----------- object-file.c: split up ternary in parse_loose_header()
18:  1b7173a5b5b ! 13:  755fde00b46 object-file.c: use "enum" return type for unpack_loose_header()
    @@ Metadata
      ## Commit message ##
         object-file.c: use "enum" return type for unpack_loose_header()
     
    -    In the preceding commits we changed and documented
    -    unpack_loose_header() from return any negative value or zero, to only
    -    -2, -1 or 0. Let's instead add an "enum unpack_loose_header_result"
    -    type and use it, and have the compiler assert that we're exhaustively
    -    covering all return values. This gets rid of the need for having a
    -    "default" BUG() case in loose_object_info().
    +    In a preceding commit we changed and documented unpack_loose_header()
    +    from its previous behavior of returning any negative value or zero, to
    +    only -1 or 0.
     
    -    I'm on the fence about whether this is more readable or worth it, but
    -    since it was suggested in [1] to do this let's go for it.
    -
    -    1. https://lore.kernel.org/git/20210527175433.2673306-1-jonathantanmy@google.com/
    +    Let's add an "enum unpack_loose_header_result" type and use it for
    +    these return values, and have the compiler assert that we're
    +    exhaustively covering all of them.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## cache.h ##
    +@@ cache.h: int git_open_cloexec(const char *name, int flags);
    +  * unpack_loose_header() initializes the data stream needed to unpack
    +  * a loose object header.
    +  *
    +- * Returns 0 on success. Returns negative values on error.
    ++ * Returns:
    ++ *
    ++ * - ULHR_OK on success
    ++ * - ULHR_BAD on error
    +  *
    +  * It will only parse up to MAX_HEADER_LEN bytes unless an optional
    +  * "hdrbuf" argument is non-NULL. This is intended for use with
    +@@ cache.h: int git_open_cloexec(const char *name, int flags);
    +  * reporting. The full header will be extracted to "hdrbuf" for use
    +  * with parse_loose_header().
    +  */
    +-int unpack_loose_header(git_zstream *stream, unsigned char *map,
    +-			unsigned long mapsize, void *buffer,
    +-			unsigned long bufsiz, struct strbuf *hdrbuf);
    ++enum unpack_loose_header_result {
    ++	ULHR_OK,
    ++	ULHR_BAD,
    ++};
    ++enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
    ++						    unsigned char *map,
    ++						    unsigned long mapsize,
    ++						    void *buffer,
    ++						    unsigned long bufsiz,
    ++						    struct strbuf *hdrbuf);
    ++
    + struct object_info;
    + int parse_loose_header(const char *hdr, struct object_info *oi,
    + 		       unsigned int flags);
    +
      ## object-file.c ##
     @@ object-file.c: void *map_loose_object(struct repository *r,
      	return map_loose_object_1(r, NULL, oid, size);
    @@ object-file.c: void *map_loose_object(struct repository *r,
      {
      	int status;
      
    +@@ object-file.c: int unpack_loose_header(git_zstream *stream,
    + 	status = git_inflate(stream, 0);
    + 	obj_read_lock();
    + 	if (status < Z_OK)
    +-		return -1;
    ++		return ULHR_BAD;
    + 
    + 	/*
    + 	 * Check if entire header is unpacked in the first iteration.
    + 	 */
    + 	if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
    +-		return 0;
    ++		return ULHR_OK;
    + 
    + 	/*
    + 	 * We have a header longer than MAX_HEADER_LEN. The "header"
    +@@ object-file.c: int unpack_loose_header(git_zstream *stream,
    + 	 * --allow-unknown-type".
    + 	 */
    + 	if (!header)
    +-		return -1;
    ++		return ULHR_BAD;
    + 
    + 	/*
    + 	 * buffer[0..bufsiz] was not large enough.  Copy the partial
    +@@ object-file.c: int unpack_loose_header(git_zstream *stream,
    + 		stream->next_out = buffer;
    + 		stream->avail_out = bufsiz;
    + 	} while (status != Z_STREAM_END);
    +-	return -1;
    ++	return ULHR_BAD;
    + }
    + 
    + static void *unpack_loose_rest(git_zstream *stream,
     @@ object-file.c: static int loose_object_info(struct repository *r,
    - 	unsigned long mapsize;
    - 	void *map;
    - 	git_zstream stream;
    --	int hdr_ret;
    -+	enum unpack_loose_header_result hdr_ret;
    - 	char hdr[MAX_HEADER_LEN];
    - 	struct strbuf hdrbuf = STRBUF_INIT;
    - 	unsigned long size_scratch;
    -@@ object-file.c: static int loose_object_info(struct repository *r,
    - 	hdr_ret = unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
    - 				      allow_unknown ? &hdrbuf : NULL);
    - 	switch (hdr_ret) {
    --	case 0:
    -+	case UNPACK_LOOSE_HEADER_RESULT_OK:
    - 		break;
    --	case -1:
    -+	case UNPACK_LOOSE_HEADER_RESULT_BAD:
    + 	if (oi->disk_sizep)
    + 		*oi->disk_sizep = mapsize;
    + 
    +-	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
    +-				allow_unknown ? &hdrbuf : NULL) < 0)
    ++	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
    ++				    allow_unknown ? &hdrbuf : NULL)) {
    ++	case ULHR_OK:
    ++		break;
    ++	case ULHR_BAD:
      		status = error(_("unable to unpack %s header"),
      			       oid_to_hex(oid));
    - 		break;
    --	case -2:
    -+	case UNPACK_LOOSE_HEADER_RESULT_BAD_TOO_LONG:
    - 		status = error(_("header for %s too long, exceeds %d bytes"),
    - 			       oid_to_hex(oid), MAX_HEADER_LEN);
    - 		break;
    --	default:
    --		BUG("unknown hdr_ret value %d", hdr_ret);
    - 	}
    - 	if (!status) {
    - 		if (!parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi))
    -
    - ## object-store.h ##
    -@@ object-store.h: int for_each_object_in_pack(struct packed_git *p,
    - int for_each_packed_object(each_packed_object_fn, void *,
    - 			   enum for_each_object_flags flags);
    - 
    -+enum unpack_loose_header_result {
    -+	UNPACK_LOOSE_HEADER_RESULT_BAD_TOO_LONG = -2,
    -+	UNPACK_LOOSE_HEADER_RESULT_BAD = -1,
    -+	UNPACK_LOOSE_HEADER_RESULT_OK,
    -+
    -+};
    +-	if (status < 0)
    +-		; /* Do nothing */
    +-	else if (hdrbuf.len) {
    ++		break;
    ++	}
     +
    - /**
    -  * unpack_loose_header() initializes the data stream needed to unpack
    -  * a loose object header.
    -  *
    -- * Returns 0 on success. Returns negative values on error. If the
    -- * header exceeds MAX_HEADER_LEN -2 will be returned.
    -+ * Returns UNPACK_LOOSE_HEADER_RESULT_OK on success. Returns
    -+ * UNPACK_LOOSE_HEADER_RESULT_BAD values on error, or if the header
    -+ * exceeds MAX_HEADER_LEN UNPACK_LOOSE_HEADER_RESULT_BAD_TOO_LONG will
    -+ * be returned.
    -  *
    -  * It will only parse up to MAX_HEADER_LEN bytes unless an optional
    -  * "hdrbuf" argument is non-NULL. This is intended for use with
    -  * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
    -  * reporting. The full header will be extracted to "hdrbuf" for use
    -- * with parse_loose_header(), -2 will still be returned from this
    -- * function to indicate that the header was too long.
    -+ * with parse_loose_header(), UNPACK_LOOSE_HEADER_RESULT_BAD_TOO_LONG
    -+ * will still be returned from this function to indicate that the
    -+ * header was too long.
    -  */
    --int unpack_loose_header(git_zstream *stream, unsigned char *map,
    --			unsigned long mapsize, void *buffer,
    --			unsigned long bufsiz, struct strbuf *hdrbuf);
    -+enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
    -+						    unsigned char *map,
    -+						    unsigned long mapsize,
    -+						    void *buffer,
    -+						    unsigned long bufsiz,
    -+						    struct strbuf *hdrbuf);
    - 
    - /**
    -  * parse_loose_header() parses the starting "<type> <len>\0" of an
    ++	if (status < 0) {
    ++		/* Do nothing */
    ++	} else if (hdrbuf.len) {
    + 		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
    + 			status = error(_("unable to parse %s header with --allow-unknown-type"),
    + 				       oid_to_hex(oid));
     
      ## streaming.c ##
     @@ streaming.c: static int open_istream_loose(struct git_istream *st, struct repository *r,
    - 			      enum object_type *type)
    - {
    - 	struct object_info oi = OBJECT_INFO_INIT;
    -+	enum unpack_loose_header_result hdr_ret;
    - 	oi.sizep = &st->size;
    - 	oi.typep = type;
    - 
      	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
      	if (!st->u.loose.mapped)
      		return -1;
    @@ streaming.c: static int open_istream_loose(struct git_istream *st, struct reposi
     -				 st->u.loose.hdr,
     -				 sizeof(st->u.loose.hdr),
     -				 NULL) < 0) ||
    --	    (parse_loose_header(st->u.loose.hdr, &oi) < 0) ||
    --	    *type < 0) {
    +-	    (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)) {
     -		git_inflate_end(&st->z);
     -		munmap(st->u.loose.mapped, st->u.loose.mapsize);
     -		return -1;
    -+	hdr_ret = unpack_loose_header(&st->z, st->u.loose.mapped,
    -+				      st->u.loose.mapsize, st->u.loose.hdr,
    -+				      sizeof(st->u.loose.hdr), NULL);
    -+	switch (hdr_ret) {
    -+	case UNPACK_LOOSE_HEADER_RESULT_OK:
    ++	switch (unpack_loose_header(&st->z, st->u.loose.mapped,
    ++				    st->u.loose.mapsize, st->u.loose.hdr,
    ++				    sizeof(st->u.loose.hdr), NULL)) {
    ++	case ULHR_OK:
     +		break;
    -+	case UNPACK_LOOSE_HEADER_RESULT_BAD:
    -+	case UNPACK_LOOSE_HEADER_RESULT_BAD_TOO_LONG:
    ++	case ULHR_BAD:
     +		goto error;
      	}
    -+	if (parse_loose_header(st->u.loose.hdr, &oi) < 0 || *type < 0)
    ++	if (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)
     +		goto error;
      
      	st->u.loose.hdr_used = strlen(st->u.loose.hdr) + 1;
17:  f28c4f0dfb4 ! 14:  522d71eb19d object-file.c: return -2 on "header too long" in unpack_loose_header()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    object-file.c: return -2 on "header too long" in unpack_loose_header()
    +    object-file.c: return ULHR_TOO_LONG on "header too long"
     
         Split up the return code for "header too long" from the generic
         negative return value unpack_loose_header() returns, and report via
    @@ Commit message
         As a test added earlier in this series in t1006-cat-file.sh shows
         we'll correctly emit zlib errors from zlib.c already in this case, so
         we have no need to carry those return codes further down the
    -    stack. Let's instead just return -2 saying we ran into the
    +    stack. Let's instead just return ULHR_TOO_LONG saying we ran into the
         MAX_HEADER_LEN limit, or other negative values for "unable to unpack
         <OID> header".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## cache.h ##
    +@@ cache.h: int git_open_cloexec(const char *name, int flags);
    +  *
    +  * - ULHR_OK on success
    +  * - ULHR_BAD on error
    ++ * - ULHR_TOO_LONG if the header was too long
    +  *
    +  * It will only parse up to MAX_HEADER_LEN bytes unless an optional
    +  * "hdrbuf" argument is non-NULL. This is intended for use with
    +  * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
    +  * reporting. The full header will be extracted to "hdrbuf" for use
    +- * with parse_loose_header().
    ++ * with parse_loose_header(), ULHR_TOO_LONG will still be returned
    ++ * from this function to indicate that the header was too long.
    +  */
    + enum unpack_loose_header_result {
    + 	ULHR_OK,
    + 	ULHR_BAD,
    ++	ULHR_TOO_LONG,
    + };
    + enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
    + 						    unsigned char *map,
    +
      ## object-file.c ##
    -@@ object-file.c: int unpack_loose_header(git_zstream *stream,
    +@@ object-file.c: enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
      	 * --allow-unknown-type".
      	 */
      	if (!header)
    --		return -1;
    -+		return -2;
    +-		return ULHR_BAD;
    ++		return ULHR_TOO_LONG;
      
      	/*
      	 * buffer[0..bufsiz] was not large enough.  Copy the partial
    -@@ object-file.c: int unpack_loose_header(git_zstream *stream,
    +@@ object-file.c: enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
      		stream->next_out = buffer;
      		stream->avail_out = bufsiz;
      	} while (status != Z_STREAM_END);
    --	return -1;
    -+	return -2;
    +-	return ULHR_BAD;
    ++	return ULHR_TOO_LONG;
      }
      
      static void *unpack_loose_rest(git_zstream *stream,
     @@ object-file.c: static int loose_object_info(struct repository *r,
    - 
    - 	hdr_ret = unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
    - 				      allow_unknown ? &hdrbuf : NULL);
    --	if (hdr_ret < 0) {
    -+	switch (hdr_ret) {
    -+	case 0:
    -+		break;
    -+	case -1:
      		status = error(_("unable to unpack %s header"),
      			       oid_to_hex(oid));
    -+		break;
    -+	case -2:
    + 		break;
    ++	case ULHR_TOO_LONG:
     +		status = error(_("header for %s too long, exceeds %d bytes"),
     +			       oid_to_hex(oid), MAX_HEADER_LEN);
     +		break;
    -+	default:
    -+		BUG("unknown hdr_ret value %d", hdr_ret);
      	}
    - 	if (!status) {
    - 		if (!parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi))
    + 
    + 	if (status < 0) {
     
    - ## object-store.h ##
    -@@ object-store.h: int for_each_packed_object(each_packed_object_fn, void *,
    -  * unpack_loose_header() initializes the data stream needed to unpack
    -  * a loose object header.
    -  *
    -- * Returns 0 on success. Returns negative values on error.
    -+ * Returns 0 on success. Returns negative values on error. If the
    -+ * header exceeds MAX_HEADER_LEN -2 will be returned.
    -  *
    -  * It will only parse up to MAX_HEADER_LEN bytes unless an optional
    -  * "hdrbuf" argument is non-NULL. This is intended for use with
    -  * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
    -  * reporting. The full header will be extracted to "hdrbuf" for use
    -- * with parse_loose_header().
    -+ * with parse_loose_header(), -2 will still be returned from this
    -+ * function to indicate that the header was too long.
    -  */
    - int unpack_loose_header(git_zstream *stream, unsigned char *map,
    - 			unsigned long mapsize, void *buffer,
    + ## streaming.c ##
    +@@ streaming.c: static int open_istream_loose(struct git_istream *st, struct repository *r,
    + 	case ULHR_OK:
    + 		break;
    + 	case ULHR_BAD:
    ++	case ULHR_TOO_LONG:
    + 		goto error;
    + 	}
    + 	if (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)
     
      ## t/t1006-cat-file.sh ##
    -@@ t/t1006-cat-file.sh: bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_t
    - 
    - test_expect_success 'die on broken object with large type under -t and -s without --allow-unknown-type' '
    - 	cat >err.expect <<-EOF &&
    --	error: unable to unpack $bogus_sha1 header
    -+	error: header for $bogus_sha1 too long, exceeds 32 bytes
    - 	fatal: git cat-file: could not get object info
    - 	EOF
    - 
    +@@ t/t1006-cat-file.sh: do
    + 			if test "$arg2" = "-p"
    + 			then
    + 				cat >expect <<-EOF
    +-				error: unable to unpack $bogus_long_sha1 header
    ++				error: header for $bogus_long_sha1 too long, exceeds 32 bytes
    + 				fatal: Not a valid object name $bogus_long_sha1
    + 				EOF
    + 			else
    + 				cat >expect <<-EOF
    +-				error: unable to unpack $bogus_long_sha1 header
    ++				error: header for $bogus_long_sha1 too long, exceeds 32 bytes
    + 				fatal: git cat-file: could not get object info
    + 				EOF
    + 			fi &&
14:  7c9819d37c5 ! 15:  1ca875395c1 object-file.c: stop dying in parse_loose_header()
    @@ Metadata
      ## Commit message ##
         object-file.c: stop dying in parse_loose_header()
     
    -    Start the libification of parse_loose_header() by making it return
    -    error codes and data instead of invoking die() by itself. For now
    -    we'll move the relevant die() call to loose_object_info() and
    -    read_loose_object() to keep this change smaller, but in subsequent
    -    commits we'll also libify those.
    +    Make parse_loose_header() return error codes and data instead of
    +    invoking die() by itself.
     
    -    Since the refactoring of parse_loose_header_extended() into
    -    parse_loose_header() in an earlier commit, its interface accepts a
    -    "unsigned long *sizep". Rather it accepts a "struct object_info *",
    -    that structure will be populated with information about the object.
    +    For now we'll move the relevant die() call to loose_object_info() and
    +    read_loose_object() to keep this change smaller. In a subsequent
    +    commit we'll make read_loose_object() return an error code instead of
    +    dying. We should also address the "allow_unknown" case (should be
    +    moved to builtin/cat-file.c), but for now I'll be leaving it.
     
    -    It thus makes sense to further libify the interface so that it stops
    -    calling die() when it encounters OBJ_BAD, and instead rely on its
    -    callers to check the populated "oi->typep".
    +    For making parse_loose_header() not die() change its prototype to
    +    accept a "struct object_info *" instead of the "unsigned long *sizep"
    +    it accepted before. Its callers can now check the populated populated
    +    "oi->typep".
     
         Because of this we don't need to pass in the "unsigned int flags"
         which we used for OBJECT_INFO_ALLOW_UNKNOWN_TYPE, we can instead do
    @@ Commit message
         variable. In some cases we set it to the return value of "error()",
         i.e. -1, and later checked if "status < 0" was true.
     
    -    In another case added in c84a1f3ed4d (sha1_file: refactor read_object,
    -    2017-06-21) (but the behavior pre-dated that) we did checks of "status
    -    >= 0", because at that point "status" had become the return value of
    -    parse_loose_header(). I.e. a non-negative "enum object_type" (unless
    -    we -1, aka. OBJ_BAD).
    +    Since 93cff9a978e (sha1_loose_object_info: return error for corrupted
    +    objects, 2017-04-01) the return value of loose_object_info() (then
    +    named sha1_loose_object_info()) had been a "status" variable that be
    +    any negative value, as we were expecting to return the "enum
    +    object_type".
     
    -    Now that parse_loose_header() will return 0 on success instead of the
    +    The only negative type happens to be OBJ_BAD, but the code still
    +    assumed that more might be added. This was then used later in
    +    e.g. c84a1f3ed4d (sha1_file: refactor read_object, 2017-06-21). Now
    +    that parse_loose_header() will return 0 on success instead of the
         type (which it'll stick into the "struct object_info") we don't need
         to conflate these two cases in its callers.
     
    +    Since parse_loose_header() doesn't need to return an arbitrary
    +    "status" we only need to treat its "ret < 0" specially, but can
    +    idiomatically overwrite it with our own error() return. This along
    +    with having made unpack_loose_header() return an "enum
    +    unpack_loose_header_result" in an earlier commit means that we can
    +    move the previously nested if/else cases mostly into the "ULHR_OK"
    +    branch of the "switch" statement.
    +
    +    We should be less silent if we reach that "status = -1" branch, which
    +    happens if we've got trailing garbage in loose objects, see
    +    f6371f92104 (sha1_file: add read_loose_object() function, 2017-01-13)
    +    for a better way to handle it. For now let's punt on it, a subsequent
    +    commit will address that edge case.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## cache.h ##
    +@@ cache.h: enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
    + 						    unsigned long bufsiz,
    + 						    struct strbuf *hdrbuf);
    + 
    ++/**
    ++ * parse_loose_header() parses the starting "<type> <len>\0" of an
    ++ * object. If it doesn't follow that format -1 is returned. To check
    ++ * the validity of the <type> populate the "typep" in the "struct
    ++ * object_info". It will be OBJ_BAD if the object type is unknown. The
    ++ * parsed <len> can be retrieved via "oi->sizep", and from there
    ++ * passed to unpack_loose_rest().
    ++ */
    + struct object_info;
    +-int parse_loose_header(const char *hdr, struct object_info *oi,
    +-		       unsigned int flags);
    ++int parse_loose_header(const char *hdr, struct object_info *oi);
    + 
    + int check_object_signature(struct repository *r, const struct object_id *oid,
    + 			   void *buf, unsigned long size, const char *type);
    +
      ## object-file.c ##
     @@ object-file.c: static void *unpack_loose_rest(git_zstream *stream,
       * too permissive for what we want to check. So do an anal
       * object header parse by hand.
       */
    --int parse_loose_header(const char *hdr,
    --		       struct object_info *oi,
    +-int parse_loose_header(const char *hdr, struct object_info *oi,
     -		       unsigned int flags)
     +int parse_loose_header(const char *hdr, struct object_info *oi)
      {
      	const char *type_buf = hdr;
      	unsigned long size;
    -@@ object-file.c: int parse_loose_header(const char *hdr,
    +@@ object-file.c: int parse_loose_header(const char *hdr, struct object_info *oi,
      	type = type_from_string_gently(type_buf, type_len, 1);
      	if (oi->type_name)
      		strbuf_add(oi->type_name, type_buf, type_len);
    @@ object-file.c: int parse_loose_header(const char *hdr,
      	if (oi->typep)
      		*oi->typep = type;
      
    -@@ object-file.c: int parse_loose_header(const char *hdr,
    - 	if (*hdr)
    - 		return -1;
    - 
    --	return type;
    +@@ object-file.c: int parse_loose_header(const char *hdr, struct object_info *oi,
    + 	/*
    + 	 * The length must be followed by a zero byte
    + 	 */
    +-	return *hdr ? -1 : type;
    ++	if (*hdr)
    ++		return -1;
    ++
     +	/*
     +	 * The format is valid, but the type may still be bogus. The
     +	 * Caller needs to check its oi->typep.
    @@ object-file.c: static int loose_object_info(struct repository *r,
      	struct strbuf hdrbuf = STRBUF_INIT;
      	unsigned long size_scratch;
     +	enum object_type type_scratch;
    -+	int parsed_header = 0;
      	int allow_unknown = flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
      
      	if (oi->delta_base_oid)
    @@ object-file.c: static int loose_object_info(struct repository *r,
      	if (oi->disk_sizep)
      		*oi->disk_sizep = mapsize;
     @@ object-file.c: static int loose_object_info(struct repository *r,
    + 	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
    + 				    allow_unknown ? &hdrbuf : NULL)) {
    + 	case ULHR_OK:
    ++		if (parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi) < 0)
    ++			status = error(_("unable to parse %s header"), oid_to_hex(oid));
    ++		else if (!allow_unknown && *oi->typep < 0)
    ++			die(_("invalid object type"));
    ++
    ++		if (!oi->contentp)
    ++			break;
    ++		*oi->contentp = unpack_loose_rest(&stream, hdr, *oi->sizep, oid);
    ++		if (*oi->contentp)
    ++			goto cleanup;
    ++
    ++		status = -1;
    + 		break;
    + 	case ULHR_BAD:
      		status = error(_("unable to unpack %s header"),
    - 			       oid_to_hex(oid));
    +@@ object-file.c: static int loose_object_info(struct repository *r,
    + 		break;
      	}
    --
    + 
     -	if (status < 0) {
     -		/* Do nothing */
     -	} else if (hdrbuf.len) {
     -		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
     -			status = error(_("unable to parse %s header with --allow-unknown-type"),
     -				       oid_to_hex(oid));
    --	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0) {
    +-	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0)
     -		status = error(_("unable to parse %s header"), oid_to_hex(oid));
    -+	if (!status) {
    -+		if (!parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi))
    -+			/*
    -+			 * oi->{sizep,typep} are meaningless unless
    -+			 * parse_loose_header() returns >= 0.
    -+			 */
    -+			parsed_header = 1;
    -+		else
    -+			status = error(_("unable to parse %s header"), oid_to_hex(oid));
    - 	}
    -+	if (!allow_unknown && parsed_header && *oi->typep < 0)
    -+		die(_("invalid object type"));
    - 
    +-
     -	if (status >= 0 && oi->contentp) {
    -+	if (parsed_header && oi->contentp) {
    - 		*oi->contentp = unpack_loose_rest(&stream, hdr,
    - 						  *oi->sizep, oid);
    - 		if (!*oi->contentp) {
    -@@ object-file.c: static int loose_object_info(struct repository *r,
    +-		*oi->contentp = unpack_loose_rest(&stream, hdr,
    +-						  *oi->sizep, oid);
    +-		if (!*oi->contentp) {
    +-			git_inflate_end(&stream);
    +-			status = -1;
    +-		}
    +-	} else
    +-		git_inflate_end(&stream);
    +-
    ++	git_inflate_end(&stream);
    ++cleanup:
    + 	munmap(map, mapsize);
      	if (oi->sizep == &size_scratch)
      		oi->sizep = NULL;
      	strbuf_release(&hdrbuf);
     +	if (oi->typep == &type_scratch)
     +		oi->typep = NULL;
      	oi->whence = OI_LOOSE;
    - 	return (status < 0) ? status : 0;
    +-	return (status < 0) ? status : 0;
    ++	return status;
      }
    + 
    + int obj_read_use_lock = 0;
     @@ object-file.c: int read_loose_object(const char *path,
      	git_zstream stream;
      	char hdr[MAX_HEADER_LEN];
    @@ object-file.c: int read_loose_object(const char *path,
      	if (*type == OBJ_BLOB && *size > big_file_threshold) {
      		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
     
    - ## object-store.h ##
    -@@ object-store.h: int for_each_packed_object(each_packed_object_fn, void *,
    - int unpack_loose_header(git_zstream *stream, unsigned char *map,
    - 			unsigned long mapsize, void *buffer,
    - 			unsigned long bufsiz, struct strbuf *hdrbuf);
    --int parse_loose_header(const char *hdr, struct object_info *oi,
    --		       unsigned int flags);
    -+
    -+/**
    -+ * parse_loose_header() parses the starting "<type> <len>\0" of an
    -+ * object. If it doesn't follow that format -1 is returned. To check
    -+ * the validity of the <type> populate the "typep" in the "struct
    -+ * object_info". It will be OBJ_BAD if the object type is unknown. The
    -+ * parsed <len> can be retrieved via "oi->sizep", and from there
    -+ * passed to unpack_loose_rest().
    -+ */
    -+int parse_loose_header(const char *hdr, struct object_info *oi);
    -+
    - int check_object_signature(struct repository *r, const struct object_id *oid,
    - 			   void *buf, unsigned long size, const char *type);
    - int finalize_object_file(const char *tmpfile, const char *filename);
    -
      ## streaming.c ##
     @@ streaming.c: static int open_istream_loose(struct git_istream *st, struct repository *r,
      {
    @@ streaming.c: static int open_istream_loose(struct git_istream *st, struct reposi
      	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
      	if (!st->u.loose.mapped)
     @@ streaming.c: static int open_istream_loose(struct git_istream *st, struct repository *r,
    - 				 st->u.loose.hdr,
    - 				 sizeof(st->u.loose.hdr),
    - 				 NULL) < 0) ||
    --	    (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)) {
    -+	    (parse_loose_header(st->u.loose.hdr, &oi) < 0) ||
    -+	    *type < 0) {
    - 		git_inflate_end(&st->z);
    - 		munmap(st->u.loose.mapped, st->u.loose.mapsize);
    - 		return -1;
    + 	case ULHR_TOO_LONG:
    + 		goto error;
    + 	}
    +-	if (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)
    ++	if (parse_loose_header(st->u.loose.hdr, &oi) < 0 || *type < 0)
    + 		goto error;
    + 
    + 	st->u.loose.hdr_used = strlen(st->u.loose.hdr) + 1;
15:  3fb660ff944 <  -:  ----------- object-file.c: guard against future bugs in loose_object_info()
20:  3bf3cf2299d <  -:  ----------- object-store.h: move read_loose_object() below 'struct object_info'
21:  974f650cddf ! 16:  d38067feab3 fsck: report invalid types recorded in objects
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    fsck: report invalid types recorded in objects
    +    fsck: don't hard die on invalid object types
     
    -    Continue the work in the preceding commit and improve the error on:
    +    Change the error fsck emits on invalid object types, such as:
     
             $ git hash-object --stdin -w -t garbage --literally </dev/null
    +        <OID>
    +
    +    From the very ungraceful error of:
    +
             $ git fsck
    -        error: hash mismatch for <OID_PATH> (expected <OID>)
    -        error: <OID>: object corrupt or missing: <OID_PATH>
    -        [ other fsck output ]
    +        fatal: invalid object type
    +        $
     
    -    To instead emit:
    +    To:
     
             $ git fsck
             error: <OID>: object is of unknown type 'garbage': <OID_PATH>
             [ other fsck output ]
     
    -    The complaint about a "hash mismatch" was simply an emergent property
    -    of how we'd fall though from read_loose_object() into fsck_loose()
    -    when we didn't get the data we expected. Now we'll correctly note that
    -    the object type is invalid.
    +    We'll still exit with non-zero, but now we'll finish the rest of the
    +    traversal. The tests that's being added here asserts that we'll still
    +    complain about other fsck issues (e.g. an unrelated dangling blob).
    +
    +    To do this we need to pass down the "OBJECT_INFO_ALLOW_UNKNOWN_TYPE"
    +    flag from read_loose_object() through to parse_loose_header(). Since
    +    the read_loose_object() function is only used in builtin/fsck.c we can
    +    simply change it to accept a "struct object_info" (which contains the
    +    OBJECT_INFO_ALLOW_UNKNOWN_TYPE in its flags). See
    +    f6371f92104 (sha1_file: add read_loose_object() function, 2017-01-13)
    +    for the introduction of read_loose_object().
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *p
      	unsigned long size;
      	void *contents;
      	int eaten;
    --
    --	if (read_loose_object(path, oid, &type, &size, &contents,
    --			      OBJECT_INFO_ALLOW_UNKNOWN_TYPE) < 0) {
    --		errors_found |= ERROR_OBJECT;
     +	struct strbuf sb = STRBUF_INIT;
    -+	unsigned int oi_flags = OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
    -+	struct object_info oi;
    -+	int found = 0;
    ++	struct object_info oi = OBJECT_INFO_INIT;
    ++	int err = 0;
    + 
    +-	if (read_loose_object(path, oid, &type, &size, &contents) < 0) {
     +	oi.type_name = &sb;
     +	oi.sizep = &size;
     +	oi.typep = &type;
     +
    -+	if (read_loose_object(path, oid, &contents, &oi, oi_flags) < 0) {
    -+		found |= ERROR_OBJECT;
    - 		error(_("%s: object corrupt or missing: %s"),
    - 		      oid_to_hex(oid), path);
    -+	}
    -+	if (type < 0) {
    -+		found |= ERROR_OBJECT;
    -+		error(_("%s: object is of unknown type '%s': %s"),
    -+		      oid_to_hex(oid), sb.buf, path);
    -+	}
    -+	if (found) {
    -+		errors_found |= ERROR_OBJECT;
    ++	if (read_loose_object(path, oid, &contents, &oi) < 0)
    ++		err = error(_("%s: object corrupt or missing: %s"),
    ++			    oid_to_hex(oid), path);
    ++	if (type < 0)
    ++		err = error(_("%s: object is of unknown type '%s': %s"),
    ++			    oid_to_hex(oid), sb.buf, path);
    ++	if (err) {
    + 		errors_found |= ERROR_OBJECT;
    +-		error(_("%s: object corrupt or missing: %s"),
    +-		      oid_to_hex(oid), path);
      		return 0; /* keep checking other objects */
      	}
      
    @@ object-file.c: static int check_stream_oid(git_zstream *stream,
      		      const struct object_id *expected_oid,
     -		      enum object_type *type,
     -		      unsigned long *size,
    - 		      void **contents,
    -+		      struct object_info *oi,
    - 		      unsigned int oi_flags)
    +-		      void **contents)
    ++		      void **contents,
    ++		      struct object_info *oi)
      {
      	int ret = -1;
    -@@ object-file.c: int read_loose_object(const char *path,
    + 	void *map = NULL;
      	unsigned long mapsize;
      	git_zstream stream;
      	char hdr[MAX_HEADER_LEN];
     -	struct object_info oi = OBJECT_INFO_INIT;
    - 	int allow_unknown = oi_flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
     -	oi.typep = type;
     -	oi.sizep = size;
    -+	enum object_type *type = oi->typep;
     +	unsigned long *size = oi->sizep;
      
      	*contents = NULL;
    @@ object-file.c: int read_loose_object(const char *path,
      		error(_("unable to parse header of %s"), path);
      		git_inflate_end(&stream);
      		goto out;
    + 	}
    +-	if (*type < 0)
    +-		die(_("invalid object type"));
    + 
    +-	if (*type == OBJ_BLOB && *size > big_file_threshold) {
    ++	if (*oi->typep == OBJ_BLOB && *size > big_file_threshold) {
    + 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
    + 			goto out;
    + 	} else {
     @@ object-file.c: int read_loose_object(const char *path,
      			goto out;
      		}
    @@ object-file.c: int read_loose_object(const char *path,
      			free(*contents);
     
      ## object-store.h ##
    -@@ object-store.h: int oid_object_info_extended(struct repository *r,
    +@@ object-store.h: int force_object_loose(const struct object_id *oid, time_t mtime);
      
      /*
       * Open the loose object at path, check its hash, and return the contents,
    @@ object-store.h: int oid_object_info_extended(struct repository *r,
       * type, and size. If the object is a blob, then "contents" may return NULL,
       * to allow streaming of large blobs.
       *
    -@@ object-store.h: int oid_object_info_extended(struct repository *r,
    +@@ object-store.h: int force_object_loose(const struct object_id *oid, time_t mtime);
       */
      int read_loose_object(const char *path,
      		      const struct object_id *expected_oid,
     -		      enum object_type *type,
     -		      unsigned long *size,
    - 		      void **contents,
    -+		      struct object_info *oi,
    - 		      unsigned int oi_flags);
    +-		      void **contents);
    ++		      void **contents,
    ++		      struct object_info *oi);
      
    - /*
    + /* Retry packed storage after checking packed and loose storage */
    + #define HAS_OBJECT_RECHECK_PACKED 1
     
      ## t/t1450-fsck.sh ##
    -@@ t/t1450-fsck.sh: test_expect_success 'object with hash mismatch' '
    - 	)
    - '
    +@@ t/t1450-fsck.sh: test_expect_success 'object with hash and type mismatch' '
    + 		cmt=$(echo bogus | git commit-tree $tree) &&
    + 		git update-ref refs/heads/bogus $cmt &&
      
    -+test_expect_success 'object with hash and type mismatch' '
    -+	git init --bare hash-type-mismatch &&
    -+	(
    -+		cd hash-type-mismatch &&
    -+		oid=$(echo blob | git hash-object -w --stdin -t garbage --literally) &&
    -+		old=$(test_oid_to_path "$oid") &&
    -+		new=$(dirname $old)/$(test_oid ff_2) &&
    -+		oid="$(dirname $new)$(basename $new)" &&
    -+		mv objects/$old objects/$new &&
    -+		git update-index --add --cacheinfo 100644 $oid foo &&
    -+		tree=$(git write-tree) &&
    -+		cmt=$(echo bogus | git commit-tree $tree) &&
    -+		git update-ref refs/heads/bogus $cmt &&
    +-		cat >expect <<-\EOF &&
    +-		fatal: invalid object type
    +-		EOF
    +-		test_must_fail git fsck 2>actual &&
    +-		test_cmp expect actual
    ++
     +		test_must_fail git fsck 2>out &&
     +		grep "^error: hash mismatch for " out &&
     +		grep "^error: $oid: object is of unknown type '"'"'garbage'"'"'" out
    -+	)
    -+'
    -+
    - test_expect_success 'branch pointing to non-commit' '
    - 	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
    - 	test_when_finished "git update-ref -d refs/heads/invalid" &&
    -@@ t/t1450-fsck.sh: test_expect_success 'fsck error and recovery on invalid object type' '
    - 	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
    - 	test_must_fail git -C garbage-type fsck >out 2>err &&
    - 	grep -e "^error" -e "^fatal" err >errors &&
    --	test_line_count = 2 errors &&
    --	grep "error: hash mismatch for" err &&
    --	grep "$garbage_blob: object corrupt or missing:" err &&
    -+	test_line_count = 1 errors &&
    -+	grep "$garbage_blob: object is of unknown type '"'"'garbage'"'"':" err &&
    - 	grep "dangling blob $empty_blob" out
    + 	)
    + '
    + 
    +@@ t/t1450-fsck.sh: test_expect_success 'detect corrupt index file in fsck' '
    + 	test_i18ngrep "bad index file" errors
    + '
    + 
    +-test_expect_success 'fsck hard errors on an invalid object type' '
    ++test_expect_success 'fsck error and recovery on invalid object type' '
    + 	git init --bare garbage-type &&
    + 	(
    + 		cd garbage-type &&
    +@@ t/t1450-fsck.sh: test_expect_success 'fsck hard errors on an invalid object type' '
    + 		fatal: invalid object type
    + 		EOF
    + 		test_must_fail git fsck >out 2>err &&
    +-		test_cmp err.expect err &&
    +-		test_must_be_empty out
    ++		grep -e "^error" -e "^fatal" err >errors &&
    ++		test_line_count = 1 errors &&
    ++		grep "$garbage_blob: object is of unknown type '"'"'garbage'"'"':" err &&
    ++		grep "dangling blob $empty_blob" out
    + 	)
      '
      
22:  804673a17b0 ! 17:  b07e892fc19 fsck: report invalid object type-path combinations
    @@ Commit message
         value for checking whether we got far enough to be certain that the
         issue was indeed this OID mismatch.
     
    -    In the case of check_object_signature() I don't really trust all the
    -    moving parts there to behave consistently, in the face of future
    -    refactorings. Getting it wrong would mean that we'd potentially emit
    -    no error at all on a failing check_object_signature(), or worse
    -    misreport whatever issue we encountered. So let's use the new bug()
    -    function to ferry and return code up to fsck_loose() in that case.
    +    We need to add the "object corrupt or missing" special-case to deal
    +    with cases where read_loose_object() will return an error before
    +    completing check_object_signature(), e.g. if we have an error in
    +    unpack_loose_rest() because we find garbage after the valid gzip
    +    content:
    +
    +        $ git hash-object --stdin -w -t blob </dev/null
    +        e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
    +        $ chmod 755 objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
    +        $ echo garbage >>objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
    +        $ git fsck
    +        error: garbage at end of loose object 'e69d[...]'
    +        error: unable to unpack contents of ./objects/e6/9d[...]
    +        error: e69d[...]: object corrupt or missing: ./objects/e6/9d[...]
    +
    +    There is currently some weird messaging in the edge case when the two
    +    are combined, i.e. because we're not explicitly passing along an error
    +    state about this specific scenario from check_stream_oid() via
    +    read_loose_object() we'll end up printing the null OID if an object is
    +    of an unknown type *and* it can't be unpacked by zlib, e.g.:
    +
    +        $ git hash-object --stdin -w -t garbage --literally </dev/null
    +        8315a83d2acc4c174aed59430f9a9c4ed926440f
    +        $ chmod 755 objects/83/15a83d2acc4c174aed59430f9a9c4ed926440f
    +        $ echo garbage >>objects/83/15a83d2acc4c174aed59430f9a9c4ed926440f
    +        $ /usr/bin/git fsck
    +        fatal: invalid object type
    +        $ ~/g/git/git fsck
    +        error: garbage at end of loose object '8315a83d2acc4c174aed59430f9a9c4ed926440f'
    +        error: unable to unpack contents of ./objects/83/15a83d2acc4c174aed59430f9a9c4ed926440f
    +        error: 8315a83d2acc4c174aed59430f9a9c4ed926440f: object corrupt or missing: ./objects/83/15a83d2acc4c174aed59430f9a9c4ed926440f
    +        error: 0000000000000000000000000000000000000000: object is of unknown type 'garbage': ./objects/83/15a83d2acc4c174aed59430f9a9c4ed926440f
    +        [...]
    +
    +    I think it's OK to leave that for future improvements, which would
    +    involve enum-ifying more error state as we've done with "enum
    +    unpack_loose_header_result" in preceding commits. In these
    +    increasingly more obscure cases the worst that can happen is that
    +    we'll get slightly nonsensical or inapplicable error messages.
    +
    +    There's other such potential edge cases, all of which might produce
    +    some confusing messaging, but still be handled correctly as far as
    +    passing along errors goes. E.g. if check_object_signature() returns
    +    and oideq(real_oid, null_oid()) is true, which could happen if it
    +    returns -1 due to the read_istream() call having failed.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/fast-export.c: static void export_blob(const struct object_id *oid)
     
      ## builtin/fsck.c ##
     @@ builtin/fsck.c: static int fsck_loose(const struct object_id *oid, const char *path, void *data)
    + 	struct object *obj;
    + 	enum object_type type;
    + 	unsigned long size;
    +-	void *contents;
    ++	unsigned char *contents = NULL;
    + 	int eaten;
      	struct strbuf sb = STRBUF_INIT;
    - 	unsigned int oi_flags = OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
    - 	struct object_info oi;
    + 	struct object_info oi = OBJECT_INFO_INIT;
    +-	int err = 0;
     +	struct object_id real_oid = *null_oid();
    - 	int found = 0;
    ++	int ret;
    + 
      	oi.type_name = &sb;
      	oi.sizep = &size;
      	oi.typep = &type;
      
    --	if (read_loose_object(path, oid, &contents, &oi, oi_flags) < 0) {
    -+	if (read_loose_object(path, oid, &real_oid, &contents, &oi, oi_flags) < 0) {
    - 		found |= ERROR_OBJECT;
    --		error(_("%s: object corrupt or missing: %s"),
    --		      oid_to_hex(oid), path);
    -+		if (!oideq(&real_oid, oid))
    +-	if (read_loose_object(path, oid, &contents, &oi) < 0)
    +-		err = error(_("%s: object corrupt or missing: %s"),
    +-			    oid_to_hex(oid), path);
    ++	ret = read_loose_object(path, oid, &real_oid, (void **)&contents, &oi);
    ++	if (ret < 0) {
    ++		if (contents && !oideq(&real_oid, oid))
     +			error(_("%s: hash-path mismatch, found at: %s"),
     +			      oid_to_hex(&real_oid), path);
     +		else
     +			error(_("%s: object corrupt or missing: %s"),
     +			      oid_to_hex(oid), path);
    - 	}
    - 	if (type < 0) {
    - 		found |= ERROR_OBJECT;
    - 		error(_("%s: object is of unknown type '%s': %s"),
    --		      oid_to_hex(oid), sb.buf, path);
    -+		      oid_to_hex(&real_oid), sb.buf, path);
    - 	}
    - 	if (found) {
    ++	}
    + 	if (type < 0)
    +-		err = error(_("%s: object is of unknown type '%s': %s"),
    +-			    oid_to_hex(oid), sb.buf, path);
    +-	if (err) {
    ++		ret = error(_("%s: object is of unknown type '%s': %s"),
    ++			    oid_to_hex(&real_oid), sb.buf, path);
    ++	if (ret < 0) {
      		errors_found |= ERROR_OBJECT;
    + 		return 0; /* keep checking other objects */
    + 	}
     
      ## builtin/index-pack.c ##
     @@ builtin/index-pack.c: static void fix_unresolved_deltas(struct hashfile *f)
    @@ builtin/mktag.c: static int verify_object_in_tag(struct object_id *tagged_oid, i
      
      	return ret;
     
    + ## cache.h ##
    +@@ cache.h: struct object_info;
    + int parse_loose_header(const char *hdr, struct object_info *oi);
    + 
    + int check_object_signature(struct repository *r, const struct object_id *oid,
    +-			   void *buf, unsigned long size, const char *type);
    ++			   void *buf, unsigned long size, const char *type,
    ++			   struct object_id *real_oidp);
    + 
    + int finalize_object_file(const char *tmpfile, const char *filename);
    + 
    +
      ## object-file.c ##
     @@ object-file.c: void *xmmap(void *start, size_t length,
       * the streaming interface and rehash it to do the same.
    @@ object-file.c: static int check_stream_oid(git_zstream *stream,
      		      const struct object_id *expected_oid,
     +		      struct object_id *real_oid,
      		      void **contents,
    - 		      struct object_info *oi,
    - 		      unsigned int oi_flags)
    + 		      struct object_info *oi)
    + {
    +@@ object-file.c: int read_loose_object(const char *path,
    + 	char hdr[MAX_HEADER_LEN];
    + 	unsigned long *size = oi->sizep;
    + 
    +-	*contents = NULL;
    +-
    + 	map = map_loose_object_1(the_repository, path, NULL, &mapsize);
    + 	if (!map) {
    + 		error_errno(_("unable to mmap %s"), path);
     @@ object-file.c: int read_loose_object(const char *path,
      			goto out;
      		}
    @@ object-file.c: int read_loose_object(const char *path,
     -			error(_("hash mismatch for %s (expected %s)"), path,
     -			      oid_to_hex(expected_oid));
     +					   *contents, *size, oi->type_name->buf, real_oid)) {
    -+			if (oideq(real_oid, null_oid()))
    -+				BUG("should only get OID mismatch errors with mapped contents");
      			free(*contents);
      			goto out;
      		}
     
      ## object-store.h ##
    -@@ object-store.h: int oid_object_info_extended(struct repository *r,
    +@@ object-store.h: int force_object_loose(const struct object_id *oid, time_t mtime);
       */
      int read_loose_object(const char *path,
      		      const struct object_id *expected_oid,
     +		      struct object_id *real_oid,
      		      void **contents,
    - 		      struct object_info *oi,
    - 		      unsigned int oi_flags);
    -@@ object-store.h: enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
    - int parse_loose_header(const char *hdr, struct object_info *oi);
    - 
    - int check_object_signature(struct repository *r, const struct object_id *oid,
    --			   void *buf, unsigned long size, const char *type);
    -+			   void *buf, unsigned long size, const char *type,
    -+			   struct object_id *real_oidp);
    - int finalize_object_file(const char *tmpfile, const char *filename);
    - int check_and_freshen_file(const char *fn, int freshen);
    + 		      struct object_info *oi);
      
     
      ## object.c ##
    @@ t/t1006-cat-file.sh: test_expect_success 'cat-file -t and -s on corrupt loose ob
     
      ## t/t1450-fsck.sh ##
     @@ t/t1450-fsck.sh: test_expect_success 'object with hash mismatch' '
    - 	(
      		cd hash-mismatch &&
    + 
      		oid=$(echo blob | git hash-object -w --stdin) &&
     +		oldoid=$oid &&
      		old=$(test_oid_to_path "$oid") &&
      		new=$(dirname $old)/$(test_oid ff_2) &&
      		oid="$(dirname $new)$(basename $new)" &&
     @@ t/t1450-fsck.sh: test_expect_success 'object with hash mismatch' '
    - 		cmt=$(echo bogus | git commit-tree $tree) &&
      		git update-ref refs/heads/bogus $cmt &&
    + 
      		test_must_fail git fsck 2>out &&
    --		test_i18ngrep "$oid.*corrupt" out
    +-		grep "$oid.*corrupt" out
     +		grep "$oldoid: hash-path mismatch, found at: .*$new" out
      	)
      '
      
     @@ t/t1450-fsck.sh: test_expect_success 'object with hash and type mismatch' '
    - 	(
      		cd hash-type-mismatch &&
    + 
      		oid=$(echo blob | git hash-object -w --stdin -t garbage --literally) &&
     +		oldoid=$oid &&
      		old=$(test_oid_to_path "$oid") &&
      		new=$(dirname $old)/$(test_oid ff_2) &&
      		oid="$(dirname $new)$(basename $new)" &&
     @@ t/t1450-fsck.sh: test_expect_success 'object with hash and type mismatch' '
    - 		cmt=$(echo bogus | git commit-tree $tree) &&
    - 		git update-ref refs/heads/bogus $cmt &&
    + 
    + 
      		test_must_fail git fsck 2>out &&
     -		grep "^error: hash mismatch for " out &&
     -		grep "^error: $oid: object is of unknown type '"'"'garbage'"'"'" out
-- 
2.33.0.1098.g29a6526ae47

