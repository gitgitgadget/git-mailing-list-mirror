Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3459C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E91F20723
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ/cEvu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbgFWPEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732862AbgFWPET (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:04:19 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBE2C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 08:04:19 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so3290815wmi.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+BdGav+wBIsbGHgdMdrR2LmG+dkhghAcWw1CNDpkxgM=;
        b=YQ/cEvu04zqEF5bhwwwV7hI7kcFqe0RZhRVkiTxd/3VW4QbxOTztRlqrrqXXVLZX+2
         Uw4IJT9NXTkQAwid5ramu624KAiVfWcDtRxdKe/CKQLVo6fFUYJ6TgvzQPbQUno9LkoL
         EzVHfoINCRBuaNCn5jD8/cpPBZ41uxEug+rCJ9RKkYfygAc9zFcCY36SceDw0EvdN9u6
         xppUZnnGB/c5AGhQ2HYddkMLYN5oxAdDASXxpXr2xKc69HDj1FlVGy8OdqGsTarulQ+n
         pgJYM51IZwqN2tDT5MZkUzTvNeVx0/sgW4VW/5mhna/5Hud8YJFOIrTK0mJhS85fImFP
         +gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+BdGav+wBIsbGHgdMdrR2LmG+dkhghAcWw1CNDpkxgM=;
        b=ZUl86RmJ6bW9t411m+EMlhZsY+v2kXe97BK8yv1tN1moXniGgZ2hIIDEz+94aDOflK
         q71iZNidfz2mrRkh9M27LDTdXVG22MuOqiSQJHMEhOOrTETDlSrIqD3HTVb/BTEJjszn
         Y/2qwQryiptnmBBIiIvGPFFs8yoi7quRtqk5pvNIw3ySlemHFubK/r6ahg+C2MDpeb4S
         xcwGIP6b9xI97df025wO84lTcn6HMS14VYGsE8JZ50l+JBWt7urVV5i6fXWvo791t4S3
         Ig7gsI9Y+kcrQtd038CdEfFqiXXAk+Q4u0aGchbtRpU5fq79nC5jcx+l6stuT+l33gdf
         0CQA==
X-Gm-Message-State: AOAM530h6s1fYO1t7QSchhQ3I1j07U6l9JCZYI5mXX4knlhOrrVmA4/s
        WNwt+3ML3t1yw49agEzybSoTfiZc
X-Google-Smtp-Source: ABdhPJwbF/tjFPbwyU4X+nUmJLpiW2iDb/YBdva35JGRTGrvq3LDi+xVuNzeTkDcvZCWMK2h9/oJHg==
X-Received: by 2002:a05:600c:4146:: with SMTP id h6mr25555895wmm.170.1592924657728;
        Tue, 23 Jun 2020 08:04:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm4494797wmb.3.2020.06.23.08.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 08:04:17 -0700 (PDT)
Message-Id: <dc6f97129019e9176d91c77576a84549c00a74b5.1592924655.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.668.git.1592924655.gitgitgadget@gmail.com>
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 15:04:13 +0000
Subject: [PATCH 1/3] docs: adjust for the recent rename of `pu` to `seen`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of "What's cooking in git.git (Jun 2020, #04; Mon, 22)", there is no
longer any `pu` branch, but a `seen` branch.

While we technically do not even need to update the manual pages, it
makes sense to update them because they clearly talk about branches in
git.git.

Please note that in two instances, this patch not only updates the
branch name, but also the description "(proposed updates)".

Where appropriate, quotes have been added for readability.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/MyFirstContribution.txt |  4 ++--
 Documentation/SubmittingPatches       | 10 +++++-----
 Documentation/git-fetch.txt           |  8 ++++----
 Documentation/git-ls-remote.txt       |  4 ++--
 Documentation/giteveryday.txt         | 10 +++++-----
 Documentation/gitworkflows.txt        | 16 ++++++++--------
 Documentation/user-manual.txt         |  2 +-
 7 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 427274df4d9..d85c9b5143c 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1179,8 +1179,8 @@ look at the section below this one for some context.)
 [[after-approval]]
 === After Review Approval
 
