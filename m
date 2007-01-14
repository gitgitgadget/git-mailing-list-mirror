From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Display a progress meter during merge-recursive.
Date: Sun, 14 Jan 2007 11:11:06 -0800
Message-ID: <7vwt3pfmph.fsf@assigned-by-dhcp.cox.net>
References: <d352c8adb1ec1c4e74b33d51d397d5756b82ceac.1168752482.git.spearce@spearce.org>
	<20070114052858.GD19113@spearce.org>
	<Pine.LNX.4.63.0701141404160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 15 19:30:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VWZ-0000tq-EF
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:21:35 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V7s-0003eK-2e
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbXANTLO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 14:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbXANTLL
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 14:11:11 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:58381 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbXANTLI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 14:11:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070114191107.OZLE25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Sun, 14 Jan 2007 14:11:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id B7BP1W00J1kojtg0000000; Sun, 14 Jan 2007 14:11:24 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36825>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> this is a nice idea, but I think you lack a "if (!isatty(1)) do_progress = 
> 0;" somewhere.

Very true.  Something like this?

diff --git a/merge-recursive.c b/merge-recursive.c
index 27a861b..fa320eb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1335,6 +1335,8 @@ int main(int argc, char *argv[])
 		buffer_output = 0;
 		do_progress = 0;
 	}
+	else
+		do_progress = isatty(1);
 
 	branch1 = argv[++i];
 	branch2 = argv[++i];
@@ -1344,10 +1346,7 @@ int main(int argc, char *argv[])
 
 	branch1 = better_branch_name(branch1);
 	branch2 = better_branch_name(branch2);
-	if (verbosity >= 5) {
-		buffer_output = 0;
-		do_progress = 0;
-	}
+
 	if (do_progress)
 		setup_progress_signal();
 	if (show(3))
