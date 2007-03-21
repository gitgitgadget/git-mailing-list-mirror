From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] improve checkout message when asking for same branch
Date: Tue, 20 Mar 2007 22:26:47 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703202222280.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 21 03:27:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTqXd-0003Zx-Jq
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 03:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbXCUC0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 22:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbXCUC0x
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 22:26:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25427 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbXCUC0w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 22:26:52 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF8007SQESR3PP0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Mar 2007 22:26:51 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42772>

Change the feedback message if doing 'git checkout foo' when already on
branch "foo".

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/git-checkout.sh b/git-checkout.sh
index 39ffa8b..3c9b1bb 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -250,8 +250,13 @@ if [ "$?" -eq 0 ]; then
 	if test -n "$branch"
 	then
 		GIT_DIR="$GIT_DIR" git-symbolic-ref -m "checkout: moving to $branch" HEAD "refs/heads/$branch"
-		if test -z "$quiet"
+		if test -n "$quiet"
 		then
+			true	# nothing
+		elif test "refs/heads/$branch" = "$oldbranch"
+		then
+			echo >&2 "Already on branch \"$branch\""
+		else
 			echo >&2 "Switched to${newbranch:+ a new} branch \"$branch\""
 		fi
 	elif test -n "$detached"
