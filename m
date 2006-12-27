From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] everyday: update for v1.5.0
Date: Tue, 26 Dec 2006 22:42:33 -0800
Message-ID: <7vd565c012.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 27 07:42:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzSUq-0003qw-Ur
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 07:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935AbWL0Gmg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 01:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932934AbWL0Gmg
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 01:42:36 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:62937 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932935AbWL0Gme (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 01:42:34 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061227064234.BQOX2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 01:42:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3iin1W0071kojtg0000000; Wed, 27 Dec 2006 01:42:47 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35445>

Fix minor mark-up mistakes and adjust to v1.5.0 BCP, namely:

 - use "git add" instead of "git update-index";
 - use "git merge" instead of "git pull .";
 - use separate remote layout;
 - use config instead of remotes/origin file;

Also updates "My typical git day" example since now I have
'next' branch these days.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/everyday.txt |   89 +++++++++++++++++++++++--------------------
 1 files changed, 48 insertions(+), 41 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 9677671..5d17ace 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -47,11 +47,11 @@ $ git repack <3>
 $ git prune <4>
 ------------
 +
-<1> running without "--full" is usually cheap and assures the
+<1> running without `\--full` is usually cheap and assures the
 repository health reasonably well.
 <2> check how many loose objects there are and how much
 disk space is wasted by not repacking.
-<3> without "-a" repacks incrementally.  repacking every 4-5MB
+<3> without `-a` repacks incrementally.  repacking every 4-5MB
 of loose objects accumulation may be a good rule of thumb.
 <4> after repack, prune removes the duplicate loose objects.
 
@@ -80,8 +80,7 @@ following commands.
   * gitlink:git-checkout[1] and gitlink:git-branch[1] to switch
     branches.
 
-  * gitlink:git-add[1] and gitlink:git-update-index[1] to manage
-    the index file.
+  * gitlink:git-add[1] to manage the index file.
 
   * gitlink:git-diff[1] and gitlink:git-status[1] to see what
     you are in the middle of doing.
@@ -91,8 +90,7 @@ following commands.
   * gitlink:git-reset[1] and gitlink:git-checkout[1] (with
     pathname parameters) to undo changes.
 
-  * gitlink:git-pull[1] with "." as the remote to merge between
-    local branches.
+  * gitlink:git-merge[1] to merge between local branches.
 
   * gitlink:git-rebase[1] to maintain topic branches.
 
@@ -101,7 +99,7 @@ following commands.
 Examples
 ~~~~~~~~
 
-Use a tarball as a starting point for a new repository:
+Use a tarball as a starting point for a new repository.::
 +
 ------------
 $ tar zxf frotz.tar.gz
@@ -123,7 +121,7 @@ $ edit/compile/test
 $ git checkout -- curses/ux_audio_oss.c <2>
 $ git add curses/ux_audio_alsa.c <3>
 $ edit/compile/test
-$ git diff <4>
+$ git diff HEAD <4>
 $ git commit -a -s <5>
 $ edit/compile/test
 $ git reset --soft HEAD^ <6>
@@ -131,15 +129,15 @@ $ edit/compile/test
 $ git diff ORIG_HEAD <7>
 $ git commit -a -c ORIG_HEAD <8>
 $ git checkout master <9>
-$ git pull . alsa-audio <10>
+$ git merge alsa-audio <10>
 $ git log --since='3 days ago' <11>
 $ git log v2.43.. curses/ <12>
 ------------
 +
 <1> create a new topic branch.
-<2> revert your botched changes in "curses/ux_audio_oss.c".
+<2> revert your botched changes in `curses/ux_audio_oss.c`.
 <3> you need to tell git if you added a new file; removal and
-modification will be caught if you do "commit -a" later.
+modification will be caught if you do `git commit -a` later.
 <4> to see what changes you are committing.
 <5> commit everything as you have tested, with your sign-off.
 <6> take the last commit back, keeping what is in the working tree.
@@ -147,11 +145,13 @@ modification will be caught if you do "commit -a" later.
 <8> redo the commit undone in the previous step, using the message
 you originally wrote.
 <9> switch to the master branch.
-<10> merge a topic branch into your master branch
+<10> merge a topic branch into your master branch.  You can also use
+`git pull . alsa-audio`, i.e. pull from the local repository.
 <11> review commit logs; other forms to limit output can be
-combined and include --max-count=10 (show 10 commits), --until='2005-12-10'.
-<12> view only the changes that touch what's in curses/
-directory, since v2.43 tag.
+combined and include `\--max-count=10` (show 10 commits),
+`\--until=2005-12-10`, etc.
+<12> view only the changes that touch what's in `curses/`
+directory, since `v2.43` tag.
 
 
 Individual Developer (Participant)[[Individual Developer (Participant)]]
@@ -193,7 +193,7 @@ $ git fetch --tags <8>
 +
 <1> repeat as needed.
 <2> extract patches from your branch for e-mail submission.
-<3> "pull" fetches from "origin" by default and merges into the
+<3> `git pull` fetches from `origin` by default and merges into the
 current branch.
 <4> immediately after pulling, look at the changes done upstream
 since last time we checked, only in the
@@ -201,37 +201,41 @@ area we are interested in.
 <5> fetch from a specific branch from a specific repository and merge.
 <6> revert the pull.
 <7> garbage collect leftover objects from reverted pull.
-<8> from time to time, obtain official tags from the "origin"
-and store them under .git/refs/tags/.
+<8> from time to time, obtain official tags from the `origin`
+and store them under `.git/refs/tags/`.
 
 
 Push into another repository.::
 +
 ------------
-satellite$ git clone mothership:frotz/.git frotz <1>
+satellite$ git clone mothership:frotz frotz <1>
 satellite$ cd frotz
-satellite$ cat .git/remotes/origin <2>
-URL: mothership:frotz/.git
-Pull: master:origin
-satellite$ echo 'Push: master:satellite' >>.git/remotes/origin <3>
+satellite$ git repo-config --get-regexp '^(remote|branch)\.' <2>
+remote.origin.url mothership:frotz
+remote.origin.fetch refs/heads/*:refs/remotes/origin/*
+branch.master.remote origin
+branch.master.merge refs/heads/master
+satellite$ git repo-config remote.origin.push \
+           master:refs/remotes/satellite/master <3>
 satellite$ edit/compile/test/commit
 satellite$ git push origin <4>
 
 mothership$ cd frotz
 mothership$ git checkout master
-mothership$ git pull . satellite <5>
+mothership$ git merge satellite/master <5>
 ------------
 +
 <1> mothership machine has a frotz repository under your home
 directory; clone from it to start a repository on the satellite
 machine.
-<2> clone creates this file by default.  It arranges "git pull"
-to fetch and store the master branch head of mothership machine
-to local "origin" branch.
-<3> arrange "git push" to push local "master" branch to
-"satellite" branch of the mothership machine.
-<4> push will stash our work away on "satellite" branch on the
-mothership machine.  You could use this as a back-up method.
+<2> clone sets these configuration variables by default.
+It arranges `git pull` to fetch and store the branches of mothership
+machine to local `remotes/origin/*` tracking branches.
+<3> arrange `git push` to push local `master` branch to
+`remotes/satellite/master` branch of the mothership machine.
+<4> push will stash our work away on `remotes/satellite/master`
+tracking branch on the mothership machine.  You could use this as
+a back-up method.
 <5> on mothership machine, merge the work done on the satellite
 machine into the master branch.
 
@@ -247,7 +251,7 @@ $ git format-patch -k -m --stdout v2.6.14..private2.6.14 |
 +
 <1> create a private branch based on a well known (but somewhat behind)
 tag.
-<2> forward port all changes in private2.6.14 branch to master branch
+<2> forward port all changes in `private2.6.14` branch to `master` branch
 without a formal "merging".
 
 
@@ -284,13 +288,13 @@ $ mailx <3>
 & s 2 3 4 5 ./+to-apply
 & s 7 8 ./+hold-linus
 & q
-$ git checkout master
+$ git checkout -b topic/one master
 $ git am -3 -i -s -u ./+to-apply <4>
 $ compile/test
 $ git checkout -b hold/linus && git am -3 -i -s -u ./+hold-linus <5>
 $ git checkout topic/one && git rebase master <6>
-$ git checkout pu && git reset --hard master <7>
-$ git pull . topic/one topic/two && git pull . hold/linus <8>
+$ git checkout pu && git reset --hard next <7>
+$ git merge topic/one topic/two && git merge hold/linus <8>
 $ git checkout maint
 $ git cherry-pick master~4 <9>
 $ compile/test
@@ -307,29 +311,32 @@ they are.
 that are not quite ready.
 <4> apply them, interactively, with my sign-offs.
 <5> create topic branch as needed and apply, again with my
-sign-offs. 
+sign-offs.
 <6> rebase internal topic branch that has not been merged to the
 master, nor exposed as a part of a stable branch.
-<7> restart "pu" every time from the master.
+<7> restart `pu` every time from the next.
 <8> and bundle topic branches still cooking.
 <9> backport a critical fix.
 <10> create a signed tag.
 <11> make sure I did not accidentally rewind master beyond what I
-already pushed out.  "ko" shorthand points at the repository I have
+already pushed out.  `ko` shorthand points at the repository I have
 at kernel.org, and looks like this:
 +
 ------------
 $ cat .git/remotes/ko
 URL: kernel.org:/pub/scm/git/git.git
 Pull: master:refs/tags/ko-master
+Pull: next:refs/tags/ko-next
 Pull: maint:refs/tags/ko-maint
 Push: master
+Push: next
 Push: +pu
 Push: maint
 ------------
 +
-In the output from "git show-branch", "master" should have
-everything "ko-master" has.
+In the output from `git show-branch`, `master` should have
+everything `ko-master` has, and `next` should have
+everything `ko-next` has.
 
 <12> push out the bleeding edge.
 <13> push the tag out, too.
@@ -406,7 +413,7 @@ $ grep git /etc/shells <2>
 ------------
 +
 <1> log-in shell is set to /usr/bin/git-shell, which does not
-allow anything but "git push" and "git pull".  The users should
+allow anything but `git push` and `git pull`.  The users should
 get an ssh access to the machine.
 <2> in many distributions /etc/shells needs to list what is used
 as the login shell.
-- 
1.5.0.rc0.g9c0d
