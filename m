Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AE6C35247
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE0A20838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="HCWNfVBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgBGAx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:57 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55564 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727154AbgBGAxi (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:38 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EF610607EF;
        Fri,  7 Feb 2020 00:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036816;
        bh=6j2ukRqB71DdmwW+Z+F/YzdXO2vTYz4setcQMIBxqyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=HCWNfVBkHbU81/jz8VboIYSeoI9KN5Z/IPrIifunDYEP0QkY2YnSOX5cCjDn1/4Ct
         zJY23J81HM54vF8ThekV7cjo5AkBUFTq0IWVIE12A8Y0QQjWoIZu4JbYGsFof3ulx5
         1rw2OSzeAz3Op8Ua0h0UC6cVClQm72hbwamQ0znBKZPF6ORyJ02zB/zLIb4mAWn/NW
         itgiaDe0LifeUpixF2k4S9hy81uuQlI3hVl6+mDwLvekZunzprdUL9jgkmsVRNGB+I
         uPZrxBzc8ozqzunm4WvelRoYwELZ9qIQuO9ONRjNKCe/QIcrIdvwQPwnGS7BvmSb/K
         MporrOIPDQzt4gzOa3JJpnDQL4zg4oQ0un/oXKI7H/YbKacWNk5nlJKEzxPyeMPfPb
         E2I1Kp+4Zgt6hPgUu0cAQKbYiZCo11CPmF5bc20G4p0jasufZ55+CJSJHb4rJdDzHY
         863aM9Vl9Ni6xqRj3bn7rLGqGLBhq0v+G/98/IixT+7zD027UGF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/21] t4211: add test cases for SHA-256
Date:   Fri,  7 Feb 2020 00:52:42 +0000
Message-Id: <20200207005254.1495851-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are already files containing example output for SHA-1.  Add test
files providing example output for SHA-256 as well and adjust the test
to look up the appropriate ones based on the algorithm in use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4211-line-log.sh                           |   3 +-
 t/t4211/sha256/expect.beginning-of-file       |  43 ++++
 t/t4211/sha256/expect.end-of-file             |  62 ++++++
 t/t4211/sha256/expect.move-support-f          |  80 ++++++++
 t/t4211/sha256/expect.multiple                | 104 ++++++++++
 t/t4211/sha256/expect.multiple-overlapping    | 187 ++++++++++++++++++
 t/t4211/sha256/expect.multiple-superset       | 187 ++++++++++++++++++
 .../sha256/expect.parallel-change-f-to-main   | 160 +++++++++++++++
 t/t4211/sha256/expect.simple-f                |  59 ++++++
 t/t4211/sha256/expect.simple-f-to-main        | 100 ++++++++++
 t/t4211/sha256/expect.simple-main             |  68 +++++++
 t/t4211/sha256/expect.simple-main-to-end      |  70 +++++++
 t/t4211/sha256/expect.two-ranges              | 102 ++++++++++
 t/t4211/sha256/expect.vanishes-early          |  39 ++++
 14 files changed, 1263 insertions(+), 1 deletion(-)
 create mode 100644 t/t4211/sha256/expect.beginning-of-file
 create mode 100644 t/t4211/sha256/expect.end-of-file
 create mode 100644 t/t4211/sha256/expect.move-support-f
 create mode 100644 t/t4211/sha256/expect.multiple
 create mode 100644 t/t4211/sha256/expect.multiple-overlapping
 create mode 100644 t/t4211/sha256/expect.multiple-superset
 create mode 100644 t/t4211/sha256/expect.parallel-change-f-to-main
 create mode 100644 t/t4211/sha256/expect.simple-f
 create mode 100644 t/t4211/sha256/expect.simple-f-to-main
 create mode 100644 t/t4211/sha256/expect.simple-main
 create mode 100644 t/t4211/sha256/expect.simple-main-to-end
 create mode 100644 t/t4211/sha256/expect.two-ranges
 create mode 100644 t/t4211/sha256/expect.vanishes-early

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 63a3bf28a5..cda58186c2 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -4,6 +4,7 @@ test_description='test log -L'
 . ./test-lib.sh
 
 test_expect_success 'setup (import history)' '
