From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH (girocco) 1/3] taskd/clone: Store git-svn refs under svn-origin remote
Date: Sat, 18 Sep 2010 13:58:52 +0400
Message-ID: <4ade10555225aa1bfeb8f3a3ba89580d1aeae99c.1284803429.git.kirr@landau.phys.spbu.ru>
References: <cover.1284803429.git.kirr@landau.phys.spbu.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Andrew Steinborn <g33kdyoo@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
X-From: git-owner@vger.kernel.org Sat Sep 18 11:57:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwuAo-0005f1-GH
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 11:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446Ab0IRJ5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 05:57:25 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:42935 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387Ab0IRJ5X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 05:57:23 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id C8982FF66F; Sat, 18 Sep 2010 13:57:22 +0400 (MSD)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.72)
	(envelope-from <kirr@roro3.zxlink>)
	id 1OwuCK-0002c8-J4; Sat, 18 Sep 2010 13:59:08 +0400
X-Mailer: git-send-email 1.7.3.rc2.1.g63647
In-Reply-To: <cover.1284803429.git.kirr@landau.phys.spbu.ru>
In-Reply-To: <cover.1284803429.git.kirr@landau.phys.spbu.ru>
References: <cover.1284803429.git.kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156446>

Previously git-svn stored everything right under refs/remotes/ , and now
I'm putting svn-mirrored refs under refs/remotes/svn-origin/ .

This makes sense, since it helps debugging svn-mirroring problems - e.g.
at present we don't forward to visible git namespace svn branches at
all.

Cc: Andrew Steinborn <g33kdyoo@gmail.com>
Cc: Miklos Vajna <vmiklos@frugalware.org>
---
 taskd/clone.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/taskd/clone.sh b/taskd/clone.sh
index 9a6409c..8d56e1e 100755
--- a/taskd/clone.sh
+++ b/taskd/clone.sh
@@ -25,13 +25,13 @@ case "$url" in
 	svn://* | svn+http://* | svn+https://*)
 		# we just remote svn+ here, so svn+http://... becomes http://...
 		svnurl="${url#svn+}"
-		GIT_DIR=. git svn init -s "$svnurl"
+		GIT_DIR=. git svn init -s --prefix=svn-origin/ "$svnurl"
 		GIT_DIR=. git svn fetch
 		# Neat Trick suggested by Miklos Vajna
 		GIT_DIR=. git config remote.origin.url .
-		GIT_DIR=. git config remote.origin.fetch '+refs/remotes/heads/*:refs/heads/*'
-		GIT_DIR=. git config --add remote.origin.fetch '+refs/remotes/trunk:refs/heads/master'
-		GIT_DIR=. git config --add remote.origin.fetch '+refs/remotes/tags/*:refs/tags/*'
+		GIT_DIR=. git config remote.origin.fetch '+refs/remotes/svn-origin/heads/*:refs/heads/*'
+		GIT_DIR=. git config --add remote.origin.fetch '+refs/remotes/svn-origin/trunk:refs/heads/master'
+		GIT_DIR=. git config --add remote.origin.fetch '+refs/remotes/svn-origin/tags/*:refs/tags/*'
 		GIT_DIR=. git fetch
 		;;
       	darcs://*)
-- 
1.7.3.rc2.1.g63647
