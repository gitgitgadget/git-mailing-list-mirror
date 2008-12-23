From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 11/13] Allow null new ObjectId during RefUpdate.delete
Date: Mon, 22 Dec 2008 16:27:21 -0800
Message-ID: <1229992043-1053-12-git-send-email-spearce@spearce.org>
References: <1229992043-1053-1-git-send-email-spearce@spearce.org>
 <1229992043-1053-2-git-send-email-spearce@spearce.org>
 <1229992043-1053-3-git-send-email-spearce@spearce.org>
 <1229992043-1053-4-git-send-email-spearce@spearce.org>
 <1229992043-1053-5-git-send-email-spearce@spearce.org>
 <1229992043-1053-6-git-send-email-spearce@spearce.org>
 <1229992043-1053-7-git-send-email-spearce@spearce.org>
 <1229992043-1053-8-git-send-email-spearce@spearce.org>
 <1229992043-1053-9-git-send-email-spearce@spearce.org>
 <1229992043-1053-10-git-send-email-spearce@spearce.org>
 <1229992043-1053-11-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 01:30:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEv9y-0005lu-HG
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 01:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbYLWA1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 19:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752817AbYLWA1q
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 19:27:46 -0500
Received: from george.spearce.org ([209.20.77.23]:54476 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbYLWA1a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 19:27:30 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7F52C38215; Tue, 23 Dec 2008 00:27:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id BE37938210;
	Tue, 23 Dec 2008 00:27:27 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1229992043-1053-11-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103795>

If we are deleting a ref we really don't care about what the
new ObjectId value should be; it just doesn't matter.  If we
didn't set the value we should consider it the same as if we
had a MissingObjectException, which means treat the value as
null and perform a force update test.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RefUpdate.java        |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
index 0c9ce91..1417f2c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefUpdate.java
@@ -424,7 +424,7 @@ private Result updateImpl(final RevWalk walk, final Store store)
 	private static RevObject safeParse(final RevWalk rw, final AnyObjectId id)
 			throws IOException {
 		try {
-			return rw.parseAny(id);
+			return id != null ? rw.parseAny(id) : null;
 		} catch (MissingObjectException e) {
 			// We can expect some objects to be missing, like if we are
 			// trying to force a deletion of a branch and the object it
-- 
1.6.1.rc4.301.g5497a
