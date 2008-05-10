From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH 05/22] Added ProjectSeeker class.
Date: Sat, 10 May 2008 15:00:23 +0200
Message-ID: <1210424440-13886-6-git-send-email-florianskarten@web.de>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 15:03:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juojc-0008FZ-1U
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 15:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278AbYEJNBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 09:01:00 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755708AbYEJNA5
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 09:00:57 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:50513 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404AbYEJNAo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 09:00:44 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id C2881DC19A17
	for <git@vger.kernel.org>; Sat, 10 May 2008 15:00:43 +0200 (CEST)
Received: from [84.150.90.150] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Juogt-000860-00; Sat, 10 May 2008 15:00:43 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210424440-13886-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19w3LtOLUmVUFyyV86gVJmMNoQwHZGy5xhEYSY1
	aR3DwwOUyJqLHKXe7fV5V4fPFUw4D4EIK1e3T29sBB6U6ZXLCe
	rs3ITshY8EfQQETHPx/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81666>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/lib/Project.java          |    5 +-
 .../src/org/spearce/jgit/lib/ProjectSeeker.java    |  118 ++++++++++++=
++++++++
 2 files changed, 122 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/ProjectSe=
eker.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Project.java b/o=
rg.spearce.jgit/src/org/spearce/jgit/lib/Project.java
index 6e72486..f6b6a17 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Project.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Project.java
@@ -19,7 +19,10 @@ package org.spearce.jgit.lib;
 import java.io.File;
=20
 /**
- * Represents a project controlled by git. Use {@link ProjectFactory} =
in order to create an object of this class.
+ * Represents a project controlled by git. Use {@link ProjectFactory} =
in order to create an object of this class. If you
+ * don't want to create a new repository, but need a new {@link Projec=
t}
+ * instance then use {@link ProjectSeeker}.
+ *=20
  * @author Florian K=C3=B6berle
  *
  */
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ProjectSeeker.ja=
va b/org.spearce.jgit/src/org/spearce/jgit/lib/ProjectSeeker.java
new file mode 100644
index 0000000..3aa5284
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ProjectSeeker.java
@@ -0,0 +1,118 @@
+/*
+ *  Copyright (C) 2008 Florian K=C3=B6berle
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public
+ *  License, version 2, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public
+ *  License along with this library; if not, write to the Free Softwar=
e
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  021=
10-1301
+ */
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.io.IOException;
+import static org.spearce.jgit.lib.GitPathConstants.OBJECTS_DIRECTORY_=
NAME;
+import static org.spearce.jgit.lib.GitPathConstants.REPOSITORY_DIRECTO=
RY_NAME;
+import static org.spearce.jgit.lib.GitPathConstants.REFS_DIRECTORY_NAM=
E;
+import static org.spearce.jgit.lib.GitPathConstants.HEAD_FILE_NAME;
+
+/**
+ * Use this class to create instances of {@link Project}.
+ *=20
+ * @author Florian K=C3=B6berle
+ *=20
+ */
+public class ProjectSeeker {
+
+	/**
+	 * Find the git repository for the current working directory.
+	 *=20
+	 * @return a {@link Repository}.
+	 * @throws IOException
+	 *             if the system property user.dir isn't set or if it is
+	 *             invalid.
+	 */
+	public Project findProject() throws IOException {
+		final String workingDirectoryPath =3D System.getProperty("user.dir")=
;
+		if (workingDirectoryPath =3D=3D null) {
+			throw new IOException("unable to get working directory");
+		}
+		final File workingDirectoryFile =3D new File(workingDirectoryPath);
+		if (!workingDirectoryFile.exists()) {
+			throw new IOException("Working directory path is invalid");
+		}
+		return findProject(workingDirectoryFile);
+	}
+
+	/**
+	 * Checks if a path is a valid git repository. Works similar like the=
 method
+	 * is_git_directory from the original setup.c file.
+	 *=20
+	 * @param directory
+	 *            the path which should be checked.
+	 * @return true if the path is a valid git repository.
+	 */
+	private boolean isRepository(File directory) {
+		if (!directory.isDirectory()) {
+			return false;
+		}
+
+		final File objectDirectory =3D new File(directory, OBJECTS_DIRECTORY=
_NAME);
+		if (!objectDirectory.isDirectory()) {
+			return false;
+		}
+
+		final File refsDirectory =3D new File(directory, REFS_DIRECTORY_NAME=
);
+		if (!refsDirectory.isDirectory()) {
+			return false;
+		}
+
+		final File head =3D new File(directory, HEAD_FILE_NAME);
+		if (!hasValidateHeadRef(head)) {
+			return false;
+		}
+
+		return true;
+	}
+
+	/**
+	 * Checks for example if a path is a valid HEAD file. Should do the s=
ame
+	 * like validate_headref from path.c.
+	 *=20
+	 * @param path
+	 *            is the path of the HEAD file.
+	 * @return true if it has a valid head reference.
+	 */
+	private static final boolean hasValidateHeadRef(File path) {
+		return true; // TODO stub. view int validate_headref(const char
+		// *path) at path.c
+	}
+
+	private Project findProject(File directory) throws IOException {
+		File currentDirectory =3D directory.getAbsoluteFile();
+		while (true) {
+			final File commonGitDirectory =3D new File(directory,
+					REPOSITORY_DIRECTORY_NAME);
+			if (isRepository(commonGitDirectory)) {
+				return new Project(currentDirectory, new Repository(
+						commonGitDirectory));
+			}
+
+			if (isRepository(currentDirectory)) {
+				return new Project(null, new Repository(currentDirectory));
+			}
+			currentDirectory =3D currentDirectory.getParentFile();
+			if (currentDirectory =3D=3D null) {
+				throw new IOException("Can't find git repository");
+			}
+		}
+
+	}
+}
--=20
1.5.2.5
