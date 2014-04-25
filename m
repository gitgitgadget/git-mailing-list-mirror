From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.0.0-rc1
Date: Fri, 25 Apr 2014 15:50:15 -0700
Message-ID: <xmqqppk5t460.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Apr 26 00:50:48 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1WdoxC-0007oQ-3M
	for glk-linux-kernel-3@plane.gmane.org; Sat, 26 Apr 2014 00:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbaDYWu3 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 25 Apr 2014 18:50:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37962 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520AbaDYWuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2014 18:50:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AE9180E31;
	Fri, 25 Apr 2014 18:50:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Q
	gj87sCUZKLt/mwwclmLyj5CvHs=; b=JZReVhuYQ+/YEcYv5IFZIVZ9UO3j7cXMn
	Pntyhoow15jPhhiPmszEfExV8TL3iy4ZUT8aVQcP71ADnqH4xAOD30ZxcxLmd5HM
	55dGFLTdanwBcife4f7aDFIVXN6ZRDibo+rTqFErozGf90EySZUV48rnJaLyANUP
	LRsCqHz0rg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=YeoKN4tGrp0K2XUV9YtoNwI5KUCBDeTpGWJMlTPCQDaMKH+7Msr5IlDW
	OGSI/AwDJULVeHkFCVMTSeaCpwaapzbooR41zD1Qd/TmMTliDmcKsRkr8o6q+qfb
	qBFlAfs1ZS1UuopV9RyPE2l2UIub+XGK273cN7kAfJoLLx8bU+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6013980E30;
	Fri, 25 Apr 2014 18:50:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2949780E2F;
	Fri, 25 Apr 2014 18:50:17 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F892D350-CCCB-11E3-9C55-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247124>

A release candidate Git v2.0.0-rc1 is now available for testing
at the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the 'v2.0.0-rc1'
tag and the 'master' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git

Git v2.0 Release Notes (draft)
==============================

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
with "git diff-files --diff-filter=d").

"git request-pull" lost a few "heuristics" that often led to mistakes.

The default prefix for "git svn" has changed in Git 2.0.  For a long
time, "git svn" created its remote-tracking branches directly under
refs/remotes, but it now places them under refs/remotes/origin/ unless
it is told otherwise with its --prefix option.


Updates since v1.9 series
-------------------------

UI, Workflows & Features

 * The "multi-mail" post-receive hook (in contrib/) has been updated
   to a more recent version from the upstream.

 * "git gc --aggressive" learned "--depth" option and
   "gc.aggressiveDepth" configuration variable to allow use of a less
   insane depth than the built-in default value of 250.

 * "git log" learned the "--show-linear-break" option to show where a
   single strand-of-pearls is broken in its output.

 * The "rev-parse --parseopt" mechanism used by scripted Porcelains to
   parse command line options and to give help text learned to take
   the argv-help (the placeholder string for an option parameter,
   e.g. "key-id" in "--gpg-sign=<key-id>").

 * The pattern to find where the function begins in C/C++ used in
   "diff" and "grep -p" have been updated to help C++ source better.

 * "git rebase" learned to interpret a lone "-" as "@{-1}", the
   branch that we were previously on.

 * "git commit --cleanup=<mode>" learned a new mode, scissors.

 * "git tag --list" output can be sorted using "version sort" with
   "--sort=version:refname".

 * Discard the accumulated "heuristics" to guess from which branch the
   result wants to be pulled from and make sure what the end user
   specified is not second-guessed by "git request-pull", to avoid
   mistakes.  When you pushed out your 'master' branch to your public
   repository as 'for-linus', use the new "master:for-linus" syntax to
   denote the branch to be pulled.

 * "git grep" learned to behave in a way similar to native grep when
   "-h" (no header) and "-c" (count) options are given.

 * "git push" via transport-helper interface (e.g. remote-hg) has
   been updated to allow ref deletion in a way similar to the natively
   supported transports.

 * The "simple" mode is the default for "git push".

 * "git add -u" and "git add -A", when run without any pathspec, is a
   tree-wide operation even when run inside a subdirectory of a
   working tree.

 * "git add <path> is the same as "git add -A <path>" now.

 * "core.statinfo" configuration variable, which is a
   never-advertised synonym to "core.checkstat", has been removed.

 * The "-q" option to "git diff-files", which does *NOT* mean
   "quiet", has been removed (it told Git to ignore deletion, which
   you can do with "git diff-files --diff-filter=d").

 * Server operators can loosen the "tips of refs only" restriction for
   the remote archive service with the uploadarchive.allowUnreachable
   configuration option.

 * The progress indicators from various time-consuming commands have
   been marked for i18n/l10n.

 * "git notes -C <blob>" diagnoses an attempt to use an object that
   is not a blob as an error.

 * "git config" learned to read from the standard input when "-" is
   given as the value to its "--file" parameter (attempting an
   operation to update the configuration in the standard input of
   course is rejected).

 * Trailing whitespaces in .gitignore files, unless they are quoted
   for fnmatch(3), e.g. "path\ ", are warned and ignored.  Strictly
   speaking, this is a backward incompatible change, but very unlikely
   to bite any sane user and adjusting should be obvious and easy.

 * Many commands that create commits, e.g. "pull", "rebase",
   learned to take the --gpg-sign option on the command line.

 * "git commit" can be told to always GPG sign the resulting commit
   by setting "commit.gpgsign" configuration variable to true (the
   command line option --no-gpg-sign should override it).

 * "git pull" can be told to only accept fast-forward by setting the
   new "pull.ff" configuration.

 * "git reset" learned "-N" option, which does not reset the index
   fully for paths the index knows about but the tree-ish the command
   resets to does not (these paths are kept as intend-to-add entries).


