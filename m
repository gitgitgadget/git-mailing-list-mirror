From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/4] Tutorial: Write about rebasing
Date: Sun, 12 Oct 2008 17:11:51 +0200
Message-ID: <20081012151151.17648.46373.stgit@yoghurt>
References: <20081012150825.17648.3315.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 17:13:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp2d1-0004du-GN
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 17:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbYJLPLz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Oct 2008 11:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754108AbYJLPLz
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 11:11:55 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1057 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994AbYJLPLy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 11:11:54 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Kp2bm-0006Wx-00; Sun, 12 Oct 2008 16:11:50 +0100
In-Reply-To: <20081012150825.17648.3315.stgit@yoghurt>
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98029>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 Documentation/tutorial.txt |   84 ++++++++++++++++++++++++++++++++++++=
+++++++-
 1 files changed, 83 insertions(+), 1 deletions(-)


diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 46c78cf..2808462 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -533,7 +533,89 @@ index e324179..6398958 100644
 Rebasing a patch series
 -----------------------
=20
-TODO:: rebase, ...
+While you are busy writing, submitting, and revising your patch
+series, other people will be doing the same thing. As a result, even
+though you started writing your patches on top of what was the latest
+history at the time, your stack base will grow ever more out of date.
+
+When you clone a repository,
+
+  $ stg clone http://homepage.ntlworld.com/cmarinas/stgit.git stgit
+
+you initially get one local branch, +master+. You also get a number of
+'remote' branches, one for each branch in the repository you cloned.
+In the case of the StGit repository, these are
++remotes/origin/stable+, +remotes/origin/master+, and
++remotes/origin/proposed+. +remotes+ means that it's not a local
+branch, just a snapshot of a branch in another repository; and
++origin+ is the default name for the first remote repository (you can
+set up more; see the man page for +git remote+).
+
+Right after cloning, +master+ and +remotes/origin/master+ point at the
+same commit. When you start writing patches, +master+ will advance,
+and always point at the current topmost patch, but
++remotes/origin/master+ will stay the same because it represents the
+master branch in the repository you cloned from -- your 'upstream'
+repository.
+
+Unless you are the only one working on the project, however, the
+upstream repository will not stay the same forever. New commits will
+be added to its branches; to update your clone, run
+
+  $ git remote update
+
+This will update all your remote branches, but won't touch your local
+branches. To get the latest changes into your local +master+ branch,
+use stglink:rebase[]:
+
+  $ stg rebase remotes/origin/master
+
+This command will do three things:
+
+  1. Pop all patches, so that your local branch (+master+, in this
+     example) points at the stack base. This is the same commit that
+     +remotes/origin/master+ pointed at at the time you started
+     writing your patches.
+
+  2. Set the stack base to the given commit (the current, updated
+     value of +remotes/origin/master+).
+
+  3. Push the patches that were popped in the first step.
+
+The end result is that your patches are now applied on top of the
+latest version of +remotes/origin/master+.
+
+The primary reason for rebasing is to reduce the amount of conflicts
+between your work and others'. If one of your patches changes the same
+part of the same file as a patch someone else has written, you will
+get a conflict when you run stglink:rebase[] the next time after the
+other person's patch has been accepted upstream. It is almost always
+less work to rebase often and resolve these one at a time, rather than
+a whole lot at once. After all, you have to rebase eventually; if you
+mail out patches that are based on an outdated branch, everyone who
+tries to apply them has to resolve the conflicts instead. There are
+more effective ways to get popular.
+
+
+When your patches are accepted
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If and when some or all of your patches are accepted upstream, you
+update and rebase just like usual -- but be sure to use the
++$$--merged$$+ flag to stglink:rebase[]:
+
+  $ git remote update
+  $ stg rebase --merged remotes/origin/master
+
+This flag makes the rebase operation better at detecting that your
+patches have been merged, at some cost in performance.
+
+The patches that had been merged will still be present in your patch
+stack after the rebase, but they will be empty, since the change they
+added is now already present in the stack base. Run stglink:clean[] to
+get rid of such empty patches if you don't want them hanging around:
+
+  $ stg clean
=20
=20
 Importing patches
