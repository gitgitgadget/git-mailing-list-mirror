Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E08DC43467
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 10:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE2E20708
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 10:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LADlCEOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgJHKNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 06:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgJHKNu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 06:13:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7399DC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 03:13:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y12so558445wrp.6
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fis0V9TQ3Gy1MWJNmSG7X3X5UQIdDNJ+tzyb9aUb4pc=;
        b=LADlCEObTYcHupHB3shPZiqLOcZkBAHBV53XtjU1JCi/VUFsMPElOHqhUcq5kLAHRn
         XaTUgTTOM61zhhWEpYDdDuaQULcI9DFwbipRT47tY+fL6GtnhdsukjFe9A2Ear4/ebpa
         ODYb64JsyDNOT66/VvW+RlEgCg3ipC/kZ/IX0WPml5bDNcXzQfiRCeKWL/d22245VIyn
         1yNhW4U8NQhlJMNWL//k92VNdGRh0UBCJboUHvMldi8RZf4e64dLawLQhRVMSM5Piq/a
         DYQp7jfp4/kZE8sMj6tKe9aXUtJrQQcqNod35Dwf3M2Av69eY/2NOT2TBaIMiirWX3td
         Ehpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fis0V9TQ3Gy1MWJNmSG7X3X5UQIdDNJ+tzyb9aUb4pc=;
        b=P/ve37mk/R3w7UGfFAjHxCJL2eqwP4Z08TkOCeLxmpjgFPak9g8k0KWC0h/iQ1GqYN
         K/nR3NXVToygaqr+/qVYjh3DCIYZihtVxNzcQ6IPEe3yAdlavZMEzhhqgGm0pOoFMqY/
         dho6Mohl5E/8GGpyW1faV2Ry2DjLpjN2q6uUKrIJLKA8xxGVWLyW+0IJUVxYqfE58YUe
         M+olAM7i6MfCTtO9iWabNpnCtMiKHJdQaSdzZOWBqytaGcDKy8tVeZhzpulJzH/QO5JX
         BRvoIH4pszKRSXaec4x9Bq2rMlxxSBo7K4heb1o7AF7VPkRPMvi56FPOeFfhVeSUqkRQ
         vBLA==
X-Gm-Message-State: AOAM533Nx+N5lfVSsjl/QdR7PkBQCReWnpAwLkW49qL6t79v+vJ3AmZT
        629EP5pgsyru2N+eycv8Py5RtqzcYJk=
X-Google-Smtp-Source: ABdhPJyAhBR0F7D1K8ajN6slPowiVHJF6bAC57d6voseQCTX4f4XJDgj9mIPZPDOvOsbgroN1UyXiQ==
X-Received: by 2002:adf:eac6:: with SMTP id o6mr8934015wrn.117.1602152028860;
        Thu, 08 Oct 2020 03:13:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm5453177wrw.37.2020.10.08.03.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 03:13:48 -0700 (PDT)
Message-Id: <pull.743.v2.git.1602152027.gitgitgadget@gmail.com>
In-Reply-To: <pull.743.git.1601888196.gitgitgadget@gmail.com>
References: <pull.743.git.1601888196.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Oct 2020 10:13:45 +0000
Subject: [PATCH v2 0/2] Avoid main as branch name in the test suite
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for changing the default branch name to main, let's stop
using it as non-default branch name in the test suite.

This is the last preparatory step before the patch series that intends to
change the default branch name to main. See 
https://github.com/gitgitgadget/git/pull/655 for the entire game plan.

Changes since v1:

 * The commit message of the t1415 patch elaborates a but more about the
   rationale for the change.
 * Instead of primary, the second patch renames all of those branches to 
   topic, imitating b6211b89eb3 (tests: avoid variations of the master 
   branch name, 2020-09-26).

Johannes Schindelin (2):
  t1415: avoid using `main` as ref name
  tests: avoid using the branch name `main`

 t/t1415-worktree-refs.sh     | 18 +++++++++---------
 t/t6012-rev-list-simplify.sh |  8 ++++----
 t/t6400-merge-df.sh          |  8 ++++----
 t/t6409-merge-subtree.sh     | 12 ++++++------
 t/t6430-merge-recursive.sh   |  4 ++--
 5 files changed, 25 insertions(+), 25 deletions(-)


base-commit: 306ee63a703ad67c54ba1209dc11dd9ea500dc1f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-743%2Fdscho%2Favoid-main-as-branch-name-in-tests-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-743/dscho/avoid-main-as-branch-name-in-tests-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/743

