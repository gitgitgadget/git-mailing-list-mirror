From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH] consistently try VISUAL, EDITOR and vi in this order.
Date: Sun, 02 Jul 2006 19:47:55 -0700
Message-ID: <7vmzbrv1yc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 03 04:48:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxETm-0001i1-2H
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 04:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWGCCr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 22:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWGCCr5
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 22:47:57 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:62361 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751009AbWGCCr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 22:47:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703024756.KBHS18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 22:47:56 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23151>

git grep -e VISUAL -e EDITOR revealed this inconsistency.  All
other commands seem to check VISUAL and then EDITOR as they should.

---
diff --git a/git-send-email.perl b/git-send-email.perl
index c5d9e73..7b81962 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -222,8 +256,7 @@ GIT: for the patch you are writing.
 EOT
 	close(C);
 
-	my $editor = $ENV{EDITOR};
-	$editor = 'vi' unless defined $editor;
+	my $editor = $ENV{VISUAL} || $ENV{EDITOR} || 'vi';
 	system($editor, $compose_filename);
 
 	open(C2,">",$compose_filename . ".final")
