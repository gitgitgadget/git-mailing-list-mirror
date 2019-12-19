Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E75C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3A82467E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKkOEJXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfLSWVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:40 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40635 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLSWVh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:37 -0500
Received: by mail-pj1-f67.google.com with SMTP id bg7so2693624pjb.5
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kw5YC2EsSZIKd2kyHRBV1lt7I29zlBLzJGOzHG28aOA=;
        b=kKkOEJXGBUTjwSvH64xVagcSliba1ihFpgp8TQuiBMRc8FKP3WAD8GBSyWWGnyRqHX
         AuZXrpTAYvZwZzMQZoWzf2N++nyZ5KGcGdMnbV8hEvmV4SLa5bmQFp61ePVY1W/hfbhW
         QS1F5dhNBL+XTiSSRZwgfrBWQNUrbxURm00ugzBYXpSItpudjpZdcqQ8xt9gFhxlmC+D
         6MxUn4DWNELu45slsr4WI9XD4m93GHyT3vZNJv6DgF+Jz68rqxn+FWsacBQXoG0LDh6m
         8YDPERqmZabfbIsBq4cnPgw/TSYTn28NNY3i3/3yqDb/VwIXLt/9IBzXO4JO1MorxcXK
         jWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kw5YC2EsSZIKd2kyHRBV1lt7I29zlBLzJGOzHG28aOA=;
        b=J31UzBi2INYAE/r7t1saODr6oiZr2E4UwQ14GmsMlHds+ZJtHATZnyIn5qbSAlD/Om
         eOCNJDEl1kCIlyVJl4kHbs5AX+/68VvqahPEhSLQszKcp484op2HmLUs777yygxviR0/
         uKMT29byNzBWHSA1Xl3a9WDLA/tOs6Vlbs7cJeFii6pm15EEetbdIpBWZkHSa+Fa/VAO
         C5m4zdkbx6EiPOaXoFKakaeTMQv5IRFq5RlyRI+zF6rAyIMHugKRPKSkKY0Uyx2kFke/
         K3IV6hYSLer4LBskRMvctFhzG/aAGlH7o0E4sTzMVCrqwk2Gvky9kLOrQ06Wpi91g09V
         kYlA==
X-Gm-Message-State: APjAAAUGBdqAGn89Fw3tyzkt9BO9xSFsprDThdfBkj0EjGwyPE+59qnt
        fGervebhz170CERaTnsexH49peIf
X-Google-Smtp-Source: APXvYqwa3uL7W+96npEMwpOrh1jFEZ9H7NYWFMouwrCO6ew9fo3H2+gKHbcH6FQwq1+RZlu6rNM0HQ==
X-Received: by 2002:a17:902:209:: with SMTP id 9mr11819927plc.58.1576794095665;
        Thu, 19 Dec 2019 14:21:35 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:34 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/16] t: replace incorrect test_must_fail usage (part 1)
Date:   Thu, 19 Dec 2019 14:22:35 -0800
Message-Id: <cover.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The overall scope of these patches is to replace inappropriate uses of
test_must_fail. IOW, we should only allow test_must_fail to run on `git`
and `test-tool`. Ultimately, we will conclude by making test_must_fail
error out on non-git commands. An advance view of the final series can
be found here[1].

This is the first part. It focuses on t[01]*.sh and also t/lib-git-p4.

Changes since v1:

* Incorporate review comments by Junio, Eric and J6t

* Further cleanup of t1507 before inlining full_name() (since we didn't
  want to inline full_name() into a bad command substitution)