-The Git project has four integration branches: `pu`, `next`, `master`, and
-`maint`. Your change will be placed into `pu` fairly early on by the maintainer
+The Git project has four integration branches: `seen`, `next`, `master`, and
+`maint`. Your change will be placed into `seen` fairly early on by the maintainer
 while it is still in the review process; from there, when it is ready for wider
 testing, it will be merged into `next`. Plenty of early testers use `next` and
 may report issues. Eventually, changes in `next` will make it to `master`,
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index ecf9438cf08..4aaf115111e 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -19,7 +19,7 @@ change is relevant to.
   base your work on the tip of the topic.
 
 * A new feature should be based on `master` in general. If the new
-  feature depends on a topic that is in `pu`, but not in `master`,
+  feature depends on a topic that is in `seen`, but not in `master`,
   base your work on the tip of that topic.
 
 * Corrections and enhancements to a topic not yet in `master` should
@@ -28,7 +28,7 @@ change is relevant to.
   into the series.
 
 * In the exceptional case that a new feature depends on several topics
-  not in `master`, start working on `next` or `pu` privately and send
+  not in `master`, start working on `next` or `seen` privately and send
   out patches for discussion. Before the final merge, you may have to
   wait until some of the dependent topics graduate to `master`, and
   rebase your work.
@@ -38,7 +38,7 @@ change is relevant to.
   these parts should be based on their trees.
 
 To find the tip of a topic branch, run `git log --first-parent
-master..pu` and look for the merge commit. The second parent of this
+master..seen` and look for the merge commit. The second parent of this
 commit is the tip of the topic branch.
 
 [[separate-commits]]
@@ -424,7 +424,7 @@ help you find out who they are.
   and cooked further and eventually graduates to `master`.
 
 In any time between the (2)-(3) cycle, the maintainer may pick it up
-from the list and queue it to `pu`, in order to make it easier for
+from the list and queue it to `seen`, in order to make it easier for
 people play with it without having to pick up and apply the patch to
 their trees themselves.
 
@@ -435,7 +435,7 @@ their trees themselves.
   master. `git pull --rebase` will automatically skip already-applied
   patches, and will let you know. This works only if you rebase on top
   of the branch in which your patch has been merged (i.e. it will not
-  tell you if your patch is merged in pu if you rebase on top of
+  tell you if your patch is merged in 'seen' if you rebase on top of
   master).
 
 * Read the Git mailing list, the maintainer regularly posts messages
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 5b1909fdf4f..45b6d8e633c 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -255,14 +255,14 @@ refspec.
 * Using refspecs explicitly:
 +
 ------------------------------------------------
-$ git fetch origin +pu:pu maint:tmp
+$ git fetch origin +seen:seen maint:tmp
 ------------------------------------------------
 +
-This updates (or creates, as necessary) branches `pu` and `tmp` in
+This updates (or creates, as necessary) branches `seen` and `tmp` in
 the local repository by fetching from the branches (respectively)
-`pu` and `maint` from the remote repository.
+`seen` and `maint` from the remote repository.
 +
-The `pu` branch will be updated even if it does not fast-forward,
+The `seen` branch will be updated even if it does not fast-forward,
 because it is prefixed with a plus sign; `tmp` will not be.
 
 * Peek at a remote's branch, without configuring the remote in your local
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 0a5c8b7d493..492e573856f 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -101,9 +101,9 @@ f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
 7ceca275d047c90c0c7d5afb13ab97efdf51bd6e	refs/tags/v0.99.3
 c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
 0918385dbd9656cab0d1d81ba7453d49bbc16250	refs/tags/junio-gpg-pub
-$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master pu rc
+$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master seen rc
 5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
-c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/pu
+c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
 $ git remote add korg http://www.kernel.org/pub/scm/git/git.git
 $ git ls-remote --tags korg v\*
 d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index 1bd919f92bd..3216b4b704c 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -278,13 +278,13 @@ $ git am -3 -i -s ./+to-apply <4>
 $ compile/test
 $ git switch -c hold/linus && git am -3 -i -s ./+hold-linus <5>
 $ git switch topic/one && git rebase master <6>
-$ git switch -C pu next <7>
+$ git switch -C seen next <7>
 $ git merge topic/one topic/two && git merge hold/linus <8>
 $ git switch maint
 $ git cherry-pick master~4 <9>
 $ compile/test
 $ git tag -s -m "GIT 0.99.9x" v0.99.9x <10>
-$ git fetch ko && for branch in master maint next pu <11>
+$ git fetch ko && for branch in master maint next seen <11>
     do
 	git show-branch ko/$branch $branch <12>
     done
@@ -294,14 +294,14 @@ $ git push --follow-tags ko <13>
 <1> see what you were in the middle of doing, if anything.
 <2> see which branches haven't been merged into `master` yet.
 Likewise for any other integration branches e.g. `maint`, `next`
-and `pu` (potential updates).
+and `seen` (patches seen by the maintainer).
 <3> read mails, save ones that are applicable, and save others
 that are not quite ready (other mail readers are available).
 <4> apply them, interactively, with your sign-offs.
 <5> create topic branch as needed and apply, again with sign-offs.
 <6> rebase internal topic branch that has not been merged to the
 master or exposed as a part of a stable branch.
-<7> restart `pu` every time from the next.
+<7> restart `seen` every time from the next.
 <8> and bundle topic branches still cooking.
 <9> backport a critical fix.
 <10> create a signed tag.
@@ -323,7 +323,7 @@ repository at kernel.org, and looks like this:
 	fetch = refs/heads/*:refs/remotes/ko/*
 	push = refs/heads/master
 	push = refs/heads/next
-	push = +refs/heads/pu
+	push = +refs/heads/seen
 	push = refs/heads/maint
 ------------
 
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index abc0dc6bc79..2db7ba78424 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -85,15 +85,15 @@ As a given feature goes from experimental to stable, it also
 
 There is a fourth official branch that is used slightly differently:
 
-* 'pu' (proposed updates) is an integration branch for things that are
-  not quite ready for inclusion yet (see "Integration Branches"
-  below).
+* 'seen' (patches seen by the maintainer) is an integration branch for
+  things that are not quite ready for inclusion yet (see "Integration
+  Branches" below).
 
 Each of the four branches is usually a direct descendant of the one
 above it.
 
 Conceptually, the feature enters at an unstable branch (usually 'next'
-or 'pu'), and "graduates" to 'master' for the next release once it is
+or 'seen'), and "graduates" to 'master' for the next release once it is
 considered stable enough.
 
 
@@ -207,7 +207,7 @@ If you make it (very) clear that this branch is going to be deleted
 right after the testing, you can even publish this branch, for example
 to give the testers a chance to work with it, or other developers a
 chance to see if their in-progress work will be compatible.  `git.git`
-has such an official throw-away integration branch called 'pu'.
+has such an official throw-away integration branch called 'seen'.
 
 
 Branch management for a release
@@ -291,7 +291,7 @@ This will not happen if the content of the branches was verified as
 described in the previous section.
 
 
-Branch management for next and pu after a feature release
+Branch management for next and seen after a feature release
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 After a feature release, the integration branch 'next' may optionally be
@@ -319,8 +319,8 @@ so.
 If you do this, then you should make a public announcement indicating
 that 'next' was rewound and rebuilt.
 
-The same rewind and rebuild process may be followed for 'pu'. A public
-announcement is not necessary since 'pu' is a throw-away branch, as
+The same rewind and rebuild process may be followed for 'seen'. A public
+announcement is not necessary since 'seen' is a throw-away branch, as
 described above.
 
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 833652983fa..fd480b86452 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -347,7 +347,7 @@ $ git branch -r
   origin/man
   origin/master
   origin/next
-  origin/pu
+  origin/seen
   origin/todo
 ------------------------------------------------
 
-- 
gitgitgadget

