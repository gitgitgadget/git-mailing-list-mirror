From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 22/28] Convert ls-tree program to args4j
Date: Thu, 17 Jul 2008 21:44:15 -0400
Message-ID: <1216345461-59382-23-git-send-email-spearce@spearce.org>
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
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:47:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf4J-0006LD-Po
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbYGRBpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758316AbYGRBpt
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:45:49 -0400
Received: from george.spearce.org ([209.20.77.23]:47017 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758627AbYGRBpT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:45:19 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 114EA3841D; Fri, 18 Jul 2008 01:44:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B4B6A3841F;
	Fri, 18 Jul 2008 01:44:31 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
In-Reply-To: <1216345461-59382-22-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88969>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/LsTree.java           |   42 ++++++--------------
 1 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java
index a0a7216..8d4937f 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsTree.java
@@ -37,40 +37,26 @@
 
 package org.spearce.jgit.pgm;
 
-import java.io.File;
-
+import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.Option;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.FileMode;
-import org.spearce.jgit.treewalk.FileTreeIterator;
+import org.spearce.jgit.treewalk.AbstractTreeIterator;
 import org.spearce.jgit.treewalk.TreeWalk;
 
 class LsTree extends TextBuiltin {
-	@Override
-	public void execute(final String[] args) throws Exception {
-		final TreeWalk walk = new TreeWalk(db);
-		int argi = 0;
-		for (; argi < args.length; argi++) {
-			final String a = args[argi];
-			if ("--".equals(a)) {
-				argi++;
-				break;
-			} else if ("-r".equals(a))
-				walk.setRecursive(true);
-			else
-				break;
-		}
+	@Option(name = "--recursive", usage = "recurse into subtrees", aliases = { "-r" })
+	private boolean recursive;
 
-		if (argi == args.length)
-			throw die("usage: [-r] treename");
-		else if (argi + 1 < args.length)
-			throw die("too many arguments");
+	@Argument(index = 0, required = true, metaVar = "tree-ish")
+	private AbstractTreeIterator tree;
 
+	@Override
+	protected void run() throws Exception {
+		final TreeWalk walk = new TreeWalk(db);
 		walk.reset(); // drop the first empty tree, which we do not need here
-		final String n = args[argi];
-		if (is_WorkDir(n))
-			walk.addTree(new FileTreeIterator(new File(n)));
-		else
-			walk.addTree(resolve(n));
+		walk.setRecursive(recursive);
+		walk.addTree(tree);
 
 		while (walk.next()) {
 			final FileMode mode = walk.getFileMode(0);
@@ -88,8 +74,4 @@ class LsTree extends TextBuiltin {
 			out.println();
 		}
 	}
-
-	private boolean is_WorkDir(final String name) {
-		return new File(name).isDirectory();
-	}
 }
-- 
1.5.6.3.569.ga9185
