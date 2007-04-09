From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/4] Teach git-reset to use index BASE extension.
Date: Sun, 08 Apr 2007 23:13:35 -0700
Message-ID: <7vlkh23wj4.fsf@assigned-by-dhcp.cox.net>
References: <7vwt0uypz7.fsf@assigned-by-dhcp.cox.net>
	<7vhcrvti9i.fsf@assigned-by-dhcp.cox.net>
	<7vps6e5b93.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 08:14:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Han96-0000cT-Pz
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 08:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbXDIGOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 02:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752999AbXDIGOR
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 02:14:17 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:60043 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbXDIGOL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 02:14:11 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409061335.UZEX28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Apr 2007 02:13:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kuDb1W0071kojtg0000000; Mon, 09 Apr 2007 02:13:35 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44045>

After resetting the HEAD to point at a different commit, the
user obviously intends to make the next commit a child of the
updated HEAD commit.  Record it in the index so that we can
detect the case where somebody else updates the tip of the
current branch while we are looking the other way.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-reset.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-reset.sh b/git-reset.sh
index fee6d98..982c726 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -71,7 +71,7 @@ then
 		die "Cannot do a soft reset in the middle of a merge."
 	fi
 else
-	git-read-tree --reset $update "$rev" || exit
+	git-read-tree --reset $update --set-base="$rev" "$rev" || exit
 fi
 
 # Any resets update HEAD to the head being switched to.
@@ -93,10 +93,11 @@ case "$reset_type" in
 	}
 	;;
 --soft )
-	;; # Nothing else to do
+	git-update-index --set-base "$rev"
+	;;
 --mixed )
 	# Report what has not been updated.
-	git-update-index --refresh
+	git-update-index --set-base "$rev" --refresh
 	;;
 esac
 
-- 
1.5.1.730.g0d43be
