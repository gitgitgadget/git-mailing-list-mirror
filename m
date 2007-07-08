From: skimo@liacs.nl
Subject: [PATCH 3/4] revision: mark commits that didn't match a pattern for later use
Date: Sun,  8 Jul 2007 18:23:26 +0200
Message-ID: <1183911808110-git-send-email-skimo@liacs.nl>
References: <11839118073186-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 18:24:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7ZYN-0003RT-BJ
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 18:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbXGHQXs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 12:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754572AbXGHQXr
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 12:23:47 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:60202 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564AbXGHQXi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 12:23:38 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l68GNSMu031442;
	Sun, 8 Jul 2007 18:23:33 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 9A0E23C00D; Sun,  8 Jul 2007 18:23:28 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc0.63.gc956
In-Reply-To: <11839118073186-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51893>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 revision.c |    4 +++-
 revision.h |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 0035d40..8d3bed2 100644
--- a/revision.c
+++ b/revision.c
@@ -1421,8 +1421,10 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		if (revs->no_merges &&
 		    commit->parents && commit->parents->next)
 			continue;
-		if (!commit_match(commit, revs))
+		if (!commit_match(commit, revs)) {
+			commit->object.flags |= PRUNED;
 			continue;
+		}
 		if (revs->prune_fn && revs->dense) {
 			/* Commit without changes? */
 			if (!(commit->object.flags & TREECHANGE)) {
diff --git a/revision.h b/revision.h
index 9728d4c..d3609ab 100644
--- a/revision.h
+++ b/revision.h
@@ -10,6 +10,7 @@
 #define CHILD_SHOWN	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
+#define PRUNED		(1u<<9)
 
 struct rev_info;
 struct log_info;
-- 
1.5.3.rc0.68.geec71-dirty
