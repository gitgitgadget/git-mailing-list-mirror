Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5317B202F3
	for <e@80x24.org>; Tue, 19 Jul 2016 22:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbcGSWNm (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 18:13:42 -0400
Received: from siwi.pair.com ([209.68.5.199]:20840 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752537AbcGSWNe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 18:13:34 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 6F19384637;
	Tue, 19 Jul 2016 18:13:33 -0400 (EDT)
From:	Jeff Hostetler <jeffhost@microsoft.com>
To:	git@vger.kernel.org
Cc:	peff@peff.net, gitster@pobox.com, jeffhost@microsoft.com
Subject: [PATCH v1 5/6] Add porcelain V2 documentation to status manpage
Date:	Tue, 19 Jul 2016 18:10:57 -0400
Message-Id: <1468966258-11191-6-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This commit updates the status manpage to include
information about porcelain format V2.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-status.txt | 62 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index de97729..01c42c0 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -185,10 +185,10 @@ If -b is used the short-format status is preceded by a line
 
 ## branchname tracking info
 
-Porcelain Format
-~~~~~~~~~~~~~~~~
+Porcelain Format Version 1
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The porcelain format is similar to the short format, but is guaranteed
+Version 1 porcelain format is similar to the short format, but is guaranteed
 not to change in a backwards-incompatible way between Git versions or
 based on user configuration. This makes it ideal for parsing by scripts.
 The description of the short format above also describes the porcelain
@@ -210,6 +210,62 @@ field from the first filename).  Third, filenames containing special
 characters are not specially formatted; no quoting or
 backslash-escaping is performed.
 
+Porcelain Format Version 2
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+
+If `--branch` is given, a header line showing branch tracking information
+is printed.  This line begins with "### branch: ".  Fields are separated
+by a single space.
+
+    Field                    Meaning
+    --------------------------------------------------------
+    <sha> | (initial)        Current commit
+    <branch> | (detached)    Current branch
+    <upstream>               Upstream branch, if set
+    +<ahead>                 Ahead count, if upstream present
+    -<behind>                Behind count, if upstream present
+    --------------------------------------------------------
+
+A series of lines are then displayed for the tracked entries.
+
+    <xy> <sub> <mA> <mB> <mC> <mD> <shaA> <shaB> <shaC> R<nr> <path>[\t<pathSrc>]
+
+    Field       Meaning
+    --------------------------------------------------------
+    <xy>        The staged and unstaged values described earlier, with
+                unchanged indicated by a "." rather than a space.
+    <sub>       The submodule state. "N" when the entry is not a submodule.
+                "S[C][M][U]" when the entry is a submodule.
+                "C" indicates the submodule commit has changed.
+                "M" indicates the submodule has tracked changes.
+                "U" indicates the submodule has untracked changes.
+    <m*>        The file modes for the entry.
+                For unmerged entries, these are the stage 1, 2, and 3,
+                and the worktree modes.
+                For regular entries, these are the head, index, and
+                worktree modes; the fourth is zero.
+    <sha*>      The SHA1 values for the entry.
+                For unmerged entries, these are the stage 1,2, and 3 values.
+                For regular entries, these are the head and index values;
+                the third entry is zero.
+    R<nr>       The rename percentage score.
+    <path>      The current pathname. It is C-Quoted if necessary.
+    <pathSrc>   The original path. This is only present for staged renames.
+                It is C-Quoted if necessary.
+    --------------------------------------------------------
+
+A series of lines are then displayed for untracked and ignored entries.
+
+    <xx> <path>
+
+Where <xx> is "??" for untracked entries and "!!" for ignored entries.
+
+When the `-z` option is given, a NUL (zero) byte follows each pathname;
+serving as both a separator and line termination. No pathname quoting
+or backslash escaping is performed. All fields are output in the same
+order.
+
 CONFIGURATION
 -------------
 
-- 
2.8.0.rc4.17.gac42084.dirty

