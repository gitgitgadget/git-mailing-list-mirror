From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2009, #02; Sun, 11)
Date: Sun, 11 Oct 2009 20:18:17 -0700
Message-ID: <7vfx9pmhae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 05:22:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxBUB-0001Sz-1C
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 05:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbZJLDTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 23:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753472AbZJLDTa
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 23:19:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbZJLDT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 23:19:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D45155214;
	Sun, 11 Oct 2009 23:18:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=ofZW
	AaA7P9WmUy4zOBZ6LTUrt58=; b=NNafCDz4ygQVJoOb9M2nFH1pfO6+g5/9X2pA
	Ph9P4eV5mn1psH25Zm6YfibdWhiBnfeMgWPdvowzvhRjPYL/Rikiu0GenlcQfIgE
	/WF5KULntAOc/uklignQ5nB3Va0MpIjWzpURmil5Vta1QiyTy9qjA1N4fbAEYHCk
	O/2u/F0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=LSQ
	VU7Y72N3/w424/oW5U0lmrtsiJfgDhYE27qeGySxVDx+/OVPCW1nqEgqC3NGMfSd
	SL3jiH6dFNKFusjVbRjWpv4jDOfQY0Jb4b62uazmpBMvywlFhjRDDKLgZYjxmVUh
	JP17hffs9FbvU5FWSwEnh6dn8nw0JTlPK+PCYC6w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EF97755213;
	Sun, 11 Oct 2009 23:18:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB3A355211; Sun, 11 Oct
 2009 23:18:18 -0400 (EDT)
X-master-at: 78d553b7d7b269bb22ebd8b1198657c37484a3a0
X-next-at: 0ff2e96835a8890f86b5b69d8967d350fe89e9e8
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E4C05C0C-B6DD-11DE-932E-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129972>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

In 1.7.0, we plan to correct handful of warts in the interfaces everybody
agrees that they were mistakes.  The resulting system may not be strictly
backward compatible.  Currently planeed changes are:

 * refuse push to update the checked out branch in a non-bare repo by
   default

   Make "git push" into a repository to update the branch that is checked
   out fail by default.  You can countermand this default by setting a
   configuration variable in the receiving repository.

   http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007

 * refuse push to delete the current branch by default

   Make "git push $there :$killed" to delete the branch that is pointed at
   by its HEAD fail by default.  You can countermand this default by
   setting a configuration variable in the receiving repository.

   http://thread.gmane.org/gmane.comp.version-control.git/108862/focus=108936

 * git-send-email won't make deep threads by default

   Many people said that by default when sending more than 2 patches the
   threading git-send-email makes by default is hard to read, and they
   prefer the default be one cover letter and each patch as a direct
   follow-up to the cover letter.  You can countermand this by setting a
   configuration variable.

   http://article.gmane.org/gmane.comp.version-control.git/109790

 * git-status won't be "git-commit --dry-run" anymore

   http://thread.gmane.org/gmane.comp.version-control.git/125989/focus=125993

 * "git-diff -w --exit-code" will exit success if only differences it
   found are whitespace changes that are stripped away from the output.

   http://thread.gmane.org/gmane.comp.version-control.git/119731/focus=119751

As a post-release ritual, I've rebuilt 'next' on top of 'master'.

--------------------------------------------------
[Graduated to "master"]

* ch/am-header (2009-09-25) 2 commits
  (merged to 'next' on 2009-09-25 at f86e197)
 + git-am: force egrep to use correct characters set
 + git-am: fixed patch_format detection according to RFC2822

* ef/msvc-noreturn (2009-09-30) 2 commits
  (merged to 'next' on 2009-10-07 at 66137a0)
 + add NORETURN_PTR for function pointers
 + increase portability of NORETURN declarations

jk: This is the latest round and I think should be ready for at least
'next' (maybe even 'master' as it is really about the build and not about
functionality).

* fc/mutt-alias (2009-09-30) 1 commit
  (merged to 'next' on 2009-10-07 at df7ac20)
 + send-email: fix mutt regex for grouped aliases

jk: Latest round that addressed comments. Ready for 'next' if not
'master'.

