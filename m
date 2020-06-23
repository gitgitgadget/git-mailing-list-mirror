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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7036C433E2
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57C320774
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5nOyhzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbgFWPEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733001AbgFWPEX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:04:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A2CC061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 08:04:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z13so9132357wrw.5
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 08:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=923L239auoPiBZR7+WLG2wYBC9wXWL0ROF1TD3Ac3XY=;
        b=K5nOyhzWOfpBBrbM9mByCp4+gsbleGu+rkqcIDDgMwrEc3I5L2B7t0CjaK8fRF4ir9
         dUVCe5nsnoh+EXRTam20EcPqRY/07FE1kvG4IzxizgOQxoVtMx/bCuW4ni2cTVZ0QD8P
         PK+J5iQpy9RJPlg7MFYRzNOHab3GQYJtWlMcyBTOFu0HTp3seEx9w/iygz29ei7ZuXqU
         t+TQZ32DfVhnJM10Al7+KHTqMRKnlBcIkArLJpV69JXVh+TzAX3Fw1buYGwr9q2/QmGT
         kHqZG3LMqJ5cOXtGTFPy4U1HxVelhGN70MKs5Qskgqn4PbDj4FaFFypSTuAGLKfVvCP7
         fDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=923L239auoPiBZR7+WLG2wYBC9wXWL0ROF1TD3Ac3XY=;
        b=OUwa9MSEP5EQcmxNPi31N2eckwwknyXPQiT7pkEtykPGQuH5PiUqXkaRw+j/4anRtd
         XeyYJ56GGXH8r4roaRIK89oQEwmhQlzWEjvNDkw/kDi7hwBzZ/TfM+Oqq7GlWrwwye8I
         Gi7y344AYoSuCwQ6jyw3LIkIMo2o8kzj0zxIQP6PTOlszp8CfgT+xZ+NCMEHC+zyuQhm
         xunLcKcgh7VDRGnodjdIXLZp7l0SrWv5snd0RjtZQbBqFQklHK6uximuFt7iG/FwrGyh
         1OidCDFx8ov0rftZblCAFa0k5uxkMVtZtzHlqlXKMuLdUtpz9VHpG74h6NsQoPgiuZkn
         dsow==
X-Gm-Message-State: AOAM531gMLQwhYoGk0x1Q8Mtr5Q/F9NY+gW9pRD5gInpH8Bk8OnzaeHP
        bcXfyEMBO9vj2p0+l/g+XlH8jhgZ
X-Google-Smtp-Source: ABdhPJz4MXQJ6ZFb4Tih2cjtJYumzd46C0KQAZ3qRSNxBY8zqdW1u+IKb260qDwbLodRrQ93ZXrtZw==
X-Received: by 2002:a5d:5607:: with SMTP id l7mr25119607wrv.261.1592924658471;
        Tue, 23 Jun 2020 08:04:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7sm4418987wml.24.2020.06.23.08.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 08:04:18 -0700 (PDT)
Message-Id: <b792cb036cf9e8b9028c00d4c657105a004d5dc0.1592924655.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.668.git.1592924655.gitgitgadget@gmail.com>
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 15:04:14 +0000
Subject: [PATCH 2/3] docs: adjust the technical overview for the rename `pu`
 -> `seen`
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

This patch tries to rewrite history a bit: the mail contents that have
been added to Git's source code are actually fixed, we cannot change
them in hindsight.

But as the `pu` branch _was_ renamed, and as the documents were added to
Git's source code not so much as historical record, but to describe the
status quo, let's pretend that we have a time machine and adjust the
provided information accordingly.

Where appropriate, quotes were added for readability.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/howto/maintain-git.txt          | 52 +++++++++----------
 .../howto/rebase-from-internal-branch.txt     | 32 ++++++------
 Documentation/howto/revert-branch-rebase.txt  | 32 ++++++------
 Documentation/howto/update-hook-example.txt   |  6 +--
 4 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index 73be8b49f84..a67130debb6 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -66,7 +66,7 @@ this mailing list after each feature release is made.
    demonstrated to be regression free.  New changes are tested
    in 'next' before merged to 'master'.
 
