From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH] BlobBasedConfig now does not print stacktrace to stderr if blob is not found by path
Date: Wed,  1 Jul 2009 21:25:22 +0400
Message-ID: <1246469122-5108-1-git-send-email-constantine.plotnikov@gmail.com>
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 19:26:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM3Zc-0004JD-8m
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 19:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbZGARZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 13:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbZGARZ0
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 13:25:26 -0400
Received: from mail.intellij.net ([213.182.181.98]:56509 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbZGARZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 13:25:25 -0400
Received: (qmail 960 invoked by uid 89); 1 Jul 2009 17:25:24 -0000
Received: by simscan 1.1.0 ppid: 917, pid: 952, t: 0.0038s
         scanners: regex: 1.1.0
Received: from unknown (HELO localhost.localdomain) (Constantine.Plotnikov@jetbrains.com@172.26.240.76)
  by mail.intellij.net with ESMTPA; 1 Jul 2009 17:25:23 -0000
X-Mailer: git-send-email 1.6.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122587>

Prior to this patch, if the blob is not found inside commit by path,
an exception stack trace was printed to stderr. This patch suppress
this behavior by throwing FileNotFoundException instead of generic
IOException in order to make it more aligned with FileBasedConfig.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
 .../src/org/spearce/jgit/lib/BlobBasedConfig.java  |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java
index 1f44994..8763c6c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/BlobBasedConfig.java
@@ -37,6 +37,7 @@
 package org.spearce.jgit.lib;
 
 import java.io.ByteArrayInputStream;
+import java.io.FileNotFoundException;
 import java.io.IOException;
 import java.io.InputStream;
 import java.util.concurrent.Callable;
@@ -118,7 +119,7 @@ this(base, new Callable<byte[]>() {
 				final Repository r = commit.getRepository();
 				final TreeWalk tree = TreeWalk.forPath(r, path, treeId);
 				if (tree == null) {
-					throw new IOException("Entry not found by path: " + path);
+					throw new FileNotFoundException("Entry not found by path: " + path);
 				}
 				ObjectId blobId = tree.getObjectId(0);
 				ObjectLoader loader = tree.getRepository().openBlob(blobId);
-- 
1.6.1.2
