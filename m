From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 02/38] i18n: advice: mark string about detached head for translation
Date: Tue,  7 Jun 2016 11:52:01 +0000
Message-ID: <1465300357-7557-3-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:54:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFas-0007al-NO
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbcFGLxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:53:40 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:60855 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754551AbcFGLxg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 07:53:36 -0400
Received: (qmail 26712 invoked from network); 7 Jun 2016 11:53:35 -0000
Received: (qmail 9263 invoked from network); 7 Jun 2016 11:53:35 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 11:53:33 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296644>

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
2.7.3
