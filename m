From: Thomas Rast <trast@student.ethz.ch>
Subject: [Interdiff] [RFC PATCH v3] Documentation: add manpage about workflows
Date: Sun, 19 Oct 2008 17:20:22 +0200
Message-ID: <1224429622-1548-2-git-send-email-trast@student.ethz.ch>
References: <7v8wsyortf.fsf@gitster.siamese.dyndns.org>
 <1224429622-1548-1-git-send-email-trast@student.ethz.ch>
Cc: git@vger.kernel.org, santi@agolina.net,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 22:34:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kra67-0007uK-By
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 17:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbYJSPU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 11:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbYJSPU1
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 11:20:27 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:37582 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbYJSPUY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 11:20:24 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 19 Oct 2008 17:20:22 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 19 Oct 2008 17:20:21 +0200
X-Mailer: git-send-email 1.6.0.2.916.g8e7f4
In-Reply-To: <1224429622-1548-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 19 Oct 2008 15:20:21.0380 (UTC) FILETIME=[3397A440:01C931FE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98601>

---
 Documentation/gitworkflows.txt |   72 ++++++++++++++++++++-------------------
 1 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 037ace5..7fe9f72 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -72,15 +72,15 @@ Graduation
 
 As a given feature goes from experimental to stable, it also
 "graduates" between the corresponding branches of the software.
-`git.git` uses the following 'main branches':
+`git.git` uses the following 'integration branches':
 
 * 'maint' tracks the commits that should go into the next "maintenance
   release", i.e., update of the last released stable version;
 
 * 'master' tracks the commits that should go into the next release;
 
-* 'next' is intended as a testing branch for topics not stable enough
-  for master yet.
+* 'next' is intended as a testing branch for topics being tested for
+  stability for master.
 
 There is a fourth official branch that is used slightly differently:
 
@@ -107,7 +107,7 @@ the unstable branch into the stable one.  Hence the following:
 [caption="Rule: "]
 =====================================
 Always commit your fixes to the oldest supported branch that require
-them.  Then (periodically) merge the main branches upwards into each
+them.  Then (periodically) merge the integration branches upwards into each
 other.
 =====================================
 
@@ -124,28 +124,32 @@ Topic branches
 Any nontrivial feature will require several patches to implement, and
 may get extra bugfixes or improvements during its lifetime.
 
-Committing everything directly on the main branches leads to many
+Committing everything directly on the integration branches leads to many
 problems: Bad commits cannot be undone, so they must be reverted one
 by one, which creates confusing histories and further error potential
 when you forget to revert part of a group of changes.  Working in
 parallel mixes up the changes, creating further confusion.
 
-The key concept here is "topic branches".  The name is pretty self
-explanatory, with a caveat that comes from the "merge upwards" rule
-above:
+Use of "topic branches" solves these problems.  The name is pretty
+self explanatory, with a caveat that comes from the "merge upwards"
+rule above:
 
 .Topic branches
 [caption="Rule: "]
 =====================================
 Make a side branch for every topic (feature, bugfix, ...). Fork it off
-at the oldest main branch that you will eventually want to merge it
+at the oldest integration branch that you will eventually want to merge it
 into.
 =====================================
 
 Many things can then be done very naturally:
 
-* To get the feature/bugfix into a main branch, simply merge it.  If
-  the topic has evolved further in the meantime, merge again.
+* To get the feature/bugfix into an integration branch, simply merge
+  it.  If the topic has evolved further in the meantime, merge again.
+  (Note that you do not necessarily have to merge it to the oldest
+  integration branch first.  For example, you can first merge a bugfix
+  to 'next', give it some testing time, and merge to 'maint' when you
+  know it is stable.)
 
 * If you find you need new features from the branch 'other' to continue
   working on your topic, merge 'other' to 'topic'.  (However, do not
@@ -154,35 +158,33 @@ Many things can then be done very naturally:
 * If you find you forked off the wrong branch and want to move it
   "back in time", use linkgit:git-rebase[1].
 
-Note that the last two points clash: a topic that has been merged
-elsewhere should not be rebased.  See the section on RECOVERING FROM
-UPSTREAM REBASE in linkgit:git-rebase[1].
+Note that the last point clashes with the other two: a topic that has
+been merged elsewhere should not be rebased.  See the section on
+RECOVERING FROM UPSTREAM REBASE in linkgit:git-rebase[1].
 
 We should point out that "habitually" (regularly for no real reason)
-merging a main branch into your topics -- and by extension, merging
-anything upstream into anything downstream on a regular basis -- is
-frowned upon:
+merging an integration branch into your topics -- and by extension,
+merging anything upstream into anything downstream on a regular basis
+-- is frowned upon:
 
 .Merge to downstream only at well-defined points
 [caption="Rule: "]
 =====================================
-Do not merge to downstream except:
-
-* with a good reason: upstream API changes affect your branch; your
-  branch no longer merges to upstream cleanly; etc.
-
-* at well-defined points such as when an upstream release has been tagged.
+Do not merge to downstream except with a good reason: upstream API
+changes affect your branch; your branch no longer merges to upstream
+cleanly; etc.
 =====================================
 
-Otherwise, the many resulting small merges will greatly clutter up
-history.  Anyone who later investigates the history of a file will
-have to find out whether that merge affected the topic in development.
-An upstream might even inadvertently be merged into a "more stable"
-branch.  And so on.
+Otherwise, the topic that was merged to suddenly contains more than a
+single (well-separated) change.  The many resulting small merges will
+greatly clutter up history.  Anyone who later investigates the history
+of a file will have to find out whether that merge affected the topic
+in development.  An upstream might even inadvertently be merged into a
+"more stable" branch.  And so on.
 
 
-Integration branches
-~~~~~~~~~~~~~~~~~~~~
+Throw-away integration
+~~~~~~~~~~~~~~~~~~~~~~
 
 If you followed the last paragraph, you will now have many small topic
 branches, and occasionally wonder how they interact.  Perhaps the
@@ -193,7 +195,7 @@ cannot easily be undone.
 The solution, of course, is to make a merge that we can undo: merge
 into a throw-away branch.
 
-.Integration branches
+.Throw-away integration branches
 [caption="Rule: "]
 =====================================
 To test the interaction of several topics, merge them into a
@@ -204,7 +206,7 @@ If you make it (very) clear that this branch is going to be deleted
 right after the testing, you can even publish this branch, for example
 to give the testers a chance to work with it, or other developers a
 chance to see if their in-progress work will be compatible.  `git.git`
-has such an official integration branch called 'pu'.
+has such an official throw-away integration branch called 'pu'.
 
 
 DISTRIBUTED WORKFLOWS
@@ -259,7 +261,7 @@ You will still have to tell people by other means, such as mail.  (Git
 provides the linkgit:request-pull[1] to send preformatted pull
 requests to upstream maintainers to simplify this task.)
 
-If you just want to get the newest copies of the main branches,
+If you just want to get the newest copies of the integration branches,
 staying up to date is easy too:
 
 .Push/pull: Staying up to date
@@ -272,8 +274,8 @@ Then simply fork your topic branches from the stable remotes as
 explained earlier.
 
 If you are a maintainer and would like to merge other people's topic
-branches to the main branches, they will typically send a request to
-do so by mail.  Such a request looks like
+branches to the integration branches, they will typically send a
+request to do so by mail.  Such a request looks like
 
 -------------------------------------
 Please pull from
-- 
1.6.0.2.916.g8e7f4
