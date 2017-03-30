Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB91120966
	for <e@80x24.org>; Thu, 30 Mar 2017 18:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934082AbdC3SIo (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 14:08:44 -0400
Received: from mx1.riseup.net ([198.252.153.129]:45866 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933891AbdC3SIn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 14:08:43 -0400
Received: from cotinga.riseup.net (unknown [10.0.1.164])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id DC2C71A204E
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 18:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1490897322; bh=M6ZumWTvKzUHbqV+YeV8veNkITHX3zQTqvmXaIT8WR4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Gbt1h+1IunT3NGjDQK2XnpniAXmsKAnu3tEOYt0+f5kd+14WAwVkKLcpK7N/92GXc
         Zpddh3+xrp8EKDqHeA6IS4NdC4RwETrZzUIBeMsQQV8XG4wxJ5gfzA5ouLcI80ZaC/
         Af0X3O/RqMErYAFj0+9ZtBujbsxFHamdOPiSVWZo=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: pickfire)
        with ESMTPSA id DB2EB400E1
From:   Ivan Tham <pickfire@riseup.net>
To:     git@vger.kernel.org
Subject: [PATCH v2] userdiff: add build-in pattern for shell
Date:   Fri, 31 Mar 2017 02:08:29 +0800
Message-Id: <20170330180829.27879-1-pickfire@riseup.net>
In-Reply-To: <20170329165331.17742-1-pickfire@riseup.net>
References: <20170329165331.17742-1-pickfire@riseup.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shell are widely used but comes with lots of different patterns. The
build-in pattern aim for POSIX-like shells with some additions:

- Notably ${g//re/s} and ${g#cut}
- Bashisms such as "function"

Signed-off-by: Ivan Tham <pickfire@riseup.net>
---
 Documentation/gitattributes.txt |  2 ++
 t/t4034-diff-words.sh           |  1 +
 t/t4034/sh/expect               | 14 ++++++++++++++
 t/t4034/sh/post                 |  7 +++++++
 t/t4034/sh/pre                  |  7 +++++++
 userdiff.c                      |  5 +++++
 6 files changed, 36 insertions(+)
 create mode 100644 t/t4034/sh/expect
 create mode 100644 t/t4034/sh/post
 create mode 100644 t/t4034/sh/pre

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index a53d093ca..f8440119d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -706,6 +706,8 @@ patterns are available:
 
 - `ruby` suitable for source code in the Ruby language.
 
+- `sh` suitable for source code in POSIX-like shells.
+
 - `tex` suitable for source code for LaTeX documents.
 
 
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 912df9122..2eb662f89 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -313,6 +313,7 @@ test_language_driver perl
 test_language_driver php
 test_language_driver python
 test_language_driver ruby
+test_language_driver sh
 test_language_driver tex
 
 test_expect_success 'word-diff with diff.sbe' '
diff --git a/t/t4034/sh/expect b/t/t4034/sh/expect
new file mode 100644
index 000000000..e7b0a9ae3
--- /dev/null
+++ b/t/t4034/sh/expect
@@ -0,0 +1,14 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 7bb0d15..df3845b 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,7 +1,7 @@<RESET>
+echo <GREEN>"<RESET>Hello world<RED>!<RESET>
+<RED>bomb<RESET><GREEN>?"<RESET>
+<GREEN>fork<RESET>(){ <RED>bomb<RESET><GREEN>fork<RESET>|<RED>bomb<RESET><GREEN>fork<RESET>& }
+<RED>; bomb<RESET>
+<RED>a<RESET><GREEN>x<RESET>=<RED>1 a<RESET><GREEN>2 x<RESET>=$((<RED>a<RESET><GREEN>x<RESET>+<RED>1<RESET><GREEN>2<RESET>)) <RED>a<RESET><GREEN>x<RESET>=$((<RED>a-1<RESET><GREEN>x-2<RESET>)) <RED>a<RESET><GREEN>x<RESET>=$((<RED>a<RESET><GREEN>x<RESET>*<RED>1<RESET><GREEN>2<RESET>)) <RED>a<RESET><GREEN>x<RESET>=$((<RED>a<RESET><GREEN>x<RESET>/<RED>1<RESET><GREEN>2<RESET>))
+<RED>a<RESET><GREEN>x<RESET>=$(<RED>a<RESET><GREEN>x<RESET>) <RED>a<RESET><GREEN>x<RESET>=`<RED>a<RESET><GREEN>x<RESET>` <RED>a<RESET><GREEN>x<RESET>=${<RED>a<RESET><GREEN>x<RESET>#<RED>a<RESET><GREEN>x<RESET>*} <RED>a<RESET><GREEN>x<RESET>=${<RED>a<RESET><GREEN>x<RESET>%<RED>a<RESET><GREEN>x<RESET>*} <RED>a<RESET><GREEN>x<RESET>=${<RED>a<RESET><GREEN>x<RESET>//<RED>a<RESET><GREEN>x<RESET>/<RED>a<RESET><GREEN>x<RESET>}
+command <RED>-h -v<RESET><GREEN>--help=all -q<RESET> | xargs -- echo <GREEN>2<RESET>><RED>&1 &<RESET><GREEN>/dev/null<RESET>
+[ <RED>$a -eq $b<RESET><GREEN>$x -ne $y<RESET> ]&&echo <RED>aa<RESET><GREEN>xx<RESET>||echo <RED>bb<RESET><GREEN>yy<RESET>
+[ "<RED>$a<RESET><GREEN>$x<RESET>"!=<RED>1<RESET><GREEN>2<RESET> ] && echo <RED>a<RESET><GREEN>x<RESET> || echo <RED>b<RESET><GREEN>y<RESET>
diff --git a/t/t4034/sh/post b/t/t4034/sh/post
new file mode 100644
index 000000000..df3845b4f
--- /dev/null
+++ b/t/t4034/sh/post
@@ -0,0 +1,7 @@
+echo "Hello world?"
+fork(){ fork|fork& }
+x=2 x=$((x+2)) x=$((x-2)) x=$((x*2)) x=$((x/2))
+x=$(x) x=`x` x=${x#x*} x=${x%x*} x=${x//x/x}
+command --help=all -q | xargs -- echo 2>/dev/null
+[ $x -ne $y ]&&echo xx||echo yy
+[ "$x"!=2 ] && echo x || echo y
diff --git a/t/t4034/sh/pre b/t/t4034/sh/pre
new file mode 100644
index 000000000..7bb0d1562
--- /dev/null
+++ b/t/t4034/sh/pre
@@ -0,0 +1,7 @@
+echo Hello world!
+bomb(){ bomb|bomb& }; bomb
+a=1 a=$((a+1)) a=$((a-1)) a=$((a*1)) a=$((a/1))
+a=$(a) a=`a` a=${a#a*} a=${a%a*} a=${a//a/a}
+command -h -v | xargs -- echo >&1 &
+[ $a -eq $b ]&&echo aa||echo bb
+[ "$a"!=1 ] && echo a || echo b
diff --git a/userdiff.c b/userdiff.c
index 8b732e40b..72ffd85f1 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -148,6 +148,11 @@ PATTERNS("csharp",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
+PATTERNS("sh",
+	 "^[ \t]*(function )?[A-Za-z_][A-Za-z_0-9]*[ \t]*\\(\\)[\t]*\\{?$",
+	 /* -- */
+	 "(\\$|--?)?([a-zA-Z_][a-zA-Z0-9._]*|[0-9]+|#|\\?)|--" /* command/param */
+	 "|\\$[({]|[)}]|[-+*/=!]=?|[\\]&%#/|]{1,2}|[<>]{1,3}|[ \t]#.*"),
 IPATTERN("css",
 	 "![:;][[:space:]]*$\n"
 	 "^[_a-z0-9].*$",
-- 
2.12.2.609.gf7d0c115f

