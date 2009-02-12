From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 6/9] Rename readPackHeader() to be onOpenPack()
Date: Wed, 11 Feb 2009 18:36:56 -0800
Message-ID: <1234406219-19547-7-git-send-email-spearce@spearce.org>
References: <1234406219-19547-1-git-send-email-spearce@spearce.org>
 <1234406219-19547-2-git-send-email-spearce@spearce.org>
 <1234406219-19547-3-git-send-email-spearce@spearce.org>
 <1234406219-19547-4-git-send-email-spearce@spearce.org>
 <1234406219-19547-5-git-send-email-spearce@spearce.org>
 <1234406219-19547-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 03:39:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXRTd-0002tJ-HC
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 03:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758272AbZBLChU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 21:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758234AbZBLChR
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 21:37:17 -0500
Received: from george.spearce.org ([209.20.77.23]:39186 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756670AbZBLChF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 21:37:05 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 3549538222; Thu, 12 Feb 2009 02:37:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id F10233819E;
	Thu, 12 Feb 2009 02:37:01 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.204.gf6b427
In-Reply-To: <1234406219-19547-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109564>

Its just a better name of the function.  Any logic we might try
to perform to validate the pack file as we open it up to read
should be here, and that logic may eventually include validation
of the footer checksum against the index's footer data.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/PackFile.java         |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index 7a16bf7..d34df03 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -89,7 +89,7 @@ public PackFile(final File idxFile, final File packFile) {
 		pack = new WindowedFile(packFile) {
 			@Override
 			protected void onOpen() throws IOException {
-				readPackHeader();
+				onOpenPack();
 			}
 		};
 	}
@@ -264,8 +264,7 @@ boolean supportsFastCopyRawData() throws IOException {
 		return idx().hasCRC32Support();
 	}
 
-
-	private void readPackHeader() throws IOException {
+	private void onOpenPack() throws IOException {
 		final WindowCursor curs = new WindowCursor();
 		long position = 0;
 		final byte[] sig = new byte[Constants.PACK_SIGNATURE.length];
-- 
1.6.2.rc0.204.gf6b427
