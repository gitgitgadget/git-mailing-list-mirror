From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH] rebase-i-p: use HEAD for updating the ref instead of mapping OLDHEAD
Date: Wed, 15 Oct 2008 02:44:35 -0500
Message-ID: <ef8c08551dca1ddfea0017fd4026ac9ae60fbfec.1224055978.git.stephen@exigencecorp.com>
References: <cover.1224055978.git.stephen@exigencecorp.com>
 <79b3f186dc599ebb5e251d5c0ca93c233263974c.1224055978.git.stephen@exigencecorp.com>
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 15 09:46:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq152-00012V-B5
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbYJOHox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 03:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbYJOHou
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:44:50 -0400
Received: from smtp162.sat.emailsrvr.com ([66.216.121.162]:49871 "EHLO
	smtp162.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbYJOHop (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 03:44:45 -0400
Received: from relay6.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay6.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 464331E06AE;
	Wed, 15 Oct 2008 03:44:45 -0400 (EDT)
Received: by relay6.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id BCE221E0660;
	Wed, 15 Oct 2008 03:44:44 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <79b3f186dc599ebb5e251d5c0ca93c233263974c.1224055978.git.stephen@exigencecorp.com>
In-Reply-To: <cover.1224055978.git.stephen@exigencecorp.com>
References: <cover.1224055978.git.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98248>

If OLDHEAD was reordered in the todo, and its mapped NEWHEAD was used to set the
ref, commits reordered after OLDHEAD in the todo would should up as un-committed
changes.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
 git-rebase--interactive.sh |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 30e4523..c968117 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -376,20 +376,7 @@ do_next () {
 	HEADNAME=$(cat "$DOTEST"/head-name) &&
 	OLDHEAD=$(cat "$DOTEST"/head) &&
 	SHORTONTO=$(git rev-parse --short $(cat "$DOTEST"/onto)) &&
-	if test -d "$REWRITTEN"
-	then
-		test -f "$DOTEST"/current-commit &&
-			current_commit=$(cat "$DOTEST"/current-commit) &&
-			git rev-parse HEAD > "$REWRITTEN"/$current_commit
-		if test -f "$REWRITTEN"/$OLDHEAD
-		then
-			NEWHEAD=$(cat "$REWRITTEN"/$OLDHEAD)
-		else
-			NEWHEAD=$OLDHEAD
-		fi
-	else
-		NEWHEAD=$(git rev-parse HEAD)
-	fi &&
+	NEWHEAD=$(git rev-parse HEAD) &&
 	case $HEADNAME in
 	refs/*)
 		message="$GIT_REFLOG_ACTION: $HEADNAME onto $SHORTONTO)" &&
-- 
1.6.0.2
