From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH 04/22] Added a "init" command to the git like command line tool.
Date: Sat, 10 May 2008 15:00:22 +0200
Message-ID: <1210424440-13886-5-git-send-email-florianskarten@web.de>
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
	id 1Juojc-0008FZ-Li
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 15:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402AbYEJNBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbYEJNA6
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 09:00:58 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:44576 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbYEJNAo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 09:00:44 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 47883DE983BB
	for <git@vger.kernel.org>; Sat, 10 May 2008 15:00:43 +0200 (CEST)
Received: from [84.150.90.150] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Juogs-000860-01; Sat, 10 May 2008 15:00:42 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210424440-13886-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19AO6p6gqSdsh3vZH0TTUiEAZDPxrBnFNGH+3SK
	9awC76y0UOLLud5oF1B6ua44mI+h8ZpK1Rs7oJ8PkMLbXQ0gT/
	GY8ypHE+l6Wbtbf1cbjw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81672>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/pgm/InitCommand.java      |   71 ++++++++++++=
++++++++
 .../src/org/spearce/jgit/pgm/MainProgram.java      |    1 +
 2 files changed, 72 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/pgm/InitComma=
nd.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/InitCommand.java=
 b/org.spearce.jgit/src/org/spearce/jgit/pgm/InitCommand.java
new file mode 100644
index 0000000..4bc7ca8
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/InitCommand.java
@@ -0,0 +1,71 @@
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
+package org.spearce.jgit.pgm;
+
+import java.io.File;
+import java.io.IOException;
+
+import org.spearce.jgit.lib.Project;
+import org.spearce.jgit.lib.ProjectFactory;
+
+import static java.lang.String.format;
+
+/**
+ * This class is immutable. It's {@link #execute} method is used to cr=
eate git
+ * repositories.
+ *=20
+ * @author Florian K=C3=B6berle
+ *=20
+ */
+public class InitCommand implements Command {
+	/**
+	 * Use this instance instead of creating a new ${link InitCommand}. Y=
ou
+	 * don't need to create an instance of this class as it is immutable =
and not
+	 * configurable.
+	 */
+	public static InitCommand INSTANCE =3D new InitCommand();
+
+	public void execute(String... args) throws IOException {
+		final String currentDirectoryPathString =3D System
+				.getProperty("user.dir");
+		if (currentDirectoryPathString =3D=3D null) {
+			throw new IOException("Unable to get current working directory");
+		}
+		final File currentDirectoryPath =3D new File(currentDirectoryPathStr=
ing);
+		if (!currentDirectoryPath.isDirectory()) {
+			final String message =3D format(
+					"No directory found at \"%s\". It was the current working directo=
ry at program start.",
+					currentDirectoryPathString);
+			throw new IOException(message);
+		}
+		final ProjectFactory projectFactory =3D new ProjectFactory();
+
+		final Project project =3D projectFactory
+				.createProject(currentDirectoryPath);
+		try {
+			System.out.printf("Created a git repository at: %s%n", project
+					.getRepository().getDirectory());
+		} finally {
+			project.closeRepository();
+		}
+
+	}
+
+	public String getShortDescription() {
+		return "Creates an empty git repository.";
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java=
 b/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java
index 69cd96f..7601f31 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java
@@ -35,6 +35,7 @@ public class MainProgram {
=20
 	static {
 		final Map<String, Command> commands =3D new HashMap<String, Command>=
();
+		commands.put("init", InitCommand.INSTANCE);
 		commands.put("help", HelpCommand.INSTANCE);
 		commandNameToObjectMap =3D Collections.unmodifiableMap(commands);
 	}
--=20
1.5.2.5
