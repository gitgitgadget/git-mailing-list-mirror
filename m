From: mr.gaffo@gmail.com
Subject: [PATCH JGit 06/19] added utility for reading the contents of a file as a string
Date: Sun, 13 Sep 2009 13:44:22 -0500
Message-ID: <1252867475-858-7-git-send-email-mr.gaffo@gmail.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-3-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-4-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-5-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-6-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:45:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu4M-00038i-EX
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbZIMSoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753203AbZIMSow
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:44:52 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:19834 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbZIMSop (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:44:45 -0400
Received: by an-out-0708.google.com with SMTP id d40so7549191and.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uzU5IOC5D9vVPJJd0XA1P/AlqRpVvS94aslVksfVIPs=;
        b=edyZydooQFVNMKmHgueC1gYhra18MPby+Ri3d5HByVlg+72CZ44V1GEXSVi3li5fXl
         +wFtyTTvaakkiWu+bGupGuu7r5J4N8DWDwT/FJmxqFLGF0nnU2dmDMPCTvMWEYNN56TS
         lzlghKvgUO2kBUrJeZhVflk2RFvpdekXweZ+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vSDN+kK4CuOrWTbpnFQrG+6CplwfSDHyZllkRoyAGk8ebleBBVv1KX1SFnjnuDUN8o
         PsixJAUybMQiG5xBbSSuwBnYq7lNIOVKjZ9BfeEX38nR7bIcBCYkHP9gmYUbw3ZQjrRr
         q8NBm59BNHgVOZ6eakbyf0cZVzTftstdYnQjI=
Received: by 10.101.43.12 with SMTP id v12mr5534918anj.90.1252867489389;
        Sun, 13 Sep 2009 11:44:49 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-6-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128386>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../tst/org/spearce/jgit/util/JGitTestUtil.java    |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
index 04184d7..b958282 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
@@ -37,10 +37,12 @@
 
 package org.spearce.jgit.util;
 
+import java.io.BufferedReader;
 import java.io.File;
 import java.io.FileInputStream;
 import java.io.FileNotFoundException;
 import java.io.FileOutputStream;
+import java.io.FileReader;
 import java.io.IOException;
 import java.io.InputStream;
 import java.io.OutputStream;
@@ -71,7 +73,8 @@ public static File getTestResourceFile(final String fileName) {
 		}
 	}
 
-	public static void copyFile(final File fromFile, final File toFile) throws IOException {
+	public static void copyFile(final File fromFile, final File toFile)
+			throws IOException {
 		InputStream in = new FileInputStream(fromFile);
 		OutputStream out = new FileOutputStream(toFile);
 
@@ -84,6 +87,21 @@ public static void copyFile(final File fromFile, final File toFile) throws IOExc
 		out.close();
 	}
 
+	public static String readFileAsString(final File file)
+			throws java.io.IOException {
+		StringBuilder fileData = new StringBuilder(1000);
+		BufferedReader reader = new BufferedReader(new FileReader(file));
+		char[] buf = new char[1024];
+		int numRead = 0;
+		while ((numRead = reader.read(buf)) != -1) {
+			String readData = String.valueOf(buf, 0, numRead);
+			fileData.append(readData);
+			buf = new char[1024];
+		}
+		reader.close();
+		return fileData.toString();
+	}
+
 	private static ClassLoader cl() {
 		return JGitTestUtil.class.getClassLoader();
 	}
-- 
1.6.4.2