* jk/reflog-date (2009-09-24) 1 commit
  (merged to 'next' on 2009-09-29 at 43d444a)
 + improve reflog date/number heuristic

--------------------------------------------------
[New Topics]

* jp/maint-send-email-fold (2009-10-08) 1 commit.
 - git-send-email.perl: fold multiple entry "Cc:" and multiple single line "RCPT TO:"s

* ks/precompute-completion (2009-10-05) 1 commit.
 - Speedup bash completion loading

* pv/maint-add-p-no-exclude (2009-10-10) 1 commit.
  (merged to 'next' on 2009-10-11 at 0ff2e96)
 + git-add--interactive: never skip files included in index

* sp/smart-http (2009-10-08) 4 commits.
 - Smart fetch and push over HTTP: server side
 - Add smart-http options to upload-pack, receive-pack
 - Git-aware CGI to provide dumb HTTP transport
 - Document the HTTP transport protocol

--------------------------------------------------
[Stalled]

* sr/gfi-options (2009-09-06) 6 commits.
 - fast-import: test the new option command
 - fast-import: add option command
 - fast-import: test the new feature command
 - fast-import: add feature command
 - fast-import: put marks reading in it's own function
 - fast-import: put option parsing code in separate functions

Ejected from 'next' as fast-import folks still seem to be discussing with
how to proceed.

* je/send-email-no-subject (2009-08-05) 1 commit.
  (merged to 'next' on 2009-10-11 at 1b99c56)
 + send-email: confirm on empty mail subjects

The existing tests cover the positive case (i.e. as long as the user says
"yes" to the "do you really want to send this message that lacks subject",
the message is sent) of this feature, but the feature itself needs its own
test to verify the negative case (i.e. does it correctly stop if the user
says "no"?)

* jh/cvs-helper (2009-08-18) 8 commits.
 - More fixes to the git-remote-cvs installation procedure
 - Fix the Makefile-generated path to the git_remote_cvs package in git-remote-cvs
 - Add simple selftests of git-remote-cvs functionality
 - git-remote-cvs: Remote helper program for CVS repositories
 - 2/2: Add Python support library for CVS remote helper
 - 1/2: Add Python support library for CVS remote helper
 - Basic build infrastructure for Python scripts
 - Allow helpers to request marks for fast-import
 (this branch uses db/vcs-helper-rest.)

Builds on db/vcs-helper.  There is a re-roll planned.

* ne/rev-cache (2009-09-07) 7 commits.
 . support for commit grafts, slight change to general mechanism
 . support for path name caching in rev-cache
 . full integration of rev-cache into git, completed test suite
 . administrative functions for rev-cache, start of integration into git
 . support for non-commit object caching in rev-cache
 . basic revision cache system, no integration or features
 . man page and technical discussion for rev-cache

This seems to break at least t6001 when merged to 'pu'.

--------------------------------------------------
[Cooking]

* dk/blame-el (2009-09-29) 1 commit.
 - git-blame.el: Change how blame information is shown.

Soon in 'next'.

* ef/msys-imap (2009-10-09) 8 commits.
 - MSVC: Enable OpenSSL, and translate -lcrypto
 - mingw: enable OpenSSL
 - mingw: wrap SSL_set_(w|r)fd to call _get_osfhandle
 - imap-send: build imap-send on Windows
 - imap-send: fix compilation-error on Windows
 - imap-send: use run-command API for tunneling
 - imap-send: use separate read and write fds
 - imap-send: remove useless uid code

* jn/gitweb-patch (2009-10-09) 1 commit.
 - gitweb: Do not show 'patch' link for merge commits

Soon in 'next'

* mr/gitweb-snapshot (2009-09-26) 2 commits.
 - gitweb: append short hash ids to snapshot files
  (merged to 'next' on 2009-10-11 at 22ba047)
 + gitweb: check given hash before trying to create snapshot

* mr/instaweb-cgid (2009-09-26) 1 commit.
  (merged to 'next' on 2009-10-11 at 99bcfaf)
 + instaweb: support mod_cgid for apache2

* tf/doc-pt-br (2009-09-23) 1 commit.
 - Documentation: update pt-BR

