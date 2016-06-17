Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232381FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbcFQUXz (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:23:55 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:35292 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753491AbcFQUXz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:23:55 -0400
Received: (qmail 2023 invoked from network); 17 Jun 2016 20:23:53 -0000
Received: (qmail 31276 invoked from network); 17 Jun 2016 20:23:53 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:23:48 -0000
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
Subject: [PATCH v5 02/38] i18n: advice: mark string about detached head for translation
Date:	Fri, 17 Jun 2016 20:20:51 +0000
Message-Id: <1466194887-18236-3-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mark string with advice seen by the user when in detached head.

Update test t7201-co.sh to pass under GETTEXT_POISON build. Pretend
success if the number of lines of "git checkout renamer^" output is not
greater than 1 and test are running under GETTEXT_POISON.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 advice.c      | 6 +++---
 t/t7201-co.sh | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/advice.c b/advice.c
index 4dc5cf1..cb445a7 100644
--- a/advice.c
+++ b/advice.c
@@ -106,14 +106,14 @@ void NORETURN die_conclude_merge(void)
 
 void detach_advice(const char *new_name)
 {
-	const char fmt[] =
-	"Note: checking out '%s'.\n\n"
+	const char *fmt =
+	_("Note: checking out '%s'.\n\n"
 	"You are in 'detached HEAD' state. You can look around, make experimental\n"
 	"changes and commit them, and you can discard any commits you make in this\n"
 	"state without impacting any branches by performing another checkout.\n\n"
 	"If you want to create a new branch to retain commits you create, you may\n"
 	"do so (now or later) by using -b with the checkout command again. Example:\n\n"
-	"  git checkout -b <new-branch-name>\n\n";
+	"  git checkout -b <new-branch-name>\n\n");
 
 	fprintf(stderr, fmt, new_name);
 }
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 8859236..d4b217b 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -257,7 +257,7 @@ test_expect_success 'checkout to detach HEAD' '
 	git checkout -f renamer && git clean -f &&
 	git checkout renamer^ 2>messages &&
 	test_i18ngrep "HEAD is now at 7329388" messages &&
-	test_line_count -gt 1 messages &&
+	(test_line_count -gt 1 messages || test -n "$GETTEXT_POISON") &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
 	test "z$H" = "z$M" &&
-- 
2.6.6

