From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [JGIT PATCH] Accept absolute IdentityFile paths in ssh config
Date: Fri, 22 Aug 2008 01:07:04 +0200
Message-ID: <200808220107.04568.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 01:09:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWJHl-0004n4-9M
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 01:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120AbYHUXIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 19:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756714AbYHUXIk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 19:08:40 -0400
Received: from av9-1-sn2.hy.skanova.net ([81.228.8.179]:39573 "EHLO
	av9-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120AbYHUXIk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 19:08:40 -0400
Received: by av9-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id A177637F6C; Fri, 22 Aug 2008 01:08:37 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av9-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id 7019C37F54; Fri, 22 Aug 2008 01:08:37 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 52A6537E44;
	Fri, 22 Aug 2008 01:08:37 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93223>

Don't prepend the home directory to absolute paths

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/transport/OpenSshConfig.java  |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
index 9ad19e7..a6849c6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
@@ -246,10 +246,12 @@ private static String dequote(final String value) {
 			return value.substring(1, value.length() - 2);
 		return value;
 	}
-
 	private File toFile(final String path) {
 		if (path.startsWith("~/"))
 			return new File(home, path.substring(2));
+		File ret = new File(path);
+		if (ret.isAbsolute())
+			return ret;
 		return new File(home, path);
 	}
 
-- 
1.6.0.rc2.35.g04c6e9
