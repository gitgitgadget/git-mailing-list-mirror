From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v12 15/15] test: add t7301 for git-clean--interactive
Date: Sat, 18 May 2013 11:19:07 +0800
Message-ID: <99e259f34c9dba5ab8447a5b7c0992d37f01016a.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368846844.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 18 05:21:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdXhl-0005De-9K
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 05:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759366Ab3ERDUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 23:20:15 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:57477 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757482Ab3ERDUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 23:20:09 -0400
Received: by mail-pd0-f174.google.com with SMTP id u10so3879322pdi.33
        for <git@vger.kernel.org>; Fri, 17 May 2013 20:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=h5pF/3+lqxUvZEote2fdDYWNNYSjsqrvwLST3Hn7PWM=;
        b=d6Q+LpoE8ZyooNQ/24EV/mKF98yeNgCdR8v1mDRo8xSliwrkSWVJQQR9lkFdD9uAjo
         cMkmVGBeFuR7NvgIEqCy/tHrcj8TFzF34Wkf/BdPv2178xBF4kZwDbnFUAJkzGZr/6DG
         bQ71RVoxyq+hgu9hjEFdayzNwNyGHGdcjVWvP1NUClPJSEcT42VAY42uluBbMi+3OOWG
         X+veqpB/Otcz6EIb0VaDBftLniQzY47GuzrsyljFgds55xrGNxUbE5JlZm/igDl+f3Dz
         qqMwReCwN1E0VojacO11peCEcihJbxgtcj/05em74QWsJU7lsaPR57kp9em/ifjrbXW7
         fzTQ==
X-Received: by 10.68.163.4 with SMTP id ye4mr1593171pbb.207.1368847209397;
        Fri, 17 May 2013 20:20:09 -0700 (PDT)
Received: from localhost.localdomain ([114.248.155.144])
        by mx.google.com with ESMTPSA id fn2sm13676683pbc.15.2013.05.17.20.20.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 20:20:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.26.g7472058
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368846844.git.worldhello.net@gmail.com>
References: <cover.1368782129.git.worldhello.net@gmail.com> <cover.1368846844.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224770>

Add test cases for git-clean--interactive.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 t/t7301-clean-interactive.sh | 439 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 439 insertions(+)
 create mode 100755 t/t7301-clean-interactive.sh

diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
new file mode 100755
index 00000..4e605
--- /dev/null
+++ b/t/t7301-clean-interactive.sh
@@ -0,0 +1,439 @@
+#!/bin/sh
+
+test_description='git clean -i basic tests'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	mkdir -p src &&
+	touch src/part1.c Makefile &&
+	echo build >.gitignore &&
+	echo \*.o >>.gitignore &&
+	git add . &&
+	git commit -m setup &&
+	touch src/part2.c README &&
+	git add .
+
+'
+
+test_expect_success 'git clean -i (clean)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	echo c | git clean -i &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test ! -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -i (quit)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	echo q | git clean -i &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -i (Ctrl+D)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	echo "\04" | git clean -i &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (filter all)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(echo f; echo "*"; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (filter patterns)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(echo f; echo "part3.* *.out"; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test ! -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test ! -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (filter patterns 2)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(echo f; echo "* !*.out"; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (select - all)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo "*"; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test ! -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test ! -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (select - none)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (select - number)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo 3; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (select - number 2)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo 2 3; echo 5; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test ! -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (select - number 3)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo 3,4 5; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (select - range)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo 1,3-4; echo 2; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test ! -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test ! -f docs/manual.txt &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (select - range 2)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo 4- 1; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test ! -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (inverse select)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(echo s; echo "*"; echo -5- 1 -2; echo; echo c) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (ask)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(echo a; echo Y; echo y; echo no; echo yes; echo bad; echo) | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test ! -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id (ask - Ctrl+D)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(echo a; echo Y; echo no; echo yes; echo "\04") | \
+	git clean -id &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id with prefix and path (filter)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(cd build/ && \
+	 (echo f; echo "docs"; echo "*.h"; echo ; echo c) | \
+	 git clean -id ..) &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id with prefix and path (select by name)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(cd build/ && \
+	 (echo s; echo "../docs/"; echo "../src/part3.c"; \
+	  echo "../src/part4.c";  echo; echo c) | \
+	 git clean -id ..) &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test -f a.out &&
+	test ! -f docs/manual.txt &&
+	test ! -f src/part3.c &&
+	test -f src/part3.h &&
+	test ! -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_expect_success 'git clean -id with prefix and path (ask)' '
+
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+	docs/manual.txt obj.o build/lib.so &&
+	(cd build/ && \
+	 (echo a; echo Y; echo y; echo no; echo yes; echo bad; echo) | \
+	 git clean -id ..) &&
+	test -f Makefile &&
+	test -f README &&
+	test -f src/part1.c &&
+	test -f src/part2.c &&
+	test ! -f a.out &&
+	test ! -f docs/manual.txt &&
+	test -f src/part3.c &&
+	test ! -f src/part3.h &&
+	test -f src/part4.c &&
+	test -f src/part4.h &&
+	test -f obj.o &&
+	test -f build/lib.so
+
+'
+
+test_done
-- 
1.8.3.rc2.26.g7472058
