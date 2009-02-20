From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/4] Start a library for cvsimport-related tests
Date: Fri, 20 Feb 2009 06:18:10 +0100
Message-ID: <c3466ee438cd4a5e9d08479ef127468981d4c293.1235106222.git.mhagger@alum.mit.edu>
References: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, peff@peff.net,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 06:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaNnv-00035N-1M
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 06:20:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbZBTFSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 00:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbZBTFSc
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 00:18:32 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:49827 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbZBTFSc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 00:18:32 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (77-21-84-251-dynip.superkabel.de [77.21.84.251])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n1K5IEtV005509;
	Fri, 20 Feb 2009 06:18:14 +0100
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110792>

For now the "library" just includes code (moved from
t/t9600-cvsimport.sh) that checks whether the prerequisites for "git
cvsimport" are installed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t9600-cvsimport.sh |   29 +----------------------------
 t/t96xx/cvs-lib.sh   |   31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 28 deletions(-)
 create mode 100644 t/t96xx/cvs-lib.sh

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index d2379e7..b4b9896 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -1,37 +1,10 @@
 #!/bin/sh
 
 test_description='git cvsimport basic tests'
-. ./test-lib.sh
+. ./t96xx/cvs-lib.sh
 
 CVSROOT=$(pwd)/cvsroot
 export CVSROOT
-unset CVS_SERVER
-# for clean cvsps cache
-HOME=$(pwd)
-export HOME
-
-if ! type cvs >/dev/null 2>&1
-then
-	say 'skipping cvsimport tests, cvs not found'
-	test_done
-	exit
-fi
-
-cvsps_version=`cvsps -h 2>&1 | sed -ne 's/cvsps version //p'`
-case "$cvsps_version" in
-2.1 | 2.2*)
-	;;
-'')
-	say 'skipping cvsimport tests, cvsps not found'
-	test_done
-	exit
-	;;
-*)
-	say 'skipping cvsimport tests, unsupported cvsps version'
-	test_done
-	exit
-	;;
-esac
 
 test_expect_success 'setup cvsroot' 'cvs init'
 
diff --git a/t/t96xx/cvs-lib.sh b/t/t96xx/cvs-lib.sh
new file mode 100644
index 0000000..bfc1c12
--- /dev/null
+++ b/t/t96xx/cvs-lib.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+. ./test-lib.sh
+
+unset CVS_SERVER
+# for clean cvsps cache
+HOME=$(pwd)
+export HOME
+
+if ! type cvs >/dev/null 2>&1
+then
+	say 'skipping cvsimport tests, cvs not found'
+	test_done
+	exit
+fi
+
+cvsps_version=`cvsps -h 2>&1 | sed -ne 's/cvsps version //p'`
+case "$cvsps_version" in
+2.1 | 2.2*)
+	;;
+'')
+	say 'skipping cvsimport tests, cvsps not found'
+	test_done
+	exit
+	;;
+*)
+	say 'skipping cvsimport tests, unsupported cvsps version'
+	test_done
+	exit
+	;;
+esac
-- 
1.6.1.3
