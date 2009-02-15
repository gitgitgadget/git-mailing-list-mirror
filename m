From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] builtin-receive-pack.c: fix compiler warnings about format
 string
Date: Sun, 15 Feb 2009 19:18:58 +0100
Message-ID: <1234721938.17613.21.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 19:20:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYlbh-00008a-0g
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 19:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbZBOSTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 13:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753977AbZBOSTH
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 13:19:07 -0500
Received: from india601.server4you.de ([85.25.151.105]:50641 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbZBOSTG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 13:19:06 -0500
Received: from [10.0.1.101] (p57B7DF0C.dip.t-dialin.net [87.183.223.12])
	by india601.server4you.de (Postfix) with ESMTPSA id 8728C2F8057;
	Sun, 15 Feb 2009 19:19:02 +0100 (CET)
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110028>

While all of the strings passed to warning() are, in fact, literals, the
compiler doesn't recognize them as such because it doesn't see through
the loop used to iterate over them:

   builtin-receive-pack.c: In function 'warn_unconfigured_deny':
   builtin-receive-pack.c:247: warning: format not a string literal and no format arguments
   builtin-receive-pack.c: In function 'warn_unconfigured_deny_delete_current':
   builtin-receive-pack.c:273: warning: format not a string literal and no format arguments

Calm the compiler by adding easily recognizable format string literals.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-receive-pack.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index f7e04c4..849f1fe 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -244,7 +244,7 @@ static void warn_unconfigured_deny(void)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(warn_unconfigured_deny_msg); i++)
-		warning(warn_unconfigured_deny_msg[i]);
+		warning("%s", warn_unconfigured_deny_msg[i]);
 }
 
 static char *warn_unconfigured_deny_delete_current_msg[] = {
@@ -270,7 +270,7 @@ static void warn_unconfigured_deny_delete_current(void)
 	for (i = 0;
 	     i < ARRAY_SIZE(warn_unconfigured_deny_delete_current_msg);
 	     i++)
-		warning(warn_unconfigured_deny_delete_current_msg[i]);
+		warning("%s", warn_unconfigured_deny_delete_current_msg[i]);
 }
 
 static const char *update(struct command *cmd)
