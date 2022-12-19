Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8475C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 10:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiLSKTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiLSKTh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 05:19:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A971B7E0
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:19:35 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bx10so8170316wrb.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 02:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yZGOjOJa6J5BvbW2Isi6jN1eE0R+GW4s1SPMFZC5Kw=;
        b=QBblMPP0/Rgjwpg+uLtT4llLGs3aN8770gIeJBEJDLv9CvvgrolpbqhuGyWeVqx8Ek
         pHhsbjhC3qEhemRiTCnmkbRxqI+zpIiscoQlHThlVSlcXoh89H/WNeyQjgVZ/1/iIyGw
         8Ja//UZoM6nuaCtJrjWU+ftLpZ9W1wFOhqkgDqVcYCV9h4lX9CvsnlZ/QfJtsF+Ijjp7
         dLPjEy8HjMg8eiS+jggrgmgb+mZ34UKT+12JyheKZhE0yJ9eWmwYD9ECBmYl5CnqmhlI
         gtqc0mmsanbupsAnx++VMCS4JxkirGKOVtLsY0/MFDkQVo2JC+8T0Ebvz8MjmpluqwQk
         ecuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yZGOjOJa6J5BvbW2Isi6jN1eE0R+GW4s1SPMFZC5Kw=;
        b=O3a5FA2S17zD7v+XwnPQ+cbgfmw5OCW/dT1CYQiSaDrlmsuN2Fp7R9EuGkdJqDXMD9
         3ezjX8mrBEYBlK8/jZtSEHMiEsmALPKWGa0eAZiGHa2OVpXPnD4XCbBABBeMm7pAB3mB
         ODd16VDljrcvbOcTRADNk6LmuwZ8wv2+RWwzhIs2gI2e7/GAYYEB0/6diV9Bg37ijpD2
         UaKQUq+mKJHuQCCHwN6wGNzqwEhcUwWhR7NMry6hFiGBE8AqQSw/kd5SjOt8fmWM1T7y
         BwvZ902ilIjoP7Y6RxJLxT/dRWxhzFY6jhjyn/md3DAkeoRLVMpkO+YdwkE2bZQkL22N
         9CVg==
X-Gm-Message-State: ANoB5plusrqW/U9jlIEd2pD8pCZum+DRk5vTmoS7AODLcQ6TxJiBbq3K
        aykMNhas0l1P2v85UyJcY2GWUERo8bTwyg==
X-Google-Smtp-Source: AA0mqf5auH6PoDEJI0SjA1qTgUAVsQkVtPyUp2FAubSvKXjG21tEJxhtyMxzFlM8+/CbUjGWjz7rzA==
X-Received: by 2002:a5d:5c11:0:b0:242:704e:c3f8 with SMTP id cc17-20020a5d5c11000000b00242704ec3f8mr31762932wrb.46.1671445173466;
        Mon, 19 Dec 2022 02:19:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bx25-20020a5d5b19000000b00225307f43fbsm9632672wrb.44.2022.12.19.02.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:19:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/6] tests: fix ignored & hidden exit codes
Date:   Mon, 19 Dec 2022 11:19:23 +0100
Message-Id: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1071.g97ce8966538
In-Reply-To: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Various fixes for "git" on the LHS of a pipe, but mostly when in
"test" expressions like:

	test str = "$(git some-command)" &&

Changes since v3[1]:

 * The previous 1/8 and 3/8 were picked independently, and have landed
   on "master". I was waiting for those to graduate before a re-roll.
 * Add a missing test_expect_success to 1/6, as pointed out by René
   (thanks!).
 * Remove commit message mention of the now-dead test_cmp_cmd (thanks
   Eric!)
 * Reword commit messages, fix typos etc. (thanks Junio, and other
   reviewers!)

I think this should address all of the feedback on the v3, except
Junio's suggestion of perhaps re-arranging this series around file
boundaries.

Given the potential size of that range-diff I thought it was better to
mosttly keep the same structure.

1. https://lore.kernel.org/git/cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (6):
  auto-crlf tests: don't lose exit code in loops and outside tests
  t/lib-patch-mode.sh: fix ignored exit codes
  tests: don't lose exit status with "(cd ...; test <op> $(git ...))"
  tests: don't lose exit status with "test <op> $(git ...)"
  tests: don't lose "git" exit codes in "! ( git ... | grep )"
  tests: don't lose misc "git" exit codes

 t/lib-httpd.sh                     |   5 +-
 t/lib-patch-mode.sh                |  11 ++-
 t/lib-submodule-update.sh          |  26 ++++---
 t/t0001-init.sh                    |   9 ++-
 t/t0002-gitfile.sh                 |   4 +-
 t/t0027-auto-crlf.sh               |  66 ++++++++++--------
 t/t0055-beyond-symlinks.sh         |  14 +++-
 t/t0060-path-utils.sh              | 107 +++++++++++++++++++++--------
 t/t0100-previous.sh                |   8 ++-
 t/t1401-symbolic-ref.sh            |   3 +-
 t/t1504-ceiling-dirs.sh            |   8 ++-
 t/t2005-checkout-index-symlinks.sh |   8 ++-
 t/t3200-branch.sh                  |  13 ++--
 t/t3700-add.sh                     |  18 +++--
 t/t3701-add-interactive.sh         |   8 ++-
 t/t5522-pull-symlink.sh            |   4 +-
 t/t5605-clone-local.sh             |  15 ++--
 t/t7402-submodule-rebase.sh        |  23 +++++--
 t/t7504-commit-msg-hook.sh         |   4 +-
 t/t7516-commit-races.sh            |   3 +-
 t/t7810-grep.sh                    |   4 +-
 21 files changed, 243 insertions(+), 118 deletions(-)

