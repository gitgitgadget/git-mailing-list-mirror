From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] Modify mingw_main() workaround to avoid link errors
Date: Sat, 26 Jul 2008 11:41:44 +0200
Message-ID: <1217065304-27815-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Jul 26 11:43:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMgJZ-0000iB-U6
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 11:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbYGZJmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 05:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbYGZJmk
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 05:42:40 -0400
Received: from mailer.zib.de ([130.73.108.11]:57723 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbYGZJmj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 05:42:39 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6Q9fjqD014640;
	Sat, 26 Jul 2008 11:41:54 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6Q9fi4o026543;
	Sat, 26 Jul 2008 11:41:44 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90202>

With MinGW's

   gcc.exe (GCC) 3.4.5 (mingw special)
   GNU ld version 2.17.50 20060824

the old define caused link errors:

   git.o: In function `main':
   C:/msysgit/git/git.c:500: undefined reference to `mingw_main'
   collect2: ld returned 1 exit status

The modified define works.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 compat/mingw.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 290a9e6..a52e657 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -228,9 +228,10 @@ char **env_setenv(char **env, const char *name);
  * A replacement of main() that ensures that argv[0] has a path
  */
 
-#define main(c,v) main(int argc, const char **argv) \
+#define main(c,v) dummy_decl_mingw_main(); \
+static int mingw_main(); \
+int main(int argc, const char **argv) \
 { \
-	static int mingw_main(); \
 	argv[0] = xstrdup(_pgmptr); \
 	return mingw_main(argc, argv); \
 } \
-- 
1.6.0.rc0.42.g186458
