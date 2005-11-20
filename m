From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] merge-recursive::removeFile: remove empty directories
Date: Sat, 19 Nov 2005 20:14:48 -0800
Message-ID: <7vy83k2bwn.fsf@assigned-by-dhcp.cox.net>
References: <17279.1674.22992.607091@cargo.ozlabs.ibm.com>
	<20051119140736.GA24901@lst.de>
	<Pine.LNX.4.64.0511190957320.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>,
	linuxppc64-dev@ozlabs.org, Git Mailing List <git@vger.kernel.org>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sun Nov 20 05:16:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdgbO-0007tb-3m
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 05:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVKTEOv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 23:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVKTEOv
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 23:14:51 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:37342 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751199AbVKTEOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 23:14:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051120041423.MCRY3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Nov 2005 23:14:23 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12370>

When the last file in a directory is removed as the result of a
merge, try to rmdir the now-empty directory.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 And this is the one for 'git pull -s recursive' which is the
 default these days.

 git-merge-recursive.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

applies-to: ea62f7003bb2769fa23d5ca371d84cee9d2ec46f
80e21a9ed809d98788ff6fb705d911bee37d460b
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index d7d36aa..37258ad 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -293,6 +293,10 @@ def removeFile(clean, path):
         except OSError, e:
             if e.errno != errno.ENOENT and e.errno != errno.EISDIR:
                 raise
+        try:
+            os.removedirs(os.path.dirname(path))
+        except:
+            pass
 
 def uniquePath(path, branch):
     def fileExists(path):
---
0.99.9.GIT
