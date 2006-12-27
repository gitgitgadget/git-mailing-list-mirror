From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] git-svn: dcommit should diff against the current HEAD after committing
Date: Tue, 26 Dec 2006 16:27:38 -0800
Message-ID: <11671792603888-git-send-email-normalperson@yhbt.net>
References: <1167179258485-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 27 01:27:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzMe3-0008Fm-7P
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 01:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860AbWL0A1n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 19:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbWL0A1m
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 19:27:42 -0500
Received: from hand.yhbt.net ([66.150.188.102]:41801 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932866AbWL0A1l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 19:27:41 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 71C1B7DC031;
	Tue, 26 Dec 2006 16:27:40 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 26 Dec 2006 16:27:40 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.4.3.gd4ada
In-Reply-To: <1167179258485-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35438>

This is a followup to dd31da2fdc199132c9fd42023aea5b33672d73cc.
Regardless of whether we commit an alternate head, we always
diff-tree based on the current HEAD, and rebase against our
remote reference as necessary.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4288a05..c2cdceb 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -512,15 +512,15 @@ sub dcommit {
 	}
 	return if $_dry_run;
 	fetch();
-	my @diff = command('diff-tree', $head, $gs, '--');
+	my @diff = command('diff-tree', 'HEAD', $gs, '--');
 	my @finish;
 	if (@diff) {
 		@finish = qw/rebase/;
 		push @finish, qw/--merge/ if $_merge;
 		push @finish, "--strategy=$_strategy" if $_strategy;
-		print STDERR "W: $head and $gs differ, using @finish:\n", @diff;
+		print STDERR "W: HEAD and $gs differ, using @finish:\n", @diff;
 	} else {
-		print "No changes between current $head and $gs\n",
+		print "No changes between current HEAD and $gs\n",
 		      "Resetting to the latest $gs\n";
 		@finish = qw/reset --mixed/;
 	}
-- 
1.4.4.3.gd4ada
