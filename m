From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH] RevWalk: Fix RevSort.REVERSE combined with RevSort.TOPO
Date: Sun,  7 Sep 2008 14:00:08 -0700
Message-ID: <1220821208-13420-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <sop@google.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 23:01:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcRNq-0002lV-Js
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 23:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbYIGVAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 17:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755497AbYIGVAL
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 17:00:11 -0400
Received: from george.spearce.org ([209.20.77.23]:36176 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179AbYIGVAK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 17:00:10 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2B63338360; Sun,  7 Sep 2008 21:00:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 75C4738355;
	Sun,  7 Sep 2008 21:00:08 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.319.g9f32b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95175>

From: Shawn O. Pearce <sop@google.com>

The reverse sort was using the initial pending queue, not the
generator that comes before it in the workflow.  This caused
a combination of TOPO and REVERSE to return no commits.

Signed-off-by: Shawn O. Pearce <sop@google.com>
---
 .../org/spearce/jgit/revwalk/StartGenerator.java   |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java
index 7ddcd3c..1b7947f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/StartGenerator.java
@@ -144,7 +144,7 @@ RevCommit next() throws MissingObjectException,
 				&& (g.outputType() & SORT_TOPO) == 0)
 			g = new TopoSortGenerator(g);
 		if (walker.hasRevSort(RevSort.REVERSE))
-			g = new LIFORevQueue(q);
+			g = new LIFORevQueue(g);
 		if (boundary)
 			g = new BoundaryGenerator(w, g);
 
-- 
1.6.0.1.319.g9f32b
