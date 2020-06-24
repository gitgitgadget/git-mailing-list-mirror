Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779C8C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5144620702
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE7RBTbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403791AbgFXOsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389818AbgFXOso (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:48:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4D1C0613ED
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:48:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so2563314wru.6
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lltVqZxVi42QeaiDJf9AH6XgViCzlTwYkukvZ8pXU3U=;
        b=AE7RBTbhFJP8+RPJauEZQWI1vJAEQgf26ub6/hFFisS1ccxaXeHAOfzfEtH/bLijSf
         QFF9T7xjPGrQbEyL+Dt5AyytmzhTkjd/2dP90a8ZYpWl2F/cz7tFXmGanGX7Z6WG4Kgv
         wIKppL9CLIdn0J4jOIH+E+H6xp86qFiMlP38JLQqwXCWrpuEFqQcOV21gLqG+4LSH53w
         /vAbEFYExweLfZbYzULznMZCEaVDuBAKzl7MaDcO3vbi6XhxIlYdS0beq7ClIMgBTbxE
         cSglk9T4JiDtFEjP2vjzHaeviLERw9QCOfaHyeQFPR5Y+vSd1q7MRKSMmdPDvTMbRp2V
         ZOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lltVqZxVi42QeaiDJf9AH6XgViCzlTwYkukvZ8pXU3U=;
        b=OrhY9CPyNRHB1REs3lf6gubdO/Jz4nJZNKiT+JtLmAAYsn0vedEGPJAysW4gaPE/ur
         qvsADyZ0RokWdIBxHhsmkBabB5u6BE/DvajR9qjXQTwt6+dhrIkUS7Ii1HLnIubYuq8V
         Ez9uyNkNTW2HwCMRHFdn8k5+B8MAa3bXD34SikYrdtXmhqC8dJx0EtYZ5G4KZSkn5kwX
         oX8o6LnreMePQE6X04vr+w7D49ca+xroRdX2T68zdbXYb5g9JDN54mx86LD0cXfCYIv/
         Ymlzf3F/+oRC/csProCsza+8zrPufyC3gKpcgNK3lj8LEMjLJaO8TUlHh136PQX+k8WV
         5TRw==
X-Gm-Message-State: AOAM531rPqP/4BJ8sFfgnGEYxZnw2O/vDIzN3+PHiOrEYb5fMuSxPfA9
        ++ELFyooOrW7C734icI6N73gxNt3VUs=
X-Google-Smtp-Source: ABdhPJwFdeBAKTTkTAuLL7A2jIJtjgGUMX+YZK+6LTNGGeglRIJxPkpS/Fhll8SXxjnuNQtA9vJcVw==
X-Received: by 2002:adf:e50a:: with SMTP id j10mr33504322wrm.71.1593010122145;
        Wed, 24 Jun 2020 07:48:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 63sm29541052wra.86.2020.06.24.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:48:41 -0700 (PDT)
Message-Id: <35e3dafd6a0b9bc2278933378f04cf13072ee298.1593010120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
        <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:48:38 +0000
Subject: [PATCH v2 1/3] docs: adjust for the recent rename of `pu` to `seen`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index 427274df4d..d85c9b5143 100644
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
index ecf9438cf0..291b61e262 100644
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
+  tell you if your patch is merged in `seen` if you rebase on top of
   master).
 
 * Read the Git mailing list, the maintainer regularly posts messages
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 5b1909fdf4..45b6d8e633 100644
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
index 0a5c8b7d49..492e573856 100644
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
index 1bd919f92b..faba2ef088 100644
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
+and `seen`.
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
index abc0dc6bc7..0965b60884 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -85,15 +85,15 @@ As a given feature goes from experimental to stable, it also
 
 There is a fourth official branch that is used slightly differently:
 
-* 'pu' (proposed updates) is an integration branch for things that are
-  not quite ready for inclusion yet (see "Integration Branches"
-  below).
+* `seen` (patches seen by the maintainer) is an integration branch for
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
index 833652983f..fd480b8645 100644
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

