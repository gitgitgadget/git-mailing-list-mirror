From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2009, #05; Wed, 28)
Date: Wed, 28 Oct 2009 14:11:14 -0700
Message-ID: <7vfx93jkb1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 22:11:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Fnv-0008DJ-DR
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 22:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460AbZJ1VLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 17:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754431AbZJ1VLX
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 17:11:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364AbZJ1VLV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 17:11:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 425BC8950D;
	Wed, 28 Oct 2009 17:11:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=MkEz
	DsViXA/FH4OrfKGKmBOLOmA=; b=CaVFtLl9yEqsKs+JNr99M6md748zF9Kc31uX
	EPL0ZujiAFwSkSdHoUwfzc9wMN5MKAKFclEe7Kxi7kBSXAvmz4TkVAlenbvzAmhp
	3Xgq/Boi7heDi8b2hVP1gtVEKZpM3k+1x07svcoPf0f5X5Nu4M0mppzySUIWImmB
	QHjEnwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=cDv
	LgOfD8Rgg6ytIJrPkOSzzQljHnYO5zDoV43wENWPZ2jDlmCCejaGGG80Pcia7KHe
	MsD7lsOy+feCsRbotY9aOLBqp8gF440LxAVbFIPS2DYDNHmZYRCfzcee8JxOclAU
	7cA+6kuWNjh5085kJYLM7/qlfH8gkSRXb0jpGbjM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 315748950C;
	Wed, 28 Oct 2009 17:11:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C56AE89509; Wed, 28 Oct 2009
 17:11:16 -0400 (EDT)
X-master-at: cd0f8e6d63d3e2744d7d3b2329238be7d064a8ea
X-next-at: 66178218961cb7484d46bd48df7da7318180b6b7
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6FC2F406-C406-11DE-B28C-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131497>

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

--------------------------------------------------
[Graduated to "master"]

* jc/fsck-default-full (2009-10-20) 1 commit
 + fsck: default to "git fsck --full"

* jc/maint-fix-unpack-zlib-check (2009-10-21) 1 commit.
 + Fix incorrect error check while reading deflated pack data

* jc/receive-pack-auto (2009-10-20) 2 commits.
 + receive-pack: run "gc --auto --quiet" and optionally "update-server-info"
 + gc --auto --quiet: make the notice a bit less verboase

* bg/clone-doc (2009-10-20) 1 commit.
 + git-clone.txt: Fix grammar and formatting

* iv/tar-lzma-xz (2009-10-20) 1 commit.
 + import-tars: Add support for tarballs compressed with lzma, xz

* jk/maint-cvsimport-pathname (2009-10-19) 1 commit.
 + cvsimport: fix relative argument filenames

* sb/gitweb-link-author (2009-10-15) 1 commit
 + gitweb: linkify author/committer names with search

--------------------------------------------------
[New Topics]

* jp/dirty-describe (2009-10-21) 1 commit.
 - Teach "git describe" --dirty option

Soon in 'next'.

* jp/fetch-cull-many-refs (2009-10-25) 2 commits
 - fetch: Speed up fetch of large numbers of refs
 - remote: Make ref_remove_duplicates faster for large numbers of refs

* bg/format-patch-p-noop (2009-10-25) 3 commits.
 - format-patch documentation: Fix formatting
 - format-patch documentation: Remove diff options that are not useful
 - format-patch: Make implementation and documentation agree

* jk/gitignore-anchored (2009-10-26) 1 commit
 - gitignore: root most patterns at the top-level directory

* jk/maint-add-p-empty (2009-10-27) 1 commit.
 - add-interactive: handle deletion of empty files

Soon in 'next'.

* jk/maint-push-config (2009-10-25) 1 commit.
 - push: always load default config

Soon in 'next'.

* lt/revision-bisect (2009-10-27) 1 commit.
 - Add '--bisect' revision machinery argument

* mh/maint-diff-color-words (2009-10-28) 3 commits
 - diff: fix the location of hunk headers for "git diff --color-words -U0"
 - diff: move the handling of the hunk header after the changed lines
 - t4034-diff-words: add a test for word diff without context

--------------------------------------------------
[Stalled]

* tr/filter-branch (2009-10-21) 2 commits.
 - filter-branch: nearest-ancestor rewriting outside subdir filter
 - filter-branch: stop special-casing $filter_subdir argument

J6t already has some comments on this.

* mr/gitweb-snapshot (2009-09-26) 2 commits.
 - gitweb: append short hash ids to snapshot files
  (merged to 'next' on 2009-10-11 at 22ba047)
 + gitweb: check given hash before trying to create snapshot

Jakub says the tip one needs updates.

* ne/rev-cache (2009-10-19) 7 commits.
 - support for commit grafts, slight change to general mechanism
 - support for path name caching in rev-cache
 - full integration of rev-cache into git, completed test suite
 - administrative functions for rev-cache, start of integration into git
 - support for non-commit object caching in rev-cache
 - basic revision cache system, no integration or features
 - man page and technical discussion for rev-cache

