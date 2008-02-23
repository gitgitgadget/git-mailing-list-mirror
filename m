From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 08/10] TreeEntry: Accessors for full raw name and mode bits
Date: Sun, 24 Feb 2008 00:50:41 +0100
Message-ID: <1203810643-28819-9-git-send-email-robin.rosenberg@dewire.com>
References: <1203810643-28819-1-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-2-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-3-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-4-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-5-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-6-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-7-git-send-email-robin.rosenberg@dewire.com>
 <1203810643-28819-8-git-send-email-robin.rosenberg@dewire.com>
Cc: David Watson <dwatson@mimvista.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 00:52:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT4AT-0001IU-7s
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbYBWXve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbYBWXvd
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:51:33 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11232 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754662AbYBWXvB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:51:01 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 124FB8027FE;
	Sun, 24 Feb 2008 00:51:00 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tWenZmWFDRZo; Sun, 24 Feb 2008 00:50:59 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id D1E2C80287A;
	Sun, 24 Feb 2008 00:50:50 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 11AAD293F0; Sun, 24 Feb 2008 00:50:43 +0100 (CET)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1203810643-28819-8-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74888>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/lib/TreeEntry.java        |   23 ++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
index 8d46230..e73f5d5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/TreeEntry.java
@@ -19,6 +19,8 @@ package org.spearce.jgit.lib;
 import java.io.IOException;
 import java.io.UnsupportedEncodingException;
 
+import org.spearce.jgit.lib.GitIndex.Entry;
+
 /**
  * This class represents an entry in a tree, like a blob or another tree.
  */
@@ -189,6 +191,14 @@ public abstract class TreeEntry implements Comparable {
 		return r.toString();
 	}
 
+	/**
+	 * @return repository relative name of the entry
+	 * FIXME better encoding
+	 */
+	public byte[] getFullNameUTF8() {
+		return getFullName().getBytes();
+	}
+
 	public int compareTo(final Object o) {
 		if (this == o)
 			return 0;
@@ -211,6 +221,19 @@ public abstract class TreeEntry implements Comparable {
 	}
 
 	/**
+	 * Helper for accessing tree/blob/index methods.
+	 *
+	 * @param i
+	 * @return '/' for Tre entries and NUL for non-treeish objects
+	 */
+	final public static int lastChar(Entry i) {
+		// FIXME, gitlink etc. Currently Trees cannot appear in the
+		// index so '\0' is always returned, except maybe for submodules
+		// which we do not support yet.
+		return FileMode.TREE.equals(i.getModeBits()) ? '/' : '\0';
+	}
+
+	/**
 	 * See @{link {@link #accept(TreeVisitor, int)}.
 	 *
 	 * @param tv
-- 
1.5.4.2
