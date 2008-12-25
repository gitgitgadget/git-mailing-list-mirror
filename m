From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 08/23] Remove the unused PackFile.get(ObjectId) form
Date: Wed, 24 Dec 2008 18:11:04 -0800
Message-ID: <1230171079-17156-9-git-send-email-spearce@spearce.org>
References: <1230171079-17156-1-git-send-email-spearce@spearce.org>
 <1230171079-17156-2-git-send-email-spearce@spearce.org>
 <1230171079-17156-3-git-send-email-spearce@spearce.org>
 <1230171079-17156-4-git-send-email-spearce@spearce.org>
 <1230171079-17156-5-git-send-email-spearce@spearce.org>
 <1230171079-17156-6-git-send-email-spearce@spearce.org>
 <1230171079-17156-7-git-send-email-spearce@spearce.org>
 <1230171079-17156-8-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 03:13:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFfjI-00029A-SB
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 03:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbYLYCLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 21:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbYLYCLg
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 21:11:36 -0500
Received: from george.spearce.org ([209.20.77.23]:59420 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbYLYCLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 21:11:25 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 96C7E382A1; Thu, 25 Dec 2008 02:11:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6F00E38211;
	Thu, 25 Dec 2008 02:11:22 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230171079-17156-8-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103868>

Everyone passes in a WindowCursor, except this one test case.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/lib/T0004_PackReader.java |    2 +-
 .../src/org/spearce/jgit/lib/PackFile.java         |   19 -------------------
 2 files changed, 1 insertions(+), 20 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
index 8288e56..f6fff52 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
@@ -55,7 +55,7 @@ public void test003_lookupCompressedObject() throws IOException {
 
 		id = ObjectId.fromString("902d5476fa249b7abc9d84c611577a81381f0327");
 		pr = new PackFile(db, TEST_IDX, TEST_PACK);
-		or = pr.get(id);
+		or = pr.get(new WindowCursor(), id);
 		assertNotNull(or);
 		assertEquals(id, or.getId());
 		assertEquals(Constants.OBJ_TREE, or.getType());
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index fc1b6ea..cd17bd4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -117,25 +117,6 @@ public boolean hasObject(final AnyObjectId id) {
 	/**
 	 * Get an object from this pack.
 	 * 
-	 * @param id
-	 *            the object to obtain from the pack. Must not be null.
-	 * @return the object loader for the requested object if it is contained in
-	 *         this pack; null if the object was not found.
-	 * @throws IOException
-	 *             the pack file or the index could not be read.
-	 */
-	public PackedObjectLoader get(final AnyObjectId id) throws IOException {
-		final WindowCursor wc = new WindowCursor();
-		try {
-			return get(wc, id);
-		} finally {
-			wc.release();
-		}
-	}
-
-	/**
-	 * Get an object from this pack.
-	 * 
 	 * @param curs
 	 *            temporary working space associated with the calling thread.
 	 * @param id
-- 
1.6.1.rc4.301.g5497a
