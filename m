From: Adam Roben <aroben@apple.com>
Subject: [PATCH 06/11] Move git-hash-object tests from t5303 to t1007
Date: Wed, 23 Apr 2008 15:17:48 -0400
Message-ID: <1208978273-98146-7-git-send-email-aroben@apple.com>
References: <1208978273-98146-1-git-send-email-aroben@apple.com>
 <1208978273-98146-2-git-send-email-aroben@apple.com>
 <1208978273-98146-3-git-send-email-aroben@apple.com>
 <1208978273-98146-4-git-send-email-aroben@apple.com>
 <1208978273-98146-5-git-send-email-aroben@apple.com>
 <1208978273-98146-6-git-send-email-aroben@apple.com>
Cc: Adam Roben <aroben@apple.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:20:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JokUz-00058u-6r
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 21:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174AbYDWTSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 15:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755843AbYDWTSS
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 15:18:18 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:50301 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043AbYDWTSE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 15:18:04 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id 5910C2A6A25A;
	Wed, 23 Apr 2008 12:18:02 -0700 (PDT)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 3DD362807F;
	Wed, 23 Apr 2008 12:18:02 -0700 (PDT)
X-AuditID: 1180711d-aab95bb000000ed7-37-480f8b698d74
Received: from localhost.localdomain (unknown [17.151.126.45])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 69BE528042;
	Wed, 23 Apr 2008 12:18:01 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.152.g9aeb7
In-Reply-To: <1208978273-98146-6-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80241>

This is a more appropriate location according to t/README.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 t/t1007-hash-object.sh |   35 +++++++++++++++++++++++++++++++++++
 t/t5303-hash-object.sh |   35 -----------------------------------
 2 files changed, 35 insertions(+), 35 deletions(-)
 create mode 100755 t/t1007-hash-object.sh
 delete mode 100755 t/t5303-hash-object.sh

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
new file mode 100755
index 0000000..543c078
--- /dev/null
+++ b/t/t1007-hash-object.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description=git-hash-object
+
+. ./test-lib.sh
+
+test_expect_success \
+    'git hash-object -w --stdin saves the object' \
+    'obname=$(echo foo | git hash-object -w --stdin) &&
+    obpath=$(echo $obname | sed -e "s/\(..\)/\1\//") &&
+    test -r .git/objects/"$obpath" &&
+    rm -f .git/objects/"$obpath"'
+    
+test_expect_success \
+    'git hash-object --stdin -w saves the object' \
+    'obname=$(echo foo | git hash-object --stdin -w) &&
+    obpath=$(echo $obname | sed -e "s/\(..\)/\1\//") &&
+    test -r .git/objects/"$obpath" &&
+    rm -f .git/objects/"$obpath"'    
+
+test_expect_success \
+    'git hash-object --stdin file1 <file0 first operates on file0, then file1' \
+    'echo foo > file1 &&
+    obname0=$(echo bar | git hash-object --stdin) &&
+    obname1=$(git hash-object file1) &&
+    obname0new=$(echo bar | git hash-object --stdin file1 | sed -n -e 1p) &&
+    obname1new=$(echo bar | git hash-object --stdin file1 | sed -n -e 2p) &&
+    test "$obname0" = "$obname0new" &&
+    test "$obname1" = "$obname1new"'
+
+test_expect_success \
+    'git hash-object refuses multiple --stdin arguments' \
+    '! git hash-object --stdin --stdin < file1'
+
+test_done
diff --git a/t/t5303-hash-object.sh b/t/t5303-hash-object.sh
deleted file mode 100755
index 543c078..0000000
--- a/t/t5303-hash-object.sh
+++ /dev/null
@@ -1,35 +0,0 @@
-#!/bin/sh
-
-test_description=git-hash-object
-
-. ./test-lib.sh
-
-test_expect_success \
-    'git hash-object -w --stdin saves the object' \
-    'obname=$(echo foo | git hash-object -w --stdin) &&
-    obpath=$(echo $obname | sed -e "s/\(..\)/\1\//") &&
-    test -r .git/objects/"$obpath" &&
-    rm -f .git/objects/"$obpath"'
-    
-test_expect_success \
-    'git hash-object --stdin -w saves the object' \
-    'obname=$(echo foo | git hash-object --stdin -w) &&
-    obpath=$(echo $obname | sed -e "s/\(..\)/\1\//") &&
-    test -r .git/objects/"$obpath" &&
-    rm -f .git/objects/"$obpath"'    
-
-test_expect_success \
-    'git hash-object --stdin file1 <file0 first operates on file0, then file1' \
-    'echo foo > file1 &&
-    obname0=$(echo bar | git hash-object --stdin) &&
-    obname1=$(git hash-object file1) &&
-    obname0new=$(echo bar | git hash-object --stdin file1 | sed -n -e 1p) &&
-    obname1new=$(echo bar | git hash-object --stdin file1 | sed -n -e 2p) &&
-    test "$obname0" = "$obname0new" &&
-    test "$obname1" = "$obname1new"'
-
-test_expect_success \
-    'git hash-object refuses multiple --stdin arguments' \
-    '! git hash-object --stdin --stdin < file1'
-
-test_done
-- 
1.5.5.1.152.g9aeb7
