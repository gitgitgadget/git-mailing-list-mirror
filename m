From: mr.gaffo@gmail.com
Subject: [PATCH JGit 2/5] Create abstract method on ObjectDatabase for accessing the list of local pack files.
Date: Tue, 15 Sep 2009 19:48:33 -0500
Message-ID: <1253062116-13830-3-git-send-email-mr.gaffo@gmail.com>
References: <1253062116-13830-1-git-send-email-mr.gaffo@gmail.com>
 <1253062116-13830-2-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>,
	Mike Gaffney <mr.gaffo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 02:54:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnimZ-0001jU-GX
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 02:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbZIPAxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 20:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbZIPAxx
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 20:53:53 -0400
Received: from mail-qy0-f182.google.com ([209.85.221.182]:52578 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbZIPAxw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 20:53:52 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Sep 2009 20:53:52 EDT
Received: by qyk12 with SMTP id 12so3798556qyk.6
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 17:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Za4xgZnsl4jEn2Us9Ex643LpgZm2eIrm6AAEIP9kIZU=;
        b=Rz7MufiZr4J0qhLHz/bQ9xq89/ux1M8HOYyXgp1o62J/tP6KcCnP+1dGxja6Wnw2ui
         YLKujClN1ZpclwesunIIDuER8r7MX2KghwZ1fDTOKIVD67F9DnHzzvaUFUeH+u6SkOz+
         /SCI0Zs2N4jLG2WtbF0aF51/xCrBSz+V+37ac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eUOjNcnKhs40iAKa+sTAb5z2feNj5ORRzNm0jFCjlrVAyqVDQsM9Lmc+2jNRx/k8dv
         Ma7GpGEDQpKcPzPVjTLYN3/hTNobh5dPX9qzfBbOep0bF2atJN1eVi/RFAB7H9ouav1P
         ie/HTY/D95d+1pizPYRi3Fd3cgrEtn8vWpfHs=
Received: by 10.224.8.136 with SMTP id h8mr6904217qah.25.1253062126827;
        Tue, 15 Sep 2009 17:48:46 -0700 (PDT)
Received: from localhost.localdomain (nat.asynchrony.com [66.236.120.131])
        by mx.google.com with ESMTPS id 4sm173278qwe.5.2009.09.15.17.48.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Sep 2009 17:48:46 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1253062116-13830-2-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128596>

From: mike.gaffney <mike.gaffney@asolutions.com>

Implemented the method for AlternateRepository database as a passthrough

Implemented the method for ObjectDirectory as a toList of the current
cached private PackList.

Hopefully this will allow easier reference to the list of packs for
others like the server side of fetch.

Signed-off-by: Mike Gaffney <mr.gaffo@gmail.com>
---
 .../org/spearce/jgit/lib/ObjectDirectoryTest.java  |   22 ++++++++++++++++++++
 .../tst/org/spearce/jgit/util/JGitTestUtil.java    |   21 ++++++++++++++++++-
 .../jgit/lib/AlternateRepositoryDatabase.java      |    6 +++++
 .../src/org/spearce/jgit/lib/ObjectDatabase.java   |   11 +++++++++-
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |    6 +++++
 5 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
index 5b1fc0f..c27580f 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
@@ -38,6 +38,7 @@
 
 import java.io.File;
 import java.io.IOException;
+import java.util.List;
 import java.util.UUID;
 
 import org.spearce.jgit.util.JGitTestUtil;
@@ -45,6 +46,9 @@
 import junit.framework.TestCase;
 
 public class ObjectDirectoryTest extends TestCase {
+	private static final String PACK_NAME = "pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f";
+	private static final File TEST_PACK = JGitTestUtil.getTestResourceFile(PACK_NAME + ".pack");
+	private static final File TEST_IDX = JGitTestUtil.getTestResourceFile(PACK_NAME + ".idx");
 	
 	private File testDir;
 
@@ -97,6 +101,24 @@ public void testGettingObjectFile() throws Exception {
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
 	private void createTestDir(){
 		if (!testDir.mkdir()){
 			fail("unable to create test directory");
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/JGitTestUtil.java
index 446c674..785922a 100644
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
 
@@ -63,11 +69,24 @@ public static File getTestResourceFile(final String fileName) {
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
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
index ee4c4cf..68ad488 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
@@ -39,6 +39,7 @@
 
 import java.io.IOException;
 import java.util.Collection;
+import java.util.List;
 
 /**
  * An ObjectDatabase of another {@link Repository}.
@@ -124,4 +125,9 @@ void openObjectInAllPacks1(final Collection<PackedObjectLoader> out,
 	protected void closeAlternates(final ObjectDatabase[] alt) {
 		// Do nothing; these belong to odb to close, not us.
 	}
+
+	@Override
+	public List<PackFile> listLocalPacks() {
+		return odb.listLocalPacks();
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
index a547052..722c802 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
@@ -39,6 +39,7 @@
 
 import java.io.IOException;
 import java.util.Collection;
+import java.util.List;
 import java.util.concurrent.atomic.AtomicReference;
 
 /**
@@ -64,7 +65,15 @@
 	protected ObjectDatabase() {
 		alternates = new AtomicReference<ObjectDatabase[]>();
 	}
-
+	
+	/**
+	 * The list of Packs THIS repo contains
+	 * 
+	 * @return List<PackFile> of package names contained in this repo. 
+	 * 		   Should be an empty list if there are none.
+	 */
+	public abstract List<PackFile> listLocalPacks();
+	
 	/**
 	 * Does this database exist yet?
 	 *
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index 859824d..cbe132d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -508,4 +508,10 @@ boolean tryAgain(final long currLastModified) {
 			return true;
 		}
 	}
+
+	@Override
+	public List<PackFile> listLocalPacks() {
+		tryAgain1();
+		return new ArrayList<PackFile>(Arrays.asList(packList.get().packs));
+	}
 }
-- 
1.6.4.2
