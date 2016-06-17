Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7691FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbcFQUYe (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:34 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:60176 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964897AbcFQUYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:32 -0400
Received: (qmail 21728 invoked from network); 17 Jun 2016 20:24:31 -0000
Received: (qmail 8013 invoked from network); 17 Jun 2016 20:24:31 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:30 -0000
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
Subject: [PATCH v5 22/38] t5523: use test_i18ngrep for negation
Date:	Fri, 17 Jun 2016 20:21:11 +0000
Message-Id: <1466194887-18236-23-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Replace the first form with the second one:

	! grep expected actual
	test_i18ngrep ! expected actual

The latter syntax is supported by test_i18ngrep defined in
t/test-lib.sh.

Although the test already passes whether GETTEXT_POSION is enabled, use
the i18n grep variant for the sake of consistency and also to make
obvious that those strings are subject to i18n.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 t/t5523-push-upstream.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 4a7b98b..d6981ba 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -83,7 +83,7 @@ test_expect_success 'progress messages do not go to non-tty' '
 
 	# skip progress messages, since stderr is non-tty
 	git push -u upstream master >out 2>err &&
-	! grep "Writing objects" err
+	test_i18ngrep ! "Writing objects" err
 '
 
 test_expect_success 'progress messages go to non-tty (forced)' '
@@ -98,15 +98,15 @@ test_expect_success TTY 'push -q suppresses progress' '
 	ensure_fresh_upstream &&
 
 	test_terminal git push -u -q upstream master >out 2>err &&
-	! grep "Writing objects" err
+	test_i18ngrep ! "Writing objects" err
 '
 
 test_expect_success TTY 'push --no-progress suppresses progress' '
 	ensure_fresh_upstream &&
 
 	test_terminal git push -u --no-progress upstream master >out 2>err &&
-	! grep "Unpacking objects" err &&
-	! grep "Writing objects" err
+	test_i18ngrep ! "Unpacking objects" err &&
+	test_i18ngrep ! "Writing objects" err
 '
 
 test_expect_success TTY 'quiet push' '
-- 
2.6.6

