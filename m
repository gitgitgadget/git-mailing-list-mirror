From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] git-config: don't silently ignore options after --list
Date: Fri,  5 Oct 2007 22:16:44 +0200
Message-ID: <1191615404-32244-1-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 22:17:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdtbR-0001Dm-Vo
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 22:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759703AbXJEUQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 16:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760529AbXJEUQp
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 16:16:45 -0400
Received: from v32413.1blu.de ([88.84.155.73]:57539 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757636AbXJEUQo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 16:16:44 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1IdtbH-0007FJ-8p; Fri, 05 Oct 2007 22:16:43 +0200
Received: from p57b271b3.dip.t-dialin.net ([87.178.113.179] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1IdtbC-0007dc-M8; Fri, 05 Oct 2007 22:16:38 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1IdtbI-0008OI-Ge; Fri, 05 Oct 2007 22:16:44 +0200
X-Mailer: git-send-email 1.5.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60126>

Error out if someone gives options after --list since that is
not a valid syntax.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 builtin-config.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

 Two minutes of my life I don't get back ;)

diff --git a/builtin-config.c b/builtin-config.c
index 0a605e0..cb7e9e9 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -172,8 +172,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			type = T_INT;
 		else if (!strcmp(argv[1], "--bool"))
 			type = T_BOOL;
-		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
+		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l")) {
+			if (argc != 2)
+				usage(git_config_set_usage);
 			return git_config(show_all_config);
+		}
 		else if (!strcmp(argv[1], "--global")) {
 			char *home = getenv("HOME");
 			if (home) {
-- 
1.5.3.4
