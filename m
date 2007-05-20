From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] t1300: Add tests for git-config --bool --get
Date: Mon, 21 May 2007 00:12:57 +0200
Message-ID: <11796991783280-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 21 00:13:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpteH-0004oZ-J5
	for gcvg-git@gmane.org; Mon, 21 May 2007 00:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbXETWND (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 18:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756831AbXETWNC
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 18:13:02 -0400
Received: from mail.lenk.info ([217.160.134.107]:1254 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbXETWNB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 18:13:01 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hptcd-00025a-7J; Mon, 21 May 2007 00:11:27 +0200
Received: from p54b0cecc.dip.t-dialin.net ([84.176.206.204] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1Hpte6-0004c4-5M; Mon, 21 May 2007 00:12:58 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1Hpte6-0002Uh-Dd; Mon, 21 May 2007 00:12:58 +0200
X-Mailer: git-send-email 1.5.2-rc3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47934>

Noticed that there were only tests for --int, but not
for --bool. Add some.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 t/t1300-repo-config.sh |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index a1d777c..3f3fd2d 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -436,6 +436,40 @@ test_expect_success numbers '
 	test z1048576 = "z$m"
 '
 
+cat > expect << EOF
+true
+false
+true
+false
+true
+false
+true
+false
+EOF
+
+test_expect_success bool '
+
+	git-config bool.true1 01 &&
+	git-config bool.true2 -1 &&
+	git-config bool.true3 YeS &&
+	git-config bool.true4 true &&
+	git-config bool.false1 000 &&
+	git-config bool.false2 "" &&
+	git-config bool.false3 nO &&
+	git-config bool.false4 FALSE &&
+	rm -f result &&
+	for i in 1 2 3 4
+	do
+	    git-config --bool --get bool.true$i >>result
+	    git-config --bool --get bool.false$i >>result
+        done &&
+	cmp expect result'
+
+test_expect_failure 'invalid bool' '
+
+	git-config bool.nobool foobar &&
+	git-config --bool --get bool.nobool'
+
 rm .git/config
 
 git-config quote.leading " test"
-- 
1.5.2-rc3.GIT
