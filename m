From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Random documentation fixes
Date: Mon, 3 Oct 2005 19:16:30 +0200
Message-ID: <20051003171630.GA27808@diku.dk>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 19:23:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMTvs-0003EV-Pe
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 19:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933208AbVJCRQg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 13:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933218AbVJCRQg
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 13:16:36 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:17388 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S933208AbVJCRQd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2005 13:16:33 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 0243B6E2261; Mon,  3 Oct 2005 19:16:26 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 1A2B96E2094; Mon,  3 Oct 2005 19:16:26 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2C3A760F16; Mon,  3 Oct 2005 19:16:31 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9638>

Junio C Hamano <junkio@cox.net> wrote Sun, Oct 02, 2005:
> Documentation
> -------------
> * Accept patches to make formatted tables in asciidoc to work
>   well in both html and man pages (see git-diff(1)).

I went through the docs and have attached a patch fixing some
formattings that was causing bad rendering. Note, I have mostly
concentrated on getting the HTML better.

In order to fix the manpages we probably have add our own docbook hooks
to convert everything to verbatim form instead of tables, which
apparently cannot be handled well by xmlto. I haven't tried it though,
just an idea.

Another thing, a lot of the manpages have long synopsis lines spanning
multiple lines. In both the man and HTML pages they are turned into one
long line. I found that wrapping them in something like:

  SYNOPSIS
  --------
 +[verse]
 +.........................................................................
  'git-cvsimport' [ -o <branch-for-HEAD> ] [ -h ] [ -v ]
  			[ -d <CVSROOT> ] [ -p <options-for-cvsps> ]
  			[ -C <GIT_repository> ] [ -i ] [ -k ]
  			[ -s <subst> ] [ -m ] [ -M regex ] [ <CVS_module> ]
 +.........................................................................

will make it look like intended. I don't know if sacrificing readability
of the *.txt files for improved generated docs is acceptable. If not the
patch below should probably also be filtered a bit.

Another thing (sorry for putting it all in one mail), what about also
documenting all Makefile configuration variables, such as:

 diff --git a/Makefile b/Makefile
 --- a/Makefile
 +++ b/Makefile
 @@ -29,6 +29,8 @@
  #
  # Define WITH_OWN_SUBPROCESS_PY if you want to use with python 2.3.
  #
 +# Define WITH_SEND_EMAIL if you have the Perl Sendmail module installed
 +#
  # Define COLLISION_CHECK below if you believe that SHA1's
  # 1461501637330902918203684832716283019655932542976 hashes do not give you
  # sufficient guarantee that no collisions between objects will ever happen.

---

The fixes focuses on improving the HTML output. Most noteworthy:

 - Fix the Makefile to also make various *.html files depend on
   included files.

 - Consistently use 'NOTE: ...' instead of '[ ... ]' for additional
   info.

 - Fix ending '::' for description lists in OPTION section etc.

 - Fix paragraphs in description lists ending up as preformated text.

 - Always use listingblocks (preformatted text wrapped in lines with -----)
   for examples that span empty lines, so they are put in only one HTML
   block.

 - Use '1.' instead of '(1)' for numbered lists.

 - Fix linking to other GIT docs.

 - git-rev-list.txt: put option descriptions in an OPTION section.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 Documentation/Makefile             |    3 +
 Documentation/cvs-migration.txt    |    8 +-
 Documentation/diffcore.txt         |   12 ++-
 Documentation/git-applypatch.txt   |    2 -
 Documentation/git-bisect.txt       |    2 -
 Documentation/git-cherry-pick.txt  |    6 +-
 Documentation/git-commit-tree.txt  |    6 +-
 Documentation/git-cvsimport.txt    |   10 +--
 Documentation/git-diff-index.txt   |    8 +-
 Documentation/git-diff-tree.txt    |   22 +++---
 Documentation/git-fetch.txt        |    2 -
 Documentation/git-fsck-objects.txt |    8 +-
 Documentation/git-ls-files.txt     |   20 +++--
 Documentation/git-pack-objects.txt |    3 +
 Documentation/git-prune-packed.txt |    3 +
 Documentation/git-read-tree.txt    |    4 +
 Documentation/git-repack.txt       |    3 +
 Documentation/git-rev-list.txt     |   72 ++++++++++---------
 Documentation/git-revert.txt       |    6 +-
 Documentation/git-send-email.txt   |   16 ++--
 Documentation/git-send-pack.txt    |    8 +-
 Documentation/git-sh-setup.txt     |    9 +-
 Documentation/git-update-index.txt |    2 -
 Documentation/git-var.txt          |   14 ++--
 Documentation/git-verify-pack.txt  |   14 ++--
 Documentation/pull-fetch-param.txt |  138 +++++++++++++++++-------------------
 27 files changed, 211 insertions(+), 192 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -53,6 +53,9 @@ install: man
 $(patsubst %.txt,%.1,$(wildcard git-diff-*.txt)): \
 	diff-format.txt diff-options.txt
 $(patsubst %,%.1,git-fetch git-pull git-push): pull-fetch-param.txt
