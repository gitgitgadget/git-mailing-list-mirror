Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAF1C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11CB621527
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 21:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2gMOWtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIZVE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 17:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgIZVEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 17:04:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC85C0613CE
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:04:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d4so2614825wmd.5
        for <git@vger.kernel.org>; Sat, 26 Sep 2020 14:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0E7Y1QOeEfVQDVjM6Uxf23pKMptNG0RPnawi/sZC584=;
        b=r2gMOWtXRYL9Ua6Ii0epu3wZooCHnh5K0Uz27byEJXzC08tz9BRf3dl8eyhAe0XgXd
         7DPfHM2jQ1OBsEnKWMPp7TjFzH0T8LEiBhprPc12Gu0pqg1YdlBTKpif4F77x5oxwP6G
         K+U2qzhIO6T++XWBtBG3DzVyB9s6NkIFdDKapfx2d/UT4A1/f+WEHuRvD+dts31aUnXj
         5oExrl5Gdbr44XMAVmrqUhwTINLipzk1yzEZxIM6Axiz5VwbTShDw3xzjTNG8biEkkkO
         PgrpsoeYS03pz0NaEVE3paT8KREzPo9oVntrum5FQYJcQSDG/plsouWD6iTZedGqEFye
         bMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0E7Y1QOeEfVQDVjM6Uxf23pKMptNG0RPnawi/sZC584=;
        b=hTVSY4w8gpRsHjE8HDxy7KgRdWXQmidiWNMB0w7k8LeiI2IYDLktm4OAvXs1cTsSx1
         AT2s7OmRA5lf8+CA+6I7dti4lDJHFR0rMFQ5EpfpS/Ip5I2y1H/RaqTchrjgBsphJwYC
         AM5u1SNFngsY8l8azCr+fEdeSB7zKW23KbzPKD9BrZ86vK0EeKUAyZrzvmT2rWuH23Ki
         dSkhw239T3yUDvYtqExC4ROA0EqVytYO84ota2+tTVwJSosTt+mMoVEVmMP6EEE8+/v6
         OEC5ktxKB5ZKD2CJ48PJWrEJc87y8fuMULCgcPrKCJZmI7HR0lU6D6dya6QsclOxZEvz
         RS+A==
X-Gm-Message-State: AOAM530dwr6RlxgVjGLGb/8ku91qGJ+NamtxwtVVIRo83m4lf9HtPNP5
        WIFkxX9jkznFNAy95czysSZEtvWmgeI=
X-Google-Smtp-Source: ABdhPJzuaehyPg/HPSvfjNEP4UE1JXr6zJk4C4e/G66qNBTEaFPvvfQjacMw6d079XrvTBfUN11rWw==
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr4211537wmk.91.1601154263639;
        Sat, 26 Sep 2020 14:04:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b64sm3772846wmh.13.2020.09.26.14.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 14:04:23 -0700 (PDT)
Message-Id: <pull.734.v3.git.1601154262.gitgitgadget@gmail.com>
In-Reply-To: <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
References: <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Sep 2020 21:04:17 +0000
Subject: [PATCH v3 0/5] Inclusive naming, part II
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series represents the logical next step on the journey begun with
introducing init.defaultBranch: in these patches, we avoid a couple
unnecessary mentions of the branch name "master".

This patch series does not try to change the default branch name, although I
have that patch series ready to go. You can see the overall idea here: 
https://github.com/gitgitgadget/git/pull/655. Concretely, I plan on
submitting three more patch series after this one:

 1. a relatively small patch series to avoid using the branch name main in
    the test suite. This is necessary because my plan is to change the
    default branch name to that name, therefore it cannot be used as the
    name of a topic branch any longer.
 2. a relatively large patch series (currently consisting of 18 patches) to
    change the default branch name to main. Most of the patches provide
    non-trivial (read: non-scriptable) adjustments to the test suite in an
    incremental fashion, with a big patch toward the end that reflects a
    fully-automated search-and-replace of all the trivial cases.
 3. a very small patch series with fall-out patches that are not necessary
    to pass the test suite, but are still required to complete the rename
    (adjusted code comment, file rename).

