From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] merge-recursive: fix longstanding bug in merging symlinks
Date: Sun, 25 Feb 2007 18:47:40 -0800
Message-ID: <7vtzx9prcj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 26 03:47:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLVtv-0007Xr-Bz
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 03:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933736AbXBZCrl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 21:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933743AbXBZCrl
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 21:47:41 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:49288 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933736AbXBZCrk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 21:47:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070226024741.XYRZ233.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 21:47:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U2nf1W00Q1kojtg0000000; Sun, 25 Feb 2007 21:47:40 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40607>

Commit 3af244ca added unlink before running symlink to update
the working tree with the merge result, but it was unlinking a
wrong file  This resulted in loss of the path pointed by a
symlink.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * This and the fix to merge-index are meant for maint to be
   included in 1.5.0.2.

 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5898942..397a7ad 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -589,7 +589,7 @@ static void update_file_flags(const unsigned char *sha,
 			memcpy(lnk, buf, size);
 			lnk[size] = '\0';
 			mkdir_p(path, 0777);
-			unlink(lnk);
+			unlink(path);
 			symlink(lnk, path);
 		} else
 			die("do not know what to do with %06o %s '%s'",
-- 
1.5.0.1.793.gedfd5
