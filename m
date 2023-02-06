Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BF6C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjBFWor (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjBFWoq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:44:46 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F233029A
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:44:44 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y1so11920084wru.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpcPL7O2rYJW3KdqhJcqcE/uLQGUQLaLX2zGRD7MPnU=;
        b=VQmH9mUd07jEKbu/pdpfpWSsxo9Su491rpTxarPGdrsvGsSgWJozmGDk5K25gUCFnG
         DwgVvAMTHAJ6n6vE6xL3wjS6obIoW1FTsbBPRYbxxhOFHFnP4FIiDSf0noQDEt9bGiGu
         hSjcwktJumskYAbOedLxZyUGwXxhpozrywXPTrfz9WuhbvxF4kq5LUiUpxopXc3HR1/H
         BC2hmgZpZkPVMqirkA6fY1G2u7QA0JcNUBei+aBkdTqcun0v9WMsfgXz7GaMnpxbZcin
         bvehdkWnq/NzHgFQpi2zpuoKJuAzyW54GoePtqLCUSRfMrWSLaF1NBveAy+ZgGifs4UK
         hdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpcPL7O2rYJW3KdqhJcqcE/uLQGUQLaLX2zGRD7MPnU=;
        b=gKCo1pluASDQQV6wG3GxVyLSLuLSGrtgGYystk3sZVZ+FIrwQQTSmAM+5eSLuY/Mzh
         w1NeMiAR50+cNVb78OTLhR5w66ZYZkdOeJuXTuU+twW4ud5o9EgHdhfQpQiWkpOdt4Vi
         xcrAMKhCNnkR4g5kGkD0z+G32kOOah47Q9YFbGloMVwxwRrote/YHEmmCMsiexetxfEx
         4jGq6j11z77Qknz0qX7XeHAxwJtTpMK3UCNlkDg5gz1pQB+cd+SZ+i7czRQ159zV3X05
         PWfFXV9FmDIwl1vXu5sx65+JdJs2RWJiVBdGGLOF7npqAYaoNTHuxJFnh74DdmMXJFIs
         05og==
X-Gm-Message-State: AO0yUKXewYslTdNQGKISrnVOmqpg3yo9Sttlbv/QPeldqRTAm7bUDx4b
        vZLgkRJilgmvDmfWQAmJGXM1ShGEPoz2bUpz
X-Google-Smtp-Source: AK7set8B6aiuM2eaOJbWxunOjDuoK5dQ1zzTHom3FqqtnMnNep+hgd1LI9ZxqAu+3+6MbcmAJ+mWDw==
X-Received: by 2002:adf:e981:0:b0:2c3:f03c:f4c5 with SMTP id h1-20020adfe981000000b002c3f03cf4c5mr745568wrm.63.1675723482554;
        Mon, 06 Feb 2023 14:44:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7-20020a056000128700b002c3df9279f5sm6657643wrx.48.2023.02.06.14.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:44:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/6] tests: fix ignored & hidden exit codes
Date:   Mon,  6 Feb 2023 23:44:27 +0100
Message-Id: <cover-v5-0.6-00000000000-20230206T224200Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
References: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Various fixes for "git" on the LHS of a pipe, but mostly when in
"test" expressions like:

       test str = "$(git some-command)" &&

Changes since v4[1]:

 * Tried to address all outstanding concernse, some with commit
   message clarifications, others with code changes.
 * The main code change here is to avoid converting code adjacent to
   the fixed "test" code away from sub-shell use, per Junio's request.

Branch & CI for this at:
https://github.com/avar/git/tree/avar/fix-even-more-broken-test-code-hiding-failures-5