- - 'pu' branch is used to publish other proposed changes that do
+ - 'seen' branch is used to publish other proposed changes that do
    not yet pass the criteria set for 'next'.
 
  - The tips of 'master' and 'maint' branches will not be rewound to
@@ -76,7 +76,7 @@ this mailing list after each feature release is made.
    of the cycle.
 
  - Usually 'master' contains all of 'maint' and 'next' contains all
-   of 'master'.  'pu' contains all the topics merged to 'next', but
+   of 'master'.  'seen' contains all the topics merged to 'next', but
    is rebuilt directly on 'master'.
 
  - The tip of 'master' is meant to be more stable than any
@@ -229,12 +229,12 @@ by doing the following:
    series?)
 
  - Prepare 'jch' branch, which is used to represent somewhere
-   between 'master' and 'pu' and often is slightly ahead of 'next'.
+   between 'master' and 'seen' and often is slightly ahead of 'next'.
 
-     $ Meta/Reintegrate master..pu >Meta/redo-jch.sh
+     $ Meta/Reintegrate master..seen >Meta/redo-jch.sh
 
    The result is a script that lists topics to be merged in order to
-   rebuild 'pu' as the input to Meta/Reintegrate script.  Remove
+   rebuild 'seen' as the input to Meta/Reintegrate script.  Remove
    later topics that should not be in 'jch' yet.  Add a line that
    consists of '### match next' before the name of the first topic
    in the output that should be in 'jch' but not in 'next' yet.
@@ -291,29 +291,29 @@ by doing the following:
    merged to 'master'.  This may lose '### match next' marker;
    add it again to the appropriate place when it happens.
 
- - Rebuild 'pu'.
+ - Rebuild 'seen'.
 
-     $ Meta/Reintegrate master..pu >Meta/redo-pu.sh
+     $ Meta/Reintegrate master..seen >Meta/redo-seen.sh
 
-   Edit the result by adding new topics that are not still in 'pu'
+   Edit the result by adding new topics that are not still in 'seen'
    in the script.  Then
 
-     $ git checkout -B pu jch
-     $ sh Meta/redo-pu.sh
+     $ git checkout -B seen jch
+     $ sh Meta/redo-seen.sh
 
-   When all is well, clean up the redo-pu.sh script with
+   When all is well, clean up the redo-seen.sh script with
 
-     $ sh Meta/redo-pu.sh -u
+     $ sh Meta/redo-seen.sh -u
 
    Double check by running
 
-     $ git branch --no-merged pu
+     $ git branch --no-merged seen
 
    to see there is no unexpected leftover topics.
 
    At this point, build-test the result for semantic conflicts, and
    if there are, prepare an appropriate merge-fix first (see
-   appendix), and rebuild the 'pu' branch from scratch, starting at
+   appendix), and rebuild the 'seen' branch from scratch, starting at
    the tip of 'jch'.
 
  - Update "What's cooking" message to review the updates to
@@ -323,14 +323,14 @@ by doing the following:
 
      $ Meta/cook
 
-   This script inspects the history between master..pu, finds tips
+   This script inspects the history between master..seen, finds tips
    of topic branches, compares what it found with the current
    contents in Meta/whats-cooking.txt, and updates that file.
-   Topics not listed in the file but are found in master..pu are
+   Topics not listed in the file but are found in master..seen are
    added to the "New topics" section, topics listed in the file that
-   are no longer found in master..pu are moved to the "Graduated to
+   are no longer found in master..seen are moved to the "Graduated to
    master" section, and topics whose commits changed their states
-   (e.g. used to be only in 'pu', now merged to 'next') are updated
+   (e.g. used to be only in 'seen', now merged to 'next') are updated
    with change markers "<<" and ">>".
 
    Look for lines enclosed in "<<" and ">>"; they hold contents from
@@ -360,7 +360,7 @@ Observations
 Some observations to be made.
 
  * Each topic is tested individually, and also together with other
