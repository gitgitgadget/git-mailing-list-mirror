From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Show an example of deleting commits with git-rebase.
Date: Mon, 5 Feb 2007 15:21:06 -0500
Message-ID: <20070205202106.GA8755@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 21:21:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEAKz-0005YE-2A
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 21:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933270AbXBEUVM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 15:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933341AbXBEUVM
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 15:21:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35080 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933270AbXBEUVL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 15:21:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEAKi-00068F-R0; Mon, 05 Feb 2007 15:21:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F1CC420FBAE; Mon,  5 Feb 2007 15:21:06 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38778>

This particular use of git-rebase to remove a single commit or a
range of commits from the history of a branch recently came up on
the mailing list.  Documenting the example should help other users
arrive at the same solution on their own.

It also was not obvious to the newcomer that git-rebase is able to
accept any commit for --onto <newbase> and <upstream>.  We should
at least minimally document this, as much of the language in
git-rebase's manpage refers to 'branch' rather than 'committish'.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-rebase.txt |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0cb9e1f..977f661 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -114,6 +114,27 @@ would result in:
 
 This is useful when topicB does not depend on topicA.
 
+A range of commits could also be removed with rebase.  If we have
+the following situation:
+
+------------
+    E---F---G---H---I---J  topicA
+------------
+
+then the command
+
+    git-rebase --onto topicA~5 topicA~2 topicA
+
+would result in the removal of commits F and G:
+
+------------
+    E---H'---I'---J'  topicA
+------------
+
+This is useful if F and G were flawed in some way, or should not be
+part of topicA.  Note that the argument to --onto and the <upstream>
+parameter can be any valid commit-ish.
+
 In case of conflict, git-rebase will stop at the first problematic commit
 and leave conflict markers in the tree.  You can use git diff to locate
 the markers (<<<<<<) and make edits to resolve the conflict.  For each
@@ -141,10 +162,12 @@ OPTIONS
 <newbase>::
 	Starting point at which to create the new commits. If the
 	--onto option is not specified, the starting point is
-	<upstream>.
+	<upstream>.  May be any valid commit, and not just an
+	existing branch name.
 
 <upstream>::
-	Upstream branch to compare against.
+	Upstream branch to compare against.  May be any valid commit,
+	not just an existing branch name.
 
 <branch>::
 	Working branch; defaults to HEAD.
-- 
1.5.0.rc3.58.g79812
