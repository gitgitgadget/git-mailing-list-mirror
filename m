From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH 03/22] Added a class Project which represents a project directory and it's repository.
Date: Sat, 10 May 2008 15:00:21 +0200
Message-ID: <1210424440-13886-4-git-send-email-florianskarten@web.de>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 15:03:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juojd-0008FZ-9X
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 15:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbYEJNBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 09:01:04 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755254AbYEJNBA
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 09:01:00 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:49349 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402AbYEJNAn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 09:00:43 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id CD0CCDA50016
	for <git@vger.kernel.org>; Sat, 10 May 2008 15:00:42 +0200 (CEST)
Received: from [84.150.90.150] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Juogs-000860-00; Sat, 10 May 2008 15:00:42 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210424440-13886-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19n6P2L59Pupwk8LlpbG5kAf0niXouQF5qS7Hqi
	3VzwCzt/BODGKx2+hlHyYgjh2De/Vz967U4xFho807n1ebBsjR
	M8Nc9hPOe+MN2Lhorujg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81673>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/lib/GitPathConstants.java |   28 +++++++++
 .../src/org/spearce/jgit/lib/Project.java          |   63 ++++++++++++=
++++++++
 .../src/org/spearce/jgit/lib/ProjectFactory.java   |   57 ++++++++++++=
++++++
 3 files changed, 148 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/GitPathCo=
nstants.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/Project.j=
ava
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/ProjectFa=
ctory.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitPathConstants=
=2Ejava b/org.spearce.jgit/src/org/spearce/jgit/lib/GitPathConstants.ja=
va
new file mode 100644
index 0000000..3d99d33
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitPathConstants.java
@@ -0,0 +1,28 @@
+package org.spearce.jgit.lib;
+
+/**
+ * Collection of constants related to the git repository directory lay=
out.
+ *=20
+ */
+public class GitPathConstants {
+	/**
+	 * The name of the repository directory in the project directory.
+	 */
+	public static final String REPOSITORY_DIRECTORY_NAME =3D ".git";
+
+	/**
+	 * Contains the name of the objects directory in the repository direc=
tory.
+	 */
+	public static final String OBJECTS_DIRECTORY_NAME =3D "objects";
+
+	/**
+	 * Contains the name of the refs directory in the repository director=
y.
+	 */
+	public static final String REFS_DIRECTORY_NAME =3D "refs";
+=09
+	/**
+	 * Contains the name of the HEAD file in the repository directory.
+	 */
+	public static final String HEAD_FILE_NAME =3D "HEAD";
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Project.java b/o=
rg.spearce.jgit/src/org/spearce/jgit/lib/Project.java
new file mode 100644
index 0000000..6e72486
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Project.java
@@ -0,0 +1,63 @@
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
+
+/**
+ * Represents a project controlled by git. Use {@link ProjectFactory} =
in order to create an object of this class.
+ * @author Florian K=C3=B6berle
+ *
+ */
+public class Project {
+	private final File directory;
+
+	private final Repository repository;
+
+	/**
+	 * This constructor should be only used by the class {@link ProjectFa=
ctory}.
+	 * @param directory defines the value of the directory field.
+	 * @param repository defines the value of the repository field.
+	 */
+	Project(File directory, Repository repository) {
+		this.directory =3D directory;
+		this.repository =3D repository;
+	}
+
+	/**
+	 *=20
+	 * @return the directory which contains the files of the project. Usu=
ally this directory contain a .git directory with the repository.
+	 */
+	public File getDirectory() {
+		return directory;
+	}
+
+	/**
+	 * @return the {@link Repository} object of the project.
+	 */
+	public Repository getRepository() {
+		return repository;
+	}
+
+	/**
+	 * Closes the git repository of this project.
+	 */
+	public void closeRepository() {
+		repository.close();
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ProjectFactory.j=
ava b/org.spearce.jgit/src/org/spearce/jgit/lib/ProjectFactory.java
new file mode 100644
index 0000000..b4e5660
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ProjectFactory.java
@@ -0,0 +1,57 @@
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
+import static org.spearce.jgit.lib.GitPathConstants.REPOSITORY_DIRECTO=
RY_NAME;
+
+/**
+ * Creates a new {@link Project} and initialize a repository for it.=20
+ *=20
+ * @author Florian K=C3=B6berle
+ *=20
+ */
+public class ProjectFactory {
+
+	/**
+	 * @param projectDirectory
+	 *            the directory with the project files.
+	 * @return a new project with a new and open repository.
+	 * @throws IOException
+	 *             thrown by {@link Repository#create()}
+	 */
+	public Project createProject(File projectDirectory) throws IOExceptio=
n {
+		final File gitDirectory =3D new File(projectDirectory, REPOSITORY_DI=
RECTORY_NAME);
+		if (gitDirectory.exists()) {
+			throw new IllegalArgumentException(
+					"Repository exists in given project directory.");
+		}
+		final Repository repository =3D new Repository(gitDirectory);
+		try {
+			repository.create();
+			return new Project(projectDirectory, repository);
+		} catch (RuntimeException e) {
+			repository.close();
+			throw e;
+		} catch (IOException e) {
+			repository.close();
+			throw e;
+		}
+	}
+
+}
--=20
1.5.2.5