-   topics cooking first in 'pu', then in 'jch' and then in 'next'.
+   topics cooking first in 'seen', then in 'jch' and then in 'next'.
    Until it matures, no part of it is merged to 'master'.
 
  * A topic already in 'next' can get fixes while still in
@@ -411,7 +411,7 @@ new use of the variable under its old name. When these two topics
 are merged together, the reference to the variable newly added by
 the latter topic will still use the old name in the result.
 
-The Meta/Reintegrate script that is used by redo-jch and redo-pu
+The Meta/Reintegrate script that is used by redo-jch and redo-seen
 scripts implements a crude but usable way to work this issue around.
 When the script merges branch $X, it checks if "refs/merge-fix/$X"
 exists, and if so, the effect of it is squashed into the result of
@@ -431,14 +431,14 @@ commit that can be squashed into a result of mechanical merge to
 correct semantic conflicts.
 
 After finding that the result of merging branch "ai/topic" to an
-integration branch had such a semantic conflict, say pu~4, check the
+integration branch had such a semantic conflict, say seen~4, check the
 problematic merge out on a detached HEAD, edit the working tree to
 fix the semantic conflict, and make a separate commit to record the
 fix-up:
 
-     $ git checkout pu~4
+     $ git checkout seen~4
      $ git show -s --pretty=%s ;# double check
-     Merge branch 'ai/topic' to pu
+     Merge branch 'ai/topic' to seen
      $ edit
      $ git commit -m 'merge-fix/ai/topic' -a
 
@@ -450,9 +450,9 @@ result:
 Then double check the result by asking Meta/Reintegrate to redo the
 merge:
 
-     $ git checkout pu~5 ;# the parent of the problem merge
+     $ git checkout seen~5 ;# the parent of the problem merge
      $ echo ai/topic | Meta/Reintegrate
-     $ git diff pu~4
+     $ git diff seen~4
 
 This time, because you prepared refs/merge-fix/ai/topic, the
 resulting merge should have been tweaked to include the fix for the
@@ -464,7 +464,7 @@ branch needs this merge-fix is because another branch merged earlier
 to the integration branch changed the underlying assumption ai/topic
 branch made (e.g. ai/topic branch added a site to refer to a
 variable, while the other branch renamed that variable and adjusted
-existing use sites), and if you changed redo-jch (or redo-pu) script
+existing use sites), and if you changed redo-jch (or redo-seen) script
 to merge ai/topic branch before the other branch, then the above
 merge-fix should not be applied while merging ai/topic, but should
 instead be applied while merging the other branch.  You would need
diff --git a/Documentation/howto/rebase-from-internal-branch.txt b/Documentation/howto/rebase-from-internal-branch.txt
index 02cb5f758d6..ece51ddddce 100644
--- a/Documentation/howto/rebase-from-internal-branch.txt
+++ b/Documentation/howto/rebase-from-internal-branch.txt
@@ -4,7 +4,7 @@ Cc:	Petr Baudis <pasky@suse.cz>, Linus Torvalds <torvalds@osdl.org>
 Subject: Re: sending changesets from the middle of a git tree
 Date:	Sun, 14 Aug 2005 18:37:39 -0700
 Abstract: In this article, JC talks about how he rebases the
- public "pu" branch using the core Git tools when he updates
+ public "seen" branch using the core Git tools when he updates
  the "master" branch, and how "rebase" works.  Also discussed
  is how this applies to individual developers who sends patches
  upstream.
@@ -20,8 +20,8 @@ Petr Baudis <pasky@suse.cz> writes:
 > where Junio C Hamano <junkio@cox.net> told me that...
 >> Linus Torvalds <torvalds@osdl.org> writes:
 >>
->> > Junio, maybe you want to talk about how you move patches from your "pu"
->> > branch to the real branches.
+>> > Junio, maybe you want to talk about how you move patches from your
+>> > "seen" branch to the real branches.
 >>
 > Actually, wouldn't this be also precisely for what StGIT is intended to?
 --------------------------------------
@@ -33,12 +33,12 @@ the kind of task StGIT is designed to do.
 I just have done a simpler one, this time using only the core
 Git tools.
 
