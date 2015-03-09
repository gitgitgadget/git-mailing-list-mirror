From: Adrien Schildknecht <adrien+dev@schischi.me>
Subject: [PATCH] userdiff: funcname and word patterns for sh
Date: Mon,  9 Mar 2015 17:36:39 +0100
Message-ID: <1425918999-11992-2-git-send-email-adrien+dev@schischi.me>
References: <1425918999-11992-1-git-send-email-adrien+dev@schischi.me>
Cc: Adrien Schildknecht <adrien+dev@schischi.me>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 17:37:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV0gT-0006LP-AM
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 17:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbbCIQhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 12:37:31 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:40104 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932345AbbCIQh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 12:37:27 -0400
Received: by wivr20 with SMTP id r20so22556688wiv.5
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 09:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mep94dp8PilacJ8RWZBo238n72GdsN1XLErHmveq7zc=;
        b=YGn3l18uLP3Mmt+azR2oqkALBQ6ORpmg48xSvSHLtnYtcLGnVSED443yK8kKvqjVGZ
         YfNX5Sy+d6viPiX5pJY4HtFplqektor/GhiNtWQXAp3kkMqD+hrToPvitf6hIhlMCC+V
         woPKyCjEZvWuU9qP2Xj7iIBHhHqZ7A9Y8VlQ9C4bP1OkZ2/oAWT21JYBCtzRBwQeJfS2
         0NpKKCpQgPxxugKnqq3WFFr0rBgf+fgXyyN4SWbS9Y0Zp8Z+sJkhpTP0vfrHDS99CANi
         XbfB6Mi2S7oQjW+md591GkAxJim507rfKRboTb68zu/n4CqnoOqiQcsflzuXVQ9T0aID
         dl9Q==
X-Gm-Message-State: ALoCoQmUZp+r11uG81vZ4Opca0Jf6heOy3FB2arB4pOxxZcsFfSG4Le2D4l9qQL1aNDvp0GadHho
X-Received: by 10.180.108.203 with SMTP id hm11mr28038200wib.49.1425919045873;
        Mon, 09 Mar 2015 09:37:25 -0700 (PDT)
Received: from archischi.lse.epita.fr (lse.epita.fr. [163.5.55.17])
        by mx.google.com with ESMTPSA id cn10sm16218646wib.15.2015.03.09.09.37.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Mar 2015 09:37:25 -0700 (PDT)
X-Mailer: git-send-email 2.3.2
In-Reply-To: <1425918999-11992-1-git-send-email-adrien+dev@schischi.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265177>

Add regexp based on the "Shell Command Language" specifications.
Because of the lax syntax of sh, some corner cases may not be
handled properly.

Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>
---
 Documentation/gitattributes.txt |  2 ++
 t/t4018-diff-funcname.sh        |  1 +
 t/t4018/sh-function             |  4 ++++
 t/t4018/sh-function-comment     |  6 ++++++
 t/t4018/sh-function-nested      |  7 +++++++
 t/t4018/sh-function-prefix      |  4 ++++
 t/t4018/sh-function-string      |  4 ++++
 t/t4034-diff-words.sh           |  1 +
 t/t4034/sh/expect               | 46 +++++++++++++++++++++++++++++++++++++++++
 t/t4034/sh/post                 | 36 ++++++++++++++++++++++++++++++++
 t/t4034/sh/pre                  | 36 ++++++++++++++++++++++++++++++++
 userdiff.c                      |  7 +++++++
 12 files changed, 154 insertions(+)
 create mode 100644 t/t4018/sh-function
 create mode 100644 t/t4018/sh-function-comment
 create mode 100644 t/t4018/sh-function-nested
 create mode 100644 t/t4018/sh-function-prefix
 create mode 100644 t/t4018/sh-function-string
 create mode 100644 t/t4034/sh/expect
 create mode 100644 t/t4034/sh/post
 create mode 100644 t/t4034/sh/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c892ffa..fb13761 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -545,6 +545,8 @@ patterns are available:
 
 - `ruby` suitable for source code in the Ruby language.
 
