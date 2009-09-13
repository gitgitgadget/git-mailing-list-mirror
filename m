From: mr.gaffo@gmail.com
Subject: [PATCH JGit 01/19] adding tests for ObjectDirectory
Date: Sun, 13 Sep 2009 13:44:17 -0500
Message-ID: <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:44:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu49-00034l-9r
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbZIMSon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbZIMSom
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:44:42 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:20766 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbZIMSok (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:44:40 -0400
Received: by an-out-0708.google.com with SMTP id d40so7549088and.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=I4A4a+Tf0cNI9R4hBHeMK2pMC3/lqrzfl8wCcD6rRBU=;
        b=AeBR2JrgFb6LZx4NfdFNBC9T6CQiqxUQWB48pqfrQbQhpze6R9CkItEgSUFa+9fMu/
         LTYiRSMRAkWZoLUyUm43JBhJf6E1u1Jndswma3o2BqF4h/jEpXVxlgbfJa0HRGlbnobo
         VC9ZhHdHtaFxEjEzslDW/IqUCCyod70O+V5cs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bnkCxgkETP2zurnTkE7OFB6nqg5cTBxoDQ7N5vW2HKfI2maKaq5VqjGNj4yK8O6VjH
         Dr0Y0mcgU9BPErrk8ebcjAqGJdFE4tbox4sGfJFqYBsFxEKSJInSbv6kcxwFW+4T/+0d
         YeFREd2lwkDwmvoBfRNsrTW/fmtVofVDMO+vg=
Received: by 10.101.111.14 with SMTP id o14mr5581696anm.83.1252867483925;
        Sun, 13 Sep 2009 11:44:43 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128384>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../org/spearce/jgit/lib/ObjectDirectoryTest.java  |   80 ++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
new file mode 100644
index 0000000..fe019af
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
@@ -0,0 +1,80 @@
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.util.UUID;
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
+			deleteDir(testDir);
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
+	public boolean deleteDir(File dir) {
+        if (dir.isDirectory()) {
+            String[] children = dir.list();
+            for (int i=0; i<children.length; i++) {
+                boolean success = deleteDir(new File(dir, children[i]));
+                if (!success) {
+                    return false;
+                }
+            }
+        }
+    
+        // The directory is now empty so delete it
+        return dir.delete();
+    }
+
+	private void createTestDir(){
+		testDir.mkdir();
+	}
+	
+}
-- 
1.6.4.2
