Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C046320179
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbcFQUYi (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:38 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:60165 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964908AbcFQUYg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:36 -0400
Received: (qmail 21695 invoked from network); 17 Jun 2016 20:24:29 -0000
Received: (qmail 7561 invoked from network); 17 Jun 2016 20:24:29 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:28 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 20/38] t9003: become resilient to GETTEXT_POISON
Date:	Fri, 17 Jun 2016 20:21:09 +0000
Message-Id: <1466194887-18236-21-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.6.6

