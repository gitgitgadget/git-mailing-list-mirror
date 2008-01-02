From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: allow dcommit --no-rebase to commit multiple, dependent changes
Date: Wed,  2 Jan 2008 10:09:49 -0800
Message-ID: <1199297389-20007-1-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 19:10:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA82j-0006uO-Sx
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 19:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbYABSJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 13:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbYABSJv
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 13:09:51 -0500
Received: from hand.yhbt.net ([66.150.188.102]:55857 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbYABSJu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 13:09:50 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id C5ED52DC034;
	Wed,  2 Jan 2008 10:09:49 -0800 (PST)
X-Mailer: git-send-email 1.5.4.rc2.16.g3ffc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69480>

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index c51f1e7..9b1113a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -418,7 +418,7 @@ sub cmd_dcommit {
 		warn "Attempting to commit more than one change while ",
 		     "--no-rebase is enabled.\n",
 		     "If these changes depend on each other, re-running ",
-		     "without --no-rebase will be required."
+		     "without --no-rebase may be required."
 	}
 	while (1) {
 		my $d = shift @$linear_refs or last;
@@ -453,6 +453,7 @@ sub cmd_dcommit {
 				                               $parents->{$d};
 			}
 			$_fetch_all ? $gs->fetch_all : $gs->fetch;
+			$last_rev = $cmt_rev;
 			next if $_no_rebase;
 
 			# we always want to rebase against the current HEAD,
@@ -512,7 +513,6 @@ sub cmd_dcommit {
 				$parents = \%p;
 				$linear_refs = \@l;
 			}
-			$last_rev = $cmt_rev;
 		}
 	}
 	unlink $gs->{index};
-- 
1.5.4.rc2.7.g6277-dirty
