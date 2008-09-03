From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT PATCH 1/2] Switch usage of AnyObjectId.toString() to new
	AnyObjectId.name()
Date: Wed, 3 Sep 2008 11:01:57 +0200
Message-ID: <20080903090157.GB23406@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 11:03:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaoGc-0001Ru-Bu
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 11:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbYICJCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 05:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbYICJCC
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 05:02:02 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:56148 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996AbYICJCA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 05:02:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 28FB819BBD9;
	Wed,  3 Sep 2008 11:01:59 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28665-06; Wed,  3 Sep 2008 11:01:57 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 5A82319BBD8;
	Wed,  3 Sep 2008 11:01:57 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 21E5A6E0F0D; Wed,  3 Sep 2008 10:59:02 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 334EE1DE5C4; Wed,  3 Sep 2008 11:01:57 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94771>

This allows objects that extend AnyObjectId to override toString() to
their needs. With this it is possible to subclass for example RevCommit
and provide a custom toString() implementation without breaking the
revision walker.

AnyObjectId's toString() implementation is changed to make sure that
users relying on the old behavior will break. This patch passes the
test suite.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../tst/org/spearce/jgit/lib/PackIndexTest.java    |   24 ++++++++++----------
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    4 +-
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |    7 +++++-
 .../src/org/spearce/jgit/lib/ObjectId.java         |    4 +-
 .../src/org/spearce/jgit/lib/RefLogWriter.java     |    2 +-
 .../src/org/spearce/jgit/lib/Repository.java       |    2 +-
 6 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java
index 8372a18..8ab380e 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java
@@ -111,21 +111,21 @@ public void testIteratorMethodsContract() {
 	public void testIteratorReturnedValues1() {
 		Iterator<PackIndex.MutableEntry> iter = smallIdx.iterator();
 		assertEquals("4b825dc642cb6eb9a060e54bf8d69288fbee4904", iter.next()
-				.toString());
+				.name());
 		assertEquals("540a36d136cf413e4b064c2b0e0a4db60f77feab", iter.next()
-				.toString());
+				.name());
 		assertEquals("5b6e7c66c276e7610d4a73c70ec1a1f7c1003259", iter.next()
-				.toString());
+				.name());
 		assertEquals("6ff87c4664981e4397625791c8ea3bbb5f2279a3", iter.next()
-				.toString());
+				.name());
 		assertEquals("82c6b885ff600be425b4ea96dee75dca255b69e7", iter.next()
-				.toString());
+				.name());
 		assertEquals("902d5476fa249b7abc9d84c611577a81381f0327", iter.next()
-				.toString());
+				.name());
 		assertEquals("aabf2ffaec9b497f0950352b3e582d73035c2035", iter.next()
-				.toString());
+				.name());
 		assertEquals("c59759f143fb1fe21c197981df75a7ee00290799", iter.next()
-				.toString());
+				.name());
 		assertFalse(iter.hasNext());
 	}
 
@@ -147,16 +147,16 @@ public void testCompareEntriesOffsetsWithFindOffsets() {
 	 */
 	public void testIteratorReturnedValues2() {
 		Iterator<PackIndex.MutableEntry> iter = denseIdx.iterator();
-		while (!iter.next().toString().equals(
+		while (!iter.next().name().equals(
 				"0a3d7772488b6b106fb62813c4d6d627918d9181")) {
 			// just iterating
 		}
 		assertEquals("1004d0d7ac26fbf63050a234c9b88a46075719d3", iter.next()
-				.toString()); // same level-1
+				.name()); // same level-1
 		assertEquals("10da5895682013006950e7da534b705252b03be6", iter.next()
-				.toString()); // same level-1
+				.name()); // same level-1
 		assertEquals("1203b03dc816ccbb67773f28b3c19318654b0bc8", iter.next()
-				.toString());
+				.name());
 	}
 
 }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index c715182..72229d5 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -125,7 +125,7 @@ public void testWriteEmptyPack1() throws IOException {
 		assertEquals(0, writer.getObjectsNumber());
 		assertEquals(0, pack.getObjectCount());
 		assertEquals("da39a3ee5e6b4b0d3255bfef95601890afd80709", writer
-				.computeName().toString());
+				.computeName().name());
 	}
 
 	/**
@@ -273,7 +273,7 @@ public void testWritePack3() throws MissingObjectException, IOException {
 		assertEquals(forcedOrder.length, writer.getObjectsNumber());
 		verifyObjectsOrder(forcedOrder);
 		assertEquals("ed3f96b8327c7c66b0f8f70056129f0769323d86", writer
-				.computeName().toString());
+				.computeName().name());
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
index ae8dfeb..f82b37f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
@@ -406,7 +406,12 @@ private static void formatHexChar(final char[] dst, final int p, int w) {
 			dst[o--] = '0';
 	}
 
+	@Override
 	public String toString() {
+		return "AnyObjectId[" + name() + "]";
+	}
+
+	public String name() {
 		return new String(toHexCharArray());
 	}
 
@@ -422,7 +427,7 @@ public String toString() {
 	 */
 	public String abbreviate(final Repository repo) {
 		// TODO implement checking for uniqueness
-		return toString().substring(0, 7);
+		return name().substring(0, 7);
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
index 2148d10..52ce0d4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
@@ -52,7 +52,7 @@
 
 	static {
 		ZEROID = new ObjectId(0, 0, 0, 0, 0);
-		ZEROID_STR = ZEROID.toString();
+		ZEROID_STR = ZEROID.name();
 	}
 
 	/**
@@ -94,7 +94,7 @@ public static final boolean isId(final String id) {
 	 * @return the hex string conversion of this id's content.
 	 */
 	public static final String toString(final ObjectId i) {
-		return i != null ? i.toString() : ZEROID_STR;
+		return i != null ? i.name() : ZEROID_STR;
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
index 3aecaf2..6de8c0f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefLogWriter.java
@@ -88,7 +88,7 @@ private static String buildReflogString(Repository repo,
 			oldCommit = ObjectId.zeroId();
 			initial = " (initial)";
 		}
-		String s = oldCommit.toString() + " " + commit.toString() + " "
+		String s = oldCommit.name() + " " + commit.name() + " "
 				+ me.toExternalString() + "\t" + message + initial;
 		return s;
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 7303438..b27c23d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -209,7 +209,7 @@ public RepositoryConfig getConfig() {
 	 * @return suggested file name
 	 */
 	public File toFile(final AnyObjectId objectId) {
-		final String n = objectId.toString();
+		final String n = objectId.name();
 		String d=n.substring(0, 2);
 		String f=n.substring(2);
 		for (int i=0; i<objectsDirs.length; ++i) {
-- 
1.6.0.336.ga07ba
-- 
Jonas Fonseca