(Note: I am still debating whether I should move one or two patches from the
second to the third patch series)

Changes since v2:

 * Extended the idea of using topic instead of main to patch 4/5.
 * Explained in the commit message of patch 5/5 why we cannot use topic 
   instead of main here.

Changes since v1:

 * Instead of using the name primary for the adjustments to 
   t/test-terminal.perl, we follow Python's lead (which uses the
   parent/child nomenclature).
 * The changes to t3200 no longer use variations of the name main as branch
   names; Instead, the renamed branches are independent from any current or
   future default branch name.

Johannes Schindelin (5):
  fast-export: avoid using unnecessary language in a code comment
  t/test-terminal: avoid non-inclusive language
  t3200: avoid variations of the `master` branch name
  tests: avoid variations of the `master` branch name
  t9902: avoid using the branch name `master`

 builtin/fast-export.c        |  2 +-
 t/t3200-branch.sh            | 34 ++++++++++++++---------------
 t/t3427-rebase-subtree.sh    | 42 ++++++++++++++++++------------------
 t/t4150-am.sh                |  8 +++----
 t/t5515-fetch-merge-logic.sh |  6 +++---
 t/t5523-push-upstream.sh     | 20 ++++++++---------
 t/t6018-rev-list-glob.sh     |  6 +++---
 t/t6040-tracking-info.sh     | 20 ++++++++---------
 t/t6409-merge-subtree.sh     | 14 ++++++------
 t/t9902-completion.sh        | 10 ++++-----
 t/test-terminal.perl         | 32 +++++++++++++--------------
 11 files changed, 97 insertions(+), 97 deletions(-)


base-commit: 54e85e7af1ac9e9a92888060d6811ae767fea1bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-734%2Fdscho%2Favoid-unnecessary-branch-name-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-734/dscho/avoid-unnecessary-branch-name-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/734

