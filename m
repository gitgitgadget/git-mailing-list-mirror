From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Documentation: update tar.umask default
Date: Wed, 22 Aug 2007 23:03:18 +0200
Message-ID: <46CCA496.2020101@lsrfire.ath.cx>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <20070820174142.GA7943@glandium.org> <46CB286C.8000403@lsrfire.ath.cx> <20070821211526.GA12483@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	git discussion list <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 23:04:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INxMt-0004d3-L4
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 23:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbXHVVDZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 17:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbXHVVDZ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 17:03:25 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:53048
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932434AbXHVVDY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 17:03:24 -0400
Received: from [10.0.1.201] (p508ED4CF.dip.t-dialin.net [80.142.212.207])
	by neapel230.server4you.de (Postfix) with ESMTP id 935378B008;
	Wed, 22 Aug 2007 23:03:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070821211526.GA12483@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56420>

Mike Hommey schrieb:
> Actually, I'd say it's not enough ; users may be confused by the
> sentence just above:
> 
> By default, file and directories modes are set to 0666 or 0777 in tar
> archives.
> 
> Which is true, but if you are not very familiar with umask, you won't
> actually gather from the rest that the modes are not going to be that by
> default.

Hmm.  And I forgot to update two other places.  How about this?  Too short?

 Documentation/config.txt       |   14 +++++---------
 Documentation/git-archive.txt  |   15 ++++++---------
 Documentation/git-tar-tree.txt |   15 ++++++---------
 3 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 46f40ad..462595c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -675,15 +675,11 @@ showbranch.default::
 	See gitlink:git-show-branch[1].
 
 tar.umask::
-	By default, gitlink:git-tar-tree[1] sets file and directories modes
-	to 0666 or 0777. While this is both useful and acceptable for projects
-	such as the Linux Kernel, it might be excessive for other projects.
-	With this variable, it becomes possible to tell
-	gitlink:git-tar-tree[1] to apply a specific umask to the modes above.
-	The special value "user" indicates that the user's current umask will
-	be used. This should be enough for most projects, as it will lead to
-	the same permissions as gitlink:git-checkout[1] would use. The default
-	value remains 0, which means world read-write.
+	This variable can be used to restrict the permission bits of
+	tar archive entries.  The default is 0002, which turns off the
+	world write bit.  The special value "user" indicates that the
+	archiving user's umask will be used instead.  See umask(2) and
+	gitlink:git-archive[1].
 
 user.email::
 	Your email address to be recorded in any newly created commits.
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 4da07c1..f2080eb 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -72,16 +72,13 @@ zip
 
 CONFIGURATION
 -------------
-By default, file and directories modes are set to 0666 or 0777 in tar
-archives.  It is possible to change this by setting the "umask" variable
-in the repository configuration as follows :
 
-[tar]
-        umask = 002	;# group friendly
-
-The special umask value "user" indicates that the user's current umask
-will be used instead. The default value remains 0, which means world
-readable/writable files and directories.
+tar.umask::
+	This variable can be used to restrict the permission bits of
+	tar archive entries.  The default is 0002, which turns off the
+	world write bit.  The special value "user" indicates that the
+	archiving user's umask will be used instead.  See umask(2) for
+	details.
 
 EXAMPLES
 --------
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 2d01d96..434607b 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -42,16 +42,13 @@ OPTIONS
 
 CONFIGURATION
 -------------
-By default, file and directories modes are set to 0666 or 0777. It is
-possible to change this by setting the "umask" variable in the
-repository configuration as follows :
 
-[tar]
-        umask = 002	;# group friendly
-
-The special umask value "user" indicates that the user's current umask
-will be used instead.  The default value is 002, which means group
-readable/writable files and directories.
+tar.umask::
+	This variable can be used to restrict the permission bits of
+	tar archive entries.  The default is 0002, which turns off the
+	world write bit.  The special value "user" indicates that the
+	archiving user's umask will be used instead.  See umask(2) for
+	details.
 
 EXAMPLES
 --------
