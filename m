From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH v2 RFC] rebase-i-p: use HEAD for updating the ref instead of mapping OLDHEAD
Date: Wed,  8 Oct 2008 01:41:52 -0500
Message-ID: <e1cac64070f53f4f217a3b8e8c0f855f23691725.1223445353.git.stephen@exigencecorp.com>
References: <cover.1223445353.git.stephen@exigencecorp.com>
 <e5ababa1de420b6460fd856679990c9dd2caf1d1.1223445353.git.stephen@exigencecorp.com>
Cc: spearce@spearce.org, Stephen Haberman <stephen@exigencecorp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 08:43:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnSlQ-0006jp-BH
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 08:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbYJHGmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 02:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753479AbYJHGmH
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 02:42:07 -0400
Received: from smtp132.sat.emailsrvr.com ([66.216.121.132]:60994 "EHLO
	smtp132.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbYJHGmB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 02:42:01 -0400
Received: from relay3.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay3.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id C1145253463;
	Wed,  8 Oct 2008 02:42:00 -0400 (EDT)
Received: by relay3.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 45777253461;
	Wed,  8 Oct 2008 02:42:00 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <e5ababa1de420b6460fd856679990c9dd2caf1d1.1223445353.git.stephen@exigencecorp.com>
In-Reply-To: <cover.1223445353.git.stephen@exigencecorp.com>
References: <cover.1223445353.git.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97765>

If OLDHEAD was reordered in the todo, and its mapped NEWHEAD was used to set the
ref, commits reordered after OLDHEAD in the todo would should up as un-committed
changes.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
 git-rebase--interactive.sh |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index edb6ec6..b7eda66 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -350,20 +350,7 @@ do_next () {
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
