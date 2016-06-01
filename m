From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 20/39] t9003: become resilient to GETTEXT_POISON
Date: Wed,  1 Jun 2016 16:41:10 +0000
Message-ID: <1464799289-7639-21-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 18:44:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89Fz-0005CT-AD
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474AbcFAQoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:44:23 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:49465 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932607AbcFAQoV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:44:21 -0400
Received: (qmail 22702 invoked from network); 1 Jun 2016 16:44:11 -0000
Received: (qmail 25844 invoked from network); 1 Jun 2016 16:44:10 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 16:44:05 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296112>

The test t9003-help-autocorrect.sh fails when run under GETTEXT_POISON,
because it's expecting to filter out the original output. Accommodate
gettext poison case by also filtering out the default simulated output.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 t/t9003-help-autocorrect.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index dfe95c9..b1c7919 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -31,10 +31,10 @@ test_expect_success 'autocorrect showing candidates' '
 	git config help.autocorrect 0 &&
 
 	test_must_fail git lfg 2>actual &&
-	sed -e "1,/^Did you mean this/d" actual | grep lgf &&
+	grep "^	lgf" actual &&
 
 	test_must_fail git distimdist 2>actual &&
-	sed -e "1,/^Did you mean this/d" actual | grep distimdistim
+	grep "^	distimdistim" actual
 '
 
 test_expect_success 'autocorrect running commands' '
-- 
2.7.3