[1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2

Denton Liu (16):
  test-lib-functions: introduce test_non_git_might_fail()
  t/lib-git-p4: use test_path_is_missing()
  t0000: replace test_must_fail with run_sub_test_lib_test_err()
  t0003: use named parameters in attr_check()
  t0003: use test_must_be_empty()
  t0003: don't use `test_must_fail attr_check`
  t0020: don't use `test_must_fail has_cr`
  t0020: use ! check_packed_refs_marked
  t1306: convert `test_might_fail rm` to `rm -f`
  t1307: reorder `nongit test_must_fail`
  t1409: let sed open its own input file
  t1409: use test_path_is_missing()
  t1501: remove use of `test_might_fail cp`
  t1507: stop losing return codes of git commands
  t1507: run commands within test_expect_success
  t1507: inline full_name()

 t/lib-git-p4.sh               |   2 +-
 t/t0000-basic.sh              |  14 ++---
 t/t0003-attributes.sh         |  47 +++++++--------
 t/t0020-crlf.sh               |  18 +++---
 t/t1306-xdg-files.sh          |   8 +--
 t/t1307-config-blob.sh        |   2 +-
 t/t1409-avoid-packing-refs.sh |  16 +++---
 t/t1501-work-tree.sh          |   2 +-
 t/t1507-rev-parse-upstream.sh | 104 +++++++++++++++++++---------------
 t/test-lib-functions.sh       |   9 +++
 10 files changed, 121 insertions(+), 101 deletions(-)

Range-diff against v1:
 1:  fcfccebd7a !  1:  778ae9052b t0000: replace test_must_fail with ! for run_sub_test_lib_test()
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    t0000: replace test_must_fail with ! for run_sub_test_lib_test()
    +    t0000: replace test_must_fail with run_sub_test_lib_test_err()
     
         The test_must_fail function should only be used for git commands since
         we should assume that external commands work sanely. We use
         test_must_fail to test run_sub_test_lib_test() but that function does
    -    not invoke any git commands internally. Replace these instances of
    -    `test_must_fail` with `!`.
    +    not invoke any git commands internally. Even better, we have a function
    +    that's exactly meant to be used when we expect to have a failing test
    +    suite: run_sub_test_lib_test_err()!
    +
    +    Replace `test_must_fail run_sub_test_lib_test` with
    +    `run_sub_test_lib_test_err`.
     
      ## t/t0000-basic.sh ##
     @@ t/t0000-basic.sh: test_expect_success 'pretend we have a fully passing test suite' "
    @@ t/t0000-basic.sh: test_expect_success 'pretend we have a fully passing test suit
      
      test_expect_success 'pretend we have a partially passing test suite' "
     -	test_must_fail run_sub_test_lib_test \
    -+	! run_sub_test_lib_test \
    ++	run_sub_test_lib_test_err \
      		partial-pass '2/3 tests passing' <<-\\EOF &&
      	test_expect_success 'passing test #1' 'true'
      	test_expect_success 'failing test #2' 'false'
    @@ t/t0000-basic.sh: test_expect_success 'pretend we have fixed one of two known br
      
      test_expect_success 'pretend we have a pass, fail, and known breakage' "
     -	test_must_fail run_sub_test_lib_test \
    -+	! run_sub_test_lib_test \
    ++	run_sub_test_lib_test_err \
      		mixed-results1 'mixed results #1' <<-\\EOF &&
      	test_expect_success 'passing test' 'true'
      	test_expect_success 'failing test' 'false'
    @@ t/t0000-basic.sh: test_expect_success 'pretend we have a pass, fail, and known b
      
      test_expect_success 'pretend we have a mix of all possible results' "
     -	test_must_fail run_sub_test_lib_test \
    -+	! run_sub_test_lib_test \
    ++	run_sub_test_lib_test_err \
      		mixed-results2 'mixed results #2' <<-\\EOF &&
      	test_expect_success 'passing test' 'true'
      	test_expect_success 'passing test' 'true'
    @@ t/t0000-basic.sh: test_expect_success 'pretend we have a mix of all possible res
      
      test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
     -	test_must_fail run_sub_test_lib_test \
    -+	! run_sub_test_lib_test \
    ++	run_sub_test_lib_test_err \
      		t1234-verbose "test verbose" --verbose <<-\EOF &&
      	test_expect_success "passing test" true
      	test_expect_success "test with output" "echo foo"
    @@ t/t0000-basic.sh: test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
      
      test_expect_success 'test --verbose-only' '
     -	test_must_fail run_sub_test_lib_test \
    -+	! run_sub_test_lib_test \
    ++	run_sub_test_lib_test_err \
      		t2345-verbose-only-2 "test verbose-only=2" \
      		--verbose-only=2 <<-\EOF &&
      	test_expect_success "passing test" true
    @@ t/t0000-basic.sh: then
      
      test_expect_success 'tests clean up even on failures' "
     -	test_must_fail run_sub_test_lib_test \
    -+	! run_sub_test_lib_test \
    ++	run_sub_test_lib_test_err \
      		failing-cleanup 'Failing tests with cleanup commands' <<-\\EOF &&
      	test_expect_success 'tests clean up even after a failure' '
      		touch clean-after-failure &&
    @@ t/t0000-basic.sh: test_expect_success 'tests clean up even on failures' "
      
      test_expect_success 'test_atexit is run' "
     -	test_must_fail run_sub_test_lib_test \
    -+	! run_sub_test_lib_test \
    ++	run_sub_test_lib_test_err \
      		atexit-cleanup 'Run atexit commands' -i <<-\\EOF &&
      	test_expect_success 'tests clean up even after a failure' '
      		> ../../clean-atexit &&
 2:  f1acb2a0df !  2:  dbc82d45c6 t0003: use named parameters in attr_check()
    @@ Commit message
         variables instead of numbered arguments for clarity.
     
         While we're at it, add variable assignments to the &&-chain. These
    -    aren't ever expected to fail but for stylistic purposes, include them
    -    anyway for stylistic purposes.
    +    aren't ever expected to fail but if a future developer ever adds some
    +    code above the assignments and they could fail in some way, the intact
    +    &&-chain will ensure that the failure is caught.
     
      ## t/t0003-attributes.sh ##
     @@ t/t0003-attributes.sh: test_description=gitattributes
    @@ t/t0003-attributes.sh: test_description=gitattributes
      
      attr_check () {
     -	path="$1" expect="$2"
    -+	path="$1" &&
    -+	expect="$2" &&
    -+	git_opts="$3" &&
    ++	path="$1" expect="$2" git_opts="$3" &&
      
     -	git $3 check-attr test -- "$path" >actual 2>err &&
     -	echo "$path: test: $2" >expect &&
    @@ t/t0003-attributes.sh: test_description=gitattributes
     -	path="$1"
     -	quoted_path="$2"
     -	expect="$3"
    -+	path="$1" &&
    -+	quoted_path="$2" &&
    -+	expect="$3" &&
    ++	path="$1" quoted_path="$2" expect="$3" &&
      
      	git check-attr test -- "$path" >actual &&
      	echo "\"$quoted_path\": test: $expect" >expect &&
 3:  055caa5c08 =  3:  e06a06cff5 t0003: use test_must_be_empty()
 4:  3afa3a16ca =  4:  219011f983 t0003: don't use `test_must_fail attr_check`
 5:  d228dcfdc7 <  -:  ---------- t0020: drop redirections to /dev/null
 6:  8adc5cd5aa !  5:  8da6c96b39 t0020: s/test_must_fail has_cr/! has_cr/
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    t0020: s/test_must_fail has_cr/! has_cr/
    +    t0020: don't use `test_must_fail has_cr`
     
         The test_must_fail function should only be used for git commands since
         we should assume that external commands work sanely. Since has_cr() just
 7:  b77b474422 =  6:  27550eaae6 t0020: use ! check_packed_refs_marked
 8:  d39422505f =  7:  c19f6344a4 t1306: convert `test_might_fail rm` to `rm -f`
 9:  2dd91c5568 =  8:  d6ea8a6df0 t1307: reorder `nongit test_must_fail`
10:  0b7d19a7e1 !  9:  d57dfe95e2 t1409: let sed open its own files
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    t1409: let sed open its own files
    +    t1409: let sed open its own input file
     
         In one case, we were using a redirection operator to feed input into
    -    sed. However, since sed is capable of opening its own files, make sed
    -    open its own files instead of redirecting input into it.
    +    sed. However, since sed is capable of opening its own input file, make
    +    sed do that instead of redirecting input into it.
     
      ## t/t1409-avoid-packing-refs.sh ##
     @@ t/t1409-avoid-packing-refs.sh: test_description='avoid rewriting packed-refs unnecessarily'
11:  27b3296242 ! 10:  eacf4e0fb4 t1409: use test_path_is_missing()
    @@ Commit message
         The test_must_fail() function should only be used for git commands since
         we should assume that external commands work sanely. Replace
         `test_must_fail test -f` with `test_path_is_missing` since we expect
    -    these files to not exist.
    +    these paths to not exist.
     
      ## t/t1409-avoid-packing-refs.sh ##
     @@ t/t1409-avoid-packing-refs.sh: test_expect_success 'setup' '
12:  3d36511d5d ! 11:  83e47748bc t1501: remove use of `test_might_fail cp`
    @@ Commit message
         should only be used on git commands. Replace test_might_fail() with
         test_non_git_might_fail().
     
    +    The `test_might_fail cp` line was introduced in 466e8d5d66 (t1501: fix
    +    test with split index, 2015-03-24). It is necessary because there might
    +    exist some index files in `repo.git/sharedindex.*` and, if they exist,
    +    we want to copy them over. However, if they don't exist, we don't want
    +    to error out because we expect that possibility. As a result, we want to
    +    keep the "might fail" semantics so we use test_non_git_might_fail().
    +
      ## t/t1501-work-tree.sh ##
     @@ t/t1501-work-tree.sh: test_expect_success 'Multi-worktree setup' '
      	mkdir work &&
13:  cd392a74ac <  -:  ---------- t1507: teach full_name() to accept `!` arg
 -:  ---------- > 12:  9e20865f94 t1507: stop losing return codes of git commands
 -:  ---------- > 13:  7c61ac6b67 t1507: run commands within test_expect_success
 -:  ---------- > 14:  d09370455f t1507: inline full_name()
-- 
2.24.1.703.g2f499f1283

