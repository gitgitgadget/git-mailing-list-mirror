From: Junio C Hamano <junkio@cox.net>
Subject: git.c: two fixes, gitsetenv type and off-by-one error.
Date: Sun, 04 Dec 2005 15:03:13 -0800
Message-ID: <7vhd9oea8e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Dec 05 00:05:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ej2t5-0006iX-Fu
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 00:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVLDXDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 18:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVLDXDQ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 18:03:16 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:49084 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751099AbVLDXDP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2005 18:03:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051204230233.LHLF20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Dec 2005 18:02:33 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13196>

gitsetenv as implemented in compat/setenv.c takes two const char*
and int; match that.

Also fix an incorrect attempt in prepend_to_path() to
NUL-terminate the string which stuffed the NUL character at one
past the end of allocation, and was not needed to begin with (we
copy the old_path string including the NUL which terminates it).

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

9a79c5a8b4e280601bcbeeed22e1e4968d06c10e
diff --git a/git.c b/git.c
index 619f25a..0975fc7 100644
--- a/git.c
+++ b/git.c
@@ -14,7 +14,7 @@
 #endif
 
 #ifdef NO_SETENV
-extern int gitsetenv(char *name, char *value, int overwrite);
+extern int gitsetenv(const char *, const char *, int);
 #endif
 
 static const char git_usage[] =
@@ -192,7 +192,6 @@ static void prepend_to_path(const char *
 	path_len = len + strlen(old_path) + 1;
 
 	path = malloc(path_len + 1);
-	path[path_len + 1] = '\0';
 
 	memcpy(path, dir, len);
 	path[len] = ':';
-- 
0.99.9.GIT
