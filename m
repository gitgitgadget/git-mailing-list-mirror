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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED85C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B7223DE3
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 11:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390721AbgLKLjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 06:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403796AbgLKLhl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 06:37:41 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D94C0613D6
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 03:37:00 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 91so8680819wrj.7
        for <git@vger.kernel.org>; Fri, 11 Dec 2020 03:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fMsyYzsbekTf5ebmZ2j4JT6KO/zqrMIjKtn19NwO5JY=;
        b=N5DymG97oww5ezi7BrxwZd2AXxwaxlKCjPxt10OVcy2JirbCAtHCL/OVwk39vT+hr7
         S7k182wtwPSbptJ4t4FM1+AFHk8stUTmicYgs6s5uHf/eCQRSofcClVUjFCgCubFWf7G
         Cti02EpAPvxzoPxdI8VBemNV7eBXdYPJujvLL8X25BD1DarKstk1wz/IfCmZzzw9S8ee
         ViH3azjlYnDZuzGrGG1zEhIbJmQc4DG63lB5L7RPYUZp8lSWbFkhncbgKtLNoCAj8A9r
         pqNgzAVqtLjUnesZaapN4Hy0Vm/I6lE5hs6ptVcxSbK8YKa62NhjH5f8zn1a/L3RKKyP
         aeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fMsyYzsbekTf5ebmZ2j4JT6KO/zqrMIjKtn19NwO5JY=;
        b=G53gaa5JMD1WF8ml8ijje3+ByyqrxXmsqNwf7b/UvzaGvGXItDLfnu8a2A9p/i/rNA
         8dRnNwX7MwlEVCdBZR95rSoABEvb8+jp0CZqwxDyhMiNVOXriRz2NEYDZxEJbwL8tdLW
         nM98hzKyXSR1zeRWcrIOaWZBQu2ocClU4qSVz445rFsag8BpBT6sxkk7I+rrdzM1PPzC
         S0Bcp/9weO4G12CoU/5d3xIZieLmcWsxVNgR3Ohr/whZRMmEa0x/Fi5setHq1Hx4fktU
         mqfZ2QZEqP3+5ezQ4BhMWuMZsTTFxPoZ7bIPW2qD8cONtMOh01bdbzqqXF1fp6L6bhuk
         DcWQ==
X-Gm-Message-State: AOAM531r0GZO4b1OiNtw9RwNpF/5KLnZ0XLYPUJHBa4FOopQFd5jCDhw
        uxYPIHnx6YWFiSp8LisCmt/OsF/P0XQ=
X-Google-Smtp-Source: ABdhPJyt7hu1Jdrr5iPel8uQWE/NsIiyOTrofulGbyfhOpvPdluoqu8DfIBwjyXMtTYOZQSqoxgC/w==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr13205487wrw.62.1607686619292;
        Fri, 11 Dec 2020 03:36:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7sm13686100wma.26.2020.12.11.03.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 03:36:58 -0800 (PST)
Message-Id: <pull.921.v5.git.git.1607686618.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
References: <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Dec 2020 11:36:53 +0000
Subject: [PATCH v5 0/4] Add helpful advice about init.defaultBranch
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

Changes since v4:

 * Reworded the documentation to weaken the "will be changed in the future"
   to "is subject to change".
 * Reworded the advice to explicitly mention "instead of 'master'".

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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-921%2Fdscho%2Finit.defaultBranch-advice-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-921/dscho/init.defaultBranch-advice-v5
Pull-Request: https://github.com/git/git/pull/921

Range-diff vs v4:

 1:  483e4903491 ! 1:  ce35cf3da65 init: document `init.defaultBranch` better
     @@ Documentation/git-init.txt: If this is reinitialization, the repository will be
      -If not specified, fall back to the default name: `master`.
      +Use the specified name for the initial branch in the newly created
      +repository.  If not specified, fall back to the default name (currently
     -+`master`, but that will be changed in the future; the name can be customized
     -+via the `init.defaultBranch` configuration variable).
     ++`master`, but this is subject to change in the future; the name can be
     ++customized via the `init.defaultBranch` configuration variable).
       
       --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
       
 2:  6cbd6692c6a = 2:  ac7b352a0ba branch -m: allow renaming a yet-unborn branch
 3:  5fc15f7b9ad = 3:  aba72340c87 get_default_branch_name(): prepare for showing some advice
 4:  2f21c505d56 ! 4:  ce26446b1a2 init: provide useful advice about init.defaultBranch
     @@ refs.c: void expand_ref_prefix(struct strvec *prefixes, const char *prefix)
      +"\n"
      +"\tgit config --global init.defaultBranch <name>\n"
      +"\n"
     -+"Common names are 'main', 'trunk' and 'development'. The initial branch\n"
     -+"that was created can be renamed via this command:\n"
     ++"Names commonly chosen instead of 'master' are 'main', 'trunk' and\n"
     ++"'development'. The just-created branch can be renamed via this command:\n"
      +"\n"
      +"\tgit branch -m <name>\n"
      +);

-- 
gitgitgadget