Performance, Internal Implementation, etc.

 * The compilation options to port to AIX and to MSVC have been
   updated.

 * We started using wildmatch() in place of fnmatch(3) a few releases
   ago; complete the process and stop using fnmatch(3).

 * Uses of curl's "multi" interface and "easy" interface do not mix
   well when we attempt to reuse outgoing connections.  Teach the RPC
   over http code, used in the smart HTTP transport, not to use the
   "easy" interface.

 * The bitmap-index feature from JGit has been ported, which should
   significantly improve performance when serving objects form a
   repository that uses it.

 * The way "git log --cc" shows a combined diff against multiple
   parents have been optimized.

 * The prefixcmp() and suffixcmp() functions are gone.  Use
   starts_with() and ends_with(), and also consider if skip_prefix()
   suits your needs better when using the former.


Also contains various documentation updates and code clean-ups.  Many
of them came from flurry of activities as GSoC candidate microproject
exercises.


Fixes since v1.9 series
-----------------------

Unless otherwise noted, all the fixes since v1.9 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * The remote-helepr interface to fast-import/fast-export via the
   transport-helper has been tightened to avoid leaving the import
   marks file from a failed/crashed run, as such a file that is out of
   sync with the reality confuses a later invocation of itself.

 * "git rebase" used a POSIX shell construct FreeBSD /bin/sh does not
   work well with.
   (merge 8cd6596 km/avoid-non-function-return-in-rebase later to maint).

 * zsh prompt (in contrib/) leaked unnecessary error messages.

 * bash completion (in contrib/) did not complete the refs and remotes
   correctly given "git pu<TAB>" when "pu" is aliased to "push".

 * Some more Unicode codepoints defined in Unicode 6.3 as having zero
   width have been taught to our display column counting logic.
   (merge d813ab9 tb/unicode-6.3-zero-width later to maint).

 * Some tests used shell constructs that did not work well on FreeBSD
   (merge ff7a1c6 km/avoid-bs-in-shell-glob later to maint).
   (merge 00764ca km/avoid-cp-a later to maint).

 * "git update-ref --stdin" did not fail a request to create a ref
   when the ref already existed.
   (merge b9d56b5 mh/update-ref-batch-create-fix later to maint).

 * "git diff --no-index -Mq a b" fell into an infinite loop.
   (merge ad1c3fb jc/fix-diff-no-index-diff-opt-parse later to maint).

 * "git fetch --prune", when the right-hand-side of multiple fetch
   refspecs overlap (e.g. storing "refs/heads/*" to
   "refs/remotes/origin/*", while storing "refs/frotz/*" to
   "refs/remotes/origin/fr/*"), aggressively thought that lack of
   "refs/heads/fr/otz" on the origin site meant we should remove
   "refs/remotes/origin/fr/otz" from us, without checking their
   "refs/frotz/otz" first.

   Note that such a configuration is inherently unsafe (think what
   should happen when "refs/heads/fr/otz" does appear on the origin
   site), but that is not a reason not to be extra careful.
   (merge e6f6371 cn/fetch-prune-overlapping-destination later to maint).

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
   new file to hold the temporary shallow boundaries but it was not
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

 * "git push" did not pay attention to branch.*.pushremote if it is
   defined earlier than remote.pushdefault; the order of these two
   variables in the configuration file should not matter, but it did
   by mistake.
   (merge 98b406f jk/remote-pushremote-config-reading later to maint).

 * Codepaths that parse timestamps in commit objects have been
   tightened.
   (merge f80d1f9 jk/commit-dates-parsing-fix later to maint).

 * "git diff --external-diff" incorrectly fed the submodule directory
   in the working tree to the external diff driver when it knew it is
   the same as one of the versions being compared.
   (merge aba4727 tr/diff-submodule-no-reuse-worktree later to maint).

 * "git reset" needs to refresh the index when working in a working
   tree (it can also be used to match the index to the HEAD in an
   otherwise bare repository), but it failed to set up the working
   tree properly, causing GIT_WORK_TREE to be ignored.
   (merge b7756d4 nd/reset-setup-worktree later to maint).

 * "git check-attr" when working on a repository with a working tree
   did not work well when the working tree was specified via the
   --work-tree (and obviously with --git-dir) option.
   (merge cdbf623 jc/check-attr-honor-working-tree later to maint).

 * "merge-recursive" was broken in 1.7.7 era and stopped working in
   an empty (temporary) working tree, when there are renames
   involved.  This has been corrected.
   (merge 6e2068a bk/refresh-missing-ok-in-merge-recursive later to maint.)

 * "git rev-parse" was loose in rejecting command line arguments
   that do not make sense, e.g. "--default" without the required
   value for that option.
   (merge a43219f ds/rev-parse-required-args later to maint.)

 * include.path variable (or any variable that expects a path that
   can use ~username expansion) in the configuration file is not a
   boolean, but the code failed to check it.
   (merge 67beb60 jk/config-path-include-fix later to maint.)

 * Commands that take pathspecs on the command line misbehaved when
   the pathspec is given as an absolute pathname (which is a
   practice not particularly encouraged) that points at a symbolic
   link in the working tree.
   (merge later 655ee9e mw/symlinks to maint.)

 * "git diff --quiet -- pathspec1 pathspec2" sometimes did not return
   correct status value.
   (merge f34b205 nd/diff-quiet-stat-dirty later to maint.)

 * Attempting to deepen a shallow repository by fetching over smart
   HTTP transport failed in the protocol exchange, when no-done
   extension was used.  The fetching side waited for the list of
   shallow boundary commits after the sending end stopped talking to
   it.
   (merge 0232852 nd/http-fetch-shallow-fix later to maint.)

 * Allow "git cmd path/", when the 'path' is where a submodule is
   bound to the top-level working tree, to match 'path', despite the
   extra and unnecessary trailing slash (such a slash is often
   given by command line completion).
   (merge 2e70c01 nd/submodule-pathspec-ending-with-slash later to maint.)

 * Documentation and in-code comments had many instances of mistaken
   use of "nor", which have been corrected.
   (merge 235e8d5 jl/nor-or-nand-and later to maint).

