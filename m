Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16CB71FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 16:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbcF3Qt7 (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 12:49:59 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:50520 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752216AbcF3Qt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 12:49:56 -0400
Received: (qmail 7090 invoked from network); 30 Jun 2016 16:49:38 -0000
Received: (qmail 29951 invoked from network); 30 Jun 2016 16:49:38 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 30 Jun 2016 16:49:36 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] t5541: become resilient to GETTEXT_POISON
Date:	Thu, 30 Jun 2016 16:49:18 +0000
Message-Id: <1467305358-12440-1-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1467304470-27781-1-git-send-email-vascomalmeida@sapo.pt>
References: <1467304470-27781-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Use test_i18n* functions for testing text already marked for
translation.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
Fix typo on v1.
Forgot to mention that tests with TTY prerequisite were skipped, I don't
know how to run them.

Notes:
    Incremental update for va/i18n-even-more (merged to 'next' on 2016-06-28 at
    5919dfa).
    
    I don't know how I didn't catch this one.

 t/t5541-http-push-smart.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index fd7d06b..ca6becf 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -119,7 +119,7 @@ test_expect_success 'rejected update prints status' '
 	git commit -m dev2 &&
 	test_must_fail git push origin dev2 2>act &&
 	sed -e "/^remote: /s/ *$//" <act >cmp &&
-	test_cmp exp cmp
+	test_i18ncmp exp cmp
 '
 rm -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
 
@@ -219,7 +219,7 @@ test_expect_success TTY 'push shows progress when stderr is a tty' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit noisy &&
 	test_terminal git push >output 2>&1 &&
-	grep "^Writing objects" output
+	test_i18ngrep "^Writing objects" output
 '
 
 test_expect_success TTY 'push --quiet silences status and progress' '
@@ -233,16 +233,16 @@ test_expect_success TTY 'push --no-progress silences progress but not status' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit no-progress &&
 	test_terminal git push --no-progress >output 2>&1 &&
-	grep "^To http" output &&
-	! grep "^Writing objects"
+	test_i18ngrep "^To http" output &&
+	test_i18ngrep ! "^Writing objects"
 '
 
 test_expect_success 'push --progress shows progress to non-tty' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit progress &&
 	git push --progress >output 2>&1 &&
-	grep "^To http" output &&
-	grep "^Writing objects" output
+	test_i18ngrep "^To http" output &&
+	test_i18ngrep "^Writing objects" output
 '
 
 test_expect_success 'http push gives sane defaults to reflog' '
-- 
2.7.4