+$(patsubst %.txt,%.html,$(wildcard git-diff-*.txt)): \
+	diff-format.txt diff-options.txt
+$(patsubst %,%.html,git-fetch git-pull git-push): pull-fetch-param.txt
 git.7: ../README
 
 clean:
diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -229,10 +229,10 @@ does rename or copy would not show in th
 "o-file.c", it would find the commit that changed the statement
 when it was in "o-file.c".
 
-[ BTW, the current versions of "git-diff-tree -C" is not eager
+NOTE: The current versions of "git-diff-tree -C" is not eager
   enough to find copies, and it will miss the fact that a-file.c
   was created by copying o-file.c unless o-file.c was somehow
-  changed in the same commit.]
+  changed in the same commit.
 
 You can use the --pickaxe-all flag in addition to the -S flag.
 This causes the differences from all the files contained in
@@ -243,6 +243,6 @@ that contain this changed "if" statement
 		nitfol();
 	}' --pickaxe-all
 
-[ Side note.  This option is called "--pickaxe-all" because -S
+NOTE: This option is called "--pickaxe-all" because -S
   option is internally called "pickaxe", a tool for software
-  archaeologists.]
+  archaeologists.
diff --git a/Documentation/diffcore.txt b/Documentation/diffcore.txt
--- a/Documentation/diffcore.txt
+++ b/Documentation/diffcore.txt
@@ -254,11 +254,11 @@ As an example, typical orderfile for the
 would look like this:
 
 ------------------------------------------------
-    README
-    Makefile
-    Documentation
-    *.h
-    *.c
-    t
+README
+Makefile
+Documentation
+*.h
+*.c
+t
 ------------------------------------------------
 
diff --git a/Documentation/git-applypatch.txt b/Documentation/git-applypatch.txt
--- a/Documentation/git-applypatch.txt
+++ b/Documentation/git-applypatch.txt
@@ -30,7 +30,7 @@ OPTIONS
 <patch>::
 	The patch to apply.
 
-<info>:
+<info>::
 	Author and subject information extracted from e-mail,
 	used on "author" line and as the first line of the
 	commit log message.
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -91,7 +91,7 @@ Author
 Written by Linus Torvalds <torvalds@osdl.org>
 
 Documentation
---------------
+-------------
 Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -38,9 +38,9 @@ OPTIONS
 	option is used, your working tree does not have to match
 	the HEAD commit.  The cherry-pick is done against the
 	beginning state of your working tree.
-
-	This is useful when cherry-picking more than one commits'
-	effect to your working tree in a row.
++
+This is useful when cherry-picking more than one commits'
+effect to your working tree in a row.
 
 
 Author
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -58,11 +58,11 @@ following environment variables.
 	GIT_COMMITTER_NAME
 	GIT_COMMITTER_EMAIL
 
