From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2009, #02; Wed, 04)
Date: Wed, 04 Feb 2009 17:32:37 -0800
Message-ID: <7vr62dk6ru.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 02:34:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUt8U-0000cL-Dz
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 02:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696AbZBEBcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 20:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756822AbZBEBcr
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 20:32:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330AbZBEBcp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 20:32:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B59796C67;
	Wed,  4 Feb 2009 20:32:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7033E96C66; Wed,
  4 Feb 2009 20:32:40 -0500 (EST)
X-master-at: 88ccb9f9745ff1f44bff7c6d6c17ad4b46870706
X-next-at: c5d3fa64fe3170d80a48f5c5b99f14dbabcbd9b4
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E2C9C51E-F324-11DD-A958-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108490>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

I was this close (shows thumb and index finger almost touching) to merge
js/notes to master and declare 1.6.2-rc0 but decided against it, because I
thought I need to at least have heard about somebody who used it before
doing so.  Perhaps I'll try it out myself to keep track of commits that
happened between 1.6.1 and master that need to be cherry-picked to maint,
or something silly like that.  In any case, my prediction is that -rc0
would look like what 'next' tonight looks like, nothing more, not much
less (I'd probably drop jc/blame).

----------------------------------------------------------------
[New Topics]

* jc/refuse-push-to-current-1.7.0 (Sat Jan 31 17:34:05 2009 -0800) 1 commit
 - Refuse updating the current branch in a non-bare repository via
   push

This is for 1.7.0.

* js/maint-remote-remove-mirror (Wed Feb 4 11:06:07 2009 -0500) 2 commits
 + builtin-remote: make rm operation safer in mirrored repository
 + builtin-remote: make rm() use properly named variable to hold
   return value

* ek/maint-filter-branch-bare (Tue Feb 3 13:27:03 2009 -0500) 1 commit
 + filter-branch: Fix fatal error on bare repositories

* tr/add-p-single (Wed Feb 4 21:12:39 2009 +0100) 2 commits
 - add -p: print errors in separate color
 - add -p: prompt for single characters

Will move to 'next'; it may or may not mature in time for 1.6.2.

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* jc/merge-convert (Mon Jan 26 16:45:01 2009 -0800) 1 commit
 - git-merge-file: allow converting the results for the work tree

This is a feature waiting for a user.  I do not need it in 1.6.2

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

* cc/replace (Mon Feb 2 06:13:06 2009 +0100) 11 commits
 - builtin-replace: use "usage_msg_opt" to give better error messages
 - parse-options: add new function "usage_msg_opt"
 - builtin-replace: teach "git replace" to actually replace
 - Add new "git replace" command
 - environment: add global variable to disable replacement
 - mktag: call "check_sha1_signature" with the replacement sha1
 - replace_object: add a test case
 - object: call "check_sha1_signature" with the replacement sha1
 - sha1_file: add a "read_sha1_file_repl" function
 - replace_object: add mechanism to replace objects found in
   "refs/replace/"
 - refs: add a "for_each_replace_ref" function

I think the code is much cleaner than the first round, but I am not
convinced it is doing the right thing in the connectivity traverser.  
I'd like to keep this out of 1.6.2.

* lh/submodule-tree-traversal (Sun Jan 25 01:52:06 2009 +0100) 6 commits
 - archive.c: add support for --submodules[=(all|checkedout)]
 - tree.c: allow read_tree_recursive() to traverse gitlink entries
 + Revert round #1 of the series
 + builtin-ls-tree: enable traversal of submodules
 + archive.c: enable traversal of submodules
 + tree.c: add support for traversal of submodules

Sorry, but what's the status of this one?  I am not particularly
interested in this new feature myself, so unless I hear otherwise from
people, I'd like to keep this out of 1.6.2.  That would have the added
benefit of being able to discard the first four that is already in 'next'
to get a fresh start post 1.6.2 ;-)

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Split git_project_list_body in two functions
 - gitweb: Modularized git_get_project_description to be more generic

Design discussion between Jakub and Sebastien seems to have stalled.

----------------------------------------------------------------
[Reverted]

* mh/unify-color (Fri Jan 23 01:25:23 2009 -0800) 3 commits
 ? Revert previous two commits
 ? move the color variables to color.c
 ? handle color.ui at a central place

This broke git-format-patch badly.

----------------------------------------------------------------
[Actively cooking]

* jc/fsck (Fri Jan 30 02:44:13 2009 -0800) 5 commits
 - fsck: revert --quick to the default and introduce --medium
 - fsck: three levels of validation
 - verify-pack: add --quick
 - verify_pack(): allow a quicker verification for a pack with
   version 2 idx
 - pack-check.c: minor formatting fix to match coding style

