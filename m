From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v4 23/24] Added a super class for RepositoryTestCase with a createTemporaryDirectory() method.
Date: Fri, 13 Jun 2008 20:35:20 +0200
Message-ID: <1213382121-19786-23-git-send-email-florianskarten@web.de>
References: <4852BCCA.4030404@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:39:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7EAW-0005zA-3F
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbYFMSgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:36:22 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbYFMSgU
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:36:20 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:43456 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbYFMSff (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:35:35 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 517BCE184F1E
	for <git@vger.kernel.org>; Fri, 13 Jun 2008 20:35:35 +0200 (CEST)
Received: from [84.150.79.9] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E7a-0000eI-01; Fri, 13 Jun 2008 20:35:34 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <4852BCCA.4030404@web.de>
In-Reply-To: <4852BCCA.4030404@web.de>
References: <4852BCCA.4030404@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18sI/Me7Of7VFpVvtzFYRgnBW8oZfh31dbUgh2G
	E7ack7jGrcySPSWjhszF9vsnswP0PqK7To273qifXNzRJkpY8/
	2K3E18Jtz/lNJkWo5AyA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84930>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../tst/org/spearce/jgit/lib/AbstractTestCase.java |  108 ++++++++++++=
++++++++
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   22 +----
 2 files changed, 109 insertions(+), 21 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/Abst=
ractTestCase.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbstractTes=
tCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbstractTes=
tCase.java
new file mode 100644
index 0000000..c017fc0
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/AbstractTestCase.j=
ava
@@ -0,0 +1,108 @@
+/*
+ * Copyright (C) 2006,  Shawn Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Florian K=C3=B6berle <florianskarten@web.de>
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
+
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.io.IOException;
+import java.util.Stack;
+
+import junit.framework.TestCase;
+
+/**
+ * This class can be used as base testcase
+ *=20
+ */
+public abstract class AbstractTestCase extends TestCase {
+	private final Stack<File> directoriesToDelete =3D new Stack<File>();
+
+	protected void setUp() throws Exception {
+		super.setUp();
+		// Do not delete directories from other test runs
+		// in order to avoid side effects between tests.
+		directoriesToDelete.clear();
+	}
+
+	/**
+	 * Creates a new directory for test purposes. The directory and it's =
content
+	 * will be deleted when the test is over.
+	 *=20
+	 * @return a temporary directory for the use in one test.
+	 * @throws IOException
+	 *             if the creation of the temporary directory fails.
+	 */
+	protected File createTemporaryDirectory() throws IOException {
+		File directory =3D null;
+		do {
+			directory =3D File.createTempFile("test", "");
+			if (!directory.delete())
+				throw new IOException("can't delete temporary file");
+
+			if (!directory.mkdir())
+				directory =3D null;
+
+		} while (directory =3D=3D null);
+		return directory;
+	}
+
+	protected static void recursiveDelete(final File dir) {
+		final File[] ls =3D dir.listFiles();
+		if (ls !=3D null) {
+			for (int k =3D 0; k < ls.length; k++) {
+				final File e =3D ls[k];
+				if (e.isDirectory()) {
+					recursiveDelete(e);
+				} else {
+					e.delete();
+				}
+			}
+		}
+		dir.delete();
+		if (dir.exists()) {
+			System.out.println("Warning: Failed to delete " + dir);
+		}
+	}
+
+	protected void tearDown() throws Exception {
+		while (!directoriesToDelete.isEmpty()) {
+			final File directory =3D directoriesToDelete.pop();
+			recursiveDelete(directory);
+		}
+		super.tearDown();
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryT=
estCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/Repositor=
yTestCase.java
index aae9ed6..9719066 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase=
=2Ejava
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase=
=2Ejava
@@ -46,9 +46,7 @@ import java.io.InputStreamReader;
 import java.io.OutputStreamWriter;
 import java.io.Reader;
=20
-import junit.framework.TestCase;
-
-public abstract class RepositoryTestCase extends TestCase {
+public abstract class RepositoryTestCase extends AbstractTestCase {
=20
 	protected final File trashParent =3D new File("trash");
=20
@@ -65,24 +63,6 @@ public abstract class RepositoryTestCase extends Tes=
tCase {
 		jcommitter =3D new PersonIdent("J. Committer", "jcommitter@example.c=
om");
 	}
=20
-	protected static void recursiveDelete(final File dir) {
-		final File[] ls =3D dir.listFiles();
-		if (ls !=3D null) {
-			for (int k =3D 0; k < ls.length; k++) {
-				final File e =3D ls[k];
-				if (e.isDirectory()) {
-					recursiveDelete(e);
-				} else {
-					e.delete();
-				}
-			}
-		}
-		dir.delete();
-		if (dir.exists()) {
-			System.out.println("Warning: Failed to delete " + dir);
-		}
-	}
-
 	protected static void copyFile(final File src, final File dst)
 			throws IOException {
 		final FileInputStream fis =3D new FileInputStream(src);
--=20
1.5.4.3
