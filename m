From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-config: print error message if the config file cannot be read
Date: Tue, 9 Oct 2007 12:51:02 +0000
Message-ID: <20071009125102.1305.qmail@054bd0fc8effa5.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 14:51:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEYo-000438-65
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 14:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184AbXJIMun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 08:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755159AbXJIMum
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 08:50:42 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:56385 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755095AbXJIMul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 08:50:41 -0400
Received: (qmail 1306 invoked by uid 1000); 9 Oct 2007 12:51:02 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60398>

Instead of simply exiting with 255, print an error message including
the reason why the config file cannot be opened or read.

The problem was noticed by Joey Hess, reported through
 http://bugs.debian.org/445208

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 builtin-config.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 1bb0ebb..750a403 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -235,8 +235,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		argv++;
 	}
 
-	if (show_all)
-		return git_config(show_all_config);
+	if (show_all) {
+		if (git_config(show_all_config) == -1)
+			die("unable to read config file %s: %s",
+			    getenv(CONFIG_ENVIRONMENT), strerror(errno));
+		return 0;
+	}
 	switch (argc) {
 	case 2:
 		return get_value(argv[1], NULL);
-- 
1.5.3.4
