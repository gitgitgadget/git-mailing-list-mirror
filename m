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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AF3C63798
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 15:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F3F20715
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 15:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URxoJyb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389582AbgKXPHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 10:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389441AbgKXPHe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 10:07:34 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7380CC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 07:07:34 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id h21so3217228wmb.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 07:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GYuQkIQZREkNvz+Szxjw8fncLUuY++AQTUYjUzYsD/I=;
        b=URxoJyb+WZkhfu0DIOAsgv3kSO7mE91hxUfbjl2m/wKlp+VU1mTZKtonP0ZBPy6G+N
         PFAOyVl2oClfCKs69twIoI9xftgERlZhnHz+cSW6wPhx8vRyGGZ7misyEkQuVkRBa9Xb
         trrtpYEGt9tAoElqGrERWyIOFeGoav9MrlX0cMCVbVDxPrd8E+cz+Le+jvufn2NeWgeB
         lYeEsg3tEhWnkDGRRtyj/vMKk9pGiehfW6r7Gpko7vKJlrshBTm46MR031nCbWxauDEN
         yWehbqO+F+QOccKyTvcf+BVakvuXseb/4SjltVLeStJqOrPdH3R7rur1ActCistDLTt2
         MTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GYuQkIQZREkNvz+Szxjw8fncLUuY++AQTUYjUzYsD/I=;
        b=AYK7IhlV0FoCg8dKG9IFb/8E+9XamMNbTGHzIt212ygZX7rwMGhbrGlxfZtpt8okMd
         lJkldQ4U29zA+takmzgW/ClAuIN6/Mzq+olFnmIh2rsJq2hfY9YFeWRMdbb3Ts88NVG1
         P4Bu75Ep8+PSNR/yZ8vdmijW10llnbc6zi/pKs61LP0ZGXJg0hkffCylFvJ6gIiRG4V5
         uzbC1i7xz+DwHQXQ/KbaQX6E5IzOcL5Iy7lPEfBanzFwrGBBHUfwQCcLl+K5XtHHGMTu
         XGVY4WIiIcxwA3djOWTfktqpN1zYWooXgdj+L6A/rzCvL+0gWW0woFDAV3JvYxIVa2iX
         zIMw==
X-Gm-Message-State: AOAM531QzligyCz3Kv+vLlL2/TalRSVA/dxb28JiHJjB/kg8/faWBlVZ
        J0lid19YZgP2y3KwWp21BaC5zDT+2lI=
X-Google-Smtp-Source: ABdhPJwkbtRgw5dhgNRvHtvMJGBhNUjFDypen4MLSO5RaqReGC9emrXSr0aeVwquBUdVHhUNY1YVxw==
X-Received: by 2002:a7b:c255:: with SMTP id b21mr5086423wmj.72.1606230452383;
        Tue, 24 Nov 2020 07:07:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm7630435wrr.89.2020.11.24.07.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 07:07:31 -0800 (PST)
Message-Id: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
References: <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Nov 2020 15:07:25 +0000
Subject: [PATCH v3 0/4] Add helpful advice about init.defaultBranch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
 advice.c                   |  1 +
 advice.h                   |  1 +
 builtin/branch.c           |  4 +++-
 builtin/clone.c            |  2 +-
 builtin/init-db.c          |  8 +++++---
 refs.c                     | 29 +++++++++++++++++++++++++----
 refs.h                     |  4 ++--
 remote.c                   |  5 +++--
 t/t0001-init.sh            | 17 ++++++++++++++++-
 t/t1510-repo-setup.sh      |  2 +-
 t/test-lib-functions.sh    |  3 ++-
 12 files changed, 67 insertions(+), 20 deletions(-)


base-commit: faefdd61ec7c7f6f3c8c9907891465ac9a2a1475
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-921%2Fdscho%2Finit.defaultBranch-advice-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-921/dscho/init.defaultBranch-advice-v3
Pull-Request: https://github.com/git/git/pull/921

