From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Wed, 28 Jan 2009 18:06:45 -0800
Message-ID: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 03:08:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSMKO-00067p-G1
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 03:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756931AbZA2CGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 21:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756873AbZA2CGx
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 21:06:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45625 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520AbZA2CGv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 21:06:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C28DD94A81;
	Wed, 28 Jan 2009 21:06:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3BB9094A7D; Wed,
 28 Jan 2009 21:06:46 -0500 (EST)
X-master-at: 8712b3cdb0495f5a56b91cd67e2697412447a886
X-next-at: c2891ee32a7e8274426c22439ed8d536a5b0bb43
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7D43F4A6-EDA9-11DD-AAE0-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107613>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* jc/maint-1.6.0-split-diff-metainfo (Mon Jan 26 00:08:24 2009 -0800) 1 commit
 + diff.c: output correct index lines for a split diff

This is slated for maintenance series 1.6.0.X, 1.6.1.X and also for
'master'.  I think the change is pretty safe and sane to go directly to
'master' but I had too many other topoics to look at that I did not feel
comfortable enough to do so.

* jc/maint-split-diff-metainfo (Tue Jan 27 01:08:02 2009 -0800) 2 commits
 + Merge branch 'jc/maint-1.6.0-split-diff-metainfo' into jc/maint-
   split-diff-metainfo
 + diff.c: output correct index lines for a split diff

Early conflict resolution branch for the above to carry it to 1.6.1X
series.

* js/maint-rebase-i-submodule (Tue Jan 27 12:42:31 2009 +0100) 2 commits
 + Fix submodule squashing into unrelated commit
 + rebase -i squashes submodule changes into unrelated commit

* jg/tag-contains (Mon Jan 26 09:13:25 2009 -0500) 3 commits
 + git-tag: Add --contains option
 + Make has_commit() non-static
 + Make opt_parse_with_commit() non-static

* jk/maint-cleanup-after-exec-failure (Wed Jan 28 02:38:14 2009 -0500) 4 commits
 + git: use run_command() to execute dashed externals
 + run_command(): help callers distinguish errors
 + run_command(): handle missing command errors more gracefully
 + git: s/run_command/run_builtin/

* jc/maint-allow-uninteresting-missing (Tue Jan 27 23:19:30 2009 -0800) 1 commit
 + revision traversal: allow UNINTERESTING objects to be missing

This is a small follow-up to the fix to send-pack in 1.6.1; meant to go in
1.6.1.X maintenance series and newer.

* am/maint-push-doc (Mon Jan 26 00:45:33 2009 +0100) 3 commits
 + Documentation: rework src/dst description in git push
 + Documentation: more git push examples
 + Documentation: simplify refspec format description

* jc/merge-convert (Mon Jan 26 16:45:01 2009 -0800) 1 commit
 - git-merge-file: allow converting the results for the work tree

We did not give scripted Porcelains a way to say "this temporary file I am
using for merging is for this path, so use the core.autocrlf and attributes
rules for that final path".  Instead, merge-file simply wrote out the
data in the canonical repository representation.

rerere has the same issue, but it is a lot worse.  It reads the three
files (preimage, postimage and thisimage) from the work tree in the work
tree representation, merges them without converting them to the canonical
representation first but inserts the conflict markers with the canonical
representation and writes the resulting mess out.  It needs to be fixed to
read with convert_to_git(), merge them while they are still in the
canonical representation and possibly add conflict markers, and then write
the results out after convert_to_working_tree().  It also needs to write
in binary mode as well.

* jc/maint-add-u-remove-conflicted (Wed Jan 28 14:24:53 2009 -0800) 1 commit
 - add -u: do not fail to resolve a path as deleted

This has been updated from the posted version with a correction.

* ns/am-slacker (Sat Jan 24 10:18:02 2009 +0900) 2 commits
 + git-am: Add --ignore-date option
 + am: Add --committer-date-is-author-date option

It is a (probably) useful new feature with a sort-of cute explanation.

* jc/maint-apply-fix (Sun Jan 25 23:41:26 2009 -0800) 1 commit
 + builtin-apply.c: do not set bogus mode in check_preimage() for
   deleted path

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

* cc/replace (Fri Jan 23 10:07:46 2009 +0100) 7 commits
 - environment: add global variable to disable replacement
 - mktag: call "check_sha1_signature" with the replacement sha1
 - replace_object: add a test case
 - object: call "check_sha1_signature" with the replacement sha1
 - sha1_file: add a "read_sha1_file_repl" function
 - replace_object: add mechanism to replace objects found in
   "refs/replace/"
 - refs: add a "for_each_replace_ref" function

Nobody has review comments on this yet.

