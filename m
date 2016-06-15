From: Junio C Hamano <junkio@cox.net>
Subject: What to expect after 0.99.8
Date: Sun, 02 Oct 2005 17:14:06 -0700
Message-ID: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 03 02:14:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMDy8-0007sV-24
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 02:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVJCAOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 20:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVJCAOI
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 20:14:08 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:10942 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751160AbVJCAOH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2005 20:14:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051003001400.GJKZ776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Oct 2005 20:14:00 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9626>

As I mentioned in teh 0.99.8 announcement, let's start aiming
for 1.0, really this time.  From now on, brown paper bags,
bugfixes, portability fixes, usability enhancements including
documentation updates take precedence over any new features.
One exception area is probably merge strategy modules -- they
are like adding new device drivers or adding new filesystem, and
can come in anytime as long as they do not touch the coreish.


The GIT To-Do File
==================

  The latest copy of this document is found at 

    http://kernel.org/git/?p=git/git.git;a=blob;hb=todo;f=TODO


Tool Renames Plan
=================

 - In 0.99.8, we still install the backward compatible symbolic
   links in $(bindir).  These will however be removed before 1.0
   happens.

   git-ssh-push and git-ssh-pull pair is not going away within
   this timeframe, if ever.  Each of these old-name commands
   continues to invoke its old-name counterpart on the other
   end.


What to expect after 0.99.8
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

* Talk about using rsync just once at the beginning when
  initializing a remote repository so that local packs do not
  need to be expanded.  I personally do not think we need tool
  support for this (but see below about optimized cloning).

* Maybe update tutorial with a toy project that involves two or
  three developers..

* Update tutorial to cover setting up repository hooks to do
  common tasks.

* Accept patches to finish missing docs.

* Accept patches to talk about "Whoops, it broke.  What's
  next?".

* Accept patches to make formatted tables in asciidoc to work
  well in both html and man pages (see git-diff(1)).


Technical (heavier)
-------------------

* We might want to optimize cloning with GIT native transport
  not to explode the pack, and store it in objects/pack instead.
  We would need a tool to generate an idx file out of a pack
  file for this.  Also this itself may turn out to be a bad
  idea, making the set of packs in repositories everybody has
  different from each other.

* Git daemon, when deployed at kernel.org, might turn out to be
  quite a burden, since it needs to generate customized packs
  every time a new request comes in.  It may be worthwhile to
  precompute some packs for popular sets of heads downloaders
  have and serve that, even if that could give more than the
  client asks for in some cases.  We will know about this soon
  enough.

* Libification.  There are many places "run once" mentality is
  ingrained in the management of basic data structures, which
  need to be fixed.

* Maybe a pack optimizer.

* Maybe an Emacs VC backend.

* 'git split-projects'?  This requires updated 'git-rev-list' to
  skip irrelevant commits.
  Message-ID: <Pine.LNX.4.63.0509221617300.23242@iabervon.org>

* Look at libified GNU diff CVS seems to use, or libxdiff.


Technical (milder)
------------------

* Encourage concrete proposals to commit log message templates
  we discussed some time ago.

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
  state?  People with BK background know this operation as
  'clean'.  'git checkout [-f] ent [path...]' was suggested by
  Matthias Urlichs which sounds a natural extention to what the
  command currently does.

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

* Updated git-changes-script Jeff Garzik needs [Inquiry for
  external spec sent out with a quick hack.  Will know if that
  is what he needs soon enough].


Technical (trivial)
-------------------

* short SHA1 naming is not enforcing uniqueness.  Should fix.

* 'git repack' can be DOSed.  Should fix.

* Stop installing the old-name symlinks [POSTPONED].

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


Local Variables:
mode: text
End:
