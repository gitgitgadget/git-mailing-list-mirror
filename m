From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Make "stg repair" help text more helpful
Date: Fri, 30 Nov 2007 07:35:50 +0100
Message-ID: <20071130063516.27500.85249.stgit@yoghurt>
References: <20071128164113.GA20749@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 07:36:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxzU9-0007cQ-6o
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 07:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287AbXK3GgF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Nov 2007 01:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbXK3GgE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 01:36:04 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1046 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256AbXK3GgD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 01:36:03 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IxzTd-0005BO-00; Fri, 30 Nov 2007 06:35:54 +0000
In-Reply-To: <20071128164113.GA20749@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66618>

Specifically, point out that if messing up the branch with git
commands was a mistake, the user should run "git reset", not "stg
repair".

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

Is this an improvement?

 stgit/commands/common.py |    4 +--
 stgit/commands/repair.py |   63 ++++++++++++++++++++++++++++----------=
--------
 2 files changed, 41 insertions(+), 26 deletions(-)


diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 6318cdd..bf804e6 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -114,8 +114,8 @@ def check_head_top_equal(crt_series):
     if not crt_series.head_top_equal():
         raise CmdException(
 """HEAD and top are not the same. This can happen if you
-   modify a branch with git. The "repair" command can
-   fix this situation.""")
+   modify a branch with git. "stg repair --help" explains
+   more about what to do next.""")
=20
 def check_conflicts():
     if os.path.exists(os.path.join(basedir.get(), 'conflicts')):
diff --git a/stgit/commands/repair.py b/stgit/commands/repair.py
index c36db07..aa34792 100644
--- a/stgit/commands/repair.py
+++ b/stgit/commands/repair.py
@@ -26,32 +26,47 @@ from stgit.out import *
 from stgit.run import *
 from stgit import stack, git
=20
-help =3D 'StGit-ify any git commits made on top of your StGit stack'
+help =3D 'Fix StGit metadata if branch was modified with git commands'
 usage =3D """%prog [options]
=20
-"repair" will repair three kinds of inconsistencies in your StGit
-stack, all of them caused by using plain git commands on the branch:
-
-  1. If you have made regular git commits on top of your stack of
-     StGit patches, "repair" converts them to StGit patches,
-     preserving their contents.
-
-  2. Merge commits cannot become patches; if you have committed a
-     merge on top of your stack, "repair" will simply mark all
-     patches below the merge unapplied, since they are no longer
-     reachable. If this is not what you want, use "git reset" to get
-     rid of the merge and run "repair" again.
-
-  3. The applied patches are supposed to be precisely those that are
-     reachable from the branch head. If you have used e.g. "git reset"
-     to move the head, some applied patches may no longer be
-     reachable, and some unapplied patches may have become reachable.
-     "repair" will correct the appliedness of such patches.
-
-Note that these are "inconsistencies", not "errors"; furthermore,
-"repair" will repair them reliably. As long as you are satisfied
-with the way "repair" handles them, you have no reason to avoid
-causing them in the first place if that is convenient for you."""
+If you modify an StGit stack (branch) with some git commands -- such
+as commit, pull, merge, and rebase -- you will leave the StGit
+metadata in an inconsistent state. In that situation, you have two
+options:
+
+  1. Use "git reset" or similar to undo the effect of the git
+     command(s).
+
+  2. Use "stg repair". This will fix up the StGit metadata to
+     accomodate the modifications to the branch. Specifically, it will
+     do the following:
+
+       * If you have made regular git commits on top of your stack of
+         StGit patches, "stg repair" makes new StGit patches out of
+         them, preserving their contents.
+
+       * However, merge commits cannot become patches; if you have
+         committed a merge on top of your stack, "repair" will simply
+         mark all patches below the merge unapplied, since they are no
+         longer reachable. If this is not what you want, use "git
+         reset" to get rid of the merge and run "stg repair" again.
+
+       * The applied patches are supposed to be precisely those that
+         are reachable from the branch head. If you have used e.g.
+         "git reset" to move the head, some applied patches may no
+         longer be reachable, and some unapplied patches may have
+         become reachable. "stg repair" will correct the appliedness
+         of such patches.
+
+     "stg repair" will fix these inconsistencies reliably, so as long
+     as you like what it does, you have no reason to avoid causing
+     them in the first place. For example, you might find it
+     convenient to make commits with a graphical tool and then have
+     "stg repair" make proper patches of the commits.
+
+NOTE: If using git commands on the stack was a mistake, running "stg
+repair" is _not_ what you want. In that case, what you want is option
+(1) above."""
=20
 directory =3D DirectoryGotoToplevel()
 options =3D []