The current AsciiDoc may barf on NOME and SINOPSE, as pt_BR language
definition is not widely distributed yet (it just hit the development
tree).  Need to revert these headings (or change the length of the section
underlines to match the length of translated names).

* jc/pretty-lf (2009-10-04) 1 commit.
 - Pretty-format: %[+-]x to tweak inter-item newlines

I am not happy with this one yet.  I am contemplating to introduce a new
syntax "%[magic(param)<anything>%]" to generalize expressions of this and
line wrapping features in an extensible way.

* js/log-rewrap (2008-11-10) 3 commits.
 . Add "%w" to pretty formats, which rewraps the commit message
 - Add strbuf_add_wrapped_text() to utf8.[ch]
 - print_wrapped_text(): allow hard newlines
... and the first two from this series will be useful to implement an
example magic "wrap", e.g. "%[wrap(i,j,w)%s%+b%]".

* jg/log-format-body-indent (2009-09-19) 1 commit.
 - git-log --format: Add %B tag with %B(x) option

I think we should redo this on top of the first two patches from
js/log-rewrap series; %B(x) is just a special case %B(x,x,0), no?  If a
magic value 0 (or negative) given to wrap-width does not disable wrapping,
we probably should make it so.

* bg/rebase-reword (2009-10-07) 1 commit.
 - Teach 'rebase -i' the command "reword"

Soon in 'next'

* js/diff-verbose-submodule (2009-10-04) 1 commit.
 - Add the --submodule-summary option to the diff option family

Dscho sounded like he has some corrections after list comments, but I did
not pick up his interdiff in the middle.

* jl/submodule-add-noname (2009-09-22) 1 commit.
 - git submodule add: make the <path> parameter optional

Dscho started an interesting discussion regarding the larger workflow in
which the "submodule add" is used.  I think the patch itself makes sense
but at the same time it probably makes sense to also take the <path> and
infer the <repository> as Dscho suggested, probably in "git submodule
add", not in "git add" proper, at least initially.

* jc/fix-tree-walk (2009-09-14) 10 commits.
 - read-tree --debug-unpack
 - unpack-trees.c: look ahead in the index
 - unpack-trees.c: prepare for looking ahead in the index
 - Aggressive three-way merge: fix D/F case
 - traverse_trees(): handle D/F conflict case sanely
 - more D/F conflict tests
 - tests: move convenience regexp to match object names to test-lib.sh
 - unpack_callback(): use unpack_failed() consistently
 - unpack-trees: typofix
 - diff-lib.c: fix misleading comments on oneway_diff()

This is my replacement for Linus's lt/maint-traverse-trees-fix patch.  It
is not so much as a counter-proposal; I originally thought it might make
sense to walk the index and drive the walker to return the entries from
trees to match entries from the index, but I ended up doing pretty much
what Linus outlined --- walk the trees, and have the index walker follow
it.  It turned out that the index side also needed some hairy look-ahead,

This includes the fix to aggressive mode of three-way merge used by the
resolve strategy.  I think the series is Ok for 'next'.

* jp/fetch-tag-match (2009-09-17) 1 commit.
 - fetch: Speed up fetch by rewriting find_non_local_tags

I just queued this without reading nor thinking about it very much.  I
personally liked my version that had far smaller number of lines changed
(which means I can be fairly certain that it did not introduce any
regression), but perhaps the majorly rewritten logic this patch gives us
may be easier to follow and maintain.

* jc/maint-blank-at-eof (2009-09-15) 0 commits.
 (this branch uses jc/maint-1.6.0-blank-at-eof.)

The series does not have a commit of its own but is a preparation for
merging the original jc/1.6.0-maint-blank-at-eof topic to 'maint' and then
'master'

Soon in 'next'

* db/vcs-helper-rest (2009-09-03) 6 commits.
 - Allow helpers to report in "list" command that the ref is unchanged
 - Add support for "import" helper command
 - Add a config option for remotes to specify a foreign vcs
 - Allow programs to not depend on remotes having urls
 - Allow fetch to modify refs
 - Use a function to determine whether a remote is valid
 (this branch is used by jh/cvs-helper.)

