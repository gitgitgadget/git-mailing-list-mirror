From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 5/5] Add a test of "git cvsimport"'s handling of tags and branches
Date: Mon, 23 Feb 2009 06:08:14 +0100
Message-ID: <9e78f6376c3ca9127728cdf9c4c3a869df73ed51.1235364493.git.mhagger@alum.mit.edu>
References: <1235365694-28935-1-git-send-email-mhagger@alum.mit.edu>
 <ee46eff8fc1cb2d0ad3d8dfac2fbe4d79f225e3a.1235364493.git.mhagger@alum.mit.edu>
 <7d834a5a7542df6bfa8963bb6440cc4b4531ead7.1235364493.git.mhagger@alum.mit.edu>
 <24f32b195f4dbfa0e1dda8b30097becdb3c2d3b7.1235364493.git.mhagger@alum.mit.edu>
 <0ceb6eefc5d16857dfe4c3433a0e4339381a929f.1235364493.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 06:10:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbT5B-00014D-FX
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 06:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbZBWFIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 00:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbZBWFIs
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 00:08:48 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:37142 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbZBWFIi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 00:08:38 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (77-21-84-251-dynip.superkabel.de [77.21.84.251])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n1N58Eg2019166;
	Mon, 23 Feb 2009 06:08:17 +0100
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <0ceb6eefc5d16857dfe4c3433a0e4339381a929f.1235364493.git.mhagger@alum.mit.edu>
In-Reply-To: <ee46eff8fc1cb2d0ad3d8dfac2fbe4d79f225e3a.1235364493.git.mhagger@alum.mit.edu>
References: <ee46eff8fc1cb2d0ad3d8dfac2fbe4d79f225e3a.1235364493.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111086>

6 out of 11 of these tests fail.

The test CVS repository used for these tests is derived from one in
cvs2svn's test suite.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t9602-cvsimport-branches-tags.sh                 |   79 ++++++++++++++
 t/t9602/README                                     |   62 +++++++++++
 t/t9602/cvsroot/.gitattributes                     |    1 +
 t/t9602/cvsroot/CVSROOT/.gitignore                 |    2 +
 t/t9602/cvsroot/module/default,v                   |  102 +++++++++++++++++++
 t/t9602/cvsroot/module/sub1/default,v              |  102 +++++++++++++++++++
 t/t9602/cvsroot/module/sub1/subsubA/default,v      |  101 ++++++++++++++++++
 t/t9602/cvsroot/module/sub1/subsubB/default,v      |  107 ++++++++++++++++++++
 .../module/sub2/Attic/branch_B_MIXED_only,v        |   59 +++++++++++
 t/t9602/cvsroot/module/sub2/default,v              |  102 +++++++++++++++++++
 t/t9602/cvsroot/module/sub2/subsubA/default,v      |  102 +++++++++++++++++++
 t/t9602/cvsroot/module/sub3/default,v              |  102 +++++++++++++++++++
 12 files changed, 921 insertions(+), 0 deletions(-)
 create mode 100755 t/t9602-cvsimport-branches-tags.sh
 create mode 100644 t/t9602/README
 create mode 100644 t/t9602/cvsroot/.gitattributes
 create mode 100644 t/t9602/cvsroot/CVSROOT/.gitignore
 create mode 100644 t/t9602/cvsroot/module/default,v
 create mode 100644 t/t9602/cvsroot/module/sub1/default,v
 create mode 100644 t/t9602/cvsroot/module/sub1/subsubA/default,v
 create mode 100644 t/t9602/cvsroot/module/sub1/subsubB/default,v
 create mode 100644 t/t9602/cvsroot/module/sub2/Attic/branch_B_MIXED_only,v
 create mode 100644 t/t9602/cvsroot/module/sub2/default,v
 create mode 100644 t/t9602/cvsroot/module/sub2/subsubA/default,v
 create mode 100644 t/t9602/cvsroot/module/sub3/default,v

