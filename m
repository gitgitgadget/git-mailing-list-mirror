From: mr.gaffo@gmail.com
Subject: [PATCH JGit 4/5] Adding in a InfoDatabase like ObjectDatabase and and implementation based upon a directory.
Date: Tue, 15 Sep 2009 19:48:35 -0500
Message-ID: <1253062116-13830-5-git-send-email-mr.gaffo@gmail.com>
References: <1253062116-13830-1-git-send-email-mr.gaffo@gmail.com>
 <1253062116-13830-2-git-send-email-mr.gaffo@gmail.com>
 <1253062116-13830-3-git-send-email-mr.gaffo@gmail.com>
 <1253062116-13830-4-git-send-email-mr.gaffo@gmail.com>
Cc: Mike Gaffney <mr.gaffo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 02:56:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnip7-0002FC-Dh
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 02:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbZIPA4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 20:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbZIPA4c
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 20:56:32 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:19013 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbZIPA4b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 20:56:31 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1480831qwb.37
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 17:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YFx6akEvnF+YrsCphEOpW5jnXiXfEXIKDrnQvoNFg/U=;
        b=EQwmQCsKdlssggNVARQlDNyuZFAA5Gu4yofrCTqbRYWQc7xRbvqzEV60n+TSxG5kf9
         pg/aK4mF39z1s5SnJ3IkFojpmITBxyx9Jz7FLDtw6nx1e0g1jVy1a5AL1lA2rbNj9afk
         gh/EG2SBAcGfToSFtVeU+U9cOsrCtMZwt9TV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GE08MkqChXbByNpCUjExwfIZbU4DQAKYoFuhty/sdKTGmgjT+G1e+hMeMUtWSg65QK
         NywLdPxhBhReVRMNQ+3WgMGdfHvGKrG9KZsNi7fhoNWYVcdrmGnh95aId0bPg+ypgocR
         0jzkVtZ1ERspAoCnTXJNcRr1dnDV2VBaYStpI=
Received: by 10.224.59.144 with SMTP id l16mr6944376qah.132.1253062128855;
        Tue, 15 Sep 2009 17:48:48 -0700 (PDT)
Received: from localhost.localdomain (nat.asynchrony.com [66.236.120.131])
        by mx.google.com with ESMTPS id 4sm173278qwe.5.2009.09.15.17.48.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Sep 2009 17:48:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1253062116-13830-4-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128600>

From: Mike Gaffney <mr.gaffo@gmail.com>

Signed-off-by: Mike Gaffney <mr.gaffo@gmail.com>
---
 .../jgit/lib/InfoDirectoryDatabaseTest.java        |   66 ++++++++++++++++++++
 .../org/spearce/jgit/lib/ObjectDirectoryTest.java  |    1 -
 .../src/org/spearce/jgit/lib/InfoDatabase.java     |   44 +++++++++++++
 .../spearce/jgit/lib/InfoDirectoryDatabase.java    |   54 ++++++++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |   11 +++
 5 files changed, 175 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java
new file mode 100644
index 0000000..066473d
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/InfoDirectoryDatabaseTest.java
@@ -0,0 +1,66 @@
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
+
+import org.spearce.jgit.util.JGitTestUtil;
+
+import junit.framework.TestCase;
+
+public class InfoDirectoryDatabaseTest extends TestCase {
+
+	private File testDir;
+
+	@Override
+	protected void setUp() throws Exception {
+		testDir = JGitTestUtil.generateTempDirectoryFileObject();
+	}
+
+	@Override
+	protected void tearDown() throws Exception {
+		if (testDir.exists()){
+			JGitTestUtil.recursiveDelete(testDir, false, getClass().getName() + "." + getName(), true);
+		}
+	}
+	
+	public void testCreateCreatesDirectory() throws Exception {
+		assertFalse(testDir.exists());
+		new InfoDirectoryDatabase(testDir).create();
+		assertTrue(testDir.exists());
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
index 204fb7c..8c1d32d 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
@@ -38,7 +38,6 @@
 
 import java.io.File;
 import java.io.IOException;
-import java.util.ArrayList;
 import java.util.List;
 
 import org.spearce.jgit.util.JGitTestUtil;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java
new file mode 100644
index 0000000..2a8d88d
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDatabase.java
@@ -0,0 +1,44 @@
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
+public abstract class InfoDatabase {
+
+	public void create() {
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java
new file mode 100644
index 0000000..90655e8
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/InfoDirectoryDatabase.java
@@ -0,0 +1,54 @@
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
+
+public class InfoDirectoryDatabase extends InfoDatabase {
+
+	private File info;
+
+	public InfoDirectoryDatabase(final File directory) {
+		info = directory;
+	}
+	
+	@Override
+	public void create() {
+		info.mkdirs();
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 46b7804..f658b5c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -97,6 +97,8 @@
 	private final RefDatabase refs;
 
 	private final ObjectDirectory objectDatabase;
+	
+	private final InfoDatabase infoDatabase;
 
 	private GitIndex index;
 
@@ -116,6 +118,7 @@ public Repository(final File d) throws IOException {
 		gitDir = d.getAbsoluteFile();
 		refs = new RefDatabase(this);
 		objectDatabase = new ObjectDirectory(FS.resolve(gitDir, "objects"));
+		infoDatabase = new InfoDirectoryDatabase(FS.resolve(gitDir, "info"));
 
 		final FileBasedConfig userConfig;
 		userConfig = SystemReader.getInstance().openUserConfig();
@@ -177,6 +180,7 @@ public void create(boolean bare) throws IOException {
 		gitDir.mkdirs();
 		refs.create();
 		objectDatabase.create();
+		infoDatabase.create();
 
 		new File(gitDir, "branches").mkdir();
 		new File(gitDir, "remotes").mkdir();
@@ -210,6 +214,13 @@ public File getObjectsDirectory() {
 	public ObjectDatabase getObjectDatabase() {
 		return objectDatabase;
 	}
+	
+	/**
+	 * @return the info database which stores this repository's info
+	 */
+	public InfoDatabase getInfoDatabase() {
+		return infoDatabase;
+	}
 
 	/**
 	 * @return the configuration of this repository
-- 
1.6.4.2
