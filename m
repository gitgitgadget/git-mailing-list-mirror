From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.0.0-rc4
Date: Tue, 20 May 2014 17:24:50 -0700
Message-ID: <xmqqr43oq8q5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Wed May 21 02:25:24 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1WmuLO-0005jA-U1
	for glk-linux-kernel-3@plane.gmane.org; Wed, 21 May 2014 02:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbaEUAZG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 20 May 2014 20:25:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50152 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbaEUAZC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2014 20:25:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44D241933C;
	Tue, 20 May 2014 20:24:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=FnzYNwV9vEkHzJKHZ2LcNr8AL
	v8=; b=CLnihkWDIEN61cwjFlKXYZg6r6YK65HGhWJgMAUOsh4GaZ813J8NsIyq6
	cDiWjerHoSH4kOZkbCEOBdLRayN+XX9NcljjSxNwgUsoe86z5wttBM2Quxuglb5H
	4VjnL2myeqrBKOBIHeKlYWp0RT3qnE5DnL/q563Hhq+CA8qv+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=KU9wdS5rc1tHsexEh2l
	EZZaRZkwnd1nFcV+WhEFLQEiTcPqU1+ztwPLMm4Ylq1Wvr0qpolqGr5+mf1kZnaJ
	3OswJx5LMI05nONic3zpUO8+TYI/ImYKmo5LeM92tQvue2sVQrb2u/ZiddATFuz8
	RcF7jrH82bEtx6FHeZy0e42k=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3A7D719339;
	Tue, 20 May 2014 20:24:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 57E1C1932F;
	Tue, 20 May 2014 20:24:52 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 538FE606-E07E-11E3-9D46-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249764>

A release candidate Git v2.0.0-rc4, hopefully the final one before
the real thing, is now available for testing at the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the 'v2.0.0-rc4'
tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v2.0 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Backward compatibility notes
----------------------------

When "git push [$there]" does not say what to push, we have used the
traditional "matching" semantics so far (all your branches were sent
to the remote as long as there already are branches of the same name
over there).  In Git 2.0, the default is now the "simple" semantics,
which pushes:

 - only the current branch to the branch with the same name, and only
   when the current branch is set to integrate with that remote
   branch, if you are pushing to the same remote as you fetch from; or

 - only the current branch to the branch with the same name, if you
   are pushing to a remote that is not where you usually fetch from.

You can use the configuration variable "push.default" to change
this.  If you are an old-timer who wants to keep using the
"matching" semantics, you can set the variable to "matching", for
example.  Read the documentation for other possibilities.

When "git add -u" and "git add -A" are run inside a subdirectory
without specifying which paths to add on the command line, they
operate on the entire tree for consistency with "git commit -a" and
other commands (these commands used to operate only on the current
subdirectory).  Say "git add -u ." or "git add -A ." if you want to
limit the operation to the current directory.

"git add <path>" is the same as "git add -A <path>" now, so that
"git add dir/" will notice paths you removed from the directory and
record the removal.  In older versions of Git, "git add <path>" used
to ignore removals.  You can say "git add --ignore-removal <path>" to
add only added or modified paths in <path>, if you really want to.

The "-q" option to "git diff-files", which does *NOT* mean "quiet",
has been removed (it told Git to ignore deletion, which you can do
with "git diff-files --diff-filter=3Dd").

"git request-pull" lost a few "heuristics" that often led to mistakes.

The default prefix for "git svn" has changed in Git 2.0.  For a long
time, "git svn" created its remote-tracking branches directly under
refs/remotes, but it now places them under refs/remotes/origin/ unless
it is told otherwise with its "--prefix" option.


Updates since v1.9 series
-------------------------

