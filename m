From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fmt-patch: output file names to stdout
Date: Fri, 5 May 2006 03:33:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605050332450.25591@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri May 05 03:33:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbpBx-0001Yk-6R
	for gcvg-git@gmane.org; Fri, 05 May 2006 03:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWEEBdI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 21:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWEEBdI
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 21:33:08 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:62093 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932276AbWEEBdG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 21:33:06 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id B912E1CC4;
	Fri,  5 May 2006 03:33:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id AB59E1CBF;
	Fri,  5 May 2006 03:33:05 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 865041CB8;
	Fri,  5 May 2006 03:33:05 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19592>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 builtin-log.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 576703c..1649f49 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -75,6 +75,8 @@ static int istitlechar(char c)
 		(c >= '0' && c <= '9') || c == '.' || c == '_';
 }
 
+static FILE *realstdout = NULL;
+
 static void reopen_stdout(struct commit *commit, int nr)
 {
 	char filename[1024];
@@ -117,7 +119,7 @@ static void reopen_stdout(struct commit 
 			len--;
 	}
 	strcpy(filename + len, ".txt");
-	fprintf(stderr, "%s\n", filename);
+	fprintf(realstdout, "%s\n", filename);
 	freopen(filename, "w", stdout);
 }
 
@@ -149,6 +151,9 @@ int cmd_format_patch(int argc, const cha
 		argv++;
 	}
 
+	if (!use_stdout)
+		realstdout = fdopen(dup(1), "w");
+
 	prepare_revision_walk(&rev);
 	while ((commit = get_revision(&rev)) != NULL) {
 		/* ignore merges */
-- 
1.3.1.g6d0e-dirty
