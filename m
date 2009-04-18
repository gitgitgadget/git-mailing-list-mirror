From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] init: Do not segfault on big GIT_TEMPLATE_DIR environment variable
Date: Sat, 18 Apr 2009 16:14:02 +0200
Message-ID: <1240064042-22539-1-git-send-email-frank@lichtenheld.de>
Cc: git@vger.kernel.org, Frank Lichtenheld <flichtenheld@astaro.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 18 16:31:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvBa3-0000kn-3w
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 16:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800AbZDRO33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 10:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758542AbZDRO33
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 10:29:29 -0400
Received: from aiolos.lenk.info ([85.214.124.154]:49989 "EHLO aiolos.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758772AbZDRO32 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 10:29:28 -0400
X-Greylist: delayed 927 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Apr 2009 10:29:28 EDT
Received: from mail.lenk.info ([78.47.143.197] ident=Debian-exim)
	by mx.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1LvBIt-0001vX-TB; Sat, 18 Apr 2009 16:13:59 +0200
Received: from p57b2734b.dip.t-dialin.net ([87.178.115.75] helo=penrose.djpig.de)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1LvBIq-00082U-Do; Sat, 18 Apr 2009 16:13:56 +0200
Received: from flichtenheld by penrose.djpig.de with local (Exim 4.69)
	(envelope-from <flichtenheld@astaro.com>)
	id 1LvBIw-0005s0-Jj; Sat, 18 Apr 2009 16:14:02 +0200
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116826>

From: Frank Lichtenheld <flichtenheld@astaro.com>

Signed-off-by: Frank Lichtenheld <flichtenheld@astaro.com>
---
 builtin-init-db.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 4e02b33..d1fa12a 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -122,8 +122,10 @@ static void copy_templates(const char *template_dir)
 		template_dir = system_path(DEFAULT_GIT_TEMPLATE_DIR);
 	if (!template_dir[0])
 		return;
+	template_len = strlen(template_dir);
+	if (PATH_MAX <= (template_len+strlen("/config")))
+		die("insanely long template path %s", template_dir);
 	strcpy(template_path, template_dir);
-	template_len = strlen(template_path);
 	if (template_path[template_len-1] != '/') {
 		template_path[template_len++] = '/';
 		template_path[template_len] = 0;
-- 
1.6.2.1