I haven't heard anything positive nor negative about this series.  I think
the tip two commits should be squashed (and perhaps the option parser
cleaned up as suggested on the list).

* kb/checkout-optim (Wed Feb 4 13:53:20 2009 +0100) 8 commits
 - lstat_cache(): print a warning if doing ping-pong between cache
   types
 - show_patch_diff(): remove a call to fstat()
 - write_entry(): cleanup of some duplicated code
 - create_directories(): remove some memcpy() and strchr() calls
 - unlink_entry(): introduce schedule_dir_for_removal()
 - lstat_cache(): swap func(length, string) into func(string, length)
 - lstat_cache(): generalise longest_match_lstat_cache()
 - lstat_cache(): small cleanup and optimisation

Should be in 'next' soon.

* js/valgrind (Wed Feb 4 00:26:31 2009 +0100) 8 commits
 - test-lib: avoid assuming that templates/ are in the GIT_EXEC_PATH
 - Tests: let --valgrind imply --verbose and --tee
 - Add a script to coalesce the valgrind outputs
 - t/Makefile: provide a 'valgrind' target
 - test-lib.sh: optionally output to test-results/$TEST.out, too
 - Valgrind support: check for more than just programming errors
 - valgrind: ignore ldso and more libz errors
 - Add valgrind support in test scripts

Should be in 'next' soon.

* js/notes (Tue Jan 13 20:57:16 2009 +0100) 6 commits
 + git-notes: fix printing of multi-line notes
 + notes: fix core.notesRef documentation
 + Add an expensive test for git-notes
 + Speed up git notes lookup
 + Add a script to edit/inspect notes
 + Introduce commit notes

It would be nice to hear a real world success story using the notes
mechanism; Dscho says he also wants to make sure the current choice
of the structure scales well before casting it in stone, but nothing
has happened since then.

----------------------------------------------------------------
[Graduated to "master"]

* wp/add-patch-find (Thu Nov 27 04:08:03 2008 +0000) 3 commits
 + In add --patch, Handle K,k,J,j slightly more gracefully.
 + Add / command in add --patch
 + git-add -i/-p: Change prompt separater from slash to comma

* jc/maint-add-u-remove-conflicted (Wed Jan 28 14:24:53 2009 -0800) 1 commit
 + add -u: do not fail to resolve a path as deleted

* jk/maint-cleanup-after-exec-failure (Wed Jan 28 02:38:14 2009 -0500) 4 commits
 + git: use run_command() to execute dashed externals
 + run_command(): help callers distinguish errors
 + run_command(): handle missing command errors more gracefully
 + git: s/run_command/run_builtin/

* ns/am-slacker (Sat Jan 24 10:18:02 2009 +0900) 2 commits
 + git-am: Add --ignore-date option
 + am: Add --committer-date-is-author-date option

----------------------------------------------------------------
[Will merge to "master" soon]

* gt/utf8-width (Fri Jan 30 04:41:29 2009 -0500) 2 commits
 + builtin-blame.c: Use utf8_strwidth for author's names
 + utf8: add utf8_strwidth()

I replaced the bottom one with a cheesy "if it does not look like
utf8, give strlen back" to make the result behave sensibly for legacy
encodings.  It does improve "git blame git-stash.sh" output (especially
if you remove .mailmap).

* jk/head-symref (Thu Jan 29 03:33:02 2009 -0500) 2 commits
 + symbolic ref: refuse non-ref targets in HEAD
 + validate_headref: tighten ref-matching to just branches

Looked fine for 1.6.2.

* rc/http-push (Tue Feb 3 20:39:00 2009 +0800) 4 commits
 + http-push: wrap signature of get_remote_object_url
 + http-push: add back underscore separator before lock token
 + http-push.c: get_remote_object_url() is only used under
   USE_CURL_MULTI
 + http-push: refactor request url creation

As these are supposed to be only clean-ups without any functionality
change, let's flush it out before 1.6.2.

* jc/refuse-push-to-current (Sat Jan 31 17:34:05 2009 -0800) 1 commit
 + receive-pack: explain what to do when push updates the current
   branch

This prepares to finally switch the default for receive.denyCurrentBranch
to "refuse".  The idea is to issue a big warning to people who push into
currently checked out branch when the configuration is unset and we
default to "warn", and explain in detail (1) why it is not likely to be
what they want to do (to help new people), (2) if it is what they want,
how to squelch that annoyingly long message, and (3) the default will be
changed to "refuse" in a future release of git.

* cb/mergetool (Fri Jan 30 23:20:11 2009 +0000) 3 commits
 + mergetool: fix running mergetool in sub-directories
 + mergetool: Add a test for running mergetool in a sub-directory
 + mergetool: respect autocrlf by using checkout-index

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