Range-diff against v3:
1:  64dfec31fb3 < -:  ----------- merge tests: don't ignore "rev-parse" exit code in helper
2:  394d5e46494 ! 1:  68d276dd421 auto-crlf tests: don't lose exit code in loops and outside tests
    @@ t/t0027-auto-crlf.sh: commit_MIX_chkwrn () {
      	test_expect_success "commit file with mixed EOL onto LF crlf=$crlf attr=$attr" '
      		check_warning "$lfwarn" ${pfx}_LF.err
     @@ t/t0027-auto-crlf.sh: checkout_files () {
    + 	lfmixcrlf=$1 ; shift
    + 	lfmixcr=$1 ; shift
    + 	crlfnul=$1 ; shift
    +-	create_gitattributes "$attr" $ident $aeol &&
    +-	git config core.autocrlf $crlf &&
    ++	test_expect_success "setup config for checkout attr=$attr ident=$ident aeol=$aeol core.autocrlf=$crlf" '
    ++		create_gitattributes "$attr" $ident $aeol &&
    ++		git config core.autocrlf $crlf
    ++	'
      	pfx=eol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
      	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
      	do
3:  4ec075689f6 < -:  ----------- diff tests: fix ignored exit codes in t4023
4:  c080899dd5f ! 2:  d351075f0ab t/lib-patch-mode.sh: fix ignored exit codes
    @@ Commit message
         t/lib-patch-mode.sh: fix ignored exit codes
     
         Fix code added in b319ef70a94 (Add a small patch-mode testing library,
    -    2009-08-13) to use &&-chaining and the newly added "test_cmp_cmd".
    +    2009-08-13) to use &&-chaining.
    +
         This avoids losing both the exit code of a "git" and the "cat"
         processes.
     
    @@ Commit message
         SANITIZE=leak, this code doesn't leak now as far as I can tell, but I
         discovered it while looking at leaks in related code.
     
    -    The "cat _head >expect" here is redundant, we could simply give
    -    "_head" to "test_cmp", but let's be consistent in using the "expect"
    -    and "actual" names for clarity.
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/lib-patch-mode.sh ##
5:  58ac6fe5604 ! 3:  f5b2489609c tests: use "test_cmp" instead of "test" in sub-shells
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    tests: use "test_cmp" instead of "test" in sub-shells
    +    tests: don't lose exit status with "(cd ...; test <op> $(git ...))"
     
    -    Convert a few cases where we were using "test" inside a sub-shell, and
    -    were losing the exit code of "git".
    +    Rewrite tests that ran "git" inside command substitution and lost the
    +    exit status of "git" so that we notice the failing "git".
     
    -    In the case of "t3200-branch.sh" some adjacent code outside of a
    -    sub-shell that was losing the exit code is also being converted, as
    -    it's within the same hunk.
    +    Have them use modern patterns such as a "test_cmp" of the expected
    +    outputs instead, and avoid needlessly spawning sub-shell in favor of
    +    using "git -C <dir>".
    +
    +    We'll fix more of these these in the subsequent commit, for now we're
    +    only converting the cases where this loss of exit code was combined
    +    with spawning a sub-shell. The one exception to that is the casein
    +    "t3200-branch.sh" where adjacent code didn't use a sub-shell, let's
    +    convert that here as it's within the same hunk.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
6:  51f32b42ce6 ! 4:  da66e5bf1c1 tests: don't lose 'test <str> = $(cmd ...)"' exit code
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    tests: don't lose 'test <str> = $(cmd ...)"' exit code
    +    tests: don't lose exit status with "test <op> $(git ...)"
     
    -    Convert some cases in the test suite where we'd lose the exit code of
    -    a command being interpolated as one of the arguments to the "test"
    -    builtin function to use &&-chaining and "test_cmp" instead.
    -
    -    This way we won't lose the exit code, and the failure output will be
    -    more helpful.
    +    As with the preceding commit, rewrite tests that ran "git" inside
    +    command substitution and lost the exit status of "git" so that we
    +    notice the failing "git". This time around we're converting cases that
    +    didn't involve a containing sub-shell around the command substitution.
     
         In the case of "t0060-path-utils.sh" and
         "t2005-checkout-index-symlinks.sh" convert the relevant code to using
7:  307f25db831 ! 5:  9596702978e tests: don't lose "git" exit codes in "! ( git ... | grep )"
    @@ Commit message
         - In the case of "t0055-beyond-symlinks.sh" compare against the
           expected output instead.
     
    +      We could use the same pattern as in the "t3700-add.sh" below, doing
    +      so would have the advantage that if we added an earlier test we
    +      wouldn't need to adjust the "expect" output.
    +
    +      But as "t0055-beyond-symlinks.sh" is a small and focused test (less
    +      than 40 lines in total) let's use "test_cmp" instead.
    +
         - For "t3700-add.sh" use "sed -n" to print the expected "bad" part,
    -      and use "test_must_be_empty" to assert that it's not there.
    +      and use "test_must_be_empty" to assert that it's not there. If we used
    +      "grep" we'd get a non-zero exit code.
    +
    +      We could use "test_expect_code 1 grep", but this is more consistent
    +      with existing patterns in the test suite.
     
           We can also remove a repeated invocation of "git ls-files" for the
           last test that's being modified in that file, and search the
8:  37c75f4a097 ! 6:  94df7a1764e tests: don't lose mist "git" exit codes
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    tests: don't lose mist "git" exit codes
    +    tests: don't lose misc "git" exit codes
     
         Fix a few miscellaneous cases where:
     
-- 
2.39.0.1071.g97ce8966538