1. https://lore.kernel.org/git/cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (6):
  auto-crlf tests: don't lose exit code in loops and outside tests
  t/lib-patch-mode.sh: fix ignored exit codes
  tests: don't lose exit status with "(cd ...; test <op> $(git ...))"
  tests: don't lose exit status with "test <op> $(git ...)"
  tests: don't lose "git" exit codes in "! ( git ... | grep )"
  tests: don't lose misc "git" exit codes

 t/lib-httpd.sh                     |   8 ++-
 t/lib-patch-mode.sh                |  11 ++-
 t/lib-submodule-update.sh          |  26 ++++---
 t/t0001-init.sh                    |   9 ++-
 t/t0002-gitfile.sh                 |   4 +-
 t/t0027-auto-crlf.sh               |  66 ++++++++++--------
 t/t0055-beyond-symlinks.sh         |  14 +++-
 t/t0060-path-utils.sh              | 108 +++++++++++++++++++++--------
 t/t0100-previous.sh                |   8 ++-
 t/t1401-symbolic-ref.sh            |   3 +-
 t/t1504-ceiling-dirs.sh            |   8 ++-
 t/t2005-checkout-index-symlinks.sh |   8 ++-
 t/t3200-branch.sh                  |   8 ++-
 t/t3700-add.sh                     |  18 +++--
 t/t3701-add-interactive.sh         |   8 ++-
 t/t5522-pull-symlink.sh            |   4 +-
 t/t5605-clone-local.sh             |  12 +++-
 t/t7402-submodule-rebase.sh        |  23 ++++--
 t/t7504-commit-msg-hook.sh         |   4 +-
 t/t7516-commit-races.sh            |   3 +-
 t/t7810-grep.sh                    |   4 +-
 21 files changed, 245 insertions(+), 112 deletions(-)

Range-diff against v4:
1:  68d276dd421 ! 1:  66d0f91e6aa auto-crlf tests: don't lose exit code in loops and outside tests
    @@ Commit message
         this failure under SANITIZE=leak when these invocations had errored
         out, even under "--immediate".
     
    +    For checkout_files() we could run one test_expect_success() instead of
    +    the 5 we run now in a loop.
    +
    +    But as this function added in [1] is already taking pains to split up
    +    its setup into phases (there are 5 more "test_expect_success()" at the
    +    end of it already, see [1]), let's follow that existing convention.
    +
    +    1. 343151dcbdf (t0027: combinations of core.autocrlf, core.eol and text, 2014-06-29)
    +
         Helped-by: René Scharfe <l.s.r@web.de>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
2:  d351075f0ab ! 2:  97f8b6a7b86 t/lib-patch-mode.sh: fix ignored exit codes
    @@ Commit message
         SANITIZE=leak, this code doesn't leak now as far as I can tell, but I
         discovered it while looking at leaks in related code.
     
    +    For "verify_saved_head()" we could make use of "test_cmp_rev" with
    +    some changes, but it uses "git rev-parse --verify", and this existing
    +    test does not. I think it could safely use it, but let's avoid the
    +    while-at-it change, and narrowly fix the exit code problem.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/lib-patch-mode.sh ##
