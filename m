Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B987C56202
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE56206D8
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3GLSUh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgKWXUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgKWXUM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 18:20:12 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A719CC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:20:10 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 64so7066952wra.11
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FWKZwEjASgfxCz9yKUDL4081d1NiQRF3RhPKSvngsbM=;
        b=q3GLSUh5H9KmIi0moM5psYRot6GP24/No3Q2oo8vEmxB0FmT6Zc4VAzhkGuKHFlEZx
         s0Fz39bybPAC1cP7H36pTwkDf9f0OTXp9Ai5iE12PiwuK2zgQgqCqDhHT7opspEIJf/M
         JEorvmza+gBe4L5O/P2zJjwy7Ux31B8vdb7Jd+xhpdF2LhMN4tYYV00XvzYNSuuP54Th
         bbbZw4Em7VywUM9YHCulGhS1Egx2NlKbkyJ7f40nqJyl/D/7JGVTnW2F++MAJZbQpB3C
         l7OXDk5SICO8oO+YuTzMEERyI3MMGSsC/JZ4KP0eZw1FciIF3j907vzWVkKabi86n6t4
         kS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FWKZwEjASgfxCz9yKUDL4081d1NiQRF3RhPKSvngsbM=;
        b=ksdOkAdlCutUhs19r8RPkMZzcMM8aNvMvH+PosU0Oa1p81nhjJz9Vi5Ut7EQ7R5Kej
         2F3MzYPKGucRc8KLe50qb/TZh5n2qELHcCILGH/EBewP/4y26p0kOBXK/jZXLjkw0YoM
         vAdHvvLcHettJQpyk4YBTein64ek+pf0+t4HZ3RZjhQQygZSJam7OS+StS2XKpRhkuNv
         QllpJpOBfN27L5Gl1LkmU37xemHBnpmwvOUNtUlXuCmZlaTNw7r7tsiRo+SMM9SOZY2n
         VMEwfUvQubQnes+p/gtY59PRLgRvNi+joIdqtO68JaayZoaY6FKWCXLXrqrqyb8OCK5n
         kbmA==
X-Gm-Message-State: AOAM530cwG3d5neFMPdNuCW6TZ73lINzZAslw4m3nSQAGVAkshIySDNu
        1YX4rrvuRHfTHJSvOEbmk3/V46LYxtk=
X-Google-Smtp-Source: ABdhPJwf3P0FGR6G0OycWisIksOfpgRyb9mqEaEl+k1y5B1nlMO/zt4kWHpN+C190ABeK/Ey2xRuOQ==
X-Received: by 2002:adf:fc49:: with SMTP id e9mr1989522wrs.31.1606173608887;
        Mon, 23 Nov 2020 15:20:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u81sm1553870wmb.27.2020.11.23.15.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 15:20:08 -0800 (PST)
Message-Id: <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 23:20:03 +0000
Subject: [PATCH v2 0/4] Add helpful advice about init.defaultBranch
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
 builtin/branch.c           |  3 ++-
 builtin/clone.c            |  2 +-
 builtin/init-db.c          |  8 +++++---
 refs.c                     | 25 +++++++++++++++++++++----
 refs.h                     |  4 ++--
 remote.c                   |  5 +++--
 t/t0001-init.sh            | 15 ++++++++++++++-
 t/t1510-repo-setup.sh      |  2 +-
 t/test-lib-functions.sh    |  3 ++-
 10 files changed, 58 insertions(+), 20 deletions(-)


base-commit: faefdd61ec7c7f6f3c8c9907891465ac9a2a1475
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-921%2Fdscho%2Finit.defaultBranch-advice-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-921/dscho/init.defaultBranch-advice-v2
Pull-Request: https://github.com/git/git/pull/921

Range-diff vs v1:

 1:  1518387eaa ! 1:  483e490349 init: document `init.defaultBranch` better
     @@ Documentation/git-init.txt: If this is reinitialization, the repository will be
      -If not specified, fall back to the default name: `master`.
      +Use the specified name for the initial branch in the newly created
      +repository.  If not specified, fall back to the default name (currently
     -+`master`, but that will be changed in the future; The name can be customized
     ++`master`, but that will be changed in the future; the name can be customized
      +via the `init.defaultBranch` configuration variable).
       
       --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
 -:  ---------- > 2:  8de0c0eb22 branch -m: allow renaming a yet-unborn branch
 2:  42f6940043 = 3:  03314f7ac6 get_default_branch_name(): prepare for showing some advice
 3:  253d6706e6 ! 4:  bccef95391 init: provide useful advice about init.defaultBranch
     @@ Metadata
       ## Commit message ##
          init: provide useful advice about init.defaultBranch
      
     -    To give ample warning in case we decide to change the fall-back for an
     -    unconfigured `init.defaultBranch`, let's introduce some advice that is
     -    shown upon `git init` when that value is not set.
     +    To give ample warning for users wishing to override Git's the fall-back
     +    for an unconfigured `init.defaultBranch` (in case we decide to change it
     +    in a future Git version), let's introduce some advice that is shown upon
     +    `git init` when that value is not set.
      
     -    Note: three test cases in Git's test suite want to verify that the
     +    Note: two test cases in Git's test suite want to verify that the
          `stderr` output of `git init` is empty. With this patch, that is only
          true if `init.defaultBranch` is configured, so let's do exactly that in
          those test cases. The same reasoning applies to `test_create_repo()`.
     @@ refs.c: void expand_ref_prefix(struct strvec *prefixes, const char *prefix)
       }
       
      +static const char default_branch_name_advice[] = N_(
     -+"Using '%s' as the name for the initial branch. This name is subject\n"
     -+"to change. To configure the name to use as the initial branch name in\n"
     -+"new repositories, or to silence this warning, run:\n"
     ++"Using '%s' as the name for the initial branch. This default branch name\n"
     ++"is subject to change. To configure the initial branch name to use in all\n"
     ++"of your new repositories, run:\n"
      +"\n"
      +"\tgit config --global init.defaultBranch <name>\n"
     ++"\n"
     ++"Common names are 'main', 'trunk' and 'development'. If you merely wish\n"
     ++"to suppress this warning, you can also use the current default branch\n"
     ++"name. The current branch can be renamed via this command:\n"
     ++"\n"
     ++"\tgit branch -m <name>\n"
      +);
      +
       char *repo_default_branch_name(struct repository *r, int quiet)
     @@ t/t1510-repo-setup.sh: setup_repo () {
       	maybe_config "$name/.git/config" core.bare "$barecfg" &&
       	mkdir -p "$name/sub/sub" &&
      
     - ## t/t7414-submodule-mistakes.sh ##
     -@@ t/t7414-submodule-mistakes.sh: test_expect_success 'no warning when updating entry' '
     - 
     - test_expect_success 'submodule add does not warn' '
     - 	test_when_finished "git rm -rf submodule .gitmodules" &&
     --	git submodule add ./embed submodule 2>stderr &&
     -+	git -c init.defaultBranch=x submodule add ./embed submodule 2>stderr &&
     - 	test_i18ngrep ! warning stderr
     - '
     - 
     -
       ## t/test-lib-functions.sh ##
      @@ t/test-lib-functions.sh: test_create_repo () {
       	mkdir -p "$repo"
     @@ t/test-lib-functions.sh: test_create_repo () {
       		cd "$repo" || error "Cannot setup test environment"
      -		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" init \
      +		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
     -+			-c init.defaultBranch=master init \
     ++			-c init.defaultBranch=${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master} init \
       			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
       		error "cannot run git init -- have you built things yet?"
       		mv .git/hooks .git/hooks-disabled

-- 
gitgitgadget