-(nb <,> and '\n's are stripped)
+(nb "<", ">" and "\n"s are stripped)
 
 A commit comment is read from stdin (max 999 chars). If a changelog
-entry is not provided via '<' redirection, "git-commit-tree" will just wait
-for one to be entered and terminated with ^D
+entry is not provided via "<" redirection, "git-commit-tree" will just wait
+for one to be entered and terminated with ^D.
 
 Diagnostics
 -----------
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -51,15 +51,15 @@ OPTIONS
 	The 'HEAD' branch from CVS is imported to the 'origin' branch within
 	the git repository, as 'HEAD' already has a special meaning for git.
 	Use this option if you want to import into a different branch.
-
-	Use '-o master' for continuing an import that was initially done by
-	the old cvs2git tool.
++
+Use '-o master' for continuing an import that was initially done by
+the old cvs2git tool.
 
 -p <options-for-cvsps>::
 	Additional options for cvsps.
 	The options '-u' and '-A' are implicit and should not be used here.
-
-	If you need to pass multiple options, separate them with a comma.
++
+If you need to pass multiple options, separate them with a comma.
 
 -m::    
 	Attempt to detect merges based on the commit message. This option
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -86,8 +86,8 @@ the more useful of the two in that what 
 a "git-write-tree" + "git-diff-tree". Thus that's the default mode.
 The non-cached version asks the question:
 
-   show me the differences between HEAD and the currently checked out
-   tree - index contents _and_ files that aren't up-to-date
+  show me the differences between HEAD and the currently checked out
+  tree - index contents _and_ files that aren't up-to-date
 
 which is obviously a very useful question too, since that tells you what
 you *could* commit. Again, the output matches the "git-diff-tree -r"
@@ -107,13 +107,13 @@ not up-to-date and may contain new stuff
 get the real diff, you need to look at the object in the working directory
 directly rather than do an object-to-object diff.
 
-NOTE! As with other commands of this type, "git-diff-index" does not
+NOTE: As with other commands of this type, "git-diff-index" does not
 actually look at the contents of the file at all. So maybe
 `kernel/sched.c` hasn't actually changed, and it's just that you
 touched it. In either case, it's a note that you need to
 "git-upate-cache" it to make the cache be in sync.
 
-NOTE 2! You can have a mixture of files show up as "has been updated"
+NOTE: You can have a mixture of files show up as "has been updated"
 and "is still dirty in the working directory" together. You can always
 tell which file is in which state, since the "has been updated" ones
 show a valid sha1, and the "not in sync with the index" ones will
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -101,16 +101,18 @@ An example of normal usage is:
 which tells you that the last commit changed just one file (it's from
 this one:
 
-  commit 3c6f7ca19ad4043e9e72fa94106f352897e651a8
-  tree 5319e4d609cdd282069cc4dce33c1db559539b03
-  parent b4e628ea30d5ab3606119d2ea5caeab141d38df7
-  author Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005
-  committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005
-
-  Make "git-fsck-objects" print out all the root commits it finds.
-
-  Once I do the reference tracking, I'll also make it print out all the
-  HEAD commits it finds, which is even more interesting.
+-----------------------------------------------------------------------------
+commit 3c6f7ca19ad4043e9e72fa94106f352897e651a8
+tree 5319e4d609cdd282069cc4dce33c1db559539b03
+parent b4e628ea30d5ab3606119d2ea5caeab141d38df7
+author Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005
+committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat Apr 9 12:02:30 2005
+
+Make "git-fsck-objects" print out all the root commits it finds.
+
+Once I do the reference tracking, I'll also make it print out all the
+HEAD commits it finds, which is even more interesting.
+-----------------------------------------------------------------------------
 
 in case you care).
 
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -39,7 +39,7 @@ Written by Linus Torvalds <torvalds@osdl
 Junio C Hamano <junkio@cox.net>
 
 Documentation
