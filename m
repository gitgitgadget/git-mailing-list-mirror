Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95133C47088
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiLBLxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiLBLxa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:53:30 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8207CD78D6
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:53:06 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id o13so11033884ejm.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bu7RqQmje+byKwoVYxVRt7q39+qgiey3lRMSOCllgwM=;
        b=WTbVJQ+EhdP6sfhBA75FP3/bWGvt0LL1tFl8I13qsfQ4PWRBFy9Z+wSO29VBqYDc2R
         65ihX8PwuvRXo5SqHiuRvIjgoQJlXZrVjcFyjC1V4M5SLF8nc+Z58sxH9Mau43c3mdlC
         F3xCeDZwBrhUGtwqdsfXfAKxGTnoN9IO6fwOKdDf9wsFvKQ+GLfUOCr8CcMtaGlghj8N
         VV5+oYFkrRiZ5CvTIxHYBrmhO0nJ90ARcHD/WvbAQLJqawskVnAjAru5/6HgOvxJnX9k
         Y1FHWs6KJBpYn6URFuKS0AR+LinuZ9Y+EydlLdEZY2UV/ErTP3zX6/3PYEkvGICkGxCi
         TAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bu7RqQmje+byKwoVYxVRt7q39+qgiey3lRMSOCllgwM=;
        b=MUF4Vm2nEKW5AIJRDloQiJZRFlJNDWWKDSLW+NPORbMx8PUJDYesbJ5UujJve9uiFw
         dAx/corrf9/J5ZO3jH+HbDgCXXM4zdbYtrqWehnzHnfVuB/aqjn4ZXQqvI2tqrK5Ws4J
         hCLRPabK1nfFhXlZsVkM0jjM86L3GqDWQsjo/74a9VdLxTVQ45lXb2QfCNbMjlYda+N7
         HXjVxJeW/lkq9roluHimp3ovd+/0uSMiZ0wIkqVtaXYZ0T4z8AFASk7fnlQdIz3RGqF6
         +NhrlAADnqM5JBK7AL8kzCaPfKXQjxfhCqRBD2l1C18dHzdf72UssPPPVskmQBfC7WhT
         kBTQ==
X-Gm-Message-State: ANoB5plp0ieJ4/Gz2ngOHUobY1Yjcr5a7ymXfEr0Hv/mvwXBSNmJYGEt
        81zlZEmfPlEgSz5uw7276Or08Ty+NlMnNQ==
X-Google-Smtp-Source: AA0mqf4WT2Qac/nK89f3o0WXQU958XF1NG+ft2Ts+mz6jEXvXSTIINsV9ZAh8YxHIEV3Wtr5NYXB9w==
X-Received: by 2002:a17:906:17da:b0:7bb:d55e:417f with SMTP id u26-20020a17090617da00b007bbd55e417fmr34349238eje.13.1669981984252;
        Fri, 02 Dec 2022 03:53:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q20-20020aa7da94000000b00458947539desm2833754eds.78.2022.12.02.03.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:53:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/8] tests: fix ignored & hidden exit codes
Date:   Fri,  2 Dec 2022 12:52:33 +0100
Message-Id: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.981.gf846af54b4b
In-Reply-To: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Various fixes for "git" on the LHS of a pipe, but mostly when in
"test" expressions like:

	test str = "$(git some-command)" &&

