Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822E6C3F68F
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9E1207FF
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 16:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzLiG1Yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfLIQKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:10:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36586 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIQKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 11:10:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so15575287wma.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 08:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Igr44XXG2Qc4zHBs0/3gm0Wl1GBHDx9XB+vbg3Ev7CY=;
        b=LzLiG1YnFykEGn3iqt0u7kqJEFfop1LwzIDM8ZVtBGvxmVkDrpCssBB+57AdvkOixT
         R6QwMNLMHLhr1pZ8J5p1YP1hXq9LmYfYG+2X2JSRg3/UwU74uV4sENH8ZU7i9Hdv343v
         Qe8nfouT6wNcJaZcixrvOObUTcDSAD12R9JVViX1+Xm3L2vGcu7C3cvLBgok5VgilQkm
         kKISBiCR4vCPtq53jbPhtT791kLrXMd0/pO4+4suKUVZ+9ksHJ0XpiPPtx/WEPmGzCpa
         /kKFYEesUW+rlDcZyuwGv+xa3s8qvFxLzTbawBghsLWMgUAlhTP0bsAgYXCF3SB9Z85t
         GI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Igr44XXG2Qc4zHBs0/3gm0Wl1GBHDx9XB+vbg3Ev7CY=;
        b=p1dUTpNYc80DtBM41BuDs3KtpiGyCDjHv30M1BWJ6gYxWwE3YdfA0AXyRG1P6miSn8
         FQ7z7Zji135OYpmRMF8WFFUOS4NGRtMImlik+lJm9Megj+p1/2P6c2UDz5EB315GHz1O
         p7cMhYAFONoXL+G+Bc1EWd13XtbrrlXvu9TTGxZPvmUSNOaXqW0Ni98Ok34N7vHl4CSS
         5wcB2gqEAvyMComJ02OBG5/RA0O7u/c527ZwI/RzGRgK7yh62OWvG8pDxI/1+i9Ngs8S
         IPFgQLRFf3UvQaXLbuBdCjwLcAx0Ln/bgAYFjwUun2gEMnCBWW9kX9ZilxYIT9ALKtli
         4TQg==
X-Gm-Message-State: APjAAAV4QE5Yd4c+dCqM9Lg5AQPMiG9gs1m7poCm3sOKewl4m+M1IMCW
        dg8AYdbqZ6h5G6UaBao80ujgOPh6
X-Google-Smtp-Source: APXvYqwrc7ImT8+hVF6NbG8LHeK7IQUfds2T9taiPbhxJZO3RQhGWDfK2fSrazkcEI2vj35GDh1C1g==
X-Received: by 2002:a7b:cf01:: with SMTP id l1mr24474446wmg.86.1575907805649;
        Mon, 09 Dec 2019 08:10:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d6sm250684wmb.6.2019.12.09.08.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 08:10:05 -0800 (PST)
Message-Id: <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.git.1574374826.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 16:09:56 +0000
Subject: [PATCH v2 0/8] Improve testability with GIT_TEST_FSMONITOR
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The GIT_TEST_FSMONITOR environment variable allows run-time specification of
the fsmonitor hook. Initially used by t7619-status-fsmonitor.sh, we can
enable it across the test suite to see how it affects Git's behavior. In
particular, we can specify the version of the hook that requests a result
from Watchman to get actual updates to the files in the repo.

In many cases, our tests are simply not ready to handle this option.
fsmonitor does not integrate well with features such as split index, bare
repos, or submodules. Other times, we need to disable it because the test is
being specific about what files Git inspects during a 'status' call.

The long-term vision is to be able to run CI builds using a file-system
watcher like Watchman to get better coverage on this feature. These patches
get us closer, but there are still some issues around overloading the
Watchman interface when the tests are run in parallel. When using "prove -j8
t[0-8]*.sh" I see some failures that do not reproduce when running the test
scripts in isolation (on Linux), but using "-j5" is enough to eliminate
failures.

Some of these changes should be backed out in favor of a deeper fix, so in
some sense these settings of GIT_TEST_FSMONITOR="" serve as TODOs for the
fsmonitor feature.