----------------------------------------------------------------

Changes since v2.0.0-rc0 are as follows:

Dave Borowitz (2):
      Makefile: use curl-config to determine curl flags
      Makefile: allow static linking against libcurl

Elia Pinto (14):
      howto-index.sh: use the $( ... ) construct for command substitution
      install-webdoc.sh: use the $( ... ) construct for command substitution
      git-checkout.sh: use the $( ... ) construct for command substitution
      git-clone.sh: use the $( ... ) construct for command substitution
      git-commit.sh: use the $( ... ) construct for command substitution
      git-fetch.sh: use the $( ... ) construct for command substitution
      git-ls-remote.sh: use the $( ... ) construct for command substitution
      git-merge.sh: use the $( ... ) construct for command substitution
      git-repack.sh: use the $( ... ) construct for command substitution
      git-resolve.sh: use the $( ... ) construct for command substitution
      git-revert.sh: use the $( ... ) construct for command substitution
      git-tag.sh: use the $( ... ) construct for command substitution
      t9360-mw-to-git-clone.sh: use the $( ... ) construct for command substitution
      t9362-mw-to-git-utf8.sh: use the $( ... ) construct for command substitution

Felipe Contreras (6):
      transport-helper: remove barely used xchgline()
      remote-helpers: make recvline return an error
      transport-helper: propagate recvline() error pushing
      transport-helper: trivial cleanup
      transport-helper: fix sync issue on crashes
      t5801 (remote-helpers): cleanup environment sets

Jiang Xin (3):
      i18n: fix uncatchable comments for translators in date.c
      i18n: remove obsolete comments for translators in diffstat generation
      i18n: only extract comments marked with "TRANSLATORS:"

Johan Herland (1):
      Git 2.0: git svn: Set default --prefix='origin/' if --prefix is not given

Junio C Hamano (3):
      i18n: mention "TRANSLATORS:" marker in Documentation/CodingGuidelines
      Update draft release notes to 2.0
      Git 2.0-rc1

Kyle J. McKay (3):
      rebase: avoid non-function use of "return" on FreeBSD
      Revert "rebase: fix run_specific_rebase's use of "return" on FreeBSD"
      ewah_bitmap.c: do not assume size_t and eword_t are the same size
