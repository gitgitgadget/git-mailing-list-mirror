Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD521F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 14:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754574AbcJEOyj (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 10:54:39 -0400
Received: from mail.javad.com ([54.86.164.124]:43259 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754408AbcJEOyh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 10:54:37 -0400
Received: from localhost6.localdomain6 (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 6DF48633E1;
        Wed,  5 Oct 2016 14:46:29 +0000 (UTC)
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
        by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id u95EkRJB020695;
        Wed, 5 Oct 2016 17:46:27 +0300
Received: (from osv@localhost)
        by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id u95EkRUT020692;
        Wed, 5 Oct 2016 17:46:27 +0300
From:   sorganov@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 6/6] Documentation/git-merge.txt: get rid of irrelevant references to git-pull
Date:   Wed,  5 Oct 2016 17:46:24 +0300
Message-Id: <b91ef5e97c60a85cce1a13f88a19218fd0f05655.1475678515.git.sorganov@gmail.com>
X-Mailer: git-send-email 2.10.0.1.g57b01a3
In-Reply-To: <cover.1475678515.git.sorganov@gmail.com>
References: <cover.1475678515.git.sorganov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sergey Organov <sorganov@gmail.com>

No awareness of git-pull is required to understand git-merge operation,
so leave reference to git-pull only where it actually makes sense, in
the description of fast-forward merges, and only as clarification of
when this merging behaviour is mostly useful.

Other references to git-pull are likely just a historical leftover
that are now neither required nor clarify anything. Besides, git-pull
may use rebase rather than merge, so it's also technically wrong to
say, unconditionally, that git-pull uses git-merge.

Overall, let git-pull description refer to git-merge where
appropriate, and not vice versa.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/git-merge.txt | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 351b8fc..ba5fb0a 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -23,10 +23,6 @@ named commits and the current branch, called "merge base", is
 calculated, and then net changes taken from the merge base to
 the named commits are applied.
 
-This command is used by 'git pull' to incorporate changes from another
-repository, and can be used by hand to merge changes from one branch
-into another.
-
 Assume the following history exists and the current branch is
 "`master`":
 
@@ -119,18 +115,17 @@ of `git fetch` for merging are merged to the current branch.
 PRE-MERGE CHECKS
 ----------------
 
-Before applying outside changes, you should get your own work in
-good shape and committed locally, so it will not be clobbered if
-there are conflicts.  See also linkgit:git-stash[1].
-'git pull' and 'git merge' will stop without doing anything when
-local uncommitted changes overlap with files that 'git pull'/'git
-merge' may need to update.
+Before applying outside changes, you should get your own work in good
+shape and committed locally, so it will not be clobbered if there are
+conflicts. See also linkgit:git-stash[1]. 'git merge' will stop
+without doing anything when local uncommitted changes overlap with
+files that 'git merge' may need to update.
 
-To avoid recording unrelated changes in the merge commit,
-'git pull' and 'git merge' will also abort if there are any changes
-registered in the index relative to the `HEAD` commit.  (One
-exception is when the changed index entries are in the state that
-would result from the merge already.)
+To avoid recording unrelated changes in the merge commit, 'git merge'
+will also abort if there are any changes registered in the index
+relative to the `HEAD` commit. (One exception is when the changed
+index entries are in the state that would result from the merge
+already.)
 
 If all named commits are already ancestors of `HEAD`, 'git merge'
 will exit early with the message "Already up-to-date."
@@ -138,14 +133,15 @@ will exit early with the message "Already up-to-date."
 FAST-FORWARD MERGE
 ------------------
 
-Often the current branch head is an ancestor of the named commit.
+Often the current branch head is an ancestor of the named commit.  In
+this case, a new commit is not needed to store the combined history;
+instead, the `HEAD` (along with the index) is updated to point at the
+named commit, without creating an extra merge commit.
+
 This is the most common case especially when invoked from 'git
 pull': you are tracking an upstream repository, you have committed
 no local changes, and now you want to update to a newer upstream
-revision.  In this case, a new commit is not needed to store the
-combined history; instead, the `HEAD` (along with the index) is
-updated to point at the named commit, without creating an extra
-merge commit.
+revision.
 
 This behavior can be suppressed with the `--no-ff` option.
 
-- 
2.10.0.1.g57b01a3

