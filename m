From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [JGIT PATCH 4/5] Prepare RawText for diff-index and diff-files
Date: Thu, 3 Sep 2009 12:47:01 +0200 (CEST)
Message-ID: <ba3eaaf6590a49c904ef6f8e139c3201c53a7b11.1251974493u.git.johannes.schindelin@gmx.de>
References: <alpine.DEB.1.00.0909030846230.8306@pacific.mpi-cbg.de> <cover.1251974493u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Sep 03 12:47:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj9qV-000891-EK
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 12:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbZICKrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 06:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbZICKrE
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 06:47:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:44903 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754123AbZICKrC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 06:47:02 -0400
Received: (qmail invoked by alias); 03 Sep 2009 10:47:02 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp063) with SMTP; 03 Sep 2009 12:47:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vQRcrPTtvGdgUS8LDa4F472x7lkWmbA1kOvcgwy
	K4soaw2lFIohAs
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1251974493u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127648>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .../src/org/spearce/jgit/diff/RawText.java         |   28 +++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/diff/RawText.java b/org.spearce.jgit/src/org/spearce/jgit/diff/RawText.java
index 9886d36..15d1c12 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/diff/RawText.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/diff/RawText.java
@@ -38,6 +38,8 @@
 
 package org.spearce.jgit.diff;
 
+import java.io.File;
+import java.io.FileInputStream;
 import java.io.IOException;
 import java.io.OutputStream;
 
@@ -81,6 +83,18 @@ public RawText(final byte[] input) {
 		hashes = computeHashes();
 	}
 
+	/**
+	 * Create a new sequence from a file.
+	 * <p>
+	 * The entire file contents are used.
+	 *
+	 * @param file
+	 *            the text file.
+	 */
+	public RawText(File file) throws IOException {
+		this(readFile(file));
+	}
+
 	public int size() {
 		// The line map is always 2 entries larger than the number of lines in
 		// the file. Index 0 is padded out/unused. The last index is the total
@@ -181,4 +195,16 @@ protected int hashLine(final byte[] raw, int ptr, final int end) {
 			hash = (hash << 5) ^ (raw[ptr] & 0xff);
 		return hash;
 	}
-}
\ No newline at end of file
+
+	private static byte[] readFile(File file) throws IOException {
+		byte[] result = new byte[(int)file.length()];
+		FileInputStream in = new FileInputStream(file);
+		for (int off = 0; off < result.length; ) {
+			int read = in.read(result, off, result.length - off);
+			if (read < 0)
+				throw new IOException("Early EOF");
+			off += read;
+		}
+		return result;
+	}
+}
-- 
1.6.4.297.gcb4cc
