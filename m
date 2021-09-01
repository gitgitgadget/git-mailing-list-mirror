Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEA2C4320A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CC56101B
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbhIAL6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 07:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242892AbhIAL6P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 07:58:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F571C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 04:57:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g18so4044494wrc.11
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 04:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I9Sl2fDi0xUCk96Ri6HSue2ERIEfgI1gF8FFjbo2Bxw=;
        b=I/x4C6oGDgk/wjdpEit3LDqyUbk+TT7XFDPFemMZ7he7l/bKUtCb8OPr3Eb83BqYOD
         buua1W5JTPYWs2EdiO//EajOQXIyyOUDQIcyyuvvsfRtukVqKvFCnFsk65ajaiJ2mecj
         zsNPalemf7VCsGXOd07NnAVt21gJyQdw9+GsPbFMhg+hQh6uska07wlaH37oVXQG1iYJ
         1vO3bGNREeMhVQtxIrpE1AzyyhTPvlXTTtYLK6f+03YSRTMDF/XDzAf6dj8rjVntInKW
         3RAfNHsVlaWnCwKvD7bBci05LWLJlqvl1a2StFt4s8nDoj0pNCaSS90Lt3tZfiwASscI
         27uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I9Sl2fDi0xUCk96Ri6HSue2ERIEfgI1gF8FFjbo2Bxw=;
        b=un4AUZXPlNEF/+fTjaECXfoO4+j2FUvIhX2IsDgwCnRQt+z6Yf1APl+WGdmw9xduFH
         /msawV5vYBgetXDa0Z+SuXR07WXuQFzB3aFEyf3ErGMR6RFIjmi83aaBVutn8v4vCcw7
         oEiSfxDjNJAhXsPSXJPGEYVSgCi2YzZCqTvREFXD+TKM3EyrqkDRvLTg+jqPstZ3EvA7
         0X/Pzh748RZsvrSBRMnwSfnHkgaaH4mUltnCjXnGBrcFfxP8s/rrm25ljZ5Sk/txGZMk
         /JmNSODqmjr+2+XE4qqaKXVoNq9vkBkj//w6BiNjNdDW8cZwaWrl5V4hpDtntHuU1qF4
         k4TQ==
X-Gm-Message-State: AOAM532kBytGQy0V27w2gu3guziIWrds0TZJni3Br3JH9fMj7rI4ZNV7
        99ak8Yfo0svm265/wjtpjGDgY5Q0G70=
X-Google-Smtp-Source: ABdhPJy0tErTrgmtIWgNyJ6BQzqMCHt5NNe7pAWZsPneuIPiMho1ULXluyAZyutBLH1Fc2JqxyJYmg==
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr38141542wrp.189.1630497436808;
        Wed, 01 Sep 2021 04:57:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9sm5137862wrg.14.2021.09.01.04.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:57:16 -0700 (PDT)
Message-Id: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.git.1574542242.gitgitgadget@gmail.com>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Sep 2021 11:57:07 +0000
Subject: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 427c3bd28ab (rebase: deprecate --preserve-merges, 2019-03-11) (which was
included in v2.22.0), we officially deprecated the --preserve-merges
backend. Over two years later, it is time to drop that backend, and here is
a patch series that does just that.

Changes since v1:

 * Rebased onto v2.33.0

Johannes Schindelin (7):
  t5520: do not use `pull.rebase=preserve`
  remote: warn about unhandled branch.<name>.rebase values
  tests: stop testing `git rebase --preserve-merges`
  pull: remove support for `--rebase=preserve`
  rebase: drop support for `--preserve-merges`
  git-svn: drop support for `--preserve-merges`
  rebase: drop the internal `rebase--interactive` command

 .github/workflows/main.yml                |    1 -
 .gitignore                                |    1 -
 Documentation/config/branch.txt           |    4 -
 Documentation/config/pull.txt             |    4 -
 Documentation/git-pull.txt                |    6 +-
 Documentation/git-rebase.txt              |   51 -
 Documentation/git-svn.txt                 |    1 -
 Makefile                                  |    2 -
 builtin/pull.c                            |    9 +-
 builtin/rebase.c                          |  318 +------
 builtin/remote.c                          |    3 +
 contrib/completion/git-completion.bash    |    2 +-
 git-rebase--preserve-merges.sh            | 1057 ---------------------
 git-svn.perl                              |    1 -
 git.c                                     |    1 -
 rebase.c                                  |    2 -
 rebase.h                                  |    1 -
 t/t3404-rebase-interactive.sh             |   76 --
 t/t3408-rebase-multi-line.sh              |   10 -
 t/t3409-rebase-preserve-merges.sh         |  130 ---
 t/t3410-rebase-preserve-dropped-merges.sh |   90 --
 t/t3411-rebase-preserve-around-merges.sh  |   80 --
 t/t3412-rebase-root.sh                    |   37 -
 t/t3414-rebase-preserve-onto.sh           |   85 --
 t/t3418-rebase-continue.sh                |   15 -
 t/t3421-rebase-topology-linear.sh         |   19 -
 t/t3422-rebase-incompatible-options.sh    |   11 -
 t/t3425-rebase-topology-merges.sh         |  151 ---
 t/t3427-rebase-subtree.sh                 |   19 -
 t/t5520-pull.sh                           |   24 +-
 t/t7505-prepare-commit-msg-hook.sh        |    1 -
 t/t7517-per-repo-email.sh                 |   13 -
 t/test-lib.sh                             |    4 -
 33 files changed, 17 insertions(+), 2212 deletions(-)
 delete mode 100644 git-rebase--preserve-merges.sh
 delete mode 100755 t/t3409-rebase-preserve-merges.sh
 delete mode 100755 t/t3410-rebase-preserve-dropped-merges.sh
 delete mode 100755 t/t3411-rebase-preserve-around-merges.sh
 delete mode 100755 t/t3414-rebase-preserve-onto.sh


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-195%2Fdscho%2Fdrop-rebase-p-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-195/dscho/drop-rebase-p-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/195