Range-diff vs v1:

 1:  d3f7b39a2f ! 1:  2c6f41f9ad t1415: avoid using `main` as ref name
     @@ Commit message
          `init.defaultBranch` to `main`, let's not use `main` as ref name in this
          test script.
      
     -    Since we already use the name "second" for a secondary worktree that is
     -    created in this test, let's use the name "first" for those refs instead.
     +    Otherwise, the `git for-each-ref ... | grep main` which wants to catch
     +    those refs would also unexpectedly catch `refs/heads/main`.
      
     -    While at it, adjust the test titles where "repo" was used by mistake
     -    instead of the term "worktree".
     +    Since the refs in question are worktree-local ones (i.e. each worktree
     +    has their own, just like `HEAD`), and since the test case already uses a
     +    secondary worktree called "second", let's use the name "first" for those
     +    refs instead.
     +
     +    While at it, adjust the test titles that talk about a "repo" when they
     +    meant a "worktree" instead.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
 2:  6045ceb938 ! 2:  b187571778 tests: avoid using the branch name `main`
     @@ Commit message
      
          In the near future, we want to change Git's default branch name to
          `main`. In preparation for that, stop using it as a branch name in the
     -    test suite. Replace that branch name by `primary`.
     +    test suite. Replace that branch name by `topic`, the same name we used
     +    to rename variations of `master` in b6211b89eb3 (tests: avoid variations
     +    of the `master` branch name, 2020-09-26).
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ t/t6012-rev-list-simplify.sh: test_expect_success '--full-diff is not affected b
       	rm -rf .git * &&
       	git init &&
      -	git switch -c main &&
     -+	git switch -c primary &&
     ++	git switch -c topic &&
       
       	echo base >file &&
       	git add file &&
     @@ t/t6012-rev-list-simplify.sh: test_expect_success 'rebuild repo' '
       	test_commit B &&
       
      -	git switch main &&
     -+	git switch primary &&
     ++	git switch topic &&
       	test_must_fail git merge -m "M" B &&
       	echo A >file &&
       	echo B >>file &&
     @@ t/t6012-rev-list-simplify.sh: test_expect_success 'rebuild repo' '
       	note R &&
       
      -	git switch main &&
     -+	git switch primary &&
     ++	git switch topic &&
       	git merge -m N R &&
       	note N &&
       
     @@ t/t6012-rev-list-simplify.sh: test_expect_success 'rebuild repo' '
       	test_commit Z &&
       
      -	git switch main &&
     -+	git switch primary &&
     ++	git switch topic &&
       	git merge -m O Z &&
       	note O &&
       
     @@ t/t6400-merge-df.sh: test_expect_success 'Simple merge in repo with interesting
       		git commit -m initial &&
       
      -		git branch main &&
     -+		git branch primary &&
     ++		git branch topic &&
       		git branch other &&
       
       		git checkout other &&
     @@ t/t6400-merge-df.sh: test_expect_success 'Simple merge in repo with interesting
       
      -		git checkout main &&
      -		echo main >foo/bar/baz &&
     -+		git checkout primary &&
     -+		echo primary >foo/bar/baz &&
     ++		git checkout topic &&
     ++		echo topic >foo/bar/baz &&
       		git add -u &&
      -		git commit -m main &&
     -+		git commit -m primary &&
     ++		git commit -m topic &&
       
       		git merge other &&
       		git ls-files -s >out &&
     @@ t/t6409-merge-subtree.sh: test_expect_success 'setup branch sub' '
       
      -test_expect_success 'setup branch main' '
      -	git checkout -b main master &&
     -+test_expect_success 'setup branch primary' '
     -+	git checkout -b primary master &&
     ++test_expect_success 'setup topic branch' '
     ++	git checkout -b topic master &&
       	git merge -s ours --no-commit --allow-unrelated-histories sub &&
       	git read-tree --prefix=dir/ -u sub &&
      -	git commit -m "initial merge of sub into main" &&
     -+	git commit -m "initial merge of sub into primary" &&
     ++	git commit -m "initial merge of sub into topic" &&
       	test_path_is_file dir/foo.t &&
       	test_path_is_file hello
       '
     @@ t/t6409-merge-subtree.sh: test_expect_success 'update branch sub' '
      -test_expect_success 'update branch main' '
      -	git checkout main &&
      -	git merge -s subtree sub -m "second merge of sub into main" &&
     -+test_expect_success 'update branch primary' '
     -+	git checkout primary &&
     -+	git merge -s subtree sub -m "second merge of sub into primary" &&
     ++test_expect_success 'update topic branch' '
     ++	git checkout topic &&
     ++	git merge -s subtree sub -m "second merge of sub into topic" &&
       	test_path_is_file dir/bar.t &&
       	test_path_is_file dir/foo.t &&
       	test_path_is_file hello
     @@ t/t6430-merge-recursive.sh: test_expect_failure 'merge-recursive rename vs. rena
       test_expect_success 'merging with triple rename across D/F conflict' '
       	git reset --hard HEAD &&
      -	git checkout -b main &&
     -+	git checkout -b primary &&
     ++	git checkout -b topic &&
       	git rm -rf . &&
       
       	echo "just a file" >sub1 &&
     @@ t/t6430-merge-recursive.sh: test_expect_success 'merging with triple rename acro
       	git commit -a -m changesimplefile &&
       
      -	git checkout main &&
     -+	git checkout primary &&
     ++	git checkout topic &&
       	git rm sub1 &&
       	git mv sub2 sub1 &&
       	test_tick &&

-- 
gitgitgadget
