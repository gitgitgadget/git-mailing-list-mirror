From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 5/5] stash -p: demonstrate failure of split with mixed y/n
Date: Thu, 16 Apr 2015 09:02:31 +0200
Message-ID: <1429167751-19398-6-git-send-email-Matthieu.Moy@imag.fr>
References: <1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
 <1429167751-19398-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Tanky Woo <wtq1990@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 16 09:03:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YidpW-0004EB-JQ
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 09:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756923AbbDPHDC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 03:03:02 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33540 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932281AbbDPHC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 03:02:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t3G72g8c029345
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 16 Apr 2015 09:02:42 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3G72h7x021235;
	Thu, 16 Apr 2015 09:02:43 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Yidow-0005Ch-Uy; Thu, 16 Apr 2015 09:02:42 +0200
X-Mailer: git-send-email 2.4.0.rc1.42.g9642cc6
In-Reply-To: <1429167751-19398-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 16 Apr 2015 09:02:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3G72g8c029345
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1429772564.32221@Jl0UmNOdz76cAtxM/6B1jQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267258>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t3904-stash-patch.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index 0f8f47f..38e7300 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -81,4 +81,27 @@ test_expect_success 'none of this moved HEAD' '
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
+	printf "%s\n" s n y q |
+	test_might_fail git stash -p 2>error &&
+	! test_must_be_empty error &&
+	grep "added line 1" test &&
+	! grep "added line 2" test
+'
+
 test_done
-- 
2.4.0.rc1.42.g9642cc6
