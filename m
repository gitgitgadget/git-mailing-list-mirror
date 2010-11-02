From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 06/10] Change incorrect uses of "remote branch" meaning "remote-tracking"
Date: Tue,  2 Nov 2010 16:31:24 +0100
Message-ID: <1288711888-21528-7-git-send-email-Matthieu.Moy@imag.fr>
References: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 02 16:33:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDIrq-00045G-Tw
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 16:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772Ab0KBPdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 11:33:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54794 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753674Ab0KBPdl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 11:33:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id oA2FPKeC022912
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Nov 2010 16:25:20 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDIpv-00026Y-Au; Tue, 02 Nov 2010 16:31:47 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDIpv-0005cH-8i; Tue, 02 Nov 2010 16:31:47 +0100
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 02 Nov 2010 16:25:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA2FPKeC022912
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1289316321.10344@Ga0rlvm6fTLPi5ZUa1IDRg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160531>

"remote branch" is a branch hosted in a remote repository, while
"remote-tracking branch" is a copy of such branch, hosted locally.
The distinction is subtle when the copy is up-to-date, but rather
fundamental to understand what "git fetch" and "git push" do.

This patch should fix all incorrect usages in Documentation/ directory.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt       |    7 ++++---
 Documentation/git-branch.txt   |   11 ++++++-----
 Documentation/git-checkout.txt |    2 +-
 Documentation/git-clone.txt    |    2 +-
 Documentation/git-describe.txt |    2 +-
 Documentation/user-manual.txt  |    9 +++++----
 6 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e4f16d8..6a6c0b5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -601,8 +601,9 @@ branch.autosetupmerge::
 	this behavior can be chosen per-branch using the `--track`
 	and `--no-track` options. The valid settings are: `false` -- no
 	automatic setup is done; `true` -- automatic setup is done when the
-	starting point is a remote branch; `always` -- automatic setup is
-	done when the starting point is either a local branch or remote
+	starting point is a remote-tracking branch; `always` --
+	automatic setup is done when the starting point is either a
+	local branch or remote-tracking
 	branch. This option defaults to true.
 
 branch.autosetuprebase::
@@ -613,7 +614,7 @@ branch.autosetuprebase::
 	When `local`, rebase is set to true for tracked branches of
 	other local branches.
 	When `remote`, rebase is set to true for tracked branches of
-	remote branches.
+	remote-tracking branches.
 	When `always`, rebase will be set to true for all tracking
 	branches.
 	See "branch.autosetupmerge" for details on how to set up a
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 1940256..7f23c56 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -37,9 +37,9 @@ Note that this will create the new branch, but it will not switch the
 working tree to it; use "git checkout <newbranch>" to switch to the
 new branch.
 
-When a local branch is started off a remote branch, git sets up the
+When a local branch is started off a remote-tracking branch, git sets up the
 branch so that 'git pull' will appropriately merge from
-the remote branch. This behavior may be changed via the global
+the remote-tracking branch. This behavior may be changed via the global
 `branch.autosetupmerge` configuration flag. That setting can be
 overridden by using the `--track` and `--no-track` options.
 
@@ -89,7 +89,8 @@ OPTIONS
 	Move/rename a branch even if the new branch name already exists.
 
 --color[=<when>]::
-	Color branches to highlight current, local, and remote branches.
+	Color branches to highlight current, local, and
+	remote-tracking branches.
 	The value must be always (the default), never, or auto.
 
 --no-color::
@@ -125,11 +126,11 @@ OPTIONS
 	it directs `git pull` without arguments to pull from the
 	upstream when the new branch is checked out.
 +
-This behavior is the default when the start point is a remote branch.
+This behavior is the default when the start point is a remote-tracking branch.
 Set the branch.autosetupmerge configuration variable to `false` if you
 want `git checkout` and `git branch` to always behave as if '--no-track'
 were given. Set it to `always` if you want this behavior when the
-start-point is either a local or remote branch.
+start-point is either a local or remote-tracking branch.
 
 --no-track::
 	Do not set up "upstream" configuration, even if the
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 22d3611..880763d 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -98,7 +98,7 @@ entries; instead, unmerged entries are ignored.
 	"--track" in linkgit:git-branch[1] for details.
 +
 If no '-b' option is given, the name of the new branch will be
-derived from the remote branch.  If "remotes/" or "refs/remotes/"
+derived from the remote-tracking branch.  If "remotes/" or "refs/remotes/"
 is prefixed it is stripped away, and then the part up to the
 next slash (which would be the nickname of the remote) is removed.
 This would tell us to use "hack" as the local branch when branching
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index ab72933..2320382 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -131,7 +131,7 @@ objects from the source repository into a pack in the cloned repository.
 	Set up a mirror of the source repository.  This implies `--bare`.
 	Compared to `--bare`, `--mirror` not only maps local branches of the
 	source to local branches of the target, it maps all refs (including
-	remote branches, notes etc.) and sets up a refspec configuration such
+	remote-tracking branches, notes etc.) and sets up a refspec configuration such
 	that all these refs are overwritten by a `git remote update` in the
 	target repository.
 
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 7ef9d51..02e015a 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -37,7 +37,7 @@ OPTIONS
 --all::
 	Instead of using only the annotated tags, use any ref
 	found in `.git/refs/`.  This option enables matching
-	any known branch, remote branch, or lightweight tag.
+	any known branch, remote-tracking branch, or lightweight tag.
 
 --tags::
 	Instead of using only the annotated tags, use any tag
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d7835ca..d70f3e0 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1724,7 +1724,8 @@ accomplish the above with just a simple
 $ git pull
 -------------------------------------------------
 
-More generally, a branch that is created from a remote branch will pull
+More generally, a branch that is created from a remote-tracking branch
+will pull
 by default from that branch.  See the descriptions of the
 branch.<name>.remote and branch.<name>.merge options in
 linkgit:git-config[1], and the discussion of the `--track` option in
@@ -2106,7 +2107,7 @@ $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
 $ cd work
 -------------------------------------------------
 
-Linus's tree will be stored in the remote branch named origin/master,
+Linus's tree will be stored in the remote-tracking branch named origin/master,
 and can be updated using linkgit:git-fetch[1]; you can track other
 public trees using linkgit:git-remote[1] to set up a "remote" and
 linkgit:git-fetch[1] to keep them up-to-date; see
@@ -2800,8 +2801,8 @@ Be aware that commits that the old version of example/master pointed at
 may be lost, as we saw in the previous section.
 
 [[remote-branch-configuration]]
-Configuring remote branches
----------------------------
+Configuring remote-tracking branches
+------------------------------------
 
 We saw above that "origin" is just a shortcut to refer to the
 repository that you originally cloned from.  This information is
-- 
1.7.3.2.183.g2e7b0
