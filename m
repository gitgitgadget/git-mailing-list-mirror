From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: move help to end of todo file
Date: Thu, 22 Nov 2007 11:15:51 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711221113360.27959@racer.site>
References: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:16:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvA2X-0005nk-Kw
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbXKVLP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbXKVLP4
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:15:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:49113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751266AbXKVLPz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:15:55 -0500
Received: (qmail invoked by alias); 22 Nov 2007 11:15:53 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp020) with SMTP; 22 Nov 2007 12:15:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/04h0onJz0xh197yH4wJHZEqTr5g1xCUCXBMVViR
	x6Y/pt+yxvhkSH
X-X-Sender: gene099@racer.site
In-Reply-To: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65792>


Many editors start in the first line, so the 9-line help text was an
annoyance.  So move it to the end.

Requested by Junio.

While at it, add a hint how to abort the rebase.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Thu, 22 Nov 2007, Junio C Hamano wrote:

	> Could we please reorder the lines so that list of initial 
	> "pick"s come first and have the help comment lines at the very 
	> end?

	How about this?  I am hesitant to remove _everything_, since quite 
	a few people seem to be allergic to man pages, so they fire up 
	rebase -i without any clue.

 git-rebase--interactive.sh |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a6dc72a..aca2fbb 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -480,20 +480,23 @@ do
 		SHORTHEAD=$(git rev-parse --short $HEAD)
 		SHORTONTO=$(git rev-parse --short $ONTO)
 		cat > "$TODO" << EOF
-# Rebasing $SHORTUPSTREAM..$SHORTHEAD onto $SHORTONTO
-#
+# Rebasing $SHORTUPSTREAM..$SHORTHEAD onto $SHORTONTO (see end for help)
+EOF
+		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
+			--abbrev=7 --reverse --left-right --cherry-pick \
+			$UPSTREAM...$HEAD | \
+			sed -n "s/^>/pick /p" >> "$TODO"
+		cat >> "$TODO" << EOF
+
 # Commands:
 #  pick = use commit
 #  edit = use commit, but stop for amending
 #  squash = use commit, but meld into previous commit
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
+# However, if you remove everything, the rebase will be aborted.
 #
 EOF
-		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
-			--abbrev=7 --reverse --left-right --cherry-pick \
-			$UPSTREAM...$HEAD | \
-			sed -n "s/^>/pick /p" >> "$TODO"
 
 		has_action "$TODO" ||
 			die_abort "Nothing to do"
-- 
1.5.3.6.1977.g54d30
