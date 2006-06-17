From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] Make t4101-apply-nonl bring along its patches
Date: Sat, 17 Jun 2006 17:02:45 +0200
Message-ID: <20060617150245.G2842888b@leonov.stosberg.net>
References: <20060617130957.G199de590@leonov.stosberg.net> <200606171446.k5HEkZAx006686@grail.cba.csuohio.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Sat Jun 17 17:03:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrcKJ-00086W-V2
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 17:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWFQPDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 11:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWFQPDE
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 11:03:04 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:29057 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1751659AbWFQPDD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 11:03:03 -0400
Received: from leonov.stosberg.net (p213.54.79.58.tisdip.tiscali.de [213.54.79.58])
	by ncs.stosberg.net (Postfix) with ESMTP id 432FDAEBA005;
	Sat, 17 Jun 2006 17:02:41 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id CD00210C6F1; Sat, 17 Jun 2006 17:02:45 +0200 (CEST)
To: Michael Somos <somos@grail.cba.csuohio.edu>
Content-Disposition: inline
In-Reply-To: <200606171446.k5HEkZAx006686@grail.cba.csuohio.edu>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22019>

Some versions of "diff" (e.g. on FreeBSD and older Linux systems) do
not support the "\ No newline at end of file" remark and are not
able to generate the patches needed for this test.  This lets the
test fail, although git-apply is working perfectly.  This patch adds
the pre-generated patches to t/t4100/ and makes the test use them.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---

 t/t4101-apply-nonl.sh |    6 +-----
 t/t4101/diff.0-1      |    6 ++++++
 t/t4101/diff.0-2      |    7 +++++++
 t/t4101/diff.0-3      |    8 ++++++++
 t/t4101/diff.1-0      |    6 ++++++
 t/t4101/diff.1-2      |    8 ++++++++
 t/t4101/diff.1-3      |    8 ++++++++
 t/t4101/diff.2-0      |    7 +++++++
 t/t4101/diff.2-1      |    8 ++++++++
 t/t4101/diff.2-3      |    7 +++++++
 t/t4101/diff.3-0      |    8 ++++++++
 t/t4101/diff.3-1      |    8 ++++++++
 t/t4101/diff.3-2      |    7 +++++++
 13 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/t/t4101-apply-nonl.sh b/t/t4101-apply-nonl.sh
index 26b131d..026fac8 100755
--- a/t/t4101-apply-nonl.sh
+++ b/t/t4101-apply-nonl.sh
@@ -20,14 +20,10 @@ do
   for j in 0 1 2 3
   do
     test $i -eq $j && continue
-    diff -u frotz.$i frotz.$j |
-    sed -e '
-	/^---/s|.*|--- a/frotz|
-	/^+++/s|.*|+++ b/frotz|' >diff.$i-$j
     cat frotz.$i >frotz
     test_expect_success \
         "apply diff between $i and $j" \
-	"git-apply <diff.$i-$j && diff frotz.$j frotz"
+	"git-apply <../t4101/diff.$i-$j && diff frotz.$j frotz"
   done
 done
 
diff --git a/t/t4101/diff.0-1 b/t/t4101/diff.0-1
new file mode 100644
index 0000000..1010a88
--- /dev/null
+++ b/t/t4101/diff.0-1
@@ -0,0 +1,6 @@
+--- a/frotz
++++ b/frotz
+@@ -1,2 +1,3 @@
+ a
+ b
++c
diff --git a/t/t4101/diff.0-2 b/t/t4101/diff.0-2
new file mode 100644
index 0000000..36460a2
--- /dev/null
+++ b/t/t4101/diff.0-2
@@ -0,0 +1,7 @@
+--- a/frotz
++++ b/frotz
+@@ -1,2 +1,2 @@
+ a
+-b
++b
+\ No newline at end of file
diff --git a/t/t4101/diff.0-3 b/t/t4101/diff.0-3
new file mode 100644
index 0000000..b281c43
--- /dev/null
+++ b/t/t4101/diff.0-3
@@ -0,0 +1,8 @@
+--- a/frotz
++++ b/frotz
+@@ -1,2 +1,3 @@
+ a
+-b
++c
++b
+\ No newline at end of file
diff --git a/t/t4101/diff.1-0 b/t/t4101/diff.1-0
new file mode 100644
index 0000000..f0a2e92
--- /dev/null
+++ b/t/t4101/diff.1-0
@@ -0,0 +1,6 @@
+--- a/frotz
++++ b/frotz
+@@ -1,3 +1,2 @@
+ a
+ b
+-c
diff --git a/t/t4101/diff.1-2 b/t/t4101/diff.1-2
new file mode 100644
index 0000000..2a440a5
--- /dev/null
+++ b/t/t4101/diff.1-2
@@ -0,0 +1,8 @@
+--- a/frotz
++++ b/frotz
+@@ -1,3 +1,2 @@
+ a
+-b
+-c
++b
+\ No newline at end of file
diff --git a/t/t4101/diff.1-3 b/t/t4101/diff.1-3
new file mode 100644
index 0000000..61aff97
--- /dev/null
+++ b/t/t4101/diff.1-3
@@ -0,0 +1,8 @@
+--- a/frotz
++++ b/frotz
+@@ -1,3 +1,3 @@
+ a
+-b
+ c
++b
+\ No newline at end of file
diff --git a/t/t4101/diff.2-0 b/t/t4101/diff.2-0
new file mode 100644
index 0000000..c2e71ee
--- /dev/null
+++ b/t/t4101/diff.2-0
@@ -0,0 +1,7 @@
+--- a/frotz
++++ b/frotz
+@@ -1,2 +1,2 @@
+ a
+-b
+\ No newline at end of file
++b
diff --git a/t/t4101/diff.2-1 b/t/t4101/diff.2-1
new file mode 100644
index 0000000..a66d9fd
--- /dev/null
+++ b/t/t4101/diff.2-1
@@ -0,0 +1,8 @@
+--- a/frotz
++++ b/frotz
+@@ -1,2 +1,3 @@
+ a
+-b
+\ No newline at end of file
++b
++c
diff --git a/t/t4101/diff.2-3 b/t/t4101/diff.2-3
new file mode 100644
index 0000000..5633c83
--- /dev/null
+++ b/t/t4101/diff.2-3
@@ -0,0 +1,7 @@
+--- a/frotz
++++ b/frotz
+@@ -1,2 +1,3 @@
+ a
++c
+ b
+\ No newline at end of file
diff --git a/t/t4101/diff.3-0 b/t/t4101/diff.3-0
new file mode 100644
index 0000000..10b1a41
--- /dev/null
+++ b/t/t4101/diff.3-0
@@ -0,0 +1,8 @@
+--- a/frotz
++++ b/frotz
+@@ -1,3 +1,2 @@
+ a
+-c
+-b
+\ No newline at end of file
++b
diff --git a/t/t4101/diff.3-1 b/t/t4101/diff.3-1
new file mode 100644
index 0000000..c799c60
--- /dev/null
+++ b/t/t4101/diff.3-1
@@ -0,0 +1,8 @@
+--- a/frotz
++++ b/frotz
+@@ -1,3 +1,3 @@
+ a
++b
+ c
+-b
+\ No newline at end of file
diff --git a/t/t4101/diff.3-2 b/t/t4101/diff.3-2
new file mode 100644
index 0000000..f8d1ba6
--- /dev/null
+++ b/t/t4101/diff.3-2
@@ -0,0 +1,7 @@
+--- a/frotz
++++ b/frotz
+@@ -1,3 +1,2 @@
+ a
+-c
+ b
+\ No newline at end of file
-- 
1.4.0
