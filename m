From: Evan Phoenix <evan@fallingsnow.net>
Subject: [PATCH] A more sensible error message why 'git rebase --continue' failed
Date: Sun, 19 Aug 2007 18:13:38 -0700
Message-ID: <11875724181583-git-send-email-evan@fallingsnow.net>
Cc: Evan Phoenix <evan@fallingsnow.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 03:14:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMvqB-0003P6-S5
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 03:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbXHTBNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 21:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753098AbXHTBNp
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 21:13:45 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:35482 "EHLO
	rwcrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbXHTBNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 21:13:45 -0400
Received: from localhost.localdomain (cpe-76-170-39-112.socal.res.rr.com[76.170.39.112])
          by comcast.net (rwcrmhc11) with SMTP
          id <20070820011338m1100150eee>; Mon, 20 Aug 2007 01:13:42 +0000
X-Mailer: git-send-email 1.5.3.rc5.41.gc1c22
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56162>

The current message is a bit cryptic, indicating that only changes which contained
merge conflicts should be added to the index, but in fact, all outstanding
changes must be.

The change could also incorporate a -i that prompts the user and performs
'git add -u' if they wish, allowing the rebase to properly continue.

Signed-off-by: Evan Phoenix <evan@fallingsnow.net>

diff --git a/git-rebase.sh b/git-rebase.sh
index cbafa14..c67f29a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -135,8 +135,12 @@ do
 	case "$1" in
 	--continue)
 		git diff-files --quiet || {
-			echo "You must edit all merge conflicts and then"
-			echo "mark them as resolved using git add"
+                        echo "Unable to continue rebase:"
+                        echo "  All modified files must be added to index first."
+                        echo "  Use 'git add' to resolve them and add them to the index."
+                        echo
+                        echo "Outstanding files:"
+                        git diff-files --name-status
 			exit 1
 		}
 		if test -d "$dotest"
-- 
1.5.3.rc5.41.gc1c22
