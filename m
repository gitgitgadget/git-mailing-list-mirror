From: =?UTF-8?q?Zoe=CC=88=20Blade?= <zoe@bytenoise.co.uk>
Subject: [PATCH] userdiff: add support for Fountain documents
Date: Fri, 17 Jul 2015 12:59:11 +0100
Message-ID: <1437134351-15392-1-git-send-email-zoe@bytenoise.co.uk>
Cc: =?UTF-8?q?Zoe=CC=88=20Blade?= <zoe@bytenoise.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 14:08:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG4R0-0007hw-Jt
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 14:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbbGQMIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 08:08:05 -0400
Received: from 702218-web2.barracudas.co.uk ([134.213.40.106]:47612 "EHLO
	702218-web2.barracudas.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753270AbbGQMIE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2015 08:08:04 -0400
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jul 2015 08:08:04 EDT
Received: by 702218-web2.barracudas.co.uk (Postfix, from userid 502)
	id 850CC38070D; Fri, 17 Jul 2015 12:59:20 +0100 (BST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274065>

Add support for Fountain, a plain text screenplay format.  In the
structure of a screenplay, scenes are roughly analogous to functions,
in the sense that it makes your job slightly easier if you can see
which ones were changed in a given range of patches.
---
 Documentation/gitattributes.txt | 2 ++
 t/t4018-diff-funcname.sh        | 1 +
 t/t4018/fountain-scene          | 4 ++++
 userdiff.c                      | 2 ++
 4 files changed, 9 insertions(+)
 create mode 100644 t/t4018/fountain-scene

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 81fe586..e3b1de8 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -527,6 +527,8 @@ patterns are available:
 
 - `fortran` suitable for source code in the Fortran language.
 
+- `fountain` suitable for Fountain documents.
+
 - `html` suitable for HTML/XHTML documents.
 
 - `java` suitable for source code in the Java language.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 1dbaa38..67373dc 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -31,6 +31,7 @@ diffpatterns="
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
index 2ccbee5..5316b48 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -35,6 +35,8 @@ IPATTERN("fortran",
 	  * they would have been matched above as a variable anyway. */
 	 "|[-+]?[0-9.]+([AaIiDdEeFfLlTtXx][Ss]?[-+]?[0-9.]*)?(_[a-zA-Z0-9][a-zA-Z0-9_]*)?"
 	 "|//|\\*\\*|::|[/<>=]="),
+PATTERNS("fountain", "^((INT|EST|EXT)?\\.[A-Z0-9' -]+)$",
+	 "[^ \t-]+"),
 PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
 	 "[^<>= \t]+"),
 PATTERNS("java",
-- 
2.5.0.rc2.28.g6003e7f.dirty
