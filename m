From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] t3203: test 'detached at' after checkout --detach
Date: Sun, 27 Sep 2015 17:13:41 +0200
Message-ID: <1443366822-1753-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 27 17:14:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgDeZ-0001wi-69
	for gcvg-git-2@plane.gmane.org; Sun, 27 Sep 2015 17:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088AbbI0POK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2015 11:14:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55985 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755952AbbI0POJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2015 11:14:09 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8RFE08K004310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 27 Sep 2015 17:14:00 +0200
Received: from estrop.imag.fr (estrop.imag.fr [129.88.7.56])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8RFE2wR011737;
	Sun, 27 Sep 2015 17:14:02 +0200
Received: from moy by estrop.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZgDeM-0000V3-Fd; Sun, 27 Sep 2015 17:14:02 +0200
X-Mailer: git-send-email 2.5.0.402.g8854c44
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 27 Sep 2015 17:14:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8RFE08K004310
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1443971642.54458@1n4xaqSTJP9N3FN11qmSBA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278706>

This currently fails: the output is 'HEAD detached at HEAD'.
---
 t/t3203-branch-output.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index f51d0f3..bf24dbf 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -106,6 +106,19 @@ EOF
 	test_i18ncmp expect actual
 '
 
+test_expect_failure 'git branch shows detached HEAD properly after checkout --detach' '
+	git checkout master &&
+	cat >expect <<EOF &&
+* (HEAD detached at $(git rev-parse --short HEAD^0))
+  branch-one
+  branch-two
+  master
+EOF
+	git checkout --detach &&
+	git branch >actual &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'git branch shows detached HEAD properly after moving' '
 	cat >expect <<EOF &&
 * (HEAD detached from $(git rev-parse --short HEAD))
-- 
2.5.0.402.g8854c44
