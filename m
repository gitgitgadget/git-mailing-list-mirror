From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] t5403-post-checkout-hook.sh: don't use "==" as test operator
Date: Thu, 04 Oct 2007 18:40:42 +0200
Message-ID: <4705178A.5000905@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Josh England <jjengla@sandia.gov>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Oct 04 18:41:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdTky-0004gF-2b
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 18:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758443AbXJDQkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 12:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758866AbXJDQkv
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 12:40:51 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:49629
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758384AbXJDQkv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2007 12:40:51 -0400
Received: from [10.0.1.201] (p57B7DDE5.dip.t-dialin.net [87.183.221.229])
	by neapel230.server4you.de (Postfix) with ESMTP id BA239873B7;
	Thu,  4 Oct 2007 18:40:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59983>

The POSIXly correct comparison operator of test is "=", not "=="; the
latter is a GNU invention.  Without this patch the script fails (at
least) on Ubuntu 7.04, where /bin/sh is not bash.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 487abf3..823239a 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -39,7 +39,7 @@ test_expect_success 'post-checkout receives the right arguments with HEAD unchan
         old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
         new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
         flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-        test $old = $new -a $flag == 1
+        test $old = $new -a $flag = 1
 '
 
 test_expect_success 'post-checkout runs as expected ' '
@@ -52,7 +52,7 @@ test_expect_success 'post-checkout args are correct with git checkout -b ' '
         old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
         new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
         flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-        test $old = $new -a $flag == 1
+        test $old = $new -a $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args with HEAD changed ' '
@@ -60,7 +60,7 @@ test_expect_success 'post-checkout receives the right args with HEAD changed ' '
         old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
         new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
         flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-        test $old != $new -a $flag == 1
+        test $old != $new -a $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args when not switching branches ' '
@@ -68,7 +68,7 @@ test_expect_success 'post-checkout receives the right args when not switching br
         old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
         new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
         flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-        test $old == $new -a $flag == 0
+        test $old = $new -a $flag = 0
 '
 
 test_done