This holds the remainder of the db/vcs-helper topic that has already
merged in 1.6.5.

* jh/notes (2009-10-09) 22 commits.
 - fast-import: Proper notes tree manipulation using the notes API
 - Refactor notes concatenation into a flexible interface for combining notes
 - Notes API: Allow multiple concurrent notes trees with new struct notes_tree
 - Notes API: for_each_note(): Traverse the entire notes tree with a callback
 - Notes API: get_note(): Return the note annotating the given object
 - Notes API: add_note(): Add note objects to the internal notes tree structure
 - Notes API: init_notes(): Initialize the notes tree from the given notes ref
 - Notes API: get_commit_notes() -> format_note() + remove the commit restriction
 - Add selftests verifying concatenation of multiple notes for the same commit
 - Refactor notes code to concatenate multiple notes annotating the same object
 - Add selftests verifying that we can parse notes trees with various fanouts
 - Teach the notes lookup code to parse notes trees with various fanout schemes
 - Teach notes code to free its internal data structures on request
 - Add '%N'-format for pretty-printing commit notes
 - Add flags to get_commit_notes() to control the format of the note string
 - t3302-notes-index-expensive: Speed up create_repo()
 - fast-import: Add support for importing commit notes
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

Rerolled and queued.

* jn/gitweb-show-size (2009-09-07) 1 commit.
 - gitweb: Add 'show-sizes' feature to show blob sizes in tree view

Soon in 'next'

* jc/maint-1.6.0-blank-at-eof (2009-09-14) 15 commits.
  (merged to 'next' on 2009-10-11 at 7f34fb3)
 + diff -B: colour whitespace errors
 + diff.c: emit_add_line() takes only the rest of the line
 + diff.c: split emit_line() from the first char and the rest of the line
 + diff.c: shuffling code around
 + diff --whitespace: fix blank lines at end
 + core.whitespace: split trailing-space into blank-at-{eol,eof}
 + diff --color: color blank-at-eof
 + diff --whitespace=warn/error: fix blank-at-eof check
 + diff --whitespace=warn/error: obey blank-at-eof
 + diff.c: the builtin_diff() deals with only two-file comparison
 + apply --whitespace: warn blank but not necessarily empty lines at EOF
 + apply --whitespace=warn/error: diagnose blank at EOF
 + apply.c: split check_whitespace() into two
 + apply --whitespace=fix: detect new blank lines at eof correctly
 + apply --whitespace=fix: fix handling of blank lines at the eof
 (this branch is used by jc/maint-blank-at-eof.)

This is a fix for an ancient bug (or inconsistent set of features); the
topic is based on an ancient codebase and is designed to be merged
upwards.  jc/maint-blank-at-eof serves that purpose.

* jn/gitweb-blame (2009-09-01) 5 commits.
 - gitweb: Minify gitweb.js if JSMIN is defined
 - gitweb: Create links leading to 'blame_incremental' using JavaScript
  (merged to 'next' on 2009-10-11 at 73c4a83)
 + gitweb: Colorize 'blame_incremental' view during processing
 + gitweb: Incremental blame (using JavaScript)
 + gitweb: Add optional "time to generate page" info in footer

Ajax-y blame.

* nd/sparse (2009-08-20) 19 commits.
 - sparse checkout: inhibit empty worktree
 - Add tests for sparse checkout
 - read-tree: add --no-sparse-checkout to disable sparse checkout support
 - unpack-trees(): ignore worktree check outside checkout area
 - unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final index
 - unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/sparse-checkout
 - unpack-trees.c: generalize verify_* functions
 - unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
 - Introduce "sparse checkout"
 - dir.c: export excluded_1() and add_excludes_from_file_1()
 - excluded_1(): support exclude files in index
 - unpack-trees(): carry skip-worktree bit over in merged_entry()
 - Read .gitignore from index if it is skip-worktree
 - Avoid writing to buffer in add_excludes_from_file_1()
 - Teach Git to respect skip-worktree bit (writing part)
 - Teach Git to respect skip-worktree bit (reading part)
 - Introduce "skip-worktree" bit in index, teach Git to get/set this bit
 - Add test-index-version
 - update-index: refactor mark_valid() in preparation for new options

--------------------------------------------------
[For 1.7.0]

* jk/1.7.0-status (2009-09-05) 5 commits.
 - docs: note that status configuration affects only long format
  (merged to 'next' on 2009-10-11 at 65c8513)
 + commit: support alternate status formats
 + status: add --porcelain output format
 + status: refactor format option parsing
 + status: refactor short-mode printing to its own function
 (this branch uses jc/1.7.0-status.)

Gives the --short output format to post 1.7.0 "git commit --dry-run" that
is similar to that of post 1.7.0 "git status".

* jc/1.7.0-status (2009-09-05) 4 commits.
  (merged to 'next' on 2009-10-11 at 9558627)
 + status: typo fix in usage
 + git status: not "commit --dry-run" anymore
 + git stat -s: short status output
 + git stat: the beginning of "status that is not a dry-run of commit"
 (this branch is used by jk/1.7.0-status.)

With this, "git status" is no longer "git commit --dry-run".

* jc/1.7.0-send-email-no-thread-default (2009-08-22) 1 commit.
  (merged to 'next' on 2009-10-11 at 043acdf)
 + send-email: make --no-chain-reply-to the default

* jc/1.7.0-diff-whitespace-only-status (2009-08-30) 4 commits.
  (merged to 'next' on 2009-10-11 at 546c74d)
 + diff.c: fix typoes in comments
 + Make test case number unique
 + diff: Rename QUIET internal option to QUICK
 + diff: change semantics of "ignore whitespace" options

This changes exit code from "git diff --ignore-whitespace" and friends
when there is no actual output.  It is a backward incompatible change, but
we could argue that it is a bugfix.

* jc/1.7.0-push-safety (2009-02-09) 2 commits.
  (merged to 'next' on 2009-10-11 at 81b8128)
 + Refuse deleting the current branch via push
 + Refuse updating the current branch in a non-bare repository via push

--------------------------------------------------
[I have been too busy to purge these]

* jc/log-tz (2009-03-03) 1 commit.
 - Allow --date=local --date=other-format to work as expected

Maybe some people care about this.  I dunno.

* jc/mailinfo-remove-brackets (2009-07-15) 1 commit.
 - mailinfo: -b option keeps [bracketed] strings that is not a [PATCH] marker

Maybe some people care about this.  I dunno.

* lt/read-directory (2009-05-15) 3 commits.
 . Add initial support for pathname conversion to UTF-8
 . read_directory(): infrastructure for pathname character set conversion
 . Add 'fill_directory()' helper function for directory traversal

* cc/reset-merge (2009-09-16) 4 commits.
 . reset: add test cases for "--merge-safe" option
 . reset: add option "--merge-safe" to "git reset"
 . reset: use "unpack_trees()" directly instead of "git read-tree"
 . reset: add a few tests for "git reset --merge"

* cc/sequencer-rebase-i (2009-08-28) 15 commits.
 . rebase -i: use "git sequencer--helper --cherry-pick"
 . sequencer: add "--cherry-pick" option to "git sequencer--helper"
 . sequencer: add "do_commit()" and related functions working on "next_commit"
 . pick: libify "pick_help_msg()"
 . revert: libify cherry-pick and revert functionnality
 . rebase -i: use "git sequencer--helper --fast-forward"
 . sequencer: let "git sequencer--helper" callers set "allow_dirty"
 . sequencer: add "--fast-forward" option to "git sequencer--helper"
 . sequencer: add "do_fast_forward()" to perform a fast forward
 . rebase -i: use "git sequencer--helper --reset-hard"
 . sequencer: add "--reset-hard" option to "git sequencer--helper"
 . sequencer: add "reset_almost_hard()" and related functions
 . rebase -i: use "git sequencer--helper --make-patch"
 . sequencer: add "make_patch" function to save a patch
 . sequencer: add "builtin-sequencer--helper.c"

* lt/maint-traverse-trees-fix (2009-09-06) 1 commit.
 . Prepare 'traverse_trees()' for D/F conflict lookahead
