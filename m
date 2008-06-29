From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/21] Allow PackIndexWriter to use any subclass of PackedObjectInfo
Date: Sun, 29 Jun 2008 03:59:16 -0400
Message-ID: <1214726371-93520-7-git-send-email-spearce@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org>
 <1214726371-93520-2-git-send-email-spearce@spearce.org>
 <1214726371-93520-3-git-send-email-spearce@spearce.org>
 <1214726371-93520-4-git-send-email-spearce@spearce.org>
 <1214726371-93520-5-git-send-email-spearce@spearce.org>
 <1214726371-93520-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:02:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrrj-0000I1-NX
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbYF2IAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbYF2IAk
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:00:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36746 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbYF2H76 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 03:59:58 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrpB-0004Mc-KB; Sun, 29 Jun 2008 03:59:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id 2463320FBAE; Sun, 29 Jun 2008 03:59:54 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 66B2720FBCE;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-6-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86770>

Some users of PackIndexWriter may have extended PackedObjectInfo
to store additional implementation specific details, but wish to
pass off their own subclass instances to avoid allocating even
more memory.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackIndexWriter.java  |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java
index 3d0050d..567f099 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexWriter.java
@@ -86,7 +86,7 @@ public abstract class PackIndexWriter {
 	 */
 	@SuppressWarnings("fallthrough")
 	public static PackIndexWriter createOldestPossible(final OutputStream dst,
-			final List<PackedObjectInfo> objs) {
+			final List<? extends PackedObjectInfo> objs) {
 		int version = 1;
 		LOOP: for (final PackedObjectInfo oe : objs) {
 			switch (version) {
@@ -137,7 +137,7 @@ public abstract class PackIndexWriter {
 	protected final byte[] tmp;
 
 	/** The entries this writer must pack. */
-	protected List<PackedObjectInfo> entries;
+	protected List<? extends PackedObjectInfo> entries;
 
 	/** SHA-1 checksum for the entire pack data. */
 	protected byte[] packChecksum;
@@ -172,7 +172,7 @@ public abstract class PackIndexWriter {
 	 *             an error occurred while writing to the output stream, or this
 	 *             index format cannot store the object data supplied.
 	 */
-	public void write(final List<PackedObjectInfo> toStore,
+	public void write(final List<? extends PackedObjectInfo> toStore,
 			final byte[] packDataChecksum) throws IOException {
 		entries = toStore;
 		packChecksum = packDataChecksum;
-- 
1.5.6.74.g8a5e
