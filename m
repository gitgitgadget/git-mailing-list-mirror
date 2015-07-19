From: =?UTF-8?q?Zoe=CC=88=20Blade?= <zoe@bytenoise.co.uk>
Subject: [PATCH] userdiff: add support for Fountain documents
Date: Sun, 19 Jul 2015 13:31:22 +0100
Message-ID: <1437309082-19060-1-git-send-email-zoe@bytenoise.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Zoe=CC=88=20Blade?= <zoe@bytenoise.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 14:31:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGnkg-0007eN-4k
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 14:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbbGSMbZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Jul 2015 08:31:25 -0400
Received: from 702218-web2.barracudas.co.uk ([134.213.40.106]:32835 "EHLO
	702218-web2.barracudas.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753368AbbGSMbZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jul 2015 08:31:25 -0400
Received: by 702218-web2.barracudas.co.uk (Postfix, from userid 502)
	id 7346D380600; Sun, 19 Jul 2015 13:31:23 +0100 (BST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274211>

Add support for Fountain, a plain text screenplay format.  Git
facilitates not just programming specifically, but creative writing
in general, so it makes sense to also support other plain text
documents besides source code.

In the structure of a screenplay specifically, scenes are roughly
analogous to functions, in the sense that it makes your job easier
if you can see which ones were changed in a given range of patches.

More information about the Fountain format can be found on its
official website, at http://fountain.io .

Signed-off-by: Zoe=CC=88 Blade <zoe@bytenoise.co.uk>
---
 Documentation/gitattributes.txt | 2 ++
 t/t4018-diff-funcname.sh        | 1 +
 t/t4018/fountain-scene          | 4 ++++
 userdiff.c                      | 2 ++
 4 files changed, 9 insertions(+)
 create mode 100644 t/t4018/fountain-scene

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 81fe586..e3b1de8 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -527,6 +527,8 @@ patterns are available:
=20
 - `fortran` suitable for source code in the Fortran language.
=20
+- `fountain` suitable for Fountain documents.
+
 - `html` suitable for HTML/XHTML documents.
=20
 - `java` suitable for source code in the Java language.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 1dbaa38..67373dc 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -31,6 +31,7 @@ diffpatterns=3D"
 	cpp
 	csharp
 	fortran
+	fountain
 	html
 	java
 	matlab
diff --git a/t/t4018/fountain-scene b/t/t4018/fountain-scene
new file mode 100644
index 0000000..6b3257d
--- /dev/null
+++ b/t/t4018/fountain-scene
@@ -0,0 +1,4 @@
+EXT. STREET RIGHT OUTSIDE - DAY
+
+CHARACTER
+You didn't say the magic phrase, "ChangeMe".
diff --git a/userdiff.c b/userdiff.c
index 2ccbee5..5a600d6 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -35,6 +35,8 @@ IPATTERN("fortran",
 	  * they would have been matched above as a variable anyway. */
 	 "|[-+]?[0-9.]+([AaIiDdEeFfLlTtXx][Ss]?[-+]?[0-9.]*)?(_[a-zA-Z0-9][a-=
zA-Z0-9_]*)?"
 	 "|//|\\*\\*|::|[/<>=3D]=3D"),
+PATTERNS("fountain", "^((\\.|(([Ii][Nn][Tt]|[Ee][Ss][Tt]|[Ee][Xx][Tt])=
?\\.?|[Ii]([Nn][Tt])?\\.?/[Ee]([Xx][Tt])?\\.?) ).+)$",
+	 "[^ \t-]+"),
 PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
 	 "[^<>=3D \t]+"),
 PATTERNS("java",
--=20
2.5.0.rc2.28.g6003e7f.dirty
