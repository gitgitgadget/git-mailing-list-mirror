From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Attempt to improve git-rebase lead-in description.
Date: Sat, 17 Feb 2007 04:31:50 -0500
Message-ID: <20070217093150.GA25871@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 10:32:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HILvN-0005ps-9Y
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 10:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbXBQJb5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 04:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbXBQJb5
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 04:31:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34825 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965093AbXBQJb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 04:31:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HILv5-0002NF-Ub; Sat, 17 Feb 2007 04:31:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9B22020FBAE; Sat, 17 Feb 2007 04:31:51 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39980>

It was mentioned on #git this morning that the lead-in description
of git-rebase is very confusing.  Too many branch this and branch
that in a very short run of text.

This new description attempts to walk the user through the command
syntax, while also describing exactly what git-rebase is doing to
their repository.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-rebase.txt |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f2ef1f7..a66b2d7 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -13,11 +13,20 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-git-rebase replaces <branch> with a new branch of the same name.  When
-the --onto option is provided the new branch starts out with a HEAD equal
-to <newbase>, otherwise it is equal to <upstream>.  It then attempts to
-create a new commit for each commit from the original <branch> that does
-not exist in the <upstream> branch.
+If <branch> is specified, git-rebase will perform an automatic
+`git checkout <branch>` before doing anything else.  Otherwise
+it remains on the current branch.
+
+All changes made by commits in the current branch but that are not
+in <upstream> are saved to a temporary area.  This is the same set
+of commits that would be shown by `git log <upstream>..HEAD`.
+
+The current branch is reset to <upstream>, or <newbase> if the
+--onto option was supplied.  This has the exact same effect as
+`git reset --hard <upstream>` (or <newbase>).
+
+The commits that were previously saved into the temporary area are
+then reapplied to the current branch, one by one, in order.
 
 It is possible that a merge failure will prevent this process from being
 completely automatic.  You will have to resolve any such merge failure
@@ -26,9 +35,6 @@ that caused the merge failure with `git rebase --skip`.  To restore the
 original <branch> and remove the .dotest working files, use the command
 `git rebase --abort` instead.
 
-Note that if <branch> is not specified on the command line, the currently
-checked out branch is used.
-
 Assume the following history exists and the current branch is "topic":
 
 ------------
-- 
1.5.0.552.ge1b1c
