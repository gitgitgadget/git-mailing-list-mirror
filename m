From: Matt Draisey <matt@draisey.ca>
Subject: [PATCH] local push/pull env cleanup
Date: Thu, 19 Jan 2006 15:58:03 -0500
Message-ID: <20060119205803.308.78669.stgit@della.draisey.ca>
X-From: git-owner@vger.kernel.org Thu Jan 19 22:03:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezgw7-0001uN-L0
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 22:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWASVDN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 16:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422637AbWASVDN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 16:03:13 -0500
Received: from tomts40.bellnexxia.net ([209.226.175.97]:31361 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1422634AbWASVDM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 16:03:12 -0500
Received: from della.draisey.ca ([70.50.19.33])
          by tomts40-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20060119210303.YHHJ5216.tomts40-srv.bellnexxia.net@della.draisey.ca>
          for <git@vger.kernel.org>; Thu, 19 Jan 2006 16:03:03 -0500
Received: from [127.0.0.1] (helo=della.draisey.ca)
	by della.draisey.ca with esmtp (Exim 4.50)
	id 1Ezgr6-000059-3Y
	for git@vger.kernel.org; Thu, 19 Jan 2006 15:58:04 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14931>

From: Matt Draisey <matt@draisey.ca>

remove environment variables relating to the current repository
before execing the 'remote' half of a local push or pull operation
---

 connect.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/connect.c b/connect.c
index d6f4e4c..50cc879 100644
--- a/connect.c
+++ b/connect.c
@@ -644,8 +644,13 @@ int git_connect(int fd[2], char *url, co
 				ssh_basename++;
 			execlp(ssh, ssh_basename, host, command, NULL);
 		}
-		else
+		else {
+			unsetenv("GIT_DIR");
+			unsetenv("GIT_INDEX_FILE");
+			unsetenv("GIT_OBJECT_DIRECTORY");
+			unsetenv("GIT_ALTERNATE_OBJECT_DIRECTORIES");
 			execlp("sh", "sh", "-c", command, NULL);
+		}
 		die("exec failed");
 	}		
 	fd[0] = pipefd[0][0];
