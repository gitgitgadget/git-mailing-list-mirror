Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79831F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 20:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbdBCU2h (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 15:28:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:3724 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752119AbdBCU2g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 15:28:36 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP; 03 Feb 2017 12:28:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,330,1477983600"; 
   d="scan'208";a="1121806613"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.35.174])
  by fmsmga002.fm.intel.com with ESMTP; 03 Feb 2017 12:28:35 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2] reset: add an example of how to split a commit into two
Date:   Fri,  3 Feb 2017 12:28:33 -0800
Message-Id: <20170203202833.17666-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.864.ge7592a54611d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

It is often useful to break a commit into multiple parts that are more
logical separations. This can be tricky to learn how to do without the
brute-force method if re-writing code or commit messages from scratch.

Add a section to the git-reset documentation which shows an example
process for how to use git add -p and git commit -c HEAD@{1} to
interactively break a commit apart and re-use the original commit
message as a starting point when making the new commit message.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-reset.txt | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 25432d9257f9..add6220fce77 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -292,6 +292,44 @@ $ git reset --keep start                    <3>
 <3> But you can use "reset --keep" to remove the unwanted commit after
     you switched to "branch2".
 
+Split a commit into two::
++
+Suppose that you have created a commit, but later decide that you want to break
+apart the changes into two logical chunks and commit each separately. You want
+to include part of the original commit into the first commit, while including
+the remainder in a second commit. You can use git reset to rewind the history
+without changing the index, and then use git add -p to interactively select
+which hunks to put into the first commit.
++
+------------
+$ git reset HEAD^                           <1>
+$ git add -p                                <2>
+$ git diff --cached                         <3>
+$ git commit -c HEAD@{1}                    <4>
+...
+$ git add ...                               <5>
+$ git diff --cached                         <6>
+$ git commit ...                            <7>
+------------
++
+<1> First, reset the history back one commit so that we remove the original
+    commit, but leave the working tree with all the changes.
+<2> Now, interactively select hunks to add to a new commit using git add -p.
+    This will ask for each hunk separately and you can use simple commands like
+    "yes, include", "no don't include" or even "edit".
+<3> Once satisfied with the hunks, you should verify that it is what you
+    expected by using git diff --cached to show all changes in the index.
+<4> Next, commit the changes stored in the index. "-c" specifies to load the
+    editor with a commit message from a previous commit so that you can re-use the
+    original commit message. HEAD@{1} is special notation to reference what
+    HEAD used to be prior to the reset command. See linkgit:git-reflog[1] for
+    more details.
+<5> Now you've created the first commit, and can repeat steps 2-4 as often as
+    you like to break the work into any number of commits. Here we show a second
+    step which simply adds the remaining changes.
+<6> Then check again that the changes are what you expected to add.
+<7> And finally commit the remaining changes.
+
 
 DISCUSSION
 ----------
-- 
2.11.0.864.ge7592a54611d

