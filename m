From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 06/10] user-manual: move howto/make-dist.txt into user manual
Date: Mon, 14 May 2007 11:21:25 -0400
Message-ID: <49302.2146904424$1179156138@news.gmane.org>
References: <11791560893572-git-send-email->
 <1179156089759-git-send-email->
 <11791560893022-git-send-email->
 <11791560891179-git-send-email->
 <1179156089470-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 17:22:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HncNJ-0006P0-Hp
	for gcvg-git@gmane.org; Mon, 14 May 2007 17:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860AbXENPVr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 11:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756848AbXENPVq
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 11:21:46 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54965 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755513AbXENPVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 11:21:32 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HncMb-0004zA-VT; Mon, 14 May 2007 11:21:29 -0400
X-Mailer: git-send-email 1.5.1.4.19.g69e2
In-Reply-To: <1179156089470-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47258>

From: J. Bruce Fields <bfields@citi.umich.edu>

There seems to be a perception that the howto's are bit-rotting a
little.  The manual might be a more visible location for some of them,
and make-dist.txt seems like a good candidate to include as an example
in the manual.

For now, incorporate much of it verbatim.  Later we may want to update
the example a bit.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/howto/make-dist.txt |   52 -------------------------------------
 Documentation/user-manual.txt     |   43 ++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/howto/make-dist.txt

diff --git a/Documentation/howto/make-dist.txt b/Documentation/howto/make-dist.txt
deleted file mode 100644
index 00e330b..0000000
--- a/Documentation/howto/make-dist.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-Date:   Fri, 12 Aug 2005 22:39:48 -0700 (PDT)
-From: Linus Torvalds <torvalds@osdl.org>
-To: Dave Jones <davej@redhat.com>
-cc: git@vger.kernel.org
-Subject: Re: Fwd: Re: git checkout -f branch doesn't remove extra files
-Abstract: In this article, Linus talks about building a tarball,
- incremental patch, and ChangeLog, given a base release and two
- rc releases, following the convention of giving the patch from
- the base release and the latest rc, with ChangeLog between the
- last rc and the latest rc.
-
-On Sat, 13 Aug 2005, Dave Jones wrote:
->
->  > Git actually has a _lot_ of nifty tools. I didn't realize that people
->  > didn't know about such basic stuff as "git-tar-tree" and "git-ls-files".
->
-> Maybe its because things are moving so fast :)  Or maybe I just wasn't
-> paying attention on that day. (I even read the git changes via RSS,
-> so I should have no excuse).
-
-Well, git-tar-tree has been there since late April - it's actually one of
-those really early commands. I'm pretty sure the RSS feed came later ;)
-
-I use it all the time in doing releases, it's a lot faster than creating a
-tar tree by reading the filesystem (even if you don't have to check things
-out). A hidden pearl.
-
-This is my crappy "release-script":
-
-        [torvalds@g5 ~]$ cat bin/release-script
-        #!/bin/sh
-        stable="$1"
-        last="$2"
-        new="$3"
-        echo "# git-tag v$new"
-        echo "git-tar-tree v$new linux-$new | gzip -9 > ../linux-$new.tar.gz"
-        echo "git-diff-tree -p v$stable v$new | gzip -9 > ../patch-$new.gz"
-        echo "git-rev-list --pretty v$new ^v$last > ../ChangeLog-$new"
-        echo "git-rev-list --pretty=short v$new ^v$last | git-shortlog > ../ShortLog"
-        echo "git-diff-tree -p v$last v$new | git-apply --stat > ../diffstat-$new"
-
-and when I want to do a new kernel release I literally first tag it, and
-then do
-
-        release-script 2.6.12 2.6.13-rc6 2.6.13-rc7
-
-and check that things look sane, and then just cut-and-paste the commands.
-
-Yeah, it's stupid.
-
-                Linus
-
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 986e617..5404d6f 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -808,6 +808,49 @@ available
 Which shows that e05db0fd is reachable from itself, from v1.5.0-rc1, and
 from v1.5.0-rc2, but not from v1.5.0-rc0.
 
+[[making-a-release]]
+Creating a changelog and tarball for a software release
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The gitlink:git-archive[1] command can create a tar or zip archive from
+any version of a project; for example:
+
+-------------------------------------------------
+$ git archive --format=tar --prefix=project/ HEAD | gzip >latest.tar.gz
+-------------------------------------------------
+
+Will use HEAD to produce a tar archive in which each filename is
+preceded by "prefix/".
+
+If you're releasing a new version of a software project, you may want
+to simultaneously make a changelog to include in the release
+announcement.
+
+Linus Torvalds, for example, makes new kernel releases by running
+
+-------------------------------------------------
+$ release-script 2.6.12 2.6.13-rc6 2.6.13-rc7
+-------------------------------------------------
+
+where release-script is a shell script that looks like:
+
+-------------------------------------------------
+#!/bin/sh
+stable="$1"
+last="$2"
+new="$3"
+echo "# git-tag v$new"
+echo "git-tar-tree v$new linux-$new | gzip -9 > ../linux-$new.tar.gz"
+echo "git-diff-tree -p v$stable v$new | gzip -9 > ../patch-$new.gz"
+echo "git-rev-list --pretty v$new ^v$last > ../ChangeLog-$new"
+echo "git-rev-list --pretty=short v$new ^v$last | git-shortlog > ../ShortLog"
+echo "git-diff-tree -p v$last v$new | git-apply --stat > ../diffstat-$new"
+-------------------------------------------------
+
+(Note that gitlink:git-rev-list[1] and gitlink:git-diff-tree[1] are low-level
+commands with functionality similar to gitlink:git-log[1] and
+gitlink:git-diff[1].)
+
 
 [[Developing-with-git]]
 Developing with git
-- 
1.5.1.4.19.g69e2