* lh/submodule-tree-traversal (Sun Jan 25 01:52:06 2009 +0100) 6 commits
 - archive.c: add support for --submodules[=(all|checkedout)]
 - tree.c: allow read_tree_recursive() to traverse gitlink entries
 + Revert round #1 of the series
 + builtin-ls-tree: enable traversal of submodules
 + archive.c: enable traversal of submodules
 + tree.c: add support for traversal of submodules

----------------------------------------------------------------
[Reverted]

* mh/unify-color (Fri Jan 23 01:25:23 2009 -0800) 3 commits
 ? Revert previous two commits
 ? move the color variables to color.c
 ? handle color.ui at a central place

This broke git-format-patch badly.

----------------------------------------------------------------
[Actively cooking]

* js/valgrind (Wed Jan 21 02:36:40 2009 +0100) 2 commits
 - valgrind: ignore ldso errors
 - Add valgrind support in test scripts

Dscho and Peff had further exchanges on the list; I am sort of waiting for
the conclusion before picking any intermediate version up.

* ks/maint-mailinfo-folded (Tue Jan 13 01:21:04 2009 +0300) 4 commits
 + mailinfo: tests for RFC2047 examples
 + mailinfo: add explicit test for mails like '<a.u.thor@example.com>
   (A U Thor)'
 + mailinfo: 'From:' header should be unfold as well
 + mailinfo: correctly handle multiline 'Subject:' header

I just got tired of waiting and cleaned up the series myself.

* js/notes (Tue Jan 13 20:57:16 2009 +0100) 6 commits
 + git-notes: fix printing of multi-line notes
 + notes: fix core.notesRef documentation
 + Add an expensive test for git-notes
 + Speed up git notes lookup
 + Add a script to edit/inspect notes
 + Introduce commit notes

It would be nice to hear a real world success story using the notes
mechanism; Dscho says he also wants to make sure the current choice
of the structure scales well before casting it in stone.

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Split git_project_list_body in two functions
 - gitweb: Modularized git_get_project_description to be more generic

Design discussion between Jakub and Sebastien continues.

----------------------------------------------------------------
[Graduated to "master"]

* sr/clone-empty (Fri Jan 23 01:07:32 2009 +0100) 1 commit
 + Allow cloning an empty repository

Has anybody actually tried this and made sure the resulting empty clone
works fine after the clone source gets updated with some contents?

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

* cb/add-pathspec (Wed Jan 14 15:54:35 2009 +0100) 2 commits
 + remove pathspec_match, use match_pathspec instead
 + clean up pathspec matching

* js/diff-color-words (Tue Jan 20 22:59:54 2009 -0600) 9 commits
 + Change the spelling of "wordregex".
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

----------------------------------------------------------------
[Will merge to "master" soon]

* jg/mergetool (Sat Jan 24 00:12:45 2009 +0100) 1 commit
 + mergetool: Don't repeat merge tool candidates

* cb/mergetool (Wed Jan 21 22:57:48 2009 +0000) 1 commit
 + mergetool: respect autocrlf by using checkout-index

Now Ted told us not to wait for him, we'll go ahead by ourselves ;-).

* jk/signal-cleanup (Thu Jan 22 01:03:28 2009 -0500) 5 commits
 + pager: do wait_for_pager on signal death
 + refactor signal handling for cleanup functions
 + chain kill signals for cleanup functions
 + diff: refactor tempfile cleanup handling
 + Windows: Fix signal numbers

* sp/runtime-prefix (Sun Jan 18 13:00:15 2009 +0100) 7 commits
 + Windows: Revert to default paths and convert them by
   RUNTIME_PREFIX
 + Compute prefix at runtime if RUNTIME_PREFIX is set
 + Modify setup_path() to only add git_exec_path() to PATH
 + Add calls to git_extract_argv0_path() in programs that call
   git_config_*
 + git_extract_argv0_path(): Move check for valid argv0 from caller
   to callee
 + Refactor git_set_argv0_path() to git_extract_argv0_path()
 + Move computation of absolute paths from Makefile to runtime (in
   preparation for RUNTIME_PREFIX)

----------------------------------------------------------------
[On Hold]

* jc/commit-assume-also-during-merge (Thu Jan 22 22:21:49 2009 -0800) 3 commits
 - git commit: pathspec without -i/-o implies -i semantics during a
   merge
 - builtin-commit: shorten eye-sore overlong lines
 - Add "partial commit" tests during a conflicted merge

This is only meant as a weatherballoon to help facilitate discussion.

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

* jk/valgrind (Thu Oct 23 04:30:45 2008 +0000) 2 commits
 . valgrind: ignore ldso errors
 . add valgrind support in test scripts

* wp/add-patch-find (Thu Nov 27 04:08:03 2008 +0000) 3 commits
 . In add --patch, Handle K,k,J,j slightly more gracefully.
 . Add / command in add --patch
 . git-add -i/-p: Change prompt separater from slash to comma
