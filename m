From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [JGIT PATCH 1/5] Add set to IntList
Date: Thu, 3 Sep 2009 12:46:31 +0200 (CEST)
Message-ID: <14843cb5774e11411f37a60e6cd16f7274649719.1251974493u.git.johannes.schindelin@gmx.de>
References: <alpine.DEB.1.00.0909030846230.8306@pacific.mpi-cbg.de> <cover.1251974493u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Sep 03 12:46:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj9pw-0007zk-6l
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 12:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbZICKqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 06:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbZICKqb
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 06:46:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:51866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752141AbZICKqa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 06:46:30 -0400
Received: (qmail invoked by alias); 03 Sep 2009 10:46:32 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp005) with SMTP; 03 Sep 2009 12:46:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+zBktXBx6zCkCeqABYiIBTL6cn4LKbONYT99PpLv
	cJazor5aVnpxoT
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1251974493u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127645>

Some applications may wish to modify an int list.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .../tst/org/spearce/jgit/util/IntListTest.java     |   21 ++++++++++++++++++++
 .../src/org/spearce/jgit/util/IntList.java         |   17 ++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.java
index c470d55..a7a12cd 100644
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
index 0a84793..32d24fc 100644
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
1.6.4.297.gcb4cc
