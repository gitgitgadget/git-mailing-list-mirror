From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 09/13] Add AnyObjectId.copyTo(StringBuilder)
Date: Mon, 22 Dec 2008 16:27:19 -0800
Message-ID: <1229992043-1053-10-git-send-email-spearce@spearce.org>
References: <1229992043-1053-1-git-send-email-spearce@spearce.org>
 <1229992043-1053-2-git-send-email-spearce@spearce.org>
 <1229992043-1053-3-git-send-email-spearce@spearce.org>
 <1229992043-1053-4-git-send-email-spearce@spearce.org>
 <1229992043-1053-5-git-send-email-spearce@spearce.org>
 <1229992043-1053-6-git-send-email-spearce@spearce.org>
 <1229992043-1053-7-git-send-email-spearce@spearce.org>
 <1229992043-1053-8-git-send-email-spearce@spearce.org>
 <1229992043-1053-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 01:30:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEv9x-0005lu-3m
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 01:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbYLWA1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 19:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758AbYLWA1m
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 19:27:42 -0500
Received: from george.spearce.org ([209.20.77.23]:54471 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbYLWA13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 19:27:29 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id A388238222; Tue, 23 Dec 2008 00:27:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 29E3B38215;
	Tue, 23 Dec 2008 00:27:27 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1229992043-1053-9-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103788>

This makes it easier to append an ObjectId onto a StringBuilder.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
index 943d916..3ec00ea 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
@@ -387,7 +387,22 @@ public void copyTo(final Writer w) throws IOException {
 	 */
 	public void copyTo(final char[] tmp, final Writer w) throws IOException {
 		toHexCharArray(tmp);
-		w.write(tmp);
+		w.write(tmp, 0, STR_LEN);
+	}
+
+	/**
+	 * Copy this ObjectId to a StringBuilder in hex format.
+	 * 
+	 * @param tmp
+	 *            temporary char array to buffer construct into before writing.
+	 *            Must be at least large enough to hold 2 digits for each byte
+	 *            of object id (40 characters or larger).
+	 * @param w
+	 *            the string to append onto.
+	 */
+	public void copyTo(final char[] tmp, final StringBuilder w) {
+		toHexCharArray(tmp);
+		w.append(tmp, 0, STR_LEN);
 	}
 
 	private char[] toHexCharArray() {
-- 
1.6.1.rc4.301.g5497a
