From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 12/21] WalkTransport must allow subclasses to implement openPush
Date: Sun, 29 Jun 2008 03:59:22 -0400
Message-ID: <1214726371-93520-13-git-send-email-spearce@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org>
 <1214726371-93520-2-git-send-email-spearce@spearce.org>
 <1214726371-93520-3-git-send-email-spearce@spearce.org>
 <1214726371-93520-4-git-send-email-spearce@spearce.org>
 <1214726371-93520-5-git-send-email-spearce@spearce.org>
 <1214726371-93520-6-git-send-email-spearce@spearce.org>
 <1214726371-93520-7-git-send-email-spearce@spearce.org>
 <1214726371-93520-8-git-send-email-spearce@spearce.org>
 <1214726371-93520-9-git-send-email-spearce@spearce.org>
 <1214726371-93520-10-git-send-email-spearce@spearce.org>
 <1214726371-93520-11-git-send-email-spearce@spearce.org>
 <1214726371-93520-12-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:02:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrro-0000I1-Dh
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbYF2IA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbYF2IA5
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:00:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36808 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbYF2IAR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:00:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrpU-0004O5-9Z; Sun, 29 Jun 2008 04:00:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id BCF2520FBAE; Sun, 29 Jun 2008 04:00:12 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 863E020FBD5;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-12-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86768>

If a walk implementation actually supports push (such as HTTP
push via WebDAV) we need to override openPush to return back
a valid PushConnection, however construction could fail with
a TransportException.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/WalkTransport.java  |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
index e208b12..b3ea4aa 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkTransport.java
@@ -38,6 +38,7 @@
 package org.spearce.jgit.transport;
 
 import org.spearce.jgit.errors.NotSupportedException;
+import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.Repository;
 
 /**
@@ -58,7 +59,8 @@ abstract class WalkTransport extends Transport {
 	}
 
 	@Override
-	public PushConnection openPush() throws NotSupportedException {
+	public PushConnection openPush() throws NotSupportedException,
+			TransportException {
 		final String s = getURI().getScheme();
 		throw new NotSupportedException("Push not supported over " + s + ".");
 	}
-- 
1.5.6.74.g8a5e
