From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3 2/3] home_config_paths(): let the caller ignore xdg path
Date: Fri, 25 Jul 2014 21:11:35 +0200
Message-ID: <1406315496-10237-2-git-send-email-Matthieu.Moy@imag.fr>
References: <xmqq1tt96yyh.fsf@gitster.dls.corp.google.com>
 <1406315496-10237-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 25 21:11:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAkuH-0005Uv-Ee
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 21:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761078AbaGYTLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 15:11:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52839 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761050AbaGYTLr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 15:11:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6PJBc6W025863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jul 2014 21:11:38 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6PJBeXe023312;
	Fri, 25 Jul 2014 21:11:40 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1XAku4-0002nk-7E; Fri, 25 Jul 2014 21:11:40 +0200
X-Mailer: git-send-email 2.0.2.737.gfb43bde
In-Reply-To: <1406315496-10237-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Jul 2014 21:11:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6PJBc6W025863
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1406920301.21938@/zWtbTkuJo0neK1SRlBKRA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254259>

The caller can signal that it is not interested in learning
the location of $HOME/.gitconfig by passing global=NULL, but
there is no way to decline the path to the configuration
file based on $XDG_CONFIG_HOME.

Allow the caller to pass xdg=NULL to signal that it is not
interested in the XDG location.

Commit-message-by: Junio C Hamano <gitster@pobox.com>
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
