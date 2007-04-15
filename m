From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH] entry.c: Use strerror() to print error info when possible
Date: Sun, 15 Apr 2007 18:56:19 -0300
Organization: Mandriva
Message-ID: <20070415185619.3fa90f3a@gnut>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 23:56:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdCi4-00056k-PY
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 23:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbXDOV41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 17:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754000AbXDOV41
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 17:56:27 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:42788 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689AbXDOV40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 17:56:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 345FE18B25;
	Sun, 15 Apr 2007 18:56:25 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id 8MFvrX1WWSdB; Sun, 15 Apr 2007 18:56:22 -0300 (BRT)
Received: from gnut (unknown [201.21.180.171])
	by perninha.conectiva.com.br (Postfix) with ESMTP id DDB9018B22;
	Sun, 15 Apr 2007 18:56:21 -0300 (BRT)
X-Mailer: Claws Mail 2.7.2 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44533>


Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
 entry.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/entry.c b/entry.c
index d72f811..c36c09d 100644
--- a/entry.c
+++ b/entry.c
@@ -19,7 +19,8 @@ static void create_directories(const char *path, struct checkout *state)
 				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
 					continue; /* ok */
 			}
-			die("cannot create directory at %s", buf);
+			die("cannot create directory at %s (%s)", buf,
+			    strerror(errno));
 		}
 	}
 	free(buf);
@@ -33,7 +34,7 @@ static void remove_subtree(const char *path)
 	char *name;
 	
 	if (!dir)
-		die("cannot opendir %s", path);
+		die("cannot opendir %s (%s)", path, strerror(errno));
 	strcpy(pathbuf, path);
 	name = pathbuf + strlen(path);
 	*name++ = '/';
@@ -45,15 +46,15 @@ static void remove_subtree(const char *path)
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
1.5.1.1.85.geed2-dirty
