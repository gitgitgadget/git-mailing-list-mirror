From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH] t: make PIPE a standard test prerequisite
Date: Thu, 11 Apr 2013 03:07:04 +0100
Message-ID: <1365646024-27393-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 04:07:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ6uv-0000k1-Fc
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 04:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135Ab3DKCHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 22:07:07 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:58217 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964901Ab3DKCHG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 22:07:06 -0400
Received: from localhost (5.c.4.3.a.a.9.7.2.0.8.9.d.e.c.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:bced:9802:79aa:34c5])
	by coral.adamspiers.org (Postfix) with ESMTPSA id DB0A82EAD5
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 03:07:04 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.347.g37e0606
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220806>

The 'PIPE' test prerequisite was already defined identically by t9010
and t9300, therefore it makes sense to make it a predefined
prerequisite.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
My first attempt at writing a test for check-ignore's new streaming
behaviour involved mkfifo, during which I noticed this code duplication.

 t/README               | 5 +++++
 t/t9010-svn-fe.sh      | 8 --------
 t/t9300-fast-import.sh | 8 --------
 t/test-lib.sh          | 5 +++++
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/t/README b/t/README
index 9b41fe7..70e49fc 100644
--- a/t/README
+++ b/t/README
@@ -619,6 +619,11 @@ use these, and "test_set_prereq" for how to define your own.
    The process retains the same pid across exec(2). See fb9a2bea for
    details.
 
+ - PIPE
+
+   The filesystem we're on supports creation of FIFOs (named pipes)
+   via mkfifo(1).
+
  - SYMLINKS
 
    The filesystem we're on supports symbolic links. E.g. a FAT
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index b7eed24..6dafe7e 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -54,14 +54,6 @@ text_no_props () {
 
 >empty
 
-test_expect_success 'setup: have pipes?' '
-	rm -f frob &&
-	if mkfifo frob
-	then
-		test_set_prereq PIPE
-	fi
-'
-
 test_expect_success PIPE 'empty dump' '
 	reinit_git &&
 	echo "SVN-fs-dump-format-version: 2" >input &&
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2fcf269..ac6f3b6 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -49,14 +49,6 @@ echo "$@"'
 
 >empty
 
-test_expect_success 'setup: have pipes?' '
-	rm -f frob &&
-	if mkfifo frob
-	then
-		test_set_prereq PIPE
-	fi
-'
-
 ###
 ### series A
 ###
diff --git a/t/test-lib.sh b/t/test-lib.sh
index da57a2f..debd8b4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -735,6 +735,11 @@ test_i18ngrep () {
 	fi
 }
 
+test_lazy_prereq PIPE '
+	# test whether the filesystem supports FIFOs
+	rm -f testfifo && mkfifo testfifo
+'
+
 test_lazy_prereq SYMLINKS '
 	# test whether the filesystem supports symbolic links
 	ln -s x y && test -h y
-- 
1.8.2.1.347.g37e0606
