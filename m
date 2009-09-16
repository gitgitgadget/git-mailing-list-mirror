From: mr.gaffo@gmail.com
Subject: [PATCH JGit 1/5] adding tests for ObjectDirectory
Date: Tue, 15 Sep 2009 19:48:32 -0500
Message-ID: <1253062116-13830-2-git-send-email-mr.gaffo@gmail.com>
References: <1253062116-13830-1-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>,
	Mike Gaffney <mr.gaffo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 02:48:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnihZ-0000XR-7M
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 02:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbZIPAso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 20:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753012AbZIPAsn
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 20:48:43 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:53981 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbZIPAsm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 20:48:42 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1479039qwb.37
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 17:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=U7freyJJWXANiA0z1+JxE8AMRv0PLCtt7pfIuKjaQo0=;
        b=TXkv6lS2evnmUNBHfbGywUBiSvp5b5B4Gm6OR7/Fd7XPtfNo+q5g5G3HKkJcowd3qI
         qcxBww1fqlsKHMAstwhCgKvyNTRcLoDJql4wpssXFNbQpskmoACgj1fSU2BGmUNJ1PVg
         +unOuDAefFXNNWYRb1/N3w73RUnRspekCOQMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g+g4GX6yXlhc9GCbOpfjjRbfiOecIUBaVxgFpdQmFPVaoIHri4bphvj6hbvF9QR3MY
         HqQn7utsdygkLpFORJwil7pNh8di6r6jJsjfQ+1Rv5j4mFgHPybzG58Wfq2ostJPgeu+
         V0axqBGz0ocDPnzTdI1bi08QN9n80Q/CRqmSM=
Received: by 10.224.81.66 with SMTP id w2mr6962279qak.98.1253062126000;
        Tue, 15 Sep 2009 17:48:46 -0700 (PDT)
Received: from localhost.localdomain (nat.asynchrony.com [66.236.120.131])
        by mx.google.com with ESMTPS id 4sm173278qwe.5.2009.09.15.17.48.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Sep 2009 17:48:45 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1253062116-13830-1-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128595>

From: mike.gaffney <mike.gaffney@asolutions.com>

Signed-off-by: Mike Gaffney <mr.gaffo@gmail.com>
---
 .../org/spearce/jgit/lib/ObjectDirectoryTest.java  |  106 ++++++++++++++++++++
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   58 +----------
 .../tst/org/spearce/jgit/util/JGitTestUtil.java    |   49 +++++++++
 3 files changed, 161 insertions(+), 52 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
new file mode 100644
index 0000000..5b1fc0f
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
@@ -0,0 +1,106 @@
+/*
+ * Copyright (C) 2009, Mike Gaffney.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.io.IOException;
+import java.util.UUID;
+
+import org.spearce.jgit.util.JGitTestUtil;
+
+import junit.framework.TestCase;
+
+public class ObjectDirectoryTest extends TestCase {
+	
+	private File testDir;
+
+	@Override
+	protected void setUp() throws Exception {
+		testDir = new File(new File(System.getProperty("java.io.tmpdir")), UUID.randomUUID().toString());
+	}
+	
+	@Override
+	protected void tearDown() throws Exception {
+		if (testDir.exists()){
+			JGitTestUtil.recursiveDelete(testDir, false, getClass().getName() + "." + getName(), true);
+		}
+	}
+
+	public void testCanGetDirectory() throws Exception {
+		ObjectDirectory od = new ObjectDirectory(testDir);
+		assertEquals(testDir, od.getDirectory());
+	}
+	
+	public void testExistsWithExistingDirectory() throws Exception {
+		createTestDir();
+		ObjectDirectory od = new ObjectDirectory(testDir);
+		assertTrue(od.exists());
+	}
+	
+	public void testExistsWithNonExistantDirectory() throws Exception {
+		assertFalse(new ObjectDirectory(new File("/some/nonexistant/file")).exists());
+	}
+	
+	public void testCreateMakesCorrectDirectories() throws Exception {
+		assertFalse(testDir.exists());
+		new ObjectDirectory(testDir).create();
+		assertTrue(testDir.exists());
+		
+		File infoDir = new File(testDir, "info");
+		assertTrue(infoDir.exists());
+		assertTrue(infoDir.isDirectory());
+		
+		File packDir = new File(testDir, "pack");
+		assertTrue(packDir.exists());
+		assertTrue(packDir.isDirectory());
+	}
+	
+	public void testGettingObjectFile() throws Exception {
+		ObjectDirectory od = new ObjectDirectory(testDir);
+		assertEquals(new File(testDir, "02/829ae153935095e4223f30cfc98c835de71bee"), 
+					 od.fileFor(ObjectId.fromString("02829ae153935095e4223f30cfc98c835de71bee")));
+		assertEquals(new File(testDir, "b0/52a1272310d8df34de72f60204dee7e28a43d0"), 
+				 od.fileFor(ObjectId.fromString("b052a1272310d8df34de72f60204dee7e28a43d0")));
+	}
+	
+	private void createTestDir(){
+		if (!testDir.mkdir()){
+			fail("unable to create test directory");
+		}
+	}
+	
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index d1aef78..cfd7d25 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -106,53 +106,7 @@ protected void configure() {
 	 * @param dir
 	 */
 	protected void recursiveDelete(final File dir) {
-		recursiveDelete(dir, false, getClass().getName() + "." + getName(), true);
-	}
-
-	protected static boolean recursiveDelete(final File dir, boolean silent,
-			final String name, boolean failOnError) {
-		assert !(silent && failOnError);
-		if (!dir.exists())
-			return silent;
-		final File[] ls = dir.listFiles();
-		if (ls != null) {
-			for (int k = 0; k < ls.length; k++) {
-				final File e = ls[k];
-				if (e.isDirectory()) {
-					silent = recursiveDelete(e, silent, name, failOnError);
-				} else {
-					if (!e.delete()) {
-						if (!silent) {
-							reportDeleteFailure(name, failOnError, e);
-						}
-						silent = !failOnError;
-					}
-				}
-			}
-		}
-		if (!dir.delete()) {
-			if (!silent) {
-				reportDeleteFailure(name, failOnError, dir);
-			}
-			silent = !failOnError;
-		}
-		return silent;
-	}
-
-	private static void reportDeleteFailure(final String name,
-			boolean failOnError, final File e) {
-		String severity;
-		if (failOnError)
-			severity = "Error";
-		else
-			severity = "Warning";
-		String msg = severity + ": Failed to delete " + e;
-		if (name != null)
-			msg += " in " + name;
-		if (failOnError)
-			fail(msg);
-		else
-			System.out.println(msg);
+		JGitTestUtil.recursiveDelete(dir, false, getClass().getName() + "." + getName(), true);
 	}
 
 	protected static void copyFile(final File src, final File dst)
