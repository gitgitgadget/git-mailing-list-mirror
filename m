Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA35C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 00:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiLBAHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiLBAHV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 19:07:21 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8886CBFCFA
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 16:07:19 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id n21so7992350ejb.9
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 16:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD3YMBiKTEe1oflyeUB4Dh8YUISf0M+gRRp/2omWjU4=;
        b=ptC3GEb78B753c8CwolLMRA6D77afnWUL7KmRXr7PHhpgaK1aLZFuBMIgbiyfPrt+G
         HlEeAHQm5c7BKzORV2qwJH6yiIIXgFFP3EU6wCmzvLOIraOPQKs+ob45cMIrbNGjTrcS
         CR4qM2KooMtHgHyhvYqJIismnJzKi+MVWLvj1QPChi0qVJZY9bDqGyjaQ/dSD2jBhTqJ
         q1ct5rlaJW30O72dXTy2uWqRjXQyJQ9MhpMNBgqbmdEr1cXE2oG0ufpr1B/WoRiRd46L
         PxSPLOvqJkLcDe0QBOZWPS95Z2etI5aTU44t1i6W669dN7X7Li0V6P4XAg/hy39toWY9
         dg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FD3YMBiKTEe1oflyeUB4Dh8YUISf0M+gRRp/2omWjU4=;
        b=yD7TmOcKi7M9iFqlWkyiEhNjyHQGrQPUMIuGXR0ShAV3k4NeQ43xiakxv10ZjXEcKz
         XDnXoPc8wgwVlY/qetODBu79KXp8uaqn7Nf6kDW2bixtxPeSDnZJNaabIr6UGxJGWrOv
         LWhNWPJKzMYtUo7n6PTQ+JSCpVTHdQBKYTKsecdW0ot1ulN3pTo8adogAdB1KVnoSwSx
         L9kxjMZ5f3o1NSjsK2HFYSMmarHiQl3xIRmHoKIzjmeKf22nelMpkcjgf2nMl6ylu0iL
         /YwiPqwk66HKbZSqJqVND81IZ59QfATqqlzpCNuRe98ZohhSHBP0AKTVrsZRmCDMNy2C
         2Aig==
X-Gm-Message-State: ANoB5pmsaXGbym+jkM/3Hl3brkFFd2f8vIMoK5mJmsEeG3bff+XLF/s4
        HYFg+c4rDhcPAolffJYhj2v/pCM7xbhCVA==
X-Google-Smtp-Source: AA0mqf7wTe95DUMgoDvoag2mZN6dzgiLd3RT0E4pSm1w0BL5Xclh2p/tpyKUY9LR98R3a8Tct30CVw==
X-Received: by 2002:a17:906:2817:b0:7ba:da1f:a727 with SMTP id r23-20020a170906281700b007bada1fa727mr33947101ejc.276.1669939637739;
        Thu, 01 Dec 2022 16:07:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ex19-20020a170907955300b007be4d8a50d8sm2351576ejc.70.2022.12.01.16.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:07:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/8] tests: fix ignored & hidden exit codes
Date:   Fri,  2 Dec 2022 01:06:26 +0100
Message-Id: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.980.g92d3d4579ad
In-Reply-To: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small set of fixes to correct git on the LHS of a pipe, and in $()
within a "test" expression, or where its exit code is otherwise
hidden.

The 1/8 here was originally submitted as part of another series, and
what prompted this re-submission at this time is that the exact same
fix was independently discovered in [2].

This is still just the tip of the iceberg in terms of these issues in
the test suite, but hopefully this will get some attention this time
around.

1. https://lore.kernel.org/git/xmqqmtd33e1h.fsf@gitster.g/
2. https://lore.kernel.org/git/c5b4d091-23c1-5a75-a255-99ec83973d8d@web.de/

Ævar Arnfjörð Bjarmason (8):
  log tests: don't use "exit 1" outside a sub-shell
  auto-crlf tests: check "git checkout" exit code
  diff tests: fix ignored exit codes in t4023
  test-lib-functions: add and use test_cmp_cmd
  t/lib-patch-mode.sh: fix ignored "git" exit codes
  merge tests: don't ignore "rev-parse" exit code in helper
  tests: use "test_cmp_cmd" instead of "test" in sub-shells
  tests: use "test_cmp_cmd" in misc tests

 t/lib-httpd.sh                     |  3 +-
 t/lib-patch-mode.sh                |  9 +++--
 t/lib-submodule-update.sh          | 22 +++++-------
 t/t0001-init.sh                    |  4 +--
 t/t0002-gitfile.sh                 |  2 +-
 t/t0027-auto-crlf.sh               | 14 +++++---
 t/t0060-path-utils.sh              | 57 ++++++++++++++++--------------
 t/t0100-previous.sh                |  4 +--
 t/t1401-symbolic-ref.sh            |  3 +-
 t/t1504-ceiling-dirs.sh            |  6 ++--
 t/t2005-checkout-index-symlinks.sh |  2 +-
 t/t3200-branch.sh                  |  9 ++---
 t/t3701-add-interactive.sh         |  9 +++--
 t/t4023-diff-rename-typechange.sh  | 12 +++----
 t/t4205-log-pretty-formats.sh      |  2 +-
 t/t5522-pull-symlink.sh            |  2 +-
 t/t5605-clone-local.sh             |  9 +++--
 t/t7402-submodule-rebase.sh        | 10 +++---
 t/t7504-commit-msg-hook.sh         |  2 +-
 t/t7516-commit-races.sh            |  3 +-
 t/t7600-merge.sh                   |  9 +++--
 t/t7810-grep.sh                    |  2 +-
 t/test-lib-functions.sh            | 18 ++++++++++
 23 files changed, 119 insertions(+), 94 deletions(-)

