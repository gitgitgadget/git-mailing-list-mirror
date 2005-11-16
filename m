From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix compilation of git.c
Date: Wed, 16 Nov 2005 02:44:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511160243360.14176@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Nov 16 02:45:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcCLV-0007bs-K4
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 02:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVKPBoO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 20:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVKPBoO
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 20:44:14 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:29067 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932565AbVKPBoN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 20:44:13 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9EAB513F8C9; Wed, 16 Nov 2005 02:44:12 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 86B379F309; Wed, 16 Nov 2005 02:44:12 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 72E109F2E3; Wed, 16 Nov 2005 02:44:12 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5906F13F8C9; Wed, 16 Nov 2005 02:44:12 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11985>


Some systems do not define GLOB_ABORTED and GLOB_NOMATCH.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

applies-to: c20dc1194fcfa73a7bf6e9d315c878d4f8c2828a
57cce66195a824221c0e9517ff4999daf2fbe2d2
diff --git a/git.c b/git.c
index 583923d..30b3c04 100644
--- a/git.c
+++ b/git.c
@@ -77,13 +77,17 @@ static void list_commands(const char *ex
 	case GLOB_NOSPACE:
 		puts("Out of memory when running glob()");
 		exit(2);
+#ifdef GLOB_ABORTED
 	case GLOB_ABORTED:
 		printf("'%s': Read error: %s\n", exec_path, strerror(errno));
 		exit(2);
+#endif
+#ifdef GLOB_NOMATCH
 	case GLOB_NOMATCH:
 		printf("No git commands available in '%s'.\n", exec_path);
 		printf("Do you need to specify --exec-path or set GIT_EXEC_PATH?\n");
 		exit(1);
+#endif
 	}
 
 	for (i = 0; i < gl.gl_pathc; i++) {
---
0.99.9.GIT