@@ -215,7 +169,7 @@ public void setUp() throws Exception {
 		super.setUp();
 		configure();
 		final String name = getClass().getName() + "." + getName();
-		recursiveDelete(trashParent, true, name, false); // Cleanup old failed stuff
+		JGitTestUtil.recursiveDelete(trashParent, true, name, false); // Cleanup old failed stuff
 		trash = new File(trashParent,"trash"+System.currentTimeMillis()+"."+(testcount++));
 		trash_git = new File(trash, ".git").getCanonicalFile();
 		if (shutdownhook == null) {
@@ -230,7 +184,7 @@ public void run() {
 					System.gc();
 					for (Runnable r : shutDownCleanups)
 						r.run();
-					recursiveDelete(trashParent, false, null, false);
+					JGitTestUtil.recursiveDelete(trashParent, false, null, false);
 				}
 			};
 			Runtime.getRuntime().addShutdownHook(shutdownhook);
@@ -277,9 +231,9 @@ protected void tearDown() throws Exception {
 			System.gc();
 
 		final String name = getClass().getName() + "." + getName();
-		recursiveDelete(trash, false, name, true);
+		JGitTestUtil.recursiveDelete(trash, false, name, true);
 		for (Repository r : repositoriesToClose)
-			recursiveDelete(r.getWorkDir(), false, name, true);
+			JGitTestUtil.recursiveDelete(r.getWorkDir(), false, name, true);
 		repositoriesToClose.clear();
 
 		super.tearDown();
@@ -314,7 +268,7 @@ protected Repository createNewEmptyRepo(boolean bare) throws IOException {
 		final String name = getClass().getName() + "." + getName();
 		shutDownCleanups.add(new Runnable() {
 			public void run() {
-				recursiveDelete(newTestRepo, false, name, false);
+				JGitTestUtil.recursiveDelete(newTestRepo, false, name, false);
 			}
 		});
 		repositoriesToClose.add(newRepo);
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
index eee0c14..446c674 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
@@ -41,6 +41,9 @@
 import java.net.URISyntaxException;
 import java.net.URL;
 
+import junit.framework.AssertionFailedError;
+
+
 public abstract class JGitTestUtil {
 	public static final String CLASSPATH_TO_RESOURCES = "org/spearce/jgit/test/resources/";
 
@@ -68,4 +71,50 @@ public static File getTestResourceFile(final String fileName) {
 	private static ClassLoader cl() {
 		return JGitTestUtil.class.getClassLoader();
 	}
+
+	public static boolean recursiveDelete(final File dir, boolean silent,
+			final String name, boolean failOnError) {
+		assert !(silent && failOnError);
+		if (!dir.exists())
+			return silent;
+		final File[] ls = dir.listFiles();
+		if (ls != null) {
+			for (int k = 0; k < ls.length; k++) {
+				final File e = ls[k];
+				if (e.isDirectory()) {
+					silent = recursiveDelete(e, silent, name, failOnError);
+				} else {
+					if (!e.delete()) {
+						if (!silent) {
+							JGitTestUtil.reportDeleteFailure(name, failOnError, e);
+						}
+						silent = !failOnError;
+					}
+				}
+			}
+		}
+		if (!dir.delete()) {
+			if (!silent) {
+				JGitTestUtil.reportDeleteFailure(name, failOnError, dir);
+			}
+			silent = !failOnError;
+		}
+		return silent;
+	}
+
+	private static void reportDeleteFailure(final String name,
+			boolean failOnError, final File e) {
+		String severity;
+		if (failOnError)
+			severity = "Error";
+		else
+			severity = "Warning";
+		String msg = severity + ": Failed to delete " + e;
+		if (name != null)
+			msg += " in " + name;
+		if (failOnError)
+			throw new AssertionFailedError(msg);
+		else
+			System.out.println(msg);
+	}
 }
-- 
1.6.4.2
