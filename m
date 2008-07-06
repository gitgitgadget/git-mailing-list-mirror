From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/1] Fix local transport to invoke git-upload-pack during fetch
Date: Sun,  6 Jul 2008 19:31:18 -0400
Message-ID: <1215387078-20375-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 01:32:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFdiL-0000eQ-DP
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 01:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756941AbYGFXbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 19:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756851AbYGFXbT
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 19:31:19 -0400
Received: from george.spearce.org ([209.20.77.23]:35035 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756785AbYGFXbS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 19:31:18 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 67D0A3808A; Sun,  6 Jul 2008 23:31:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D548F3808A;
	Sun,  6 Jul 2008 23:31:17 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87566>

We need to use git-upload-pack, not git-receive-pack.  This was
broken by accident in 57aa472a7ef5e9349c4c0aa1a3022a1e28499324.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/TransportLocal.java |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
index b41d4af..155d59f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportLocal.java
@@ -125,7 +125,7 @@ class TransportLocal extends PackTransport {
 
 		LocalFetchConnection() throws TransportException {
 			super(TransportLocal.this);
-			uploadPack = startProcessWithErrStream(getOptionReceivePack());
+			uploadPack = startProcessWithErrStream(getOptionUploadPack());
 			init(uploadPack.getInputStream(), uploadPack.getOutputStream());
 			readAdvertisedRefs();
 		}
-- 
1.5.6.74.g8a5e
