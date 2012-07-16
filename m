From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH v2 8/8] t4012: Use test_must_fail instead of if-else
Date: Mon, 16 Jul 2012 22:47:22 +0200
Message-ID: <629b1abf980cd9aac28ae8c55dd52a9124c15b55.1342468069.git.eclipse7@gmx.net>
References: <cover.1342468069.git.eclipse7@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 22:47:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqsCa-0004bk-K9
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 22:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab2GPUra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 16:47:30 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:59264 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752826Ab2GPUr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 16:47:28 -0400
Received: (qmail invoked by alias); 16 Jul 2012 20:47:25 -0000
Received: from p5DC37C42.dip.t-dialin.net (EHLO gmx.net) [93.195.124.66]
  by mail.gmx.net (mp024) with SMTP; 16 Jul 2012 22:47:25 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX1+IExVjIHGIe7FahioXrO9FYPPaJcRzhm/aHXBKYr
	4MsCRxBhF3PkrN
Received: by gmx.net (sSMTP sendmail emulation); Mon, 16 Jul 2012 22:47:22 +0200
Content-Disposition: inline
In-Reply-To: <cover.1342468069.git.eclipse7@gmx.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201576>

Make the code less bulky and easier to read. Also do not overlook
failures like e.g. git failing because of unexpected signals.

Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
---
 t/t4012-diff-binary.sh | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 077870e..ec4deea 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -66,13 +66,7 @@ test_expect_success 'apply --numstat understands diff --binary format' '
 test_expect_success 'apply detecting corrupt patch correctly' '
 	git diff >output &&
 	sed -e "s/-CIT/xCIT/" <output >broken &&
-	if git apply --stat --summary broken 2>detected
-	then
-		echo unhappy - should have detected an error
-		(exit 1)
-	else
-		echo happy
-	fi &&
+	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=`cat detected` &&
 	detected=`expr "$detected" : "fatal.*at line \\([0-9]*\\)\$"` &&
 	detected=`sed -ne "${detected}p" broken` &&
@@ -81,13 +75,7 @@ test_expect_success 'apply detecting corrupt patch correctly' '
 
 test_expect_success 'apply detecting corrupt patch correctly' '
 	git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
-	if git apply --stat --summary broken 2>detected
-	then
-		echo unhappy - should have detected an error
-		(exit 1)
-	else
-		echo happy
-	fi &&
+	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=`cat detected` &&
 	detected=`expr "$detected" : "fatal.*at line \\([0-9]*\\)\$"` &&
 	detected=`sed -ne "${detected}p" broken` &&
-- 
1.7.10.2.552.gaa3bb87
