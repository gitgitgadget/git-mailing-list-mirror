From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH] Add a test-case for git-apply trying to add an ending line
Date: Tue, 23 May 2006 22:48:36 +0100
Message-ID: <20060523214836.22628.2179.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue May 23 23:48:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiekD-00035a-Ge
	for gcvg-git@gmane.org; Tue, 23 May 2006 23:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWEWVsp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 17:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWEWVsp
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 17:48:45 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:44203 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932258AbWEWVsp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 17:48:45 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20060523214843.RHPK29343.mtaout01-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Tue, 23 May 2006 22:48:43 +0100
Received: from localhost.localdomain ([81.98.248.58])
          by aamtaout01-winn.ispmail.ntl.com with ESMTP
          id <20060523214843.UDOW19763.aamtaout01-winn.ispmail.ntl.com@localhost.localdomain>;
          Tue, 23 May 2006 22:48:43 +0100
To: git@vger.kernel.org
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20643>

From: Catalin Marinas <catalin.marinas@gmail.com>

git-apply adding an ending line doesn't seem to fail if the ending line is
already present in the patched file.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 t/t4113-apply-ending.sh |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
new file mode 100755
index 0000000..d021ae8
--- /dev/null
+++ b/t/t4113-apply-ending.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Catalin Marinas
+#
+
+test_description='git-apply trying to add an ending line.
+
+'
+. ./test-lib.sh
+
+# setup
+
+cat >test-patch <<\EOF
+diff --git a/file b/file
+--- a/file
++++ b/file
+@@ -1,2 +1,3 @@
+ a
+ b
++c
+EOF
+
+echo 'a' >file
+echo 'b' >>file
+echo 'c' >>file
+
+test_expect_success setup \
+    'git-update-index --add file'
+
+# test
+
+test_expect_failure apply \
+    'git-apply --index test-patch'
+
+test_done
