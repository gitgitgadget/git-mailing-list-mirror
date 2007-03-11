From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] git-merge: warn when -m provided on a fast forward
Date: Sun, 11 Mar 2007 12:28:56 -0400
Message-ID: <20070311162856.GB629@fieldses.org>
References: <200703111505.l2BF54Kq006625@localhost.localdomain> <20070311160424.GA629@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Xavier Maillard <zedek@gnu.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 17:28:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQQu7-0002cZ-7d
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 17:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933812AbXCKQ2M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 12:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933814AbXCKQ2M
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 12:28:12 -0400
Received: from mail.fieldses.org ([66.93.2.214]:60723 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933812AbXCKQ2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 12:28:12 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HQQum-0002iP-CC; Sun, 11 Mar 2007 12:28:56 -0400
Content-Disposition: inline
In-Reply-To: <20070311160424.GA629@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41940>

Warn the user that the "-m" option is ignored in the case of a fast
forward.  That may save some confusion in the case where the user
doesn't know about fast forwards yet and may not realize that the
behavior here is intentional.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 git-merge.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 4afcd95..8b6fcf0 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -294,7 +294,12 @@ f,*)
 	git-update-index --refresh 2>/dev/null
 	new_head=$(git-rev-parse --verify "$1^0") &&
 	git-read-tree -v -m -u --exclude-per-directory=.gitignore $head "$new_head" &&
-	finish "$new_head" "Fast forward" || exit
+	msg="Fast forward"
+	if test -n "$have_message"
+	then
+		msg="$msg (no commit created; -m option ignored)"
+	fi
+	finish "$new_head" "$msg" || exit
 	dropsave
 	exit 0
 	;;
-- 
1.5.0.gb75812-dirty
