From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/5] t/t5800: skip if python version is older than 2.5
Date: Tue,  1 Jun 2010 19:13:40 -0500
Message-ID: <Wt_M4qptcPdpY0Q3jqUbfCU_HpY9NEjqs9eujZFD2rsUj5HRo__oQm7EUCxzXu38mC0y-ilUA14@cipher.nrlssc.navy.mil>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 02:14:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJbbV-0007om-9o
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 02:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757407Ab0FBAOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 20:14:31 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50205 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756488Ab0FBAOa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 20:14:30 -0400
Received: by mail.nrlssc.navy.mil id o520E91P007905; Tue, 1 Jun 2010 19:14:09 -0500
In-Reply-To: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 02 Jun 2010 00:14:09.0974 (UTC) FILETIME=[85D7BD60:01CB01E8]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148178>

From: Brandon Casey <drafnel@gmail.com>

This test script depends on the git-remote-testgit python script.  This
python script makes use of the hashlib module which was released in python
version 2.5.  So, add a new pre-requisite named PYTHON_2_5_OR_NEWER to
test-lib.sh and check for it in t5800.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t5800-remote-helpers.sh |    4 ++--
 t/test-lib.sh             |    9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 75a0163..58f60ab 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -7,9 +7,9 @@ test_description='Test remote-helper import and export commands'
 
 . ./test-lib.sh
 
-if ! test_have_prereq PYTHON
+if ! test_have_prereq PYTHON_2_5_OR_NEWER
 then
-	say 'skipping git remote-testgit tests: requires Python support'
+	say 'skipping git remote-testgit tests: requires Python 2.5 or newer'
 	test_done
 fi
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 454880a..ce56e1c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -846,6 +846,15 @@ esac
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 
+if test_have_prereq PYTHON && "$PYTHON_PATH" -c '
+import sys
+if sys.hexversion < 0x02050000:
+    sys.exit(1)
+'
+then
+	test_set_prereq PYTHON_2_5_OR_NEWER
+fi
+
 # test whether the filesystem supports symbolic links
 ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYMLINKS
 rm -f y
-- 
1.6.6.2
