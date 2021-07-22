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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1018C6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 05:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2EA61279
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 05:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhGVEYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 00:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhGVEYT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 00:24:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337CDC061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 22:04:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p15-20020a05600c358fb0290245467f26a4so2194197wmq.0
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 22:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GE8lSS6vIS7EWqa3zalqho+KTIO09B6aoNskiiQj/Zw=;
        b=eKeCZlfN3SiHMdL88H6sC4r1NhRWTSmKdREDco5UiQTWfvd0pEat7hlrZz2yNnQ1nq
         mShcECQF7hmOXaKwJ/TCYoPKxcpZodCHz5Hn3Qprcn4FYUGh2xZWgDUE5RJWQMAKmu/z
         kCgT4M9buLppv78n3cVkm6YBBuD8VfsglgyA8UrsKSEEIXOt2gPWLPyjpVZL5L8+JcxV
         gCajHn5IbfohGpgZ2vs60ZYaz4AgIhphkHtLVpZQ1pMWuqTQv2+bD4XrGyuPC0Q+OaQs
         /cfHnR2gWLmYiQ7S8wBpUOH5fAFOFRRiaQ54zcd1LEKZSBknZP61HDQn40jCcIqFI4lx
         XQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GE8lSS6vIS7EWqa3zalqho+KTIO09B6aoNskiiQj/Zw=;
        b=d6dSITaPj86lw/Zrow5KUrYLad+upj0a88MrHzpJIrOu4hkhw82TGFBZjG1wzKcxjl
         xLNW5/IujNNHAteC0neDJ1/BU27W0pNgvKE0WcFTw+yXDc1djoFVEggHFfK9TmhZ2Jbu
         XqdPJLi2NAjsy5onlk2Z5Ta2VEAOAqZjGE8RAWQiSMJGtG9Cx7O2IHvg2++BR+YmDR4S
         2Fl2SUUfFkPtfuu0KqJ4Z7PJQu9o/zXUjk7qJ7CaKwv9/OpRunzWej7HaFgXTmzZLPQw
         hsnJV+5q3zAussp+Mp9VYXvI/RvbVOdKlckJ56Bp1BkEIdyu5eX9PFTHmwZwAVCU7RXI
         xAMw==
X-Gm-Message-State: AOAM532QlDKzRXAVkZSQRd+ueyvdnQnE6u/To2Lf12TqhS/PUDc2o1iy
        ywuEYIymu5ZogJX3jCyGwzKximCPDU8=
X-Google-Smtp-Source: ABdhPJxlG+Tz5cUNodMOIf+vw5D3PyO/MjRGGnwYsMRI0/brJKpNUUI3OYOG48zSvrEno3jleG7ZYQ==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr7174546wmc.65.1626930291698;
        Wed, 21 Jul 2021 22:04:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o29sm22576084wms.13.2021.07.21.22.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 22:04:51 -0700 (PDT)
Message-Id: <pull.1049.v3.git.git.1626930290.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 05:04:42 +0000
Subject: [PATCH v3 0/8] Handle pull option precedence
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Based on a recent list of rules for flag/option precedence for git-pull[1]
from Junio (particularly focusing on rebase vs. merge vs. fast-forward),
here's an attempt to implement and document it. Given multiple recent
surprises from users about some of these behaviors[2][3] and a coworker just
yesterday expressing some puzzlement with git-pull and rebase vs. merge, it
seems like a good time to address some of these issues.

Since the handling of conflicting options was holding up two of Alex's
patches[4][5], and his patches fix some of the tests, I also include those
two patches in my series, with a few small changes to the first (so I've
kept him as author) and more substantial changes to the second (so I've
given him an Initial-patch-by attribution).

Changes since v2:

 * Remove some unnecessary changes in patch 4, pointed out by Junio.

Changes since v1:

 * Rebased on latest master (resolved a simple conflict with
   dd/test-stdout-count-lines)
 * Patch 1: based on feedback from Junio, fixed some style issues, clarified
   function names, added a few new tests, and took a stab at fixing up the
   comments and test descriptions (but still unsure if I hit the mark on the
   last point)
 * Patch 2: changed the test expectations for one of the multiple head tests
   as per Junio's suggestion, and made one of the other tests expect a more
   specific error message
 * Patches 4 & 5 were squashed and fixed: these now address a submodule bug
   interaction with --ff-only
 * Old patch 6 (now 5): added a code comment explaining a subtle point
 * Old patch 8 (now 7): a few more documentation updates, especially making
   --ff-only not sound merge-specific
 * Old patch 9 (now 8): Updates for new test expectation from patch 2

Quick overview:

 * Patches 1-2: new testcases (see the commit messages for the rules)
 * Patch 3: Alex's recent patch (abort if --ff-only but can't do so)
 * Patches 4-6: fix the precedence parts Alex didn't cover
 * Patch 7: Alex's other patch, abort if rebase vs. merge not specified
 * Patch 8: Compatibility of git-pull with merge-options.txt (think
   rebasing)
 * Patch 9: Fix multiple heads handling too

