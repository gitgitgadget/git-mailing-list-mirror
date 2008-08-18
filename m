From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/14] Fix NB.decodeUInt16 to correctly handle the high byte
Date: Mon, 18 Aug 2008 16:53:10 -0700
Message-ID: <1219103602-32222-3-git-send-email-spearce@spearce.org>
References: <1219103602-32222-1-git-send-email-spearce@spearce.org>
 <1219103602-32222-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:55:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEZ1-0006i3-I2
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbYHRXxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753576AbYHRXx2
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:53:28 -0400
Received: from george.spearce.org ([209.20.77.23]:45137 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbYHRXxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:53:25 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 247403838B; Mon, 18 Aug 2008 23:53:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4801238376;
	Mon, 18 Aug 2008 23:53:23 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.87.g2858d
In-Reply-To: <1219103602-32222-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92768>

Our decodeUInt16 method was buggy and always cleared the high byte
of the pair.  This meant we always lost the upper 8 bits when we
read in a 16 bit unsigned integer, possibly causing us to misread
the data associated with that pair.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 org.spearce.jgit/src/org/spearce/jgit/util/NB.java |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/NB.java b/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
index c6176f8..fa13354 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/NB.java
@@ -102,7 +102,7 @@ public static int compareUInt32(final int a, final int b) {
 	 * @return unsigned integer value that matches the 16 bits read.
 	 */
 	public static int decodeUInt16(final byte[] intbuf, final int offset) {
-		int r = (intbuf[offset] << 8) & 0xff;
+		int r = (intbuf[offset] & 0xff) << 8;
 		return r | (intbuf[offset + 1] & 0xff);
 	}
 
-- 
1.6.0.87.g2858d
