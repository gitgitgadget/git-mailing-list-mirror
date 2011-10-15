From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 4/7] t9901: fix line-ending dependency on windows
Date: Sat, 15 Oct 2011 15:05:17 +0100
Message-ID: <1318687520-19522-5-git-send-email-patthoyts@users.sourceforge.net>
References: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 15 16:05:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RF4rw-0003yR-FI
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 16:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab1JOOFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 10:05:33 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:63001 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752854Ab1JOOF3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 10:05:29 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111015140528.GEFP8898.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 15 Oct 2011 15:05:28 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <pat@patthoyts.tk>)
	id 1RF4rg-0001pu-HB; Sat, 15 Oct 2011 15:05:28 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 3D9B3207A7; Sat, 15 Oct 2011 15:05:28 +0100 (BST)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1318687520-19522-1-git-send-email-patthoyts@users.sourceforge.net>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=dAFvIKoIEu4A:10 a=FP58Ms26AAAA:8 a=A1X0JdhQAAAA:8 a=oD47-y1EKti9fW2EHZUA:9 a=dEdKmOJAzpS6tEYsF7AA:7 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183657>

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 t/t9901-git-web--browse.sh |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/t/t9901-git-web--browse.sh b/t/t9901-git-web--browse.sh
index 7906e5d..69513f1 100755
--- a/t/t9901-git-web--browse.sh
+++ b/t/t9901-git-web--browse.sh
@@ -7,31 +7,35 @@ This test checks that git web--browse can handle various valid URLs.'
 
 . ./test-lib.sh
 
+test_web_browse () {
+	# browser=$1 url=$2
+	git web--browse --browser="$1" "$2" >actual &&
+	tr -d '\015' <actual >text &&
+	test_cmp expect text
+}
+
 test_expect_success \
 	'URL with an ampersand in it' '
 	echo http://example.com/foo\&bar >expect &&
 	git config browser.custom.cmd echo &&
-	git web--browse --browser=custom \
-		http://example.com/foo\&bar >actual &&
-	test_cmp expect actual
+	test_web_browse custom \
+		http://example.com/foo\&bar
 '
 
 test_expect_success \
 	'URL with a semi-colon in it' '
 	echo http://example.com/foo\;bar >expect &&
 	git config browser.custom.cmd echo &&
-	git web--browse --browser=custom \
-		http://example.com/foo\;bar >actual &&
-	test_cmp expect actual
+	test_web_browse custom \
+		http://example.com/foo\;bar
 '
 
 test_expect_success \
 	'URL with a hash in it' '
 	echo http://example.com/foo#bar >expect &&
 	git config browser.custom.cmd echo &&
-	git web--browse --browser=custom \
-		http://example.com/foo#bar >actual &&
-	test_cmp expect actual
+	test_web_browse custom \
+		http://example.com/foo#bar
 '
 
 test_expect_success \
@@ -43,9 +47,8 @@ test_expect_success \
 	EOF
 	chmod +x "fake browser" &&
 	git config browser.w3m.path "`pwd`/fake browser" &&
-	git web--browse --browser=w3m \
-		http://example.com/foo >actual &&
-	test_cmp expect actual
+	test_web_browse w3m \
+		http://example.com/foo
 '
 
 test_expect_success \
@@ -58,9 +61,8 @@ test_expect_success \
 			done
 		}
 		f" &&
-	git web--browse --browser=custom \
-		http://example.com/foo >actual &&
-	test_cmp expect actual
+	test_web_browse custom \
+		http://example.com/foo
 '
 
 test_done
-- 
1.7.7.1.gbba15