-I had a handful of commits that were ahead of master in pu, and I
+I had a handful of commits that were ahead of master in 'seen', and I
 wanted to add some documentation bypassing my usual habit of
-placing new things in pu first.  At the beginning, the commit
+placing new things in 'seen' first.  At the beginning, the commit
 ancestry graph looked like this:
 
-                             *"pu" head
+                             *"seen" head
     master --> #1 --> #2 --> #3
 
 So I started from master, made a bunch of edits, and committed:
@@ -50,7 +50,7 @@ So I started from master, made a bunch of edits, and committed:
 
 After the commit, the ancestry graph would look like this:
 
-                              *"pu" head
+                              *"seen" head
     master^ --> #1 --> #2 --> #3
           \
             \---> master
@@ -58,31 +58,31 @@ After the commit, the ancestry graph would look like this:
 The old master is now master^ (the first parent of the master).
 The new master commit holds my documentation updates.
 
-Now I have to deal with "pu" branch.
+Now I have to deal with "seen" branch.
 
 This is the kind of situation I used to have all the time when
 Linus was the maintainer and I was a contributor, when you look
-at "master" branch being the "maintainer" branch, and "pu"
+at "master" branch being the "maintainer" branch, and "seen"
 branch being the "contributor" branch.  Your work started at the
 tip of the "maintainer" branch some time ago, you made a lot of
 progress in the meantime, and now the maintainer branch has some
 other commits you do not have yet.  And "git rebase" was written
 with the explicit purpose of helping to maintain branches like
-"pu".  You _could_ merge master to pu and keep going, but if you
+"seen".  You _could_ merge master to 'seen' and keep going, but if you
 eventually want to cherrypick and merge some but not necessarily
 all changes back to the master branch, it often makes later
 operations for _you_ easier if you rebase (i.e. carry forward
-your changes) "pu" rather than merge.  So I ran "git rebase":
+your changes) "seen" rather than merge.  So I ran "git rebase":
 
-    $ git checkout pu
-    $ git rebase master pu
+    $ git checkout seen
+    $ git rebase master seen
 
 What this does is to pick all the commits since the current
-branch (note that I now am on "pu" branch) forked from the
+branch (note that I now am on "seen" branch) forked from the
 master branch, and forward port these changes.
 
     master^ --> #1 --> #2 --> #3
-          \                                  *"pu" head
+          \                                  *"seen" head
             \---> master --> #1' --> #2' --> #3'
 
 The diff between master^ and #1 is applied to master and
@@ -92,7 +92,7 @@ commits are made similarly out of #2 and #3 commits.
 
 Old #3 is not recorded in any of the .git/refs/heads/ file
 anymore, so after doing this you will have dangling commit if
-you ran fsck-cache, which is normal.  After testing "pu", you
+you ran fsck-cache, which is normal.  After testing "seen", you
 can run "git prune" to get rid of those original three commits.
 
 While I am talking about "git rebase", I should talk about how
diff --git a/Documentation/howto/revert-branch-rebase.txt b/Documentation/howto/revert-branch-rebase.txt
index 149508e13bd..a3e5595a569 100644
--- a/Documentation/howto/revert-branch-rebase.txt
+++ b/Documentation/howto/revert-branch-rebase.txt
@@ -15,7 +15,7 @@ One of the changes I pulled into the 'master' branch turns out to
 break building Git with GCC 2.95.  While they were well-intentioned
 portability fixes, keeping things working with gcc-2.95 was also
 important.  Here is what I did to revert the change in the 'master'
-branch and to adjust the 'pu' branch, using core Git tools and
+branch and to adjust the 'seen' branch, using core Git tools and
 barebone Porcelain.
 
 First, prepare a throw-away branch in case I screw things up.
@@ -104,11 +104,11 @@ $ git diff master..revert-c99
 
 says nothing.
 
-Then we rebase the 'pu' branch as usual.
+Then we rebase the 'seen' branch as usual.
 
 ------------------------------------------------
