From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2009, #03; Wed, 14)
Date: Wed, 14 Jan 2009 03:32:32 -0800
Message-ID: <7vmydu3yy7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 12:34:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN40b-00080m-Gk
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 12:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087AbZANLcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 06:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754934AbZANLcl
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 06:32:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbZANLcj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 06:32:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BC0D01C6E6;
	Wed, 14 Jan 2009 06:32:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 64BB51C680; Wed,
 14 Jan 2009 06:32:33 -0500 (EST)
X-master-at: 3cf3b838c7b379824c68ee87799aaaa9028b36cd
X-next-at: 5b4a894b226c0bf6c51c888eeb06524eeb201ab9
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0B0ACE4E-E22F-11DD-9EE4-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105617>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The ones marked with '.' do not appear in any of
the branches, but I am still holding onto them.

The topics list the commits in reverse chronological order.  The
topics meant to be merged to the maintenance series have "maint-"
in their names.

----------------------------------------------------------------
[New Topics]

* kb/am-directory (Sun Jan 11 22:21:48 2009 -0800) 1 commit
 + git-am: add --directory=<dir> option

This is "third-time-lucky, perhaps?" resurrection.  I do not think I'd be
using this very often, but it originated from a real user request.

* jk/signal-cleanup (Sun Jan 11 06:36:49 2009 -0500) 3 commits
 - pager: do wait_for_pager on signal death
 - refactor signal handling for cleanup functions
 - chain kill signals for cleanup functions

* kb/lstat-cache (Tue Jan 13 13:29:08 2009 +0100) 5 commits
 - lstat_cache(): introduce clear_lstat_cache() function
 - lstat_cache(): introduce invalidate_lstat_cache() function
 - lstat_cache(): introduce has_dirs_only_path() function
 - lstat_cache(): introduce has_symlink_or_noent_leading_path()
   function
 - lstat_cache(): more cache effective symlink/directory detection

This is the seventh round; although the author asked me not to bother, I
couldn't resist.  I renamed one helper function while reading the patches
and made minor adjustments on styles, but it looked reasonable.

* lh/submodule-tree-traversal (Mon Jan 12 00:45:55 2009 +0100) 3 commits
 - builtin-ls-tree: enable traversal of submodules
 - archive.c: enable traversal of submodules
 - tree.c: add support for traversal of submodules

* jc/maint-format-patch-o-relative (Mon Jan 12 15:18:02 2009 -0800) 1 commit
 - Teach format-patch to handle output directory relative to cwd

This was my lunchtime "this may fix it" response to a breakage report.  I
haven't really thought things through but my gut feeling is this might
break things for minorities who are accustomed to the existing behaviour,
especially wrt the filenames reported on the standard output.

* lt/maint-wrap-zlib (Wed Jan 7 19:54:47 2009 -0800) 1 commit
 + Wrap inflate and other zlib routines for better error reporting

Needs the "free our memory upon seeing Z_MEM_ERROR and try again" bits
extracted from Shawn's patch on top of this one.

* js/diff-color-words (Sun Jan 11 21:00:58 2009 +0100) 4 commits
 - color-words: take an optional regular expression describing words
 - color-words: refactor to allow for 0-character word boundaries
 - color-words: refactor word splitting and use ALLOC_GROW()
 - Add color_fwrite(), a function coloring each line individually

Dscho's series that was done in response to Thomas's original; two agreed
to work together on this codebase.

* db/foreign-scm (Sun Jan 11 15:12:10 2009 -0500) 3 commits
 - Support fetching from foreign VCSes
 - Add specification of git-vcs helpers
 - Add "vcs" config option in remotes

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* ds/uintmax-config (Mon Nov 3 09:14:28 2008 -0900) 1 commit
 . autoconf: Enable threaded delta search when pthreads are supported

I haven't heard neither positive nor negative comments from minority
platforms that might be harmed, but this feels like the right thing to do,
so perhaps the best course of action is to merge this down to 'master' and
see if anybody screams.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

This gives Porcelains (like gitweb) the information on the commit _before_
the one that the final blame is laid on, which should save them one
rev-parse to dig further.  The line number in the "previous" information
may need refining, and sanity checking code for reference counting may
need to be resurrected before this can move forward.

----------------------------------------------------------------
[Actively cooking]

* gb/gitweb-opml (Fri Jan 2 13:49:30 2009 +0100) 2 commits
 + gitweb: suggest name for OPML view
 + gitweb: don't use pathinfo for global actions

* ks/maint-mailinfo-folded (Mon Jan 12 15:22:11 2009 -0800) 2 commits
 - mailinfo: 'From:' header should be unfold as well
 - mailinfo: correctly handle multiline 'Subject:' header

The author seems to have more updates, but I couldn't extract them from
the e-mail.

* js/patience-diff (Thu Jan 1 17:39:37 2009 +0100) 3 commits
 + bash completions: Add the --patience option
 + Introduce the diff option '--patience'
 + Implement the patience diff algorithm

