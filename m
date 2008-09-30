From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] ObjectId: Convert StringIndexOutOfBounds to IllegalArgumentException
Date: Tue, 30 Sep 2008 00:47:51 -0700
Message-ID: <1222760871-58768-2-git-send-email-spearce@spearce.org>
References: <1222760871-58768-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 09:49:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkZz0-0003MS-Lm
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 09:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbYI3HsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 03:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754848AbYI3HsB
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 03:48:01 -0400
Received: from george.spearce.org ([209.20.77.23]:49751 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbYI3Hr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 03:47:57 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9384838368; Tue, 30 Sep 2008 07:47:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id DCA373835F;
	Tue, 30 Sep 2008 07:47:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.463.g7f0eb
In-Reply-To: <1222760871-58768-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97072>

If parsing an ObjectId fromString fails because the string is too short
we don't want to throw StringIndexOutOfBoundsException with a trace that
leads back to the error handling code; instead we should throw what the
caller expects us to throw, which is IllegalArgumentException.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/MutableObjectId.java  |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
index f88d8cb..5b16345 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/MutableObjectId.java
@@ -161,6 +161,8 @@ private void fromHexString(final byte[] bs, int p) {
 				throw new IllegalArgumentException("Invalid id: " + str);
 			} catch (UnsupportedEncodingException e2) {
 				throw new IllegalArgumentException("Invalid id");
+			} catch (StringIndexOutOfBoundsException e2) {
+				throw new IllegalArgumentException("Invalid id");
 			}
 		}
 	}
-- 
1.6.0.2.463.g7f0eb
