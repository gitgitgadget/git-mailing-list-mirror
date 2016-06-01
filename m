From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 17/39] i18n: setup: mark strings for translation
Date: Wed,  1 Jun 2016 16:41:07 +0000
Message-ID: <1464799289-7639-18-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 18:44:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89Fw-0005CT-RF
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014AbcFAQoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:44:00 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:43551 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161634AbcFAQny (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:43:54 -0400
Received: (qmail 13210 invoked from network); 1 Jun 2016 16:43:52 -0000
Received: (qmail 21540 invoked from network); 1 Jun 2016 16:43:52 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 16:43:50 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296118>

Update tests that compare the strings newly marked for translation to
succeed when running under GETTEXT_POISON.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 setup.c                        | 16 ++++++++--------
 t/t1506-rev-parse-diagnosis.sh |  2 +-
 t/t4208-log-magic-pathspec.sh  |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/setup.c b/setup.c
index c86bf5c..6d0e0c9 100644
--- a/setup.c
+++ b/setup.c
@@ -157,8 +157,8 @@ static void NORETURN die_verify_filename(const char *prefix,
 					 int diagnose_misspelt_rev)
 {
 	if (!diagnose_misspelt_rev)
-		die("%s: no such path in the working tree.\n"
-		    "Use 'git <command> -- <path>...' to specify paths that do not exist locally.",
+		die(_("%s: no such path in the working tree.\n"
+		      "Use 'git <command> -- <path>...' to specify paths that do not exist locally."),
 		    arg);
 	/*
 	 * Saying "'(icase)foo' does not exist in the index" when the
@@ -170,9 +170,9 @@ static void NORETURN die_verify_filename(const char *prefix,
 		maybe_die_on_misspelt_object_name(arg, prefix);
 
 	/* ... or fall back the most general message. */
-	die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
-	    "Use '--' to separate paths from revisions, like this:\n"
-	    "'git <command> [<revision>...] -- [<file>...]'", arg);
+	die(_("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
+	      "Use '--' to separate paths from revisions, like this:\n"
+	      "'git <command> [<revision>...] -- [<file>...]'"), arg);
 
 }
 
@@ -220,9 +220,9 @@ void verify_non_filename(const char *prefix, const char *arg)
 		return; /* flag */
 	if (!check_filename(prefix, arg))
 		return;
-	die("ambiguous argument '%s': both revision and filename\n"
-	    "Use '--' to separate paths from revisions, like this:\n"
-	    "'git <command> [<revision>...] -- [<file>...]'", arg);
+	die(_("ambiguous argument '%s': both revision and filename\n"
+	      "Use '--' to separate paths from revisions, like this:\n"
+	      "'git <command> [<revision>...] -- [<file>...]'"), arg);
 }
 
 int get_common_dir(struct strbuf *sb, const char *gitdir)
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 86c2ff2..79a0251 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -106,7 +106,7 @@ test_expect_success 'incorrect revision id' '
 	test_must_fail git rev-parse foobar:file.txt 2>error &&
 	grep "Invalid object name '"'"'foobar'"'"'." error &&
 	test_must_fail git rev-parse foobar 2> error &&
-	grep "unknown revision or path not in the working tree." error
+	test_i18ngrep "unknown revision or path not in the working tree." error
 '
 
 test_expect_success 'incorrect file in sha1:path' '
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index d8f23f4..001343e 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -18,7 +18,7 @@ test_expect_success '"git log :/" should not be ambiguous' '
 test_expect_success '"git log :/a" should be ambiguous (applied both rev and worktree)' '
 	: >a &&
 	test_must_fail git log :/a 2>error &&
-	grep ambiguous error
+	test_i18ngrep ambiguous error
 '
 
 test_expect_success '"git log :/a -- " should not be ambiguous' '
@@ -31,7 +31,7 @@ test_expect_success '"git log -- :/a" should not be ambiguous' '
 
 test_expect_success '"git log :" should be ambiguous' '
 	test_must_fail git log : 2>error &&
-	grep ambiguous error
+	test_i18ngrep ambiguous error
 '
 
 test_expect_success 'git log -- :' '
-- 
2.7.3
