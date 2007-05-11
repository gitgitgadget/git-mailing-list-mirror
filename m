From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.5.2-rc3
Date: Thu, 10 May 2007 17:23:04 -0700
Message-ID: <7virb0gqdz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759613AbXEKAXV@vger.kernel.org Fri May 11 02:23:35 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759613AbXEKAXV@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmIuy-0002vF-6e
	for glk-linux-kernel-3@gmane.org; Fri, 11 May 2007 02:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759613AbXEKAXV (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 10 May 2007 20:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755718AbXEKAXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 May 2007 20:23:07 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:63516 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbXEKAXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 May 2007 20:23:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511002305.JGVN2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 20:23:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xcP41W00J1kojtg0000000; Thu, 10 May 2007 20:23:05 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46920>

Upcoming 1.5.2 will have three large-ish new features that the
user community wished to have for quite some time.  I usually do
not CC the kernel list for -rc releases, but this one will
hopefully be pretty much the same as what the final one would
look like, so here it is.

We may get around fixing the long standing git-apply corner case
HPA's rebase problem unveiled before v1.5.2, but we might defer
it post 1.5.2 (it is not a regression).  We'll see.

----------------------------------------------------------------

GIT v1.5.2 Release Notes (draft)
========================

Updates since v1.5.1
--------------------

* Plumbing level subproject support.

  You can include a subdirectory that has an independent git
  repository in your index and tree objects as a
  "subproject".  This plumbing (i.e. "core") level subproject
  support explicitly excludes recursive behaviour.

  The "subproject" entries in the index and trees are
  incompatible with older versions of git.  Experimenting with
  the plumbing level support is encouraged, but be warned that
  unless everybody in your project updates to this release or
  later, using this feature would make your project
  inaccessible by people with older versions of git.

* Plumbing level gitattributes support.

  The gitattributes mechanism allows you to add 'attributes' to
  paths in your project, and affect the way certain git
  operations work.  Currently you can influence if a path is
  considered a binary or text (the former would be treated by
  'git diff' not to produce textual output; the latter can go
  through the line endings conversion process in repositories
  with core.autocrlf set), expand and unexpand '$ident$' keyword
  with blob object name, specify a custom 3-way merge driver,
  and specify a custom diff driver.  You can also apply
  arbitrary filter to contents on check-in/check-out codepath
  but this feature is an extremely sharp-edged razor and needs
  to be handled with caution (do not use it unless you
  understand the earlier mailing list discussion on keyword
  expansion).

* The packfile format now optionally suports 64-bit index.

  This release supports the "version 2" format of the .idx
  file.  This is automatically enabled when a huge packfile
  needs more than 32-bit to express offsets of objects in the
  pack

* Comes with an updated git-gui 0.7.0

* Updated gitweb:

  - can show combined diff for merges;
  - uses font size of user's preference, not hardcoded in pixels;

* New commands and options.

  - "git bisect start" can optionally take a single bad commit and
    zero or more good commits on the command line.

  - "git shortlog" can optionally be told to wrap its output.

  - "subtree" merge strategy allows another project to be merged in as
    your subdirectory.

  - "git format-patch" learned a new --subject-prefix=<string>
    option, to override the built-in "[PATCH]".

  - "git add -u" is a quick way to do the first stage of "git
    commit -a" (i.e. update the index to match the working
    tree); it obviously does not make a commit.

  - "git clean" honors a new configuration, "clean.requireforce".  When
    set to true, this makes "git clean" a no-op, preventing you
    from losing files by typing "git clean" when you meant to
    say "make clean".  You can still say "git clean -f" to
    override this.

  - "git log" family of commands learned --date={local,relative,default}
    option.  --date=relative is synonym to the --relative-date.
    --date=local gives the timestamp in local timezone.

