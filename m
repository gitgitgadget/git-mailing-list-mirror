From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 2/3] home_config_path: allow NULL xdg parameter
Date: Fri, 25 Jul 2014 20:00:06 +0200
Message-ID: <1406311207-8276-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1406311207-8276-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 25 20:00:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAjnF-00069U-JO
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 20:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934542AbaGYSA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 14:00:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51710 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933322AbaGYSA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 14:00:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6PI08ks013587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jul 2014 20:00:08 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6PI0Aqv022866;
	Fri, 25 Jul 2014 20:00:10 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1XAjms-0002KK-6d; Fri, 25 Jul 2014 20:00:10 +0200
X-Mailer: git-send-email 2.0.2.737.gfb43bde
In-Reply-To: <1406311207-8276-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Jul 2014 20:00:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6PI08ks013587
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1406916009.00699@7v9QIPrIxNyw98JiOV6e/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254253>

This allows a caller to request the global config file without requesting
the XDG one.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
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
