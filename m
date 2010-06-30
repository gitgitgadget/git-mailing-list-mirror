From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v2 12/13] add two test cases
Date: Wed, 30 Jun 2010 23:25:25 +0800
Message-ID: <1277911526-12105-12-git-send-email-struggleyb.nku@gmail.com>
References: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 17:31:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTzGU-0002R0-Oz
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 17:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab0F3Pbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 11:31:48 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46743 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab0F3Pbr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 11:31:47 -0400
Received: by pwj8 with SMTP id 8so321340pwj.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 08:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XiS4lQHEgzJLmZDfXP66I4SRUakdOpwc4E9g/2mbLBA=;
        b=d36jk7q0lKzP/uXeYS+qA/MpOTuEbvIsNbS1pHKh4WjUHrZNSoqIiU2tg22huBBW4/
         13YxmZ96N5ym2Ml68uORtP/pPQ5yKJ59UUeVrtpXmSzOOVAZl4VhBVbuS3FEO69mU3zl
         f5FlYCTF2CojxLTuCAzWZ47vAuMiJ7XlBMn0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Hp6DIF3UmYnZ1mWfLuRvkwHjdXgk8ZuaMdj4fFaGl18mxkiRxIo5hoYZ5DKGIdFoIH
         MqZCoglkNLxbez4WOC73NRpRAB9h7UODIuvAxL54ZsCwFJ53jT6RAt8WR7+jXIjq/FDa
         K2TxxfxBBxzdaf7/JRZ0f/7POZt2ohsdVBefg=
Received: by 10.114.32.31 with SMTP id f31mr9989447waf.195.1277911906806;
        Wed, 30 Jun 2010 08:31:46 -0700 (PDT)
Received: from localhost.localdomain ([117.15.79.69])
        by mx.google.com with ESMTPS id d38sm75050850wam.20.2010.06.30.08.31.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 08:31:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.27.g1c5fd
In-Reply-To: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149975>

t4301: for simple linear history only
t4302: for history contains merge

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 t/t4301-log-line-single-history.sh |  342 ++++++++++++++++++++++++++++++++++++
 t/t4302-log-line-merge-history.sh  |  118 +++++++++++++
 2 files changed, 460 insertions(+), 0 deletions(-)
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
index 0000000..70ad0bf
--- /dev/null
+++ b/t/t4302-log-line-merge-history.sh
@@ -0,0 +1,118 @@
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
+    'git log --pretty=format:%s%n%b -L /func/,/^}/ path0 > current-path0'
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