-$ git checkout pu
-$ git tag pu-anchor pu
+$ git checkout seen
+$ git tag seen-anchor seen
 $ git rebase master
 * Applying: Redo "revert" using three-way merge machinery.
 First trying simple merge strategy to cherry-pick.
@@ -127,11 +127,11 @@ First trying simple merge strategy to cherry-pick.
 First trying simple merge strategy to cherry-pick.
 ------------------------------------------------
 
-The temporary tag 'pu-anchor' is me just being careful, in case 'git
+The temporary tag 'seen-anchor' is me just being careful, in case 'git
 rebase' screws up.  After this, I can do these for sanity check:
 
 ------------------------------------------------
-$ git diff pu-anchor..pu ;# make sure we got the master fix.
+$ git diff seen-anchor..seen ;# make sure we got the master fix.
 $ make CC=gcc-2.95 clean test ;# make sure it fixed the breakage.
 $ make clean test ;# make sure it did not cause other breakage.
 ------------------------------------------------
@@ -140,7 +140,7 @@ Everything is in the good order.  I do not need the temporary branch
 or tag anymore, so remove them:
 
 ------------------------------------------------
-$ rm -f .git/refs/tags/pu-anchor
+$ rm -f .git/refs/tags/seen-anchor
 $ git branch -d revert-c99
 ------------------------------------------------
 
@@ -168,18 +168,18 @@ Committed merge 7fb9b7262a1d1e0a47bbfdcbbcf50ce0635d3f8f
 And the final repository status looks like this:
 
 ------------------------------------------------
-$ git show-branch --more=1 master pu rc
+$ git show-branch --more=1 master seen rc
 ! [master] Revert "Replace zero-length array decls with []."
- ! [pu] git-repack: Add option to repack all objects.
+ ! [seen] git-repack: Add option to repack all objects.
   * [rc] Merge refs/heads/master from .
 ---
- +  [pu] git-repack: Add option to repack all objects.
- +  [pu~1] More documentation updates.
- +  [pu~2] Show commits in topo order and name all commits.
- +  [pu~3] mailinfo and applymbox updates
- +  [pu~4] Document "git cherry-pick" and "git revert"
- +  [pu~5] Remove git-apply-patch-script.
- +  [pu~6] Redo "revert" using three-way merge machinery.
+ +  [seen] git-repack: Add option to repack all objects.
+ +  [seen~1] More documentation updates.
+ +  [seen~2] Show commits in topo order and name all commits.
+ +  [seen~3] mailinfo and applymbox updates
+ +  [seen~4] Document "git cherry-pick" and "git revert"
+ +  [seen~5] Remove git-apply-patch-script.
+ +  [seen~6] Redo "revert" using three-way merge machinery.
   - [rc] Merge refs/heads/master from .
 ++* [master] Revert "Replace zero-length array decls with []."
   - [rc~1] Merge refs/heads/master from .
diff --git a/Documentation/howto/update-hook-example.txt b/Documentation/howto/update-hook-example.txt
index 89821ec74fe..151ee84cebc 100644
--- a/Documentation/howto/update-hook-example.txt
+++ b/Documentation/howto/update-hook-example.txt
@@ -179,7 +179,7 @@ allowed-groups, to describe which heads can be pushed into by
 whom.  The format of each file would look like this:
 
     refs/heads/master   junio
-    +refs/heads/pu      junio
+    +refs/heads/seen    junio
     refs/heads/cogito$  pasky
     refs/heads/bw/.*    linus
     refs/heads/tmp/.*   .*
@@ -187,6 +187,6 @@ whom.  The format of each file would look like this:
 
 With this, Linus can push or create "bw/penguin" or "bw/zebra"
 or "bw/panda" branches, Pasky can do only "cogito", and JC can
-do master and pu branches and make versioned tags.  And anybody
-can do tmp/blah branches. The '+' sign at the pu record means
+do master and "seen" branches and make versioned tags.  And anybody
+can do tmp/blah branches. The '+' sign at the "seen" record means
 that JC can make non-fast-forward pushes on it.
-- 
gitgitgadget

