From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] rebase -i: support single-letter abbreviations for the
 actions
Date: Sat, 29 Sep 2007 03:32:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709290323560.28395@racer.site>
References: <Pine.LNX.4.64.0709290231300.28395@racer.site>
 <7vfy0ymd7g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 04:33:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbS95-0005Y2-0i
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 04:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbXI2CdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 22:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794AbXI2CdV
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 22:33:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:54747 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752222AbXI2CdV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 22:33:21 -0400
Received: (qmail invoked by alias); 29 Sep 2007 02:33:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 29 Sep 2007 04:33:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19LV7wZpQpLt4Dzha94bj9ropzRaP+XX/MgnPnpsN
	LW5NHULhrhT9Dq
X-X-Sender: gene099@racer.site
In-Reply-To: <7vfy0ymd7g.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59440>


When you do many rebases, you can get annoyed by having to type out
the actions "edit" or "squash" in total.

This commit helps that, by allowing you to enter "e" instead of "edit",
"p" instead of "pick", or "s" instead of "squash".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 28 Sep 2007, Junio C Hamano wrote:

	> I am not sure if we want to taint the words merge and amend like
	> this.  I was hoping someday you would allow people to reorder
	> something like this...

	Okay, you convinced me.

	> 
	>           e
	>            \     
	>  ---a---b---c---d
	> 
	> into something like this:
	> 
	>       e
	>        \     
	>  ---b'--c'--a'+d'

	I thought that this would be possible with "git rebase -p -i"?

	Ah no, that does not work; "-p" is not yet graceful enough to 
	accept reorders.  (But then, I do not see why the command should 
	be "merge" instead of the "pick" we already have...)

 git-rebase--interactive.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 823291d..7a5aaa5 100755
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
+	squash|s)
 		comment_for_reflog squash
 
 		has_action "$DONE" ||
@@ -263,7 +263,7 @@ do_next () {
 		mark_action_done
 		make_squash_message $sha1 > "$MSG"
 		case "$(peek_next_command)" in
-		squash)
+		squash|s)
 			EDIT_COMMIT=
 			USE_OUTPUT=output
 			cp "$MSG" "$SQUASH_MSG"
-- 
1.5.3.2.1102.g9487