Range-diff against v1:
6:  259b4618fcb = 1:  7c9f8d2830f log tests: don't use "exit 1" outside a sub-shell
3:  cfc1abbf7e3 = 2:  345a667d5bb auto-crlf tests: check "git checkout" exit code
1:  f8a382841d5 = 3:  c5feef1c808 diff tests: fix ignored exit codes in t4023
4:  df1b674b8a7 ! 4:  c36060934a6 test-lib-functions: add and use test_cmp_cmd
    @@ Commit message
                 test_cmp_cmd --stdin <some-cmd> <expect
                 test_cmp_cmd --ignore-stderr "output" <some-cmd>
     
    -    By using this in t0060-path.sh we'll catch cases where "git" or
    -    "test-tool" errors (such as segfaults or abort()) were previously
    -    hidden, and we'd either pass the test, or fail in some subsequent
    -    assertion.
    +    By using this in we'll catch cases where "git" or "test-tool"
    +    errors (such as segfaults or abort()) were previously hidden, and we'd
    +    either pass the test, or fail in some subsequent assertion.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## t/lib-submodule-update.sh ##
    +@@ t/lib-submodule-update.sh: test_git_directory_exists () {
    + 	if test -f sub1/.git
    + 	then
    + 		# does core.worktree point at the right place?
    +-		test "$(git -C .git/modules/$1 config core.worktree)" = "../../../$1"
    ++		test_cmp_cmd "../../../$1" git -C ".git/modules/$1" config core.worktree
    + 	fi
    + }
    + 
    +
    + ## t/t0001-init.sh ##
    +@@ t/t0001-init.sh: test_expect_success 'invalid default branch name' '
    + test_expect_success 'branch -m with the initial branch' '
    + 	git init rename-initial &&
    + 	git -C rename-initial branch -m renamed &&
    +-	test renamed = $(git -C rename-initial symbolic-ref --short HEAD) &&
    ++	test_cmp_cmd renamed git -C rename-initial symbolic-ref --short HEAD &&
    + 	git -C rename-initial branch -m renamed again &&
    +-	test again = $(git -C rename-initial symbolic-ref --short HEAD)
    ++	test_cmp_cmd again git -C rename-initial symbolic-ref --short HEAD
    + '
    + 
    + test_done
    +
    + ## t/t0002-gitfile.sh ##
    +@@ t/t0002-gitfile.sh: test_expect_success 'bad setup: invalid .git file path' '
    + 
    + test_expect_success 'final setup + check rev-parse --git-dir' '
    + 	echo "gitdir: $REAL" >.git &&
    +-	test "$REAL" = "$(git rev-parse --git-dir)"
    ++	test_cmp_cmd "$REAL" git rev-parse --git-dir
    + '
    + 
    + test_expect_success 'check hash-object' '
    +
      ## t/t0060-path-utils.sh ##
     @@ t/t0060-path-utils.sh: TEST_PASSES_SANITIZE_LEAK=true
      
    @@ t/t0060-path-utils.sh: TEST_PASSES_SANITIZE_LEAK=true
     -	test_expect_success $3 "normalize path: $1 => $2" \
     -	"test \"\$(test-tool path-utils normalize_path_copy '$1')\" = '$expected'"
     +	test_expect_success $3 "normalize path: $1 => $2" "
    -+		echo '$expected' >expect &&
    -+		test-tool path-utils normalize_path_copy '$1' >actual &&
    -+		test_cmp expect actual
    ++		test_cmp_cmd '$expected' test-tool path-utils normalize_path_copy '$1'
     +	"
      }
      
      relative_path() {
    + 	expected=$(test-tool path-utils print_path "$3")
    +-	test_expect_success $4 "relative path: $1 $2 => $3" \
    +-	"test \"\$(test-tool path-utils relative_path '$1' '$2')\" = '$expected'"
    ++	test_expect_success $4 "relative path: $1 $2 => $3" "
    ++		test_cmp_cmd '$expected' test-tool path-utils relative_path '$1' '$2'
    ++	"
    + }
    + 
    + test_submodule_relative_url() {
    + 	test_expect_success "test_submodule_relative_url: $1 $2 $3 => $4" "
    +-		actual=\$(test-tool submodule resolve-relative-url '$1' '$2' '$3') &&
    +-		test \"\$actual\" = '$4'
    ++		test_cmp_cmd '$4' test-tool submodule resolve-relative-url '$1' '$2' '$3'
    + 	"
    + }
    + 
    +@@ t/t0060-path-utils.sh: ancestor() {
    + 		expected=$(($expected-$rootslash+$rootoff))
    + 		;;
    + 	esac
    +-	test_expect_success $4 "longest ancestor: $1 $2 => $expected" \
    +-	"actual=\$(test-tool path-utils longest_ancestor_length '$1' '$2') &&
    +-	 test \"\$actual\" = '$expected'"
    ++	test_expect_success $4 "longest ancestor: $1 $2 => $expected" "
    ++		test_cmp_cmd '$expected' test-tool path-utils longest_ancestor_length '$1' '$2'
    ++	"
    + }
    + 
    + # Some absolute path tests should be skipped on Windows due to path mangling
     @@ t/t0060-path-utils.sh: ancestor D:/Users/me C:/ -1 MINGW
      ancestor //server/share/my-directory //server/share/ 14 MINGW
      
    @@ t/t0060-path-utils.sh: test_expect_success 'prefix_path rejects absolute path to
      
      relative_path /foo/a/b/c/	/foo/a/b/	c/
     
    + ## t/t0100-previous.sh ##
    +@@ t/t0100-previous.sh: test_expect_success 'branch -d @{-1}' '
    + 	test_commit A &&
    + 	git checkout -b junk &&
    + 	git checkout - &&
    +-	test "$(git symbolic-ref HEAD)" = refs/heads/main &&
    ++	test_cmp_cmd refs/heads/main git symbolic-ref HEAD &&
    + 	git branch -d @{-1} &&
    + 	test_must_fail git rev-parse --verify refs/heads/junk
    + '
    +@@ t/t0100-previous.sh: test_expect_success 'branch -d @{-12} when there is not enough switches yet' '
    + 	git reflog expire --expire=now &&
    + 	git checkout -b junk2 &&
    + 	git checkout - &&
    +-	test "$(git symbolic-ref HEAD)" = refs/heads/main &&
    ++	test_cmp_cmd refs/heads/main git symbolic-ref HEAD &&
    + 	test_must_fail git branch -d @{-12} &&
    + 	git rev-parse --verify refs/heads/main
    + '
    +
    + ## t/t1504-ceiling-dirs.sh ##
    +@@ t/t1504-ceiling-dirs.sh: TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    + 
    + test_prefix() {
    +-	test_expect_success "$1" \
    +-	"test '$2' = \"\$(git rev-parse --show-prefix)\""
    ++	local expect="$2" &&
    ++	test_expect_success "$1: git rev-parse --show-prefix is '$2'" '
    ++		test_cmp_cmd "$expect" git rev-parse --show-prefix
    ++	'
    + }
    + 
    + test_fail() {
    +
      ## t/test-lib-functions.sh ##
     @@ t/test-lib-functions.sh: test_cmp_rev () {
      	fi
2:  85c6ab40e91 ! 5:  f826a336c3d t/lib-patch-mode.sh: fix ignored "git" exit codes
    @@ Commit message
         t/lib-patch-mode.sh: fix ignored "git" exit codes
     
         Fix code added in b319ef70a94 (Add a small patch-mode testing library,
    -    2009-08-13) to use &&-chaining and test_cmp instead of interpolating
    -    "git" commands in a "test" statement.
    +    2009-08-13) to use &&-chaining and the newly added "test_cmp_cmd"
    +    instead of interpolating "git" commands in a "test" statement.
     
         This fixes cases where we'd have e.g. missed memory leaks under
         SANITIZE=leak, this code doesn't leak now as far as I can tell, but I
    @@ t/lib-patch-mode.sh: set_and_save_state () {
     +	cat "$1" >actual &&
     +	test_cmp expect actual &&
     +
    -+	echo "$3" >expect
    -+	git show :"$1" >actual &&
    -+	test_cmp expect actual
    ++	test_cmp_cmd "$3" git show :"$1"
      }
      
      # verify_saved_state <path>
    @@ t/lib-patch-mode.sh: save_head () {
      
      verify_saved_head () {
     -	test "$(cat _head)" = "$(git rev-parse HEAD)"
    -+	cat _head >expect &&
    -+	git rev-parse HEAD >actual &&
    -+	test_cmp expect actual
    ++	test_cmp_cmd "$(cat _head)" git rev-parse HEAD
      }
5:  563666f9426 = 6:  5715ff7f0f7 merge tests: don't ignore "rev-parse" exit code in helper
-:  ----------- > 7:  d090478aa84 tests: use "test_cmp_cmd" instead of "test" in sub-shells
-:  ----------- > 8:  979a7f003f8 tests: use "test_cmp_cmd" in misc tests
-- 
2.39.0.rc1.980.g92d3d4579ad

