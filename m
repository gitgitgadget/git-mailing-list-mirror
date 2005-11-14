From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH] git-daemon: --inetd implies --syslog
Date: Mon, 14 Nov 2005 17:41:01 +0100 (CET)
Message-ID: <20051114164101.58A495BF92@nox.op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 14 17:44:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbhOF-0006Gg-5K
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVKNQlD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVKNQlD
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:41:03 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:32963 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751180AbVKNQlC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 11:41:02 -0500
Received: from nox.op5.se (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 82B216BD01
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 17:41:01 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 58A495BF92; Mon, 14 Nov 2005 17:41:01 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11816>


Otherwise nothing is logged anywhere, which is a Bad Thing.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Documentation/git-daemon.txt |    2 +-
 daemon.c                     |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

applies-to: 963d67921d6f65c08d51a8c93811f03274c34703
9fac415ad7ec34c21b20b3c349872304869505df
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 67c5f22..3783858 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -35,7 +35,7 @@ OPTIONS
 	do not have the 'git-daemon-export-ok' file.
 
 --inetd::
-	Have the server run as an inetd service.
+	Have the server run as an inetd service. Implies --syslog.
 
 --port::
 	Listen on an alternative port.
diff --git a/daemon.c b/daemon.c
index c3f8641..50a3396 100644
--- a/daemon.c
+++ b/daemon.c
@@ -627,9 +627,9 @@ int main(int argc, char **argv)
 	}
 
 	if (inetd_mode) {
-		fclose(stderr); //FIXME: workaround
+		log_syslog = 1;
 		return execute();
-	} else {
-		return serve(port);
 	}
+
+	return serve(port);
 }
---
0.99.9.GIT
