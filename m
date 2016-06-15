From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2009, #05; Wed, 21)
Date: Wed, 21 Jan 2009 19:55:36 -0800
Message-ID: <7vab9kataf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 04:57:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPqgl-000888-Kh
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 04:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456AbZAVDzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 22:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756431AbZAVDzm
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 22:55:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbZAVDzl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 22:55:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 67D871CFBC;
	Wed, 21 Jan 2009 22:55:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3B9931CFB9; Wed,
 21 Jan 2009 22:55:38 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 88EE8FE4-E838-11DD-937F-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106715>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* js/valgrind (Wed Jan 21 02:36:40 2009 +0100) 2 commits
 - valgrind: ignore ldso errors
 - Add valgrind support in test scripts

Dscho seems to have some updates out of discussion with Peff.

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

This gives Porcelains (like gitweb) the information on the commit _before_
the one that the final blame is laid on, which should save them one
rev-parse to dig further.  The line number in the "previous" information
may need refining, and sanity checking code for reference counting may
need to be resurrected before this can move forward.

* db/foreign-scm (Sun Jan 11 15:12:10 2009 -0500) 3 commits
 - Support fetching from foreign VCSes
 - Add specification of git-vcs helpers
 - Add "vcs" config option in remotes

The "spec" did not seem quite well cooked yet, but in the longer term I
think something like this to allow interoperating with other SCMs as if
the other end is a native git repository is a very worthy goal.

----------------------------------------------------------------
[Actively cooking]

* sp/runtime-prefix (Sun Jan 18 13:00:15 2009 +0100) 7 commits
 - Windows: Revert to default paths and convert them by
   RUNTIME_PREFIX
 - Compute prefix at runtime if RUNTIME_PREFIX is set
 - Modify setup_path() to only add git_exec_path() to PATH
 - Add calls to git_extract_argv0_path() in programs that call
   git_config_*
 - git_extract_argv0_path(): Move check for valid argv0 from caller
   to callee
 - Refactor git_set_argv0_path() to git_extract_argv0_path()
 - Move computation of absolute paths from Makefile to runtime (in
   preparation for RUNTIME_PREFIX)

We should move this to 'next' soon with J6t's blessing.

* lh/submodule-tree-traversal (Mon Jan 12 00:45:55 2009 +0100) 3 commits
 + builtin-ls-tree: enable traversal of submodules
 + archive.c: enable traversal of submodules
 + tree.c: add support for traversal of submodules

I think choosing the submodules to descend into by seeing if the commit
happens to be available is a horribly broken semantics; it needs to be
fixed before this can move to 'master'.

* jk/signal-cleanup (Sun Jan 11 06:36:49 2009 -0500) 3 commits
 - pager: do wait_for_pager on signal death
 - refactor signal handling for cleanup functions
 - chain kill signals for cleanup functions

I think this can move to 'next', as Peff and J6t agreed on how to fix
things up as needed for Windows.

* ks/maint-mailinfo-folded (Tue Jan 13 01:21:04 2009 +0300) 5 commits
 - mailinfo: tests for RFC2047 examples
 - mailinfo: add explicit test for mails like '<a.u.thor@example.com>
   (A U Thor)'
 - mailinfo: more smarter removal of rfc822 comments from 'From'
 + mailinfo: 'From:' header should be unfold as well
 + mailinfo: correctly handle multiline 'Subject:' header

As far as I can see, the only remaining thing is a minor fix-up in the
"comment removal" one before we can move this fully to 'next'.

* js/notes (Tue Jan 13 20:57:16 2009 +0100) 6 commits
 + git-notes: fix printing of multi-line notes
 + notes: fix core.notesRef documentation
 + Add an expensive test for git-notes
 + Speed up git notes lookup
 + Add a script to edit/inspect notes
 + Introduce commit notes

It would be nice to hear a real world success story using the notes
mechanism before casting this design in stone.

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Split git_project_list_body in two functions
 - gitweb: Modularized git_get_project_description to be more generic

Design discussion between Jakub and Sebastien continues.

----------------------------------------------------------------
[Graduated to "master"]

* jk/color-parse (Sat Jan 17 10:38:46 2009 -0500) 2 commits
 + expand --pretty=format color options
 + color: make it easier for non-config to parse color specs

* sb/hook-cleanup (Sat Jan 17 04:02:55 2009 +0100) 5 commits
 + run_hook(): allow more than 9 hook arguments
 + run_hook(): check the executability of the hook before filling
   argv
 + api-run-command.txt: talk about run_hook()
 + Move run_hook() from builtin-commit.c into run-command.c (libgit)
 + checkout: don't crash on file checkout before running post-
   checkout hook

* rs/ctype (Sat Jan 17 16:50:37 2009 +0100) 4 commits
 + Add is_regex_special()
 + Change NUL char handling of isspecial()
 + Reformat ctype.c
 + Add ctype test

