From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: fix overzealous output redirection
Date: Thu, 26 Jul 2007 07:35:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707260735150.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 26 08:36:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDwx6-00080A-RL
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 08:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875AbXGZGf5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 02:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756674AbXGZGf5
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 02:35:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:33286 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755914AbXGZGf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 02:35:56 -0400
Received: (qmail invoked by alias); 26 Jul 2007 06:35:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 26 Jul 2007 08:35:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wstZ5sU4wznvHLqBu29ELipVjEswX/E7+mZsDgB
	hl66ZRowoNQGzy
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53783>


When squashing, you no longer saw what the editor had to say to you
after commit 'Shut "git rebase -i" up when no --verbose was given'
(if you used a console based editor, at least).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
	This bit me real hard when cleaning up the work-tree patch
	series.

 git-rebase--interactive.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 93289c0..9a88335 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -250,10 +250,12 @@ do_next () {
 		case "$(peek_next_command)" in
 		squash)
 			EDIT_COMMIT=
+			USE_OUTPUT=output
 			cp "$MSG" "$SQUASH_MSG"
 		;;
 		*)
 			EDIT_COMMIT=-e
+			USE_OUTPUT=
 			test -f "$SQUASH_MSG" && rm "$SQUASH_MSG"
 		esac
 
@@ -267,7 +269,7 @@ do_next () {
 			# This is like --amend, but with a different message
 			eval "$author_script"
 			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
-			output git commit -F "$MSG" $EDIT_COMMIT
+			$USE_OUTPUT git commit -F "$MSG" $EDIT_COMMIT
 			;;
 		t)
 			cp "$MSG" "$GIT_DIR"/MERGE_MSG
-- 
1.5.3.rc2.42.gda8d-dirty