Range-diff vs v1:

 1:  662e16dbc12 ! 1:  8da29d539fc t5520: do not use `pull.rebase=preserve`
     @@ t/t5520-pull.sh: test_expect_success '--rebase=false create a new merge commit'
      -	test_config pull.rebase preserve &&
      +	test_config pull.rebase merges &&
       	git pull --rebase=true . copy &&
     - 	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
     - 	test file3 = "$(git show HEAD:file3.t)"
     + 	test_cmp_rev HEAD^^ copy &&
     + 	echo file3 >expect &&
      @@ t/t5520-pull.sh: test_expect_success '--rebase=invalid fails' '
     - 	! git pull --rebase=invalid . copy
     + 	test_must_fail git pull --rebase=invalid . copy
       '
       
      -test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
     @@ t/t5520-pull.sh: test_expect_success '--rebase=invalid fails' '
      -	test_config pull.rebase preserve &&
      +	test_config pull.rebase merges &&
       	git pull --rebase . copy &&
     - 	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
     - 	test file3 = "$(git show HEAD:file3.t)"
     + 	test_cmp_rev HEAD^^ copy &&
     + 	echo file3 >expect &&
 2:  fb531064b35 < -:  ----------- remote: warn about unhandled branch.<name>.rebase values
 -:  ----------- > 2:  acda0f59947 remote: warn about unhandled branch.<name>.rebase values
 3:  b614336f3df ! 3:  cdb9fae4b93 tests: stop testing `git rebase --preserve-merges`
     @@ Commit message
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     - ## azure-pipelines.yml ##
     -@@ azure-pipelines.yml: jobs:
     -       HOME: $(Build.SourcesDirectory)
     -       MSYSTEM: MINGW64
     -       NO_SVN_TESTS: 1
     --      GIT_TEST_SKIP_REBASE_P: 1
     -   - powershell: |
     -       if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
     -         cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
     -@@ azure-pipelines.yml: jobs:
     -       HOME: $(Build.SourcesDirectory)
     -       MSYSTEM: MINGW64
     -       NO_SVN_TESTS: 1
     --      GIT_TEST_SKIP_REBASE_P: 1
     -   - powershell: |
     -       if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
     -         cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
     + ## .github/workflows/main.yml ##
     +@@ .github/workflows/main.yml: jobs:
     +       shell: bash
     +       env:
     +         NO_SVN_TESTS: 1
     +-        GIT_TEST_SKIP_REBASE_P: 1
     +       run: ci/run-test-slice.sh ${{matrix.nr}} 10
     +     - name: ci/print-test-failures.sh
     +       if: failure()
      
       ## t/t3404-rebase-interactive.sh ##
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'retain authorship when squashing' '
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'retain authorship when squas
      -'
      -
      -test_expect_success REBASE_P 'preserve merges with -p' '
     --	git checkout -b to-be-preserved master^ &&
     +-	git checkout -b to-be-preserved primary^ &&
      -	: > unrelated-file &&
      -	git add unrelated-file &&
      -	test_tick &&
      -	git commit -m "unrelated" &&
     --	git checkout -b another-branch master &&
     +-	git checkout -b another-branch primary &&
      -	echo B > file1 &&
      -	test_tick &&
      -	git commit -m J file1 &&
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'retain authorship when squas
      -	git commit -m M file1 &&
      -	git checkout -b to-be-rebased &&
      -	test_tick &&
     --	git rebase -i -p --onto branch1 master &&
     +-	git rebase -i -p --onto branch1 primary &&
      -	git update-index --refresh &&
      -	git diff-files --quiet &&
      -	git diff-index --quiet --cached HEAD -- &&
     --	test $(git rev-parse HEAD~6) = $(git rev-parse branch1) &&
     --	test $(git rev-parse HEAD~4^2) = $(git rev-parse to-be-preserved) &&
     --	test $(git rev-parse HEAD^^2^) = $(git rev-parse HEAD^^^) &&
     +-	test_cmp_rev HEAD~6 branch1 &&
     +-	test_cmp_rev HEAD~4^2 to-be-preserved &&
     +-	test_cmp_rev HEAD^^2^ HEAD^^^ &&
      -	test $(git show HEAD~5:file1) = B &&
      -	test $(git show HEAD~3:file1) = C &&
      -	test $(git show HEAD:file1) = E &&
     @@ t/t3409-rebase-preserve-merges.sh (deleted)
      -
      -Run "git rebase -p" and check that merges are properly carried along
      -'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     +-export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     +-
      -. ./test-lib.sh
      -
      -if ! test_have_prereq REBASE_P; then
     @@ t/t3409-rebase-preserve-merges.sh (deleted)
      -
      -# Clone 2 (conflicting merge):
      -#
     --# A1--A2--B3   <-- origin/master
     +-# A1--A2--B3   <-- origin/main
      -#  \       \
      -#   B1------M  <-- topic
      -#    \
     @@ t/t3409-rebase-preserve-merges.sh (deleted)
      -#
      -# Clone 3 (no-ff merge):
      -#
     --# A1--A2--B3   <-- origin/master
     +-# A1--A2--B3   <-- origin/main
      -#  \
      -#   B1------M  <-- topic
      -#    \     /
     @@ t/t3409-rebase-preserve-merges.sh (deleted)
      -	echo Second > B &&
      -	git add B &&
      -	git commit -m "Add B1" &&
     --	git checkout -f master &&
     +-	git checkout -f main &&
      -	echo Third >> A &&
      -	git commit -a -m "Modify A2" &&
      -	echo Fifth > B &&
     @@ t/t3409-rebase-preserve-merges.sh (deleted)
      -	(
      -		cd clone2 &&
      -		git checkout -b topic origin/topic &&
     --		test_must_fail git merge origin/master &&
     +-		test_must_fail git merge origin/main &&
      -		echo Resolved >B &&
      -		git add B &&
     --		git commit -m "Merge origin/master into topic"
     +-		git commit -m "Merge origin/main into topic"
      -	) &&
      -
      -	git clone ./. clone3 &&
     @@ t/t3412-rebase-root.sh: test_expect_success 'pre-rebase got correct input (4)' '
       
      -test_expect_success REBASE_P 'rebase -i -p with linear history' '
      -	git checkout -b work5 other &&
     --	git rebase -i -p --root --onto master &&
     +-	git rebase -i -p --root --onto main &&
      -	git log --pretty=tformat:"%s" > rebased5 &&
      -	test_cmp expect rebased5
      -'
     @@ t/t3412-rebase-root.sh: commit work6~4
       
      -test_expect_success REBASE_P 'rebase -i -p with merge' '
      -	git checkout -b work6 other &&
     --	git rebase -i -p --root --onto master &&
     +-	git rebase -i -p --root --onto main &&
      -	log_with_names work6 > rebased6 &&
      -	test_cmp expect-side rebased6
      -'
     @@ t/t3412-rebase-root.sh: commit work7~5
       
      -test_expect_success REBASE_P 'rebase -i -p with two roots' '
      -	git checkout -b work7 other &&
     --	git rebase -i -p --root --onto master &&
     +-	git rebase -i -p --root --onto main &&
      -	log_with_names work7 > rebased7 &&
      -	test_cmp expect-third rebased7
      -'
     @@ t/t3412-rebase-root.sh: commit conflict3~6
       
      -test_expect_success REBASE_P 'rebase -i -p --root with conflict (first part)' '
      -	git checkout -b conflict3 other &&
     --	test_must_fail git rebase -i -p --root --onto master &&
     +-	test_must_fail git rebase -i -p --root --onto main &&
      -	git ls-files -u | grep "B$"
      -'
      -
     @@ t/t3418-rebase-continue.sh: test_rerere_autoupdate
      
       ## t/t3421-rebase-topology-linear.sh ##
      @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
     - test_run_rebase success ''
     + test_run_rebase success --apply
       test_run_rebase success -m
       test_run_rebase success -i
      -test_have_prereq !REBASE_P || test_run_rebase success -p
     @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
       test_expect_success 'setup branches and remote tracking' '
       	git tag -l >tags &&
      @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
     - test_run_rebase success ''
     + test_run_rebase success --apply
       test_run_rebase success -m
       test_run_rebase success -i
      -test_have_prereq !REBASE_P || test_run_rebase success -p
       
       test_run_rebase () {
       	result=$1
     -@@ t/t3421-rebase-topology-linear.sh: test_run_rebase success ''
     +@@ t/t3421-rebase-topology-linear.sh: test_run_rebase success --apply
       test_run_rebase success --fork-point
       test_run_rebase success -m
       test_run_rebase success -i
     @@ t/t3421-rebase-topology-linear.sh: test_run_rebase success ''
       
       test_run_rebase () {
       	result=$1
     -@@ t/t3421-rebase-topology-linear.sh: test_run_rebase success ''
     +@@ t/t3421-rebase-topology-linear.sh: test_run_rebase success --apply
       test_run_rebase success --fork-point
       test_run_rebase success -m
       test_run_rebase success -i
     @@ t/t3421-rebase-topology-linear.sh: test_run_rebase success ''
       
       test_run_rebase () {
       	result=$1
     -@@ t/t3421-rebase-topology-linear.sh: test_run_rebase success ''
     +@@ t/t3421-rebase-topology-linear.sh: test_run_rebase success --apply
       test_run_rebase success --fork-point
       test_run_rebase success -m
       test_run_rebase success -i
     @@ t/t3421-rebase-topology-linear.sh: test_run_rebase success ''
       #       f
       #      /
      @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
     - test_run_rebase success ''
     + test_run_rebase success --apply
       test_run_rebase success -m
       test_run_rebase success -i
      -test_have_prereq !REBASE_P || test_run_rebase success -p
     @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
       test_run_rebase () {
       	result=$1
      @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
     - test_run_rebase success ''
     + test_run_rebase success --apply
       test_run_rebase success -m
       test_run_rebase success -i
      -test_have_prereq !REBASE_P || test_run_rebase success -p
     @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
       test_run_rebase () {
       	result=$1
      @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
     - test_run_rebase success ''
     + test_run_rebase success --apply
       test_run_rebase success -m
       test_run_rebase success -i
      -test_have_prereq !REBASE_P || test_run_rebase success -p
     @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
       test_run_rebase () {
       	result=$1
      @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
     - test_run_rebase success ''
     + test_run_rebase success --apply
       test_run_rebase success -m
       test_run_rebase success -i
      -test_have_prereq !REBASE_P || test_run_rebase success -p
     @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
       # a---b---c---j!
       #      \
      @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
     - test_run_rebase success ''
     + test_run_rebase failure --apply
       test_run_rebase success -m
       test_run_rebase success -i
     --test_have_prereq !REBASE_P || test_run_rebase success -p
     +-test_have_prereq !REBASE_P || test_run_rebase failure -p
       
       test_run_rebase () {
       	result=$1
      @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
     - test_run_rebase success ''
     + }
       test_run_rebase success -m
       test_run_rebase success -i
     --test_have_prereq !REBASE_P || test_run_rebase failure -p
     +-test_have_prereq !REBASE_P || test_run_rebase success -p
       
       test_run_rebase () {
       	result=$1
      @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
     - test_run_rebase success ''
     + }
       test_run_rebase success -m
       test_run_rebase success -i
     --test_have_prereq !REBASE_P || test_run_rebase failure -p
     +-test_have_prereq !REBASE_P || test_run_rebase success -p
       test_run_rebase success --rebase-merges
       
       #       m
      @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
     - test_run_rebase success ''
     + test_run_rebase success --apply
       test_run_rebase success -m
       test_run_rebase success -i
      -test_have_prereq !REBASE_P || test_run_rebase success -p
     @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
       test_run_rebase () {
       	result=$1
      @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
     - test_run_rebase success ''
     + test_run_rebase success --apply
       test_run_rebase success -m
       test_run_rebase success -i
      -test_have_prereq !REBASE_P || test_run_rebase failure -p
     @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
       test_run_rebase () {
       	result=$1
      @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
     - test_run_rebase success ''
     + test_run_rebase success --apply
       test_run_rebase success -m
       test_run_rebase success -i
      -test_have_prereq !REBASE_P || test_run_rebase success -p
     @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
       test_run_rebase () {
       	result=$1
      @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
     - test_run_rebase success ''
     + test_run_rebase success --apply
       test_run_rebase success -m
       test_run_rebase success -i
      -test_have_prereq !REBASE_P || test_run_rebase failure -p
     @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
       test_run_rebase () {
       	result=$1
      @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
     - test_run_rebase success ''
     + test_run_rebase success --apply
       test_run_rebase success -m
       test_run_rebase success -i
      -test_have_prereq !REBASE_P || test_run_rebase failure -p
     @@ t/t3421-rebase-topology-linear.sh: test_run_rebase () {
       test_done
      
       ## t/t3422-rebase-incompatible-options.sh ##
     -@@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only --ignore-whitespace
     - test_rebase_am_only --committer-date-is-author-date
     +@@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
     + test_rebase_am_only --whitespace=fix
       test_rebase_am_only -C4
       
      -test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
     @@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only --ignore-whitespace
       test_done
      
       ## t/t3425-rebase-topology-merges.sh ##
     -@@ t/t3425-rebase-topology-merges.sh: test_run_rebase success 'd n o e' ''
     +@@ t/t3425-rebase-topology-merges.sh: test_run_rebase success 'd n o e' --apply
       test_run_rebase success 'd n o e' -m
       test_run_rebase success 'd n o e' -i
       
     @@ t/t3427-rebase-subtree.sh: test_expect_success 'setup' '
       	git commit -m "Empty commit" --allow-empty
       '
       
     --# FAILURE: Does not preserve master4.
     +-# FAILURE: Does not preserve topic_4.
      -test_expect_failure REBASE_P 'Rebase -Xsubtree --preserve-merges --onto commit' '
      -	reset_rebase &&
      -	git checkout -b rebase-preserve-merges to-rebase &&
     --	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
     --	verbose test "$(commit_message HEAD~)" = "master4" &&
     --	verbose test "$(commit_message HEAD)" = "files_subtree/master5"
     +-	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-main main &&
     +-	verbose test "$(commit_message HEAD~)" = "topic_4" &&
     +-	verbose test "$(commit_message HEAD)" = "files_subtree/topic_5"
      -'
      -
     --# FAILURE: Does not preserve master4.
     +-# FAILURE: Does not preserve topic_4.
      -test_expect_failure REBASE_P 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit' '
      -	reset_rebase &&
      -	git checkout -b rebase-keep-empty to-rebase &&
     --	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
     --	verbose test "$(commit_message HEAD~2)" = "master4" &&
     --	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
     +-	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-main main &&
     +-	verbose test "$(commit_message HEAD~2)" = "topic_4" &&
     +-	verbose test "$(commit_message HEAD~)" = "files_subtree/topic_5" &&
      -	verbose test "$(commit_message HEAD)" = "Empty commit"
      -'
      -
     - test_expect_success 'Rebase -Xsubtree --keep-empty --onto commit' '
     + test_expect_success 'Rebase -Xsubtree --empty=ask --onto commit' '
       	reset_rebase &&
       	git checkout -b rebase-onto to-rebase &&
      
       ## t/t5520-pull.sh ##
      @@ t/t5520-pull.sh: test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
     - 	test file3 = "$(git show HEAD:file3.t)"
     + 	test_cmp expect actual
       '
       
      -test_expect_success REBASE_P \
     @@ t/t5520-pull.sh: test_expect_success 'pull.rebase=1 is treated as true and flatt
      -	git reset --hard before-preserve-rebase &&
      -	test_config pull.rebase preserve &&
      -	git pull . copy &&
     --	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
     --	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
     +-	test_cmp_rev HEAD^^ copy &&
     +-	test_cmp_rev HEAD^2 keep-merge
      -'
      -
       test_expect_success 'pull.rebase=interactive' '
       	write_script "$TRASH_DIRECTORY/fake-editor" <<-\EOF &&
       	echo I was here >fake.out &&
      @@ t/t5520-pull.sh: test_expect_success '--rebase=true rebases and flattens keep-merge' '
     - 	test file3 = "$(git show HEAD:file3.t)"
     + 	test_cmp expect actual
       '
       
      -test_expect_success REBASE_P \
     @@ t/t5520-pull.sh: test_expect_success '--rebase=true rebases and flattens keep-me
      -	git reset --hard before-preserve-rebase &&
      -	test_config pull.rebase true &&
      -	git pull --rebase=preserve . copy &&
     --	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
     --	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
     +-	test_cmp_rev HEAD^^ copy &&
     +-	test_cmp_rev HEAD^2 keep-merge
      -'
      -
       test_expect_success '--rebase=invalid fails' '
       	git reset --hard before-preserve-rebase &&
     - 	! git pull --rebase=invalid . copy
     + 	test_must_fail git pull --rebase=invalid . copy
      
       ## t/t7505-prepare-commit-msg-hook.sh ##
      @@ t/t7505-prepare-commit-msg-hook.sh: test_rebase () {
     @@ t/t7505-prepare-commit-msg-hook.sh: test_rebase () {
      -test_have_prereq !REBASE_P || test_rebase success -p
       
       test_expect_success 'with hook (cherry-pick)' '
     - 	test_when_finished "git checkout -f master" &&
     + 	test_when_finished "git checkout -f main" &&
      
       ## t/t7517-per-repo-email.sh ##
      @@ t/t7517-per-repo-email.sh: test_expect_success 'noop interactive rebase does not care about ident' '
     @@ t/t7517-per-repo-email.sh: test_expect_success 'noop interactive rebase does not
      -test_expect_success REBASE_P \
      -	'fast-forward rebase does not care about ident (preserve)' '
      -	git checkout -B tmp side-without-commit &&
     --	git rebase -p master
     +-	git rebase -p main
      -'
      -
      -test_expect_success REBASE_P \
      -	'non-fast-forward rebase refuses to write commits (preserve)' '
      -	test_when_finished "git rebase --abort || true" &&
      -	git checkout -B tmp side-with-commit &&
     --	test_must_fail git rebase -p master
     +-	test_must_fail git rebase -p main
      -'
      -
       test_expect_success 'author.name overrides user.name' '
     @@ t/t7517-per-repo-email.sh: test_expect_success 'noop interactive rebase does not
       	test_config user.email user@example.com &&
      
       ## t/test-lib.sh ##
     -@@ t/test-lib.sh: test_lazy_prereq CURL '
     - test_lazy_prereq SHA1 '
     - 	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
     +@@ t/test-lib.sh: test_lazy_prereq SHA1 '
     + 	esac
       '
     --
     + 
      -test_lazy_prereq REBASE_P '
      -	test -z "$GIT_TEST_SKIP_REBASE_P"
      -'
     +-
     + # Ensure that no test accidentally triggers a Git command
     + # that runs the actual maintenance scheduler, affecting a user's
     + # system permanently.
 4:  0c8bfe5d18d ! 4:  b493046134d pull: remove support for `--rebase=preserve`
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Documentation/config/branch.txt ##
     -@@ Documentation/config/branch.txt: When `merges`, pass the `--rebase-merges` option to 'git rebase'
     +@@ Documentation/config/branch.txt: When `merges` (or just 'm'), pass the `--rebase-merges` option to 'git rebase'
       so that the local merge commits are included in the rebase (see
       linkgit:git-rebase[1] for details).
       +
     --When `preserve` (deprecated in favor of `merges`), also pass
     +-When `preserve` (or just 'p', deprecated in favor of `merges`), also pass
      -`--preserve-merges` along to 'git rebase' so that locally committed merge
      -commits will not be flattened by running 'git pull'.
      -+
     - When the value is `interactive`, the rebase is run in interactive mode.
     + When the value is `interactive` (or just 'i'), the rebase is run in interactive
     + mode.
       +
     - *NOTE*: this is a possibly dangerous operation; do *not* use
      
       ## Documentation/config/pull.txt ##
     -@@ Documentation/config/pull.txt: When `merges`, pass the `--rebase-merges` option to 'git rebase'
     +@@ Documentation/config/pull.txt: When `merges` (or just 'm'), pass the `--rebase-merges` option to 'git rebase'
       so that the local merge commits are included in the rebase (see
       linkgit:git-rebase[1] for details).
       +
     --When `preserve` (deprecated in favor of `merges`), also pass
     +-When `preserve` (or just 'p', deprecated in favor of `merges`), also pass
      -`--preserve-merges` along to 'git rebase' so that locally committed merge
      -commits will not be flattened by running 'git pull'.
      -+
     - When the value is `interactive`, the rebase is run in interactive mode.
     + When the value is `interactive` (or just 'i'), the rebase is run in interactive
     + mode.
       +
     - *NOTE*: this is a possibly dangerous operation; do *not* use
      
       ## Documentation/git-pull.txt ##
      @@ Documentation/git-pull.txt: Options related to merging
     @@ Documentation/git-pull.txt: When set to `merges`, rebase using `git rebase --reb
      -`--preserve-merges` option passed to `git rebase` so that locally created
      -merge commits will not be flattened.
      -+
     - When false, merge the current branch into the upstream branch.
     + When false, merge the upstream branch into the current branch.
       +
       When `interactive`, enable the interactive mode of rebase.
      
       ## builtin/pull.c ##
     -@@ builtin/pull.c: enum rebase_type {
     - 	REBASE_INVALID = -1,
     - 	REBASE_FALSE = 0,
     - 	REBASE_TRUE,
     --	REBASE_PRESERVE,
     - 	REBASE_MERGES,
     - 	REBASE_INTERACTIVE
     - };
     -@@ builtin/pull.c: enum rebase_type {
     +@@
       /**
        * Parses the value of --rebase. If value is a false value, returns
        * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
     @@ builtin/pull.c: enum rebase_type {
        */
       static enum rebase_type parse_config_rebase(const char *key, const char *value,
       		int fatal)
     -@@ builtin/pull.c: static enum rebase_type parse_config_rebase(const char *key, const char *value,
     - 		return REBASE_FALSE;
     - 	else if (v > 0)
     - 		return REBASE_TRUE;
     --	else if (!strcmp(value, "preserve") || !strcmp(value, "p"))
     --		return REBASE_PRESERVE;
     - 	else if (!strcmp(value, "merges") || !strcmp(value, "m"))
     - 		return REBASE_MERGES;
     - 	else if (!strcmp(value, "interactive") || !strcmp(value, "i"))
      @@ builtin/pull.c: static struct option pull_options[] = {
       	/* Options passed to git-merge or git-rebase */
       	OPT_GROUP(N_("Options related to merging")),
     - 	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
     --	  "(false|true|merges|preserve|interactive)",
     -+	  "(false|true|merges|interactive)",
     - 	  N_("incorporate changes by rebasing rather than merging"),
     - 	  PARSE_OPT_OPTARG, parse_opt_rebase },
     + 	OPT_CALLBACK_F('r', "rebase", &opt_rebase,
     +-		"(false|true|merges|preserve|interactive)",
     ++		"(false|true|merges|interactive)",
     + 		N_("incorporate changes by rebasing rather than merging"),
     + 		PARSE_OPT_OPTARG, parse_opt_rebase),
       	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
     -@@ builtin/pull.c: static int run_rebase(const struct object_id *curr_head,
     +@@ builtin/pull.c: static int run_rebase(const struct object_id *newbase,
       	/* Options passed to git-rebase */
       	if (opt_rebase == REBASE_MERGES)
     - 		argv_array_push(&args, "--rebase-merges");
     + 		strvec_push(&args, "--rebase-merges");
      -	else if (opt_rebase == REBASE_PRESERVE)
     --		argv_array_push(&args, "--preserve-merges");
     +-		strvec_push(&args, "--preserve-merges");
       	else if (opt_rebase == REBASE_INTERACTIVE)
     - 		argv_array_push(&args, "--interactive");
     + 		strvec_push(&args, "--interactive");
       	if (opt_diffstat)
      
       ## contrib/completion/git-completion.bash ##
     @@ contrib/completion/git-completion.bash: __git_complete_config_variable_value ()
       		return
       		;;
       	remote.pushdefault)
     +
     + ## rebase.c ##
     +@@ rebase.c: enum rebase_type rebase_parse_value(const char *value)
     + 		return REBASE_FALSE;
     + 	else if (v > 0)
     + 		return REBASE_TRUE;
     +-	else if (!strcmp(value, "preserve") || !strcmp(value, "p"))
     +-		return REBASE_PRESERVE;
     + 	else if (!strcmp(value, "merges") || !strcmp(value, "m"))
     + 		return REBASE_MERGES;
     + 	else if (!strcmp(value, "interactive") || !strcmp(value, "i"))
     +
     + ## rebase.h ##
     +@@ rebase.h: enum rebase_type {
     + 	REBASE_INVALID = -1,
     + 	REBASE_FALSE = 0,
     + 	REBASE_TRUE,
     +-	REBASE_PRESERVE,
     + 	REBASE_MERGES,
     + 	REBASE_INTERACTIVE
     + };
 5:  14e242b3cf9 ! 5:  eb738b1bf05 rebase: drop support for `--preserve-merges`
     @@ Documentation/git-rebase.txt: i.e. commits that would be excluded by linkgit:git
       onto `<upstream>` (or `<onto>`, if specified).
       +
      -The `--rebase-merges` mode is similar in spirit to the deprecated
     --`--preserve-merges`, but in contrast to that option works well in interactive
     --rebases: commits can be reordered, inserted and dropped at will.
     +-`--preserve-merges` but works with interactive rebases,
     +-where commits can be reordered, inserted and dropped at will.
      -+
       It is currently only possible to recreate the merge commits using the
       `recursive` merge strategy; Different merge strategies can be used only via
     @@ Documentation/git-rebase.txt: are incompatible with the following options:
      - * --preserve-merges
        * --interactive
        * --exec
     -  * --keep-empty
     +  * --no-keep-empty
      @@ Documentation/git-rebase.txt: are incompatible with the following options:
       
       In addition, the following pairs of options are incompatible:
     @@ Documentation/git-rebase.txt: are incompatible with the following options:
      - * --preserve-merges and --interactive
      - * --preserve-merges and --signoff
      - * --preserve-merges and --rebase-merges
     +- * --preserve-merges and --empty=
     +- * --preserve-merges and --ignore-whitespace
     +- * --preserve-merges and --committer-date-is-author-date
     +- * --preserve-merges and --ignore-date
        * --keep-base and --onto
        * --keep-base and --root
     - 
     -@@ Documentation/git-rebase.txt: merge tlsv1.3
     - merge cmake
     - ------------
     +  * --fork-point and --root
     +@@ Documentation/git-rebase.txt: CONFIGURATION
     + include::config/rebase.txt[]
     + include::config/sequencer.txt[]
       
      -BUGS
      -----
     @@ Documentation/git-rebase.txt: merge tlsv1.3
       Part of the linkgit:git[1] suite
      
       ## Makefile ##
     -@@ Makefile: SCRIPT_SH += git-web--browse.sh
     +@@ Makefile: SCRIPT_SH += git-submodule.sh
     + SCRIPT_SH += git-web--browse.sh
       
       SCRIPT_LIB += git-mergetool--lib
     - SCRIPT_LIB += git-parse-remote
      -SCRIPT_LIB += git-rebase--preserve-merges
     - SCRIPT_LIB += git-sh-setup
       SCRIPT_LIB += git-sh-i18n
     + SCRIPT_LIB += git-sh-setup
       
      @@ Makefile: XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
     + 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
       LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
       LOCALIZED_SH = $(SCRIPT_SH)
     - LOCALIZED_SH += git-parse-remote.sh
      -LOCALIZED_SH += git-rebase--preserve-merges.sh
       LOCALIZED_SH += git-sh-setup.sh
       LOCALIZED_PERL = $(SCRIPT_PERL)
       
      
       ## builtin/rebase.c ##
     -@@ builtin/rebase.c: enum rebase_type {
     +@@ builtin/rebase.c: static GIT_PATH_FUNC(merge_dir, "rebase-merge")
     + enum rebase_type {
       	REBASE_UNSPECIFIED = -1,
     - 	REBASE_AM,
     - 	REBASE_MERGE,
     --	REBASE_INTERACTIVE,
     + 	REBASE_APPLY,
     +-	REBASE_MERGE,
      -	REBASE_PRESERVE_MERGES
     -+	REBASE_INTERACTIVE
     ++	REBASE_MERGE
       };
       
     - struct rebase_options {
     + enum empty_type {
      @@ builtin/rebase.c: int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
       
     - static int is_interactive(struct rebase_options *opts)
     + static int is_merge(struct rebase_options *opts)
       {
     --	return opts->type == REBASE_INTERACTIVE ||
     +-	return opts->type == REBASE_MERGE ||
      -		opts->type == REBASE_PRESERVE_MERGES;
     -+	return opts->type == REBASE_INTERACTIVE;
     ++	return opts->type == REBASE_MERGE;
       }
       
     - static void imply_interactive(struct rebase_options *opts, const char *option)
     -@@ builtin/rebase.c: static void imply_interactive(struct rebase_options *opts, const char *option)
     - 		die(_("%s requires an interactive rebase"), option);
     + static void imply_merge(struct rebase_options *opts, const char *option)
     +@@ builtin/rebase.c: static void imply_merge(struct rebase_options *opts, const char *option)
     + 		die(_("%s requires the merge backend"), option);
       		break;
     - 	case REBASE_INTERACTIVE:
     + 	case REBASE_MERGE:
      -	case REBASE_PRESERVE_MERGES:
       		break;
     - 	case REBASE_MERGE:
     - 		/* we now implement --merge via --interactive */
     + 	default:
     + 		opts->type = REBASE_MERGE; /* implied */
      @@ builtin/rebase.c: static struct commit *peel_committish(const char *name)
       	return (struct commit *)peel_to_type(name, 0, obj, OBJ_COMMIT);
       }
     @@ builtin/rebase.c: static struct commit *peel_committish(const char *name)
      -	}
      -}
      -
     - #define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
     - 
     - #define RESET_HEAD_DETACH (1<<0)
     + static int move_to_original_branch(struct rebase_options *opts)
     + {
     + 	struct strbuf orig_head_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
      @@ builtin/rebase.c: static int run_am(struct rebase_options *opts)
       
       static int run_specific_rebase(struct rebase_options *opts, enum action action)
     @@ builtin/rebase.c: static int run_am(struct rebase_options *opts)
       	int status;
      -	const char *backend, *backend_func;
       
     - 	if (opts->type == REBASE_INTERACTIVE) {
     - 		/* Run builtin interactive rebase */
     + 	if (opts->type == REBASE_MERGE) {
     + 		/* Run sequencer-based rebase */
      @@ builtin/rebase.c: static int run_specific_rebase(struct rebase_options *opts, enum action action)
       		}
       
     - 		status = run_rebase_interactive(opts, action);
     + 		status = run_sequencer_rebase(opts, action);
      -		goto finished_rebase;
      -	}
      -
     --	if (opts->type == REBASE_AM) {
     -+	} else if (opts->type == REBASE_AM)
     +-	if (opts->type == REBASE_APPLY) {
     ++	} else if (opts->type == REBASE_APPLY)
       		status = run_am(opts);
      -		goto finished_rebase;
      -	}
     @@ builtin/rebase.c: static int run_specific_rebase(struct rebase_options *opts, en
      -	add_var(&script_snippet, "revisions", opts->revisions);
      -	add_var(&script_snippet, "restrict_revision", opts->restrict_revision ?
      -		oid_to_hex(&opts->restrict_revision->object.oid) : NULL);
     --	add_var(&script_snippet, "GIT_QUIET",
     --		opts->flags & REBASE_NO_QUIET ? "" : "t");
     --	sq_quote_argv_pretty(&buf, opts->git_am_opts.argv);
     +-	sq_quote_argv_pretty(&buf, opts->git_am_opts.v);
      -	add_var(&script_snippet, "git_am_opt", buf.buf);
      -	strbuf_release(&buf);
      -	add_var(&script_snippet, "verbose",
     @@ builtin/rebase.c: static int run_specific_rebase(struct rebase_options *opts, en
      -	add_var(&script_snippet, "git_format_patch_opt",
      -		opts->git_format_patch_opt.buf);
      -
     --	if (is_interactive(opts) &&
     +-	if (is_merge(opts) &&
      -	    !(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
      -		strbuf_addstr(&script_snippet,
      -			      "GIT_SEQUENCE_EDITOR=:; export GIT_SEQUENCE_EDITOR; ");
     @@ builtin/rebase.c: static int run_specific_rebase(struct rebase_options *opts, en
      -finished_rebase:
       	if (opts->dont_finish_rebase)
       		; /* do nothing */
     - 	else if (opts->type == REBASE_INTERACTIVE)
     + 	else if (opts->type == REBASE_MERGE)
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       			N_("let the user edit the list of commits to rebase"),
       			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
     - 			parse_opt_interactive },
     + 			parse_opt_interactive),
      -		OPT_SET_INT_F('p', "preserve-merges", &options.type,
      -			      N_("(DEPRECATED) try to recreate merges instead of "
      -				 "ignoring them"),
      -			      REBASE_PRESERVE_MERGES, PARSE_OPT_HIDDEN),
       		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
     - 		OPT_BOOL('k', "keep-empty", &options.keep_empty,
     - 			 N_("preserve empty commits during rebase")),
     + 		OPT_CALLBACK_F(0, "empty", &options, "{drop,keep,ask}",
     + 			       N_("how to handle commits that become empty"),
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       		strbuf_reset(&buf);
       		strbuf_addf(&buf, "%s/rewritten", merge_dir());
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       		if (options.onto_name)
       			die(_("cannot combine '--keep-base' with '--onto'"));
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     + 		case REBASE_APPLY:
       			die(_("--strategy requires --merge or --interactive"));
       		case REBASE_MERGE:
     - 		case REBASE_INTERACTIVE:
      -		case REBASE_PRESERVE_MERGES:
       			/* compatible */
       			break;
       		case REBASE_UNSPECIFIED:
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     + 
       	switch (options.type) {
       	case REBASE_MERGE:
     - 	case REBASE_INTERACTIVE:
      -	case REBASE_PRESERVE_MERGES:
       		options.state_dir = merge_dir();
       		break;
     - 	case REBASE_AM:
     + 	case REBASE_APPLY:
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     - 	}
     + 		options.reschedule_failed_exec = reschedule_failed_exec;
       
       	if (options.signoff) {
      -		if (options.type == REBASE_PRESERVE_MERGES)
      -			die("cannot combine '--signoff' with "
      -			    "'--preserve-merges'");
     - 		argv_array_push(&options.git_am_opts, "--signoff");
     + 		strvec_push(&options.git_am_opts, "--signoff");
       		options.flags |= REBASE_FORCE;
       	}
       
     @@ git-rebase--preserve-merges.sh (deleted)
      -	fi
      -}
      -
     --# Put the last action marked done at the beginning of the todo list
     --# again. If there has not been an action marked done yet, leave the list of
     --# items on the todo list unchanged.
     --reschedule_last_action () {
     --	tail -n 1 "$done" | cat - "$todo" >"$todo".new
     --	sed -e \$d <"$done" >"$done".new
     --	mv -f "$todo".new "$todo"
     --	mv -f "$done".new "$done"
     --}
     --
      -append_todo_help () {
      -	gettext "
      -Commands:
 6:  b7ba83969da = 6:  a987e9439af git-svn: drop support for `--preserve-merges`
 7:  634e4141e97 ! 7:  4492cca369c rebase: drop the internal `rebase--interactive` command
     @@ builtin/rebase.c: static const char *action_names[] = { "undefined",
       static int edit_todo_file(unsigned flags)
       {
       	const char *todo_file = rebase_path_todo();
     -@@ builtin/rebase.c: static int run_rebase_interactive(struct rebase_options *opts,
     +@@ builtin/rebase.c: static int run_sequencer_rebase(struct rebase_options *opts,
       
       		break;
       	}
     @@ builtin/rebase.c: static int run_rebase_interactive(struct rebase_options *opts,
       	default:
       		BUG("invalid command '%d'", command);
       	}
     -@@ builtin/rebase.c: static int run_rebase_interactive(struct rebase_options *opts,
     - 	return ret;
     +@@ builtin/rebase.c: static int parse_opt_keep_empty(const struct option *opt, const char *arg,
     + 	return 0;
       }
       
      -static const char * const builtin_rebase_interactive_usage[] = {
     @@ builtin/rebase.c: static int run_rebase_interactive(struct rebase_options *opts,
      -int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
      -{
      -	struct rebase_options opts = REBASE_OPTIONS_INIT;
     --	struct object_id squash_onto = null_oid;
     +-	struct object_id squash_onto = *null_oid();
      -	enum action command = ACTION_NONE;
      -	struct option options[] = {
      -		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
      -			   REBASE_FORCE),
     --		OPT_BOOL(0, "keep-empty", &opts.keep_empty, N_("keep empty commits")),
     --		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
     --			 N_("allow commits with empty messages")),
     +-		OPT_CALLBACK_F('k', "keep-empty", &options, NULL,
     +-			N_("keep commits which start empty"),
     +-			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
     +-			parse_opt_keep_empty),
     +-		OPT_BOOL_F(0, "allow-empty-message", &opts.allow_empty_message,
     +-			   N_("allow commits with empty messages"),
     +-			   PARSE_OPT_HIDDEN),
      -		OPT_BOOL(0, "rebase-merges", &opts.rebase_merges, N_("rebase merge commits")),
      -		OPT_BOOL(0, "rebase-cousins", &opts.rebase_cousins,
      -			 N_("keep original branch points of cousins")),
     @@ builtin/rebase.c: static int run_rebase_interactive(struct rebase_options *opts,
      -		warning(_("--[no-]rebase-cousins has no effect without "
      -			  "--rebase-merges"));
      -
     --	return !!run_rebase_interactive(&opts, command);
     +-	return !!run_sequencer_rebase(&opts, command);
      -}
      -
     - static int is_interactive(struct rebase_options *opts)
     + static int is_merge(struct rebase_options *opts)
       {
     - 	return opts->type == REBASE_INTERACTIVE;
     + 	return opts->type == REBASE_MERGE;
      
       ## git.c ##
      @@ git.c: static struct cmd_struct commands[] = {
 8:  45fee72059d < -:  ----------- remote: no longer claim that branch.*.rebase=preserve is a thing

-- 
gitgitgadget