* Updated behavior of existing commands.

  - When $GIT_COMMITTER_EMAIL or $GIT_AUTHOR_EMAIL is not set
    but $EMAIL is set, the latter is used as a substitute.

  - "git diff --stat" shows size of preimage and postimage blobs
    for binary contents.  Earlier it only said "Bin".

  - "git lost-found" shows stuff that are unreachable except
    from reflogs.

  - "git checkout branch^0" now detaches HEAD at the tip commit
    on the named branch, instead of just switching to the
    branch (use "git checkout branch" to switch to the branch,
    as before).

  - "git bisect next" can be used after giving only a bad commit
    without giving a good one (this starts bisection half-way to
    the root commit).  We used to refuse to operate without a
    good and a bad commit.

  - "git push", when pushing into more than one repository, does
    not stop at the first error.

  - "git archive" does not insist you to give --format parameter
    anymore; it defaults to "tar".

  - "git cvsserver" can use backends other than sqlite.

  - "gitview" (in contrib/ section) learned to better support
    "git-annotate".

  - "git diff $commit1:$path2 $commit2:$path2" can now report
    mode changes between the two blobs.

  - Local "git fetch" from a repository whose object store is
    one of the alternates (e.g. fetching from the origin in a
    repository created with "git clone -l -s") avoids
    downloading objects unnecessary.

  - "git blame" uses .mailmap to canonicalize the author name
    just like "git shortlog" does.

  - "git pack-objects" pays attention to pack.depth
    configuration variable.

  - "git cherry-pick" and "git revert" does not use .msg file in
    the working tree to prepare commit message; instead it uses
    $GIT_DIR/MERGE_MSG as other commands.

* Builds

  - git-p4import has never been installed; now there is an
    installation option to do so.

  - gitk and git-gui can be configured out.

  - Generated documentation pages automatically get version
    information from GIT_VERSION

  - Parallel build with "make -j" descending into subdirectory
    was fixed.

* Performance Tweaks

  - Optimized "git-rev-list --bisect" (hence "git-bisect").

  - Optimized "git-add $path" in a large directory, most of
    whose contents are ignored.

  - Optimized "git-diff-tree" for reduced memory footprint.

  - The recursive merge strategy updated a worktree file that
    was changed identically in two branches, when one of them
    renamed it.  We do not do that when there is no rename, so
    match that behaviour.

  - The default pack depth has been increased to 50, as the
    recent addition of delta_base_cache makes deeper delta chains
    much less expensive to access.


Fixes since v1.5.1
------------------

All of the fixes in v1.5.1 maintenance series are included in
this release, unless otherwise noted.

* Bugfixes

  - Switching branches with "git checkout" refused to work when
    a path changes from a file to a directory between the
    current branch and the new branch, in order not to lose
    possible local changes in the directory that is being turned
    into a file with the switch.  We now allow such a branch
    switch after making sure that there is no locally modified
    file nor un-ignored file in the directory.  This has not
    been backported to 1.5.1.x series, as it is rather an
    intrusive change.

  - Merging branches that have a file in one and a directory in
    another at the same path used to get quite confused.  We
    handle such a case a bit more carefully, even though that is
    still left as a conflict for the user to sort out.  This
    will not be backported to 1.5.1.x series, as it is rather an
    intrusive change.

  - git-fetch had trouble with a remote with insanely large number
    of refs.

  - "git clean -d -X" now does not remove non-excluded directories.

* Documentation updates

* Performance Tweaks

----------------------------------------------------------------

Changes since v1.5.2-rc2 are as follows:

Alex Riesen (1):
      Use GIT_OBJECT_DIR for temporary files of pack-objects

Amos Waterland (1):
      wcwidth redeclaration

Frank Lichtenheld (1):
      cvsserver: Add test cases for git-cvsserver

Gerrit Pape (1):
      gitweb: choose appropriate view for file type if a= parameter missing

J. Bruce Fields (7):
      user-manual: more discussion of detached heads, fix typos
      user-manual: add section ID's
      user-manual: clean up fast-forward and dangling-objects sections
      user-manual: fix .gitconfig editing examples
      user-manual: miscellaneous editing
      user-manual: stop deprecating the manual
      user-manual: fix clone and fetch typos

