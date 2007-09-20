From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] User Manual: add a chapter for submodules
Date: Thu, 20 Sep 2007 02:34:14 +0200
Message-ID: <20070920003413.GJ16235@genesis.frugalware.org>
References: <7vbqbyphil.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 02:34:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYA00-0005Pc-9l
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 02:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbXITAeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 20:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbXITAeY
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 20:34:24 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:44777 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbXITAeX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 20:34:23 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IY9zo-00006v-7D
	from <vmiklos@frugalware.org>; Thu, 20 Sep 2007 02:34:20 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 371401678013; Thu, 20 Sep 2007 02:34:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vbqbyphil.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.4 required=5.9 tests=BAYES_00,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58745>

Signed-off-by: Michael Smith <msmith@cbnco.com>
Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Sorry, I sent the original patch again. So here is the updated second version.

 Documentation/user-manual.txt |  202 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 202 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index ecb2bf9..aee654c 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3155,6 +3155,208 @@ a tree which you are in the process of working on.
 If you blow the index away entirely, you generally haven't lost any
 information as long as you have the name of the tree that it described.
 
+[[submodules]]
+Submodules
+==========
+
+This tutorial explains how to create and publish a repository with submodules
+using the gitlink:git-submodule[1] command.
+
+Submodules maintain their own identity; the submodule support just stores the
+submodule repository location and commit ID, so other developers who clone the
+superproject can easily clone all the submodules at the same revision.
+
+To see how submodule support works, create (for example) four example
+repositories that can be used later as a submodule:
+
+-------------------------------------------------
+$ mkdir ~/git
+$ cd ~/git
+$ for i in a b c d
+do
+	mkdir $i
+	cd $i
+	git init
+	echo "module $i" > $i.txt
+	git add $i.txt
+	git commit -m "Initial commit, submodule $i"
+	cd ..
+done
+-------------------------------------------------
+
+Now create the superproject and add all the submodules:
+
+-------------------------------------------------
+$ mkdir super
+$ cd super
+$ git init
+$ for i in a b c d
+do
+	git submodule add ~/git/$i
+done
+-------------------------------------------------
+
+NOTE: Do not use local URLs here if you plan to publish your superproject!
+
+See what files `git submodule` created:
+
+-------------------------------------------------
+$ ls -a
+.  ..  .git  .gitmodules  a  b  c  d
+-------------------------------------------------
+
+The `git submodule add` command does a couple of things:
+
+- It clones the submodule under the current directory and by default checks out
+  the master branch.
+- It adds the submodule's clone path to the `.gitmodules` file and adds this
+  file to the index, ready to be committed.
+- It adds the submodule's current commit ID to the index, ready to be
+  committed.
+
+Commit the superproject:
+
+-------------------------------------------------
+$ git commit -m "Add submodules a, b, c and d."
+-------------------------------------------------
+
+Now clone the superproject:
+
+-------------------------------------------------
+$ cd ..
+$ git clone super cloned
+$ cd cloned
+-------------------------------------------------
+
+The submodule directories are there, but they're empty:
+
+-------------------------------------------------
+$ ls -a a
+.  ..
+$ git submodule status
+-d266b9873ad50488163457f025db7cdd9683d88b a
+-e81d457da15309b4fef4249aba9b50187999670d b
+-c1536a972b9affea0f16e0680ba87332dc059146 c
+-d96249ff5d57de5de093e6baff9e0aafa5276a74 d
+-------------------------------------------------
+
+NOTE: The commit object names shown above would be different for you, but they
+should match the HEAD commit object names of your repositories.  You can check
+it by running `git ls-remote ../a`.
+
+Pulling down the submodules is a two-step process. First run `git submodule
+init` to add the submodule repository URLs to `.git/config`:
+
+-------------------------------------------------
+$ git submodule init
+-------------------------------------------------
+
+Now use `git submodule update` to clone the repositories and check out the
+commits specified in the superproject:
+
+-------------------------------------------------
+$ git submodule update
+$ cd a
+$ ls -a
+.  ..  .git  a.txt
+-------------------------------------------------
+
+One major difference between `git submodule update` and `git submodule add` is
+that `git submodule update` checks out a specific commit, rather than the tip
+of a branch. It's like checking out a tag: the head is detached, so you're not
+working on a branch.
+
+-------------------------------------------------
+$ git branch
+* (no branch)
+  master
+-------------------------------------------------
+
+If you want to make a change within a submodule and you have a detached head,
+then you should create or checkout a branch, make your changes, publish the
+change within the submodule, and then update the superproject to reference the
+new commit:
+
+-------------------------------------------------
+$ git checkout master
+-------------------------------------------------
+
+or
+
+-------------------------------------------------
+$ git checkout -b fix-up
+-------------------------------------------------
+
+then
+
+-------------------------------------------------
+$ echo "adding a line again" >> a.txt
+$ git commit -a -m "Updated the submodule from within the superproject."
+$ git push
+$ cd ..
+$ git diff
+diff --git a/a b/a
+index d266b98..261dfac 160000
+--- a/a
++++ b/a
+@@ -1 +1 @@
+-Subproject commit d266b9873ad50488163457f025db7cdd9683d88b
++Subproject commit 261dfac35cb99d380eb966e102c1197139f7fa24
+$ git add a
+$ git commit -m "Updated submodule a."
+$ git push
+-------------------------------------------------
+
+You have to run `git submodule update` after `git pull` if you want to update
+submodules, too.
+
+Pitfalls with submodules
+------------------------
+
+Always publish the submodule change before publishing the change to the
+superproject that references it. If you forget to publish the submodule change,
+others won't be able to clone the repository:
+
+-------------------------------------------------
+$ cd ~/git/super/a
+$ echo i added another line to this file >> a.txt
+$ git commit -a -m "doing it wrong this time"
+$ cd ..
+$ git add a
+$ git commit -m "Updated submodule a again."
+$ git push
+$ cd ~/git/cloned
+$ git pull
+$ git submodule update
+error: pathspec '261dfac35cb99d380eb966e102c1197139f7fa24' did not match any file(s) known to git.
+Did you forget to 'git add'?
+Unable to checkout '261dfac35cb99d380eb966e102c1197139f7fa24' in submodule path 'a'
+-------------------------------------------------
+
+You also should not rewind branches in a submodule beyond commits that were
+ever recorded in any superproject.
+
+It's not safe to run `git submodule update` if you've made and committed
+changes within a submodule without checking out a branch first. They will be
+silently overwritten:
+
+-------------------------------------------------
+$ cat a.txt
+module a
+$ echo line added from private2 >> a.txt
+$ git commit -a -m "line added inside private2"
+$ cd ..
+$ git submodule update
+Submodule path 'a': checked out 'd266b9873ad50488163457f025db7cdd9683d88b'
+$ cd a
+$ cat a.txt
+module a
+-------------------------------------------------
+
+NOTE: The changes are still visible in the submodule's reflog.
+
+This is not the case if you did not commit your changes.
+
 [[low-level-operations]]
 Low-level git operations
 ========================
-- 
1.5.3.1.1.g1e61-dirty
