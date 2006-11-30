X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] git-diff: Introduce --index and deprecate --cached.
Date: Thu, 30 Nov 2006 12:43:13 +0100
Message-ID: <20061130115913.EA36C5BA19@nox.op5.se>
NNTP-Posting-Date: Thu, 30 Nov 2006 11:59:29 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32726>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpkZT-0004sY-W7 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 12:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936240AbWK3L7Q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 06:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936241AbWK3L7P
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 06:59:15 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:36807 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S936240AbWK3L7P (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 06:59:15 -0500
Received: from nox.op5.se (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 3B8D46BCC2 for <git@vger.kernel.org>; Thu, 30 Nov
 2006 12:59:14 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500) id EA36C5BA19; Thu, 30 Nov
 2006 12:59:13 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

'git diff --cached' still works, but its use is discouraged
in the documentation. 'git diff --index' does the same thing
and is consistent with how 'git apply --index' works.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---
 Documentation/git-diff.txt |    6 ++++--
 builtin-diff.c             |    2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 228c4d9..3144864 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -22,8 +22,10 @@ the number of trees given to the command.
 
 * When one <tree-ish> is given, the working tree and the named
   tree are compared, using `git-diff-index`.  The option
-  `--cached` can be given to compare the index file and
+  `--index` can be given to compare the index file and
   the named tree.
+  `--cached` is a deprecated alias for `--index`. It's use is
+  discouraged.
 
 * When two <tree-ish>s are given, these two trees are compared
   using `git-diff-tree`.
@@ -47,7 +49,7 @@ Various ways to check your working tree::
 +
 ------------
 $ git diff            <1>
-$ git diff --cached   <2>
+$ git diff --index    <2>
 $ git diff HEAD       <3>
 ------------
 +
diff --git a/builtin-diff.c b/builtin-diff.c
index a659020..1c535b1 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -137,7 +137,7 @@ static int builtin_diff_index(struct rev_info *revs,
 	int cached = 0;
 	while (1 < argc) {
 		const char *arg = argv[1];
-		if (!strcmp(arg, "--cached"))
+		if (!strcmp(arg, "--index") || !strcmp(arg, "--cached"))
 			cached = 1;
 		else
 			usage(builtin_diff_usage);
-- 
1.4.4.1.GIT
