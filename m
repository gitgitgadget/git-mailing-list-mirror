From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 1/5] remove_subtree(): Use strerror() when possible
Date: Wed, 25 Apr 2007 11:17:56 -0300
Organization: Mandriva
Message-ID: <20070425111756.2fb2e870@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Apr 25 16:18:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgiKL-00042K-GD
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 16:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613AbXDYOSA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 10:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754611AbXDYOSA
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 10:18:00 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:46393 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613AbXDYOR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 10:17:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id E030817AE1;
	Wed, 25 Apr 2007 11:17:57 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id yoRA9+MlSkhv; Wed, 25 Apr 2007 11:17:57 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 9B7B317AE0;
	Wed, 25 Apr 2007 11:17:57 -0300 (BRT)
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45527>

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
 entry.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index 84f7802..b51addb 100644
--- a/entry.c
+++ b/entry.c
@@ -33,7 +33,7 @@ static void remove_subtree(const char *path)
 	char *name;
 	
 	if (!dir)
-		die("cannot opendir %s", path);
+		die("cannot opendir %s (%s)", path, strerror(errno));
 	strcpy(pathbuf, path);
 	name = pathbuf + strlen(path);
 	*name++ = '/';
@@ -45,15 +45,15 @@ static void remove_subtree(const char *path)
 			continue;
 		strcpy(name, de->d_name);
 		if (lstat(pathbuf, &st))
-			die("cannot lstat %s", pathbuf);
+			die("cannot lstat %s (%s)", pathbuf, strerror(errno));
 		if (S_ISDIR(st.st_mode))
 			remove_subtree(pathbuf);
 		else if (unlink(pathbuf))
-			die("cannot unlink %s", pathbuf);
+			die("cannot unlink %s (%s)", pathbuf, strerror(errno));
 	}
 	closedir(dir);
 	if (rmdir(path))
-		die("cannot rmdir %s", path);
+		die("cannot rmdir %s (%s)", path, strerror(errno));
 }
 
 static int create_file(const char *path, unsigned int mode)
-- 
1.5.1.1.320.g1cf2