The author indicated that there is another round coming.

* jl/submodule-add-noname (2009-09-22) 1 commit.
 - git submodule add: make the <path> parameter optional

Dscho started an interesting discussion regarding the larger workflow in
which the "submodule add" is used.  I think the patch itself makes sense
but at the same time it probably makes sense to also take the <path> and
infer the <repository> as Dscho suggested, probably in "git submodule
add", not in "git add" proper, at least initially.

* sr/gfi-options (2009-09-06) 6 commits.
 - fast-import: test the new option command
 - fast-import: add option command
 - fast-import: test the new feature command
 - fast-import: add feature command
 - fast-import: put marks reading in it's own function
 - fast-import: put option parsing code in separate functions

???

* je/send-email-no-subject (2009-08-05) 1 commit.
  (merged to 'next' on 2009-10-11 at 1b99c56)
 + send-email: confirm on empty mail subjects

The existing tests cover the positive case (i.e. as long as the user says
"yes" to the "do you really want to send this message that lacks subject",
the message is sent) of this feature, but the feature itself needs its own
test to verify the negative case (i.e. does it correctly stop if the user
says "no"?)

--------------------------------------------------
[Cooking]

* db/vcs-helper-rest (2009-10-27) 7 commits.
 - Fix memory leak in helper method for disconnect
 - Allow helpers to report in "list" command that the ref is unchanged
 - Add support for "import" helper command
 - Add a config option for remotes to specify a foreign vcs
 - Allow programs to not depend on remotes having urls
 - Allow fetch to modify refs
 - Use a function to determine whether a remote is valid
 (this branch is used by jh/cvs-helper.)

Queued a fix-up.

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

This depends on the above.

* cb/doc-fetch-pull-merge (2009-10-21) 1 commit.
  (merged to 'next' on 2009-10-21 at 1d9190d)
 + modernize fetch/merge/pull examples

Soon in 'master'.

* ja/fetch-doc (2009-10-22) 3 commits.
  (merged to 'next' on 2009-10-22 at 8868407)
 + Documentation/merge-options.txt: order options in alphabetical groups
 + Documentation/git-pull.txt: Add subtitles above included option files
  (merged to 'next' on 2009-10-21 at bf09f62)
 + Documentation/fetch-options.txt: order options alphabetically

Soon in 'master'.

* tr/maint-roff-quote (2009-10-22) 1 commit.
  (merged to 'next' on 2009-10-22 at 14c5631)
 + Quote ' as \(aq in manpages

Soon in 'master'.

* rs/pretty-wrap (2009-10-17) 1 commit
 - Implement wrap format %w() as if it is a mode switch
 (this branch uses js/log-rewrap.)

* jc/pretty-lf (2009-10-04) 1 commit.
 - Pretty-format: %[+-]x to tweak inter-item newlines

* js/log-rewrap (2009-10-18) 3 commits
 - Teach --wrap to only indent without wrapping
 - Add strbuf_add_wrapped_text() to utf8.[ch]
 - print_wrapped_text(): allow hard newlines
 (this branch is used by rs/pretty-wrap.)

Before discarding jc/strbuf-nested-expand, I cherry-picked the tip of it
to this series.

* sr/blame-incomplete (2009-10-19) 1 commit.
  (merged to 'next' on 2009-10-22 at 133e0ce)
 + blame: make sure that the last line ends in an LF

I think this is _good enough_ as-is; although it would be better if we
added some hint to the output for Porcelain implementations, that can be
done as a follow-up fix.

* ak/bisect-reset-to-switch (2009-10-13) 1 commit.
  (merged to 'next' on 2009-10-22 at 592fff3)
 + bisect reset: Allow resetting to any commit, not just a branch

Soon in 'master'.

* fc/doc-fast-forward (2009-10-24) 1 commit.
 - Use 'fast-forward' all over the place

* jc/maint-1.6.3-graft-trailing-space (2009-10-14) 1 commit.
  (merged to 'next' on 2009-10-22 at 90ccac6)
 + info/grafts: allow trailing whitespaces at the end of line

Soon in 'master'.

* jn/show-normalized-refs (2009-10-12) 3 commits.
  (merged to 'next' on 2009-10-23 at 332aad3)
 + check-ref-format: simplify --print implementation
 + git check-ref-format --print
 + Add tests for git check-ref-format

Soon in 'master'.

* jc/checkout-auto-track (2009-10-18) 3 commits
  (merged to 'next' on 2009-10-23 at ff7e8f3)
 + git checkout --no-guess
 + DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
 + check_filename(): make verify_filename() callable without dying

The final shape of this series ended up to be more or less exactly what
Dscho hinted he wanted to have in one of the discussion.

Soon in 'master'.

