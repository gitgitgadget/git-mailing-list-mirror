From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: [PATCH] userdiff: add built-in pattern for CSS
Date: Fri, 20 May 2016 15:28:29 +0200
Message-ID: <20160520132829.7937-1-william.duclot@ensimag.grenoble-inp.fr>
Cc: simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 15:29:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3kUM-00087N-FX
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 15:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978AbcETN24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 09:28:56 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:41466 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753222AbcETN2z (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2016 09:28:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 0AFDC2537;
	Fri, 20 May 2016 15:28:51 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wnaUM3RAba7M; Fri, 20 May 2016 15:28:50 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id F050D2536;
	Fri, 20 May 2016 15:28:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id EA4632066;
	Fri, 20 May 2016 15:28:50 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YjhAnItzDJRA; Fri, 20 May 2016 15:28:50 +0200 (CEST)
Received: from Messiaen.grenet.fr (eduroam-033144.grenet.fr [130.190.33.144])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id D14932064;
	Fri, 20 May 2016 15:28:50 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.403.gdf0b511.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295164>

CSS is widely used, motivating it being included as a built-in pattern.

It must be noted that the word_regex for CSS (i.e. the regex defining
what is a word in the language) does not consider '.' and '#' characters
(in CSS selectors) to be part of the word. This behavior is documented
by the test t/t4018/css-rule.
The logic behind this behavior is the following: identifiers in CSS
selectors are identifiers in a HTML/XML document. Therefore, the '.'/'#'
character are not part of the identifier, but an indicator of the nature
of the identifier in HTML/XML (class or id). Diffing ".class1" and
".class2" must show that the class name is changed, but we still are
selecting a class.

Signed-off-by: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 Documentation/gitattributes.txt |  2 ++
 t/t4018-diff-funcname.sh        |  1 +
 t/t4018/css-rule                |  4 ++++
 t/t4034-diff-words.sh           |  1 +
 t/t4034/css/expect              | 16 ++++++++++++++++
 t/t4034/css/post                |  9 +++++++++
 t/t4034/css/pre                 |  9 +++++++++
 userdiff.c                      |  8 ++++++++
 8 files changed, 50 insertions(+)
 create mode 100644 t/t4018/css-rule
 create mode 100644 t/t4034/css/expect
 create mode 100644 t/t4034/css/post
 create mode 100644 t/t4034/css/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e3b1de8..81f60ad 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -525,6 +525,8 @@ patterns are available:
 
 - `csharp` suitable for source code in the C# language.
 
+- `css` suitable for source code in the CSS language.
+
 - `fortran` suitable for source code in the Fortran language.
 
 - `fountain` suitable for Fountain documents.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 67373dc..1795ffc 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -30,6 +30,7 @@ diffpatterns="
 	bibtex
 	cpp
 	csharp
+	css
 	fortran
 	fountain
 	html
diff --git a/t/t4018/css-rule b/t/t4018/css-rule
new file mode 100644
index 0000000..84ed754
--- /dev/null
+++ b/t/t4018/css-rule
@@ -0,0 +1,4 @@
+RIGHT label.control-label {
+    margin-top: 10px!important;
+    border : 10px ChangeMe #C6C6C6;
+}
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index f2f55fc..912df91 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -302,6 +302,7 @@ test_language_driver ada
 test_language_driver bibtex
 test_language_driver cpp
 test_language_driver csharp
+test_language_driver css
 test_language_driver fortran
 test_language_driver html
 test_language_driver java
diff --git a/t/t4034/css/expect b/t/t4034/css/expect
new file mode 100644
index 0000000..b025d88
--- /dev/null
+++ b/t/t4034/css/expect
@@ -0,0 +1,16 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 735f301..bdf6a90 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,9 +1,9 @@<RESET>
+.<RED>class-form<RESET><GREEN>other-form<RESET> label.control-label {
+    margin-top: <RED>10<RESET><GREEN>15<RESET>px!important;
+    border : 10px <RED>dashed<RESET><GREEN>dotted<RESET> #C6C6C6;
+}<RESET>
+<RED>#CCCCCC<RESET>
+<RED>padding-bottom<RESET><GREEN>#CCCCCB<RESET>
+<GREEN>margin-left<RESET>
+150<RED>px<RESET><GREEN>em<RESET>
+10px
+<RED>!important<RESET>
+<RED>div<RESET><GREEN>li<RESET>.class#id
diff --git a/t/t4034/css/post b/t/t4034/css/post
new file mode 100644
index 0000000..bdf6a90
--- /dev/null
+++ b/t/t4034/css/post
@@ -0,0 +1,9 @@
+.other-form label.control-label {
+    margin-top: 15px!important;
+    border : 10px dotted #C6C6C6;
+}
+#CCCCCB
+margin-left
+150em
+10px
+li.class#id
diff --git a/t/t4034/css/pre b/t/t4034/css/pre
new file mode 100644
index 0000000..735f301
--- /dev/null
+++ b/t/t4034/css/pre
@@ -0,0 +1,9 @@
+.class-form label.control-label {
+    margin-top: 10px!important;
+    border : 10px dashed #C6C6C6;
+}
+#CCCCCC
+padding-bottom
+150px
+10px!important
+div.class#id
diff --git a/userdiff.c b/userdiff.c
index 6bf2505..0f9cfbe 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -148,6 +148,14 @@ PATTERNS("csharp",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
+PATTERNS("css",
+	 "^([^,{}]+)((,[^}]*\\{)|([ \t]*\\{))$",
+	 /* -- */
+	 /* This regex comes from W3C CSS specs. Should theoretically also allow ISO 10646 characters U+00A0 and higher,
+	  * this not handled in this regex. */
+	 "-?[_a-zA-F][-_a-zA-F0-9]*" /* identifiers */
+	 "|-?[0-9]+|\\#[0-9a-fA-F]+" /* numbers */
+),
 { "default", NULL, -1, { NULL, 0 } },
 };
 #undef PATTERNS
-- 
2.8.2.403.gdf0b511.dirty
