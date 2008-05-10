From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH 07/22] Added the class Rule.
Date: Sat, 10 May 2008 15:00:25 +0200
Message-ID: <1210424440-13886-8-git-send-email-florianskarten@web.de>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 15:03:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juoje-0008FZ-Ik
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 15:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbYEJNBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 09:01:09 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754713AbYEJNBG
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 09:01:06 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:50523 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485AbYEJNAp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 09:00:45 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id AD94FDC19A2D
	for <git@vger.kernel.org>; Sat, 10 May 2008 15:00:44 +0200 (CEST)
Received: from [84.150.90.150] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Juogu-000860-00; Sat, 10 May 2008 15:00:44 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210424440-13886-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19oGEJpXzWp+9aDcqC9Pe4Dam51+T8nLVsMsV+u
	mmgxIizDzQJlQ8q5eMDZJZ7+MPdVfJs0ro+eHzeR62YHTU6/2K
	BvZiALsmHv7hERVsQIGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81675>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../org/spearce/jgit/lib/fileiteration/Rule.java   |   58 ++++++++++++=
++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/fileitera=
tion/Rule.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/Ru=
le.java b/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/Rule.=
java
new file mode 100644
index 0000000..733bb6a
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/Rule.java
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
+package org.spearce.jgit.lib.fileiteration;
+
+/**
+ * A Rule defines what to do with a files which match a specified
+ * {@link FilePattern}.
+ */
+class Rule {
+	private boolean ignoreAtMatch;
+
+	private FilePattern pattern;
+
+	Rule(boolean ignoreAtMatch, FilePattern pattern) {
+		this.ignoreAtMatch =3D ignoreAtMatch;
+		this.pattern =3D pattern;
+	}
+
+	FilePattern getPattern() {
+		return pattern;
+	}
+
+	boolean isIgnoreAtMatch() {
+		return ignoreAtMatch;
+	}
+
+	Rule getRuleForSubDirectory(String directoryName) {
+		final FilePattern subPattern =3D pattern
+				.getPatternForSubDirectory(directoryName);
+		if (subPattern =3D=3D pattern) {
+			return this;
+		}
+		return new Rule(ignoreAtMatch, subPattern);
+	}
+
+	boolean canMatchAtThisDirectoryLevel() {
+		return pattern.canMatchAtThisDirectoryLevel();
+	}
+
+	boolean isSameForSubDirectories() {
+		return pattern.isSameForSubDirectories();
+	}
+
+}
--=20
1.5.2.5