Some recent and upcoming work on fsmonitor by Utsav Shah and Kevin Willford
may help us reach the goal of running with watchman enabled in CI builds.
I'll come back around with updates to the .azure-pipelines YAML files when
we feel the feature is ready for that.

Updates in V2:

 * Commit messages have been filled out completely. Most provide the same
   blurb of context before briefly describing the actual change.
   
   
 * Some commits were merged because they had similar causes (worktrees,
   submodules).
   
   
 * The test_clear_watchman function is updated and it is called by test_done
   instead of the atexit helper.
   
   

Thanks, -Stolee

Derrick Stolee (8):
  fsmonitor: disable in a bare repo
  fsmonitor: do not output to stderr for tests
  t1301-shared-repo.sh: disable FSMONITOR
  t3030-merge-recursive.sh: disable fsmonitor when tweaking
    GIT_WORK_TREE
  tests: disable fsmonitor in submodule tests
  t7063: disable fsmonitor with status cache
  t7519: disable external GIT_TEST_FSMONITOR variable
  test-lib: clear watchman watches at test completion

 config.c                                     |  5 +++++
 t/t1301-shared-repo.sh                       |  1 +
 t/t1510-repo-setup.sh                        |  1 +
 t/t2400-worktree-add.sh                      |  2 ++
 t/t3030-merge-recursive.sh                   |  2 ++
 t/t3404-rebase-interactive.sh                |  1 +
 t/t3600-rm.sh                                |  1 +
 t/t4060-diff-submodule-option-diff-format.sh |  3 +++
 t/t5526-fetch-submodules.sh                  |  2 ++
 t/t7063-status-untracked-cache.sh            |  3 +++
 t/t7402-submodule-rebase.sh                  |  3 +++
 t/t7406-submodule-update.sh                  |  2 ++
 t/t7506-status-submodule.sh                  |  3 +++
 t/t7508-status.sh                            |  3 +++
 t/t7519-status-fsmonitor.sh                  |  3 +++
 t/t7519/fsmonitor-watchman                   |  1 -
 t/test-lib-functions.sh                      | 15 +++++++++++++++
 t/test-lib.sh                                |  4 ++++
 18 files changed, 54 insertions(+), 1 deletion(-)


base-commit: dd0b61f577f041f1119bb3288451f8f9b7f9e3f2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-466%2Fderrickstolee%2Ftest-watchman-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-466/derrickstolee/test-watchman-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/466

