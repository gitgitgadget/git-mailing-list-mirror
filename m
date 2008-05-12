From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v2 12/24] Added the class GlobalFilePattern
Date: Mon, 12 May 2008 22:13:30 +0200
Message-ID: <1210623222-24908-13-git-send-email-florianskarten@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 22:23:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveSk-00086f-2I
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbYELUOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:14:36 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754311AbYELUOe
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:14:34 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40228 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003AbYELUNt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:13:49 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 2C480DECFD07
	for <git@vger.kernel.org>; Mon, 12 May 2008 22:13:47 +0200 (CEST)
Received: from [84.150.98.143] (helo=localhost.localdomain)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JveP4-00016x-01; Mon, 12 May 2008 22:13:46 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210623222-24908-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX18gzcn/ZNL4YXnnXQb4DgbXBBpPpLmIb9N9hOgd
	2e1it2JVUVQNXYM8r0eaNBnLi4XRNzB9If8n/JZZseBYQQFX+C
	+9OM8FX9hq7ah+TNt9iw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81928>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../jgit/treewalk/rules/GlobalFilePattern.java     |   58 ++++++++++++=
++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/GlobalFilePattern.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Globa=
lFilePattern.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/GlobalFilePattern.java
new file mode 100644
index 0000000..ec1f38a
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/GlobalFilePa=
ttern.java
@@ -0,0 +1,58 @@
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
+package org.spearce.jgit.treewalk.rules;
+
+import org.spearce.jgit.lib.FNMatchPattern;
+
+/**
+ * A {@link GlobalFilePattern} defines a pattern for all files in a tr=
ee. A
+ * typical example would be "*.txt", which would match at any file or =
subtree
+ * which ends with ".txt" like "a/b/c.txt" and "a.txt/a.c".
+ *=20
+ */
+class GlobalFilePattern implements FilePattern {
+	private final FNMatchPattern fnMatchPattern;
+
+	private final boolean matchDirectoriesOnly;
+
+	GlobalFilePattern(String fnMatchPatternString, boolean matchDirectori=
esOnly) {
+		this.fnMatchPattern =3D new FNMatchPattern(fnMatchPatternString);
+		this.matchDirectoriesOnly =3D matchDirectoriesOnly;
+	}
+
+	public boolean canMatchAtThisDirectoryLevel() {
+		return true;
+	}
+
+	public FilePattern getPatternForSubDirectory(String directoryName) {
+		if (match(directoryName, true)) {
+			return MATCH_ALWAYS;
+		}
+		return this;
+	}
+
+	public boolean match(String fileName, boolean fileIsDirectory) {
+		if (matchDirectoriesOnly && !fileIsDirectory) {
+			return false;
+		}
+		return fnMatchPattern.matches(fileName);
+	}
+
+	public boolean isSameForSubDirectories() {
+		return false;
+	}
+}
--=20
1.5.4.3