diff --git a/t/t9602-cvsimport-branches-tags.sh b/t/t9602-cvsimport-branches-tags.sh
new file mode 100755
index 0000000..67878b2
--- /dev/null
+++ b/t/t9602-cvsimport-branches-tags.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+# A description of the repository used for this test can be found in
+# t9602/README.
+
+test_description='git cvsimport handling of branches and tags'
+. ./lib-cvs.sh
+
+CVSROOT="$TEST_DIRECTORY"/t9602/cvsroot
+export CVSROOT
+
+test_expect_success 'import module' '
+
+	git cvsimport -C module-git module
+
+'
+
+test_expect_success 'test branch master' '
+
+	test_cmp_branch_tree master
+
+'
+
+test_expect_success 'test branch vendorbranch' '
+
+	test_cmp_branch_tree vendorbranch
+
+'
+
+test_expect_failure 'test branch B_FROM_INITIALS' '
+
+	test_cmp_branch_tree B_FROM_INITIALS
+
+'
+
+test_expect_failure 'test branch B_FROM_INITIALS_BUT_ONE' '
+
+	test_cmp_branch_tree B_FROM_INITIALS_BUT_ONE
+
+'
+
+test_expect_failure 'test branch B_MIXED' '
+
+	test_cmp_branch_tree B_MIXED
+
+'
+
+test_expect_success 'test branch B_SPLIT' '
+
+	test_cmp_branch_tree B_SPLIT
+
+'
+
+test_expect_failure 'test tag vendortag' '
+
+	test_cmp_branch_tree vendortag
+
+'
+
+test_expect_success 'test tag T_ALL_INITIAL_FILES' '
+
+	test_cmp_branch_tree T_ALL_INITIAL_FILES
+
+'
+
+test_expect_failure 'test tag T_ALL_INITIAL_FILES_BUT_ONE' '
+
+	test_cmp_branch_tree T_ALL_INITIAL_FILES_BUT_ONE
+
+'
+
+test_expect_failure 'test tag T_MIXED' '
+
+	test_cmp_branch_tree T_MIXED
+
+'
+
+
+test_done
diff --git a/t/t9602/README b/t/t9602/README
new file mode 100644
index 0000000..c231e0f
--- /dev/null
+++ b/t/t9602/README
@@ -0,0 +1,62 @@
+This repository is for testing the ability to group revisions
+correctly along tags and branches.  Here is its history:
+
+  1.  The initial import (revision 1.1 of everybody) created a
+      directory structure with a file named `default' in each dir:
+
+            ./
+              default
+              sub1/default
+                   subsubA/default
+                   subsubB/default
+              sub2/default
+                   subsubA/default
+              sub3/default
+
+  2.  Then tagged everyone with T_ALL_INITIAL_FILES.
+
+  3.  Then tagged everyone except sub1/subsubB/default with
+      T_ALL_INITIAL_FILES_BUT_ONE.
+
+  4.  Then created branch B_FROM_INITIALS on everyone.
+
+  5.  Then created branch B_FROM_INITIALS_BUT_ONE on everyone except
+      /sub1/subsubB/default.
+
+  6.  Then committed modifications to two files: sub3/default, and
+      sub1/subsubA/default.
+
+  7.  Then committed a modification to all 7 files.
+
+  8.  Then backdated sub3/default to revision 1.2, and
+      sub2/subsubA/default to revision 1.1, and tagged with T_MIXED.
+
+  9.  Same as 8, but tagged with -b to create branch B_MIXED.
+
+  10. Switched the working copy to B_MIXED, and added
+      sub2/branch_B_MIXED_only.  (That's why the RCS file is in
+      sub2/Attic/ -- it never existed on trunk.)
+
+  11. In one commit, modified default, sub1/default, and
+      sub2/subsubA/default, on branch B_MIXED.
+
+  12. Did "cvs up -A" on sub2/default, then in one commit, made a
+      change to sub2/default and sub2/branch_B_MIXED_only.  So this
+      commit should be spread between the branch and the trunk.
+
+  13. Do "cvs up -A" to get everyone back to trunk, then make a new
+      branch B_SPLIT on everyone except sub1/subsubB/default,v.
+
+  14. Switch to branch B_SPLIT (see sub1/subsubB/default disappear)
+      and commit a change that affects everyone except sub3/default.
+
+  15. An hour or so later, "cvs up -A" to get sub1/subsubB/default
+      back, then commit a change on that file, on trunk.  (It's
+      important that this change happened after the previous commits
+      on B_SPLIT.)
+
+  16. Branch sub1/subsubB/default to B_SPLIT, then "cvs up -r B_SPLIT"
+      to switch the whole working copy to the branch.
+
+  17. Commit a change on B_SPLIT, to sub1/subsubB/default and
+      sub3/default.
diff --git a/t/t9602/cvsroot/.gitattributes b/t/t9602/cvsroot/.gitattributes
new file mode 100644
index 0000000..562b12e
--- /dev/null
+++ b/t/t9602/cvsroot/.gitattributes
@@ -0,0 +1 @@
+* -whitespace
diff --git a/t/t9602/cvsroot/CVSROOT/.gitignore b/t/t9602/cvsroot/CVSROOT/.gitignore
new file mode 100644
index 0000000..3bb9b34
--- /dev/null
+++ b/t/t9602/cvsroot/CVSROOT/.gitignore
@@ -0,0 +1,2 @@
+history
+val-tags
diff --git a/t/t9602/cvsroot/module/default,v b/t/t9602/cvsroot/module/default,v
new file mode 100644
index 0000000..3b68382
--- /dev/null
+++ b/t/t9602/cvsroot/module/default,v
@@ -0,0 +1,102 @@
+head	1.2;
+access;
+symbols
+	B_SPLIT:1.2.0.4
+	B_MIXED:1.2.0.2
+	T_MIXED:1.2
+	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
+	B_FROM_INITIALS:1.1.1.1.0.2
+	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
+	T_ALL_INITIAL_FILES:1.1.1.1
+	vendortag:1.1.1.1
+	vendorbranch:1.1.1;
+locks; strict;
+comment	@# @;
+
+
+1.2
+date	2003.05.23.00.17.53;	author jrandom;	state Exp;
+branches
+	1.2.2.1
+	1.2.4.1;
+next	1.1;
+
+1.1
+date	2003.05.22.23.20.19;	author jrandom;	state Exp;
+branches
+	1.1.1.1;
+next	;
+
+1.1.1.1
+date	2003.05.22.23.20.19;	author jrandom;	state Exp;
+branches;
+next	;
+
+1.2.2.1
+date	2003.05.23.00.31.36;	author jrandom;	state Exp;
+branches;
+next	;
+
+1.2.4.1
+date	2003.06.03.03.20.31;	author jrandom;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.2
+log
+@Second commit to proj, affecting all 7 files.
+@
+text
+@This is the file `default' in the top level of the project.
+
+Every directory in the `proj' project has a file named `default'.
+
+This line was added in the second commit (affecting all 7 files).
+@
+
+
+1.2.4.1
+log
+@First change on branch B_SPLIT.
+
+This change excludes sub3/default, because it was not part of this
+commit, and sub1/subsubB/default, which is not even on the branch yet.
+@
+text
+@a5 2
+
+First change on branch B_SPLIT.
+@
+
+
+1.2.2.1
+log
+@Modify three files, on branch B_MIXED.
+@
+text
+@a5 2
+
+This line was added on branch B_MIXED only (affecting 3 files).
+@
+
+
+1.1
+log
+@Initial revision
+@
+text
+@d4 2
+@
+
+
+1.1.1.1
+log
+@Initial import.
+@
+text
+@@
diff --git a/t/t9602/cvsroot/module/sub1/default,v b/t/t9602/cvsroot/module/sub1/default,v
new file mode 100644
index 0000000..b7fdccd
--- /dev/null
+++ b/t/t9602/cvsroot/module/sub1/default,v
@@ -0,0 +1,102 @@
+head	1.2;
+access;
+symbols
+	B_SPLIT:1.2.0.4
+	B_MIXED:1.2.0.2
+	T_MIXED:1.2
+	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
+	B_FROM_INITIALS:1.1.1.1.0.2
+	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
+	T_ALL_INITIAL_FILES:1.1.1.1
+	vendortag:1.1.1.1
+	vendorbranch:1.1.1;
+locks; strict;
+comment	@# @;
+
+
+1.2
+date	2003.05.23.00.17.53;	author jrandom;	state Exp;
+branches
+	1.2.2.1
+	1.2.4.1;
+next	1.1;
+
+1.1
+date	2003.05.22.23.20.19;	author jrandom;	state Exp;
+branches
+	1.1.1.1;
+next	;
+
+1.1.1.1
+date	2003.05.22.23.20.19;	author jrandom;	state Exp;
+branches;
+next	;
+
+1.2.2.1
+date	2003.05.23.00.31.36;	author jrandom;	state Exp;
+branches;
+next	;
+
+1.2.4.1
+date	2003.06.03.03.20.31;	author jrandom;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.2
+log
+@Second commit to proj, affecting all 7 files.
+@
+text
+@This is sub1/default.
+
+Every directory in the `proj' project has a file named `default'.
+
+This line was added in the second commit (affecting all 7 files).
+@
+
+
+1.2.4.1
+log
+@First change on branch B_SPLIT.
+
+This change excludes sub3/default, because it was not part of this
+commit, and sub1/subsubB/default, which is not even on the branch yet.
+@
+text
+@a5 2
+
+First change on branch B_SPLIT.
+@
+
+
+1.2.2.1
+log
+@Modify three files, on branch B_MIXED.
+@
+text
+@a5 2
+
+This line was added on branch B_MIXED only (affecting 3 files).
+@
+
+
+1.1
+log
+@Initial revision
+@
+text
+@d4 2
+@
+
+
+1.1.1.1
+log
+@Initial import.
+@
+text
+@@
diff --git a/t/t9602/cvsroot/module/sub1/subsubA/default,v b/t/t9602/cvsroot/module/sub1/subsubA/default,v
new file mode 100644
index 0000000..472b7b2
--- /dev/null
+++ b/t/t9602/cvsroot/module/sub1/subsubA/default,v
@@ -0,0 +1,101 @@
+head	1.3;
+access;
+symbols
+	B_SPLIT:1.3.0.4
+	B_MIXED:1.3.0.2
+	T_MIXED:1.3
+	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
+	B_FROM_INITIALS:1.1.1.1.0.2
+	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
+	T_ALL_INITIAL_FILES:1.1.1.1
+	vendortag:1.1.1.1
+	vendorbranch:1.1.1;
+locks; strict;
+comment	@# @;
+
+
+1.3
+date	2003.05.23.00.17.53;	author jrandom;	state Exp;
+branches
+	1.3.4.1;
+next	1.2;
+
+1.2
+date	2003.05.23.00.15.26;	author jrandom;	state Exp;
+branches;
+next	1.1;
+
+1.1
+date	2003.05.22.23.20.19;	author jrandom;	state Exp;
+branches
+	1.1.1.1;
+next	;
+
+1.1.1.1
+date	2003.05.22.23.20.19;	author jrandom;	state Exp;
+branches;
+next	;
+
+1.3.4.1
+date	2003.06.03.03.20.31;	author jrandom;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.3
+log
+@Second commit to proj, affecting all 7 files.
+@
+text
+@This is sub1/subsubA/default.
+
+Every directory in the `proj' project has a file named `default'.
+
+This line was added by the first commit (affecting two files).
+
+This line was added in the second commit (affecting all 7 files).
+@
+
+
+1.3.4.1
+log
+@First change on branch B_SPLIT.
+
+This change excludes sub3/default, because it was not part of this
+commit, and sub1/subsubB/default, which is not even on the branch yet.
+@
+text
+@a7 2
+
+First change on branch B_SPLIT.
+@
+
+
+1.2
+log
+@First commit to proj, affecting two files.
+@
+text
+@d6 2
+@
+
+
+1.1
+log
+@Initial revision
+@
+text
+@d4 2
+@
+
+
+1.1.1.1
+log
+@Initial import.
+@
+text
+@@
diff --git a/t/t9602/cvsroot/module/sub1/subsubB/default,v b/t/t9602/cvsroot/module/sub1/subsubB/default,v
new file mode 100644
index 0000000..fe6efa4
--- /dev/null
+++ b/t/t9602/cvsroot/module/sub1/subsubB/default,v
@@ -0,0 +1,107 @@
+head	1.3;
+access;
+symbols
+	B_SPLIT:1.3.0.2
+	B_MIXED:1.2.0.2
+	T_MIXED:1.2
+	B_FROM_INITIALS:1.1.1.1.0.2
+	T_ALL_INITIAL_FILES:1.1.1.1
+	vendortag:1.1.1.1
+	vendorbranch:1.1.1;
+locks; strict;
+comment	@# @;
+
+
+1.3
+date	2003.06.03.04.29.14;	author jrandom;	state Exp;
+branches
+	1.3.2.1;
+next	1.2;
+
+1.2
+date	2003.05.23.00.17.53;	author jrandom;	state Exp;
+branches;
+next	1.1;
+
+1.1
+date	2003.05.22.23.20.19;	author jrandom;	state Exp;
+branches
+	1.1.1.1;
+next	;
+
+1.1.1.1
+date	2003.05.22.23.20.19;	author jrandom;	state Exp;
+branches;
+next	;
+
+1.3.2.1
+date	2003.06.03.04.33.13;	author jrandom;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.3
+log
+@A trunk change to sub1/subsubB/default.  This was committed about an
+hour after an earlier change that affected most files on branch
+B_SPLIT.  This file is not on that branch yet, but after this commit,
+we'll branch to B_SPLIT, albeit rooted in a revision that didn't exist
+at the time the rest of B_SPLIT was created.
+@
+text
+@This is sub1/subsubB/default.
+
+Every directory in the `proj' project has a file named `default'.
+
+This line was added in the second commit (affecting all 7 files).
+
+This bit was committed on trunk about an hour after an earlier change
+to everyone else on branch B_SPLIT.  Afterwards, we'll finally branch
+this file to B_SPLIT, but rooted in a revision that didn't exist at
+the time the rest of B_SPLIT was created.
+@
+
+
+1.3.2.1
+log
+@This change affects sub3/default and sub1/subsubB/default, on branch
+B_SPLIT.  Note that the latter file did not even exist on this branch
+until after some other files had had revisions committed on B_SPLIT.
+@
+text
+@a10 4
+
+This change affects sub3/default and sub1/subsubB/default, on branch
+B_SPLIT.  Note that the latter file did not even exist on this branch
+until after some other files had had revisions committed on B_SPLIT.
+@
+
+
+1.2
+log
+@Second commit to proj, affecting all 7 files.
+@
+text
+@d6 5
+@
+
+
+1.1
+log
+@Initial revision
+@
+text
+@d4 2
+@
+
+
+1.1.1.1
+log
+@Initial import.
+@
+text
+@@
diff --git a/t/t9602/cvsroot/module/sub2/Attic/branch_B_MIXED_only,v b/t/t9602/cvsroot/module/sub2/Attic/branch_B_MIXED_only,v
new file mode 100644
index 0000000..34c9789
--- /dev/null
+++ b/t/t9602/cvsroot/module/sub2/Attic/branch_B_MIXED_only,v
@@ -0,0 +1,59 @@
+head	1.1;
+access;
+symbols
+	B_MIXED:1.1.0.2;
+locks; strict;
+comment	@# @;
+
+
+1.1
+date	2003.05.23.00.25.26;	author jrandom;	state dead;
+branches
+	1.1.2.1;
+next	;
+
+1.1.2.1
+date	2003.05.23.00.25.26;	author jrandom;	state Exp;
+branches;
+next	1.1.2.2;
+
+1.1.2.2
+date	2003.05.23.00.48.51;	author jrandom;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.1
+log
+@file branch_B_MIXED_only was initially added on branch B_MIXED.
+@
+text
+@@
+
+
+1.1.2.1
+log
+@Add a file on branch B_MIXED.
+@
+text
+@a0 1
+This file was added on branch B_MIXED.  It never existed on trunk.
+@
+
+
+1.1.2.2
+log
+@A single commit affecting one file on branch B_MIXED and one on trunk.
+@
+text
+@a1 3
+
+The same commit added these two lines here on branch B_MIXED, and two
+similar lines to ./default on trunk.
+@
+
+
diff --git a/t/t9602/cvsroot/module/sub2/default,v b/t/t9602/cvsroot/module/sub2/default,v
new file mode 100644
index 0000000..018f7f8
--- /dev/null
+++ b/t/t9602/cvsroot/module/sub2/default,v
@@ -0,0 +1,102 @@
+head	1.3;
+access;
+symbols
+	B_SPLIT:1.3.0.2
+	B_MIXED:1.2.0.2
+	T_MIXED:1.2
+	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
+	B_FROM_INITIALS:1.1.1.1.0.2
+	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
+	T_ALL_INITIAL_FILES:1.1.1.1
+	vendortag:1.1.1.1
+	vendorbranch:1.1.1;
+locks; strict;
+comment	@# @;
+
+
+1.3
+date	2003.05.23.00.48.51;	author jrandom;	state Exp;
+branches
+	1.3.2.1;
+next	1.2;
+
+1.2
+date	2003.05.23.00.17.53;	author jrandom;	state Exp;
+branches;
+next	1.1;
+
+1.1
+date	2003.05.22.23.20.19;	author jrandom;	state Exp;
+branches
+	1.1.1.1;
+next	;
+
+1.1.1.1
+date	2003.05.22.23.20.19;	author jrandom;	state Exp;
+branches;
+next	;
+
+1.3.2.1
+date	2003.06.03.03.20.31;	author jrandom;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.3
+log
+@A single commit affecting one file on branch B_MIXED and one on trunk.
+@
+text
+@This is sub2/default.
+
+Every directory in the `proj' project has a file named `default'.
+
+This line was added in the second commit (affecting all 7 files).
+
+The same commit added these two lines here on trunk, and two similar
+lines to ./branch_B_MIXED_only on branch B_MIXED.
+@
+
+
+1.3.2.1
+log
+@First change on branch B_SPLIT.
+
+This change excludes sub3/default, because it was not part of this
+commit, and sub1/subsubB/default, which is not even on the branch yet.
+@
+text
+@a8 2
+
+First change on branch B_SPLIT.
+@
+
+
+1.2
+log
+@Second commit to proj, affecting all 7 files.
+@
+text
+@d6 3
+@
+
+
+1.1
+log
+@Initial revision
+@
+text
+@d4 2
+@
+
+
+1.1.1.1
+log
+@Initial import.
+@
+text
+@@
diff --git a/t/t9602/cvsroot/module/sub2/subsubA/default,v b/t/t9602/cvsroot/module/sub2/subsubA/default,v
new file mode 100644
index 0000000..d13242c
--- /dev/null
+++ b/t/t9602/cvsroot/module/sub2/subsubA/default,v
@@ -0,0 +1,102 @@
+head	1.2;
+access;
+symbols
+	B_SPLIT:1.2.0.2
+	B_MIXED:1.1.0.2
+	T_MIXED:1.1
+	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
+	B_FROM_INITIALS:1.1.1.1.0.2
+	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
+	T_ALL_INITIAL_FILES:1.1.1.1
+	vendortag:1.1.1.1
+	vendorbranch:1.1.1;
+locks; strict;
+comment	@# @;
+
+
+1.2
+date	2003.05.23.00.17.53;	author jrandom;	state Exp;
+branches
+	1.2.2.1;
+next	1.1;
+
+1.1
+date	2003.05.22.23.20.19;	author jrandom;	state Exp;
+branches
+	1.1.1.1
+	1.1.2.1;
+next	;
+
+1.1.1.1
+date	2003.05.22.23.20.19;	author jrandom;	state Exp;
+branches;
+next	;
+
+1.1.2.1
+date	2003.05.23.00.31.36;	author jrandom;	state Exp;
+branches;
+next	;
+
+1.2.2.1
+date	2003.06.03.03.20.31;	author jrandom;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.2
+log
+@Second commit to proj, affecting all 7 files.
+@
+text
+@This is sub2/subsub2/default.
+
+Every directory in the `proj' project has a file named `default'.
+
+This line was added in the second commit (affecting all 7 files).
+@
+
+
+1.2.2.1
+log
+@First change on branch B_SPLIT.
+
+This change excludes sub3/default, because it was not part of this
+commit, and sub1/subsubB/default, which is not even on the branch yet.
+@
+text
+@a5 2
+
+First change on branch B_SPLIT.
+@
+
+
+1.1
+log
+@Initial revision
+@
+text
+@d4 2
+@
+
+
+1.1.2.1
+log
+@Modify three files, on branch B_MIXED.
+@
+text
+@a3 2
+
+This line was added on branch B_MIXED only (affecting 3 files).
+@
+
+
+1.1.1.1
+log
+@Initial import.
+@
+text
+@@
diff --git a/t/t9602/cvsroot/module/sub3/default,v b/t/t9602/cvsroot/module/sub3/default,v
new file mode 100644
index 0000000..88e4567
--- /dev/null
+++ b/t/t9602/cvsroot/module/sub3/default,v
@@ -0,0 +1,102 @@
+head	1.3;
+access;
+symbols
+	B_SPLIT:1.3.0.2
+	B_MIXED:1.2.0.2
+	T_MIXED:1.2
+	B_FROM_INITIALS_BUT_ONE:1.1.1.1.0.4
+	B_FROM_INITIALS:1.1.1.1.0.2
+	T_ALL_INITIAL_FILES_BUT_ONE:1.1.1.1
+	T_ALL_INITIAL_FILES:1.1.1.1
+	vendortag:1.1.1.1
+	vendorbranch:1.1.1;
+locks; strict;
+comment	@# @;
+
+
+1.3
+date	2003.05.23.00.17.53;	author jrandom;	state Exp;
+branches
+	1.3.2.1;
+next	1.2;
+
+1.2
+date	2003.05.23.00.15.26;	author jrandom;	state Exp;
+branches;
+next	1.1;
+
+1.1
+date	2003.05.22.23.20.19;	author jrandom;	state Exp;
+branches
+	1.1.1.1;
+next	;
+
+1.1.1.1
+date	2003.05.22.23.20.19;	author jrandom;	state Exp;
+branches;
+next	;
+
+1.3.2.1
+date	2003.06.03.04.33.13;	author jrandom;	state Exp;
+branches;
+next	;
+
+
+desc
+@@
+
+
+1.3
+log
+@Second commit to proj, affecting all 7 files.
+@
+text
+@This is sub3/default.
+
+Every directory in the `proj' project has a file named `default'.
+
+This line was added by the first commit (affecting two files).
+
+This line was added in the second commit (affecting all 7 files).
+@
+
+
+1.3.2.1
+log
+@This change affects sub3/default and sub1/subsubB/default, on branch
+B_SPLIT.  Note that the latter file did not even exist on this branch
+until after some other files had had revisions committed on B_SPLIT.
+@
+text
+@a7 4
+
+This change affects sub3/default and sub1/subsubB/default, on branch
+B_SPLIT.  Note that the latter file did not even exist on this branch
+until after some other files had had revisions committed on B_SPLIT.
+@
+
+
+1.2
+log
+@First commit to proj, affecting two files.
+@
+text
+@d6 2
+@
+
+
+1.1
+log
+@Initial revision
+@
+text
+@d4 2
+@
+
+
+1.1.1.1
+log
+@Initial import.
+@
+text
+@@
-- 
1.6.1.3
