From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH 08/22] Added the iterface Rules.
Date: Sat, 10 May 2008 15:00:26 +0200
Message-ID: <1210424440-13886-9-git-send-email-florianskarten@web.de>
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
	id 1Juojd-0008FZ-Ut
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 15:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254AbYEJNBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 09:01:07 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbYEJNBD
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 09:01:03 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:49376 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755507AbYEJNAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 09:00:46 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 29296DA5014B
	for <git@vger.kernel.org>; Sat, 10 May 2008 15:00:45 +0200 (CEST)
Received: from [84.150.90.150] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Juogu-000860-01; Sat, 10 May 2008 15:00:44 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1210424440-13886-1-git-send-email-florianskarten@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/qghX0RAFcUViAl2c3s6EznJfq+4R1HPnIvXXG
	mlwoU7oo1zxBAwW8sgraFY+cAnkZfrYU2V5FiaFX3jI8zJRDsc
	3Hjz1ZJfbahpwjubRuaA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81674>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../org/spearce/jgit/lib/fileiteration/Rules.java  |  101 ++++++++++++=
++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/fileitera=
tion/Rules.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/Ru=
les.java b/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/Rule=
s.java
new file mode 100644
index 0000000..1334a22
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/fileiteration/Rules.jav=
a
@@ -0,0 +1,101 @@
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
+ * A {@link Rules} instances defines ignore or do not ignore rules for=
 files in
+ * a directory. It can't directly be used to match files in sub direct=
ories, but
+ * provides a method {@link #getRulesForSubDirectory}.
+ *=20
+ * @author Florian K=C3=B6berle
+ *=20
+ */
+public interface Rules {
+
+	/**
+	 * Provides the instance of {@link IgnoreAllRules}.
+	 */
+	public static final Rules IGNORE_ALL =3D new IgnoreAllRules();
+
+	/**
+	 * Provides the instance of {@link IgnoreNothingRules}.
+	 */
+	public static final Rules IGNORE_NOTHING =3D new IgnoreNothingRules()=
;
+
+	/**
+	 * @param fileName
+	 *            the name of the file or directory.
+	 * @param fileIsDirectory
+	 *            should be true if the file is a directory.
+	 * @return true if the file or directory should be ignored.
+	 */
+	public abstract boolean toIgnore(String fileName, boolean fileIsDirec=
tory);
+
+	/**
+	 * @param directoryName
+	 *            the sub directory for which you want an {@link Rules}
+	 *            instance.
+	 * @return an {@link Rules} instance, which can be used to check file=
s in
+	 *         the specified sub directory.
+	 */
+	public abstract Rules getRulesForSubDirectory(String directoryName);
+
+	/**
+	 * This implementation ignores everything.
+	 */
+	public static final class IgnoreAllRules implements Rules {
+		private IgnoreAllRules() {
+			// declared to make the constructor private
+		}
+
+		public Rules getRulesForSubDirectory(String directoryName) {
+			return this;
+		}
+
+		public boolean toIgnore(String fileName, boolean fileIsDirectory) {
+			return true;
+		}
+
+		@Override
+		public String toString() {
+			return "ignore all rules";
+		}
+	}
+
+	/**
+	 * This implementation ignores nothing.
+	 */
+	public static final class IgnoreNothingRules implements Rules {
+		private IgnoreNothingRules() {
+			// declared to make the constructor private
+		}
+	=09
+		public Rules getRulesForSubDirectory(String directoryName) {
+			return this;
+		}
+
+		public boolean toIgnore(String fileName, boolean fileIsDirectory) {
+			return false;
+		}
+
+		@Override
+		public String toString() {
+			return "ignore nothing rules";
+		}
+	}
+
+}
\ No newline at end of file
--=20
1.5.2.5
