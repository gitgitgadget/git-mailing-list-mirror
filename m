From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH 19/21] t9003: become resilient to GETTEXT_POISON
Date: Wed, 18 May 2016 15:27:52 +0000
Message-ID: <1463585274-9027-20-git-send-email-vascomalmeida@sapo.pt>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 17:31:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b33RE-0001jN-N1
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 17:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbcERPbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 11:31:03 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:41798 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751895AbcERPbB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 11:31:01 -0400
Received: (qmail 9836 invoked from network); 18 May 2016 15:30:54 -0000
Received: (qmail 1230 invoked from network); 18 May 2016 15:30:54 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 18 May 2016 15:30:49 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294960>

The test t9003-help-autocorrect.sh fails when run under GETTEXT_POISON,
because it's expecting to filter out the original output. Accommodate
gettext poison case by also filtering out the default simulated output.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 t/t9003-help-autocorrect.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index dfe95c9..f6f6c92 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -31,10 +31,14 @@ test_expect_success 'autocorrect showing candidates' '
 	git config help.autocorrect 0 &&
 
 	test_must_fail git lfg 2>actual &&
-	sed -e "1,/^Did you mean this/d" actual | grep lgf &&
+	sed -e "1,/^Did you mean this/d" actual |
+	sed -e "/GETTEXT POISON/d" actual |
+	grep lgf &&
 
 	test_must_fail git distimdist 2>actual &&
-	sed -e "1,/^Did you mean this/d" actual | grep distimdistim
+	sed -e "1,/^Did you mean this/d" actual |
+	sed -e "/GETTEXT POISON/d" actual |
+	grep distimdistim
 '
 
 test_expect_success 'autocorrect running commands' '
-- 
2.7.3
