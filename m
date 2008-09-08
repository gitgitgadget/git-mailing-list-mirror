From: imyousuf@gmail.com
Subject: [JGIT PATCH 1/3] Introduce utility method to load test resources
Date: Mon,  8 Sep 2008 09:07:34 +0600
Message-ID: <1220843256-1243-1-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org, robin.rosenberg@dewire.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 05:09:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcX7c-00009C-Dk
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 05:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbYIHDHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 23:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbYIHDHw
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 23:07:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:6647 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbYIHDHv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 23:07:51 -0400
Received: by nf-out-0910.google.com with SMTP id d3so294795nfc.21
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 20:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=E6Mnf8Is4wRw9pImWn2biWdkwd2EcICSqY7rHbBhut8=;
        b=lLN2hZzPCDaXaD+iysh7FgQ4XGBjJnaGvj9t3dlfz/RSabizL1r6NWGbjHtDv26UK+
         SOkQpsfWmgQeMdXMlaOwysKFpziBj3SshwW6JNlCGRSLxSPdC8h9qWUIO0y+iA5H5d7C
         rtr8AGfupqBmXpEJwBl3uQOmn8sSTb0htZDXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SsB/iUnAncM6zv0hsN8F2k1XTTXE0vAECxfnQbCFl699/zib98hkqjAEgbfXErlL0Y
         tLD7/3o9WGz0GnwZd7NeeUluMxkuWkSejGGe3UjDGAzKQm66UniKk2ODScDuXDVSNG4o
         CQBpF+NUp26swdjfa+QKagSgPe2CU0Dc/5fGA=
Received: by 10.210.78.16 with SMTP id a16mr18015150ebb.173.1220843269269;
        Sun, 07 Sep 2008 20:07:49 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id k7sm3006945nfh.17.2008.09.07.20.07.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Sep 2008 20:07:48 -0700 (PDT)
X-Mailer: git-send-email 1.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95209>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Previously test resources were being loaded from the sources but code for
loading them was done in different locations, thus introduced a utility
class that will contain utility operations and the first one's responsibility
would be to load test resources.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 .../dircache/DirCacheCGitCompatabilityTest.java    |    3 +-
 .../tst/org/spearce/jgit/lib/PackIndexV1Test.java  |    9 ++++---
 .../tst/org/spearce/jgit/lib/PackIndexV2Test.java  |    5 ++-
 .../org/spearce/jgit/lib/PackReverseIndexTest.java |    5 +--
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    3 +-
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    8 +++---
 .../tst/org/spearce/jgit/lib/T0004_PackReader.java |    8 ++++--
 .../org/spearce/jgit/transport/IndexPackTest.java  |    6 ++--
 .../tst/org/spearce/jgit/util/JGitTestUtil.java    |   25 +++++++++----------
 9 files changed, 38 insertions(+), 34 deletions(-)
 copy org.spearce.jgit/src/org/spearce/jgit/util/FS_POSIX_Java5.java => org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java (80%)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
