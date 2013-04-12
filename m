From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 1/4] t4211: pass -M to 'git log -M -L...' test
Date: Fri, 12 Apr 2013 18:05:09 +0200
Message-ID: <d3e5ef657b4bf4baa849528d4be8560e25c3134e.1365781999.git.trast@inf.ethz.ch>
References: <cover.1365781999.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 18:05:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQgTp-0000ti-6O
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 18:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688Ab3DLQFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 12:05:21 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:4869 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043Ab3DLQFU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 12:05:20 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Apr
 2013 18:05:18 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Apr
 2013 18:05:16 +0200
X-Mailer: git-send-email 1.8.2.1.567.g8ad0f43
In-Reply-To: <cover.1365781999.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220989>

Embarrassingly, the -M test did not actually invoke -M, and thus not
really test the feature.
---
 t/t4211-line-log.sh           |  2 +-
 t/t4211/expect.move-support-f | 56 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 2341351..2a67e31 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -37,7 +37,7 @@ canned_test "-L 20:a.c simple" end-of-file
 canned_test "-L '/long f/',/^}/:a.c -L /main/,/^}/:a.c simple" two-ranges
 canned_test "-L 24,+1:a.c simple" vanishes-early
 
-canned_test "-L '/long f/,/^}/:b.c' move-support" move-support-f
+canned_test "-M -L '/long f/,/^}/:b.c' move-support" move-support-f
 
 canned_test "-L 4,12:a.c -L :main:a.c simple" multiple
 canned_test "-L 4,18:a.c -L :main:a.c simple" multiple-overlapping
diff --git a/t/t4211/expect.move-support-f b/t/t4211/expect.move-support-f
index 78a8cf1..c905e01 100644
--- a/t/t4211/expect.move-support-f
+++ b/t/t4211/expect.move-support-f
@@ -19,22 +19,62 @@ diff --git a/b.c b/b.c
  	return s;
  }
 
-commit e6da343666244ea9e67cbe3f3bd26da860f9fe0e
+commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
 Author: Thomas Rast <trast@student.ethz.ch>
-Date:   Thu Feb 28 10:49:28 2013 +0100
+Date:   Thu Feb 28 10:45:16 2013 +0100
 
-    move file
+    touch both functions
 
-diff --git a/b.c b/b.c
---- /dev/null
-+++ b/b.c
-@@ -0,0 +4,9 @@
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,9 +3,9 @@
+-int f(int x)
 +long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+
+commit f04fb20f2c77850996cba739709acc6faecc58f7
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
+commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
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
 +{
 +	int s = 0;
 +	while (x) {
 +		x >>= 1;
 +		s++;
 +	}
-+	return s;
 +}
-- 
1.8.2.1.567.g8ad0f43
