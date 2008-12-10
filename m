From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/3] Add ObjectId.startsWith(AbbreviatedObjectId)
Date: Wed, 10 Dec 2008 15:18:26 -0800
Message-ID: <1228951107-5546-3-git-send-email-spearce@spearce.org>
References: <1228951107-5546-1-git-send-email-spearce@spearce.org>
 <1228951107-5546-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:20:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAYLj-0005dF-El
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 00:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbYLJXSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 18:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754217AbYLJXSe
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 18:18:34 -0500
Received: from george.spearce.org ([209.20.77.23]:41569 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbYLJXSb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 18:18:31 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6235338200; Wed, 10 Dec 2008 23:18:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8C72138210;
	Wed, 10 Dec 2008 23:18:28 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
In-Reply-To: <1228951107-5546-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102738>

This test can be useful to determine if the object id at least
begins with an abbreviated id.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/lib/AbbreviatedObjectIdTest.java  |   58 ++++++++++++++++++++
 .../org/spearce/jgit/lib/AbbreviatedObjectId.java  |   57 +++++++++++++++++++
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |   11 ++++
 3 files changed, 126 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbbreviatedObjectIdTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbbreviatedObjectIdTest.java
index f540f49..3f82d50 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbbreviatedObjectIdTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbbreviatedObjectIdTest.java
@@ -224,4 +224,62 @@ public void testNotEquals_DiffLength() {
 		assertFalse(a.equals(b));
 		assertFalse(b.equals(a));
 	}
+
+	public void testPrefixCompare_Full() {
+		final String s1 = "7b6e8067ec96acef9a4184b43210d583b6d2f99a";
+		final AbbreviatedObjectId a = AbbreviatedObjectId.fromString(s1);
+		final ObjectId i1 = ObjectId.fromString(s1);
+		assertEquals(0, a.prefixCompare(i1));
+		assertTrue(i1.startsWith(a));
+
+		final String s2 = "7b6e8067ec96acef9a4184b43210d583b6d2f99b";
+		final ObjectId i2 = ObjectId.fromString(s2);
+		assertTrue(a.prefixCompare(i2) < 0);
+		assertFalse(i2.startsWith(a));
+
+		final String s3 = "7b6e8067ec96acef9a4184b43210d583b6d2f999";
+		final ObjectId i3 = ObjectId.fromString(s3);
+		assertTrue(a.prefixCompare(i3) > 0);
+		assertFalse(i3.startsWith(a));
+	}
+
+	public void testPrefixCompare_1() {
+		final String sa = "7";
+		final AbbreviatedObjectId a = AbbreviatedObjectId.fromString(sa);
+
+		final String s1 = "7b6e8067ec96acef9a4184b43210d583b6d2f99a";
+		final ObjectId i1 = ObjectId.fromString(s1);
+		assertEquals(0, a.prefixCompare(i1));
+		assertTrue(i1.startsWith(a));
+
+		final String s2 = "8b6e8067ec96acef9a4184b43210d583b6d2f99a";
+		final ObjectId i2 = ObjectId.fromString(s2);
+		assertTrue(a.prefixCompare(i2) < 0);
+		assertFalse(i2.startsWith(a));
+
+		final String s3 = "6b6e8067ec96acef9a4184b43210d583b6d2f99a";
+		final ObjectId i3 = ObjectId.fromString(s3);
+		assertTrue(a.prefixCompare(i3) > 0);
+		assertFalse(i3.startsWith(a));
+	}
+
+	public void testPrefixCompare_17() {
+		final String sa = "7b6e8067ec96acef9";
+		final AbbreviatedObjectId a = AbbreviatedObjectId.fromString(sa);
+
+		final String s1 = "7b6e8067ec96acef9a4184b43210d583b6d2f99a";
+		final ObjectId i1 = ObjectId.fromString(s1);
+		assertEquals(0, a.prefixCompare(i1));
+		assertTrue(i1.startsWith(a));
+
+		final String s2 = "7b6e8067eca6acef9a4184b43210d583b6d2f99a";
+		final ObjectId i2 = ObjectId.fromString(s2);
+		assertTrue(a.prefixCompare(i2) < 0);
+		assertFalse(i2.startsWith(a));
+
+		final String s3 = "7b6e8067ec86acef9a4184b43210d583b6d2f99a";
+		final ObjectId i3 = ObjectId.fromString(s3);
+		assertTrue(a.prefixCompare(i3) > 0);
+		assertFalse(i3.startsWith(a));
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
index 1a8d296..206cc2f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
@@ -39,6 +39,8 @@
 
 import java.io.UnsupportedEncodingException;
 
+import org.spearce.jgit.util.NB;
+
 /**
  * A prefix abbreviation of an {@link ObjectId}.
  * <p>
@@ -119,6 +121,24 @@ private static final int hexUInt32(final byte[] bs, int p, final int end) {
 		return r << (8 - n) * 4;
 	}
 
+	static int mask(final int nibbles, final int word, final int v) {
+		final int b = (word - 1) * 8;
+		if (b + 8 <= nibbles) {
+			// We have all of the bits required for this word.
+			//
+			return v;
+		}
+
+		if (nibbles < b) {
+			// We have none of the bits required for this word.
+			//
+			return 0;
+		}
+
+		final int s = 32 - (nibbles - b) * 4;
+		return (v >>> s) << s;
+	}
+
 	/** Number of half-bytes used by this id. */
 	final int nibbles;
 
@@ -157,6 +177,43 @@ public ObjectId toObjectId() {
 		return isComplete() ? new ObjectId(w1, w2, w3, w4, w5) : null;
 	}
 
+	/**
+	 * Compares this abbreviation to a full object id.
+	 * 
+	 * @param other
+	 *            the other object id.
+	 * @return &lt;0 if this abbreviation names an object that is less than
+	 *         <code>other</code>; 0 if this abbreviation exactly matches the
+	 *         first {@link #length()} digits of <code>other.name()</code>;
+	 *         &gt;0 if this abbreviation names an object that is after
+	 *         <code>other</code>.
+	 */
+	public int prefixCompare(final AnyObjectId other) {
+		int cmp;
+
+		cmp = NB.compareUInt32(w1, mask(1, other.w1));
+		if (cmp != 0)
+			return cmp;
+
+		cmp = NB.compareUInt32(w2, mask(2, other.w2));
+		if (cmp != 0)
+			return cmp;
+
+		cmp = NB.compareUInt32(w3, mask(3, other.w3));
+		if (cmp != 0)
+			return cmp;
+
+		cmp = NB.compareUInt32(w4, mask(4, other.w4));
+		if (cmp != 0)
+			return cmp;
+
+		return NB.compareUInt32(w5, mask(5, other.w5));
+	}
+
+	private int mask(final int word, final int v) {
+		return mask(nibbles, word, v);
+	}
+
 	@Override
 	public int hashCode() {
 		return w2;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
index e88e09d..8872017 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
@@ -226,6 +226,17 @@ int compareTo(final int[] bs, final int p) {
 		return NB.compareUInt32(w5, bs[p + 4]);
 	}
 
+	/**
+	 * Tests if this ObjectId starts with the given abbreviation.
+	 * 
+	 * @param abbr
+	 *            the abbreviation.
+	 * @return true if this ObjectId begins with the abbreviation; else false.
+	 */
+	public boolean startsWith(final AbbreviatedObjectId abbr) {
+		return abbr.prefixCompare(this) == 0;
+	}
+
 	public int hashCode() {
 		return w2;
 	}
-- 
1.6.1.rc2.299.gead4c
