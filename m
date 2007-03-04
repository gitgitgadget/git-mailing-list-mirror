From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] user-manual: how to replace commits older than most recent
Date: Sun,  4 Mar 2007 16:59:14 -0500
Message-ID: <11730455602463-git-send-email-bfields@citi.umich.edu>
References: <1173045556191-git-send-email-bfields@citi.umich.edu> <11730455574115-git-send-email-bfields@citi.umich.edu> <1173045558959-git-send-email-bfields@citi.umich.edu> <11730455591178-git-send-email-bfields@citi.umich.edu> <11730455592152-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 23:08:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNysm-00081f-Ch
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 23:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbXCDWI0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 17:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbXCDWI0
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 17:08:26 -0500
Received: from pool-138-88-140-139.esr.east.verizon.net ([138.88.140.139]:50417
	"EHLO pad.fieldses.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752663AbXCDWIX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 17:08:23 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Mar 2007 17:08:19 EST
Received: from pad.fieldses.org (localhost [127.0.0.1] (may be forged))
	by pad.fieldses.org (8.13.8/8.13.8) with ESMTP id l24LxKM0006635;
	Sun, 4 Mar 2007 16:59:20 -0500
Received: (from bfields@localhost)
	by pad.fieldses.org (8.13.8/8.13.8/Submit) id l24LxK1j006634;
	Sun, 4 Mar 2007 16:59:20 -0500
X-Mailer: git-send-email 1.5.0.gb75812-dirty
In-Reply-To: <11730455592152-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41382>

From: J. Bruce Fields <bfields@citi.umich.edu>

"Modifying" an old commit by checking it out, --amend'ing it, then
rebasing on top of it, is a slightly cumbersome technique, but I've
found it useful frequently enough to make it seem worth documenting.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   46 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 33f8a72..907f122 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1333,6 +1333,7 @@ with the changes to be reverted, then you will be asked to fix
 conflicts manually, just as in the case of <<resolving-a-merge,
 resolving a merge>>.
 
+[[fixing-a-mistake-by-editing-history]]
 Fixing a mistake by editing history
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -1935,6 +1936,51 @@ return mywork to the state it had before you started the rebase:
 $ git rebase --abort
 -------------------------------------------------
 
+Modifying a single commit
+-------------------------
+
+We saw in <<fixing-a-mistake-by-editing-history>> that you can replace the
+most recent commit using
+
+-------------------------------------------------
+$ git commit --amend
+-------------------------------------------------
+
+which will replace the old commit by a new commit incorporating your
+changes, giving you a chance to edit the old commit message first.
+
+You can also use a combination of this and gitlink:git-rebase[1] to edit
+commits further back in your history.  First, tag the problematic commit with
+
+-------------------------------------------------
+$ git tag bad mywork~5
+-------------------------------------------------
+
+(Either gitk or git-log may be useful for finding the commit.)
+
+Then check out a new branch at that commit, edit it, and rebase the rest of
+the series on top of it:
+
+-------------------------------------------------
+$ git checkout -b TMP bad
+$ # make changes here and update the index
+$ git commit --amend
+$ git rebase --onto TMP bad mywork
+-------------------------------------------------
+
+When you're done, you'll be left with mywork checked out, with the top patches
+on mywork reapplied on top of the modified commit you created in TMP.  You can
+then clean up with
+
+-------------------------------------------------
+$ git branch -d TMP
+$ git tag -d bad
+-------------------------------------------------
+
+Note that the immutable nature of git history means that you haven't really
+"modified" existing commits; instead, you have replaced the old commits with
+new commits having new object names.
+
 Reordering or selecting from a patch series
 -------------------------------------------
 
-- 
1.5.0.gb75812-dirty