+- `sh` suitable for source code in the Shell language.
+
 - `tex` suitable for source code for LaTeX documents.
 
 
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 1dbaa38..960b6e4 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -40,6 +40,7 @@ diffpatterns="
 	php
 	python
 	ruby
+	sh
 	tex
 	custom1
 	custom2
diff --git a/t/t4018/sh-function b/t/t4018/sh-function
new file mode 100644
index 0000000..1d5096a
--- /dev/null
+++ b/t/t4018/sh-function
@@ -0,0 +1,4 @@
+RIGHT_foo()
+{
+	ChangeMe;
+}
diff --git a/t/t4018/sh-function-comment b/t/t4018/sh-function-comment
new file mode 100644
index 0000000..f340ee7
--- /dev/null
+++ b/t/t4018/sh-function-comment
@@ -0,0 +1,6 @@
+  RIGHT_foo() # echo 'foo'
+#bar()
+{
+	#bar()
+	ChangeMe;
+}
diff --git a/t/t4018/sh-function-nested b/t/t4018/sh-function-nested
new file mode 100644
index 0000000..d3263f3
--- /dev/null
+++ b/t/t4018/sh-function-nested
@@ -0,0 +1,7 @@
+foo (     )
+{
+	RIGHT_bar()
+	{
+		echo ChangeMe
+	}
+}
diff --git a/t/t4018/sh-function-prefix b/t/t4018/sh-function-prefix
new file mode 100644
index 0000000..e96eb7a
--- /dev/null
+++ b/t/t4018/sh-function-prefix
@@ -0,0 +1,4 @@
+function RIGHT_foo()
+{
+	ChangeMe;
+}
diff --git a/t/t4018/sh-function-string b/t/t4018/sh-function-string
new file mode 100644
index 0000000..f60a899
--- /dev/null
+++ b/t/t4018/sh-function-string
@@ -0,0 +1,4 @@
+RIGHT_foo() {
+	echo "bar()"
+	ChangeMe;
+}
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index f2f55fc..24fd9aa 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -312,6 +312,7 @@ test_language_driver perl
 test_language_driver php
 test_language_driver python
 test_language_driver ruby
+test_language_driver sh
 test_language_driver tex
 
 test_expect_success 'word-diff with diff.sbe' '