[1] https://lore.kernel.org/git/xmqqwnpqot4m.fsf@gitster.g/ [2]
https://lore.kernel.org/git/CAL3xRKdOyVWvcLXK7zoXtFPiHBjgL24zi5hhg+3yjowwSUPgmg@mail.gmail.com/
[3]
https://lore.kernel.org/git/c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com/
[4]
https://lore.kernel.org/git/20210711012604.947321-1-alexhenrie24@gmail.com/
[5]
https://lore.kernel.org/git/20210627000855.530985-1-alexhenrie24@gmail.com/

Alex Henrie (1):
  pull: abort if --ff-only is given and fast-forwarding is impossible

Elijah Newren (7):
  t7601: test interaction of merge/rebase/fast-forward flags and options
  t7601: add tests of interactions with multiple merge heads and config
  pull: since --ff-only overrides, handle it first
  pull: make --rebase and --no-rebase override pull.ff=only
  pull: abort by default when fast-forwarding is not possible
  pull: update docs & code for option compatibility with rebasing
  pull: fix handling of multiple heads

 Documentation/git-merge.txt     |   2 +
 Documentation/git-pull.txt      |  21 +--
 Documentation/merge-options.txt |  40 ++++++
 advice.c                        |   5 +
 advice.h                        |   1 +
 builtin/merge.c                 |   2 +-
 builtin/pull.c                  |  55 +++++--
 t/t4013-diff-various.sh         |   2 +-
 t/t5520-pull.sh                 |  20 +--
 t/t5521-pull-options.sh         |   4 +-
 t/t5524-pull-msg.sh             |   4 +-
 t/t5553-set-upstream.sh         |  14 +-
 t/t5604-clone-reference.sh      |   4 +-
 t/t6402-merge-rename.sh         |  18 +--
 t/t6409-merge-subtree.sh        |   6 +-
 t/t6417-merge-ours-theirs.sh    |  10 +-
 t/t7601-merge-pull-config.sh    | 244 +++++++++++++++++++++++++++++---
 t/t7603-merge-reduce-heads.sh   |   2 +-
 18 files changed, 371 insertions(+), 83 deletions(-)


base-commit: daab8a564f8bbac55f70f8bf86c070e001a9b006
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1049%2Fnewren%2Fhandle-pull-option-precedence-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1049/newren/handle-pull-option-precedence-v3
Pull-Request: https://github.com/git/git/pull/1049

Range-diff vs v2:

 1:  17560927211 = 1:  17560927211 t7601: test interaction of merge/rebase/fast-forward flags and options
 2:  66fe7f7f934 = 2:  66fe7f7f934 t7601: add tests of interactions with multiple merge heads and config
 3:  c45cd239666 = 3:  c45cd239666 pull: abort if --ff-only is given and fast-forwarding is impossible
 4:  1a821d3b1dd ! 4:  0682b2250f4 pull: since --ff-only overrides, handle it first
     @@ builtin/pull.c: int cmd_pull(int argc, const char **argv, const char *prefix)
       
       	if (opt_rebase) {
       		int ret = 0;
     -@@ builtin/pull.c: int cmd_pull(int argc, const char **argv, const char *prefix)
     - 		    submodule_touches_in_range(the_repository, &upstream, &curr_head))
     - 			die(_("cannot rebase with locally recorded submodule modifications"));
     - 
     --		if (can_ff) {
     --			/* we can fast-forward this without invoking rebase */
     --			opt_ff = "--ff-only";
     --			ret = run_merge();
     --		} else {
     --			ret = run_rebase(&newbase, &upstream);
     --		}
     -+		ret = run_rebase(&newbase, &upstream);
     - 
     - 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
     - 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
     -
     - ## t/t5520-pull.sh ##
     -@@ t/t5520-pull.sh: test_expect_success '--rebase (merge) fast forward' '
     - 	# The above only validates the result.  Did we actually bypass rebase?
     - 	git reflog -1 >reflog.actual &&
     - 	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
     --	echo "OBJID HEAD@{0}: pull --rebase . ff: Fast-forward" >reflog.expected &&
     -+	echo "OBJID HEAD@{0}: pull --rebase . ff (finish): returning to refs/heads/to-rebase" >reflog.expected &&
     - 	test_cmp reflog.expected reflog.fuzzy
     - '
     - 
     -@@ t/t5520-pull.sh: test_expect_success '--rebase (am) fast forward' '
     - 
     - 	# The above only validates the result.  Did we actually bypass rebase?
     - 	git reflog -1 >reflog.actual &&
     --	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
     --	echo "OBJID HEAD@{0}: pull --rebase . ff: Fast-forward" >reflog.expected &&
     -+	sed -e "s/^[0-9a-f][0-9a-f]*/OBJID/" -e "s/[0-9a-f][0-9a-f]*$/OBJID/" reflog.actual >reflog.fuzzy &&
     -+	echo "OBJID HEAD@{0}: rebase finished: refs/heads/to-rebase onto OBJID" >reflog.expected &&
     - 	test_cmp reflog.expected reflog.fuzzy
     - '
     - 
 5:  9b116f3d284 = 5:  b242d001132 pull: make --rebase and --no-rebase override pull.ff=only
 6:  f061f8b4e75 = 6:  7447c719bd7 pull: abort by default when fast-forwarding is not possible
 7:  90d49e0fb78 = 7:  726082f2e79 pull: update docs & code for option compatibility with rebasing
 8:  f03b15b7eb0 = 8:  768dec71558 pull: fix handling of multiple heads

-- 
gitgitgadget
