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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928ACC4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 22:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49CF923CD0
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 22:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404694AbgLJWzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 17:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393636AbgLJWzF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 17:55:05 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F167DC0611CE
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 14:38:48 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w206so3603881wma.0
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 14:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Puiz8JAxFUKu7fQLZ7O8QFd7NXtmmE90p+wFbSDkGOw=;
        b=dxfzYGAaw4cCiobRgoVbfiK0BVAJ8kJKU/RpQYOCiKUqMPF0ay8RJOATANsplemwpU
         2mqwNUB8badM+j4FQSfTCaKYK37KvLXKP+0+MhnoqsXWSxlsOTAE2jywxO1A9ajKKQBU
         Rr2MoDtTebtsPdpyoIoPVmoDEl13Hwhd5iFVKRX0W13diGm44TKw9tTECZ4nPzouN9lE
         96XkNxl9+vvoeXXyPI9TL+CjRoSta0V/oKhhLCHKbW6osbr9FgXJdAinENl+TqDrsjT2
         4SlfFHyZIG9vHeydhrD+LMknGEGGx6GCunGZWLAQ5NeGIWqVUjXAXEBn/dIXGBHqt56h
         h7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Puiz8JAxFUKu7fQLZ7O8QFd7NXtmmE90p+wFbSDkGOw=;
        b=Mdrq+vDOZNHMxniLosIC4IhsfJQeBdnqLtDI6ceCk/qGZ5Fyis6ykPvEwuCS7HE/9l
         U9Dao4JiEP0lDNf7UTPM9wHUW4wPLHOFZnKlMfZNh+H6SHbjxGLwHh/ojAWkC/2CQf+4
         LE2L4roOXi4Osl8zXHli0a8s7AMPUlNsESplBgCkXec5Ont6onjCDzTv1sd/3Ma1Ue6w
         9qEpOMLNfWMeFUL54QOpibRwDc21R05/LRc5pBVnTxUAWIFkc+HlwlUBygqkXXVGwqL3
         J6UJoOMxHyfgaLJkqsEvAJ4K99oncJg+v+NNUfS3B3DABvdv9P6mmeZJZMOE5z8Cpjln
         d2ng==
X-Gm-Message-State: AOAM5330gcXdvo4cQ4avXA+jEuoDMlKH4auhArtik+b8p4M7sq7xR12W
        1Y6TNm6cjh0X3IjBXPbAaPa+/2tRDZk=
X-Google-Smtp-Source: ABdhPJy4lONEtHa4PBeqWGyTFLnS4/hMMOIfBeDIhFZE0wmycSY/FszvwLuiL9d2G6bqQTObfXg8xg==
X-Received: by 2002:a05:600c:313:: with SMTP id q19mr10256184wmd.126.1607637518704;
        Thu, 10 Dec 2020 13:58:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4sm11118247wrr.30.2020.12.10.13.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 13:58:37 -0800 (PST)
