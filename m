From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC PATCH 2/3] home_config_path: allow NULL xdg parameter
Date: Fri, 25 Jul 2014 15:44:50 +0200
Message-ID: <1406295891-7316-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 15:45:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAfoC-0006EV-UX
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 15:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759870AbaGYNpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 09:45:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46610 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752233AbaGYNpI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 09:45:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6PDirpC025313
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jul 2014 15:44:53 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6PDisqv020230;
	Fri, 25 Jul 2014 15:44:54 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1XAfnq-0002Gh-OR; Fri, 25 Jul 2014 15:44:54 +0200
X-Mailer: git-send-email 2.0.2.737.gfb43bde
In-Reply-To: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Jul 2014 15:44:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6PDirpC025313
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1406900695.4286@V4/s92HQwU3hlhgwCZZK7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254220>

This allows a caller to requst the global config file without requesting
the XDG one.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This is actually not needed, but I wrote this for a previous version,
and it seems sensible anyway.

 path.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/path.c b/path.c
index 3afcdb4..f68df0c 100644
--- a/path.c
+++ b/path.c
@@ -148,10 +148,12 @@ void home_config_paths(char **global, char **xdg, char *file)
 			*global = mkpathdup("%s/.gitconfig", home);
 	}
 
-	if (!xdg_home)
-		*xdg = NULL;
-	else
-		*xdg = mkpathdup("%s/git/%s", xdg_home, file);
+	if (xdg) {
+		if (!xdg_home)
+			*xdg = NULL;
+		else
+			*xdg = mkpathdup("%s/git/%s", xdg_home, file);
+	}
 
 	free(to_free);
 }
-- 
2.0.2.737.gfb43bde
