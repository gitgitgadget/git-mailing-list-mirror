From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Teach lookup_prog not to select directories
Date: Fri, 18 Jul 2008 09:34:42 +0200
Message-ID: <1216366485-12201-2-git-send-email-johannes.sixt@telecom.at>
References: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Eric Raible <raible@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 09:36:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJkVU-0003a0-ST
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 09:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbYGRHez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 03:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbYGRHev
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 03:34:51 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4679 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbYGRHet (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 03:34:49 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1KJkUI-0002lc-Hf; Fri, 18 Jul 2008 09:34:46 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 12518BF4C; Fri, 18 Jul 2008 09:34:46 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id B871BFA45; Fri, 18 Jul 2008 09:34:45 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.275.g0a3e0f
In-Reply-To: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at>
X-Spam-Score: -1.8 (-)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_50=0.001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89001>

From: Eric Raible <raible@gmail.com>

Without this simple fix "git gui" in the git source directory
finds the git-gui directory instead of the tcl script in /usr/bin.

Signed-off-by: Eric Raible <raible@gmail.com>
Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 3a05fe7..bb33c8d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -536,7 +536,8 @@ static char *lookup_prog(const char *dir, const char *cmd, int isexe, int exe_on
 		return xstrdup(path);
 	path[strlen(path)-4] = '\0';
 	if ((!exe_only || isexe) && access(path, F_OK) == 0)
-		return xstrdup(path);
+		if (!(GetFileAttributes(path) & FILE_ATTRIBUTE_DIRECTORY))
+			return xstrdup(path);
 	return NULL;
 }
 
-- 
1.5.6.1.275.g0a3e0f
