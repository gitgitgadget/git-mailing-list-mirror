From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Documentation: move options of git-diff-tree to a separate file.
Date: Sun, 27 Apr 2008 04:17:41 +0200
Message-ID: <1209262661-14370-1-git-send-email-vmiklos@frugalware.org>
References: <7vod7wkuue.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 04:18:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpwTX-0005X7-Kl
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 04:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbYD0CSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 22:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbYD0CSA
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 22:18:00 -0400
Received: from virgo.iok.hu ([193.202.89.103]:46069 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742AbYD0CR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 22:17:59 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 9F7291B251C;
	Sun, 27 Apr 2008 04:17:57 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 55C7544659;
	Sun, 27 Apr 2008 04:14:17 +0200 (CEST)
Received: from vmobile.example.net (catv-5062e605.catv.broadband.hu [80.98.230.5])
	by genesis.frugalware.org (Postfix) with ESMTP id 2DA2111901AE;
	Sun, 27 Apr 2008 04:17:55 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 62736186104; Sun, 27 Apr 2008 04:17:41 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <7vod7wkuue.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80403>

These options are used by high-level commands, like git-show; moving the
options to a separate file makes it possible to include the options in
the high-level manges as well.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sat, Apr 26, 2008 at 05:24:57PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Are you sure "git show" takes --stdin?
>
> Also for "show", listing --cc as one of the options does not make much
> sense, as that is an unoverridable default.
>
> And no, making it overridable so that it can take -m to show
> independent
> diff against each parent of a merge commit do not make much sense in
> the
> context of "git show".

Right, --stdin and --cc is not something I should move
to diff-tree-options.txt. Updated patch below.

 Documentation/diff-tree-options.txt |   43 ++++++++++++++++++++++++++++++
 Documentation/git-diff-tree.txt     |   49 +++--------------------------------
 2 files changed, 47 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/diff-tree-options.txt

diff --git a/Documentation/diff-tree-options.txt b/Documentation/diff-tree-options.txt
new file mode 100644
index 0000000..3049ede
--- /dev/null
+++ b/Documentation/diff-tree-options.txt
@@ -0,0 +1,43 @@
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
+--always::
+	Show the commit itself and the commit log message even
+	if the diff itself is empty.
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 58d02c6..55345df 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -36,16 +36,6 @@ include::diff-options.txt[]
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
 --stdin::
 	When '--stdin' is specified, the command does not take
 	<tree-ish> arguments from the command line.  Instead, it
@@ -57,38 +47,6 @@ the commit with its parents.  The following flags further affects its
 behavior.  This does not apply to the case where two <tree-ish>
 separated with a single space are given.
 
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
-
-include::pretty-options.txt[]
-
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
 --cc::
 	This flag changes the way a merge commit patch is displayed,
 	in a similar way to the '-c' option. It implies the '-c'
@@ -99,9 +57,10 @@ include::pretty-options.txt[]
 	hunks disappear, the commit itself and the commit log
 	message is not shown, just like in any other "empty diff" case.
 
---always::
-	Show the commit itself and the commit log message even
-	if the diff itself is empty.
+include::diff-tree-options.txt[]
+
+
+include::pretty-options.txt[]
 
 
 include::pretty-formats.txt[]
-- 
1.5.5.1
