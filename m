From: Junio C Hamano <junkio@cox.net>
Subject: What to expect after GIT 0.99.7
Date: Sun, 18 Sep 2005 16:40:12 -0700
Message-ID: <7vpsr6ymg3.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net>
	<7vwtleyml5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 19 01:42:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH8m3-0004PB-4l
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 01:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVIRXkk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 19:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVIRXkk
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 19:40:40 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:63933 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932266AbVIRXkk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 19:40:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050918234013.KUAI23945.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Sep 2005 19:40:13 -0400
To: git@vger.kernel.org
In-Reply-To: <7vwtleyml5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 18 Sep 2005 16:37:10 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8821>

The GIT To-Do File
==================

  The latest copy of this document is found at 

    http://kernel.org/git/?p=git/git.git;a=blob;hb=todo;f=TODO


Tool Renames Plan
=================

 - All non-binary commands will lose -script suffix in
   $(bindir).  The source to git-foo will be either git-foo.sh
   or git-foo.perl in the source tree, and the documentation
   will be in Documentation/git-foo.txt.

 - The commands whose names have 'cache' to mean 'index file'
   will get 'cache' in their names replaced with 'index'. For
   git-fsck-cache and git-convert-cache, 'cache' will be
   replaced with 'objects'.

 - The commit walkers will have 'pull' in their names replaced
   with 'fetch'.  'git-ssh-push' will become 'git-ssh-upload'.

 - We continue to follow the convention to name the C source
   file that contains the main program of 'git-foo' command
   'foo.c'.  That means we will have 'fsck-objects.c', for
   example.

 - At this moment, I am not planning to rename the symbols used
   in programs, nor any library sources.  "cache.h" will stay
   "cache.h", so does "read-cache.c".  "struct cache_entry"  and
   "ce_match_stat()" will keep their names.  We _might_ want to
   rename them in later rounds but not right now.

 - In 0.99.7, all renamed commands will have symbolic links in
   $(bindir) so that old names continue to work.  These backward
   compatible names will not appear in documentation.  The main
   documentation, git(7) will talk about the new names but would
   mention their old names as historical notes.  Old environment
   names defined in gitenv() will also be removed in this release.

 - In 0.99.8, we do not install these backward compatible
   symbolic links in $(bindir) anymore.  The Makefile will have
   a target to remove old symlinks from $(DESTDIR)$(bindir) you
   can run manually to help you clean things up.

   The timeframe for this is around Oct 1st, but I could be
   talked into delaying the symlink removal if Porcelain people
   find this schedule too tight.


What to expect after 0.99.7
===========================

This is written in a form of to-do list for me, so if I say
"accept patch", it means I do not currently plan to do that
myself.  People interested in seeing it materialize please take
a hint.


Documentation
-------------

* Accept patches from people who actually have done CVS
  migration and update the cvs-migration documentation.
  Link the documentation from the main git.txt page.

* Accept patches from people who were hit by shiny blue bat to
  update the SubmittingPatches.

* Talk about using rsync just once at the beginning when
  initializing a remote repository so that local packs do not
  need to be expanded.  I personally do not think we need tool
  support for this (but see below about optimized cloning).

* Maybe update tutorial with a toy project that involves two or
  three developers..

* Update tutorial to cover setting up repository hooks to do
  common tasks.

* Accept patches to finish missing docs.


Technical (heavier)
-------------------

* Tony Luck reported an unfortunate glitch in the 3-way merge.
  Encourage discussions to come up with a not-so-expensive way
  to catch the kind of ambiguities that led to his misery.
  [Deathmatch between Daniel's and Fredrik's ongoing.]

* HPA has two projects, klibc and klibc-kbuild, that have large
  set of overlapping files in different paths (i.e. one has many
  renames from the other).  There currently is no way for git to
  help keep these two trees in sync, merging criss-cross between
  them.  The merge logic should be able to take advantage of
  rename/copy detection smarts git-diff-* family has.  Linus,
  me, and Daniel outlined a smarter merge strategy for this.
  Try them out.

* We might want to optimize cloning with GIT native transport
  not to explode the pack, and store it in objects/pack instead.
  We would need a tool to generate an idx file out of a pack
  file for this.  Also this itself may turn out to be a bad
  idea, making the set of packs in repositories everybody has
  different from each other.

* Libification.  There are many places "run once" mentality is
  ingrained in the management of basic data structures, which
  need to be fixed.

* Maybe a pack optimizer.

* Maybe an Emacs VC backend.


Technical (milder)
------------------

* The recent commit walker safety patch may be too cautious and
  appears to take forever when cloning.  This may even be
  infinitely looping in the code lifted from the old rev-list --
  needs to be taken a look at [DONE INITIAL CUT].

* Encourage concrete proposals to commit log message templates
  we discussed some time ago.

* Accept patches for more portability.

  * strcasestr() in mailinfo.  We may need compat/strcasestr.c;
    this is bugging OpenBSD folks.

* Accept patches to cause "read-tree -u" delete a directory when
  it makes it empty.

* Perhaps accept patches to introduce the concept of "patch flow
  expressed as ref mappings" Josef has been advocating about.

* Perhaps accept patches to do undo/redo.

* Perhaps accept patch to optionally allow '--fuzz' in
  'git-apply'.

* Allow 'git apply' to accept GNU diff 2.7 output that forgets
  to say '\No newline' if both input ends with incomplete
  lines.

* Maybe grok PGP signed text/plain in applymbox as well.

* Perhaps a tool to revert a single file to pre-modification
  state?  git-cat-file blob `git-ls-files | grep foo` >foo or
  git-cat-file blob `git-ls-tree HEAD foo` >foo?  What should
  the command be called?  git-revert is taken so is
  git-checkout.

* Enhance "git repack" to not always use --all; this would be
  handy if the repository contains wagging heads like "pu" in
  git.git repository.

* Internally split the project into non-doc and doc parts; add
  an extra root for the doc part and merge from it; move the
  internal doc source to a separate repository, like the +Meta
  repository; experiment if this results in a reasonable
  workflow, and document it in howto form if it does.

* Make rebase restartable; instead of skipping what cannot be
  automatically forward ported, leave the conflicts in the work
  tree, have the user resolve it, and then restart from where it
  left off.

* Output full path in the "git-rev-list --objects" output, not
  just the basename, and see the improved clustering results in
  better packing [Tried, but did not work out well].

* Remove obsolete commands [READY].

* Option to limit rename detection for more than N paths [READY].

* Option to show only status and name from diff [READY].


Technical (trivial)
-------------------

* 'git add --recursive'?

* 'git merge-projects'?

* 'git lost-and-found'?  Link dangling commits found by
  fsck-objects under $GIT_DIR/refs/lost-found/.  Then
  show-branch or gitk can be used to find any lost commit. [A
  feeler patch sent out. Very underwhelming response X-<.]

  Do not name it /lost+found/; that would probably confuse
  things that mistake it a mount point (not our code but
  somebody else's).

* Add simple globbing rules to git-show-branch so that I can
  say 'git show-branch --heads "ko-*"' (ko-master, ko-pu, and
  ko-rc are in refs/tags/).

* We would want test scripts for the relative directory path
  stuff Linus has been working on.  So far, the following
  commands should be usable with relative directory paths:

    git-update-index
    git-ls-files
    git-diff-files
    git-diff-index
    git-diff-tree
    git-rev-list
    git-rev-parse

* In a freashly created empty repository, `git fetch foo:bar`
  works OK, but `git checkout bar` afterwards does not (missing
  `.git/HEAD`).