* mv/apply-parse-opt (Fri Jan 9 22:21:36 2009 -0800) 2 commits
 + Resurrect "git apply --flags -" to read from the standard input
 + parse-opt: migrate builtin-apply.

* tr/rebase-root (Fri Jan 2 23:28:29 2009 +0100) 4 commits
 + rebase: update documentation for --root
 + rebase -i: learn to rebase root commit
 + rebase: learn to rebase root commit
 + rebase -i: execute hook only after argument checking

Looked reasonable.

* js/notes (Tue Jan 13 20:57:16 2009 +0100) 6 commits
 + git-notes: fix printing of multi-line notes
 + notes: fix core.notesRef documentation
 + Add an expensive test for git-notes
 + Speed up git notes lookup
 + Add a script to edit/inspect notes
 + Introduce commit notes

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Split git_project_list_body in two functions
 - gitweb: Modularized git_get_project_description to be more generic

----------------------------------------------------------------
[Graduated to "master"]

* nd/grep-assume-unchanged (Sat Dec 27 15:21:03 2008 +0700) 2 commits
 + grep: grep cache entries if they are "assume unchanged"
 + grep: support --no-ext-grep to test builtin grep

* as/maint-shortlog-cleanup (Tue Dec 30 22:01:44 2008 +0100) 1 commit
 + builtin-shortlog.c: use string_list_append(), and don't strdup
   unnecessarily

* jc/maint-ls-tree (Wed Dec 31 19:00:50 2008 +0900) 2 commits
 + Document git-ls-tree --full-tree
 + ls-tree: add --full-tree option

* js/bundle-tags (Fri Jan 2 19:08:46 2009 +0100) 1 commit
 + bundle: allow rev-list options to exclude annotated tags

* js/add-not-submodule (Fri Jan 2 19:08:40 2009 +0100) 1 commit
 + git add: do not add files from a submodule

* pb/maint-git-pm-false-dir (Mon Dec 29 01:25:00 2008 +0100) 1 commit
 + Git.pm: correctly handle directory name that evaluates to "false"

* pj/maint-ldflags (Sun Jan 4 21:27:41 2009 -0500) 1 commit
 + configure clobbers LDFLAGS

* fe/cvsserver (Fri Jan 2 16:40:14 2009 +0100) 2 commits
 + cvsserver: change generation of CVS author names
 + cvsserver: add option to configure commit message

* js/maint-bisect-gitk (Fri Jan 2 19:08:00 2009 +0100) 1 commit
 + bisect view: call gitk if Cygwin's SESSIONNAME variable is set

* np/no-loosen-prune-expire-now (Tue Dec 30 14:45:11 2008 -0500) 1 commit
 + objects to be pruned immediately don't have to be loosened

* cb/maint-unpack-trees-absense (Thu Jan 1 21:54:33 2009 +0100) 3 commits
 + unpack-trees: remove redundant path search in verify_absent
 + unpack-trees: fix path search bug in verify_absent
 + unpack-trees: handle failure in verify_absent

* mc/cd-p-pwd (Tue Dec 30 07:10:24 2008 -0800) 1 commit
 + git-sh-setup: Fix scripts whose PWD is a symlink to a work-dir on
   OS X

* mh/cherry-default (Thu Jan 1 22:56:29 2009 +0100) 2 commits
 + Documentation: clarify which parameters are optional to git-cherry
 + git-cherry: make <upstream> parameter optional

Some of the above will still need to be downmerged to respective
maintenance branches after they are widely used on 'master'.

----------------------------------------------------------------
[Will merge to "master" soon]

* mh/maint-commit-color-status (Thu Jan 8 19:53:05 2009 +0100) 2 commits
 + git-status -v: color diff output when color.ui is set
 + git-commit: color status output when color.ui is set

* rs/maint-shortlog-foldline (Tue Jan 6 21:41:06 2009 +0100) 1 commit
 + shortlog: handle multi-line subjects like log --pretty=oneline et.
   al. do

* rs/fgrep (Sat Jan 10 00:18:34 2009 +0100) 2 commits
 + grep: don't call regexec() for fixed strings
 + grep -w: forward to next possible position after rejected match

* as/autocorrect-alias (Sun Jan 4 18:16:01 2009 +0100) 1 commit
 + git.c: make autocorrected aliases work

* tr/maint-no-index-fixes (Wed Jan 7 12:15:30 2009 +0100) 3 commits
 + diff --no-index -q: fix endless loop
 + diff --no-index: test for pager after option parsing
 + diff: accept -- when using --no-index

* jc/maint-format-patch (Sat Jan 10 12:41:33 2009 -0800) 1 commit
 + format-patch: show patch text for the root commit

* ap/clone-into-empty (Sun Jan 11 15:19:12 2009 +0300) 2 commits
 + Allow cloning to an existing empty directory
 + add is_dot_or_dotdot inline function

* gb/gitweb-patch (Thu Dec 18 08:13:19 2008 +0100) 4 commits
 + gitweb: link to patch(es) view in commit(diff) and (short)log view
 + gitweb: add patches view
 + gitweb: change call pattern for git_commitdiff
 + gitweb: add patch view

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
