From: Paul Serice <paul@serice.net>
Subject: [PATCH] git-daemon not listening when compiled with -DNO_IPV6
Date: Mon, 21 Nov 2005 11:07:23 -0600 (CST)
Message-ID: <20051121170723.BDFAF58220@serice.org>
X-From: git-owner@vger.kernel.org Mon Nov 21 18:15:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeF9A-0000XK-1v
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 18:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVKURHn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 12:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVKURHn
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 12:07:43 -0500
Received: from serice.org ([206.123.107.184]:37392 "EHLO serice.org")
	by vger.kernel.org with ESMTP id S932332AbVKURHm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 12:07:42 -0500
Received: from serice.net (localhost [127.0.0.1])
	by serice.org (Postfix) with ESMTP id BDFAF58220
	for <git@vger.kernel.org>; Mon, 21 Nov 2005 11:07:23 -0600 (CST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12459>

git-daemon was not listening when compiled with -DNO_IPV6.
socksetup() was not returning socket count when compiled with -DNO_IPV6.

Signed-off-by: Paul Serice <paul@serice.net>


---

 daemon.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

applies-to: 339319e60db7b3f96f8c711407b135a54da7aa2e
bb8968537a35a635c6f8a6393cff8735b4edcef9
diff --git a/daemon.c b/daemon.c
index 2b81152..e889596 100644
--- a/daemon.c
+++ b/daemon.c
@@ -510,8 +510,14 @@ static int socksetup(int port, int **soc
 		return 0;
 	}
 
+	if (listen(sockfd, 5) < 0) {
+		close(sockfd);
+		return 0;
+	}
+
 	*socklist_p = xmalloc(sizeof(int));
 	**socklist_p = sockfd;
+	return 1;
 }
 
 #endif
---
0.99.9i