Changes since v2
(https://lore.kernel.org/git/cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com/):

 * Ejected 1/8, as René's identical patch has been queued in "seen"
 * The "test_cmp_cmd" helper is gone, instead we just use the same
   three echo/git/test_cmp lines every time.

   I agree that introducing a new helper with some odd semantics was
   probably not a good idea at this time.  It would be nice to do some
   of these as one line, but that probably doesn't justify the helper.

 * Since we're not using the helper the latter part of this series is
   now split up by the category of fix.
 * Rewrote the t0027-auto-crlf.sh commit to address the concerns
   raised.
 * Avid removing redundant code from t7600-merge.sh, and just fix the
   hidden exit code.
 * Small bits here and there, which I think should collectively
   address all outstanding feedback on the v2. Thank all!

Ævar Arnfjörð Bjarmason (8):
  merge tests: don't ignore "rev-parse" exit code in helper
  auto-crlf tests: don't lose exit code in loops and outside tests
  diff tests: fix ignored exit codes in t4023
  t/lib-patch-mode.sh: fix ignored exit codes
  tests: use "test_cmp" instead of "test" in sub-shells
  tests: don't lose 'test <str> = $(cmd ...)"' exit code
  tests: don't lose "git" exit codes in "! ( git ... | grep )"
  tests: don't lose mist "git" exit codes

 t/lib-httpd.sh                     |   5 +-
 t/lib-patch-mode.sh                |  11 ++-
 t/lib-submodule-update.sh          |  26 ++++---
 t/t0001-init.sh                    |   9 ++-
 t/t0002-gitfile.sh                 |   4 +-
 t/t0027-auto-crlf.sh               |  60 +++++++++-------
 t/t0055-beyond-symlinks.sh         |  14 +++-
 t/t0060-path-utils.sh              | 107 +++++++++++++++++++++--------
 t/t0100-previous.sh                |   8 ++-
 t/t1401-symbolic-ref.sh            |   3 +-
 t/t1504-ceiling-dirs.sh            |   8 ++-
 t/t2005-checkout-index-symlinks.sh |   8 ++-
 t/t3200-branch.sh                  |  13 ++--
 t/t3700-add.sh                     |  18 +++--
 t/t3701-add-interactive.sh         |   8 ++-
 t/t4023-diff-rename-typechange.sh  |  12 ++--
 t/t5522-pull-symlink.sh            |   4 +-
 t/t5605-clone-local.sh             |  15 ++--
 t/t7402-submodule-rebase.sh        |  23 +++++--
 t/t7504-commit-msg-hook.sh         |   4 +-
 t/t7516-commit-races.sh            |   3 +-
 t/t7600-merge.sh                   |   2 +-
 t/t7810-grep.sh                    |   4 +-
 23 files changed, 246 insertions(+), 123 deletions(-)

Range-diff against v2:
1:  7c9f8d2830f < -:  ----------- log tests: don't use "exit 1" outside a sub-shell
6:  5715ff7f0f7 ! 1:  64dfec31fb3 merge tests: don't ignore "rev-parse" exit code in helper
    @@ Commit message
         merge tests: don't ignore "rev-parse" exit code in helper
     
         Change the verify_mergeheads() helper the check the exit code of "git
    -    rev-parse". The "$rest" variable added in 274a5c06d52 (merge: record
    -    tag objects without peeling in MERGE_HEAD, 2011-11-07) wasn't being
    -    used.
    -
    -    Such a thing is needed to support the .git/MERGE_HEAD format in
    -    general, but in this case we have no such addition to the line. So
    -    let's compare with "test_cmp" instead, we can always add back this
    -    "$rest" parsing if it's needed in the future.
    +    rev-parse".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t7600-merge.sh ##
    -@@ t/t7600-merge.sh: verify_parents () {
    - }
    - 
    - verify_mergeheads () {
    --	test_write_lines "$@" >mergehead.expected &&
    --	while read sha1 rest
    -+	for rev in "$@"
    +@@ t/t7600-merge.sh: verify_mergeheads () {
    + 	test_write_lines "$@" >mergehead.expected &&
    + 	while read sha1 rest
      	do
     -		git rev-parse $sha1
    --	done <.git/MERGE_HEAD >mergehead.actual &&
    --	test_cmp mergehead.expected mergehead.actual
    -+		git rev-parse $rev || return 1
    -+	done >mergehead.expected &&
    -+	test_cmp mergehead.expected .git/MERGE_HEAD
    ++		git rev-parse $sha1 || return 1
    + 	done <.git/MERGE_HEAD >mergehead.actual &&
    + 	test_cmp mergehead.expected mergehead.actual
      }
    - 
    - verify_no_mergehead () {
2:  345a667d5bb ! 2:  394d5e46494 auto-crlf tests: check "git checkout" exit code
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    auto-crlf tests: check "git checkout" exit code
    +    auto-crlf tests: don't lose exit code in loops and outside tests
     
    -    Don't hide the exit code from the "git checkout" we run to checkout
    -    our attributes file.
    +    Change the functions which are called from within
    +    "test_expect_success" to add the "|| return 1" idiom to their
    +    for-loops, so we won't lose the exit code of "cp", "git" etc.
     
    -    This fixes cases where we'd have e.g. missed memory leaks under
    +    Then for those setup functions that aren't called from a
    +    "test_expect_success" we need to put the setup code in a
    +    "test_expect_success" as well. It would not be enough to properly
    +    &&-chain these, as the calling code is the top-level script itself. As
    +    we don't run the tests with "set -e" we won't report failing commands
    +    at the top-level.
    +
    +    The "checkout" part of this would miss memory leaks under
         SANITIZE=leak, this code doesn't leak (the relevant "git checkout"
         leak has been fixed), but in a past version of git we'd continue past
         this failure under SANITIZE=leak when these invocations had errored
         out, even under "--immediate".
     
    +    Helped-by: René Scharfe <l.s.r@web.de>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t0027-auto-crlf.sh ##
    +@@ t/t0027-auto-crlf.sh: create_NNO_MIX_files () {
    + 				cp CRLF        ${pfx}_CRLF.txt &&
    + 				cp CRLF_mix_LF ${pfx}_CRLF_mix_LF.txt &&
    + 				cp LF_mix_CR   ${pfx}_LF_mix_CR.txt &&
    +-				cp CRLF_nul    ${pfx}_CRLF_nul.txt
    ++				cp CRLF_nul    ${pfx}_CRLF_nul.txt ||
    ++				return 1
    + 			done
    + 		done
    + 	done
    +@@ t/t0027-auto-crlf.sh: commit_check_warn () {
    + 	do
    + 		fname=${pfx}_$f.txt &&
    + 		cp $f $fname &&
    +-		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
    ++		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err" ||
    ++		return 1
    + 	done &&
    + 	git commit -m "core.autocrlf $crlf" &&
    + 	check_warning "$lfname" ${pfx}_LF.err &&
    +@@ t/t0027-auto-crlf.sh: commit_chk_wrnNNO () {
    + 	lfmixcr=$1 ; shift
    + 	crlfnul=$1 ; shift
    + 	pfx=NNO_attr_${attr}_aeol_${aeol}_${crlf}
    +-	#Commit files on top of existing file
    +-	create_gitattributes "$attr" $aeol &&
    +-	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
    +-	do
    +-		fname=${pfx}_$f.txt &&
    +-		cp $f $fname &&
    +-		printf Z >>"$fname" &&
    +-		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
    +-	done
    ++
    ++	test_expect_success 'setup commit NNO files' '
    ++		#Commit files on top of existing file
    ++		create_gitattributes "$attr" $aeol &&
    ++		for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
    ++		do
    ++			fname=${pfx}_$f.txt &&
    ++			cp $f $fname &&
    ++			printf Z >>"$fname" &&
    ++			git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err" ||
    ++			return 1
    ++		done
    ++	'
    + 
    + 	test_expect_success "commit NNO files crlf=$crlf attr=$attr LF" '
    + 		check_warning "$lfwarn" ${pfx}_LF.err
    +@@ t/t0027-auto-crlf.sh: commit_MIX_chkwrn () {
    + 	lfmixcr=$1 ; shift
    + 	crlfnul=$1 ; shift
    + 	pfx=MIX_attr_${attr}_aeol_${aeol}_${crlf}
    +-	#Commit file with CLRF_mix_LF on top of existing file
    +-	create_gitattributes "$attr" $aeol &&
    +-	for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
    +-	do
    +-		fname=${pfx}_$f.txt &&
    +-		cp CRLF_mix_LF $fname &&
    +-		printf Z >>"$fname" &&
    +-		git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err"
    +-	done
    ++
    ++	test_expect_success 'setup commit file with mixed EOL' '
    ++		#Commit file with CLRF_mix_LF on top of existing file
    ++		create_gitattributes "$attr" $aeol &&
    ++		for f in LF CRLF CRLF_mix_LF LF_mix_CR CRLF_nul
    ++		do
    ++			fname=${pfx}_$f.txt &&
    ++			cp CRLF_mix_LF $fname &&
    ++			printf Z >>"$fname" &&
    ++			git -c core.autocrlf=$crlf add $fname 2>"${pfx}_$f.err" ||
    ++			return 1
    ++		done
    ++	'
    + 
    + 	test_expect_success "commit file with mixed EOL onto LF crlf=$crlf attr=$attr" '
    + 		check_warning "$lfwarn" ${pfx}_LF.err
     @@ t/t0027-auto-crlf.sh: checkout_files () {
      	pfx=eol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
      	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
    @@ t/t0027-auto-crlf.sh: checkout_files () {
     -		rm crlf_false_attr__$f.txt &&
     -		if test -z "$ceol"; then
     -			git checkout -- crlf_false_attr__$f.txt
    -+		if test -z "$ceol"
    -+		then
    -+			test_expect_success "setup $f checkout" '
    -+				rm crlf_false_attr__$f.txt &&
    -+				git checkout -- crlf_false_attr__$f.txt
    -+			'
    - 		else
    +-		else
     -			git -c core.eol=$ceol checkout -- crlf_false_attr__$f.txt
    -+			test_expect_success "setup $f checkout with core.eol=$ceol" '
    -+				rm crlf_false_attr__$f.txt &&
    -+				git -c core.eol=$ceol checkout -- crlf_false_attr__$f.txt
    -+			'
    - 		fi
    +-		fi
    ++		test_expect_success "setup $f checkout ${ceol:+ with -c core.eol=$ceol}"  '
    ++			rm -f crlf_false_attr__$f.txt &&
    ++			git ${ceol:+-c core.eol=$ceol} checkout -- crlf_false_attr__$f.txt
    ++		'
      	done
      
    + 	test_expect_success "ls-files --eol attr=$attr $ident aeol=$aeol core.autocrlf=$crlf core.eol=$ceol" '
3:  c5feef1c808 = 3:  4ec075689f6 diff tests: fix ignored exit codes in t4023
5:  f826a336c3d ! 4:  c080899dd5f t/lib-patch-mode.sh: fix ignored "git" exit codes
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    t/lib-patch-mode.sh: fix ignored "git" exit codes
    +    t/lib-patch-mode.sh: fix ignored exit codes
     
         Fix code added in b319ef70a94 (Add a small patch-mode testing library,
    -    2009-08-13) to use &&-chaining and the newly added "test_cmp_cmd"
    -    instead of interpolating "git" commands in a "test" statement.
    +    2009-08-13) to use &&-chaining and the newly added "test_cmp_cmd".
    +    This avoids losing both the exit code of a "git" and the "cat"
    +    processes.
     
         This fixes cases where we'd have e.g. missed memory leaks under
         SANITIZE=leak, this code doesn't leak now as far as I can tell, but I
    @@ t/lib-patch-mode.sh: set_and_save_state () {
     -	test "$(cat "$1")" = "$2" &&
     -	test "$(git show :"$1")" = "$3"
     +	echo "$2" >expect &&
    -+	cat "$1" >actual &&
    -+	test_cmp expect actual &&
    ++	test_cmp expect "$1" &&
     +
    -+	test_cmp_cmd "$3" git show :"$1"
    ++	echo "$3" >expect &&
    ++	git show :"$1" >actual &&
    ++	test_cmp expect actual
      }
      
      # verify_saved_state <path>
    @@ t/lib-patch-mode.sh: save_head () {
      
      verify_saved_head () {
     -	test "$(cat _head)" = "$(git rev-parse HEAD)"
    -+	test_cmp_cmd "$(cat _head)" git rev-parse HEAD
    ++	git rev-parse HEAD >actual &&
    ++	test_cmp _head actual
      }
7:  d090478aa84 ! 5:  58ac6fe5604 tests: use "test_cmp_cmd" instead of "test" in sub-shells
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    tests: use "test_cmp_cmd" instead of "test" in sub-shells
    +    tests: use "test_cmp" instead of "test" in sub-shells
     
         Convert a few cases where we were using "test" inside a sub-shell, and
         were losing the exit code of "git".
    @@ t/lib-httpd.sh: test_http_push_nonff () {
      		test_must_fail git push -v origin >output 2>&1 &&
     -		(cd "$REMOTE_REPO" &&
     -		 test $HEAD = $(git rev-parse --verify HEAD))
    -+		test_cmp_cmd "$HEAD" git -C "$REMOTE_REPO" rev-parse --verify HEAD
    ++		echo "$HEAD" >expect &&
    ++		git -C "$REMOTE_REPO" rev-parse --verify HEAD >actual &&
    ++		test_cmp expect actual
      	'
      
      	test_expect_success 'non-fast-forward push show ref status' '
    @@ t/lib-submodule-update.sh: replace_gitfile_with_git_dir () {
     -		git config --unset core.worktree
     -	) &&
     +	# does core.worktree point at the right place?
    -+	test_cmp_cmd "../../../$1" git -C ".git/modules/$1" config core.worktree
    ++	echo "../../../$1" >expect &&
    ++	git -C ".git/modules/$1" config core.worktree >actual &&
    ++	test_cmp expect actual &&
     +	# remove it temporarily before comparing, as
     +	# "$1/.git/config" lacks it...
     +	git -C ".git/modules/$1" config --unset core.worktree &&
    @@ t/lib-submodule-update.sh: replace_gitfile_with_git_dir () {
      
      test_git_directory_exists () {
     
    + ## t/t0060-path-utils.sh ##
    +@@ t/t0060-path-utils.sh: test_expect_success 'prefix_path rejects absolute path to dir with same beginnin
    + test_expect_success SYMLINKS 'prefix_path works with absolute path to a symlink to work tree having  same beginning as work tree' '
    + 	git init repo &&
    + 	ln -s repo repolink &&
    +-	test "a" = "$(cd repo && test-tool path-utils prefix_path prefix "$(pwd)/../repolink/a")"
    ++	echo "a" >expect &&
    ++	test-tool -C repo path-utils prefix_path prefix "$(cd repo && pwd)/../repolink/a" >actual &&
    ++	test_cmp expect actual
    + '
    + 
    + relative_path /foo/a/b/c/	/foo/a/b/	c/
    +
      ## t/t3200-branch.sh ##
     @@ t/t3200-branch.sh: test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
      test_expect_success 'git branch -M baz bam should succeed within a worktree in which baz is checked out' '
    @@ t/t3200-branch.sh: test_expect_success 'git branch -M baz bam should succeed whe
     -	) &&
     -	test $(git rev-parse --abbrev-ref HEAD) = bam &&
     +	git -C "$bazdir" branch -M baz bam &&
    -+	test_cmp_cmd "bam" git -C "$bazdir" rev-parse --abbrev-ref HEAD &&
    -+	test_cmp_cmd "bam" git rev-parse --abbrev-ref HEAD &&
    ++	echo "bam" >expect &&
    ++	git -C "$bazdir" rev-parse --abbrev-ref HEAD >actual &&
    ++	test_cmp expect actual &&
    ++	echo "bam" >expect &&
    ++	git rev-parse --abbrev-ref HEAD >actual &&
    ++	test_cmp expect actual &&
      	rm -r bazdir &&
      	git worktree prune
      '
    @@ t/t5605-clone-local.sh: test_expect_success 'preparing origin repository' '
      	git clone --bare . x &&
     -	test "$(cd a.git && git config --bool core.bare)" = true &&
     -	test "$(cd x && git config --bool core.bare)" = true &&
    -+	test_cmp_cmd true git -C a.git config --bool core.bare &&
    -+	test_cmp_cmd true git -C x config --bool core.bare &&
    ++	echo true >expect &&
    ++	git -C a.git config --bool core.bare >actual &&
    ++	test_cmp expect actual &&
    ++	echo true >expect &&
    ++	git -C x config --bool core.bare >actual &&
    ++	test_cmp expect actual &&
      	git bundle create b1.bundle --all &&
      	git bundle create b2.bundle main &&
      	mkdir dir &&
    @@ t/t5605-clone-local.sh: test_expect_success 'preparing origin repository' '
     -	(cd b &&
     -	test "$(git config --bool core.bare)" = false &&
     -	git fetch)
    -+	test_cmp_cmd false git -C b config --bool core.bare &&
    ++	echo false >expect &&
    ++	git -C b config --bool core.bare >actual &&
    ++	test_cmp expect actual &&
     +	git -C b fetch
      '
      
    @@ t/t7402-submodule-rebase.sh: test_expect_success 'stash with a dirty submodule'
      	test new != $(cat file) &&
     -	test submodule = $(git diff --name-only) &&
     -	test $CURRENT = $(cd submodule && git rev-parse HEAD) &&
    -+	test_cmp_cmd submodule git diff --name-only &&
    -+	test_cmp_cmd "$CURRENT" git -C submodule rev-parse HEAD &&
    ++	echo submodule >expect &&
    ++	git diff --name-only >actual &&
    ++	test_cmp expect actual &&
    ++
    ++	echo "$CURRENT" >expect &&
    ++	git -C submodule rev-parse HEAD >actual &&
    ++	test_cmp expect actual &&
    ++
      	git stash apply &&
      	test new = $(cat file) &&
     -	test $CURRENT = $(cd submodule && git rev-parse HEAD)
    -+	test_cmp_cmd "$CURRENT" git -C submodule rev-parse HEAD
    ++	echo "$CURRENT" >expect &&
    ++	git -C submodule rev-parse HEAD >actual &&
    ++	test_cmp expect actual
      
      '
      
4:  c36060934a6 ! 6:  51f32b42ce6 test-lib-functions: add and use test_cmp_cmd
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    test-lib-functions: add and use test_cmp_cmd
    +    tests: don't lose 'test <str> = $(cmd ...)"' exit code
     
    -    Add a "test_cmp_cmd" helper for the common pattern discussed in the
    -    documentation being added here to "t/test-lib-functions.sh".
    +    Convert some cases in the test suite where we'd lose the exit code of
    +    a command being interpolated as one of the arguments to the "test"
    +    builtin function to use &&-chaining and "test_cmp" instead.
     
    -    This implementation leaves the door open for extending this helper
    -    past its obvious limitations, such as:
    +    This way we won't lose the exit code, and the failure output will be
    +    more helpful.
     
    -            test_cmp_cmd "some" "lines" -- <some-cmd>
    -            test_cmp_cmd --stdin <some-cmd> <expect
    -            test_cmp_cmd --ignore-stderr "output" <some-cmd>
    -
    -    By using this in we'll catch cases where "git" or "test-tool"
    -    errors (such as segfaults or abort()) were previously hidden, and we'd
    -    either pass the test, or fail in some subsequent assertion.
    +    In the case of "t0060-path-utils.sh" and
    +    "t2005-checkout-index-symlinks.sh" convert the relevant code to using
    +    the modern style of indentation and newline wrapping while having to
    +    change it.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/lib-submodule-update.sh: test_git_directory_exists () {
      	then
      		# does core.worktree point at the right place?
     -		test "$(git -C .git/modules/$1 config core.worktree)" = "../../../$1"
    -+		test_cmp_cmd "../../../$1" git -C ".git/modules/$1" config core.worktree
    ++		echo "../../../$1" >expect &&
    ++		git -C ".git/modules/$1" config core.worktree >actual &&
    ++		test_cmp expect actual
      	fi
      }
      
    @@ t/t0001-init.sh: test_expect_success 'invalid default branch name' '
      	git init rename-initial &&
      	git -C rename-initial branch -m renamed &&
     -	test renamed = $(git -C rename-initial symbolic-ref --short HEAD) &&
    -+	test_cmp_cmd renamed git -C rename-initial symbolic-ref --short HEAD &&
    ++	echo renamed >expect &&
    ++	git -C rename-initial symbolic-ref --short HEAD >actual &&
    ++	test_cmp expect actual &&
    ++
      	git -C rename-initial branch -m renamed again &&
     -	test again = $(git -C rename-initial symbolic-ref --short HEAD)
    -+	test_cmp_cmd again git -C rename-initial symbolic-ref --short HEAD
    ++	echo again >expect &&
    ++	git -C rename-initial symbolic-ref --short HEAD >actual &&
    ++	test_cmp expect actual
      '
      
      test_done
    @@ t/t0002-gitfile.sh: test_expect_success 'bad setup: invalid .git file path' '
      test_expect_success 'final setup + check rev-parse --git-dir' '
      	echo "gitdir: $REAL" >.git &&
     -	test "$REAL" = "$(git rev-parse --git-dir)"
    -+	test_cmp_cmd "$REAL" git rev-parse --git-dir
    ++	echo "$REAL" >expect &&
    ++	git rev-parse --git-dir >actual &&
    ++	test_cmp expect actual
      '
      
      test_expect_success 'check hash-object' '
    @@ t/t0060-path-utils.sh: TEST_PASSES_SANITIZE_LEAK=true
     -	test_expect_success $3 "normalize path: $1 => $2" \
     -	"test \"\$(test-tool path-utils normalize_path_copy '$1')\" = '$expected'"
     +	test_expect_success $3 "normalize path: $1 => $2" "
    -+		test_cmp_cmd '$expected' test-tool path-utils normalize_path_copy '$1'
    ++		echo '$expected' >expect &&
    ++		test-tool path-utils normalize_path_copy '$1' >actual &&
    ++		test_cmp expect actual
     +	"
      }
      
    @@ t/t0060-path-utils.sh: TEST_PASSES_SANITIZE_LEAK=true
     -	test_expect_success $4 "relative path: $1 $2 => $3" \
     -	"test \"\$(test-tool path-utils relative_path '$1' '$2')\" = '$expected'"
     +	test_expect_success $4 "relative path: $1 $2 => $3" "
    -+		test_cmp_cmd '$expected' test-tool path-utils relative_path '$1' '$2'
    ++		echo '$expected' >expect &&
    ++		test-tool path-utils relative_path '$1' '$2' >actual &&
    ++		test_cmp expect actual
     +	"
      }
      
    @@ t/t0060-path-utils.sh: TEST_PASSES_SANITIZE_LEAK=true
      	test_expect_success "test_submodule_relative_url: $1 $2 $3 => $4" "
     -		actual=\$(test-tool submodule resolve-relative-url '$1' '$2' '$3') &&
     -		test \"\$actual\" = '$4'
    -+		test_cmp_cmd '$4' test-tool submodule resolve-relative-url '$1' '$2' '$3'
    ++		echo '$4' >expect &&
    ++		test-tool submodule resolve-relative-url '$1' '$2' '$3' >actual &&
    ++		test_cmp expect actual
      	"
      }
      
    @@ t/t0060-path-utils.sh: ancestor() {
     -	"actual=\$(test-tool path-utils longest_ancestor_length '$1' '$2') &&
     -	 test \"\$actual\" = '$expected'"
     +	test_expect_success $4 "longest ancestor: $1 $2 => $expected" "
    -+		test_cmp_cmd '$expected' test-tool path-utils longest_ancestor_length '$1' '$2'
    ++		echo '$expected' >expect &&
    ++		test-tool path-utils longest_ancestor_length '$1' '$2' >actual &&
    ++		test_cmp expect actual
     +	"
      }
      
    @@ t/t0060-path-utils.sh: ancestor D:/Users/me C:/ -1 MINGW
      
      test_expect_success 'absolute path rejects the empty string' '
     @@ t/t0060-path-utils.sh: test_expect_success 'real path rejects the empty string' '
    + '
      
      test_expect_success POSIX 'real path works on absolute paths 1' '
    ++	echo / >expect &&
    ++	test-tool path-utils real_path "/" >actual &&
    ++	test_cmp expect actual &&
    ++
      	nopath="hopefully-absent-path" &&
     -	test "/" = "$(test-tool path-utils real_path "/")" &&
     -	test "/$nopath" = "$(test-tool path-utils real_path "/$nopath")"
    -+	test_cmp_cmd / test-tool path-utils real_path "/" &&
    -+	test_cmp_cmd "/$nopath" test-tool path-utils real_path "/$nopath"
    ++	echo "/$nopath" >expect &&
    ++	test-tool path-utils real_path "/$nopath" >actual &&
    ++	test_cmp expect actual
      '
      
      test_expect_success 'real path works on absolute paths 2' '
    - 	nopath="hopefully-absent-path" &&
    +-	nopath="hopefully-absent-path" &&
      	# Find an existing top-level directory for the remaining tests:
      	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
     -	test "$d" = "$(test-tool path-utils real_path "$d")" &&
     -	test "$d/$nopath" = "$(test-tool path-utils real_path "$d/$nopath")"
    -+	test_cmp_cmd "$d" test-tool path-utils real_path "$d" &&
    -+	test_cmp_cmd "$d/$nopath" test-tool path-utils real_path "$d/$nopath"
    ++	echo "$d" >expect &&
    ++	test-tool path-utils real_path "$d" >actual &&
    ++	test_cmp expect actual &&
    ++
    ++	nopath="hopefully-absent-path" &&
    ++	echo "$d/$nopath" >expect &&
    ++	test-tool path-utils real_path "$d/$nopath" >actual &&
    ++	test_cmp expect actual
      '
      
      test_expect_success POSIX 'real path removes extra leading slashes' '
    ++	echo "/" >expect &&
    ++	test-tool path-utils real_path "///" >actual &&
    ++	test_cmp expect actual &&
    ++
      	nopath="hopefully-absent-path" &&
     -	test "/" = "$(test-tool path-utils real_path "///")" &&
     -	test "/$nopath" = "$(test-tool path-utils real_path "///$nopath")" &&
    -+	test_cmp_cmd "/" test-tool path-utils real_path "///" &&
    -+	test_cmp_cmd "/$nopath" test-tool path-utils real_path "///$nopath" &&
    ++	echo "/$nopath" >expect &&
    ++	test-tool path-utils real_path "///$nopath" >actual &&
    ++	test_cmp expect actual &&
    ++
      	# Find an existing top-level directory for the remaining tests:
      	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
     -	test "$d" = "$(test-tool path-utils real_path "//$d")" &&
     -	test "$d/$nopath" = "$(test-tool path-utils real_path "//$d/$nopath")"
    -+	test_cmp_cmd "$d" test-tool path-utils real_path "//$d" &&
    -+	test_cmp_cmd "$d/$nopath" test-tool path-utils real_path "//$d/$nopath"
    ++	echo "$d" >expect &&
    ++	test-tool path-utils real_path "//$d" >actual &&
    ++	test_cmp expect actual &&
    ++
    ++	echo "$d/$nopath" >expect &&
    ++	test-tool path-utils real_path "//$d/$nopath" >actual &&
    ++	test_cmp expect actual
      '
      
      test_expect_success 'real path removes other extra slashes' '
    - 	nopath="hopefully-absent-path" &&
    +-	nopath="hopefully-absent-path" &&
      	# Find an existing top-level directory for the remaining tests:
      	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
     -	test "$d" = "$(test-tool path-utils real_path "$d///")" &&
     -	test "$d/$nopath" = "$(test-tool path-utils real_path "$d///$nopath")"
    -+	test_cmp_cmd "$d" test-tool path-utils real_path "$d///" &&
    -+	test_cmp_cmd "$d/$nopath" test-tool path-utils real_path "$d///$nopath"
    ++	echo "$d" >expect &&
    ++	test-tool path-utils real_path "$d///" >actual &&
    ++	test_cmp expect actual &&
    ++
    ++	nopath="hopefully-absent-path" &&
    ++	echo "$d/$nopath" >expect &&
    ++	test-tool path-utils real_path "$d///$nopath" >actual &&
    ++	test_cmp expect actual
      '
      
      test_expect_success SYMLINKS 'real path works on symlinks' '
    @@ t/t0060-path-utils.sh: test_expect_success SYMLINKS 'real path works on symlinks
      	dir="$(cd .git && pwd -P)" &&
      	dir2=third/../second/other/.git &&
     -	test "$dir" = "$(test-tool path-utils real_path $dir2)" &&
    -+	test_cmp_cmd "$dir" test-tool path-utils real_path $dir2 &&
    ++	echo "$dir" >expect &&
    ++	test-tool path-utils real_path $dir2 >actual &&
    ++	test_cmp expect actual &&
      	file="$dir"/index &&
     -	test "$file" = "$(test-tool path-utils real_path $dir2/index)" &&
    -+	test_cmp_cmd "$file" test-tool path-utils real_path $dir2/index &&
    ++	echo "$file" >expect &&
    ++	test-tool path-utils real_path $dir2/index >actual &&
    ++	test_cmp expect actual &&
      	basename=blub &&
     -	test "$dir/$basename" = "$(cd .git && test-tool path-utils real_path "$basename")" &&
    -+	test_cmp_cmd "$dir/$basename" test-tool -C .git path-utils real_path "$basename" &&
    ++	echo "$dir/$basename" >expect &&
    ++	test-tool -C .git path-utils real_path "$basename" >actual &&
    ++	test_cmp expect actual &&
      	ln -s ../first/file .git/syml &&
      	sym="$(cd first && pwd -P)"/file &&
     -	test "$sym" = "$(test-tool path-utils real_path "$dir2/syml")"
    -+	test_cmp_cmd "$sym" test-tool path-utils real_path "$dir2/syml"
    ++	echo "$sym" >expect &&
    ++	test-tool path-utils real_path "$dir2/syml" >actual &&
    ++	test_cmp expect actual
      '
      
      test_expect_success SYMLINKS 'prefix_path works with absolute paths to work tree symlinks' '
      	ln -s target symlink &&
     -	test "$(test-tool path-utils prefix_path prefix "$(pwd)/symlink")" = "symlink"
    -+	test_cmp_cmd "symlink" test-tool path-utils prefix_path prefix "$(pwd)/symlink"
    ++	echo "symlink" >expect &&
    ++	test-tool path-utils prefix_path prefix "$(pwd)/symlink" >actual &&
    ++	test_cmp expect actual
      '
      
      test_expect_success 'prefix_path works with only absolute path to work tree' '
    -@@ t/t0060-path-utils.sh: test_expect_success 'prefix_path rejects absolute path to dir with same beginnin
    - test_expect_success SYMLINKS 'prefix_path works with absolute path to a symlink to work tree having  same beginning as work tree' '
    - 	git init repo &&
    - 	ln -s repo repolink &&
    --	test "a" = "$(cd repo && test-tool path-utils prefix_path prefix "$(pwd)/../repolink/a")"
    -+	test_cmp_cmd "a" test-tool -C repo path-utils prefix_path prefix "$(cd repo && pwd)/../repolink/a"
    - '
    - 
    - relative_path /foo/a/b/c/	/foo/a/b/	c/
     
      ## t/t0100-previous.sh ##
     @@ t/t0100-previous.sh: test_expect_success 'branch -d @{-1}' '
    @@ t/t0100-previous.sh: test_expect_success 'branch -d @{-1}' '
      	git checkout -b junk &&
      	git checkout - &&
     -	test "$(git symbolic-ref HEAD)" = refs/heads/main &&
    -+	test_cmp_cmd refs/heads/main git symbolic-ref HEAD &&
    ++	echo refs/heads/main >expect &&
    ++	git symbolic-ref HEAD >actual &&
    ++	test_cmp expect actual &&
      	git branch -d @{-1} &&
      	test_must_fail git rev-parse --verify refs/heads/junk
      '
    @@ t/t0100-previous.sh: test_expect_success 'branch -d @{-12} when there is not eno
      	git checkout -b junk2 &&
      	git checkout - &&
     -	test "$(git symbolic-ref HEAD)" = refs/heads/main &&
    -+	test_cmp_cmd refs/heads/main git symbolic-ref HEAD &&
    ++	echo refs/heads/main >expect &&
    ++	git symbolic-ref HEAD >actual &&
    ++	test_cmp expect actual &&
      	test_must_fail git branch -d @{-12} &&
      	git rev-parse --verify refs/heads/main
      '
    @@ t/t1504-ceiling-dirs.sh: TEST_PASSES_SANITIZE_LEAK=true
     -	"test '$2' = \"\$(git rev-parse --show-prefix)\""
     +	local expect="$2" &&
     +	test_expect_success "$1: git rev-parse --show-prefix is '$2'" '
    -+		test_cmp_cmd "$expect" git rev-parse --show-prefix
    ++		echo "$expect" >expect &&
    ++		git rev-parse --show-prefix >actual &&
    ++		test_cmp expect actual
     +	'
      }
      
      test_fail() {
     
    - ## t/test-lib-functions.sh ##
    -@@ t/test-lib-functions.sh: test_cmp_rev () {
    - 	fi
    - }
    + ## t/t2005-checkout-index-symlinks.sh ##
    +@@ t/t2005-checkout-index-symlinks.sh: test_expect_success \
    + git checkout-index symlink &&
    + test -f symlink'
      
    -+# test_cmp_cmd is a convenience helper for doing the more verbose:
    -+#
    -+#	echo something >expect &&
    -+#	<some-command-and-args> >actual &&
    -+#	test_cmp expect actual
    -+#
    -+# As:
    -+#
    -+#	test_cmp_cmd something <some-command-and-args>
    -+test_cmp_cmd () {
    -+	local expect="$1" &&
    -+	shift &&
    -+	printf "%s\n" "$expect" >expect &&
    -+	"$@" >actual 2>err &&
    -+	test_must_be_empty err
    +-test_expect_success \
    +-'the file must be the blob we added during the setup' '
    +-test "$(git hash-object -t blob symlink)" = $l'
    ++test_expect_success 'the file must be the blob we added during the setup' '
    ++	echo "$l" >expect &&
    ++	git hash-object -t blob symlink >actual &&
     +	test_cmp expect actual
    -+}
    -+
    - # Compare paths respecting core.ignoreCase
    - test_cmp_fspath () {
    - 	if test "x$1" = "x$2"
    ++'
    + 
    + test_done
    +
    + ## t/t5522-pull-symlink.sh ##
    +@@ t/t5522-pull-symlink.sh: test_expect_success SYMLINKS 'pushing from symlinked subdir' '
    + 		git commit -m push ./file &&
    + 		git push
    + 	) &&
    +-	test push = $(git show HEAD:subdir/file)
    ++	echo push >expect &&
    ++	git show HEAD:subdir/file >actual &&
    ++	test_cmp expect actual
    + '
    + 
    + test_done
    +
    + ## t/t7402-submodule-rebase.sh ##
    +@@ t/t7402-submodule-rebase.sh: chmod a+x fake-editor.sh
    + 
    + test_expect_success 'interactive rebase with a dirty submodule' '
    + 
    +-	test submodule = $(git diff --name-only) &&
    ++	echo submodule >expect &&
    ++	git diff --name-only >actual &&
    ++	test_cmp expect actual &&
    + 	HEAD=$(git rev-parse HEAD) &&
    + 	GIT_EDITOR="\"$(pwd)/fake-editor.sh\"" EDITOR_TEXT="pick $HEAD" \
    + 		git rebase -i HEAD^ &&
    +-	test submodule = $(git diff --name-only)
    +-
    ++	echo submodule >expect &&
    ++	git diff --name-only >actual &&
    ++	test_cmp expect actual
    + '
    + 
    + test_expect_success 'rebase with dirty file and submodule fails' '
    +
    + ## t/t7504-commit-msg-hook.sh ##
    +@@ t/t7504-commit-msg-hook.sh: test_expect_success 'setup: commit-msg hook that always fails' '
    + '
    + 
    + commit_msg_is () {
    +-	test "$(git log --pretty=format:%s%b -1)" = "$1"
    ++	printf "%s" "$1" >expect &&
    ++	git log --pretty=format:%s%b -1 >actual &&
    ++	test_cmp expect actual
    + }
    + 
    + test_expect_success 'with failing hook' '
    +
    + ## t/t7810-grep.sh ##
    +@@ t/t7810-grep.sh: test_expect_success 'log --committer does not search in timestamp' '
    + test_expect_success 'grep with CE_VALID file' '
    + 	git update-index --assume-unchanged t/t &&
    + 	rm t/t &&
    +-	test "$(git grep test)" = "t/t:test" &&
    ++	echo "t/t:test" >expect &&
    ++	git grep test >actual &&
    ++	test_cmp expect actual &&
    + 	git update-index --no-assume-unchanged t/t &&
    + 	git checkout t/t
    + '
-:  ----------- > 7:  307f25db831 tests: don't lose "git" exit codes in "! ( git ... | grep )"
8:  979a7f003f8 ! 8:  37c75f4a097 tests: use "test_cmp_cmd" in misc tests
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    tests: use "test_cmp_cmd" in misc tests
    +    tests: don't lose mist "git" exit codes
     
    -    Change a few miscellaneous tests to use "test_cmp_cmd" to avoid losing
    -    the exit code of "git".
    +    Fix a few miscellaneous cases where:
     
    -    There's many offenders left that match patterns like:
    -
    -            /test .*\$\((test-tool|git)/
    -
    -    What these all have in common is that they were the rare odd cases out
    -    in test files that were otherwise consistently checking the exit code.
    +    - We lost the "git" exit code via "git ... | grep"
    +    - Likewise by having a $(git) argument to git itself
    +    - Used "test -z" to check that a command emitted no output, we can use
    +      "test_must_be_empty" and &&-chaining instead.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/t1401-symbolic-ref.sh: test_expect_success 'symbolic-ref refuses non-ref for H
      
      reset_to_sane
     
    - ## t/t2005-checkout-index-symlinks.sh ##
    -@@ t/t2005-checkout-index-symlinks.sh: test -f symlink'
    - 
    - test_expect_success \
    - 'the file must be the blob we added during the setup' '
    --test "$(git hash-object -t blob symlink)" = $l'
    -+test_cmp_cmd "$l" git hash-object -t blob symlink'
    - 
    - test_done
    -
      ## t/t3701-add-interactive.sh ##
     @@ t/t3701-add-interactive.sh: test_expect_success FILEMODE 'stage mode and hunk' '
      	echo content >>file &&
    @@ t/t3701-add-interactive.sh: test_expect_success FILEMODE 'stage mode and hunk' '
     -	git diff --cached file | grep "+content" &&
     -	test -z "$(git diff file)"
     +	git diff --cached file >out &&
    -+	grep "new mode" <out &&
    -+	git diff --cached file >out &&
    -+	grep "+content" <out &&
    ++	grep "new mode" out &&
    ++	grep "+content" out &&
     +	git diff file >out &&
     +	test_must_be_empty out
      '
      
      # end of tests disabled when filemode is not usable
     
    - ## t/t5522-pull-symlink.sh ##
    -@@ t/t5522-pull-symlink.sh: test_expect_success SYMLINKS 'pushing from symlinked subdir' '
    - 		git commit -m push ./file &&
    - 		git push
    - 	) &&
    --	test push = $(git show HEAD:subdir/file)
    -+	test_cmp_cmd push git show HEAD:subdir/file
    - '
    - 
    - test_done
    -
    - ## t/t7402-submodule-rebase.sh ##
    -@@ t/t7402-submodule-rebase.sh: chmod a+x fake-editor.sh
    - 
    - test_expect_success 'interactive rebase with a dirty submodule' '
    - 
    --	test submodule = $(git diff --name-only) &&
    -+	test_cmp_cmd submodule git diff --name-only &&
    - 	HEAD=$(git rev-parse HEAD) &&
    - 	GIT_EDITOR="\"$(pwd)/fake-editor.sh\"" EDITOR_TEXT="pick $HEAD" \
    - 		git rebase -i HEAD^ &&
    --	test submodule = $(git diff --name-only)
    -+	test_cmp_cmd submodule git diff --name-only
    - 
    - '
    - 
    -
    - ## t/t7504-commit-msg-hook.sh ##
    -@@ t/t7504-commit-msg-hook.sh: test_expect_success 'setup: commit-msg hook that always fails' '
    - '
    - 
    - commit_msg_is () {
    --	test "$(git log --pretty=format:%s%b -1)" = "$1"
    -+	test_cmp_cmd "$1" git log --pretty=tformat:%s%b -1
    - }
    - 
    - test_expect_success 'with failing hook' '
    -
      ## t/t7516-commit-races.sh ##
     @@ t/t7516-commit-races.sh: test_expect_success 'race to create orphan commit' '
      	test_must_fail env EDITOR=./hare-editor git commit --allow-empty -m tortoise -e &&
    @@ t/t7516-commit-races.sh: test_expect_success 'race to create orphan commit' '
      '
      
      test_expect_success 'race to create non-orphan commit' '
    -
    - ## t/t7810-grep.sh ##
    -@@ t/t7810-grep.sh: test_expect_success 'log --committer does not search in timestamp' '
    - test_expect_success 'grep with CE_VALID file' '
    - 	git update-index --assume-unchanged t/t &&
    - 	rm t/t &&
    --	test "$(git grep test)" = "t/t:test" &&
    -+	test_cmp_cmd "t/t:test" git grep test &&
    - 	git update-index --no-assume-unchanged t/t &&
    - 	git checkout t/t
    - '
-- 
2.39.0.rc1.981.gf846af54b4b

