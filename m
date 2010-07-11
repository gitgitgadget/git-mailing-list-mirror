From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v3 12/13] add two test cases
Date: Sun, 11 Jul 2010 14:19:00 +0800
Message-ID: <1278829141-11900-12-git-send-email-struggleyb.nku@gmail.com>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 08:22:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXpvR-0002Bb-Ew
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 08:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988Ab0GKGVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 02:21:50 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50220 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab0GKGVs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 02:21:48 -0400
Received: by pvc7 with SMTP id 7so1396182pvc.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 23:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/vnSwnz8Q00Tw15DvFkUCFIE88xAHj/OkFHJMXgeqrs=;
        b=rhKWVe9+QFV4KY2d1yNyTgiQOPE0l1fYBQWTC36O/p6bskNXv+KlOexpZd5R/PR8Ry
         Cu1l1LRD9OOfm6d1ICaXH17cLKmcouI9yQQdpftRTxDv5ISPv90arljEdVdz/67mmnqT
         /45FglOpemW5z/f1M6V9Tznp8Z1FFD6H99XOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=K9mUfdAJDD8Oa6YvZ3RU5DTN5t4RTEff9Gw3atFiPogkw9ujTQsfaX3ZyNigNqxTzL
         m7zzr00+A3nSudfklGpp1BGHTze2+5lLbQcDqugISM28QvsN8VWda2OvvdwXKzZPsqP9
         BS3hCu30Ry2Ukgj56pOkIqE/GP1WrC+yvHgyQ=
Received: by 10.142.158.13 with SMTP id g13mr13580055wfe.235.1278829307919;
        Sat, 10 Jul 2010 23:21:47 -0700 (PDT)
Received: from localhost.localdomain ([222.35.175.242])
        by mx.google.com with ESMTPS id c15sm2927911rvi.11.2010.07.10.23.21.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 23:21:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2.18.g2bc49
In-Reply-To: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150756>

t4301: for simple linear history only
t4302: for history contains merge

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 t/t4301-log-line-single-history.sh |  342 ++++++++++++++++++++++++++++++++++++
 t/t4302-log-line-merge-history.sh  |  114 ++++++++++++
 2 files changed, 456 insertions(+), 0 deletions(-)
 create mode 100755 t/t4301-log-line-single-history.sh
 create mode 100755 t/t4302-log-line-merge-history.sh