Message-Id: <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
References: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Dec 2020 21:58:32 +0000
Subject: [PATCH v4 0/4] Add helpful advice about init.defaultBranch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is our designated intention
[https://sfconservancy.org/news/2020/jun/23/gitbranchname/] to "to explore
changing the name of the first branch created automatically for new
repositories away from ‘master’". Further, we promised that we "will
minimize disruption for Git's users and will include appropriate deprecation
periods".

To that end, we first clarify git init's documentation (a lightly edited
version of Junio's patch
[https://lore.kernel.org/git/xmqqd00a36wc.fsf@gitster.c.googlers.com]), and
then introduce a message giving advice to users running git init that the
fall-back for init.defaultBranch is subject to change, and how to override
Git's fall-back manually.

The beauty of this patch series, if I may say so, is that it does not commit
us to any concrete plan, but opens the door for all options regarding the
default branch name.

Changes since v3:

 * Kicked out advice.defaultBranchName again. The advice can now only be
   suppressed by setting init.defaultBranch.

Changes since v2:

 * git branch -m <initial> <renamed> now works, too
 * The config setting advice.defaultBranchName was introduced to allow
   suppressing this warning specifically
 * The advice now first talks about the current default branch name, then
   how to suppress the advice, and only then explains how to override the
   default branch name (and that that will also prevent the message from
   being shown)

Changes since v1:

 * Grammar fix
 * Reworded advice and commit messages
 * test_create_repo already respected GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME,
   but now does so more obviously
 * Allowed git branch -m <name> to rename unborn branches, so that the
   advice actually works

Johannes Schindelin (4):
  init: document `init.defaultBranch` better
  branch -m: allow renaming a yet-unborn branch
  get_default_branch_name(): prepare for showing some advice
  init: provide useful advice about init.defaultBranch

 Documentation/git-init.txt | 11 +++++++----
 builtin/branch.c           |  4 +++-
 builtin/clone.c            |  2 +-
 builtin/init-db.c          |  8 +++++---
 refs.c                     | 24 ++++++++++++++++++++----
 refs.h                     |  4 ++--
 remote.c                   |  5 +++--
 t/t0001-init.sh            | 17 ++++++++++++++++-
 t/t1510-repo-setup.sh      |  2 +-
 t/test-lib-functions.sh    |  4 +++-
 10 files changed, 61 insertions(+), 20 deletions(-)


base-commit: faefdd61ec7c7f6f3c8c9907891465ac9a2a1475
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-921%2Fdscho%2Finit.defaultBranch-advice-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-921/dscho/init.defaultBranch-advice-v4
Pull-Request: https://github.com/git/git/pull/921

Range-diff vs v3:

 1:  483e4903491 = 1:  483e4903491 init: document `init.defaultBranch` better
 2:  6cbd6692c6a = 2:  6cbd6692c6a branch -m: allow renaming a yet-unborn branch
 3:  5fc15f7b9ad = 3:  5fc15f7b9ad get_default_branch_name(): prepare for showing some advice
 4:  87c93068771 ! 4:  2f21c505d56 init: provide useful advice about init.defaultBranch
     @@ Commit message
      
          Note: two test cases in Git's test suite want to verify that the
          `stderr` output of `git init` is empty. It is now necessary to suppress
     -    the advice using the newly-added `advice.defaultBranchName` setting.
     -    While not strictly necessary, we also set this to `false` in
     +    the advice, we now do that via the `init.defaultBranch` setting. While
     +    not strictly necessary, we also set this to `false` in
          `test_create_repo()`.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     - ## advice.c ##
     -@@ advice.c: static struct {
     - 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
     - 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
     - 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
     -+	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName", 1 },
     - 	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
     - 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates", 1 },
     - 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated", 1 },
     -
     - ## advice.h ##
     -@@ advice.h: extern int advice_add_empty_pathspec;
     - 	ADVICE_AM_WORK_DIR,
     - 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
     - 	ADVICE_COMMIT_BEFORE_MERGE,
     -+	ADVICE_DEFAULT_BRANCH_NAME,
     - 	ADVICE_DETACHED_HEAD,
     - 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
     - 	ADVICE_GRAFT_FILE_DEPRECATED,
     -
       ## refs.c ##
     -@@
     - #include "strvec.h"
     - #include "repository.h"
     - #include "sigchain.h"
     -+#include "advice.h"
     - 
     - /*
     -  * List of all available backends
      @@ refs.c: void expand_ref_prefix(struct strvec *prefixes, const char *prefix)
       		strvec_pushf(prefixes, *p, len, prefix);
       }
       
      +static const char default_branch_name_advice[] = N_(
      +"Using '%s' as the name for the initial branch. This default branch name\n"
     -+"is subject to change. To suppress this warning, run:\n"
     -+"\n"
     -+"\tgit config --global advice.defaultBranchName false\n"
     -+"\n"
     -+"Alternatively, you can configure the initial branch name to use in all\n"
     -+"of your new repositories, which will also suppress this warning:\n"
     ++"is subject to change. To configure the initial branch name to use in all\n"
     ++"of your new repositories, which will suppress this warning, call:\n"
      +"\n"
      +"\tgit config --global init.defaultBranch <name>\n"
      +"\n"
     @@ refs.c: char *repo_default_branch_name(struct repository *r, int quiet)
      -	if (!ret)
      +	if (!ret) {
       		ret = xstrdup("master");
     -+		if (!quiet && advice_enabled(ADVICE_DEFAULT_BRANCH_NAME))
     ++		if (!quiet)
      +			advise(_(default_branch_name_advice), ret);
      +	}
       
     @@ t/t0001-init.sh: test_expect_success 'reinit' '
       		mkdir again &&
       		cd again &&
      -		git init >out1 2>err1 &&
     -+		git -c advice.defaultBranchName=false init >out1 2>err1 &&
     ++		git -c init.defaultBranch=initial init >out1 2>err1 &&
       		git init >out2 2>err2
       	) &&
       	test_i18ngrep "Initialized empty" again/out1 &&
     @@ t/t1510-repo-setup.sh: setup_repo () {
       	sane_unset GIT_DIR GIT_WORK_TREE &&
       
      -	git init "$name" &&
     -+	git -c advice.defaultBranchName=false init "$name" &&
     ++	git -c init.defaultBranch=initial init "$name" &&
       	maybe_config "$name/.git/config" core.worktree "$worktreecfg" &&
       	maybe_config "$name/.git/config" core.bare "$barecfg" &&
       	mkdir -p "$name/sub/sub" &&
     @@ t/test-lib-functions.sh: test_create_repo () {
       	(
       		cd "$repo" || error "Cannot setup test environment"
      -		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
     -+		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
     -+			-c advice.defaultBranchName=false init \
     ++		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" -c \
     ++			init.defaultBranch="${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}" \
     ++			init \
       			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
       		error "cannot run git init -- have you built things yet?"
       		mv .git/hooks .git/hooks-disabled

-- 
gitgitgadget
