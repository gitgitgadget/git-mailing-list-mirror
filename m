Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF700C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 10:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9776B20771
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 10:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRYPqcPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbgFWK6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732398AbgFWK6L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 06:58:11 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97104C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 03:58:11 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 80so6486954qko.7
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 03:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sSAi/5XXDbQqNnTBD3btL1PwHDBtq4UcGR8A9w9/Imo=;
        b=DRYPqcPnI041lY0+/d5jW8eTT2jHgpf4+W75uvhsE6xhPOu5GJy3uKTXaxiHvXnBi8
         pNqGThEQMXqQbj3uLxq0fcA4FkxrqNGXB+0BKfYKCoct4UEKkK8/cXQKvUfy1MeM+ofI
         +RrDUXLivP4LxwM3WOAWMts9dAmmdfybD4NQapgE/z8HeUtidTbrZydxGd81w6jjttEH
         /BmixA3UG+IAhDkfRhWn9MYOCXw8cQeHdinptSrZsFcyyloIP2mfVN1ic8mUJWbdain7
         YPjO7UQOg7AJuWplWbSi3dcIOGPin9xUgOn3s17Xb/xQrrE8noc39C83a5+8ndUtLXrp
         5LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sSAi/5XXDbQqNnTBD3btL1PwHDBtq4UcGR8A9w9/Imo=;
        b=n5ZmTstSBh/RZotWzLP3v0PTy6oC1Fviq+1F0d7l5TtqJyT1Dq0QetE+j1JZpzcO0J
         bLEI04Uoz4Dmp//aF4m+aDwHfDoJ/jeWT6p3eHBnMzsPe3xG0zRttupq/MKYJO+ITc+s
         UFRaIa22d4NHL5bnZhFJfy4FHd6MumcLBodpB9mO87lpKLmwtV00ogzHGozoloODnf8W
         LGYoxwxNXPBN6Fnox1rxRlmwrJXbw3U3+dw1TK0ZcTYd8LZwEUsNKvK5jj6HNZbKqYgP
         pP/39ZT69nGASkZaqYsfqVcUXuNbfiHmFUdscLFMqSwpgJaaNlEdWCBTA7BJRd59syjg
         N2iA==
X-Gm-Message-State: AOAM532UkxrS3u8Zi9Gh+IvdYmSsIWZOrWVIV7bSIKAnPcB6fgYA1w2l
        jRTmr0DmvGX17p7So2xdIM1u3slffjA=
X-Google-Smtp-Source: ABdhPJw7ZmaoKHuPkmprOaJWDOfoplOKFyUqLRhtCrnZYWkJ3ncAe8vpGeWbTgpLFHkC54oP0m5mUQ==
X-Received: by 2002:a05:620a:218e:: with SMTP id g14mr3201949qka.430.1592909890156;
        Tue, 23 Jun 2020 03:58:10 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id c189sm251457qkb.8.2020.06.23.03.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 03:58:09 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Doc: reference 'seen' instead of 'pu' in meta docs
Date:   Tue, 23 Jun 2020 06:58:00 -0400
Message-Id: <e250f1bb100aca94c914f1b2d38a3849c2566aea.1592909867.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.307.g7979e895e7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of 2020-06-22, the name of git.git's integration branch has been
renamed from 'pu' to 'seen'.[0] Update git.git-specific documentation to
refer to the new branch name. In particular, update documents that refer
to the workflow and also "how to contribute"-type docs.

There still remains other uses of 'pu' in the docs. In these cases, it
is generally used as an example and there isn't much value in updating
these examples since they aren't git.git specific.

[0]: https://lore.kernel.org/git/xmqqimfid2l1.fsf@gitster.c.googlers.com/

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/MyFirstContribution.txt |  4 +--
 Documentation/SubmittingPatches       | 10 +++---
 Documentation/giteveryday.txt         | 10 +++---
 Documentation/gitworkflows.txt        | 12 +++----
 Documentation/howto/maintain-git.txt  | 52 +++++++++++++--------------
 5 files changed, 44 insertions(+), 44 deletions(-)

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
index abc0dc6bc7..ae38ff3fed 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -85,7 +85,7 @@ As a given feature goes from experimental to stable, it also
 
 There is a fourth official branch that is used slightly differently:
 
-* 'pu' (proposed updates) is an integration branch for things that are
+* 'seen' is an integration branch for things that are
   not quite ready for inclusion yet (see "Integration Branches"
   below).
 
@@ -93,7 +93,7 @@ Each of the four branches is usually a direct descendant of the one
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
 
 
diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index 73be8b49f8..a67130debb 100644
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
-- 
2.27.0.307.g7979e895e7

