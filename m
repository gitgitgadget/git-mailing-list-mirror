From: mr.gaffo@gmail.com
Subject: [PATCH JGit 05/19] Made tests for listLocalPacks function on ObjectDirectory and made them pass
Date: Sun, 13 Sep 2009 13:44:21 -0500
Message-ID: <1252867475-858-6-git-send-email-mr.gaffo@gmail.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-3-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-4-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-5-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:45:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu4L-00038i-TQ
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbZIMSox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbZIMSou
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:44:50 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:20766 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbZIMSoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:44:44 -0400
Received: by an-out-0708.google.com with SMTP id d40so7549088and.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kaVY3ZiR5xqjeCkGYnl50S7xXqWQzpNuiT5Wl70uNWU=;
        b=JcK3AgiGH0A0+nxutPPHvrKr+vUL5Dakynlsr04M/ufa1IbTGALERi7GNcnOW5TtQo
         9iEsNjT4BU59BdPLUM3f3CSFldU9KDHsMsQ5HO1QEnkCmfy/880DPJfMOcsLd2E5IDl8
         kTbRoPMP55jCmqismfXTAR9O4N2fKR1x0zGQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=V/78rjkH0a47yTyBK94xIK0kVLD0T4694N+IGIxUbRTuHpQugbMRibBcTKV1iMYBTI
         tFcFVDTgMl/tkWg61hijh7OMJwdrA6dFhH89bPGlEmYm7vykYky4BaU804M1d1mR3hkI
         pwfTTzeFzZ/TUR8SnXSre4P3RVh/qi4m9bdmY=
Received: by 10.101.96.5 with SMTP id y5mr4849599anl.89.1252867488362;
        Sun, 13 Sep 2009 11:44:48 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-5-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128388>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../org/spearce/jgit/lib/ObjectDirectoryTest.java  |   24 ++++++++++++++++++++
 .../jgit/lib/UpdateDirectoryInfoCacheTest.java     |   11 +++++++++
 .../tst/org/spearce/jgit/util/JGitTestUtil.java    |   21 ++++++++++++++++-
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |    6 +++++
 .../spearce/jgit/lib/UpdateDirectoryInfoCache.java |   22 ++++++++++++++++++
 5 files changed, 83 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryInfoCacheTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
index fe019af..8e4d8e5 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
@@ -1,11 +1,17 @@
 package org.spearce.jgit.lib;
 
 import java.io.File;
+import java.util.List;
 import java.util.UUID;
 
+import org.spearce.jgit.util.JGitTestUtil;
+
 import junit.framework.TestCase;
 
 public class ObjectDirectoryTest extends TestCase {
+	private static final String PACK_NAME = "pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f";
+	private static final File TEST_PACK = JGitTestUtil.getTestResourceFile(PACK_NAME + ".pack");
+	private static final File TEST_IDX = JGitTestUtil.getTestResourceFile(PACK_NAME + ".idx");
 	
 	private File testDir;
 
@@ -58,6 +64,24 @@ public void testGettingObjectFile() throws Exception {
 				 od.fileFor(ObjectId.fromString("b052a1272310d8df34de72f60204dee7e28a43d0")));
 	}
 	
+	public void testListLocalPacksNotCreated() throws Exception {
+		assertEquals(0, new ObjectDirectory(testDir).listLocalPacks().size());
+	}
+	
+	public void testListLocalPacksWhenThereIsAPack() throws Exception {
+		createTestDir();
+		File packsDir = new File(testDir, "pack");
+		packsDir.mkdirs();
+		
+		JGitTestUtil.copyFile(TEST_PACK, new File(packsDir, TEST_PACK.getName()));
+		JGitTestUtil.copyFile(TEST_IDX, new File(packsDir, TEST_IDX.getName()));
+
+		ObjectDirectory od = new ObjectDirectory(testDir);
+		List<PackFile> localPacks = od.listLocalPacks();
+		assertEquals(1, localPacks.size());
+		assertEquals(TEST_PACK.getName(), localPacks.get(0).getPackFile().getName());
+	}
+	
 	public boolean deleteDir(File dir) {
         if (dir.isDirectory()) {
             String[] children = dir.list();
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryInfoCacheTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryInfoCacheTest.java
new file mode 100644
index 0000000..11d183e
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryInfoCacheTest.java
@@ -0,0 +1,11 @@
+package org.spearce.jgit.lib;
+
+import junit.framework.TestCase;
+
+public class UpdateDirectoryInfoCacheTest extends TestCase {
+	
+	public void testBase() throws Exception {
+		fail("nyi");
+	}
+
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
index eee0c14..04184d7 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
@@ -38,6 +38,12 @@
 package org.spearce.jgit.util;
 
 import java.io.File;
+import java.io.FileInputStream;
+import java.io.FileNotFoundException;
+import java.io.FileOutputStream;
+import java.io.IOException;
+import java.io.InputStream;
+import java.io.OutputStream;
 import java.net.URISyntaxException;
 import java.net.URL;
 
@@ -60,11 +66,24 @@ public static File getTestResourceFile(final String fileName) {
 		}
 		try {
 			return new File(url.toURI());
-		} catch(URISyntaxException e) {
+		} catch (URISyntaxException e) {
 			return new File(url.getPath());
 		}
 	}
 
+	public static void copyFile(final File fromFile, final File toFile) throws IOException {
+		InputStream in = new FileInputStream(fromFile);
+		OutputStream out = new FileOutputStream(toFile);
+
+		byte[] buf = new byte[1024];
+		int len;
+		while ((len = in.read(buf)) > 0) {
+			out.write(buf, 0, len);
+		}
+		in.close();
+		out.close();
+	}
+
 	private static ClassLoader cl() {
 		return JGitTestUtil.class.getClassLoader();
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index fe219c6..a90ae00 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -511,6 +511,12 @@ boolean tryAgain(final long currLastModified) {
 
 	@Override
 	public List<PackFile> listLocalPacks() {
+		tryAgain1();
 		return new ArrayList<PackFile>(Arrays.asList(packList.get().packs));
 	}
+
+	@Override
+	public void updateInfoCache() {
+		new UpdateDirectoryInfoCache(this.listLocalPacks(), this.infoDirectory).execute();
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java
new file mode 100644
index 0000000..2bceb9e
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java
@@ -0,0 +1,22 @@
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.util.List;
+
+public class UpdateDirectoryInfoCache {
+
+	private List<PackFile> packsList;
+	private File infoDirectory;
+
+	public UpdateDirectoryInfoCache(List<PackFile> packsList,
+			File infoDirectory) {
+		this.packsList = packsList;
+		this.infoDirectory = infoDirectory;
+	}
+
+	public void execute() {
+//		File objectFile = objectDatabase.
+//		String packsContents = new PacksFileContentsCreator(this.objectDatabase.listLocalPacks()).toString();
+	}
+
+}
-- 
1.6.4.2