3:  f5b2489609c ! 3:  d8f4c4a6d9e tests: don't lose exit status with "(cd ...; test <op> $(git ...))"
    @@ Commit message
         exit status of "git" so that we notice the failing "git".
     
         Have them use modern patterns such as a "test_cmp" of the expected
    -    outputs instead, and avoid needlessly spawning sub-shell in favor of
    -    using "git -C <dir>".
    +    outputs instead.
     
         We'll fix more of these these in the subsequent commit, for now we're
         only converting the cases where this loss of exit code was combined
    -    with spawning a sub-shell. The one exception to that is the casein
    -    "t3200-branch.sh" where adjacent code didn't use a sub-shell, let's
    -    convert that here as it's within the same hunk.
    +    with spawning a sub-shell.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/lib-httpd.sh: test_http_push_nonff () {
      		test_must_fail git push -v origin >output 2>&1 &&
     -		(cd "$REMOTE_REPO" &&
     -		 test $HEAD = $(git rev-parse --verify HEAD))
    -+		echo "$HEAD" >expect &&
    -+		git -C "$REMOTE_REPO" rev-parse --verify HEAD >actual &&
    -+		test_cmp expect actual
    ++		(
    ++			cd "$REMOTE_REPO" &&
    ++			echo "$HEAD" >expect &&
    ++			git rev-parse --verify HEAD >actual &&
    ++			test_cmp expect actual
    ++		)
      	'
      
      	test_expect_success 'non-fast-forward push show ref status' '
    @@ t/t0060-path-utils.sh: test_expect_success 'prefix_path rejects absolute path to
      	ln -s repo repolink &&
     -	test "a" = "$(cd repo && test-tool path-utils prefix_path prefix "$(pwd)/../repolink/a")"
     +	echo "a" >expect &&
    -+	test-tool -C repo path-utils prefix_path prefix "$(cd repo && pwd)/../repolink/a" >actual &&
    ++	repo_path="$(cd repo && pwd)" &&
    ++	test-tool -C repo path-utils prefix_path prefix "$repo_path/../repolink/a" >actual &&
     +	test_cmp expect actual
      '
      
      relative_path /foo/a/b/c/	/foo/a/b/	c/
     
      ## t/t3200-branch.sh ##
    -@@ t/t3200-branch.sh: test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
    - test_expect_success 'git branch -M baz bam should succeed within a worktree in which baz is checked out' '
    - 	git checkout -b baz &&
    - 	git worktree add -f bazdir baz &&
    --	(
    --		cd bazdir &&
    --		git branch -M baz bam &&
    +@@ t/t3200-branch.sh: test_expect_success 'git branch -M baz bam should succeed within a worktree in w
    + 	(
    + 		cd bazdir &&
    + 		git branch -M baz bam &&
     -		test $(git rev-parse --abbrev-ref HEAD) = bam
    --	) &&
    ++		echo bam >expect &&
    ++		git rev-parse --abbrev-ref HEAD >actual &&
    ++		test_cmp expect actual
    + 	) &&
     -	test $(git rev-parse --abbrev-ref HEAD) = bam &&
    -+	git -C "$bazdir" branch -M baz bam &&
    -+	echo "bam" >expect &&
    -+	git -C "$bazdir" rev-parse --abbrev-ref HEAD >actual &&
    -+	test_cmp expect actual &&
    -+	echo "bam" >expect &&
    ++	echo bam >expect &&
     +	git rev-parse --abbrev-ref HEAD >actual &&
     +	test_cmp expect actual &&
      	rm -r bazdir &&
    @@ t/t5605-clone-local.sh: test_expect_success 'preparing origin repository' '
      	git bundle create b2.bundle main &&
      	mkdir dir &&
     @@ t/t5605-clone-local.sh: test_expect_success 'preparing origin repository' '
    - 
      test_expect_success 'local clone without .git suffix' '
      	git clone -l -s a b &&
    --	(cd b &&
    + 	(cd b &&
     -	test "$(git config --bool core.bare)" = false &&
    --	git fetch)
     +	echo false >expect &&
    -+	git -C b config --bool core.bare >actual &&
    ++	git config --bool core.bare >actual &&
     +	test_cmp expect actual &&
    -+	git -C b fetch
    + 	git fetch)
      '
      
    - test_expect_success 'local clone with .git suffix' '
     
      ## t/t7402-submodule-rebase.sh ##
     @@ t/t7402-submodule-rebase.sh: test_expect_success 'stash with a dirty submodule' '
4:  da66e5bf1c1 = 4:  e6f56478b65 tests: don't lose exit status with "test <op> $(git ...)"
5:  9596702978e = 5:  55abdbef49f tests: don't lose "git" exit codes in "! ( git ... | grep )"
6:  94df7a1764e = 6:  e7f10c0641a tests: don't lose misc "git" exit codes
-- 
2.39.1.1425.gac85d95d48c

