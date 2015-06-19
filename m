From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 11/19] fsck: Add a simple test for receive.fsck.<msg-id>
Date: Fri, 19 Jun 2015 15:34:28 +0200
Organization: gmx
Message-ID: <18f00f86adf7f9e8a252e857e60d369270fdbe33.1434720655.git.johannes.schindelin@gmx.de>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 15:34:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wRJ-0000Nq-Sc
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbbFSNee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 09:34:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:56923 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309AbbFSNec (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:34:32 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MDi9C-1ZKnk30aZq-00H6ZL; Fri, 19 Jun 2015 15:34:29
 +0200
In-Reply-To: <cover.1434720655.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:KpIoCG9WNvAi86raCoi1AnjXO+0LFdc4gZBYZzMSxK+QRlflwmE
 rHsBZn8QyihyNQQae9vHbQgGgqGDvPWlGXXidoZNRs/KAGJZC3wLJFB25nvaLoYfc+0mi4/
 UfZ1gCDbouJKv5ArLHtl+OJC12z5vvVv9vcUbglhynWnjCZx8J+zWNiqK/MUdNAkyb0t/4k
 RXyT4sUkECs732iTcHsiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RvqecGO8BsA=:4QZOqr4bs7skGrj/tYuHDm
 5xbc/c9nwPD6gt2UHRcTYrlw60Tv4XpM5qO/CTwHwqyhs0v08pUOHUwQHhDWXxMcEBn5qLJsR
 SkVr76xngqoucw/7F5s2onTXxzNbfS3Gt69Isp8Hxt104ZJogAGTciOZSzMsZ2wAC5kZepb93
 tHmSk3TdGyYsdH4a53vMxsNCWYXjklMU5wP8s21MvA8HQbk2dATcOUGkAXTW5byu3okFQ++2F
 G2tlw8HLxtUKzuH8TXiFmppaEAzG7BKLpmotoHuVonM1YG6QTL35jkkP2w28ycl6UFqu0WUth
 0VPkjPL0BQr8uKGBI3qTF9SsIgp9hWfsW8yA44pWCMmy10okr7JCYLOtN/6GDVbgeo1d65hAp
 aybGj2Xp6ipJACCFlwRHj2EnFUphNTT0yPdtnwg06ei2ATPrx30eoZ07muUlit12GJ63wwyAX
 My+QmUIcZiCrufPThnZKHknCDXvsiDZy0iMhxrpPleHl6PXXNGstldXx6h4yfsBdgVidosGui
 aGZuBCSR6xGIuRUSqlTjSj/TudnUq/fHPOjDRcLdkozhaT+tFnwvJjOPSDM6ulIT21AmfqroV
 g5JMHtNyZbUQkbHRZgT/7ehEl4vkAMPPkU7+zgS7Ctr50jcz0kAPIt5s2KiIrKMicPjvxMM1N
 m4vC2A0vjVPfDh6bh7ySdVQikfYkhzSY6a+BfG1BdSMfJ8wVOOrEXVsMZGoduE1MmoqA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272147>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5504-fetch-receive-strict.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 69ee13c..3f7e96a 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -115,4 +115,25 @@ test_expect_success 'push with transfer.fsckobjects' '
 	test_cmp exp act
 '
 
+cat >bogus-commit <<\EOF
+tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
+author Bugs Bunny 1234567890 +0000
+committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
+
+This commit object intentionally broken
+EOF
+
+test_expect_success 'push with receive.fsck.missingemail=warn' '
+	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
+	git push . $commit:refs/heads/bogus &&
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config receive.fsckobjects true &&
+	test_must_fail git push --porcelain dst bogus &&
+	git --git-dir=dst/.git config \
+		receive.fsck.missingemail warn &&
+	git push --porcelain dst bogus >act 2>&1 &&
+	grep "missingemail" act
+'
+
 test_done
-- 
2.3.1.windows.1.9.g8c01ab4
