From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] tests: added d2u to have unix style testfiles even in textmode
Date: Wed,  8 Aug 2007 00:49:07 +0200
Message-ID: <11865269472121-git-send-email-prohaska@zib.de>
References: <A80CCC35-DE1E-4A0B-9144-A8165AF6C98A@zib.de>
 <11865269472595-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org, torvalds@linux-foundation.org,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 08 00:53:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIXvo-0004x2-Ae
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 00:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933144AbXHGWxg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 18:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbXHGWxg
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 18:53:36 -0400
Received: from mailer.zib.de ([130.73.108.11]:33049 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763801AbXHGWxf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 18:53:35 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l77Mn8AL023716;
	Wed, 8 Aug 2007 00:49:08 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l77Mn7ck001225;
	Wed, 8 Aug 2007 00:49:07 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11865269472595-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55284>

This is needed if the content of files is compared with
precomputed sha1s or stored expected results.

***WARNING***
This patch is useful for testing and illustrating the problem
but not thought to be applied to any official git branch.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 t/t0000-basic.sh      |    2 +-
 t/t0020-crlf.sh       |    8 ++++----
 t/t0021-conversion.sh |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 4e49d59..bf71ce6 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -91,7 +91,7 @@ test_expect_success \
 mkdir path2 path3 path3/subp3
 for p in path0 path2/file2 path3/file3 path3/subp3/file3
 do
-    echo "hello $p" >$p
+    echo "hello $p" | d2u >$p
     ln -s "hello $p" ${p}sym
 done
 test_expect_success \
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index fe1dfd0..52dc739 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -21,10 +21,10 @@ test_expect_success setup '
 
 	git repo-config core.autocrlf false &&
 
-	for w in Hello world how are you; do echo $w; done >one &&
+	for w in Hello world how are you; do echo $w; done | d2u >one &&
 	mkdir dir &&
-	for w in I am very very fine thank you; do echo $w; done >dir/two &&
-	for w in Oh here is NULQin text here; do echo $w; done | q_to_nul >three &&
+	for w in I am very very fine thank you; do echo $w; done | d2u  >dir/two &&
+	for w in Oh here is NULQin text here; do echo $w; done | q_to_nul | d2u >three &&
 	git add . &&
 
 	git commit -m initial &&
@@ -34,7 +34,7 @@ test_expect_success setup '
 	two=`git rev-parse HEAD:dir/two` &&
 	three=`git rev-parse HEAD:three` &&
 
-	for w in Some extra lines here; do echo $w; done >>one &&
+	for w in Some extra lines here; do echo $w; done | d2u >>one &&
 	git diff >patch.file &&
 	patched=`git hash-object --stdin <one` &&
 	git read-tree --reset -u HEAD &&
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index a839f4e..9ca11bb 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -57,7 +57,7 @@ test_expect_success expanded_in_repo '
 		echo "\$Id:NoSpaceAtFront \$"
 		echo "\$Id:NoSpaceAtEitherEnd\$"
 		echo "\$Id: NoTerminatingSymbol"
-	} > expanded-keywords &&
+	} | d2u > expanded-keywords &&
 
 	{
 		echo "File with expanded keywords"
@@ -68,7 +68,7 @@ test_expect_success expanded_in_repo '
 		echo "\$Id: 4f21723e7b15065df7de95bd46c8ba6fb1818f4c \$"
 		echo "\$Id: 4f21723e7b15065df7de95bd46c8ba6fb1818f4c \$"
 		echo "\$Id: NoTerminatingSymbol"
-	} > expected-output &&
+	} | d2u > expected-output &&
 
 	git add expanded-keywords &&
 	git commit -m "File with keywords expanded" &&
-- 
1.5.1.2
