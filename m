From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 23/28] Convert merge-base program to args4j
Date: Thu, 17 Jul 2008 21:44:16 -0400
Message-ID: <1216345461-59382-24-git-send-email-spearce@spearce.org>
References: <1216345461-59382-1-git-send-email-spearce@spearce.org>
 <1216345461-59382-2-git-send-email-spearce@spearce.org>
 <1216345461-59382-3-git-send-email-spearce@spearce.org>
 <1216345461-59382-4-git-send-email-spearce@spearce.org>
 <1216345461-59382-5-git-send-email-spearce@spearce.org>
 <1216345461-59382-6-git-send-email-spearce@spearce.org>
 <1216345461-59382-7-git-send-email-spearce@spearce.org>
 <1216345461-59382-8-git-send-email-spearce@spearce.org>
 <1216345461-59382-9-git-send-email-spearce@spearce.org>
 <1216345461-59382-10-git-send-email-spearce@spearce.org>
 <1216345461-59382-11-git-send-email-spearce@spearce.org>
 <1216345461-59382-12-git-send-email-spearce@spearce.org>
 <1216345461-59382-13-git-send-email-spearce@spearce.org>
 <1216345461-59382-14-git-send-email-spearce@spearce.org>
 <1216345461-59382-15-git-send-email-spearce@spearce.org>
 <1216345461-59382-16-git-send-email-spearce@spearce.org>
 <1216345461-59382-17-git-send-email-spearce@spearce.org>
 <1216345461-59382-18-git-send-email-spearce@spearce.org>
 <1216345461-59382-19-git-send-email-spearce@spearce.org>
 <1216345461-59382-20-git-send-email-spearce@spearce.org>
 <1216345461-59382-21-git-send-email-spearce@spearce.org>
 <1216345461-59382-22-git-send-email-spearce@spearce.org>
 <1216345461-59382-23-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:47:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf4K-0006LD-Et
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbYGRBpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758159AbYGRBpx
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:45:53 -0400
Received: from george.spearce.org ([209.20.77.23]:47016 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758638AbYGRBpU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:45:20 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5A8E13841F; Fri, 18 Jul 2008 01:44:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1D55C38420;
	Fri, 18 Jul 2008 01:44:32 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-23-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88977>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/MergeBase.java        |   37 ++++++++++++--------
 1 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java
index c1648a0..c0ddd3b 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/MergeBase.java
@@ -37,27 +37,34 @@
 
 package org.spearce.jgit.pgm;
 
+import java.util.ArrayList;
+import java.util.List;
+
+import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.Option;
 import org.spearce.jgit.revwalk.RevCommit;
-import org.spearce.jgit.revwalk.RevWalk;
 import org.spearce.jgit.revwalk.filter.RevFilter;
 
 class MergeBase extends TextBuiltin {
-	@Override
-	public void execute(final String[] args) throws Exception {
-		final RevWalk walk = new RevWalk(db);
-		int max = 1;
-		for (final String a : args) {
-			if ("--".equals(a))
-				break;
-			else if ("--all".equals(a))
-				max = Integer.MAX_VALUE;
-			else
-				walk.markStart(walk.parseCommit(resolve(a)));
-		}
+	@Option(name = "--all", usage = "display all possible merge bases")
+	private boolean all;
 
-		walk.setRevFilter(RevFilter.MERGE_BASE);
+	@Argument(index = 0, metaVar = "commit-ish", required = true)
+	void commit_0(final RevCommit c) {
+		commits.add(c);
+	}
+
+	@Argument(index = 1, metaVar = "commit-ish", required = true)
+	private final List<RevCommit> commits = new ArrayList<RevCommit>();
+
+	@Override
+	protected void run() throws Exception {
+		for (final RevCommit c : commits)
+			argWalk.markStart(c);
+		argWalk.setRevFilter(RevFilter.MERGE_BASE);
+		int max = all ? Integer.MAX_VALUE : 1;
 		while (max-- > 0) {
-			final RevCommit b = walk.next();
+			final RevCommit b = argWalk.next();
 			if (b == null)
 				break;
 			out.println(b.getId());
-- 
1.5.6.3.569.ga9185
