From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/10] Expose the raw path for the current entry of a TreeWalk
Date: Thu, 22 Jan 2009 15:28:02 -0800
Message-ID: <1232666890-23488-3-git-send-email-spearce@spearce.org>
References: <1232666890-23488-1-git-send-email-spearce@spearce.org>
 <1232666890-23488-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 00:29:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ8zW-0007uv-Eg
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 00:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758278AbZAVX2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 18:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757572AbZAVX2Q
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 18:28:16 -0500
Received: from george.spearce.org ([209.20.77.23]:55221 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbZAVX2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 18:28:13 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 210A138222; Thu, 22 Jan 2009 23:28:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 351CC3816F;
	Thu, 22 Jan 2009 23:28:12 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.399.g0d272
In-Reply-To: <1232666890-23488-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106793>

Copying the path byte array (keeping it encoded in UTF-8) is quicker
than converting to String and then back again to UTF-8 when creating
a DirCacheEntry for the current position in a TreeWalk.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
index 414587c..22040e3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/TreeWalk.java
@@ -663,6 +663,21 @@ public String getPathString() {
 	}
 
 	/**
+	 * Get the current entry's complete path as a UTF-8 byte array.
+	 * 
+	 * @return complete path of the current entry, from the root of the
+	 *         repository. If the current entry is in a subtree there will be at
+	 *         least one '/' in the returned string.
+	 */
+	public byte[] getRawPath() {
+		final AbstractTreeIterator t = currentHead;
+		final int n = t.pathLen;
+		final byte[] r = new byte[n];
+		System.arraycopy(t.path, 0, r, 0, n);
+		return r;
+	}
+
+	/**
 	 * Test if the supplied path matches the current entry's path.
 	 * <p>
 	 * This method tests that the supplied path is exactly equal to the current
-- 
1.6.1.399.g0d272
