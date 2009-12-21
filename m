From: Andrew Myrick <amyrick@apple.com>
Subject: [PATCH] git-svn: Remove obsolete MAXPARENT check
Date: Mon, 21 Dec 2009 14:22:54 -0800
Message-ID: <1261434174-298-1-git-send-email-amyrick@apple.com>
Content-Transfer-Encoding: 7BIT
Cc: sam@vilain.net, normalperson@yhbt.net,
	Andrew Myrick <amyrick@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 23:30:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMqln-0003Wl-7N
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 23:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbZLUWaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 17:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbZLUWaV
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 17:30:21 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:56471 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbZLUWaT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 17:30:19 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2009 17:30:19 EST
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out4.apple.com (Postfix) with ESMTP id 27C51834B97C
	for <git@vger.kernel.org>; Mon, 21 Dec 2009 14:23:07 -0800 (PST)
X-AuditID: 11807134-b7cd9ae000001002-ca-4b2ff54a0d4d
Received: from elliott.apple.com (elliott.apple.com [17.151.62.13])
	by relay14.apple.com (Apple SCV relay) with SMTP id 7B.03.04098.B45FF2B4; Mon, 21 Dec 2009 14:23:07 -0800 (PST)
Received: from localhost.localdomain (integrity.apple.com [17.201.24.194])
 by elliott.apple.com
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPSA id <0KV00094GWUFQD10@elliott.apple.com> for git@vger.kernel.org;
 Mon, 21 Dec 2009 14:23:06 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc3.dirty
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135567>

Change git-svn not to impose a limit of 16 parents on a merge.

This limit in git-svn artificially prevents cloning svn repositories
that contain commits with more than 16 merge parents.

The limit was removed from builtin-commit-tree.c for git v1.6.0 in commit
ef98c5cafb3e799b1568bb843fcd45920dc62f16, so there is no need to check for it
it in git-svn.

Signed-off-by: Andrew Myrick <amyrick@apple.com>
---
 git-svn.perl |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0a6460e..92c40da 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2447,12 +2447,6 @@ sub get_commit_parents {
 		next if $seen{$p};
 		$seen{$p} = 1;
 		push @ret, $p;
-		# MAXPARENT is defined to 16 in commit-tree.c:
-		last if @ret >= 16;
-	}
-	if (@tmp) {
-		die "r$log_entry->{revision}: No room for parents:\n\t",
-		    join("\n\t", @tmp), "\n";
 	}
 	@ret;
 }
-- 
1.6.6.rc3.dirty
