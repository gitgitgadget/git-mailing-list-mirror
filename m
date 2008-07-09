From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/4] Use a singleton for the NullProgressMonitor implementation
Date: Wed,  9 Jul 2008 00:15:31 -0400
Message-ID: <1215576931-4174-5-git-send-email-spearce@spearce.org>
References: <1215576931-4174-1-git-send-email-spearce@spearce.org>
 <1215576931-4174-2-git-send-email-spearce@spearce.org>
 <1215576931-4174-3-git-send-email-spearce@spearce.org>
 <1215576931-4174-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 06:16:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGR6p-0004Ib-IB
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 06:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbYGIEPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 00:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbYGIEPi
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 00:15:38 -0400
Received: from george.spearce.org ([209.20.77.23]:46882 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbYGIEPe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 00:15:34 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4C466381FF; Wed,  9 Jul 2008 04:15:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id A0D21381FC;
	Wed,  9 Jul 2008 04:15:33 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1215576931-4174-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87844>

No reason to create a new instance every time we need to shove
a null monitor into a variable because someone passed us null.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/lib/NullProgressMonitor.java  |    3 +++
 .../src/org/spearce/jgit/util/TemporaryBuffer.java |    2 +-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/NullProgressMonitor.java b/org.spearce.jgit/src/org/spearce/jgit/lib/NullProgressMonitor.java
index de75b90..191dc00 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/NullProgressMonitor.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/NullProgressMonitor.java
@@ -42,6 +42,9 @@ package org.spearce.jgit.lib;
  * A NullProgressMonitor does not report progress anywhere.
  */
 public class NullProgressMonitor implements ProgressMonitor {
+	/** Immutable instance of a null progress monitor. */
+	public static final NullProgressMonitor INSTANCE = new NullProgressMonitor();
+
 	public void start(int totalTasks) {
 		// Do not report.
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java b/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
index 20db580..d597c38 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/TemporaryBuffer.java
@@ -200,7 +200,7 @@ public class TemporaryBuffer extends OutputStream {
 	public void writeTo(final OutputStream os, ProgressMonitor pm)
 			throws IOException {
 		if (pm == null)
-			pm = new NullProgressMonitor();
+			pm = NullProgressMonitor.INSTANCE;
 		if (blocks != null) {
 			// Everything is in core so we can stream directly to the output.
 			//
-- 
1.5.6.74.g8a5e