* tr/stash-format (2009-10-19) 5 commits
  (merged to 'next' on 2009-10-23 at 6c551c3)
 + stash list: drop the default limit of 10 stashes
 + stash list: use new %g formats instead of sed
 + Introduce new pretty formats %g[sdD] for reflog information
 + reflog-walk: refactor the branch@{num} formatting
 + Refactor pretty_print_commit arguments into a struct

Soon in 'master'.

* ks/precompute-completion (2009-10-26) 3 commits.
  (merged to 'next' on 2009-10-28 at cd5177f)
 + completion: ignore custom merge strategies when pre-generating
  (merged to 'next' on 2009-10-22 at f46a28a)
 + bug: precomputed completion includes scripts sources
  (merged to 'next' on 2009-10-14 at adf722a)
 + Speedup bash completion loading

* sp/smart-http (2009-10-25) 24 commits
 - remote-helpers: return successfully if everything up-to-date
 - update http tests according to remote-curl capabilities
 - http-backend: more explict LocationMatch
 - http-backend: add example for gitweb on same URL
 - http-backend: use mod_alias instead of mod_rewrite
 - http-backend: reword some documentation
 - http-backend: add GIT_PROJECT_ROOT environment var
 - Smart HTTP fetch: gzip requests
 - Smart fetch over HTTP: client side
 - Smart push over HTTP: client side
 - Discover refs via smart HTTP server when available
 - Smart fetch and push over HTTP: server side
 - Add stateless RPC options to upload-pack, receive-pack
 - Git-aware CGI to provide dumb HTTP transport
 - Move WebDAV HTTP push under remote-curl
 - remote-helpers: Support custom transport options
 - remote-helpers: Fetch more than one ref in a batch
 - fetch: Allow transport -v -v -v to set verbosity to 3
 - remote-curl: Refactor walker initialization
 - Add multi_ack_detailed capability to fetch-pack/upload-pack
 - Move "get_ack()" back to fetch-pack
 - fetch-pack: Use a strbuf to compose the want list
 - pkt-line: Make packet_read_line easier to debug
 - pkt-line: Add strbuf based functions

Shawn plans another round of re-roll.

* ef/msys-imap (2009-10-22) 9 commits.
 - Windows: use BLK_SHA1 again
 - MSVC: Enable OpenSSL, and translate -lcrypto
 - mingw: enable OpenSSL
 - mingw: wrap SSL_set_(w|r)fd to call _get_osfhandle
 - imap-send: build imap-send on Windows
 - imap-send: fix compilation-error on Windows
 - imap-send: use run-command API for tunneling
 - imap-send: use separate read and write fds
 - imap-send: remove useless uid code

This is pulled from J6t; I'll merge it to 'next' if Dscho is Ok with it.

* js/diff-verbose-submodule (2009-10-23) 2 commits.
  (merged to 'next' on 2009-10-23 at e479773)
 + add tests for git diff --submodule
 + Add the --submodule option to the diff option family

Soon in 'master'.

* jc/fix-tree-walk (2009-10-22) 11 commits.
  (merged to 'next' on 2009-10-22 at 10c0c8f)
 + Revert failed attempt since 353c5ee
 + read-tree --debug-unpack
  (merged to 'next' on 2009-10-11 at 0b058e2)
 + unpack-trees.c: look ahead in the index
 + unpack-trees.c: prepare for looking ahead in the index
 + Aggressive three-way merge: fix D/F case
 + traverse_trees(): handle D/F conflict case sanely
 + more D/F conflict tests
 + tests: move convenience regexp to match object names to test-lib.sh
 + unpack_callback(): use unpack_failed() consistently
 + unpack-trees: typofix
 + diff-lib.c: fix misleading comments on oneway_diff()

This has some stupid bugs and temporarily reverted from 'next' until I can
fix it.

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

I think Johan indicated that early parts of it is ready for 'next', so I
may do so up to "Add selftests" one.

* jn/gitweb-blame (2009-09-01) 5 commits.
 - gitweb: Minify gitweb.js if JSMIN is defined
 - gitweb: Create links leading to 'blame_incremental' using JavaScript
  (merged to 'next' on 2009-10-11 at 73c4a83)
 + gitweb: Colorize 'blame_incremental' view during processing
 + gitweb: Incremental blame (using JavaScript)
 + gitweb: Add optional "time to generate page" info in footer

Ajax-y blame.  Probably the first three should go to 'master' by now?

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

* jc/1.7.0-no-commit-no-ff-2 (2009-10-22) 1 commit.
 - git-merge: forbid fast-forward and up-to-date when --no-commit is given

This makes "git merge --no-commit" fail when it results in fast-forward or
up-to-date.  I haven't described this at the beginning of this message
yet, as it is not clear if this change is even necessary.  Opinions?

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

The tip one is not in 'next' as I have been hoping that somebody may want
to change the code to make it unnecessary, but it does not seem to be
happening, so probably it should also go to 'next'.

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

* jg/log-format-body-indent (2009-09-19) 1 commit.
 . git-log --format: Add %B tag with %B(x) option
