From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH] Fix prefixCompare for AbbreviatedObjectId for sizes multiples of eight
Date: Fri, 24 Apr 2009 01:01:40 +0200
Message-ID: <1240527700-22154-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Apr 24 01:03:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx7wt-0003yH-Ur
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 01:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbZDWXBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 19:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754195AbZDWXBp
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 19:01:45 -0400
Received: from mail.dewire.com ([83.140.172.130]:24398 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754064AbZDWXBo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 19:01:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0341F14A8B20;
	Fri, 24 Apr 2009 01:01:42 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CUhQsOsKKc7C; Fri, 24 Apr 2009 01:01:41 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id B91F014927C9;
	Fri, 24 Apr 2009 01:01:41 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117393>

This tests the special cases for the mask computed for comparisons.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../spearce/jgit/lib/AbbreviatedObjectIdTest.java  |   60 ++++++++++++++++++++
 .../org/spearce/jgit/lib/AbbreviatedObjectId.java  |    2 +-
 2 files changed, 61 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbbreviatedObjectIdTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbbreviatedObjectIdTest.java
index 3f82d50..a6272e6 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbbreviatedObjectIdTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbbreviatedObjectIdTest.java
@@ -263,6 +263,66 @@ public void testPrefixCompare_1() {
 		assertFalse(i3.startsWith(a));
 	}
 
+	public void testPrefixCompare_7() {
+		final String sa = "7b6e806";
+		final AbbreviatedObjectId a = AbbreviatedObjectId.fromString(sa);
+
+		final String s1 = "7b6e8067ec96acef9a4184b43210d583b6d2f99a";
+		final ObjectId i1 = ObjectId.fromString(s1);
+		assertEquals(0, a.prefixCompare(i1));
+		assertTrue(i1.startsWith(a));
+
+		final String s2 = "7b6e8167ec86acef9a4184b43210d583b6d2f99a";
+		final ObjectId i2 = ObjectId.fromString(s2);
+		assertTrue(a.prefixCompare(i2) < 0);
+		assertFalse(i2.startsWith(a));
+
+		final String s3 = "7b6e8057eca6acef9a4184b43210d583b6d2f99a";
+		final ObjectId i3 = ObjectId.fromString(s3);
+		assertTrue(a.prefixCompare(i3) > 0);
+		assertFalse(i3.startsWith(a));
+	}
+
+	public void testPrefixCompare_8() {
+		final String sa = "7b6e8067";
+		final AbbreviatedObjectId a = AbbreviatedObjectId.fromString(sa);
+
+		final String s1 = "7b6e8067ec96acef9a4184b43210d583b6d2f99a";
+		final ObjectId i1 = ObjectId.fromString(s1);
+		assertEquals(0, a.prefixCompare(i1));
+		assertTrue(i1.startsWith(a));
+
+		final String s2 = "7b6e8167ec86acef9a4184b43210d583b6d2f99a";
+		final ObjectId i2 = ObjectId.fromString(s2);
+		assertTrue(a.prefixCompare(i2) < 0);
+		assertFalse(i2.startsWith(a));
+
+		final String s3 = "7b6e8057eca6acef9a4184b43210d583b6d2f99a";
+		final ObjectId i3 = ObjectId.fromString(s3);
+		assertTrue(a.prefixCompare(i3) > 0);
+		assertFalse(i3.startsWith(a));
+	}
+
+	public void testPrefixCompare_9() {
+		final String sa = "7b6e8067e";
+		final AbbreviatedObjectId a = AbbreviatedObjectId.fromString(sa);
+
+		final String s1 = "7b6e8067ec96acef9a4184b43210d583b6d2f99a";
+		final ObjectId i1 = ObjectId.fromString(s1);
+		assertEquals(0, a.prefixCompare(i1));
+		assertTrue(i1.startsWith(a));
+
+		final String s2 = "7b6e8167ec86acef9a4184b43210d583b6d2f99a";
+		final ObjectId i2 = ObjectId.fromString(s2);
+		assertTrue(a.prefixCompare(i2) < 0);
+		assertFalse(i2.startsWith(a));
+
+		final String s3 = "7b6e8057eca6acef9a4184b43210d583b6d2f99a";
+		final ObjectId i3 = ObjectId.fromString(s3);
+		assertTrue(a.prefixCompare(i3) > 0);
+		assertFalse(i3.startsWith(a));
+	}
+
 	public void testPrefixCompare_17() {
 		final String sa = "7b6e8067ec96acef9";
 		final AbbreviatedObjectId a = AbbreviatedObjectId.fromString(sa);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
index d76e5b5..ed03fb5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
@@ -129,7 +129,7 @@ static int mask(final int nibbles, final int word, final int v) {
 			return v;
 		}
 
-		if (nibbles < b) {
+		if (nibbles <= b) {
 			// We have none of the bits required for this word.
 			//
 			return 0;
-- 
1.6.2.2.446.gfbdc0