Range-diff vs v2:

 1:  483e490349 = 1:  483e490349 init: document `init.defaultBranch` better
 2:  8de0c0eb22 ! 2:  6cbd6692c6 branch -m: allow renaming a yet-unborn branch
     @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
       			    oldref.buf, newref.buf);
       
      -	if (!copy && rename_ref(oldref.buf, newref.buf, logmsg.buf))
     -+	if (!copy && (oldname != head || !is_null_oid(&head_oid)) &&
     ++	if (!copy &&
     ++	    (!head || strcmp(oldname, head) || !is_null_oid(&head_oid)) &&
      +	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
       		die(_("Branch rename failed"));
       	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
     @@ t/t0001-init.sh: test_expect_success 'invalid default branch name' '
       '
       
      +test_expect_success 'branch -m with the initial branch' '
     -+	git init rename-initial-branch &&
     -+	git -C rename-initial-branch branch -m renamed &&
     -+	test renamed = $(git -C rename-initial-branch symbolic-ref --short HEAD)
     ++	git init rename-initial &&
     ++	git -C rename-initial branch -m renamed &&
     ++	test renamed = $(git -C rename-initial symbolic-ref --short HEAD) &&
     ++	git -C rename-initial branch -m renamed again &&
     ++	test again = $(git -C rename-initial symbolic-ref --short HEAD)
      +'
      +
       test_done
 3:  03314f7ac6 = 3:  5fc15f7b9a get_default_branch_name(): prepare for showing some advice
 4:  bccef95391 ! 4:  87c9306877 init: provide useful advice about init.defaultBranch
     @@ Commit message
          `git init` when that value is not set.
      
          Note: two test cases in Git's test suite want to verify that the
     -    `stderr` output of `git init` is empty. With this patch, that is only
     -    true if `init.defaultBranch` is configured, so let's do exactly that in
     -    those test cases. The same reasoning applies to `test_create_repo()`.
     +    `stderr` output of `git init` is empty. It is now necessary to suppress
     +    the advice using the newly-added `advice.defaultBranchName` setting.
     +    While not strictly necessary, we also set this to `false` in
     +    `test_create_repo()`.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     + ## advice.c ##
     +@@ advice.c: static struct {
     + 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
     + 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
     + 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
     ++	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName", 1 },
     + 	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
     + 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates", 1 },
     + 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated", 1 },
     +
     + ## advice.h ##
     +@@ advice.h: extern int advice_add_empty_pathspec;
     + 	ADVICE_AM_WORK_DIR,
     + 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
     + 	ADVICE_COMMIT_BEFORE_MERGE,
     ++	ADVICE_DEFAULT_BRANCH_NAME,
     + 	ADVICE_DETACHED_HEAD,
     + 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
     + 	ADVICE_GRAFT_FILE_DEPRECATED,
     +
       ## refs.c ##
     +@@
     + #include "strvec.h"
     + #include "repository.h"
     + #include "sigchain.h"
     ++#include "advice.h"
     + 
     + /*
     +  * List of all available backends
      @@ refs.c: void expand_ref_prefix(struct strvec *prefixes, const char *prefix)
       		strvec_pushf(prefixes, *p, len, prefix);
       }
       
      +static const char default_branch_name_advice[] = N_(
      +"Using '%s' as the name for the initial branch. This default branch name\n"
     -+"is subject to change. To configure the initial branch name to use in all\n"
     -+"of your new repositories, run:\n"
     ++"is subject to change. To suppress this warning, run:\n"
     ++"\n"
     ++"\tgit config --global advice.defaultBranchName false\n"
     ++"\n"
     ++"Alternatively, you can configure the initial branch name to use in all\n"
     ++"of your new repositories, which will also suppress this warning:\n"
      +"\n"
      +"\tgit config --global init.defaultBranch <name>\n"
      +"\n"
     -+"Common names are 'main', 'trunk' and 'development'. If you merely wish\n"
     -+"to suppress this warning, you can also use the current default branch\n"
     -+"name. The current branch can be renamed via this command:\n"
     ++"Common names are 'main', 'trunk' and 'development'. The initial branch\n"
     ++"that was created can be renamed via this command:\n"
      +"\n"
      +"\tgit branch -m <name>\n"
      +);
     @@ refs.c: char *repo_default_branch_name(struct repository *r, int quiet)
      -	if (!ret)
      +	if (!ret) {
       		ret = xstrdup("master");
     -+		if (!quiet)
     ++		if (!quiet && advice_enabled(ADVICE_DEFAULT_BRANCH_NAME))
      +			advise(_(default_branch_name_advice), ret);
      +	}
       
     @@ t/t0001-init.sh: test_expect_success 'reinit' '
       		mkdir again &&
       		cd again &&
      -		git init >out1 2>err1 &&
     -+		git -c init.defaultBranch=initial init >out1 2>err1 &&
     ++		git -c advice.defaultBranchName=false init >out1 2>err1 &&
       		git init >out2 2>err2
       	) &&
       	test_i18ngrep "Initialized empty" again/out1 &&
     @@ t/t1510-repo-setup.sh: setup_repo () {
       	sane_unset GIT_DIR GIT_WORK_TREE &&
       
      -	git init "$name" &&
     -+	git -c init.defaultBranch=repo init "$name" &&
     ++	git -c advice.defaultBranchName=false init "$name" &&
       	maybe_config "$name/.git/config" core.worktree "$worktreecfg" &&
       	maybe_config "$name/.git/config" core.bare "$barecfg" &&
       	mkdir -p "$name/sub/sub" &&
     @@ t/test-lib-functions.sh: test_create_repo () {
       		cd "$repo" || error "Cannot setup test environment"
      -		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
      +		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
     -+			-c init.defaultBranch=${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master} init \
     ++			-c advice.defaultBranchName=false init \
       			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
       		error "cannot run git init -- have you built things yet?"
       		mv .git/hooks .git/hooks-disabled

-- 
gitgitgadget