UI, Workflows & Features

 * The "multi-mail" post-receive hook (in contrib/) has been updated
   to a more recent version from upstream.

 * The "remote-hg/bzr" remote-helper interfaces (in contrib/) are
   now maintained separately as a third-party plug-in.

 * "git gc --aggressive" learned "--depth" option and
   "gc.aggressiveDepth" configuration variable to allow use of a less
   insane depth than the built-in default value of 250.

 * "git log" learned the "--show-linear-break" option to show where a
   single strand-of-pearls is broken in its output.

 * The "rev-parse --parseopt" mechanism used by scripted Porcelains to
   parse command-line options and to give help text learned to take
   the argv-help (the placeholder string for an option parameter,
   e.g. "key-id" in "--gpg-sign=3D<key-id>").

 * The pattern to find where the function begins in C/C++ used in
   "diff" and "grep -p" has been updated to improve viewing C++
   sources.

 * "git rebase" learned to interpret a lone "-" as "@{-1}", the
   branch that we were previously on.

 * "git commit --cleanup=3D<mode>" learned a new mode, scissors.

 * "git tag --list" output can be sorted using "version sort" with
   "--sort=3Dversion:refname".

 * Discard the accumulated "heuristics" to guess from which branch the
   result wants to be pulled from and make sure that what the end user
   specified is not second-guessed by "git request-pull", to avoid
   mistakes.  When you pushed out your 'master' branch to your public
   repository as 'for-linus', use the new "master:for-linus" syntax to
   denote the branch to be pulled.

 * "git grep" learned to behave in a way similar to native grep when
   "-h" (no header) and "-c" (count) options are given.

 * "git push" via transport-helper interface has been updated to
   allow forced ref updates in a way similar to the natively
   supported transports.

 * The "simple" mode is the default for "git push".

 * "git add -u" and "git add -A", when run without any pathspec, is a
   tree-wide operation even when run inside a subdirectory of a
   working tree.

 * "git add <path>" is the same as "git add -A <path>" now.

 * "core.statinfo" configuration variable, which is a
   never-advertised synonym to "core.checkstat", has been removed.

 * The "-q" option to "git diff-files", which does *NOT* mean
   "quiet", has been removed (it told Git to ignore deletion, which
   you can do with "git diff-files --diff-filter=3Dd").

 * Server operators can loosen the "tips of refs only" restriction for
   the remote archive service with the uploadarchive.allowUnreachable
   configuration option.

 * The progress indicators from various time-consuming commands have
   been marked for i18n/l10n.

 * "git notes -C <blob>" diagnoses as an error an attempt to use an
   object that is not a blob.

 * "git config" learned to read from the standard input when "-" is
   given as the value to its "--file" parameter (attempting an
   operation to update the configuration in the standard input is
   rejected, of course).

 * Trailing whitespaces in .gitignore files, unless they are quoted
   for fnmatch(3), e.g. "path\ ", are warned and ignored.  Strictly
   speaking, this is a backward-incompatible change, but very unlikely
   to bite any sane user and adjusting should be obvious and easy.

 * Many commands that create commits, e.g. "pull" and "rebase",
   learned to take the "--gpg-sign" option on the command line.

 * "git commit" can be told to always GPG sign the resulting commit
   by setting the "commit.gpgsign" configuration variable to "true"
   (the command-line option "--no-gpg-sign" should override it).

 * "git pull" can be told to only accept fast-forward by setting the
   new "pull.ff" configuration variable.

 * "git reset" learned the "-N" option, which does not reset the index
   fully for paths the index knows about but the tree-ish the command
   resets to does not (these paths are kept as intend-to-add entries).


Performance, Internal Implementation, etc.

 * The compilation options to port to AIX and to MSVC have been
   updated.

 * We started using wildmatch() in place of fnmatch(3) a few releases
   ago; complete the process and stop using fnmatch(3).

 * Uses of curl's "multi" interface and "easy" interface do not mix
   well when we attempt to reuse outgoing connections.  Teach the RPC
   over HTTP code, used in the smart HTTP transport, not to use the
   "easy" interface.

 * The bitmap-index feature from JGit has been ported, which should
   significantly improve performance when serving objects from a
   repository that uses it.

 * The way "git log --cc" shows a combined diff against multiple
   parents has been optimized.

 * The prefixcmp() and suffixcmp() functions are gone.  Use
   starts_with() and ends_with(), and also consider if skip_prefix()
   suits your needs better when using the former.


Also contains various documentation updates and code clean-ups.  Many
of them came from flurry of activities as GSoC candidate microproject
exercises.


=46ixes since v1.9 series
-----------------------

