From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 10/10] user-manual: listing commits reachable from some refs not others
Date: Mon, 14 May 2007 11:21:29 -0400
Message-ID: <35095.5721959055$1179156138@news.gmane.org>
References: <11791560893572-git-send-email->
 <1179156089759-git-send-email->
 <11791560893022-git-send-email->
 <11791560891179-git-send-email->
 <1179156089470-git-send-email->
 <11791560892667-git-send-email->
 <11791560901-git-send-email->
 <11791560901645-git-send-email->
 <1179156090113-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 17:22:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HncNL-0006P0-4T
	for gcvg-git@gmane.org; Mon, 14 May 2007 17:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756260AbXENPV6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 11:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756911AbXENPV6
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 11:21:58 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54971 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756260AbXENPVe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 11:21:34 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HncMc-0004zO-ED; Mon, 14 May 2007 11:21:30 -0400
X-Mailer: git-send-email 1.5.1.4.19.g69e2
In-Reply-To: <1179156090113-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47259>

From: J. Bruce Fields <bfields@citi.umich.edu>

This is just an amusing example raised by someone in irc.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   44 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d6ac29b..9fc2bba 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -830,6 +830,50 @@ available
 Which shows that e05db0fd is reachable from itself, from v1.5.0-rc1, and
 from v1.5.0-rc2, but not from v1.5.0-rc0.
 
+[[showing-commits-unique-to-a-branch]]
+Showing commits unique to a given branch
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Suppose you would like to see all the commits reachable from the branch
+head named "master" but not from any other head in your repository.
+
+You can list all the heads in this repository with
+gitlink:git-show-ref[1]:
+
+-------------------------------------------------
+$ git show-ref --heads
+bf62196b5e363d73353a9dcf094c59595f3153b7 refs/heads/core-tutorial
+db768d5504c1bb46f63ee9d6e1772bd047e05bf9 refs/heads/maint
+a07157ac624b2524a059a3414e99f6f44bebc1e7 refs/heads/master
+24dbc180ea14dc1aebe09f14c8ecf32010690627 refs/heads/tutorial-2
+1e87486ae06626c2f31eaa63d26fc0fd646c8af2 refs/heads/tutorial-fixes
+-------------------------------------------------
+
+We can get just the branch-head names, and remove "maint", with
+the help of the standard utilities cut and grep:
+
+-------------------------------------------------
+$ git show-ref --heads | cut -d' ' -f2 | grep -v '^refs/heads/maint'
+-------------------------------------------------
+
+And then we can ask to see all the commits reachable from maint
+but not from these other heads:
+
+-------------------------------------------------
+$ gitk maint --not $( git show-ref --heads | cut -d' ' -f2 |
+				grep -v '^refs/heads/maint' )
+-------------------------------------------------
+
+Obviously endless variations are possible; to see all commits
+reachable from some head but not from any tag in the repository:
+
+-------------------------------------------------
+$ gitk ($ git show-ref --heads ) --not  $( git show-ref --tags )
+-------------------------------------------------
+
+(See gitlink:git-rev-parse[1] for explanations of commit-selecting
+syntax such as `--not`.)
+
 [[making-a-release]]
 Creating a changelog and tarball for a software release
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
1.5.1.4.19.g69e2
