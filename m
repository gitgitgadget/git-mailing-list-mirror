From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/2] Documentation: move options of git-diff-tree to a separate file.
Date: Sat, 26 Apr 2008 23:01:06 +0200
Message-ID: <b57b2d5d484b6e099382900069ed6ca2afc6922d.1209243527.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 23:02:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JprXI-0002uZ-6o
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 23:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760162AbYDZVBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 17:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759654AbYDZVBZ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 17:01:25 -0400
Received: from virgo.iok.hu ([193.202.89.103]:45163 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759106AbYDZVBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 17:01:25 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id AD5F01B25A1;
	Sat, 26 Apr 2008 23:01:23 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 81FA344668;
	Sat, 26 Apr 2008 22:57:43 +0200 (CEST)
Received: from vmobile.example.net (dsl5401CCC2.pool.t-online.hu [84.1.204.194])
	by genesis.frugalware.org (Postfix) with ESMTP id DEA4111904D3;
	Sat, 26 Apr 2008 23:01:20 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 9F0FB186105; Sat, 26 Apr 2008 23:01:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80391>

These options are used by high-level commands, like git-show; moving the
options to a separate file makes it possible to include the options in
the high-level manges as well.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/diff-tree-options.txt |   64 +++++++++++++++++++++++++++++++++
 Documentation/git-diff-tree.txt     |   66 +---------------------------------
 2 files changed, 66 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/diff-tree-options.txt

diff --git a/Documentation/diff-tree-options.txt b/Documentation/diff-tree-options.txt
new file mode 100644
index 0000000..24a47f4
--- /dev/null
+++ b/Documentation/diff-tree-options.txt
@@ -0,0 +1,64 @@
+-r::
+        recurse into sub-trees
+
+-t::
+	show tree entry itself as well as subtrees.  Implies -r.
+
+--root::
+	When '--root' is specified the initial commit will be showed as a big
+	creation event. This is equivalent to a diff against the NULL tree.
+
+--stdin::
+	When '--stdin' is specified, the command does not take
+	<tree-ish> arguments from the command line.  Instead, it
+	reads either one <commit> or a pair of <tree-ish>
+	separated with a single space from its standard input.
++
+When a single commit is given on one line of such input, it compares
+the commit with its parents.  The following flags further affects its
+behavior.  This does not apply to the case where two <tree-ish>
+separated with a single space are given.
+
+-m::
+	By default, "--stdin" does not show
+	differences for merge commits.  With this flag, it shows
+	differences to that commit from all of its parents. See
+	also '-c'.
+
+-s::
+	By default, "--stdin" shows differences,
+	either in machine-readable form (without '-p') or in patch
+	form (with '-p').  This output can be suppressed.  It is
+	only useful with '-v' flag.
+
+-v::
+	This flag causes "--stdin" to also show
+	the commit message before the differences.
+
+--no-commit-id::
+	The output contains a line with the commit ID when
+	applicable.  This flag suppressed the commit ID output.
+
+-c::
+	This flag changes the way a merge commit is displayed
+	(which means it is useful only when the command is given
+	one <tree-ish>, or '--stdin').  It shows the differences
+	from each of the parents to the merge result simultaneously
+	instead of showing pairwise diff between a parent and the
+	result one at a time (which is what the '-m' option does).
+	Furthermore, it lists only files which were modified
+	from all parents.
+
+--cc::
+	This flag changes the way a merge commit patch is displayed,
+	in a similar way to the '-c' option. It implies the '-c'
+	and '-p' options and further compresses the patch output
+	by omitting hunks that show differences from only one
+	parent, or show the same change from all but one parent
+	for an Octopus merge.  When this optimization makes all
+	hunks disappear, the commit itself and the commit log
+	message is not shown, just like in any other "empty diff" case.
+
+--always::
+	Show the commit itself and the commit log message even
+	if the diff itself is empty.
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 58d02c6..b91cbde 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -36,72 +36,10 @@ include::diff-options.txt[]
 	Note that this parameter does not provide any wildcard or regexp
 	features.
 
--r::
-        recurse into sub-trees
-
--t::
-	show tree entry itself as well as subtrees.  Implies -r.
-
---root::
-	When '--root' is specified the initial commit will be showed as a big
-	creation event. This is equivalent to a diff against the NULL tree.
-
---stdin::
-	When '--stdin' is specified, the command does not take
-	<tree-ish> arguments from the command line.  Instead, it
-	reads either one <commit> or a pair of <tree-ish>
-	separated with a single space from its standard input.
-+
-When a single commit is given on one line of such input, it compares
-the commit with its parents.  The following flags further affects its
-behavior.  This does not apply to the case where two <tree-ish>
-separated with a single space are given.
-
--m::
-	By default, "git-diff-tree --stdin" does not show
-	differences for merge commits.  With this flag, it shows
-	differences to that commit from all of its parents. See
-	also '-c'.
-
--s::
-	By default, "git-diff-tree --stdin" shows differences,
-	either in machine-readable form (without '-p') or in patch
-	form (with '-p').  This output can be suppressed.  It is
-	only useful with '-v' flag.
-
--v::
-	This flag causes "git-diff-tree --stdin" to also show
-	the commit message before the differences.
+include::diff-tree-options.txt[]
 
-include::pretty-options.txt[]
 
---no-commit-id::
-	git-diff-tree outputs a line with the commit ID when
-	applicable.  This flag suppressed the commit ID output.
-
--c::
-	This flag changes the way a merge commit is displayed
-	(which means it is useful only when the command is given
-	one <tree-ish>, or '--stdin').  It shows the differences
-	from each of the parents to the merge result simultaneously
-	instead of showing pairwise diff between a parent and the
-	result one at a time (which is what the '-m' option does).
-	Furthermore, it lists only files which were modified
-	from all parents.
-
---cc::
-	This flag changes the way a merge commit patch is displayed,
-	in a similar way to the '-c' option. It implies the '-c'
-	and '-p' options and further compresses the patch output
-	by omitting hunks that show differences from only one
-	parent, or show the same change from all but one parent
-	for an Octopus merge.  When this optimization makes all
-	hunks disappear, the commit itself and the commit log
-	message is not shown, just like in any other "empty diff" case.
-
---always::
-	Show the commit itself and the commit log message even
-	if the diff itself is empty.
+include::pretty-options.txt[]
 
 
 include::pretty-formats.txt[]
-- 
1.5.5.1