Unless otherwise noted, all the fixes since v1.9 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * "git p4" was broken in 1.9 release to deal with changes in binary
   files.
   (merge 749b668 cl/p4-use-diff-tree later to maint).

 * The shell prompt script (in contrib/), when using the PROMPT_COMMAND
   interface, used an unsafe construct when showing the branch name in
   $PS1.
   (merge 8976500 rh/prompt-pcmode-avoid-eval-on-refname later to maint=
).

 * The remote-helper interface to fast-import/fast-export via the
   transport-helper has been tightened to avoid leaving the import
   marks file from a failed/crashed run, as such a file that is out-of-
   sync with reality confuses a later invocation of itself.

 * "git rebase" used a POSIX shell construct FreeBSD's /bin/sh does not
   work well with.
   (merge 8cd6596 km/avoid-non-function-return-in-rebase later to maint=
).

 * zsh prompt (in contrib/) leaked unnecessary error messages.

 * Bash completion (in contrib/) did not complete the refs and remotes
   correctly given "git pu<TAB>" when "pu" is aliased to "push".

 * Some more Unicode code points, defined in Unicode 6.3 as having zero
   width, have been taught to our display column counting logic.
   (merge d813ab9 tb/unicode-6.3-zero-width later to maint).

 * Some tests used shell constructs that did not work well on FreeBSD
   (merge ff7a1c6 km/avoid-bs-in-shell-glob later to maint).
   (merge 00764ca km/avoid-cp-a later to maint).

 * "git update-ref --stdin" did not fail a request to create a ref
   when the ref already existed.
   (merge b9d56b5 mh/update-ref-batch-create-fix later to maint).

 * "git diff --no-index -Mq a b" fell into an infinite loop.
   (merge ad1c3fb jc/fix-diff-no-index-diff-opt-parse later to maint).

 * "git fetch --prune", when the right-hand side of multiple fetch
   refspecs overlap (e.g. storing "refs/heads/*" to
   "refs/remotes/origin/*", while storing "refs/frotz/*" to
   "refs/remotes/origin/fr/*"), aggressively thought that lack of
   "refs/heads/fr/otz" on the origin site meant we should remove
   "refs/remotes/origin/fr/otz" from us, without checking their
   "refs/frotz/otz" first.

   Note that such a configuration is inherently unsafe (think what
   should happen when "refs/heads/fr/otz" does appear on the origin
   site), but that is not a reason not to be extra careful.
   (merge e6f6371 cn/fetch-prune-overlapping-destination later to maint=
).

 * "git status --porcelain --branch" showed its output with labels
   "ahead/behind/gone" translated to the user's locale.
   (merge 7a76c28 mm/status-porcelain-format-i18n-fix later to maint).

 * A stray environment variable $prefix could have leaked into and
   affected the behaviour of the "subtree" script (in contrib/).

 * When it is not necessary to edit a commit log message (e.g. "git
   commit -m" is given a message without specifying "-e"), we used to
   disable the spawning of the editor by overriding GIT_EDITOR, but
   this means all the uses of the editor, other than to edit the
   commit log message, are also affected.
   (merge b549be0 bp/commit-p-editor later to maint).

 * "git mv" that moves a submodule forgot to adjust the array that
   uses to keep track of which submodules were to be moved to update
   its configuration.
   (merge fb8a4e8 jk/mv-submodules-fix later to maint).

 * Length limit for the pathname used when removing a path in a deep
   subdirectory has been removed to avoid buffer overflows.
   (merge 2f29e0c mh/remove-subtree-long-pathname-fix later to maint).

 * The test helper lib-terminal always run an actual test_expect_*
   when included, which screwed up with the use of skil-all that may
   have to be done later.
   (merge 7e27173 jk/lib-terminal-lazy later to maint).

 * "git index-pack" used a wrong variable to name the keep-file in an
   error message when the file cannot be written or closed.
   (merge de983a0 nd/index-pack-error-message later to maint).

 * "rebase -i" produced a broken insn sheet when the title of a commit
   happened to contain '\n' (or ended with '\c') due to a careless use
   of 'echo'.
   (merge cb1aefd us/printf-not-echo later to maint).

 * There were a few instances of 'git-foo' remaining in the
   documentation that should have been spelled 'git foo'.
   (merge 3c3e6f5 rr/doc-merge-strategies later to maint).

 * Serving objects from a shallow repository needs to write a
   new file to hold the temporary shallow boundaries, but it was not
   cleaned when we exit due to die() or a signal.
   (merge 7839632 jk/shallow-update-fix later to maint).

 * When "git stash pop" stops after failing to apply the stash
   (e.g. due to conflicting changes), the stash is not dropped. State
   that explicitly in the output to let the users know.
   (merge 2d4c993 jc/stash-pop-not-popped later to maint).

 * The labels in "git status" output that describe the nature of
   conflicts (e.g. "both deleted") were limited to 20 bytes, which was
   too short for some l10n (e.g. fr).
   (merge c7cb333 jn/wt-status later to maint).

 * "git clean -d pathspec" did not use the given pathspec correctly
   and ended up cleaning too much.
   (merge 1f2e108 jk/clean-d-pathspec later to maint).

 * "git difftool" misbehaved when the repository is bound to the
   working tree with the ".git file" mechanism, where a textual file
   ".git" tells us where it is.
   (merge fcfec8b da/difftool-git-files later to maint).

 * "git push" did not pay attention to "branch.*.pushremote" if it is
   defined earlier than "remote.pushdefault"; the order of these two
   variables in the configuration file should not matter, but it did
   by mistake.
   (merge 98b406f jk/remote-pushremote-config-reading later to maint).

 * Code paths that parse timestamps in commit objects have been
   tightened.
   (merge f80d1f9 jk/commit-dates-parsing-fix later to maint).

 * "git diff --external-diff" incorrectly fed the submodule directory
   in the working tree to the external diff driver when it knew that it
   is the same as one of the versions being compared.
   (merge aba4727 tr/diff-submodule-no-reuse-worktree later to maint).

 * "git reset" needs to refresh the index when working in a working
   tree (it can also be used to match the index to the HEAD in an
   otherwise bare repository), but it failed to set up the working
   tree properly, causing GIT_WORK_TREE to be ignored.
   (merge b7756d4 nd/reset-setup-worktree later to maint).

 * "git check-attr" when working on a repository with a working tree
   did not work well when the working tree was specified via the
   "--work-tree" (and obviously with "--git-dir") option.
   (merge cdbf623 jc/check-attr-honor-working-tree later to maint).

 * "merge-recursive" was broken in 1.7.7 era and stopped working in
   an empty (temporary) working tree, when there are renames
   involved.  This has been corrected.
   (merge 6e2068a bk/refresh-missing-ok-in-merge-recursive later to mai=
nt.)

 * "git rev-parse" was loose in rejecting command-line arguments
   that do not make sense, e.g. "--default" without the required
   value for that option.
   (merge a43219f ds/rev-parse-required-args later to maint.)

 * "include.path" variable (or any variable that expects a path that
   can use ~username expansion) in the configuration file is not a
   boolean, but the code failed to check it.
   (merge 67beb60 jk/config-path-include-fix later to maint.)

 * Commands that take pathspecs on the command line misbehaved when
   the pathspec is given as an absolute pathname (which is a
   practice not particularly encouraged) that points at a symbolic
   link in the working tree.
   (merge later 655ee9e mw/symlinks to maint.)

 * "git diff --quiet -- pathspec1 pathspec2" sometimes did not return
   the correct status value.
   (merge f34b205 nd/diff-quiet-stat-dirty later to maint.)

 * Attempting to deepen a shallow repository by fetching over smart
   HTTP transport failed in the protocol exchange, when the no-done
   extension was used.  The fetching side waited for the list of
   shallow boundary commits after the sending side stopped talking to
   it.
   (merge 0232852 nd/http-fetch-shallow-fix later to maint.)

 * Allow "git cmd path/", when the 'path' is where a submodule is
   bound to the top-level working tree, to match 'path', despite the
   extra and unnecessary trailing slash (such a slash is often
   given by command-line completion).
   (merge 2e70c01 nd/submodule-pathspec-ending-with-slash later to main=
t.)

 * Documentation and in-code comments had many instances of mistaken
   use of "nor", which have been corrected.
   (merge 235e8d5 jl/nor-or-nand-and later to maint).

----------------------------------------------------------------

Changes since v2.0.0-rc3 are as follows:

Alexander Shopov (1):
      l10n: Updated Bulgarian translation of git (1307t0f921u)

Anders Kaseorg (1):
      Documentation/technical/api-hashmap: remove source highlighting

=46elipe Contreras (2):
      contrib: completion: fix 'eread()' namespace
      contrib: remote-helpers: add move warnings (v2.0)

Gr=C3=A9goire Paris (1):
      fr: a lot of good fixups

Jason St. John (1):
      RelNotes/2.0.0.txt: Fix several grammar issues, notably a lack of=
 hyphens, double quotes, or articles

Jens Lehmann (1):
      git-gui: tolerate major version changes when comparing the git ve=
rsion

Junio C Hamano (5):
      request-pull: resurrect for-linus -> tags/for-linus DWIM
      Revert "Merge branch 'fc/transport-helper-sync-error-fix'"
      remote-helpers: point at their upstream repositories
      Revert "Merge branch 'jc/graduate-remote-hg-bzr' (early part)"
      Git 2.0-rc4

Richard Hansen (1):
      git-prompt.sh: don't assume the shell expands the value of PS1
