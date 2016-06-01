From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 35/39] i18n: init-db: join message pieces
Date: Wed,  1 Jun 2016 18:12:59 +0000
Message-ID: <1464804783-10195-6-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 20:14:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Aej-0006c3-Jm
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 20:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbcFASNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 14:13:43 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:34657 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754961AbcFASNm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 14:13:42 -0400
Received: (qmail 9744 invoked from network); 1 Jun 2016 18:13:35 -0000
Received: (qmail 19705 invoked from network); 1 Jun 2016 18:13:35 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 18:13:30 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296141>

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
