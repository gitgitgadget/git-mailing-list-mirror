Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8C71F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 00:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbdBCAa7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 19:30:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:59218 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751565AbdBCAa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 19:30:58 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP; 02 Feb 2017 16:30:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,326,1477983600"; 
   d="scan'208";a="1121436912"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.35.174])
  by fmsmga002.fm.intel.com with ESMTP; 02 Feb 2017 16:30:40 -0800
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] reset: add an example of how to split a commit into two
Date:   Thu,  2 Feb 2017 16:30:38 -0800
Message-Id: <20170203003038.22278-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.11.0.864.ge7592a54611d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

It is sometimes useful to break a commit into parts to more logically
show how the code changes. There are many possible ways to achieve this
result, but one simple and powerful one is to use git reset -p.

Add an example to the documentation showing how this can be done so that
users are more likely to discover this, instead of inventing more
painful methods such as re-writing code from scratch, or duplicating git
add -p more times than necessary.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/git-reset.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 25432d9257f9..4adac7a25bf9 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -292,6 +292,29 @@ $ git reset --keep start                    <3>
 <3> But you can use "reset --keep" to remove the unwanted commit after
     you switched to "branch2".
 
+Split a commit into two::
++
+Suppose that you have created a commit, but later decide that you want to split
+the changes into two separate commits, including only part of the old commit
+into the first commit, and including the rest as a separate commit on top. You
+can use git reset in patch mode to interactively select which hunks to split
+out into a separate commit.
++
+------------
+$ git reset -p HEAD^                        <1>
+$ git commit --amend                        <2>
+$ git commit ...                            <3>
+------------
++
+<1> This lets you interactively undo changes between HEAD^ and HEAD, so you can
+    select which parts to remove from the initial commit. The changes are
+    placed into the index, leaving the working tree untouched.
+<2> Now, you ammend the initial commit with the modifications that you just
+    made in the index.
+<3> Finally, you can add and then commit the final original unmodified files
+    back as the second commit, enabling you to logically separate a commit
+    into a sequence of two commits instead.
+
 
 DISCUSSION
 ----------
-- 
2.11.0.864.ge7592a54611d