---------------
+-------------
 Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
 
 GIT
diff --git a/Documentation/git-fsck-objects.txt b/Documentation/git-fsck-objects.txt
--- a/Documentation/git-fsck-objects.txt
+++ b/Documentation/git-fsck-objects.txt
@@ -19,9 +19,9 @@ OPTIONS
 -------
 <object>::
 	An object to treat as the head of an unreachability trace.
-
-	If no objects are given, git-fsck-objects defaults to using the
-	index file and all SHA1 references in .git/refs/* as heads.
++
+If no objects are given, git-fsck-objects defaults to using the
+index file and all SHA1 references in .git/refs/* as heads.
 
 --unreachable::
 	Print out objects that exist but that aren't readable from any
@@ -128,7 +128,7 @@ GIT_OBJECT_DIRECTORY::
 GIT_INDEX_FILE::
 	used to specify the index file of the cache
 
-GIT_ALTERNATE_OBJECT_DIRECTORIES:
+GIT_ALTERNATE_OBJECT_DIRECTORIES::
 	used to specify additional object database roots (usually unset)
 
 Author
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -70,11 +70,11 @@ OPTIONS
 -t::
 	Identify the file status with the following tags (followed by
 	a space) at the start of each line:
-	H	cached
-	M	unmerged
-	R	removed/deleted
-	C	modifed/changed
-	K	to be killed
+	H::	cached
+	M::	unmerged
+	R::	removed/deleted
+	C::	modifed/changed
+	K::	to be killed
 	?	other
 
 --::
@@ -110,13 +110,13 @@ flags --others or --ignored are specifie
 
 These exclude patterns come from these places:
 
- (1) command line flag --exclude=<pattern> specifies a single
+  1. command line flag --exclude=<pattern> specifies a single
      pattern.
 
- (2) command line flag --exclude-from=<file> specifies a list of
+  2. command line flag --exclude-from=<file> specifies a list of
      patterns stored in a file.
 
- (3) command line flag --exclude-per-directory=<name> specifies
+  3. command line flag --exclude-per-directory=<name> specifies
      a name of the file in each directory 'git-ls-files'
      examines, and if exists, its contents are used as an
      additional list of patterns.
@@ -168,12 +168,13 @@ An exclude pattern is of the following f
  - otherwise, it is a shell glob pattern, suitable for
    consumption by fnmatch(3) with FNM_PATHNAME flag.  I.e. a
    slash in the pattern must match a slash in the pathname.
-   "Documentation/*.html" matches "Documentation/git.html" but
+   "Documentation/\*.html" matches "Documentation/git.html" but
    not "ppc/ppc.html".  As a natural exception, "/*.c" matches
    "cat-file.c" but not "mozilla-sha1/sha1.c".
 
 An example:
 
+--------------------------------------------------------------
     $ cat .git/ignore
     # ignore objects and archives, anywhere in the tree.
     *.[oa]
@@ -186,6 +187,7 @@ An example:
         --exclude='Documentation/*.[0-9]' \
         --exclude-from=.git/ignore \
         --exclude-per-directory=.gitignore
+--------------------------------------------------------------
 
 
 See Also
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -76,7 +76,8 @@ Documentation by Junio C Hamano
 
 See-Also
 --------
-git-repack(1) git-prune-packed(1)
+gitlink:git-repack[1]
+gitlink:git-prune-packed[1]
 
 GIT
 ---
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -34,7 +34,8 @@ Documentation by Ryan Anderson <ryan@mic
 
 See-Also
 --------
-git-pack-objects(1) git-repack(1)
+gitlink:git-pack-objects[1]
+gitlink:git-repack[1]
 
 GIT
 ---
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -84,10 +84,10 @@ fast forward situation).
 When two trees are specified, the user is telling git-read-tree
 the following:
 
-    (1) The current index and work tree is derived from $H, but
+     1. The current index and work tree is derived from $H, but
         the user may have local changes in them since $H;
 
-    (2) The user wants to fast-forward to $M.
+     2. The user wants to fast-forward to $M.
 
 In this case, the "git-read-tree -m $H $M" command makes sure
 that no local change is lost as the result of this "merge".
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -51,7 +51,8 @@ Documentation by Ryan Anderson <ryan@mic
 
 See-Also
 --------
-git-pack-objects(1) git-prune-packed(1)
+gitlink:git-pack-objects[1]
+gitlink:git-prune-packed[1]
 
 GIT
 ---
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -22,65 +22,69 @@ that point. Their parents are implied. "
 means "list all the commits which are included in 'foo' and 'bar', but
 not in 'baz'".
 
-If *--pretty* is specified, print the contents of the commit changesets
-in human-readable form.
-
-The *--objects* flag causes 'git-rev-list' to print the object IDs of
-any object referenced by the listed commits. 'git-rev-list --objects foo
-^bar' thus means "send me all object IDs which I need to download if
-I have the commit object 'bar', but not 'foo'".
-
-The *--bisect* flag limits output to the one commit object which is
-roughly halfway between the included and excluded commits. Thus,
-if 'git-rev-list --bisect foo ^bar
-^baz' outputs 'midpoint', the output
-of 'git-rev-list foo ^midpoint' and 'git-rev-list midpoint
-^bar
-^baz'
-would be of roughly the same length. Finding the change which introduces
-a regression is thus reduced to a binary search: repeatedly generate and
-test new 'midpoint's until the commit chain is of length one.
-
-If *--merge-order* is specified, the commit history is decomposed into a
-unique sequence of minimal, non-linear epochs and maximal, linear epochs.
-Non-linear epochs are then linearised by sorting them into merge order, which
-is described below.
-
+OPTIONS
+-------
+--pretty::
+	Print the contents of the commit changesets in human-readable form.
+
+--objects::
+	Print the object IDs of any object referenced by the listed commits.
+	'git-rev-list --objects foo ^bar' thus means "send me all object IDs
+	which I need to download if I have the commit object 'bar', but
+	not 'foo'".
+
+--bisect::
+	Limit output to the one commit object which is roughly halfway
+	between the included and excluded commits. Thus, if 'git-rev-list
+	--bisect foo ^bar ^baz' outputs 'midpoint', the output
+	of 'git-rev-list foo ^midpoint' and 'git-rev-list midpoint
+	^bar ^baz' would be of roughly the same length. Finding the change
+	which introduces a regression is thus reduced to a binary search:
+	repeatedly generate and test new 'midpoint's until the commit chain
+	is of length one.
+
+--merge-order::
+	When specified the commit history is decomposed into a unique
+	sequence of minimal, non-linear epochs and maximal, linear epochs.
+	Non-linear epochs are then linearised by sorting them into merge
+	order, which is described below.
++
 Maximal, linear epochs correspond to periods of sequential development.
 Minimal, non-linear epochs correspond to periods of divergent development
 followed by a converging merge. The theory of epochs is described in more
 detail at
 link:http://blackcubes.dyndns.org/epoch/[http://blackcubes.dyndns.org/epoch/].
-
++
 The merge order for a non-linear epoch is defined as a linearisation for which
 the following invariants are true:
-
++
     1. if a commit P is reachable from commit N, commit P sorts after commit N
        in the linearised list.
     2. if Pi and Pj are any two parents of a merge M (with i < j), then any
        commit N, such that N is reachable from Pj but not reachable from Pi,
        sorts before all commits reachable from Pi.
-
++
 Invariant 1 states that later commits appear before earlier commits they are
 derived from.
-
++
 Invariant 2 states that commits unique to "later" parents in a merge, appear
 before all commits from "earlier" parents of a merge.
 
-If *--show-breaks* is specified, each item of the list is output with a
-2-character prefix consisting of one of: (|), (^), (=) followed by a space.
-
+--show-breaks::
+	Each item of the list is output with a 2-character prefix consisting
+	of one of: (|), (^), (=) followed by a space.
++
 Commits marked with (=) represent the boundaries of minimal, non-linear epochs
 and correspond either to the start of a period of divergent development or to
 the end of such a period.
-
++
 Commits marked with (|) are direct parents of commits immediately preceding
 the marked commit in the list.
-
++
 Commits marked with (^) are not parents of the immediately preceding commit.
 These "breaks" represent necessary discontinuities implied by trying to
 represent an arbtirary DAG in a linear form.
-
++
 *--show-breaks* is only valid if *--merge-order* is also specified.
 
 Author
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -29,9 +29,9 @@ OPTIONS
 	working tree does not have to match the HEAD commit.
 	The revert is done against the beginning state of your
 	working tree.
-
-	This is useful when reverting more than one commits'
-	effect to your working tree in a row.
++
+This is useful when reverting more than one commits'
+effect to your working tree in a row.
 
 
 Author
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -21,35 +21,37 @@ The header of the email is configurable 
 specified on the command line, the user will be prompted with a ReadLine
 enabled interface to provide the necessary information.
 
+OPTIONS
+-------
 The options available are:
 
-  --to
+--to::
 	Specify the primary recipient of the emails generated.
 	Generally, this will be the upstream maintainer of the
 	project involved.
 
-   --from
+--from::
 	Specify the sender of the emails.  This will default to
 	the value GIT_COMMITTER_IDENT, as returned by "git-var -l".
 	The user will still be prompted to confirm this entry.
 
-   --compose
+--compose::
 	Use \$EDITOR to edit an introductory message for the
 	patch series.
 
-   --subject
+--subject::
    	Specify the initial subject of the email thread.
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
-   --in-reply-to
+--in-reply-to::
 	Specify the contents of the first In-Reply-To header.
 	Subsequent emails will refer to the previous email 
 	instead of this if --chain-reply-to is set (the default)
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
-   --chain-reply-to, --no-chain-reply-to
+--chain-reply-to, --no-chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with "--no-chain-reply-to", all emails after
 	the first will be sent as replies to the first email sent.  When using
@@ -57,7 +59,7 @@ The options available are:
 	entire patch series.
 	Default is --chain-reply-to
 
-   --smtp-server
+--smtp-server::
 	If set, specifies the outgoing SMTP server to use.  Defaults to
 	localhost.
 
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -61,9 +61,9 @@ this flag.
 Without '--all' and without any '<ref>', the refs that exist
 both on the local side and on the remote side are updated.
 
-When '<ref>'s are specified explicitly, it can be either a
+When one or more '<ref>' are specified explicitly, it can be either a
 single pattern, or a pair of such pattern separated by a colon
-':' (this means that a ref name cannot have a colon in it).  A
+":" (this means that a ref name cannot have a colon in it).  A
 single pattern '<name>' is just a shorthand for '<name>:<name>'.
 
 Each pattern pair consists of the source side (before the colon)
@@ -79,10 +79,10 @@ destination side.
 
  - If <dst> does not match any remote ref, either
 
-   - it has to start with "refs/"; <dst> is used as the
+   * it has to start with "refs/"; <dst> is used as the
      destination literally in this case.
 
-   - <src> == <dst> and the ref that matched the <src> must not
+   * <src> == <dst> and the ref that matched the <src> must not
      exist in the set of remote refs; the ref matched <src>
      locally is used as the name of the destination.
 
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -14,11 +14,12 @@ DESCRIPTION
 
 Sets up the normal git environment variables and a few helper functions
 (currently just "die()"), and returns ok if it all looks like a git archive.
-So use it something like
+So, to make the rest of the git scripts more careful and readable,
+use it as follows:
 
-	. git-sh-setup || die "Not a git archive"
-
-to make the rest of the git scripts more careful and readable.
+-------------------------------------------------
+. git-sh-setup || die "Not a git archive"
+-------------------------------------------------
 
 Author
 ------
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -101,7 +101,7 @@ Using --cacheinfo or --info-only
 current working directory.  This is useful for minimum-checkout
 merging.
 
-  To pretend you have a file with mode and sha1 at path, say:
+To pretend you have a file with mode and sha1 at path, say:
 
    $ git-update-index --cacheinfo mode sha1 path
 
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -15,21 +15,23 @@ DESCRIPTION
 -----------
 Prints a git logical variable.
 
--l causes the logical variables to be listed.
+OPTIONS
+-------
+-l::
+	Cause the logical variables to be listed.
 
 EXAMPLE
 --------
-$git-var GIT_AUTHOR_IDENT
-
-Eric W. Biederman <ebiederm@lnxi.com> 1121223278 -0600
+	$ git-var GIT_AUTHOR_IDENT
+	Eric W. Biederman <ebiederm@lnxi.com> 1121223278 -0600
 
 
 VARIABLES
 ----------
-GIT_AUTHOR_IDENT
+GIT_AUTHOR_IDENT::
     The author of a piece of code.
 
-GIT_COMMITTER_IDENT
+GIT_COMMITTER_IDENT::
     The person who put a piece of code into git.
 
 Diagnostics
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -25,15 +25,19 @@ OPTIONS
 
 -v::
 	After verifying the pack, show list of objects contained
-	in the pack.  The format used is:
+	in the pack.
 
-		SHA1 type size offset-in-packfile
+OUTPUT FORMAT
+-------------
+When specifying the -v option the format used is:
 
-	for objects that are not deltified in the pack, and
+	SHA1 type size offset-in-packfile
 
-		SHA1 type size offset-in-packfile depth base-SHA1
+for objects that are not deltified in the pack, and
 
-	for objects that are deltified.
+	SHA1 type size offset-in-packfile depth base-SHA1
+
+for objects that are deltified.
 
 Author
 ------
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -2,84 +2,78 @@
 	The "remote" repository to pull from.  One of the
 	following notations can be used to name the repository
 	to pull from:
-
-		Rsync URL
-			rsync://remote.machine/path/to/repo.git/
-
-		HTTP(s) URL
-			http://remote.machine/path/to/repo.git/
-
-		GIT URL
-			git://remote.machine/path/to/repo.git/
-			remote.machine:/path/to/repo.git/
-
-		Local directory
-			/path/to/repo.git/
-
-	In addition to the above, as a short-hand, the name of a
-	file in $GIT_DIR/remotes directory can be given; the
-	named file should be in the following format:
-
-		URL: one of the above URL format
-		Push: <refspec>...
-		Pull: <refspec>...
-
-	When such a short-hand is specified in place of
-	<repository> without <refspec> parameters on the command
-	line, <refspec>... specified on Push lines or Pull lines
-	are used for "git push" and "git fetch/pull",
-	respectively.
-
-	The name of a file in $GIT_DIR/branches directory can be
-	specified as an older notation short-hand; the named
-	file should contain a single line, a URL in one of the
-	above formats, optionally followed by a hash '#' and the
-	name of remote head (URL fragment notation).
-	$GIT_DIR/branches/<remote> file that stores a <url>
-	without the fragment is equivalent to have this in the
-	corresponding file in the $GIT_DIR/remotes/ directory
-
-		URL: <url>
-		Pull: refs/heads/master:<remote>
-
-	while having <url>#<head> is equivalent to
-
-		URL: <url>
-		Pull: refs/heads/<head>:<remote>
++
+===============================================================
+- Rsync URL:		rsync://remote.machine/path/to/repo.git/
+- HTTP(s) URL:		http://remote.machine/path/to/repo.git/
+- GIT URL:		git://remote.machine/path/to/repo.git/
+			or remote.machine:/path/to/repo.git/
+- Local directory:	/path/to/repo.git/
+===============================================================
++
+In addition to the above, as a short-hand, the name of a
+file in $GIT_DIR/remotes directory can be given; the
+named file should be in the following format:
++
+	URL: one of the above URL format
+	Push: <refspec>...
+	Pull: <refspec>...
++
+When such a short-hand is specified in place of
+<repository> without <refspec> parameters on the command
+line, <refspec>... specified on Push lines or Pull lines
+are used for "git push" and "git fetch/pull",
+respectively.
++
+The name of a file in $GIT_DIR/branches directory can be
+specified as an older notation short-hand; the named
+file should contain a single line, a URL in one of the
+above formats, optionally followed by a hash '#' and the
+name of remote head (URL fragment notation).
+$GIT_DIR/branches/<remote> file that stores a <url>
+without the fragment is equivalent to have this in the
+corresponding file in the $GIT_DIR/remotes/ directory
++
+	URL: <url>
+	Pull: refs/heads/master:<remote>
++
+while having <url>#<head> is equivalent to
++
+	URL: <url>
+	Pull: refs/heads/<head>:<remote>
 
 <refspec>::
 	The canonical format of a <refspec> parameter is
 	'+?<src>:<dst>'; that is, an optional plus '+', followed
 	by the source ref, followed by a colon ':', followed by
 	the destination ref.
-
-	When used in "git push", the <src> side can be an
-	arbitrary "SHA1 expression" that can be used as an
-	argument to "git-cat-file -t".  E.g. "master~4" (push
-	four parents before the current master head).
-
-        For "git push", the local ref that matches <src> is used
-        to fast forward the remote ref that matches <dst>.  If
-        the optional plus '+' is used, the remote ref is updated
-        even if it does not result in a fast forward update.
-
-	For "git fetch/pull", the remote ref that matches <src>
-	is fetched, and if <dst> is not empty string, the local
-	ref that matches it is fast forwarded using <src>.
-	Again, if the optional plus '+' is used, the local ref
-	is updated even if it does not result in a fast forward
-	update.
-
-	Some short-cut notations are also supported.
-
-	* For backward compatibility, "tag" is almost ignored;
-          it just makes the following parameter <tag> to mean a
-          refspec "refs/tags/<tag>:refs/tags/<tag>".
-
-        * A parameter <ref> without a colon is equivalent to
-          <ref>: when pulling/fetching, and <ref>:<ref> when
-          pushing.  That is, do not store it locally if
-          fetching, and update the same name if pushing.
++
+When used in "git push", the <src> side can be an
+arbitrary "SHA1 expression" that can be used as an
+argument to "git-cat-file -t".  E.g. "master~4" (push
+four parents before the current master head).
++
+For "git push", the local ref that matches <src> is used
+to fast forward the remote ref that matches <dst>.  If
+the optional plus '+' is used, the remote ref is updated
+even if it does not result in a fast forward update.
++
+For "git fetch/pull", the remote ref that matches <src>
+is fetched, and if <dst> is not empty string, the local
+ref that matches it is fast forwarded using <src>.
+Again, if the optional plus '+' is used, the local ref
+is updated even if it does not result in a fast forward
+update.
++
+Some short-cut notations are also supported.
++
+* For backward compatibility, "tag" is almost ignored;
+  it just makes the following parameter <tag> to mean a
+  refspec "refs/tags/<tag>:refs/tags/<tag>".
+* A parameter <ref> without a colon is equivalent to
+  <ref>: when pulling/fetching, and <ref>:<ref> when
+  pushing.  That is, do not store it locally if
+  fetching, and update the same name if pushing.
 
 -a, \--append::
 	Append ref names and object names of fetched refs to the

-- 
Jonas Fonseca
