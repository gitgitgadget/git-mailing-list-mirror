From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/4] stash -p: demonstrate failure of split with mixed y/n
Date: Tue, 14 Apr 2015 13:32:48 +0200
Message-ID: <1429011168-23216-5-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq7ftfkpue.fsf@anie.imag.fr>
 <1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 14 13:33:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhz5q-0001p1-E7
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 13:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbbDNLdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 07:33:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38770 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753785AbbDNLdD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 07:33:03 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t3EBWvCi011015
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 14 Apr 2015 13:32:57 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3EBWwtw010344;
	Tue, 14 Apr 2015 13:32:58 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Yhz5O-0006Fn-JG; Tue, 14 Apr 2015 13:32:58 +0200
X-Mailer: git-send-email 2.4.0.rc1.42.g9642cc6
In-Reply-To: <1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 14 Apr 2015 13:32:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3EBWvCi011015
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1429615979.01067@05WpqSdQe8gNFXAQSw1bVw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267134>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t3904-stash-patch.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index 0f8f47f..6f053ff 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -81,4 +81,30 @@ test_expect_success 'none of this moved HEAD' '
 	verify_saved_head
 '
 
+test_expect_failure 'stash -p with split hunk' '
+	git reset --hard &&
+	cat >test <<-\EOF &&
+	aaa
+	bbb
+	ccc
+	EOF
+	git add test &&
+	git commit -m "initial" &&
+	cat >test <<-\EOF &&
+	aaa
+	added line 1
+	bbb
+	added line 2
+	ccc
+	EOF
+	for a in s n y q
+	do
+		echo $a
+	done |
+	test_might_fail git stash -p 2>error &&
+	! test_must_be_empty error &&
+	grep "added line 1" test &&
+	! grep "added line 2" test
+'
+
 test_done
-- 
2.4.0.rc1.42.g9642cc6