Range-diff vs v2:

 1:  587ddca42a = 1:  587ddca42a fast-export: avoid using unnecessary language in a code comment
 2:  80e1d46cce = 2:  80e1d46cce t/test-terminal: avoid non-inclusive language
 3:  8d8e9abfe2 = 3:  8d8e9abfe2 t3200: avoid variations of the `master` branch name
 4:  8f59e19b95 ! 4:  ef8a9b74ed tests: avoid variations of the `master` branch name
     @@ Commit message
          because they do not require any changes outside of the test script, so
          let's do that.
      
     -    Seeing as `main` seems to be materializing as the favorite default
     -    branch name of many Open Source projects, we use that name in our
     -    replacements, too.
     +    Seeing as the touched branches have very little (if anything) to do with
     +    the default branch, we choose to use a completely separate naming
     +    scheme: `topic_<number>` (it cannot be `topic-<number>` because t5515
     +    uses the `test_oid` machinery with the term, and that machinery uses
     +    shell variables internally, whose names cannot contain dashes).
      
          This trick was performed by this (GNU) sed invocation:
      
     -            $ sed -i 's/master\([a-z0-9]\)/main\1/g' t/t*.sh
     +            $ sed -i 's/master\([a-z0-9]\)/topic_\1/g' t/t*.sh
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ t/t3427-rebase-subtree.sh: commit_message() {
       # is generated (the onelines are shown, time flows from left to right):
       #
      -# master1 - master2 - master3
     -+# main1 - main2 - main3
     ++# topic_1 - topic_2 - topic_3
       #                             \
      -# README ---------------------- Add subproject master - master4 - files_subtree/master5
     -+# README ---------------------- Add subproject master - main4 - files_subtree/main5
     ++# README ---------------------- Add subproject master - topic_4 - files_subtree/topic_5
       #
       # Where the merge moves the files master[123].t into the subdirectory
      -# files_subtree/ and master4 as well as files_subtree/master5 add files to that
     -+# files_subtree/ and main4 as well as files_subtree/main5 add files to that
     ++# files_subtree/ and topic_4 as well as files_subtree/topic_5 add files to that
       # directory directly.
       #
       # Then, in subsequent test cases, `git filter-branch` is used to distill just
     @@ t/t3427-rebase-subtree.sh: commit_message() {
       # this:
       #
      -# Add subproject master - master4 - files_subtree/master5 - Empty commit
     -+# Add subproject master - main4 - files_subtree/main5 - Empty commit
     ++# Add subproject master - topic_4 - files_subtree/topic_5 - Empty commit
       #
      -# where the root commit adds three files: master1.t, master2.t and master3.t.
     -+# where the root commit adds three files: main1.t, main2.t and main3.t.
     ++# where the root commit adds three files: topic_1.t, topic_2.t and topic_3.t.
       #
      -# This commit history is then rebased onto `master3` with the
     -+# This commit history is then rebased onto `main3` with the
     ++# This commit history is then rebased onto `topic_3` with the
       # `-Xsubtree=files_subtree` option in three different ways:
       #
       # 1. using `--preserve-merges`
     @@ t/t3427-rebase-subtree.sh: test_expect_success 'setup' '
      -	test_commit -C files master1 &&
      -	test_commit -C files master2 &&
      -	test_commit -C files master3 &&
     -+	test_commit -C files main1 &&
     -+	test_commit -C files main2 &&
     -+	test_commit -C files main3 &&
     ++	test_commit -C files topic_1 &&
     ++	test_commit -C files topic_2 &&
     ++	test_commit -C files topic_3 &&
       
       	: perform subtree merge into files_subtree/ &&
       	git fetch files refs/heads/master:refs/heads/files-master &&
     @@ t/t3427-rebase-subtree.sh: test_expect_success 'setup' '
       	: add two extra commits to rebase &&
      -	test_commit -C files_subtree master4 &&
      -	test_commit files_subtree/master5 &&
     -+	test_commit -C files_subtree main4 &&
     -+	test_commit files_subtree/main5 &&
     ++	test_commit -C files_subtree topic_4 &&
     ++	test_commit files_subtree/topic_5 &&
       
       	git checkout -b to-rebase &&
       	git fast-export --no-data HEAD -- files_subtree/ |
     @@ t/t3427-rebase-subtree.sh: test_expect_success 'setup' '
       '
       
      -# FAILURE: Does not preserve master4.
     -+# FAILURE: Does not preserve main4.
     ++# FAILURE: Does not preserve topic_4.
       test_expect_failure REBASE_P 'Rebase -Xsubtree --preserve-merges --onto commit' '
       	reset_rebase &&
       	git checkout -b rebase-preserve-merges to-rebase &&
       	git rebase -Xsubtree=files_subtree --preserve-merges --onto files-master master &&
      -	verbose test "$(commit_message HEAD~)" = "master4" &&
      -	verbose test "$(commit_message HEAD)" = "files_subtree/master5"
     -+	verbose test "$(commit_message HEAD~)" = "main4" &&
     -+	verbose test "$(commit_message HEAD)" = "files_subtree/main5"
     ++	verbose test "$(commit_message HEAD~)" = "topic_4" &&
     ++	verbose test "$(commit_message HEAD)" = "files_subtree/topic_5"
       '
       
      -# FAILURE: Does not preserve master4.
     -+# FAILURE: Does not preserve main4.
     ++# FAILURE: Does not preserve topic_4.
       test_expect_failure REBASE_P 'Rebase -Xsubtree --keep-empty --preserve-merges --onto commit' '
       	reset_rebase &&
       	git checkout -b rebase-keep-empty to-rebase &&
       	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
      -	verbose test "$(commit_message HEAD~2)" = "master4" &&
      -	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
     -+	verbose test "$(commit_message HEAD~2)" = "main4" &&
     -+	verbose test "$(commit_message HEAD~)" = "files_subtree/main5" &&
     ++	verbose test "$(commit_message HEAD~2)" = "topic_4" &&
     ++	verbose test "$(commit_message HEAD~)" = "files_subtree/topic_5" &&
       	verbose test "$(commit_message HEAD)" = "Empty commit"
       '
       
     @@ t/t3427-rebase-subtree.sh: test_expect_success 'Rebase -Xsubtree --empty=ask --o
       	git rebase --skip &&
      -	verbose test "$(commit_message HEAD~2)" = "master4" &&
      -	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
     -+	verbose test "$(commit_message HEAD~2)" = "main4" &&
     -+	verbose test "$(commit_message HEAD~)" = "files_subtree/main5" &&
     ++	verbose test "$(commit_message HEAD~2)" = "topic_4" &&
     ++	verbose test "$(commit_message HEAD~)" = "files_subtree/topic_5" &&
       	verbose test "$(commit_message HEAD)" = "Empty commit"
       '
       
     @@ t/t3427-rebase-subtree.sh: test_expect_success 'Rebase -Xsubtree --empty=ask --r
       	git rebase --skip &&
      -	verbose test "$(commit_message HEAD~2)" = "master4" &&
      -	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
     -+	verbose test "$(commit_message HEAD~2)" = "main4" &&
     -+	verbose test "$(commit_message HEAD~)" = "files_subtree/main5" &&
     ++	verbose test "$(commit_message HEAD~2)" = "topic_4" &&
     ++	verbose test "$(commit_message HEAD~)" = "files_subtree/topic_5" &&
       	verbose test "$(commit_message HEAD)" = "Empty commit"
       '
       
     @@ t/t4150-am.sh: test_expect_success 'am changes committer and keeps author' '
       	rm -fr .git/rebase-apply &&
       	git reset --hard &&
      -	git checkout -b master2 first &&
     -+	git checkout -b main2 first &&
     ++	git checkout -b topic_2 first &&
       	git am --signoff <patch2 &&
       	{
       		printf "third\n\nSigned-off-by: %s <%s>\n\n" \
     @@ t/t4150-am.sh: test_expect_success 'am --signoff adds Signed-off-by: line' '
       
       test_expect_success 'am stays in branch' '
      -	echo refs/heads/master2 >expected &&
     -+	echo refs/heads/main2 >expected &&
     ++	echo refs/heads/topic_2 >expected &&
       	git symbolic-ref HEAD >actual &&
       	test_cmp expected actual
       '
     @@ t/t4150-am.sh: test_expect_success 'am without --keep removes Re: and [PATCH] st
       	git am <patch4 &&
       	git rev-parse HEAD >expected &&
      -	git rev-parse master2 >actual &&
     -+	git rev-parse main2 >actual &&
     ++	git rev-parse topic_2 >actual &&
       	test_cmp expected actual
       '
       
     @@ t/t4150-am.sh: test_expect_success 'am --keep-non-patch really keeps the non-pat
       	rm -fr .git/rebase-apply &&
       	git reset --hard &&
      -	git checkout -b base3way master2 &&
     -+	git checkout -b base3way main2 &&
     ++	git checkout -b base3way topic_2 &&
       	sed -n -e "3,\$p" msg >file &&
       	head -n 9 msg >>file &&
       	git add file &&
     @@ t/t5515-fetch-merge-logic.sh: export GIT_TEST_PROTOCOL_VERSION
       build_script () {
       	script="$1" &&
      -	for i in one three_file master master2 one_tree three two two2 three2
     -+	for i in one three_file master main2 one_tree three two two2 three2
     ++	for i in one three_file master topic_2 one_tree three two two2 three2
       	do
       		echo "s/$(test_oid --hash=sha1 "$i")/$(test_oid "$i")/g" >>"$script"
       	done
     @@ t/t5515-fetch-merge-logic.sh: test_expect_success setup '
       
      -	master2 sha1:754b754407bf032e9a2f9d5a9ad05ca79a6b228f
      -	master2 sha256:6c7abaea8a6d8ef4d89877e68462758dc6774690fbbbb0e6d7dd57415c9abde0
     -+	main2 sha1:754b754407bf032e9a2f9d5a9ad05ca79a6b228f
     -+	main2 sha256:6c7abaea8a6d8ef4d89877e68462758dc6774690fbbbb0e6d7dd57415c9abde0
     ++	topic_2 sha1:754b754407bf032e9a2f9d5a9ad05ca79a6b228f
     ++	topic_2 sha256:6c7abaea8a6d8ef4d89877e68462758dc6774690fbbbb0e6d7dd57415c9abde0
       
       	two2 sha1:6134ee8f857693b96ff1cc98d3e2fd62b199e5a8
       	two2 sha256:87a2d3ee29c83a3dc7afd41c0606b11f67603120b910a7be7840accdc18344d4
     @@ t/t5523-push-upstream.sh: test_expect_success 'push -u --dry-run master:otherX'
      -	git branch master2 &&
      -	git push -u upstream master2:master2 &&
      -	check_config master2 upstream refs/heads/master2
     -+test_expect_success 'push -u main2:main2' '
     -+	git branch main2 &&
     -+	git push -u upstream main2:main2 &&
     -+	check_config main2 upstream refs/heads/main2
     ++test_expect_success 'push -u topic_2:topic_2' '
     ++	git branch topic_2 &&
     ++	git push -u upstream topic_2:topic_2 &&
     ++	check_config topic_2 upstream refs/heads/topic_2
       '
       
      -test_expect_success 'push -u master2:other2' '
      -	git push -u upstream master2:other2 &&
      -	check_config master2 upstream refs/heads/other2
     -+test_expect_success 'push -u main2:other2' '
     -+	git push -u upstream main2:other2 &&
     -+	check_config main2 upstream refs/heads/other2
     ++test_expect_success 'push -u topic_2:other2' '
     ++	git push -u upstream topic_2:other2 &&
     ++	check_config topic_2 upstream refs/heads/other2
       '
       
      -test_expect_success 'push -u :master2' '
      -	git push -u upstream :master2 &&
      -	check_config master2 upstream refs/heads/other2
     -+test_expect_success 'push -u :main2' '
     -+	git push -u upstream :main2 &&
     -+	check_config main2 upstream refs/heads/other2
     ++test_expect_success 'push -u :topic_2' '
     ++	git push -u upstream :topic_2 &&
     ++	check_config topic_2 upstream refs/heads/other2
       '
       
       test_expect_success 'push -u --all' '
     @@ t/t6018-rev-list-glob.sh: test_expect_success 'setup' '
       	commit some &&
       	git checkout master &&
      -	commit master2 &&
     -+	commit main2 &&
     ++	commit topic_2 &&
       	git tag foo/bar master &&
      -	commit master3 &&
     -+	commit main3 &&
     ++	commit topic_3 &&
       	git update-ref refs/remotes/foo/baz master &&
      -	commit master4 &&
     -+	commit main4 &&
     ++	commit topic_4 &&
       	git update-ref refs/remotes/upstream/one subspace/one &&
       	git update-ref refs/remotes/upstream/two subspace/two &&
       	git update-ref refs/remotes/upstream/x subspace-x &&
     @@ t/t6040-tracking-info.sh: test_expect_success 'fail to track annotated tags' '
      -	git update-ref refs/heads/from-master2 from-master2^ &&
      -	git rev-parse from-master2 >expect2 &&
      -	git branch --set-upstream-to master from-master2 &&
     -+	git branch from-main2 master &&
     -+	test_must_fail git config branch.from-main2.merge > actual &&
     -+	git rev-list from-main2 &&
     -+	git update-ref refs/heads/from-main2 from-main2^ &&
     -+	git rev-parse from-main2 >expect2 &&
     -+	git branch --set-upstream-to master from-main2 &&
     ++	git branch from-topic_2 master &&
     ++	test_must_fail git config branch.from-topic_2.merge > actual &&
     ++	git rev-list from-topic_2 &&
     ++	git update-ref refs/heads/from-topic_2 from-topic_2^ &&
     ++	git rev-parse from-topic_2 >expect2 &&
     ++	git branch --set-upstream-to master from-topic_2 &&
       	git config branch.from-master.merge > actual &&
      -	git rev-parse from-master2 >actual2 &&
     -+	git rev-parse from-main2 >actual2 &&
     ++	git rev-parse from-topic_2 >actual2 &&
       	grep -q "^refs/heads/master$" actual &&
       	cmp expect2 actual2
       '
     @@ t/t6040-tracking-info.sh: test_expect_success 'fail to track annotated tags' '
       	git checkout follower &&
      -	git checkout from-master2 &&
      -	git config branch.from-master2.merge > expect2 &&
     -+	git checkout from-main2 &&
     -+	git config branch.from-main2.merge > expect2 &&
     ++	git checkout from-topic_2 &&
     ++	git config branch.from-topic_2.merge > expect2 &&
       	git branch --set-upstream-to @{-1} from-master &&
       	git config branch.from-master.merge > actual &&
      -	git config branch.from-master2.merge > actual2 &&
     -+	git config branch.from-main2.merge > actual2 &&
     ++	git config branch.from-topic_2.merge > actual2 &&
       	git branch --set-upstream-to follower from-master &&
       	git config branch.from-master.merge > expect &&
       	test_cmp expect2 actual2 &&
     @@ t/t6409-merge-subtree.sh: test_expect_success 'merge update' '
       	o3=$(git hash-object git-gui.sh) &&
       	git add git-gui.sh &&
      -	git checkout -b master2 &&
     -+	git checkout -b main2 &&
     ++	git checkout -b topic_2 &&
       	git commit -m "update git-gui" &&
       	cd ../git &&
      -	git pull -s subtree gui master2 &&
     -+	git pull -s subtree gui main2 &&
     ++	git pull -s subtree gui topic_2 &&
       	git ls-files -s >actual &&
       	(
       		echo "100644 $o3 0	git-gui/git-gui.sh" &&
     @@ t/t6409-merge-subtree.sh: test_expect_success 'merge update' '
       	cd ../git &&
       	git reset --hard master &&
      -	git checkout -b master2 &&
     -+	git checkout -b main2 &&
     ++	git checkout -b topic_2 &&
       	git merge -s ours --no-commit gui/master &&
       	git read-tree --prefix=git-gui2/ -u gui/master &&
       	git commit -m "Merge git-gui2 as our subdirectory" &&
     @@ t/t6409-merge-subtree.sh: test_expect_success 'initial ambiguous subtree' '
       	cd ../git &&
      -	git reset --hard master2 &&
      -	git pull -Xsubtree=git-gui gui master2 &&
     -+	git reset --hard main2 &&
     -+	git pull -Xsubtree=git-gui gui main2 &&
     ++	git reset --hard topic_2 &&
     ++	git pull -Xsubtree=git-gui gui topic_2 &&
       	git ls-files -s >actual &&
       	(
       		echo "100644 $o3 0	git-gui/git-gui.sh" &&
     @@ t/t6409-merge-subtree.sh: test_expect_success 'merge using explicit' '
       	cd ../git &&
      -	git reset --hard master2 &&
      -	git pull -Xsubtree=git-gui2 gui master2 &&
     -+	git reset --hard main2 &&
     -+	git pull -Xsubtree=git-gui2 gui main2 &&
     ++	git reset --hard topic_2 &&
     ++	git pull -Xsubtree=git-gui2 gui topic_2 &&
       	git ls-files -s >actual &&
       	(
       		echo "100644 $o1 0	git-gui/git-gui.sh" &&
 5:  c2c1238b5d ! 5:  a80297f5df t9902: avoid using the branch name `master`
     @@ Commit message
          The completion tests used that name unnecessarily, and it is a
          non-inclusive term, so let's avoid using it here.
      
     +    Since three of the touched test cases make use of the fact that two of
     +    the branch names (`master` and `maint`) start with the same letter (or
     +    even with the same two letters), we choose to replace the use of
     +    `master` by a name that also has that property: `main`.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t9902-completion.sh ##

-- 
gitgitgadget