* jf/am-failure-report (Sun Jan 18 19:34:31 2009 -0800) 2 commits
 + git-am: re-fix the diag message printing
 + git-am: Make it easier to see which patch failed

* sg/maint-gitdir-in-subdir (Fri Jan 16 16:37:33 2009 +0100) 1 commit
 + Fix gitdir detection when in subdir of gitdir

This has my "don't do the fullpath if you are directly inside .git"
squashed in, so it should be much safer.

* am/maint-push-doc (Sun Jan 18 15:36:58 2009 +0100) 4 commits
 + Documentation: avoid using undefined parameters
 + Documentation: mention branches rather than heads
 + Documentation: remove a redundant elaboration
 + Documentation: git push repository can also be a remote

* lt/maint-wrap-zlib (Wed Jan 7 19:54:47 2009 -0800) 1 commit
 + Wrap inflate and other zlib routines for better error reporting

Needs the "free our memory upon seeing Z_MEM_ERROR and try again" bits
extracted from Shawn's patch on top of this one.

* kb/am-directory (Wed Jan 14 16:29:59 2009 -0800) 2 commits
 + git-am: fix shell quoting
 + git-am: add --directory=<dir> option

This is "third-time-lucky, perhaps?" resurrection.  I do not think I'd be
using this very often, but it originated from a real user request.

* jc/maint-format-patch-o-relative (Mon Jan 12 15:18:02 2009 -0800) 1 commit
 + Teach format-patch to handle output directory relative to cwd

----------------------------------------------------------------
[Will merge to "master" soon]

* kb/lstat-cache (Sun Jan 18 16:14:54 2009 +0100) 5 commits
 + lstat_cache(): introduce clear_lstat_cache() function
 + lstat_cache(): introduce invalidate_lstat_cache() function
 + lstat_cache(): introduce has_dirs_only_path() function
 + lstat_cache(): introduce has_symlink_or_noent_leading_path()
   function
 + lstat_cache(): more cache effective symlink/directory detection

* tr/previous-branch (Wed Jan 21 00:37:38 2009 -0800) 10 commits
 + Simplify parsing branch switching events in reflog
 + Introduce for_each_recent_reflog_ent().
 + interpret_nth_last_branch(): plug small memleak
 + Fix reflog parsing for a malformed branch switching entry
 + Fix parsing of @{-1}@{1}
 + interpret_nth_last_branch(): avoid traversing the reflog twice
 + checkout: implement "-" abbreviation, add docs and tests
 + sha1_name: support @{-N} syntax in get_sha1()
 + sha1_name: tweak @{-N} lookup
 + checkout: implement "@{-N}" shortcut name for N-th last branch

* js/maint-all-implies-HEAD (Sat Jan 17 22:27:08 2009 -0800) 2 commits
 + bundle: allow the same ref to be given more than once
 + revision walker: include a detached HEAD in --all

* mh/unify-color (Sun Jan 18 21:39:12 2009 +0100) 2 commits
 + move the color variables to color.c
 + handle color.ui at a central place

* cb/add-pathspec (Wed Jan 14 15:54:35 2009 +0100) 2 commits
 + remove pathspec_match, use match_pathspec instead
 + clean up pathspec matching

* js/diff-color-words (Tue Jan 20 21:46:57 2009 -0600) 8 commits
 + color-words: Support diff.wordregex config option
 + color-words: make regex configurable via attributes
 + color-words: expand docs with precise semantics
 + color-words: enable REG_NEWLINE to help user
 + color-words: take an optional regular expression describing words
 + color-words: change algorithm to allow for 0-character word
   boundaries
 + color-words: refactor word splitting and use ALLOC_GROW()
 + Add color_fwrite_lines(), a function coloring each line
   individually

* js/patience-diff (Thu Jan 1 17:39:37 2009 +0100) 3 commits
 + bash completions: Add the --patience option
 + Introduce the diff option '--patience'
 + Implement the patience diff algorithm

----------------------------------------------------------------
[On Hold]

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 . diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 . git-am --forge: add Signed-off-by: line for the author
 . git-am: clean-up Signed-off-by: lines
 . stripspace: add --log-clean option to clean up signed-off-by:
   lines
 . stripspace: use parse_options()
 . Add "git am -s" test
 . git-am: refactor code to add signed-off-by line for the committer

* jc/post-simplify (Fri Aug 15 01:34:51 2008 -0700) 2 commits
 . revision --simplify-merges: incremental simplification
 . revision --simplify-merges: prepare for incremental simplification

* wp/add-patch-find (Thu Nov 27 04:08:03 2008 +0000) 3 commits
 . In add --patch, Handle K,k,J,j slightly more gracefully.
 . Add / command in add --patch
 . git-add -i/-p: Change prompt separater from slash to comma

* jc/grafts (Wed Jul 2 17:14:12 2008 -0700) 1 commit
 . [BROKEN wrt shallow clones] Ignore graft during object transfer

* jc/replace (Fri Oct 31 09:21:39 2008 -0700) 1 commit
 . WIP