diff --git a/t/t4034/sh/expect b/t/t4034/sh/expect
new file mode 100644
index 0000000..1c6de2d
--- /dev/null
+++ b/t/t4034/sh/expect
@@ -0,0 +1,46 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 20229c3..ab791db 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,36 +1,36 @@<RESET>
+foo() {ls&echo}<RESET>
+$((<RED>a<RESET><GREEN>x<RESET>++))
+$((<RED>a<RESET><GREEN>x<RESET>--))
+$((--<RED>a<RESET><GREEN>x<RESET>))
+$((++<RED>a<RESET><GREEN>x<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>*<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>&<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>**<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>/<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>%<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>+<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>-<RED>b<RESET><GREEN>y<RESET>))
+[ <RED>a<RESET><GREEN>x<RESET><=<RED>b<RESET><GREEN>y<RESET> ]
+[ <RED>a<RESET><GREEN>x<RESET>>=<RED>b<RESET><GREEN>y<RESET> ]
+[ <RED>a<RESET><GREEN>x<RESET>==<RED>b<RESET><GREEN>y<RESET> ]
+[ <RED>a<RESET><GREEN>x<RESET>!=<RED>b<RESET><GREEN>y<RESET> ]
+<RED>a<RESET><GREEN>x<RESET><<<RED>b a<RESET><GREEN>y x<RESET>>><RED>b a<RESET><GREEN>y x<RESET><<-<RED>b a<RESET><GREEN>y x<RESET><<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>|<RED>b a<RESET><GREEN>y x<RESET><&<RED>b a<RESET><GREEN>y x<RESET>>&<RED>b a<RESET><GREEN>y x<RESET><><RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>&&<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>|<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>||<RED>b<RESET>
+<RED>a<RESET><GREEN>y<RESET>
+<GREEN>x<RESET>=<RED>b<RESET><GREEN>y<RESET>
+$((<RED>a<RESET><GREEN>x<RESET>+=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>-=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>*=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>/=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>%=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET><<=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>>>=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>&=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>^=<RED>b<RESET><GREEN>y<RESET>))
+$((<RED>a<RESET><GREEN>x<RESET>|=<RED>b<RESET><GREEN>y<RESET>))
+*)<RED>a<RESET><GREEN>b<RESET>;;ls
+FOO=42&<RED>foo<RESET><GREEN>fro<RESET>
+BAR=$(0)<RESET>
+[[ $<RED>a<RESET><GREEN>x<RESET> -eq $<RED>b<RESET><GREEN>y<RESET> ]]
diff --git a/t/t4034/sh/post b/t/t4034/sh/post
new file mode 100644
index 0000000..ab791db
--- /dev/null
+++ b/t/t4034/sh/post
@@ -0,0 +1,36 @@
+foo() {ls&echo}
+$((x++))
+$((x--))
+$((--x))
+$((++x))
+$((x*y))
+$((x&y))
+$((x**y))
+$((x/y))
+$((x%y))
+$((x+y))
+$((x-y))
+[ x<=y ]
+[ x>=y ]
+[ x==y ]
+[ x!=y ]
+x<<y x>>y x<<-y x<y x>y x>|y x<&y x>&y x<>y
+x&y
+x&&y
+x|y
+x||y
+x=y
+$((x+=y))
+$((x-=y))
+$((x*=y))
+$((x/=y))
+$((x%=y))
+$((x<<=y))
+$((x>>=y))
+$((x&=y))
+$((x^=y))
+$((x|=y))
+*)b;;ls
+FOO=42&fro
+BAR=$(0)
+[[ $x -eq $y ]]
diff --git a/t/t4034/sh/pre b/t/t4034/sh/pre
new file mode 100644
index 0000000..20229c3
--- /dev/null
+++ b/t/t4034/sh/pre
@@ -0,0 +1,36 @@
+foo() {ls&echo}
+$((a++))
+$((a--))
+$((--a))
+$((++a))
+$((a*b))
+$((a&b))
+$((a**b))
+$((a/b))
+$((a%b))
+$((a+b))
+$((a-b))
+[ a<=b ]
+[ a>=b ]
+[ a==b ]
+[ a!=b ]
+a<<b a>>b a<<-b a<b a>b a>|b a<&b a>&b a<>b
+a&b
+a&&b
+a|b
+a||b
+a=b
+$((a+=b))
+$((a-=b))
+$((a*=b))
+$((a/=b))
+$((a%=b))
+$((a<<=b))
+$((a>>=b))
+$((a&=b))
+$((a^=b))
+$((a|=b))
+*)a;;ls
+FOO=42&foo
+BAR=$(0)
+[[ $a -eq $b ]]
diff --git a/userdiff.c b/userdiff.c
index 2ccbee5..40b3dc0 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -146,6 +146,13 @@ PATTERNS("csharp",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
+PATTERNS("sh",
+	"^([ \t]*(function[ \t]*)?[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\).*)$",
+	/* -- */
+	 "[a-zA-Z0-9_]+"
+	 "|[-+0-9]+"
+	 "|[-+*/<>%&^|=!]=|>>=?|<<=?|\\+\\+|--|\\*\\*|&&|\\|\\||\\[\\[|\\]\\]"
+	 "|>\\||[<>]+&|<>|<<-|;;"),
 { "default", NULL, -1, { NULL, 0 } },
 };
 #undef PATTERNS
-- 
Adrien Schildknecht
http://schischi.me
