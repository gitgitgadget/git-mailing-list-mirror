From: Hiroyuki Sano <sh19910711@gmail.com>
Subject: [GSoC][PATCH 1/2] userdiff: add built-in patterns for CSS
Date: Sun,  8 Mar 2015 20:03:43 +0900
Message-ID: <1425812624-6671-1-git-send-email-sh19910711@gmail.com>
Cc: Hiroyuki Sano <sh19910711@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 12:04:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUZ0V-0007TW-Fv
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 12:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbbCHLEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 07:04:22 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:45671 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbbCHLEV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 07:04:21 -0400
Received: by pdjy10 with SMTP id y10so17859421pdj.12
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 04:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0R7LU4QbimPNeZsNyQmjEaVg9h8V26IEYNQgloKhrYc=;
        b=npezuEk+r0cNnm00i18DHiuDb2Xtwl4qjeDE/5JUVZ7P5WidHqSua7HSbyvIaT3/ht
         SbcoU14Cz9EkXcTisBdXwKdRrQHrnIy/nFnd2lBmaHuex2N5rd2+xg3pNPxBsKeioEAn
         ekUx8eKfAdstmmsf/apkW9Yyfpb3tn/4nG3kutZ4Gqi6k/4RHwykumphk/pzBD5p2lxY
         zGLlPw2JMeD55TnJZnuWscj4rnh6b+VGiga3hH8iAmTOgXrYr4bNk9vvF7R/yG4p+m+v
         OV7vQkA/FIKkyE+EoKXE9JdSIIZtZHyavI9gRbqBHJKptOm3AlgztHv84+zgkj9aUhEh
         m7zA==
X-Received: by 10.68.242.200 with SMTP id ws8mr42076068pbc.138.1425812660593;
        Sun, 08 Mar 2015 04:04:20 -0700 (PDT)
Received: from localhost (iris.u-aizu.ac.jp. [163.143.87.170])
        by mx.google.com with ESMTPSA id os6sm14593840pac.28.2015.03.08.04.04.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 04:04:19 -0700 (PDT)
X-Mailer: git-send-email 2.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265085>

Add regex patterns for CSS. The word regex maches selectors, properties,
and values. On the other hand, the funcname regex matches lines contains
the curly brace character.

Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
---
 t/t4018-diff-funcname.sh |  1 +
 t/t4034-diff-words.sh    |  1 +
 t/t4034/css/expect       | 35 +++++++++++++++++++++++++++++++++++
 t/t4034/css/post         | 32 ++++++++++++++++++++++++++++++++
 t/t4034/css/pre          | 32 ++++++++++++++++++++++++++++++++
 userdiff.c               |  3 +++
 6 files changed, 104 insertions(+)
 create mode 100644 t/t4034/css/expect
 create mode 100644 t/t4034/css/post
 create mode 100644 t/t4034/css/pre

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 1dbaa38..29fe220 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -30,6 +30,7 @@ diffpatterns="
 	bibtex
 	cpp
 	csharp
+	css
 	fortran
 	html
 	java
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
index 0000000..8bc6dfd
--- /dev/null
+++ b/t/t4034/css/expect
@@ -0,0 +1,35 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index c53f20b..7e64463 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -2,7 +2,7 @@<RESET> <RESET><MAGENTA>elm1, elm2 {<RESET>
+prop: first-value;<RESET>
+prop: value;<RESET>
+prop: value;<RESET>
+prop: <RED>value<RESET><GREEN>NEW-VALUE<RESET>;
+prop: last-value;<RESET>
+}<RESET>
+
+<CYAN>@@ -10,7 +10,7 @@<RESET> <RESET><MAGENTA>elm3, elm4 {<RESET>
+prop: first-value;<RESET>
+prop: value;<RESET>
+prop: value;<RESET>
+<RED>prop<RESET><GREEN>NEW-PROP<RESET>: value;
+prop: last-value;<RESET>
+}<RESET>
+
+<CYAN>@@ -19,7 +19,7 @@<RESET> <RESET><MAGENTA>elm6 {<RESET>
+prop: first-value;<RESET>
+prop: value;<RESET>
+prop: value;<RESET>
+<RED>prop<RESET><GREEN>NEW-PROP<RESET>: <RED>value<RESET><GREEN>NEW-VALUE<RESET>;
+prop: last-value;<RESET>
+}<RESET>
+
+<CYAN>@@ -27,6 +27,6 @@<RESET> <RESET><MAGENTA>.class, elm:hover, elm:first-child, elm:lang(en), #id, elm#id, .num123{<RESET>
+prop: first-value;<RESET>
+prop: value;<RESET>
+prop: value;<RESET>
+<RED>prop<RESET><GREEN>NUM-PROP<RESET>: <RED>value<RESET><GREEN>999<RESET>;
+prop: last-value;<RESET>
+}<RESET>
diff --git a/t/t4034/css/post b/t/t4034/css/post
new file mode 100644
index 0000000..7e64463
--- /dev/null
+++ b/t/t4034/css/post
@@ -0,0 +1,32 @@
+elm1, elm2 {
+prop: first-value;
+prop: value;
+prop: value;
+prop: NEW-VALUE;
+prop: last-value;
+}
+
+elm3, elm4 {
+prop: first-value;
+prop: value;
+prop: value;
+NEW-PROP: value;
+prop: last-value;
+}
+
+elm5,
+elm6 {
+prop: first-value;
+prop: value;
+prop: value;
+NEW-PROP: NEW-VALUE;
+prop: last-value;
+}
+
+.class, elm:hover, elm:first-child, elm:lang(en), #id, elm#id, .num123{
+prop: first-value;
+prop: value;
+prop: value;
+NUM-PROP: 999;
+prop: last-value;
+}
diff --git a/t/t4034/css/pre b/t/t4034/css/pre
new file mode 100644
index 0000000..c53f20b
--- /dev/null
+++ b/t/t4034/css/pre
@@ -0,0 +1,32 @@
+elm1, elm2 {
+prop: first-value;
+prop: value;
+prop: value;
+prop: value;
+prop: last-value;
+}
+
+elm3, elm4 {
+prop: first-value;
+prop: value;
+prop: value;
+prop: value;
+prop: last-value;
+}
+
+elm5,
+elm6 {
+prop: first-value;
+prop: value;
+prop: value;
+prop: value;
+prop: last-value;
+}
+
+.class, elm:hover, elm:first-child, elm:lang(en), #id, elm#id, .num123{
+prop: first-value;
+prop: value;
+prop: value;
+prop: value;
+prop: last-value;
+}
diff --git a/userdiff.c b/userdiff.c
index 2ccbee5..8374a2a 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -37,6 +37,9 @@ IPATTERN("fortran",
 	 "|//|\\*\\*|::|[/<>=]="),
 PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
 	 "[^<>= \t]+"),
+PATTERNS("css",
+	 "^.*[{].*$",
+	 "[-_\\.,#a-zA-Z0-9]+"),
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
 	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
-- 
2.3.1
