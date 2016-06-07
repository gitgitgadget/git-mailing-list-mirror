From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 34/38] i18n: init-db: join message pieces
Date: Tue,  7 Jun 2016 12:55:37 +0000
Message-ID: <1465304141-9392-5-git-send-email-vascomalmeida@sapo.pt>
References: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 14:56:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAGY6-00071R-Vw
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 14:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862AbcFGMz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 08:55:59 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:50557 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754852AbcFGMz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 08:55:58 -0400
Received: (qmail 28696 invoked from network); 7 Jun 2016 12:55:56 -0000
Received: (qmail 12996 invoked from network); 7 Jun 2016 12:55:56 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 12:55:50 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296670>

Join message displayed during repository initialization in one entire
sentence. That would improve translations since it's easier translate an
entire sentence than translating each piece.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/init-db.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index b2d8d40..3a45f0b 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -397,13 +397,16 @@ int init_db(const char *template_dir, unsigned int flags)
 	if (!(flags & INIT_DB_QUIET)) {
 		int len = strlen(git_dir);
 
-		/* TRANSLATORS: The first '%s' is either "Reinitialized
-		   existing" or "Initialized empty", the second " shared" or
-		   "", and the last '%s%s' is the verbatim directory name. */
-		printf(_("%s%s Git repository in %s%s\n"),
-		       reinit ? _("Reinitialized existing") : _("Initialized empty"),
-		       get_shared_repository() ? _(" shared") : "",
-		       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
+		if (reinit)
+			printf(get_shared_repository()
+			       ? _("Reinitialized existing shared Git repository in %s%s\n")
+			       : _("Reinitialized existing Git repository in %s%s\n"),
+			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
+		else
+			printf(get_shared_repository()
+			       ? _("Initialized empty shared Git repository in %s%s\n")
+			       : _("Initialized empty Git repository in %s%s\n"),
+			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
 	}
 
 	return 0;
-- 
2.7.3