Range-diff vs v1:

  1:  9bf5a803e6 !  1:  79bb4c8e7d fsmonitor: disable in a bare repo
     @@ -2,7 +2,18 @@
      
          fsmonitor: disable in a bare repo
      
     -    t0003-attributes.sh
     +    The fsmonitor feature allows an external tool such as watchman to
     +    monitor the working directory. The direct test
     +    t7619-status-fsmonitor.sh provides some coverage, but it would be
     +    better to run the entire test suite with watchman enabled. This
     +    would provide more confidence that the feature is working as
     +    intended.
     +
     +    If the repository is bare, then there is no working directory to
     +    watch. Disable the core_fsmonitor global in this case.
     +
     +    Before this change, the test t0003-attributes.sh would fail with
     +    GIT_TEST_FSMONITOR pointing to t/t7519/fsmonitor-watchman.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
  2:  245cc1b2cc !  2:  dd492091e3 fsmonitor: do not output to stderr for tests
     @@ -2,7 +2,18 @@
      
          fsmonitor: do not output to stderr for tests
      
     -    t0003-attributes.sh
     +    The fsmonitor feature allows an external tool such as watchman to
     +    monitor the working directory. The direct test
     +    t7619-status-fsmonitor.sh provides some coverage, but it would be
     +    better to run the entire test suite with watchman enabled. This
     +    would provide more confidence that the feature is working as
     +    intended.
     +
     +    The test t0003-attributes.sh and others would fail when
     +    GIT_TEST_FSMONITOR is pointing at t/t7519/fsmonitor-watchman because
     +    it sends a message over stderr when registering the repo with
     +    watchman for the first time. Remove this stderr message for the
     +    test script to avoid this noise.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
  3:  ed40ce8e4c !  3:  f9db0c3416 t1301-shared-repo.sh: disable FSMONITOR
     @@ -2,6 +2,17 @@
      
          t1301-shared-repo.sh: disable FSMONITOR
      
     +    The fsmonitor feature allows an external tool such as watchman to
     +    monitor the working directory. The direct test
     +    t7619-status-fsmonitor.sh provides some coverage, but it would be
     +    better to run the entire test suite with watchman enabled. This
     +    would provide more confidence that the feature is working as
     +    intended.
     +
     +    The test t1301-shared-repo.sh would fail when GIT_TEST_FSMONITOR
     +    is set to t/t7519/fsmonitor-watchman because it changes permissions
     +    in an incompatible way.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
  4:  9179776982 <  -:  ---------- t1510-repo-setup.sh: disable fsmonitor if no .git dir
  5:  81c587651e <  -:  ---------- fsmonitor: disable fsmonitor with worktrees
  6:  d5f5a3e2b9 !  4:  efc16962ee t3030-merge-recursive.sh: disable fsmonitor when tweaking GIT_WORK_TREE
     @@ -2,8 +2,47 @@
      
          t3030-merge-recursive.sh: disable fsmonitor when tweaking GIT_WORK_TREE
      
     +    The fsmonitor feature allows an external tool such as watchman to
     +    monitor the working directory. The direct test
     +    t7619-status-fsmonitor.sh provides some coverage, but it would be
     +    better to run the entire test suite with watchman enabled. This
     +    would provide more confidence that the feature is working as
     +    intended.
     +
     +    Worktrees use a ".git" _file_ instead of a folder to point to
     +    the base repo's .git directory and the proper worktree HEAD. The
     +    fsmonitor hook tries to create a JSON file inside the ".git" folder
     +    which violates the expectation here. It would be better to properly
     +    find a safe folder for storing this JSON file.
     +
     +    This is also a problem when a test script uses GIT_WORK_TREE.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     + diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
     + --- a/t/t1510-repo-setup.sh
     + +++ b/t/t1510-repo-setup.sh
     +@@
     + 	setup_repo 29 non-existent gitfile true &&
     + 	mkdir -p 29/sub/sub 29/wt/sub &&
     + 	(
     ++		GIT_TEST_FSMONITOR="" &&
     + 		cd 29 &&
     + 		GIT_WORK_TREE="$here/29" &&
     + 		export GIT_WORK_TREE &&
     +
     + diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
     + --- a/t/t2400-worktree-add.sh
     + +++ b/t/t2400-worktree-add.sh
     +@@
     + #!/bin/sh
     + 
     ++GIT_TEST_FSMONITOR=""
     ++
     + test_description='test git worktree add'
     + 
     + . ./test-lib.sh
     +
       diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
       --- a/t/t3030-merge-recursive.sh
       +++ b/t/t3030-merge-recursive.sh
  7:  d0b212c9df <  -:  ---------- t3600-rm.sh: disable fsmonitor when deleting populated submodule
  8:  36f845cb7e !  5:  a5b0bf6ac7 tests: disable fsmonitor in submodule tests
     @@ -2,12 +2,43 @@
      
          tests: disable fsmonitor in submodule tests
      
     +    The fsmonitor feature allows an external tool such as watchman to
     +    monitor the working directory. The direct test
     +    t7619-status-fsmonitor.sh provides some coverage, but it would be
     +    better to run the entire test suite with watchman enabled. This
     +    would provide more confidence that the feature is working as
     +    intended.
     +
          The fsmonitor feature struggles with submodules. Disable the
          GIT_TEST_FSMONITOR environment variable before running tests with
          a lot of submodule interactions.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     + diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
     + --- a/t/t3404-rebase-interactive.sh
     + +++ b/t/t3404-rebase-interactive.sh
     +@@
     + '
     + 
     + test_expect_success 'submodule rebase setup' '
     ++	GIT_TEST_FSMONITOR="" &&
     + 	git checkout A &&
     + 	mkdir sub &&
     + 	(
     +
     + diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
     + --- a/t/t3600-rm.sh
     + +++ b/t/t3600-rm.sh
     +@@
     + '
     + 
     + test_expect_success 'rm of a populated submodule with different HEAD fails unless forced' '
     ++	GIT_TEST_FSMONITOR="" &&
     + 	git reset --hard &&
     + 	git submodule update &&
     + 	git -C submod checkout HEAD^ &&
     +
       diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
       --- a/t/t4060-diff-submodule-option-diff-format.sh
       +++ b/t/t4060-diff-submodule-option-diff-format.sh
  9:  141a1909a4 !  6:  9cd4a08d82 t7063: disable fsmonitor with status cache
     @@ -2,6 +2,13 @@
      
          t7063: disable fsmonitor with status cache
      
     +    The fsmonitor feature allows an external tool such as watchman to
     +    monitor the working directory. The direct test
     +    t7619-status-fsmonitor.sh provides some coverage, but it would be
     +    better to run the entire test suite with watchman enabled. This
     +    would provide more confidence that the feature is working as
     +    intended.
     +
          The status cache tests use GIT_TRACE_UNTRACKED_STATS to check very
          detailed statistics related to how much Git actually checked for
          untracked files. The fsmonitor feature changes the expected behavior
 10:  cd717ef5de =  7:  215ec8688e t7519: disable external GIT_TEST_FSMONITOR variable
 11:  47cecb4a83 !  8:  e51165f260 test-lib: clear watchman watches at test completion
     @@ -2,6 +2,29 @@
      
          test-lib: clear watchman watches at test completion
      
     +    The fsmonitor feature allows an external tool such as watchman to
     +    monitor the working directory. The direct test
     +    t7619-status-fsmonitor.sh provides some coverage, but it would be
     +    better to run the entire test suite with watchman enabled. This
     +    would provide more confidence that the feature is working as
     +    intended.
     +
     +    When running the test suite in parallel with 'prove -j <N>', many
     +    repos are created and deleted in parallel. When GIT_TEST_FSMONITOR
     +    points to t/t7519/fsmonitor-watchman, this can lead to watchman
     +    tracking many different folders, overloading its watch queue.
     +
     +    As a test script completes, we can tell watchman to stop watching
     +    the directories inside the TRASH_DIRECTORY.
     +
     +    This is particularly important on Windows where watchman keeps an
     +    open handle on the directories it watches, preventing them from
     +    being deleted. There is currently a bug in watchman [1] where this
     +    handle still is not closed, but if that is updated then these tests
     +    can be run on Windows as well.
     +
     +    [1] https://github.com/facebook/watchman/issues/764
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
     @@ -13,17 +36,17 @@
       }
      +
      +test_clear_watchman () {
     -+	if test $GIT_TEST_FSMONITOR -ne ""
     ++	if test -n "$GIT_TEST_FSMONITOR"
      +	then
      +		watchman watch-list |
      +			grep "$TRASH_DIRECTORY" |
     -+			sed "s/\t\"//g" |
     -+			sed "s/\",//g" >repo-list
     ++			sed "s/\",//g" |
     ++			sed "s/\"//g" >repo-list
      +
     -+		for repo in $(cat repo-list)
     ++		while read repo
      +		do
      +			watchman watch-del "$repo"
     -+		done
     ++		done <repo-list
      +	fi
      +}
      
     @@ -31,11 +54,13 @@
       --- a/t/test-lib.sh
       +++ b/t/test-lib.sh
      @@
     - 	# sure that the registered cleanup commands are run only once.
     - 	test : != "$test_atexit_cleanup" || return 0
     + test_done () {
     + 	GIT_EXIT_OK=t
       
     ++	# If watchman is being used with GIT_TEST_FSMONITOR, then
     ++	# clear all watches on directories inside the TRASH_DIRECTORY.
      +	test_clear_watchman
      +
     - 	setup_malloc_check
     - 	test_eval_ "$test_atexit_cleanup"
     - 	test_atexit_cleanup=:
     + 	# Run the atexit commands _before_ the trash directory is
     + 	# removed, so the commands can access pidfiles and socket files.
     + 	test_atexit_handler

-- 
gitgitgadget