Jakub Narebski (6):
      gitweb: Add parsing of raw combined diff format to parse_difftree_raw_line
      gitweb: Add combined diff support to git_difftree_body
      gitweb: Add combined diff support to git_patchset_body
      gitweb: Make it possible to use pre-parsed info in git_difftree_body
      gitweb: Show combined diff for merge commits in 'commitdiff' view
      gitweb: Show combined diff for merge commits in 'commit' view

Jari Aalto (1):
      SPECIFYING RANGES typo fix: it it => it is

Jeff King (1):
      Documentation: don't reference non-existent 'git-cvsapplycommit'

Johannes Sixt (1):
      git-gui: Call changes "Staged" and "Unstaged" in file list titles.

Junio C Hamano (10):
      diff: release blobs after generating textual diff.
      diff.c: do not use a separate "size cache".
      diff -M: release the preimage candidate blobs after rename detection.
      diff -S: release the image after looking for needle in it
      GIT v1.5.1.4
      Update documentation links to point at 1.5.1.4
      t9400: skip cvsserver test if Perl SQLite interface is unavailable
      git-clone: don't get fooled by $PWD
      .mailmap: add some aliases
      GIT v1.5.2-rc3

Matthieu Moy (2):
      Document git add -u introduced earlier.
      Added a reference to git-add in the documentation for git-update-index

Michael Hendricks (1):
      Document 'git-log --decorate'

Michael Spang (3):
      dir.c: Omit non-excluded directories with dir->show_ignored
      t7300: Basic tests for git-clean
      Fix minor documentation errors

Paul Mackerras (1):
      gitk: Allow user to choose whether to see the diff, old file, or new file

Petr Baudis (2):
      Git.pm: config_boolean() -> config_bool()
      gitweb: Do not use absolute font sizes

Quy Tonthat (2):
      Add howto files to rpm packages.
      Added new git-gui library files to rpm spec

Richard P. Curnow (2):
      Fix documentation of tag in git-fast-import.txt
      Fix documentation of tag in git-fast-import.txt

Shawn O. Pearce (32):
      git-gui: Correctly handle UTF-8 encoded commit messages
      git-gui: Allow spaces in path to 'wish'
      git-gui: Include the subject in the status bar after commit
      git-gui: Warn users before making an octopus merge
      git-gui: Correct line wrapping for too many branch message
      git-gui: Cleanup common font handling for font_ui
      git-gui: Use option database defaults to set the font
      git-gui: Refactor to use our git proc more often
      git-gui: Track our own embedded values and rebuild when they change
      Properly handle '0' filenames in import-tars
      git-gui: Refactor into multiple files to save my sanity
      git-gui: Move console procs into their own namespace
      git-gui: Allow vi keys to scroll the diff/blame regions
      git-gui: Move merge support into a namespace
      git-gui: Show all possible branches for merge
      git-gui: Include commit id/subject in merge choices
      git-gui: Use vi-like keys in merge dialog
      Remove duplicate exports from Makefile
      git-gui: Allow shift-{k,j} to select a range of branches to merge
      git-gui: Define a simple class/method system
      git-gui: Convert browser, console to "class" format
      git-gui: Don't attempt to inline array reads in methods
      git-gui: Convert blame to the "class" way of doing things
      git-gui: Use prefix if blame is run in a subdirectory
      git-gui: Smarter command line parsing for browser, blame
      git-gui: Generate blame on uncommitted working tree file
      git-gui: Cleanup minor nits in blame code
      git-gui: Format author/committer times in ISO format
      Use .git/MERGE_MSG in cherry-pick/revert
      git-gui: Paperbag fix blame in subdirectory
      git gui 0.7.0
      Correct error message in revert/cherry-pick

Theodore Ts'o (2):
      Add pack.depth option to git-pack-objects.
      Increase pack.depth default to 50