index 43b23f6..b052686 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/dircache/DirCacheCGitCompatabilityTest.java
@@ -50,6 +50,7 @@
 import org.spearce.jgit.lib.ObjectId;
 import org.spearce.jgit.lib.RepositoryTestCase;
 import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.util.JGitTestUtil;
 
 public class DirCacheCGitCompatabilityTest extends RepositoryTestCase {
 	private final File index = pathOf("gitgit.index");
@@ -138,7 +139,7 @@ assertEquals(ObjectId
 	}
 
 	private File pathOf(final String name) {
-		return new File("tst", name);
+		return JGitTestUtil.getTestResourceFile(name);
 	}
 
 	private Map<String, CGitIndexRecord> readLsFiles() throws Exception {
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
index 49235ca..645e054 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
@@ -40,18 +40,19 @@
 import java.io.File;
 
 import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.util.JGitTestUtil;
 
 public class PackIndexV1Test extends PackIndexTest {
 	@Override
 	public File getFileForPack34be9032() {
-		return new File(new File("tst"),
-				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx");
+		return JGitTestUtil.getTestResourceFile(
+                    "pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx");
 	}
 
 	@Override
 	public File getFileForPackdf2982f28() {
-		return new File(new File("tst"),
-				"pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx");
+		return JGitTestUtil.getTestResourceFile(
+                    "pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idx");
 	}
 
 	/**
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
index c986c49..d95937c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
@@ -40,17 +40,18 @@
 import java.io.File;
 
 import org.spearce.jgit.errors.MissingObjectException;
+import org.spearce.jgit.util.JGitTestUtil;
 
 public class PackIndexV2Test extends PackIndexTest {
 	@Override
 	public File getFileForPack34be9032() {
-		return new File(new File("tst"),
+		return JGitTestUtil.getTestResourceFile(
 				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2");
 	}
 
 	@Override
 	public File getFileForPackdf2982f28() {
-		return new File(new File("tst"),
+		return JGitTestUtil.getTestResourceFile(
 				"pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2");
 	}
 
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java
index 52d1282..c66818f 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackReverseIndexTest.java
@@ -37,10 +37,9 @@
 
 package org.spearce.jgit.lib;
 
-import java.io.File;
-
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.lib.PackIndex.MutableEntry;
+import org.spearce.jgit.util.JGitTestUtil;
 
 public class PackReverseIndexTest extends RepositoryTestCase {
 
@@ -54,7 +53,7 @@
 	public void setUp() throws Exception {
 		super.setUp();
 		// index with both small (< 2^31) and big offsets
-		idx = PackIndex.open(new File(new File("tst"),
+		idx = PackIndex.open(JGitTestUtil.getTestResourceFile(
 				"pack-huge.idx"));
 		reverseIdx = new PackReverseIndex(idx);
 	}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index 0fcb2dc..e5bce4d 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -57,6 +57,7 @@
 import org.spearce.jgit.revwalk.RevWalk;
 import org.spearce.jgit.transport.IndexPack;
 import org.spearce.jgit.util.CountingOutputStream;
+import org.spearce.jgit.util.JGitTestUtil;
 
 public class PackWriterTest extends RepositoryTestCase {
 
@@ -239,7 +240,7 @@ public void testWritePack2DeltasCRC32Copy() throws IOException {
 				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack");
 		final File crc32Idx = new File(packDir,
 				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idx");
-		copyFile(new File(new File("tst"),
+		copyFile(JGitTestUtil.getTestResourceFile(
 				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2"),
 				crc32Idx);
 		db.openPack(crc32Pack, crc32Idx);
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 14e7179..270b90a 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -47,6 +47,7 @@
 import java.io.Reader;
 
 import junit.framework.TestCase;
+import org.spearce.jgit.util.JGitTestUtil;
 
 public abstract class RepositoryTestCase extends TestCase {
 
@@ -142,16 +143,15 @@ public void run() {
 				"pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745",
 				"pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa"
 		};
-		final File tst = new File("tst");
 		final File packDir = new File(db.getObjectsDirectory(), "pack");
 		for (int k = 0; k < packs.length; k++) {
-			copyFile(new File(tst, packs[k] + ".pack"), new File(packDir,
+			copyFile(JGitTestUtil.getTestResourceFile(packs[k] + ".pack"), new File(packDir,
 					packs[k] + ".pack"));
-			copyFile(new File(tst, packs[k] + ".idx"), new File(packDir,
+			copyFile(JGitTestUtil.getTestResourceFile(packs[k] + ".idx"), new File(packDir,
 					packs[k] + ".idx"));
 		}
 
-		copyFile(new File(tst, "packed-refs"), new File(trash_git,"packed-refs"));
+		copyFile(JGitTestUtil.getTestResourceFile("packed-refs"), new File(trash_git,"packed-refs"));
 
 		db.scanForPacks();
 	}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
index c036e79..8288e56 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0004_PackReader.java
@@ -41,10 +41,12 @@
 import java.io.File;
 import java.io.IOException;
 
+import org.spearce.jgit.util.JGitTestUtil;
+
 public class T0004_PackReader extends RepositoryTestCase {
 	private static final String PACK_NAME = "pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f";
-	private static final File TEST_PACK = new File(new File("tst"), PACK_NAME + ".pack");
-	private static final File TEST_IDX = new File(TEST_PACK.getParentFile(), PACK_NAME + ".idx");
+	private static final File TEST_PACK = JGitTestUtil.getTestResourceFile(PACK_NAME + ".pack");
+	private static final File TEST_IDX = JGitTestUtil.getTestResourceFile(PACK_NAME + ".idx");
 
 	public void test003_lookupCompressedObject() throws IOException {
 		final PackFile pr;
@@ -77,7 +79,7 @@ public void test004_lookupDeltifiedObject() throws IOException {
 	}
 
 	public void test005_todopack() throws IOException {
-		final File todopack = new File(new File("tst"), "todopack");
+		final File todopack = JGitTestUtil.getTestResourceFile("todopack");
 		if (!todopack.isDirectory()) {
 			System.err.println("Skipping " + getName() + ": no " + todopack);
 			return;
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java
index ffa9142..46bd969 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/IndexPackTest.java
@@ -47,7 +47,7 @@
 import org.spearce.jgit.lib.PackFile;
 import org.spearce.jgit.lib.RepositoryTestCase;
 import org.spearce.jgit.lib.TextProgressMonitor;
-import org.spearce.jgit.transport.IndexPack;
+import org.spearce.jgit.util.JGitTestUtil;
 
 /**
  * Test indexing of git packs. A pack is read from a stream, copied
@@ -63,7 +63,7 @@
 	 * @throws IOException
 	 */
 	public void test1() throws  IOException {
-		File packFile = new File("tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack");
+		File packFile = JGitTestUtil.getTestResourceFile("pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.pack");
 		final InputStream is = new FileInputStream(packFile);
 		try {
 			IndexPack pack = new IndexPack(db, is, new File(trash, "tmp_pack1"));
@@ -89,7 +89,7 @@ public void test1() throws  IOException {
 	 * @throws IOException
 	 */
 	public void test2() throws  IOException {
-		File packFile = new File("tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack");
+		File packFile = JGitTestUtil.getTestResourceFile("pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.pack");
 		final InputStream is = new FileInputStream(packFile);
 		try {
 			IndexPack pack = new IndexPack(db, is, new File(trash, "tmp_pack2"));
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/FS_POSIX_Java5.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
similarity index 80%
copy from org.spearce.jgit/src/org/spearce/jgit/util/FS_POSIX_Java5.java
copy to org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
index d62b210..bfeb2a0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/FS_POSIX_Java5.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Imran M Yousuf <imyousuf@smartitengineering.com>
  *
  * All rights reserved.
  *
@@ -39,16 +39,15 @@
 
 import java.io.File;
 
-class FS_POSIX_Java5 extends FS {
-	public boolean supportsExecute() {
-		return false;
-	}
-
-	public boolean canExecute(final File f) {
-		return false;
-	}
-
-	public boolean setExecute(final File f, final boolean canExec) {
-		return false;
-	}
+public abstract class JGitTestUtil {
+    private JGitTestUtil() {
+        throw new AssertionError();
+    }
+    
+    public static File getTestResourceFile(String fileName) {
+        if (fileName == null || fileName.length() <= 0) {
+            return null;
+        }
+        return new File("tst", fileName);
+    }
 }
-- 
1.5.6
