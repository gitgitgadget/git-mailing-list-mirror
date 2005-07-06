From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Tidy up - slight simplification of rev-list.c
Date: Wed, 06 Jul 2005 18:12:34 +1000
Message-ID: <20050706081234.14219.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 10:14:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq53L-0006qP-7f
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 10:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVGFIOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 04:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVGFIOM
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 04:14:12 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:40067 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262201AbVGFIMh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 04:12:37 -0400
Received: (qmail 14229 invoked by uid 500); 6 Jul 2005 08:12:34 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch implements a small tidy up of rev-list.c to reduce
(but not eliminate) the amount of ugliness associated
with the merge_order flag.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
Linus: I decided not to abstract this out as a function
as _too_ much abstraction can be a bad thing from a
readability point of view. Let me know if you disagree.
---

 rev-list.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

34a034b978c6b946fafdf41b42c5f67ee9c94599
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -78,19 +78,15 @@ static void show_commit(struct commit *c
 
 static int filter_commit(struct commit * commit)
 {
-	if (merge_order && stop_traversal && commit->object.flags & BOUNDARY)
+	if (stop_traversal && (commit->object.flags & BOUNDARY))
 		return STOP;
 	if (commit->object.flags & (UNINTERESTING|SHOWN))
 		return CONTINUE;
 	if (min_age != -1 && (commit->date > min_age))
 		return CONTINUE;
 	if (max_age != -1 && (commit->date < max_age)) {
-		if (!merge_order)
-			return STOP;
-		else {
-			stop_traversal = 1;
-			return CONTINUE;
-		}
+		stop_traversal=1;
+		return merge_order?CONTINUE:STOP;
 	}
 	if (max_count != -1 && !max_count--)
 		return STOP;
------------
