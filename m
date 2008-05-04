From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v3 6/6] --color-words: Add test t4030
Date: Sun,  4 May 2008 12:20:15 +0800
Message-ID: <1209874815-14411-7-git-send-email-pkufranky@gmail.com>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-1-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-2-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-3-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-4-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-5-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-6-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 06:21:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsVjI-00053b-Ej
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 06:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbYEDEUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 00:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbYEDEU2
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 00:20:28 -0400
Received: from mail.qikoo.org ([60.28.205.235]:54658 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751072AbYEDEUV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 00:20:21 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 6C825470B3; Sun,  4 May 2008 12:20:15 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.121.g26b3
In-Reply-To: <1209874815-14411-6-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81131>

Also add a script gen-expect.sh to generate the expected
diff output.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 t/t4030-diff-color-words.sh |   42 ++++++++++++++++++++++++++++++++++++++++++
 t/t4030/expect1             |    1 +
 t/t4030/expect10            |    1 +
 t/t4030/expect2             |    1 +
 t/t4030/expect3             |    1 +
 t/t4030/expect4             |    1 +
 t/t4030/expect5             |    1 +
 t/t4030/expect6             |    1 +
 t/t4030/expect7             |    1 +
 t/t4030/expect8             |    1 +
 t/t4030/expect9             |    1 +
 t/t4030/gen-expect.sh       |   35 +++++++++++++++++++++++++++++++++++
 12 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100755 t/t4030-diff-color-words.sh
 create mode 100644 t/t4030/expect1
 create mode 100644 t/t4030/expect10
 create mode 100644 t/t4030/expect2
 create mode 100644 t/t4030/expect3
 create mode 100644 t/t4030/expect4
 create mode 100644 t/t4030/expect5
 create mode 100644 t/t4030/expect6
 create mode 100644 t/t4030/expect7
 create mode 100644 t/t4030/expect8
 create mode 100644 t/t4030/expect9
 create mode 100644 t/t4030/gen-expect.sh

diff --git a/t/t4030-diff-color-words.sh b/t/t4030-diff-color-words.sh
new file mode 100755
index 0000000..e1c8e8e
--- /dev/null
+++ b/t/t4030-diff-color-words.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='diff --color-words'
+
+. ./test-lib.sh
+. ../diff-lib.sh
+
+dotest() {
+	test_expect_success "$1" "
+	echo '$1' >t &&
+	git diff --color-words | tail -1 >actual &&
+	cat actual &&
+	test_cmp ../t4030/$2 actual
+"	
+}
+
+test_expect_success 'setup for foo bar(_baz' '
+	git config diff.nonwordchars "_()" &&
+	echo "foo bar(_baz" > t &&
+	git add t  &&
+	git commit -m "add t"
+'
+
+dotest "foo bar(_" expect1
+dotest "foo bar(" expect2
+dotest "foo bar" expect3
+dotest "foo (_baz" expect4
+dotest "foo _baz" expect5
+dotest "foo baz" expect6
+dotest "bar(_baz" expect7
+
+test_expect_success 'setup for foo bar(_' '
+	echo "foo bar(_" > t &&
+	git add t  &&
+	git commit -m "add t"
+'
+
+dotest "foo bar(" expect8
+dotest "foo bar" expect9
+dotest "foo bar_baz" expect10
+
+test_done
diff --git a/t/t4030/expect1 b/t/t4030/expect1
new file mode 100644
index 0000000..fb75467
--- /dev/null
+++ b/t/t4030/expect1
@@ -0,0 +1 @@
+[mfoo [mbar([m_[m[31mbaz[m[32m[m
diff --git a/t/t4030/expect10 b/t/t4030/expect10
new file mode 100644
index 0000000..b36e5db
--- /dev/null
+++ b/t/t4030/expect10
@@ -0,0 +1 @@
+[mfoo [mbar[m[31m([m[32m_[m[31m_[m[31m[m[32mbaz[m
diff --git a/t/t4030/expect2 b/t/t4030/expect2
new file mode 100644
index 0000000..6a9ca69
--- /dev/null
+++ b/t/t4030/expect2
@@ -0,0 +1 @@
+[mfoo [mbar([m[31m_[m[32m[m[31mbaz[m
diff --git a/t/t4030/expect3 b/t/t4030/expect3
new file mode 100644
index 0000000..d7d9885
--- /dev/null
+++ b/t/t4030/expect3
@@ -0,0 +1 @@
+[mfoo [mbar[m[31m([m[32m[m[31m_[m[31mbaz[m
diff --git a/t/t4030/expect4 b/t/t4030/expect4
new file mode 100644
index 0000000..449fd6d
--- /dev/null
+++ b/t/t4030/expect4
@@ -0,0 +1 @@
+[mfoo [m[31mbar([m[32m([m_[mbaz[m
diff --git a/t/t4030/expect5 b/t/t4030/expect5
new file mode 100644
index 0000000..eb184f7
--- /dev/null
+++ b/t/t4030/expect5
@@ -0,0 +1 @@
+[mfoo [m[31mbar([m_[mbaz[m
diff --git a/t/t4030/expect6 b/t/t4030/expect6
new file mode 100644
index 0000000..58591ad
--- /dev/null
+++ b/t/t4030/expect6
@@ -0,0 +1 @@
+[mfoo [m[31mbar([m[31m_[mbaz[m
diff --git a/t/t4030/expect7 b/t/t4030/expect7
new file mode 100644
index 0000000..c68a1f1
--- /dev/null
+++ b/t/t4030/expect7
@@ -0,0 +1 @@
+[m[31mfoo [mbar([m_[mbaz[m
diff --git a/t/t4030/expect8 b/t/t4030/expect8
new file mode 100644
index 0000000..f48152f
--- /dev/null
+++ b/t/t4030/expect8
@@ -0,0 +1 @@
+[mfoo [mbar([m[31m_[m[32m[m[31m[m
diff --git a/t/t4030/expect9 b/t/t4030/expect9
new file mode 100644
index 0000000..4f42b6c
--- /dev/null
+++ b/t/t4030/expect9
@@ -0,0 +1 @@
+[mfoo [mbar[m[31m([m[32m[m[31m_[m[31m[m
diff --git a/t/t4030/gen-expect.sh b/t/t4030/gen-expect.sh
new file mode 100644
index 0000000..da07535
--- /dev/null
+++ b/t/t4030/gen-expect.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+
+git config diff.nonwordchars "_()"
+
+echo "foo bar(_baz" >&2 &&
+echo "foo bar(_baz" > t
+
+git add t  &&
+git commit -m "add t"
+
+dotest() {
+	echo "$1" >&2 &&
+	echo "$1" >t  &&
+	git diff --color-words |
+	tail -1 > $2
+}
+
+dotest "foo bar(_" expect1
+dotest "foo bar(" expect2
+dotest "foo bar" expect3
+dotest "foo (_baz" expect4
+dotest "foo _baz" expect5
+dotest "foo baz" expect6
+dotest "bar(_baz" expect7
+
+
+echo "foo bar(_" >&2 &&
+echo "foo bar(_" >t
+
+git add t  &&
+git commit -m "add t"
+
+dotest "foo bar(" expect8
+dotest "foo bar" expect9
+dotest "foo bar_baz" expect10
-- 
1.5.5.1.121.g26b3
