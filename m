From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 04/10] Document PackedObjectInfo and make it public for reuse
Date: Mon, 23 Jun 2008 22:10:02 -0400
Message-ID: <1214273408-70793-5-git-send-email-spearce@spearce.org>
References: <1214273408-70793-1-git-send-email-spearce@spearce.org>
 <1214273408-70793-2-git-send-email-spearce@spearce.org>
 <1214273408-70793-3-git-send-email-spearce@spearce.org>
 <1214273408-70793-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:11:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAy0V-0005iO-Kg
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbYFXCKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752840AbYFXCKe
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:10:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49761 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbYFXCKd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:10:33 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KAxz7-0001O0-UZ; Mon, 23 Jun 2008 22:10:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id BD18F20FBC9; Mon, 23 Jun 2008 22:10:27 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 0C35720FBCF;
	Mon, 23 Jun 2008 22:10:09 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214273408-70793-4-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85972>

Classes outside of transport may wish to use this abstraction,
so we mark it public, expose the offset field, and document
as much of the API as possible.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/PackedObjectInfo.java   |   33 ++++++++++++++++++--
 1 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java
index eaedee9..58feada 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PackedObjectInfo.java
@@ -41,7 +41,14 @@ package org.spearce.jgit.transport;
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.ObjectId;
 
-class PackedObjectInfo extends ObjectId {
+/**
+ * Description of an object stored in a pack file, including offset.
+ * <p>
+ * When objects are stored in packs Git needs the ObjectId and the offset
+ * (starting position of the object data) to perform random-access reads of
+ * objects from the pack. This extension of ObjectId includes the offset.
+ */
+public class PackedObjectInfo extends ObjectId {
 	private long offset;
 
 	PackedObjectInfo(final long headerOffset, final AnyObjectId id) {
@@ -50,10 +57,30 @@ class PackedObjectInfo extends ObjectId {
 	}
 
 	/**
-	 * @return offset in pack when object has been already written, or -1 if it
+	 * Create a new structure to remember information about an object.
+	 * 
+	 * @param id
+	 *            the identity of the object the new instance tracks.
+	 */
+	public PackedObjectInfo(final AnyObjectId id) {
+		super(id);
+	}
+
+	/**
+	 * @return offset in pack when object has been already written, or 0 if it
 	 *         has not been written yet
 	 */
-	long getOffset() {
+	public long getOffset() {
 		return offset;
 	}
+
+	/**
+	 * Set the offset in pack when object has been written to.
+	 * 
+	 * @param offset
+	 *            offset where written object starts
+	 */
+	public void setOffset(final long offset) {
+		this.offset = offset;
+	}
 }
-- 
1.5.6.74.g8a5e
