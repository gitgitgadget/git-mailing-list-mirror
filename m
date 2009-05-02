From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/6] Add set to IntList
Date: Fri,  1 May 2009 19:08:42 -0700
Message-ID: <1241230127-28279-2-git-send-email-spearce@spearce.org>
References: <1241230127-28279-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 02 04:09:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M04fM-0003rn-EC
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 04:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbZEBCJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 22:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbZEBCJM
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 22:09:12 -0400
Received: from george.spearce.org ([209.20.77.23]:48663 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbZEBCJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 22:09:09 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9AC703808A; Sat,  2 May 2009 02:09:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B0C8C3807D;
	Sat,  2 May 2009 02:08:47 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.rc3.212.g8c698
In-Reply-To: <1241230127-28279-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118119>

Some applications may wish to modify an int list.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/util/IntListTest.java     |   21 ++++++++++++++++++++
 .../src/org/spearce/jgit/util/IntList.java         |   17 ++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java
index c470d55..ce0d7af 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java
@@ -144,6 +144,27 @@ public void testClear() {
 		}
 	}
 
+	public void testSet() {
+		final IntList i = new IntList();
+		i.add(1);
+		assertEquals(1, i.size());
+		assertEquals(1, i.get(0));
+		
+		i.set(0, 5);
+		assertEquals(5, i.get(0));
+		
+		try {
+			i.set(5, 5);
+			fail("accepted set of 5 beyond end of list");
+		} catch (ArrayIndexOutOfBoundsException e){
+			assertTrue(true);
+		}
+
+		i.set(1, 2);
+		assertEquals(2, i.size());
+		assertEquals(2, i.get(1));
+	}
+
 	public void testToString() {
 		final IntList i = new IntList();
 		i.add(1);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/IntList.java b/org.spearce.jgit/src/org/spearce/jgit/util/IntList.java
index 0a84793..9d86a5c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/IntList.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/IntList.java
@@ -94,6 +94,23 @@ public void add(final int n) {
 	}
 
 	/**
+	 * Assign an entry in the list.
+	 * 
+	 * @param index
+	 *            index to set, must be in the range [0, {@link #size()}).
+	 * @param n
+	 *            value to store at the position.
+	 */
+	public void set(final int index, final int n) {
+		if (count < index)
+			throw new ArrayIndexOutOfBoundsException(index);
+		else if (count == index)
+			add(n);
+		else
+			entries[index] = n;
+	}
+	
+	/**
 	 * Pad the list with entries.
 	 *
 	 * @param toIndex
-- 
1.6.3.rc3.212.g8c698
