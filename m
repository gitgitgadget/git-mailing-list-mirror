From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: support single-letter abbreviations for the
 actions
Date: Sat, 29 Sep 2007 02:31:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709290231300.28395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 03:33:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbRCa-00039x-IO
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 03:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbXI2Bc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 21:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbXI2Bc6
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 21:32:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:58683 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752294AbXI2Bc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 21:32:57 -0400
Received: (qmail invoked by alias); 29 Sep 2007 01:32:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 29 Sep 2007 03:32:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Re79BEmXRQwl3NlP1+AZPoNkJMHA4+WbANqsZWb
	yYzC6moRlXKZte
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59438>


When you do many rebases, you can get annoyed by having to type out
the actions "edit" or "squash" in total.

This commit helps that, by allowing you to enter "e" instead of "edit",
or "s" instead of "squash", and it also plays nice with "merge" or "amend"
as synonyms to "squash".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 823291d..0f9483e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -232,14 +232,14 @@ do_next () {
 	'#'*|'')
 		mark_action_done
 		;;
-	pick)
+	pick|p)
 		comment_for_reflog pick
 
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		;;
-	edit)
+	edit|e)
 		comment_for_reflog edit
 
 		mark_action_done
@@ -254,7 +254,7 @@ do_next () {
 		warn
 		exit 0
 		;;
-	squash)
+	squash|s|merge|m|amend|a)
 		comment_for_reflog squash
 
 		has_action "$DONE" ||
@@ -263,7 +263,7 @@ do_next () {
 		mark_action_done
 		make_squash_message $sha1 > "$MSG"
 		case "$(peek_next_command)" in
-		squash)
+		squash|s|merge|m|amend|a)
 			EDIT_COMMIT=
 			USE_OUTPUT=output
 			cp "$MSG" "$SQUASH_MSG"
-- 
1.5.3.2.1102.g9487
