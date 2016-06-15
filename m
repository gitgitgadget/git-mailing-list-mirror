From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Include rev-list options in git-log manpage.
Date: Thu, 17 Jan 2008 22:44:25 +0100
Message-ID: <20080117214425.GP29972@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 22:46:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFcYy-00020i-C5
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 22:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759100AbYAQVow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 16:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759083AbYAQVow
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 16:44:52 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:42144 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759035AbYAQVor (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 16:44:47 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1JFcXL-0004wg-DX
	from <vmiklos@frugalware.org>; Thu, 17 Jan 2008 22:44:44 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 511B51190499; Thu, 17 Jan 2008 22:44:25 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70930>

It seems that all the git-rev-list options (--grep, --author, etc) were missing
from the git-log manpage. This can be quite problematic if one does not know
that git-log accepts the options of git-rev-list.

So move these options to a separate file and include it from both
git-rev-list.txt and git-log.txt.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Noticed by tsuna on IRC. I hope this is okay for 1.5.4.

 Documentation/git-log.txt          |    2 +
 Documentation/git-rev-list.txt     |  358 +-----------------------------------
 Documentation/rev-list-options.txt |  356 +++++++++++++++++++++++++++++++++++
 3 files changed, 359 insertions(+), 357 deletions(-)
 create mode 100644 Documentation/rev-list-options.txt

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 5985f47..8095707 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -80,6 +80,8 @@ include::diff-options.txt[]
 	Show only commits that affect the specified paths.
 
 
+include::rev-list-options.txt[]
+
 include::pretty-formats.txt[]
 
 include::diff-generate-patch.txt[]
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index db42cd8..6a4b0cf 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -88,363 +88,7 @@ linkgit:git-repack[1].
 OPTIONS
 -------
 
-Commit Formatting
-~~~~~~~~~~~~~~~~~
-
-Using these options, linkgit:git-rev-list[1] will act similar to the
-more specialized family of commit log tools: linkgit:git-log[1],
-linkgit:git-show[1], and linkgit:git-whatchanged[1]
-
-include::pretty-options.txt[]
-
---relative-date::
-
-	Synonym for `--date=relative`.
-
---date={relative,local,default,iso,rfc}::
-
-	Only takes effect for dates shown in human-readable format, such
-	as when using "--pretty".
-+
-`--date=relative` shows dates relative to the current time,
-e.g. "2 hours ago".
-+
-`--date=local` shows timestamps in user's local timezone.
-+
-`--date=iso` (or `--date=iso8601`) shows timestamps in ISO 8601 format.
-+
-`--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
-format, often found in E-mail messages.
-+
-`--date=short` shows only date but not time, in `YYYY-MM-DD` format.
-+
-`--date=default` shows timestamps in the original timezone
-(either committer's or author's).
-
---header::
-
-	Print the contents of the commit in raw-format; each record is
-	separated with a NUL character.
-
---parents::
-
-	Print the parents of the commit.
-
---timestamp::
-	Print the raw commit timestamp.
-
---left-right::
-
-	Mark which side of a symmetric diff a commit is reachable from.
-	Commits from the left side are prefixed with `<` and those from
-	the right with `>`.  If combined with `--boundary`, those
-	commits are prefixed with `-`.
-+
-For example, if you have this topology:
-+
------------------------------------------------------------------------
-             y---b---b  branch B
-            / \ /
-           /   .
-          /   / \
-         o---x---a---a  branch A
------------------------------------------------------------------------
-+
-you would get an output line this:
-+
------------------------------------------------------------------------
-	$ git rev-list --left-right --boundary --pretty=oneline A...B
-
-	>bbbbbbb... 3rd on b
-	>bbbbbbb... 2nd on b
-	<aaaaaaa... 3rd on a
-	<aaaaaaa... 2nd on a
-	-yyyyyyy... 1st on b
-	-xxxxxxx... 1st on a
------------------------------------------------------------------------
-
-Diff Formatting
-~~~~~~~~~~~~~~~
-
-Below are listed options that control the formatting of diff output.
-Some of them are specific to linkgit:git-rev-list[1], however other diff
-options may be given. See linkgit:git-diff-files[1] for more options.
-
--c::
-
-	This flag changes the way a merge commit is displayed.  It shows
-	the differences from each of the parents to the merge result
-	simultaneously instead of showing pairwise diff between a parent
-	and the result one at a time. Furthermore, it lists only files
-	which were modified from all parents.
-
---cc::
-
-	This flag implies the '-c' options and further compresses the
-	patch output by omitting hunks that show differences from only
-	one parent, or show the same change from all but one parent for
-	an Octopus merge.
-
--r::
-
-	Show recursive diffs.
-
--t::
-
-	Show the tree objects in the diff output. This implies '-r'.
-
-Commit Limiting
-~~~~~~~~~~~~~~~
-
-Besides specifying a range of commits that should be listed using the
-special notations explained in the description, additional commit
-limiting may be applied.
-
---
-
--n 'number', --max-count='number'::
-
-	Limit the number of commits output.
-
---skip='number'::
-
-	Skip 'number' commits before starting to show the commit output.
-
---since='date', --after='date'::
-
-	Show commits more recent than a specific date.
-
---until='date', --before='date'::
-
-	Show commits older than a specific date.
-
---max-age='timestamp', --min-age='timestamp'::
-
-	Limit the commits output to specified time range.
-
---author='pattern', --committer='pattern'::
-
-	Limit the commits output to ones with author/committer
-	header lines that match the specified pattern (regular expression).
-
---grep='pattern'::
-
-	Limit the commits output to ones with log message that
-	matches the specified pattern (regular expression).
-
--i, --regexp-ignore-case::
-
-	Match the regexp limiting patterns without regard to letters case.
-
--E, --extended-regexp::
-
-	Consider the limiting patterns to be extended regular expressions
-	instead of the default basic regular expressions.
-
---remove-empty::
-
-	Stop when a given path disappears from the tree.
-
---full-history::
-
-	Show also parts of history irrelevant to current state of a given
-	path. This turns off history simplification, which removed merges
-	which didn't change anything at all at some child. It will still actually
-	simplify away merges that didn't change anything at all into either
-	child.
-
---no-merges::
-
-	Do not print commits with more than one parent.
-
---first-parent::
-	Follow only the first parent commit upon seeing a merge
-	commit.  This option can give a better overview when
-	viewing the evolution of a particular topic branch,
-	because merges into a topic branch tend to be only about
-	adjusting to updated upstream from time to time, and
-	this option allows you to ignore the individual commits
-	brought in to your history by such a merge.
-
---not::
-
-	Reverses the meaning of the '{caret}' prefix (or lack thereof)
-	for all following revision specifiers, up to the next '--not'.
-
---all::
-
-	Pretend as if all the refs in `$GIT_DIR/refs/` are listed on the
-	command line as '<commit>'.
-
---stdin::
-
-	In addition to the '<commit>' listed on the command
-	line, read them from the standard input.
-
---quiet::
-
-	Don't print anything to standard output.  This form of
-	git-rev-list is primarily meant to allow the caller to
-	test the exit status to see if a range of objects is fully
-	connected (or not).  It is faster than redirecting stdout
-	to /dev/null as the output does not have to be formatted.
-
---cherry-pick::
-
-	Omit any commit that introduces the same change as
-	another commit on the "other side" when the set of
-	commits are limited with symmetric difference.
-+
-For example, if you have two branches, `A` and `B`, a usual way
-to list all commits on only one side of them is with
-`--left-right`, like the example above in the description of
-that option.  It however shows the commits that were cherry-picked
-from the other branch (for example, "3rd on b" may be cherry-picked
-from branch A).  With this option, such pairs of commits are
-excluded from the output.
-
--g, --walk-reflogs::
-
-	Instead of walking the commit ancestry chain, walk
-	reflog entries from the most recent one to older ones.
-	When this option is used you cannot specify commits to
-	exclude (that is, '{caret}commit', 'commit1..commit2',
-	nor 'commit1...commit2' notations cannot be used).
-+
-With '\--pretty' format other than oneline (for obvious reasons),
-this causes the output to have two extra lines of information
-taken from the reflog.  By default, 'commit@\{Nth}' notation is
-used in the output.  When the starting commit is specified as
-'commit@{now}', output also uses 'commit@\{timestamp}' notation
-instead.  Under '\--pretty=oneline', the commit message is
-prefixed with this information on the same line.
-
-Cannot be combined with '\--reverse'.
-
---merge::
-
-	After a failed merge, show refs that touch files having a
-	conflict and don't exist on all heads to merge.
-
---boundary::
-
-	Output uninteresting commits at the boundary, which are usually
-	not shown.
-
---dense, --sparse::
-
-When optional paths are given, the default behaviour ('--dense') is to
-only output commits that changes at least one of them, and also ignore
-merges that do not touch the given paths.
-
-Use the '--sparse' flag to makes the command output all eligible commits
-(still subject to count and age limitation), but apply merge
-simplification nevertheless.
-
---bisect::
-
-Limit output to the one commit object which is roughly halfway between
-the included and excluded commits. Thus, if
-
------------------------------------------------------------------------
-	$ git-rev-list --bisect foo ^bar ^baz
------------------------------------------------------------------------
-
-outputs 'midpoint', the output of the two commands
-
------------------------------------------------------------------------
-	$ git-rev-list foo ^midpoint
-	$ git-rev-list midpoint ^bar ^baz
------------------------------------------------------------------------
-
-would be of roughly the same length.  Finding the change which
-introduces a regression is thus reduced to a binary search: repeatedly
-generate and test new 'midpoint's until the commit chain is of length
-one.
-
---bisect-vars::
-
-This calculates the same as `--bisect`, but outputs text ready
-to be eval'ed by the shell. These lines will assign the name of
-the midpoint revision to the variable `bisect_rev`, and the
-expected number of commits to be tested after `bisect_rev` is
-tested to `bisect_nr`, the expected number of commits to be
-tested if `bisect_rev` turns out to be good to `bisect_good`,
-the expected number of commits to be tested if `bisect_rev`
-turns out to be bad to `bisect_bad`, and the number of commits
-we are bisecting right now to `bisect_all`.
-
---bisect-all::
-
-This outputs all the commit objects between the included and excluded
-commits, ordered by their distance to the included and excluded
-commits. The farthest from them is displayed first. (This is the only
-one displayed by `--bisect`.)
-
-This is useful because it makes it easy to choose a good commit to
-test when you want to avoid to test some of them for some reason (they
-may not compile for example).
-
-This option can be used along with `--bisect-vars`, in this case,
-after all the sorted commit objects, there will be the same text as if
-`--bisect-vars` had been used alone.
-
---
-
-Commit Ordering
-~~~~~~~~~~~~~~~
-
-By default, the commits are shown in reverse chronological order.
-
---topo-order::
-
-	This option makes them appear in topological order (i.e.
-	descendant commits are shown before their parents).
-
---date-order::
-
-	This option is similar to '--topo-order' in the sense that no
-	parent comes before all of its children, but otherwise things
-	are still ordered in the commit timestamp order.
-
---reverse::
-
-	Output the commits in reverse order.
-	Cannot be combined with '\--walk-reflogs'.
-
-Object Traversal
-~~~~~~~~~~~~~~~~
-
-These options are mostly targeted for packing of git repositories.
-
---objects::
-
-	Print the object IDs of any object referenced by the listed
-	commits.  'git-rev-list --objects foo ^bar' thus means "send me
-	all object IDs which I need to download if I have the commit
-	object 'bar', but not 'foo'".
-
---objects-edge::
-
-	Similar to '--objects', but also print the IDs of excluded
-	commits prefixed with a "-" character.  This is used by
-	linkgit:git-pack-objects[1] to build "thin" pack, which records
-	objects in deltified form based on objects contained in these
-	excluded commits to reduce network traffic.
-
---unpacked::
-
-	Only useful with '--objects'; print the object IDs that are not
-	in packs.
-
---no-walk::
-
-	Only show the given revs, but do not traverse their ancestors.
-
---do-walk::
-
-	Overrides a previous --no-walk.
-
+include::rev-list-options.txt[]
 
 include::pretty-formats.txt[]
 
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
new file mode 100644
index 0000000..85fa1fb
--- /dev/null
+++ b/Documentation/rev-list-options.txt
@@ -0,0 +1,356 @@
+Commit Formatting
+~~~~~~~~~~~~~~~~~
+
+Using these options, linkgit:git-rev-list[1] will act similar to the
+more specialized family of commit log tools: linkgit:git-log[1],
+linkgit:git-show[1], and linkgit:git-whatchanged[1]
+
+include::pretty-options.txt[]
+
+--relative-date::
+
+	Synonym for `--date=relative`.
+
+--date={relative,local,default,iso,rfc}::
+
+	Only takes effect for dates shown in human-readable format, such
+	as when using "--pretty".
++
+`--date=relative` shows dates relative to the current time,
+e.g. "2 hours ago".
++
+`--date=local` shows timestamps in user's local timezone.
++
+`--date=iso` (or `--date=iso8601`) shows timestamps in ISO 8601 format.
++
+`--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
+format, often found in E-mail messages.
++
+`--date=short` shows only date but not time, in `YYYY-MM-DD` format.
++
+`--date=default` shows timestamps in the original timezone
+(either committer's or author's).
+
+--header::
+
+	Print the contents of the commit in raw-format; each record is
+	separated with a NUL character.
+
+--parents::
+
+	Print the parents of the commit.
+
+--timestamp::
+	Print the raw commit timestamp.
+
+--left-right::
+
+	Mark which side of a symmetric diff a commit is reachable from.
+	Commits from the left side are prefixed with `<` and those from
+	the right with `>`.  If combined with `--boundary`, those
+	commits are prefixed with `-`.
++
+For example, if you have this topology:
++
+-----------------------------------------------------------------------
+             y---b---b  branch B
+            / \ /
+           /   .
+          /   / \
+         o---x---a---a  branch A
+-----------------------------------------------------------------------
++
+you would get an output line this:
++
+-----------------------------------------------------------------------
+	$ git rev-list --left-right --boundary --pretty=oneline A...B
+
+	>bbbbbbb... 3rd on b
+	>bbbbbbb... 2nd on b
+	<aaaaaaa... 3rd on a
+	<aaaaaaa... 2nd on a
+	-yyyyyyy... 1st on b
+	-xxxxxxx... 1st on a
+-----------------------------------------------------------------------
+
+Diff Formatting
+~~~~~~~~~~~~~~~
+
+Below are listed options that control the formatting of diff output.
+Some of them are specific to linkgit:git-rev-list[1], however other diff
+options may be given. See linkgit:git-diff-files[1] for more options.
+
+-c::
+
+	This flag changes the way a merge commit is displayed.  It shows
+	the differences from each of the parents to the merge result
+	simultaneously instead of showing pairwise diff between a parent
+	and the result one at a time. Furthermore, it lists only files
+	which were modified from all parents.
+
+--cc::
+
+	This flag implies the '-c' options and further compresses the
+	patch output by omitting hunks that show differences from only
+	one parent, or show the same change from all but one parent for
+	an Octopus merge.
+
+-r::
+
+	Show recursive diffs.
+
+-t::
+
+	Show the tree objects in the diff output. This implies '-r'.
+
+Commit Limiting
+~~~~~~~~~~~~~~~
+
+Besides specifying a range of commits that should be listed using the
+special notations explained in the description, additional commit
+limiting may be applied.
+
+--
+
+-n 'number', --max-count='number'::
+
+	Limit the number of commits output.
+
+--skip='number'::
+
+	Skip 'number' commits before starting to show the commit output.
+
+--since='date', --after='date'::
+
+	Show commits more recent than a specific date.
+
+--until='date', --before='date'::
+
+	Show commits older than a specific date.
+
+--max-age='timestamp', --min-age='timestamp'::
+
+	Limit the commits output to specified time range.
+
+--author='pattern', --committer='pattern'::
+
+	Limit the commits output to ones with author/committer
+	header lines that match the specified pattern (regular expression).
+
+--grep='pattern'::
+
+	Limit the commits output to ones with log message that
+	matches the specified pattern (regular expression).
+
+-i, --regexp-ignore-case::
+
+	Match the regexp limiting patterns without regard to letters case.
+
+-E, --extended-regexp::
+
+	Consider the limiting patterns to be extended regular expressions
+	instead of the default basic regular expressions.
+
+--remove-empty::
+
+	Stop when a given path disappears from the tree.
+
+--full-history::
+
+	Show also parts of history irrelevant to current state of a given
+	path. This turns off history simplification, which removed merges
+	which didn't change anything at all at some child. It will still actually
+	simplify away merges that didn't change anything at all into either
+	child.
+
+--no-merges::
+
+	Do not print commits with more than one parent.
+
+--first-parent::
+	Follow only the first parent commit upon seeing a merge
+	commit.  This option can give a better overview when
+	viewing the evolution of a particular topic branch,
+	because merges into a topic branch tend to be only about
+	adjusting to updated upstream from time to time, and
+	this option allows you to ignore the individual commits
+	brought in to your history by such a merge.
+
+--not::
+
+	Reverses the meaning of the '{caret}' prefix (or lack thereof)
+	for all following revision specifiers, up to the next '--not'.
+
+--all::
+
+	Pretend as if all the refs in `$GIT_DIR/refs/` are listed on the
+	command line as '<commit>'.
+
+--stdin::
+
+	In addition to the '<commit>' listed on the command
+	line, read them from the standard input.
+
+--quiet::
+
+	Don't print anything to standard output.  This form of
+	git-rev-list is primarily meant to allow the caller to
+	test the exit status to see if a range of objects is fully
+	connected (or not).  It is faster than redirecting stdout
+	to /dev/null as the output does not have to be formatted.
+
+--cherry-pick::
+
+	Omit any commit that introduces the same change as
+	another commit on the "other side" when the set of
+	commits are limited with symmetric difference.
++
+For example, if you have two branches, `A` and `B`, a usual way
+to list all commits on only one side of them is with
+`--left-right`, like the example above in the description of
+that option.  It however shows the commits that were cherry-picked
+from the other branch (for example, "3rd on b" may be cherry-picked
+from branch A).  With this option, such pairs of commits are
+excluded from the output.
+
+-g, --walk-reflogs::
+
+	Instead of walking the commit ancestry chain, walk
+	reflog entries from the most recent one to older ones.
+	When this option is used you cannot specify commits to
+	exclude (that is, '{caret}commit', 'commit1..commit2',
+	nor 'commit1...commit2' notations cannot be used).
++
+With '\--pretty' format other than oneline (for obvious reasons),
+this causes the output to have two extra lines of information
+taken from the reflog.  By default, 'commit@\{Nth}' notation is
+used in the output.  When the starting commit is specified as
+'commit@{now}', output also uses 'commit@\{timestamp}' notation
+instead.  Under '\--pretty=oneline', the commit message is
+prefixed with this information on the same line.
+
+Cannot be combined with '\--reverse'.
+
+--merge::
+
+	After a failed merge, show refs that touch files having a
+	conflict and don't exist on all heads to merge.
+
+--boundary::
+
+	Output uninteresting commits at the boundary, which are usually
+	not shown.
+
+--dense, --sparse::
+
+When optional paths are given, the default behaviour ('--dense') is to
+only output commits that changes at least one of them, and also ignore
+merges that do not touch the given paths.
+
+Use the '--sparse' flag to makes the command output all eligible commits
+(still subject to count and age limitation), but apply merge
+simplification nevertheless.
+
+--bisect::
+
+Limit output to the one commit object which is roughly halfway between
+the included and excluded commits. Thus, if
+
+-----------------------------------------------------------------------
+	$ git-rev-list --bisect foo ^bar ^baz
+-----------------------------------------------------------------------
+
+outputs 'midpoint', the output of the two commands
+
+-----------------------------------------------------------------------
+	$ git-rev-list foo ^midpoint
+	$ git-rev-list midpoint ^bar ^baz
+-----------------------------------------------------------------------
+
+would be of roughly the same length.  Finding the change which
+introduces a regression is thus reduced to a binary search: repeatedly
+generate and test new 'midpoint's until the commit chain is of length
+one.
+
+--bisect-vars::
+
+This calculates the same as `--bisect`, but outputs text ready
+to be eval'ed by the shell. These lines will assign the name of
+the midpoint revision to the variable `bisect_rev`, and the
+expected number of commits to be tested after `bisect_rev` is
+tested to `bisect_nr`, the expected number of commits to be
+tested if `bisect_rev` turns out to be good to `bisect_good`,
+the expected number of commits to be tested if `bisect_rev`
+turns out to be bad to `bisect_bad`, and the number of commits
+we are bisecting right now to `bisect_all`.
+
+--bisect-all::
+
+This outputs all the commit objects between the included and excluded
+commits, ordered by their distance to the included and excluded
+commits. The farthest from them is displayed first. (This is the only
+one displayed by `--bisect`.)
+
+This is useful because it makes it easy to choose a good commit to
+test when you want to avoid to test some of them for some reason (they
+may not compile for example).
+
+This option can be used along with `--bisect-vars`, in this case,
+after all the sorted commit objects, there will be the same text as if
+`--bisect-vars` had been used alone.
+
+--
+
+Commit Ordering
+~~~~~~~~~~~~~~~
+
+By default, the commits are shown in reverse chronological order.
+
+--topo-order::
+
+	This option makes them appear in topological order (i.e.
+	descendant commits are shown before their parents).
+
+--date-order::
+
+	This option is similar to '--topo-order' in the sense that no
+	parent comes before all of its children, but otherwise things
+	are still ordered in the commit timestamp order.
+
+--reverse::
+
+	Output the commits in reverse order.
+	Cannot be combined with '\--walk-reflogs'.
+
+Object Traversal
+~~~~~~~~~~~~~~~~
+
+These options are mostly targeted for packing of git repositories.
+
+--objects::
+
+	Print the object IDs of any object referenced by the listed
+	commits.  'git-rev-list --objects foo ^bar' thus means "send me
+	all object IDs which I need to download if I have the commit
+	object 'bar', but not 'foo'".
+
+--objects-edge::
+
+	Similar to '--objects', but also print the IDs of excluded
+	commits prefixed with a "-" character.  This is used by
+	linkgit:git-pack-objects[1] to build "thin" pack, which records
+	objects in deltified form based on objects contained in these
+	excluded commits to reduce network traffic.
+
+--unpacked::
+
+	Only useful with '--objects'; print the object IDs that are not
+	in packs.
+
+--no-walk::
+
+	Only show the given revs, but do not traverse their ancestors.
+
+--do-walk::
+
+	Overrides a previous --no-walk.
-- 
1.5.4.rc3.4.g16335-dirty
