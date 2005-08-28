From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 9/9] New git-apply test cases for scanning forwards and backwards.
Date: Sun, 28 Aug 2005 15:25:10 +0000
Message-ID: <1125242710834-git-send-email-robfitz@273k.net>
References: <11252427062184-git-send-email-robfitz@273k.net>
Reply-To: Robert Fitzsimons <robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Aug 28 17:24:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9P0M-0006Xg-Pb
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 17:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVH1PX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 11:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVH1PX2
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 11:23:28 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:37357 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S1751216AbVH1PX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 11:23:27 -0400
Received: from [212.17.39.138] (helo=earth)
	by igraine.blacknight.ie with smtp (Exim 4.42)
	id 1E9P05-0004Tl-Vi; Sun, 28 Aug 2005 16:23:16 +0100
In-Reply-To: <11252427062184-git-send-email-robfitz@273k.net>
X-Mailer: git-send-email-script
To: git@vger.kernel.org
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 7.5)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7875>

Added a new test case for the scanning forwards and backwards for the
correct location to apply a patch fragment.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>

---

 t/t4110-apply-scan.sh |  101 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 t/t4110-apply-scan.sh

51e9797ee16edc9d6164f2c7afaf1f8245538255
diff --git a/t/t4110-apply-scan.sh b/t/t4110-apply-scan.sh
new file mode 100644
--- /dev/null
+++ b/t/t4110-apply-scan.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+# Copyright (c) 2005 Robert Fitzsimons
+#
+
+test_description='git-apply test for patches which require scanning forwards and backwards.
+
+'
+. ./test-lib.sh
+
+# setup
+
+cat > patch1.patch <<\EOF
+diff --git a/new.txt b/new.txt
+new file mode 100644
+--- /dev/null
++++ b/new.txt
+@@ -0,0 +1,12 @@
++a1
++a11
++a111
++a1111
++b1
++b11
++b111
++b1111
++c1
++c11
++c111
++c1111
+EOF
+cat > patch2.patch <<\EOF
+diff --git a/new.txt b/new.txt
+--- a/new.txt
++++ b/new.txt
+@@ -1,7 +1,3 @@
+-a1
+-a11
+-a111
+-a1111
+ b1
+ b11
+ b111
+EOF
+cat > patch3.patch <<\EOF
+diff --git a/new.txt b/new.txt
+--- a/new.txt
++++ b/new.txt
+@@ -6,6 +6,10 @@
+ b11
+ b111
+ b1111
++b2
++b22
++b222
++b2222
+ c1
+ c11
+ c111
+EOF
+cat > patch4.patch <<\EOF
+diff --git a/new.txt b/new.txt
+--- a/new.txt
++++ b/new.txt
+@@ -1,3 +1,7 @@
++a1
++a11
++a111
++a1111
+ b1
+ b11
+ b111
+EOF
+cat > patch5.patch <<\EOF
+diff --git a/new.txt b/new.txt
+--- a/new.txt
++++ b/new.txt
+@@ -10,3 +10,7 @@
+ c11
+ c111
+ c1111
++c2
++c22
++c222
++c2222
+EOF
+
+test_expect_success "S = git-apply scan" \
+    'git-apply patch1.patch patch2.patch patch3.patch patch4.patch patch5.patch'
+mv new.txt apply.txt
+
+test_expect_success "S = patch scan" \
+    'cat patch1.patch patch2.patch patch3.patch patch4.patch patch5.patch | patch'
+mv new.txt patch.txt
+
+test_expect_success "S = cmp" \
+    'cmp apply.txt patch.txt'
+
+test_done
+
