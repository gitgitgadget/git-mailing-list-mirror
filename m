From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/4] Use BASE index extension in git-am.
Date: Sun, 08 Apr 2007 23:13:33 -0700
Message-ID: <7vwt0m3wj6.fsf@assigned-by-dhcp.cox.net>
References: <7vwt0uypz7.fsf@assigned-by-dhcp.cox.net>
	<7vhcrvti9i.fsf@assigned-by-dhcp.cox.net>
	<7vps6e5b93.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 08:14:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Han8q-0000Yn-QJ
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 08:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbXDIGON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 02:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbXDIGON
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 02:14:13 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48160 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbXDIGOK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 02:14:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409061334.MDEM27119.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Apr 2007 02:13:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kuDZ1W00B1kojtg0000000; Mon, 09 Apr 2007 02:13:34 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44044>

This makes git-am to record the expected HEAD location after
finishing its operation in the index, so that subsequent BASE
check would notice when somebody else updated your branch head
while you are looking the other way.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-am.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index e69ecbf..27912ce 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -13,6 +13,7 @@ git var GIT_COMMITTER_IDENT >/dev/null || exit
 
 stop_here () {
     echo "$1" >"$dotest/next"
+    git update-index --set-base $(git rev-parse --verify HEAD)
     exit 1
 }
 
@@ -157,6 +158,8 @@ do
 	esac
 done
 
+check_base || exit
+
 # If the dotest directory exists, but we have finished applying all the
 # patches in them, clear it out.
 if test -d "$dotest" &&
@@ -468,5 +471,6 @@ do
 
 	go_next
 done
+git update-index --set-base $(git rev-parse --verify HEAD)
 
 rm -fr "$dotest"
-- 
1.5.1.730.g0d43be
