From: skimo@liacs.nl
Subject: [PATCH 5/6] revision: mark commits that didn't match a pattern for later use
Date: Thu, 12 Jul 2007 21:06:02 +0200
Message-ID: <11842671632265-git-send-email-skimo@liacs.nl>
References: <11842671631744-git-send-email-skimo@liacs.nl>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 21:08:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I941Y-0004QU-9v
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 21:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080AbXGLTIJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 15:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755679AbXGLTIJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 15:08:09 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:46143 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755378AbXGLTIH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 15:08:07 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l6CJ69oS029840;
	Thu, 12 Jul 2007 21:06:14 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id E51A33C00F; Thu, 12 Jul 2007 21:06:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc0.63.gc956
In-Reply-To: <11842671631744-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52328>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 revision.c |    4 +++-
 revision.h |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 38061f9..cbeb137 100644
--- a/revision.c
+++ b/revision.c
@@ -1446,8 +1446,10 @@ static struct commit *get_revision_1(struct rev_info *revs)
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
1.5.3.rc0.100.ge60b4
