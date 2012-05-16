From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4] git-svn: clarify the referent of dcommit's optional argument
Date: Thu, 17 May 2012 06:42:35 +1000
Message-ID: <1337200956-9260-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, normalperson@yhbt.net, trast@student.ethz.ch,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 22:42:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUl3e-0006by-BV
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 22:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab2EPUmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 May 2012 16:42:50 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44479 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098Ab2EPUmt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 16:42:49 -0400
Received: by dady13 with SMTP id y13so1478681dad.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 13:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=HzdeAoSyiJy12jrIMfka/UP1vmz57p+UsZoBjxamSKk=;
        b=0qDukyaPDeOFCpOXXiVapwsP8RjbMmJvrCPLH2Gp1adaQLSKYKE6dPUZna1BEFbhNC
         TqEXhM/LurKpzypVjMLjv0eT8ZW8Gq49JutC6/TG4eWTOKo5IUTfFQDtJiRC6efpgItQ
         7WWOE7IhfQrpjHOCAdGk9+5H8BIXbNLDCZYEop1gpKiSNITssrXxls8NbnEL5uz/epA1
         Pmt1hTOXuDp5koprA5shc/IwVdQlaRQwgVpfL1Crhlg/zW6Q1ltWLG1cR4SgLtTzrRl1
         Cz5KmfOMibpWdfu/KiYwm9HieSqeiH+FqCbf3cbZeqNARIW5j5odkJpq0NCB1ipuUZMf
         LJRQ==
Received: by 10.68.129.98 with SMTP id nv2mr19690026pbb.140.1337200968469;
        Wed, 16 May 2012 13:42:48 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([175.103.19.195])
        by mx.google.com with ESMTPS id qq2sm2208723pbc.27.2012.05.16.13.42.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 13:42:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.514.ge33c7ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197900>

The documentation of the dcommit subcommand is reworded to clarify that
the optional argument refers to a git branch, not an SVN branch.

The discussion of the optional argument is put into its own paragraph
as is the guidance about using 'dcommit' in preference to 'set-tree'.

The section on REBASE vs. PULL/MERGE is reworded to incorporate the
advice to prefer 'git rebase' previously in the description of 'dcommit'.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-svn.txt | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

Restore original meaning that pull/merge causes issues specifically 
with set-tree A..B (not with set-tree A, in general).

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 34ee785..4384ed9 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -189,18 +189,16 @@ and have no uncommitted changes.
 	last fetched commit from the upstream SVN.
 
 'dcommit'::
-	Commit each diff from a specified head directly to the SVN
+	Commit each diff from the current branch directly to the SVN
 	repository, and then rebase or reset (depending on whether or
 	not there is a diff between SVN and head).  This will create
 	a revision in SVN for each commit in git.
-	It is recommended that you run 'git svn' fetch and rebase (not
-	pull or merge) your commits against the latest changes in the
-	SVN repository.
-	An optional revision or branch argument may be specified, and
-	causes 'git svn' to do all work on that revision/branch
-	instead of HEAD.
-	This is advantageous over 'set-tree' (below) because it produces
-	cleaner, more linear history.
++
+When an optional git branch name (or a git commit object name)
+is specified as an argument, the subcommand works on the specified
+branch, not on the current branch.
++
+Use of 'dcommit' is preferred to 'set-tree' (below).
 +
 --no-rebase;;
 	After committing, do not rebase or reset.
@@ -800,18 +798,18 @@ have each person clone that repository with 'git clone':
 
 REBASE VS. PULL/MERGE
 ---------------------
-
-Originally, 'git svn' recommended that the 'remotes/git-svn' branch be
-pulled or merged from.  This is because the author favored
-`git svn set-tree B` to commit a single head rather than the
-`git svn set-tree A..B` notation to commit multiple commits.
-
-If you use `git svn set-tree A..B` to commit several diffs and you do
-not have the latest remotes/git-svn merged into my-branch, you should
-use `git svn rebase` to update your work branch instead of `git pull` or
-`git merge`.  `pull`/`merge` can cause non-linear history to be flattened
-when committing into SVN, which can lead to merge commits reversing
-previous commits in SVN.
+Prefer to use 'git svn rebase' or 'git rebase', rather than
+'git pull' or 'git merge' to synchronize unintegrated commits with a 'git svn'
+branch. Doing so will keep the history of unintegrated commits linear with
+respect to the upstream SVN repository and allow the use of the preferred
+'git svn dcommit' subcommand to push unintegrated commits back into SVN.
+
+Originally, 'git svn' recommended that developers pulled or merged from
+the 'git svn' branch.  This was because the author favored `git svn set-tree B`
+to commit a single head rather than the `git svn set-tree A..B` notation to
+commit multiple commits. Use of 'git pull' or 'git merge' with `git svn set-tree A...B` 
+will cause non-linear history will be flattened when committing into SVN and 
+this can lead to merge commits unexpectedly reversing previous commits in SVN.
 
 MERGE TRACKING
 --------------
-- 
1.7.10.1.514.ge33c7ea