+	test_oid_init &&
 	git fast-import < "$TEST_DIRECTORY"/t4211/history.export &&
 	git reset --hard
 '
@@ -11,7 +12,7 @@ test_expect_success 'setup (import history)' '
 canned_test_1 () {
 	test_expect_$1 "$2" "
 		git log $2 >actual &&
-		test_cmp \"\$TEST_DIRECTORY\"/t4211/sha1/expect.$3 actual
+		test_cmp \"\$TEST_DIRECTORY\"/t4211/$(test_oid algo)/expect.$3 actual
 	"
 }
 
diff --git a/t/t4211/sha256/expect.beginning-of-file b/t/t4211/sha256/expect.beginning-of-file
new file mode 100644
index 0000000000..5adfdfc1a1
--- /dev/null
+++ b/t/t4211/sha256/expect.beginning-of-file
@@ -0,0 +1,43 @@
+commit 62a40b38fa4f00800004aee81ef287b7201317594ebcb990f38cbe493b01d200
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:47:40 2013 +0100
+
+    change at very beginning
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -1,3 +1,4 @@
++#include <unistd.h>
+ #include <stdio.h>
+ 
+ long f(long x)
+
+commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -1,3 +1,3 @@
+ #include <stdio.h>
+ 
+-int f(int x)
++long f(long x)
+
+commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +1,3 @@
++#include <stdio.h>
++
++int f(int x)
diff --git a/t/t4211/sha256/expect.end-of-file b/t/t4211/sha256/expect.end-of-file
new file mode 100644
index 0000000000..03ab5c1784
--- /dev/null
+++ b/t/t4211/sha256/expect.end-of-file
@@ -0,0 +1,62 @@
+commit 5526ed05c2476b56af8b7be499e8f78bd50f490740733a9ca7e1f55878fa90a9
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -20,3 +20,5 @@
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
++
++/* incomplete lines are bad! */
+
+commit 29f32ac3141c48b22803e5c4127b719917b67d0f8ca8c5248bebfa2a19f7da10
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -20,3 +20,3 @@
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
+
+commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -19,3 +19,3 @@
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
+commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +18,3 @@
++	printf("%d\n", f(15));
++	return 0;
++}
diff --git a/t/t4211/sha256/expect.move-support-f b/t/t4211/sha256/expect.move-support-f
new file mode 100644
index 0000000000..223b4ed2a0
--- /dev/null
+++ b/t/t4211/sha256/expect.move-support-f
@@ -0,0 +1,80 @@
+commit 4f7a58195a92c400e28a2354328587f1ff14fb77f5cf894536f17ccbc72931b9
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:49:50 2013 +0100
+
+    another simple change
+
+diff --git a/b.c b/b.c
+--- a/b.c
++++ b/b.c
+@@ -4,9 +4,9 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+-		x >>= 1;
++		x /= 2;
+ 		s++;
+ 	}
+ 	return s;
+ }
+
+commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,9 +3,9 @@
+-int f(int x)
++long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+
+commit f6434acd34260a6c9f61e96d96bf9a323d330561df5b1ca2631104f82026dfed
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:55 2013 +0100
+
+    change f()
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,8 +3,9 @@
+ int f(int x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
++	return s;
+ }
+
+commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +3,8 @@
++int f(int x)
++{
++	int s = 0;
++	while (x) {
++		x >>= 1;
++		s++;
++	}
++}
diff --git a/t/t4211/sha256/expect.multiple b/t/t4211/sha256/expect.multiple
new file mode 100644
index 0000000000..ca00409b9a
--- /dev/null
+++ b/t/t4211/sha256/expect.multiple
@@ -0,0 +1,104 @@
+commit 5526ed05c2476b56af8b7be499e8f78bd50f490740733a9ca7e1f55878fa90a9
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,7 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
++
++/* incomplete lines are bad! */
+
+commit 29f32ac3141c48b22803e5c4127b719917b67d0f8ca8c5248bebfa2a19f7da10
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,5 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
+
+commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,9 +3,9 @@
+-int f(int x)
++long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+@@ -17,5 +17,5 @@
+ int main ()
+ {
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
+commit f6434acd34260a6c9f61e96d96bf9a323d330561df5b1ca2631104f82026dfed
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:55 2013 +0100
+
+    change f()
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,8 +3,9 @@
+ int f(int x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
++	return s;
+ }
+
+commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +3,8 @@
++int f(int x)
++{
++	int s = 0;
++	while (x) {
++		x >>= 1;
++		s++;
++	}
++}
diff --git a/t/t4211/sha256/expect.multiple-overlapping b/t/t4211/sha256/expect.multiple-overlapping
new file mode 100644
index 0000000000..9015a45a25
--- /dev/null
+++ b/t/t4211/sha256/expect.multiple-overlapping
@@ -0,0 +1,187 @@
+commit 5526ed05c2476b56af8b7be499e8f78bd50f490740733a9ca7e1f55878fa90a9
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -4,19 +4,21 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+  * This is only an example!
+  */
+ 
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
++
++/* incomplete lines are bad! */
+
+commit 29f32ac3141c48b22803e5c4127b719917b67d0f8ca8c5248bebfa2a19f7da10
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -4,19 +4,19 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+  * This is only an example!
+  */
+ 
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
+
+commit 5a1b3989063d55e71e7685efa3392f133385b4034bddde530dcb5090d8b8b8ca
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:41 2013 +0100
+
+    touch comment
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,19 +3,19 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+- * A comment.
++ * This is only an example!
+  */
+ 
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
+commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,19 +3,19 @@
+-int f(int x)
++long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+  * A comment.
+  */
+ 
+ int main ()
+ {
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
+commit f6434acd34260a6c9f61e96d96bf9a323d330561df5b1ca2631104f82026dfed
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:55 2013 +0100
+
+    change f()
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,18 +3,19 @@
+ int f(int x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
++	return s;
+ }
+ 
+ /*
+  * A comment.
+  */
+ 
+ int main ()
+ {
+ 	printf("%d\n", f(15));
+ 	return 0;
+ }
+
+commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +3,18 @@
++int f(int x)
++{
++	int s = 0;
++	while (x) {
++		x >>= 1;
++		s++;
++	}
++}
++
++/*
++ * A comment.
++ */
++
++int main ()
++{
++	printf("%d\n", f(15));
++	return 0;
++}
diff --git a/t/t4211/sha256/expect.multiple-superset b/t/t4211/sha256/expect.multiple-superset
new file mode 100644
index 0000000000..9015a45a25
--- /dev/null
+++ b/t/t4211/sha256/expect.multiple-superset
@@ -0,0 +1,187 @@
+commit 5526ed05c2476b56af8b7be499e8f78bd50f490740733a9ca7e1f55878fa90a9
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -4,19 +4,21 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+  * This is only an example!
+  */
+ 
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
++
++/* incomplete lines are bad! */
+
+commit 29f32ac3141c48b22803e5c4127b719917b67d0f8ca8c5248bebfa2a19f7da10
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -4,19 +4,19 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+  * This is only an example!
+  */
+ 
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
+
+commit 5a1b3989063d55e71e7685efa3392f133385b4034bddde530dcb5090d8b8b8ca
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:41 2013 +0100
+
+    touch comment
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,19 +3,19 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+- * A comment.
++ * This is only an example!
+  */
+ 
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
+commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,19 +3,19 @@
+-int f(int x)
++long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+  * A comment.
+  */
+ 
+ int main ()
+ {
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
+commit f6434acd34260a6c9f61e96d96bf9a323d330561df5b1ca2631104f82026dfed
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:55 2013 +0100
+
+    change f()
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,18 +3,19 @@
+ int f(int x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
++	return s;
+ }
+ 
+ /*
+  * A comment.
+  */
+ 
+ int main ()
+ {
+ 	printf("%d\n", f(15));
+ 	return 0;
+ }
+
+commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +3,18 @@
++int f(int x)
++{
++	int s = 0;
++	while (x) {
++		x >>= 1;
++		s++;
++	}
++}
++
++/*
++ * A comment.
++ */
++
++int main ()
++{
++	printf("%d\n", f(15));
++	return 0;
++}
diff --git a/t/t4211/sha256/expect.parallel-change-f-to-main b/t/t4211/sha256/expect.parallel-change-f-to-main
new file mode 100644
index 0000000000..e68f8928ea
--- /dev/null
+++ b/t/t4211/sha256/expect.parallel-change-f-to-main
@@ -0,0 +1,160 @@
+commit 98117c2059b76c36995748fb97b02542aef477fe26379e94c18fd70f7790bc67
+Merge: b511694 4f7a581
+Author: Thomas Rast <trast@inf.ethz.ch>
+Date:   Fri Apr 12 16:16:24 2013 +0200
+
+    Merge across the rename
+
+
+commit 4f7a58195a92c400e28a2354328587f1ff14fb77f5cf894536f17ccbc72931b9
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:49:50 2013 +0100
+
+    another simple change
+
+diff --git a/b.c b/b.c
+--- a/b.c
++++ b/b.c
+@@ -4,14 +4,14 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+-		x >>= 1;
++		x /= 2;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+  * This is only an example!
+  */
+ 
+
+commit b511694f5337663fbd697622993a5f8e1099eca84be4df313f2b3ee94a098b42
+Author: Thomas Rast <trast@inf.ethz.ch>
+Date:   Fri Apr 12 16:15:57 2013 +0200
+
+    change on another line of history while rename happens
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -4,14 +4,14 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+- * This is only an example!
++ * This is only a short example!
+  */
+ 
+
+commit 5a1b3989063d55e71e7685efa3392f133385b4034bddde530dcb5090d8b8b8ca
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:41 2013 +0100
+
+    touch comment
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,14 +3,14 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+- * A comment.
++ * This is only an example!
+  */
+ 
+
+commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,14 +3,14 @@
+-int f(int x)
++long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+  * A comment.
+  */
+ 
+
+commit f6434acd34260a6c9f61e96d96bf9a323d330561df5b1ca2631104f82026dfed
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:55 2013 +0100
+
+    change f()
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,13 +3,14 @@
+ int f(int x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
++	return s;
+ }
+ 
+ /*
+  * A comment.
+  */
+ 
+
+commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +3,13 @@
++int f(int x)
++{
++	int s = 0;
++	while (x) {
++		x >>= 1;
++		s++;
++	}
++}
++
++/*
++ * A comment.
++ */
++
diff --git a/t/t4211/sha256/expect.simple-f b/t/t4211/sha256/expect.simple-f
new file mode 100644
index 0000000000..65508d7c0b
--- /dev/null
+++ b/t/t4211/sha256/expect.simple-f
@@ -0,0 +1,59 @@
+commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,9 +3,9 @@
+-int f(int x)
++long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+
+commit f6434acd34260a6c9f61e96d96bf9a323d330561df5b1ca2631104f82026dfed
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:55 2013 +0100
+
+    change f()
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,8 +3,9 @@
+ int f(int x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
++	return s;
+ }
+
+commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +3,8 @@
++int f(int x)
++{
++	int s = 0;
++	while (x) {
++		x >>= 1;
++		s++;
++	}
++}
diff --git a/t/t4211/sha256/expect.simple-f-to-main b/t/t4211/sha256/expect.simple-f-to-main
new file mode 100644
index 0000000000..77b721c196
--- /dev/null
+++ b/t/t4211/sha256/expect.simple-f-to-main
@@ -0,0 +1,100 @@
+commit 5a1b3989063d55e71e7685efa3392f133385b4034bddde530dcb5090d8b8b8ca
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:41 2013 +0100
+
+    touch comment
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,14 +3,14 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+- * A comment.
++ * This is only an example!
+  */
+ 
+
+commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,14 +3,14 @@
+-int f(int x)
++long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+  * A comment.
+  */
+ 
+
+commit f6434acd34260a6c9f61e96d96bf9a323d330561df5b1ca2631104f82026dfed
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:55 2013 +0100
+
+    change f()
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,13 +3,14 @@
+ int f(int x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
++	return s;
+ }
+ 
+ /*
+  * A comment.
+  */
+ 
+
+commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +3,13 @@
++int f(int x)
++{
++	int s = 0;
++	while (x) {
++		x >>= 1;
++		s++;
++	}
++}
++
++/*
++ * A comment.
++ */
++
diff --git a/t/t4211/sha256/expect.simple-main b/t/t4211/sha256/expect.simple-main
new file mode 100644
index 0000000000..d20708c9f9
--- /dev/null
+++ b/t/t4211/sha256/expect.simple-main
@@ -0,0 +1,68 @@
+commit 5526ed05c2476b56af8b7be499e8f78bd50f490740733a9ca7e1f55878fa90a9
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,5 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
+
+commit 29f32ac3141c48b22803e5c4127b719917b67d0f8ca8c5248bebfa2a19f7da10
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,5 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
+
+commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -17,5 +17,5 @@
+ int main ()
+ {
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
+commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +16,5 @@
++int main ()
++{
++	printf("%d\n", f(15));
++	return 0;
++}
diff --git a/t/t4211/sha256/expect.simple-main-to-end b/t/t4211/sha256/expect.simple-main-to-end
new file mode 100644
index 0000000000..617cdf3481
--- /dev/null
+++ b/t/t4211/sha256/expect.simple-main-to-end
@@ -0,0 +1,70 @@
+commit 5526ed05c2476b56af8b7be499e8f78bd50f490740733a9ca7e1f55878fa90a9
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,7 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
++
++/* incomplete lines are bad! */
+
+commit 29f32ac3141c48b22803e5c4127b719917b67d0f8ca8c5248bebfa2a19f7da10
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,5 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
+
+commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -17,5 +17,5 @@
+ int main ()
+ {
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
+commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +16,5 @@
++int main ()
++{
++	printf("%d\n", f(15));
++	return 0;
++}
diff --git a/t/t4211/sha256/expect.two-ranges b/t/t4211/sha256/expect.two-ranges
new file mode 100644
index 0000000000..af57c8b997
--- /dev/null
+++ b/t/t4211/sha256/expect.two-ranges
@@ -0,0 +1,102 @@
+commit 5526ed05c2476b56af8b7be499e8f78bd50f490740733a9ca7e1f55878fa90a9
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,5 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
+
+commit 29f32ac3141c48b22803e5c4127b719917b67d0f8ca8c5248bebfa2a19f7da10
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,5 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
+
+commit ccf97b9878189c40a981da50b15713bb80a35755326320ec80900caf22ced46f
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,9 +3,9 @@
+-int f(int x)
++long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+@@ -17,5 +17,5 @@
+ int main ()
+ {
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
+commit f6434acd34260a6c9f61e96d96bf9a323d330561df5b1ca2631104f82026dfed
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:55 2013 +0100
+
+    change f()
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,8 +3,9 @@
+ int f(int x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
++	return s;
+ }
+
+commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +3,8 @@
++int f(int x)
++{
++	int s = 0;
++	while (x) {
++		x >>= 1;
++		s++;
++	}
++}
diff --git a/t/t4211/sha256/expect.vanishes-early b/t/t4211/sha256/expect.vanishes-early
new file mode 100644
index 0000000000..11ec9bdecf
--- /dev/null
+++ b/t/t4211/sha256/expect.vanishes-early
@@ -0,0 +1,39 @@
+commit 5526ed05c2476b56af8b7be499e8f78bd50f490740733a9ca7e1f55878fa90a9
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -22,1 +24,1 @@
+-}
+\ No newline at end of file
++/* incomplete lines are bad! */
+
+commit 29f32ac3141c48b22803e5c4127b719917b67d0f8ca8c5248bebfa2a19f7da10
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -22,1 +22,1 @@
+-}
++}
+\ No newline at end of file
+
+commit 1dd7e9b2b1699324b53b341e728653b913bc192a14dfea168c5b51f2b3d03592
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +20,1 @@
++}
