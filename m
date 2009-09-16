From: mr.gaffo@gmail.com
Subject: [PATCH JGit 5/5] added tests for the file based info cache update and made pass
Date: Tue, 15 Sep 2009 19:48:36 -0500
Message-ID: <1253062116-13830-6-git-send-email-mr.gaffo@gmail.com>
References: <1253062116-13830-1-git-send-email-mr.gaffo@gmail.com>
 <1253062116-13830-2-git-send-email-mr.gaffo@gmail.com>
 <1253062116-13830-3-git-send-email-mr.gaffo@gmail.com>
 <1253062116-13830-4-git-send-email-mr.gaffo@gmail.com>
 <1253062116-13830-5-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>,
	Mike Gaffney <mr.gaffo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 02:55:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnio8-00022v-4C
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 02:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbZIPAzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 20:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbZIPAza
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 20:55:30 -0400
Received: from mail-qy0-f182.google.com ([209.85.221.182]:61688 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbZIPAza (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 20:55:30 -0400
Received: by qyk12 with SMTP id 12so3799517qyk.6
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 17:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=f2nIUxkghiBIOkLBoVZ/oQWQQn6d6zGSbaRTzfKz5ww=;
        b=qsDDGrqcKogfuyliMH5ySqUT7DtnoMl2N87KWjXG3JojZxlf2FAp3QlxFm6kKr0V8g
         G89u2MYIl8qD8/JMEqI0gKGBqelYPeuSXPG7ckKE/mTenBqaIIuOu4StqfaqZ/CW5pEb
         16zqcsUGiHTTM7rx9lnhAvaTnpLWrkwbt2nrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wBGpqOvIqi2jiHz4DoC6qqnOlW180HI3OerLOySzsMwGavCOqlBesS/XHMSeKLLN7m
         rcV89aNmnzu5UwwGQ40NYCbUHZW04ElEA8OMTXdN0s/hWOcm7q2vx5AhRFz2TvlpNDAJ
         bk/O0Y/OqOO3s9S411ztgVMXdoh2+kfqXyurI=
Received: by 10.224.95.200 with SMTP id e8mr6894556qan.157.1253062129667;
        Tue, 15 Sep 2009 17:48:49 -0700 (PDT)
Received: from localhost.localdomain (nat.asynchrony.com [66.236.120.131])
        by mx.google.com with ESMTPS id 4sm173278qwe.5.2009.09.15.17.48.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Sep 2009 17:48:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1253062116-13830-5-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128598>

From: mike.gaffney <mike.gaffney@asolutions.com>

Signed-off-by: Mike Gaffney <mr.gaffo@gmail.com>
---
 .../CachedPacksInfoFileContentsGeneratorTest.java  |    8 ++--
 .../jgit/lib/InfoDirectoryDatabaseTest.java        |   30 ++++++++++++++++++++
 .../org/spearce/jgit/lib/ObjectDirectoryTest.java  |    4 +-
 .../src/org/spearce/jgit/lib/InfoDatabase.java     |   15 ++++++++++
 .../spearce/jgit/lib/InfoDirectoryDatabase.java    |   15 ++++++++++
 .../org/spearce/jgit/transport/ReceivePack.java    |   10 ++++++
 6 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/CachedPacksInfoFileContentsGeneratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/CachedPacksInfoFileContentsGeneratorTest.java
index bea0b70..10ce9e3 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/CachedPacksInfoFileContentsGeneratorTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/CachedPacksInfoFileContentsGeneratorTest.java
@@ -63,10 +63,10 @@ public void testGettingPacksContentsMultiplePacks() throws Exception {
 		packs.add(new PackFile(TEST_IDX, TEST_PACK));
 		
 		StringBuilder expected = new StringBuilder();
-		expected.append("P ").append(TEST_PACK.getName()).append("\n");
-		expected.append("P ").append(TEST_PACK.getName()).append("\n");
-		expected.append("P ").append(TEST_PACK.getName()).append("\n");
-		expected.append("\n");
+		expected.append("P ").append(TEST_PACK.getName()).append('\n');
+		expected.append("P ").append(TEST_PACK.getName()).append('\n');
+		expected.append("P ").append(TEST_PACK.getName()).append('\n');
+		expected.append('\n');
 		
 		assertEquals(expected.toString(), new CachedPacksInfoFileContentsGenerator(packs).generateContents());
 	}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java
index 066473d..e31b883 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java
@@ -37,6 +37,10 @@
 package org.spearce.jgit.lib;
 
 import java.io.File;
+import java.io.IOException;
+import java.io.StringWriter;
+import java.util.ArrayList;
+import java.util.Collection;
 
 import org.spearce.jgit.util.JGitTestUtil;
 
@@ -63,4 +67,30 @@ public void testCreateCreatesDirectory() throws Exception {
 		new InfoDirectoryDatabase(testDir).create();
 		assertTrue(testDir.exists());
 	}
+	
+	public void testUpdateInfoCache() throws Exception {
+		Collection<Ref> refs = new ArrayList<Ref>();
+		refs.add(new Ref(Ref.Storage.LOOSE, "refs/heads/master", ObjectId.fromString("32aae7aef7a412d62192f710f2130302997ec883")));
+		refs.add(new Ref(Ref.Storage.LOOSE, "refs/heads/development", ObjectId.fromString("184063c9b594f8968d61a686b2f6052779551613")));
+
+		File expectedFile = new File(testDir, "refs");
+		assertFalse(expectedFile.exists());
+		
+		
+		final StringWriter expectedString = new StringWriter();
+		new RefWriter(refs) {
+			@Override
+			protected void writeFile(String file, byte[] content) throws IOException {
+				expectedString.write(new String(content));
+			}
+		}.writeInfoRefs();
+		
+		InfoDirectoryDatabase out = new InfoDirectoryDatabase(testDir);
+		out.create();
+		out.updateInfoCache(refs);
+		assertTrue(expectedFile.exists());
+		
+		String actual = JGitTestUtil.readFileAsString(expectedFile);
+		assertEquals(expectedString.toString(), actual);
+	}
 }
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
index 8c1d32d..a3f5278 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
@@ -40,10 +40,10 @@
 import java.io.IOException;
 import java.util.List;
 
-import org.spearce.jgit.util.JGitTestUtil;
-
 import junit.framework.TestCase;
 
+import org.spearce.jgit.util.JGitTestUtil;
+
 public class ObjectDirectoryTest extends TestCase {
 	private static final String PACK_NAME = "pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f";
 	private static final File TEST_PACK = JGitTestUtil.getTestResourceFile(PACK_NAME + ".pack");
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java
index 2a8d88d..96a39fc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java
@@ -36,9 +36,24 @@
  */
 package org.spearce.jgit.lib;
 
+import java.io.IOException;
+import java.util.Collection;
+
 public abstract class InfoDatabase {
 
+	/**
+	 * Create the info database
+	 */
 	public void create() {
 	}
 
+	/**
+	 * Updates the info cache typically done by update-server-info command.
+	 * This writes THIS repository's refs out to the info/refs file.
+	 * @param collection the collections of refs to update the info cache with
+	 * @throws IOException for any type of failure on the local or remote 
+	 * 					   data store
+	 */
+	public abstract void updateInfoCache(Collection<Ref> collection) throws IOException;
+
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java
index 90655e8..48f60d1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java
@@ -37,6 +37,9 @@
 package org.spearce.jgit.lib;
 
 import java.io.File;
+import java.io.FileOutputStream;
+import java.io.IOException;
+import java.util.Collection;
 
 public class InfoDirectoryDatabase extends InfoDatabase {
 
@@ -51,4 +54,16 @@ public void create() {
 		info.mkdirs();
 	}
 
+	@Override
+	public void updateInfoCache(Collection<Ref> refs) throws IOException {
+		new RefWriter(refs) {
+			@Override
+			protected void writeFile(String file, byte[] content) throws IOException {
+				FileOutputStream fos = new FileOutputStream(new File(info, "refs"));
+				fos.write(content);
+				fos.close();
+			}
+		}.writeInfoRefs();
+	}
+
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index 5865736..23277c9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -522,6 +522,16 @@ void sendString(final String s) throws IOException {
 
 			postReceive.onPostReceive(this, filterCommands(Result.OK));
 			updateObjectInfoCache();
+			updateInfoRefsCache();
+		}
+	}
+
+	private void updateInfoRefsCache() {
+		try{
+			getRepository().getInfoDatabase().updateInfoCache(getRepository().getAllRefs().values());
+		}
+		catch (IOException e){
+			sendMessage("error updating info/refs: " + e.getMessage());
 		}
 	}
 
-- 
1.6.4.2
