From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 06/24] Added a "init" command to the git like command line tool.
Date: Mon, 12 May 2008 22:13:24 +0200
Message-ID: <1210623222-24908-7-git-send-email-florianskarten@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:23:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveSn-00086f-6J
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025AbYELUOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:14:49 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754993AbYELUOr
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:14:47 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40162 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbYELUNp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:45 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 4C6DDDECEBCE
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:44 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JveP1-00016x-01; Mon, 12 May 2008 22:13:43 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/VOB7jE0h6Nm2JnHAxtLSbGMXuyzwyuCWT310/
	4b4N3TQBlNjr1LW/i4kvYO2pH6UZDfuJ3QS67FK4g101dQJ8oe
	nWhYS4w1c8iIoJi7S4kQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81926>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/pgm/InitCommand.java      |   67 ++++++++++++=
++++++++
 .../src/org/spearce/jgit/pgm/MainProgram.java      |    1 +
 2 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/pgm/InitComma=
nd.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/pgm/InitCommand.java=
 b/org.spearce.jgit/src/org/spearce/jgit/pgm/InitCommand.java
new file mode 100644
index 0000000..e87e777
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/InitCommand.java
@@ -0,0 +1,67 @@
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
+import static org.spearce.jgit.lib.Repository.createWorkTree;
+import org.spearce.jgit.lib.WorkTree;
+
+import static java.lang.String.format;
+
+/**
+ * The {@link #execute} method of this class is used to create git rep=
ositories.
+ * This class is immutable.
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
+
+		final WorkTree workTree =3D createWorkTree(currentDirectoryPath);
+		try {
+			System.out.printf("Created a git repository at: %s%n", workTree
+					.getRepository().getDirectory());
+		} finally {
+			workTree.closeRepository();
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
index c9af51c..1ade91b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/pgm/MainProgram.java
@@ -33,6 +33,7 @@ public class MainProgram {
=20
 	static {
 		final Map<String, Command> commands =3D new HashMap<String, Command>=
();
+		commands.put("init", InitCommand.INSTANCE);
 		commands.put("help", HelpCommand.INSTANCE);
 		commandNameToObjectMap =3D Collections.unmodifiableMap(commands);
 	}
--=20
1.5.4.3
