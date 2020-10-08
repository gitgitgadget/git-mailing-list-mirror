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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F7AC4363A
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 15:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4336B21974
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 15:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLq9MRCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgJHP3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 11:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbgJHP3j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 11:29:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924B7C061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 08:29:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so7081981wrp.8
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 08:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zJ7Qmj2XmifAxCrwAA3eqqw5nYpJXGAwyOkpq7JTGoY=;
        b=LLq9MRCXoWtQf8VnbB3bYT4ez5hDp0zTJnginbpNRB5F/w1I7LyCBZAr6Z+EXigjLr
         t+n29BnjogC5wfaZzpjmavv+5ZQQk56ghDlSej+C/eMaKp2YIg/5p1/rabQWu4PKIZPm
         Y/iUrrERQMJx/YkWBkqsixTx+L/MDQlSA/+WUATPmo2d2Nn7Cu/z5UuiH1mvVs9OEjGc
         PnA678sPy0HtfjcguUpT4Nqr2SY3pIf/y65q9HajRM51PpU/l3ZVAESHyYRQF151VVY6
         NLDLs3QfLl9LMbt7s+ujF/QbtOGpTFzjyqzDUmBktWfHlbfJ8w+7GaLrsYDpNHOm4fOE
         QTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zJ7Qmj2XmifAxCrwAA3eqqw5nYpJXGAwyOkpq7JTGoY=;
        b=pNDwpRRhTYicphFNt2zVkD4HsAAVDyAsByYUYmUsl0eiYLHV4g99a7LuIFUCzOAbpD
         LHnlVkU1AHkPn8UYceh1NizrR+DD9ztQkk7DlO9xMH9uZnSaqtiJLvCqnlRw3nLbbgm6
         3qSFFYquDlwFdbPwx/9xypdG2TlrsZ+RpJwAjkn9LMBEYNZoCgtb6OJwgYPCsC0AqUE5
         4HD/CAq6WwVUiHNxDZy3uvQ2Z0xk7xJFTd4vHRlSyiJZqWZyVEgMureWA04abdo25Wpy
         H/GcdGiP5gvcntU1nFc6omJRdKLrpTPIjF9+dcl3r7an8uU683gNQBtQOl7uGRdnidcw
         zWHw==
X-Gm-Message-State: AOAM530kcZA7FupJpcsd8sPDE9Li/DScNkQjOgQwamkN7YPe/TOpzaWz
        k03twWzvqWESO0t5H0BrO4qsIIhy27M=
X-Google-Smtp-Source: ABdhPJyKjZth80uVBcCPhgHyUxW0+kcEvwf89+TX3jOK/3P3RwLwdPmvfyp6CKPt/haMdjIWRTAvEA==
X-Received: by 2002:a05:6000:10cd:: with SMTP id b13mr6421943wrx.4.1602170977689;
        Thu, 08 Oct 2020 08:29:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2sm7799813wrw.40.2020.10.08.08.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 08:29:37 -0700 (PDT)
Message-Id: <pull.619.v2.git.1602170976.gitgitgadget@gmail.com>
In-Reply-To: <pull.619.git.1587748660308.gitgitgadget@gmail.com>
References: <pull.619.git.1587748660308.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 08 Oct 2020 15:29:33 +0000
Subject: [PATCH v2 0/2] Do not skip tagged revisions in the GitHub workflow runs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whenever a GitGitGadget Pull Request is sent to the Git mailing list, a tag
is pushed to gitgitgadget/git to commemorate that iteration.

The push event caused for that triggers the CI/PR workflow, and reveals a
pretty old bug where the windows-build steps are skipped for tagged
revisions, but the windows-test steps are not (and will therefore fail).

That means, of course, that every GitGitGadget PR is marked with a failed
test once it is submitted.

This patch series is designed to address this issue, and is based on 
am/ci-wsfix (the initial round was based on 
dd/ci-swap-azure-pipelines-with-github-actions but would now cause merge
conflicts).

Changes since v1:

 * Rather than returning early from skip_branch_tip_with_tag(), we now skip
   the function call altogether when run in a GitHub workflow.
 * The intention of the tag skipping was replicated by introducing another
   check in ci-config: is there a successful workflow run for the same
   commit (or at least for the same tree)? If yes, skip, referring to that
   successful run.

Johannes Schindelin (2):
  ci: skip GitHub workflow runs for already-tested commits/trees
  ci: do not skip tagged revisions in GitHub workflows

 .github/workflows/main.yml | 39 +++++++++++++++++++++++++++++++++++++-
 ci/lib.sh                  |  2 ++
 2 files changed, 40 insertions(+), 1 deletion(-)


base-commit: 055747cd75c0904cc8122e5c12bd45e9f4743c30
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-619%2Fdscho%2Fgithub-workflows-and-tags-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-619/dscho/github-workflows-and-tags-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/619

Range-diff vs v1:

 -:  ---------- > 1:  914868d558 ci: skip GitHub workflow runs for already-tested commits/trees
 1:  d9823f82ee ! 2:  931a2b8482 ci: fix GitHub workflow when on a tagged revision
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    ci: fix GitHub workflow when on a tagged revision
     +    ci: do not skip tagged revisions in GitHub workflows
      
          When `master` is tagged, and then both `master` and the tag are pushed,
          Travis CI will happily build both. That is a waste of energy, which is
          why we skip the build for `master` in that case.
      
     -    However, our GitHub workflow does not trigger on tags, therefore, this
     -    logic results in a missing build for that revision.
     +    Our GitHub workflow is also triggered by tags. However, the run would
     +    fail because the `windows-test` jobs are _not_ skipped on tags, but the
     +    `windows-build` job _is skipped (and therefore fails to upload the
     +    build artifacts needed by the test jobs).
      
     -    Even worse: the run would _fail_ because we would skip the Windows
     -    build, there are no artifacts to publish, and therefore no artifacts to
     -    download in the Windows test jobs.
     +    In addition, we just added logic to our GitHub workflow that will skip
     +    runs altogether if there is already a successful run for the same commit
     +    or at least for the same tree.
      
     -    Let's just change the GitHub workflow to skip the logic to skip
     -    revisions that are tagged.
     +    Let's just change the GitHub workflow to no longer specifically skip
     +    tagged revisions.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## ci/lib.sh ##
     -@@
     - # Library of functions shared by all CI scripts
     - 
     - skip_branch_tip_with_tag () {
     -+	test -z "$DONT_SKIP_TAGS" || return 0
     - 	# Sometimes, a branch is pushed at the same time the tag that points
     - 	# at the same commit as the tip of the branch is pushed, and building
     - 	# both at the same time is a waste.
      @@ ci/lib.sh: then
     + 	CI_REPO_SLUG="$GITHUB_REPOSITORY"
     + 	CI_JOB_ID="$GITHUB_RUN_ID"
       	CC="${CC:-gcc}"
     ++	DONT_SKIP_TAGS=t
       
       	cache_dir="$HOME/none"
     -+	DONT_SKIP_TAGS=t
       
     - 	export GIT_PROVE_OPTS="--timer --jobs 10"
     - 	export GIT_TEST_OPTS="--verbose-log -x"
     +@@ ci/lib.sh: good_trees_file="$cache_dir/good-trees"
     + 
     + mkdir -p "$cache_dir"
     + 
     ++test -n "${DONT_SKIP_TAGS-}" ||
     + skip_branch_tip_with_tag
     + skip_good_tree
     + 

-- 
gitgitgadget