diff --git a/t/t4301-log-line-single-history.sh b/t/t4301-log-line-single-history.sh
new file mode 100755
index 0000000..9981496
--- /dev/null
+++ b/t/t4301-log-line-single-history.sh
@@ -0,0 +1,342 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Bo Yang
+#
+
+test_description='Test git log -L with single line of history
+
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+echo >path0 'void func(){
+	int a = 0;
+	int b = 1;
+	int c;
+	c = a + b;
+}
+'
+
+echo >path1 'void output(){
+	printf("hello world");
+}
+'
+
+test_expect_success \
+    'add path0/path1 and commit.' \
+    'git add path0 path1 &&
+     git commit -m "Base commit"'
+
+echo >path0 'void func(){
+	int a = 10;
+	int b = 11;
+	int c;
+	c = a + b;
+}
+'
+
+echo >path1 'void output(){
+	const char *str = "hello world!";
+	printf("%s", str);
+}
+'
+
+test_expect_success \
+    'Change the 2,3 lines of path0 and path1.' \
+    'git add path0 path1 &&
+     git commit -m "Change 2,3 lines of path0 and path1"'
+
+echo >path0 'void func(){
+	int a = 10;
+	int b = 11;
+	int c;
+	c = 10 * (a + b);
+}
+'
+
+test_expect_success \
+	'Change the 5th line of path0.' \
+	'git add path0 &&
+	 git commit -m "Change the 5th line of path0"'
+
+echo >path0 'void func(){
+	int a = 10;
+	int b = 11;
+	printf("%d", a - b);
+}
+'
+
+test_expect_success \
+	'Final change of path0.' \
+	'git add path0 &&
+	 git commit -m "Final change of path0"'
+
+test_expect_success \
+    'Show the line level log of path0' \
+    'git log --pretty=format:%s%n%b -L /func/,/^}/ path0 > current-path0'
+
+test_expect_success \
+    'Show the line level log of path1' \
+    'git log --pretty=format:%s%n%b -L /output/,/^}/ path1 > current-path1'
+
+test_expect_success \
+	'Show the line level log of two files' \
+    'git log --pretty=format:%s%n%b -L /func/,/^}/ path0 -L /output/,/^}/ path1 > current-pathall'
+
+test_expect_success \
+	'Test the line number argument' \
+	'git log --pretty=format:%s%n%b -L 1,2 path0 > current-linenum'
+
+test_expect_success \
+	'Test the --always-print option' \
+	'git log --pretty=format:%s%n%b --always-print -L 1,2 path0 > current-always'
+
+cat >expected-path0 <<\EOF
+Final change of path0
+
+diff --git a/path0 b/path0
+index 44db133..1518c15 100644
+--- a/path0
++++ b/path0
+@@ -1,6 +1,5 @@
+ void func(){
+ 	int a = 10;
+ 	int b = 11;
+-	int c;
+-	c = 10 * (a + b);
++	printf("%d", a - b);
+ }
+
+Change the 5th line of path0
+
+diff --git a/path0 b/path0
+index 9ef1692..44db133 100644
+--- a/path0
++++ b/path0
+@@ -1,6 +1,6 @@
+ void func(){
+ 	int a = 10;
+ 	int b = 11;
+ 	int c;
+-	c = a + b;
++	c = 10 * (a + b);
+ }
+
+Change 2,3 lines of path0 and path1
+
+diff --git a/path0 b/path0
+index aabffdf..9ef1692 100644
+--- a/path0
++++ b/path0
+@@ -1,6 +1,6 @@
+ void func(){
+-	int a = 0;
+-	int b = 1;
++	int a = 10;
++	int b = 11;
+ 	int c;
+ 	c = a + b;
+ }
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..aabffdf
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,6 @@
++void func(){
++	int a = 0;
++	int b = 1;
++	int c;
++	c = a + b;
++}
+EOF
+
+cat >expected-path1 <<\EOF
+Change 2,3 lines of path0 and path1
+
+diff --git a/path1 b/path1
+index 997d841..1d711b5 100644
+--- a/path1
++++ b/path1
+@@ -1,3 +1,4 @@
+ void output(){
+-	printf("hello world");
++	const char *str = "hello world!";
++	printf("%s", str);
+ }
+
+Base commit
+
+diff --git a/path1 b/path1
+new file mode 100644
+index 0000000..997d841
+--- /dev/null
++++ b/path1
+@@ -0,0 +1,3 @@
++void output(){
++	printf("hello world");
++}
+EOF
+
+cat >expected-pathall <<\EOF
+Final change of path0
+
+diff --git a/path0 b/path0
+index 44db133..1518c15 100644
+--- a/path0
++++ b/path0
+@@ -1,6 +1,5 @@
+ void func(){
+ 	int a = 10;
+ 	int b = 11;
+-	int c;
+-	c = 10 * (a + b);
++	printf("%d", a - b);
+ }
+
+Change the 5th line of path0
+
+diff --git a/path0 b/path0
+index 9ef1692..44db133 100644
+--- a/path0
++++ b/path0
+@@ -1,6 +1,6 @@
+ void func(){
+ 	int a = 10;
+ 	int b = 11;
+ 	int c;
+-	c = a + b;
++	c = 10 * (a + b);
+ }
+
+Change 2,3 lines of path0 and path1
+
+diff --git a/path0 b/path0
+index aabffdf..9ef1692 100644
+--- a/path0
++++ b/path0
+@@ -1,6 +1,6 @@
+ void func(){
+-	int a = 0;
+-	int b = 1;
++	int a = 10;
++	int b = 11;
+ 	int c;
+ 	c = a + b;
+ }
+diff --git a/path1 b/path1
+index 997d841..1d711b5 100644
+--- a/path1
++++ b/path1
+@@ -1,3 +1,4 @@
+ void output(){
+-	printf("hello world");
++	const char *str = "hello world!";
++	printf("%s", str);
+ }
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..aabffdf
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,6 @@
++void func(){
++	int a = 0;
++	int b = 1;
++	int c;
++	c = a + b;
++}
+diff --git a/path1 b/path1
+new file mode 100644
+index 0000000..997d841
+--- /dev/null
++++ b/path1
+@@ -0,0 +1,3 @@
++void output(){
++	printf("hello world");
++}
+EOF
+
+cat >expected-linenum <<\EOF
+Change 2,3 lines of path0 and path1
+
+diff --git a/path0 b/path0
+index aabffdf..9ef1692 100644
+--- a/path0
++++ b/path0
+@@ -1,2 +1,2 @@
+ void func(){
+-	int a = 0;
++	int a = 10;
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..aabffdf
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,2 @@
++void func(){
++	int a = 0;
+EOF
+
+cat >expected-always <<\EOF
+Final change of path0
+
+diff --git a/path0 b/path0
+index 44db133..1518c15 100644
+--- a/path0
++++ b/path0
+@@ -1,2 +1,2 @@
+ void func(){
+ 	int a = 10;
+
+Change the 5th line of path0
+
+diff --git a/path0 b/path0
+index 9ef1692..44db133 100644
+--- a/path0
++++ b/path0
+@@ -1,2 +1,2 @@
+ void func(){
+ 	int a = 10;
+
+Change 2,3 lines of path0 and path1
+
+diff --git a/path0 b/path0
+index aabffdf..9ef1692 100644
+--- a/path0
++++ b/path0
+@@ -1,2 +1,2 @@
+ void func(){
+-	int a = 0;
++	int a = 10;
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..aabffdf
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,2 @@
++void func(){
++	int a = 0;
+EOF
+
+test_expect_success \
+    'validate the output.' \
+    'test_cmp current-path0 expected-path0 &&
+	 test_cmp current-path1 expected-path1 &&
+	 test_cmp current-pathall expected-pathall &&
+	 test_cmp current-linenum expected-linenum &&
+	 test_cmp current-always expected-always'
+
+test_done
diff --git a/t/t4302-log-line-merge-history.sh b/t/t4302-log-line-merge-history.sh
new file mode 100755
index 0000000..02e7439
--- /dev/null
+++ b/t/t4302-log-line-merge-history.sh
@@ -0,0 +1,114 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Bo Yang
+#
+
+test_description='Test git log -L with merge commit
+
+'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+echo >path0 'void func(){
+	printf("hello");
+}
+'
+
+test_expect_success \
+    'Add path0 and commit.' \
+    'git add path0 &&
+     git commit -m "Base commit"'
+
+echo >path0 'void func(){
+	printf("hello earth");
+}
+'
+
+test_expect_success \
+    'Change path0 in master.' \
+    'git add path0 &&
+     git commit -m "Change path0 in master"'
+
+test_expect_success \
+	'Make a new branch from the base commit' \
+	'git checkout -b feature master^'
+
+echo >path0 'void func(){
+	print("hello moon");
+}
+'
+
+test_expect_success \
+    'Change path0 in feature.' \
+    'git add path0 &&
+     git commit -m "Change path0 in feature"'
+
+test_expect_success \
+	'Merge the master to feature' \
+	'! git merge master'
+
+echo >path0 'void func(){
+	printf("hello earth and moon");
+}
+'
+
+test_expect_success \
+	'Resolve the conflict' \
+	'git add path0 &&
+	 git commit -m "Merge two branches"'
+
+test_expect_success \
+    'Show the line level log of path0' \
+    'git log --pretty=format:%s%n%b -L /func/,/^}/ path0 > current'
+
+cat >expected <<\EOF
+Merge two branches
+
+nontrivial merge found
+path0
+
+@@ 2,1 @@
+ 	printf("hello earth and moon");
+
+
+Change path0 in master
+
+diff --git a/path0 b/path0
+index f628dea..bef7fa3 100644
+--- a/path0
++++ b/path0
+@@ -1,3 +1,3 @@
+ void func(){
+-	printf("hello");
++	printf("hello earth");
+ }
+
+Change path0 in feature
+
+diff --git a/path0 b/path0
+index f628dea..a940ef6 100644
+--- a/path0
++++ b/path0
+@@ -1,3 +1,3 @@
+ void func(){
+-	printf("hello");
++	print("hello moon");
+ }
+
+Base commit
+
+diff --git a/path0 b/path0
+new file mode 100644
+index 0000000..f628dea
+--- /dev/null
++++ b/path0
+@@ -0,0 +1,3 @@
++void func(){
++	printf("hello");
++}
+EOF
+test_expect_success \
+    'validate the output.' \
+    'test_cmp current expected'
+
+test_done
-- 
1.7.0.2.273.gc2413.dirty
