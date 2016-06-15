From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2009, #01; Wed, 04)
Date: Wed, 04 Nov 2009 21:41:57 -0800
Message-ID: <7vmy31a5p6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 06:42:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5v6y-0001pg-4k
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 06:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbZKEFmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 00:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755110AbZKEFmA
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 00:42:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbZKEFl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 00:41:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA081933BF;
	Thu,  5 Nov 2009 00:42:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=J7DH
	igMwSUV8+vpdFm9SEbgjuZo=; b=okfa65pAZ8HppptEx/12ox4K1myIyAWDMAHG
	j/+6ofAdR2PUPdu6i7BS1um5T96pZQL4SAnoSsYvLKjG4f/BCzqR9cbtIgecoR1h
	xsAvaoTrfVlLUOcDwgMmbpQ3IGZAyClaN1aElHnTTqFvAUwMOrIHIrvJilZPoaP4
	5z7Gq9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=cQu
	E7/1KbyqrcFB21UvY6Mzt9XLBchLjmqGX3A3IxZsXQZ1lVdRauqhSPtiXKp3foy4
	gAzP3ZWTFPGTO4W4rk+oHilMtEcgtoFsHKd+c9G97ryrfbY+OceJakj3Ei2dridg
	opfqLMCkqwrYul1giB9PYDZyEJrUnOiMGCs3Iv0k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B8A00933BE;
	Thu,  5 Nov 2009 00:42:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 65524933BA; Thu,  5 Nov 2009
 00:41:59 -0500 (EST)
X-master-at: 1b52ac5935c3773596fa41f6cf83578ab86b6b83
X-next-at: 13162391f0c3d2cbb810fc00a877496042919b10
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F10A2666-C9CD-11DE-9857-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132200>

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
[New Topics]

* bw/autoconf-more (2009-11-04) 2 commits
 - configure: add settings for gitconfig, editor and pager
 - configure: add macro to set arbitrary make variables

* em/commit-claim (2009-11-04) 1 commit
 - commit -c/-C/--amend: reset timestamp and authorship to committer with --reset-author

I just picked better bits from both versions.

* jk/maint-format-patch-p-suppress-stat (2009-11-04) 2 commits.
 - format-patch: make "-p" suppress diffstat
 - Revert "format-patch -p is now a no-op" series
 (this branch uses bg/format-patch-p-noop.)

This corrects a mistake made soon after 1.6.0.

* rj/maint-simplify-cygwin-makefile (2009-10-27) 1 commit.
 - Makefile: merge two Cygwin configuration sections into one

This is one of the most obviously correct bit from "Compiling on Cygwin
using MSVC fails" topic I didn't really look at.  If J6t is Ok with the
series, I don't mind queueing the whole thing myself.

* vl/maint-openssl-signature-change (2009-10-31) 1 commit.
  (merged to 'next' on 2009-10-31 at 0e1ce6b)
 + imap-send.c: fix compiler warnings for OpenSSL 1.0

Prepare ourselves before newer versions of OpenSSL hits more platforms.

--------------------------------------------------
[Stalled]

* tr/filter-branch (2009-10-28) 2 commits.
 - filter-branch: nearest-ancestor rewriting outside subdir filter
 - filter-branch: stop special-casing $filter_subdir argument

J6t had some comments on this.

* ne/rev-cache (2009-10-19) 7 commits.
 - support for commit grafts, slight change to general mechanism
 - support for path name caching in rev-cache
 - full integration of rev-cache into git, completed test suite
 - administrative functions for rev-cache, start of integration into git
 - support for non-commit object caching in rev-cache
 - basic revision cache system, no integration or features
 - man page and technical discussion for rev-cache

The author indicated that there is another round coming.  Does not seem to
pass the tests when merged to 'pu'.

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

Seems to be moving again soon.

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

* bg/merge-ff-only (2009-10-29) 1 commit
  (merged to 'next' on 2009-10-31 at b6b49aa)
 + Teach 'git merge' and 'git pull' the option --ff-only

* jk/maint-1.6.3-ls-files-i (2009-10-30) 1 commit.
  (merged to 'next' on 2009-10-31 at 3a31fcc)
 + ls-files: unbreak "ls-files -i"

* jn/editor-pager (2009-10-30) 8 commits
 - Provide a build time default-pager setting
 - Provide a build time default-editor setting
 - am -i, git-svn: use "git var GIT_PAGER"
 - add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR"
 - Teach git var about GIT_PAGER
 - Teach git var about GIT_EDITOR
 - Do not use VISUAL editor on dumb terminals
 - Handle more shell metacharacters in editor names

* js/maint-diff-color-words (2009-10-30) 3 commits.
 - diff --color-words: bit of clean-up
 - diff --color-words -U0: fix the location of hunk headers
 - t4034-diff-words: add a test for word diff without context

Fixes a corner case of running --color-words with -U0.

* sc/difftool-p4merge (2009-10-28) 1 commit
  (merged to 'next' on 2009-10-31 at 194b5c5)
 + mergetool--lib: add p4merge as a pre-configured mergetool option

* sc/protocol-doc (2009-10-29) 1 commit
 - Update packfile transfer protocol documentation

There is the final draft posted, but I haven't picked it up yet.

* sr/vcs-helper (2009-11-04) 13 commits
 - Add Python support library for remote helpers
 - Basic build infrastructure for Python scripts
 - Allow helpers to request the path to the .git directory
 - Allow helpers to report in "list" command that the ref is unchanged
 - Honour the refspec when updating refs after import
 - Write local refs written by the "import" helper command only once
 - Add support for "import" helper command
 - Allow specifying the remote helper in the url
 - Add a config option for remotes to specify a foreign vcs
 - Allow fetch to modify refs
 - Use a function to determine whether a remote is valid
 - Allow programs to not depend on remotes having urls
 - Fix memory leak in helper method for disconnect

Supposed to replace db/vcs-helper-rest.  Still does not pass tests in
'pu'.

* tr/describe-advice (2009-10-28) 1 commit
  (merged to 'next' on 2009-10-31 at 8084850)
 + describe: when failing, tell the user about options that work

* mr/gitweb-snapshot (2009-10-29) 3 commits.
 - gitweb: Smarter snapshot names
 - t/gitweb-lib.sh: Split gitweb output into headers and body
  (merged to 'next' on 2009-10-11 at 22ba047)
 + gitweb: check given hash before trying to create snapshot

Replaced the tip with Jakub's updates.

* jp/dirty-describe (2009-10-21) 1 commit.
  (merged to 'next' on 2009-10-30 at 19c7fc7)
 + Teach "git describe" --dirty option

* jp/fetch-cull-many-refs (2009-10-25) 2 commits
  (merged to 'next' on 2009-11-01 at 1f09ce9)
 + fetch: Speed up fetch of large numbers of refs
 + remote: Make ref_remove_duplicates faster for large numbers of refs

* bg/format-patch-p-noop (2009-10-25) 3 commits.
  (merged to 'next' on 2009-10-30 at e34a3db)
 + format-patch documentation: Fix formatting
 + format-patch documentation: Remove diff options that are not useful
 + format-patch: Make implementation and documentation agree
 (this branch is used by jk/maint-format-patch-p-suppress-stat.)

Will revert from 'next' by merging Peff's fix.

* jk/gitignore-anchored (2009-10-26) 1 commit
  (merged to 'next' on 2009-10-30 at 9391a93)
 + gitignore: root most patterns at the top-level directory

* jk/maint-add-p-empty (2009-10-27) 1 commit.
  (merged to 'next' on 2009-10-30 at 2bd302f)
 + add-interactive: handle deletion of empty files

* jk/maint-push-config (2009-10-25) 1 commit.
  (merged to 'next' on 2009-10-30 at 934e3c5)
 + push: always load default config

* lt/revision-bisect (2009-10-27) 1 commit.
  (merged to 'next' on 2009-10-30 at 81ee52b)
 + Add '--bisect' revision machinery argument

* jc/pretty-lf (2009-10-04) 1 commit.
 - Pretty-format: %[+-]x to tweak inter-item newlines

* rs/pretty-wrap (2009-10-17) 1 commit
  (merged to 'next' on 2009-10-30 at 403bbfe)
 + Implement wrap format %w() as if it is a mode switch
 (this branch uses js/log-rewrap.)

* js/log-rewrap (2009-10-18) 3 commits
  (merged to 'next' on 2009-10-30 at 403bbfe)
 + Teach --wrap to only indent without wrapping
 + Add strbuf_add_wrapped_text() to utf8.[ch]
 + print_wrapped_text(): allow hard newlines
 (this branch is used by rs/pretty-wrap.)

* sr/blame-incomplete (2009-10-19) 1 commit.
  (merged to 'next' on 2009-10-22 at 133e0ce)
 + blame: make sure that the last line ends in an LF

I think this is _good enough_ as-is; although it would be better if we
added some hint to the output for Porcelain implementations, that can be
done as a follow-up fix.

* fc/doc-fast-forward (2009-10-24) 1 commit.
  (merged to 'next' on 2009-11-01 at faaad90)
 + Use 'fast-forward' all over the place

* ks/precompute-completion (2009-10-26) 3 commits.
  (merged to 'next' on 2009-10-28 at cd5177f)
 + completion: ignore custom merge strategies when pre-generating
  (merged to 'next' on 2009-10-22 at f46a28a)
 + bug: precomputed completion includes scripts sources
  (merged to 'next' on 2009-10-14 at adf722a)
 + Speedup bash completion loading

* sp/smart-http (2009-11-04) 30 commits
 - http-backend: Test configuration options
 - http-backend: Use http.getanyfile to disable dumb HTTP serving
 - test smart http fetch and push
 - http tests: use /dumb/ URL prefix
 - set httpd port before sourcing lib-httpd
 - t5540-http-push: remove redundant fetches
 - Smart HTTP fetch: gzip requests
 - Smart fetch over HTTP: client side
 - Smart push over HTTP: client side
 - Discover refs via smart HTTP server when available
 - http-backend: more explict LocationMatch
 - http-backend: add example for gitweb on same URL
 - http-backend: use mod_alias instead of mod_rewrite
 - http-backend: reword some documentation
 - http-backend: add GIT_PROJECT_ROOT environment var
 - Smart fetch and push over HTTP: server side
 - Add stateless RPC options to upload-pack, receive-pack
 - Git-aware CGI to provide dumb HTTP transport
 - remote-helpers: return successfully if everything up-to-date
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
 - http-push: fix check condition on http.c::finish_http_pack_request()

v5 plus 3 more fix-up patches from today.

* ef/msys-imap (2009-10-22) 9 commits.
  (merged to 'next' on 2009-10-31 at 8630603)
 + Windows: use BLK_SHA1 again
 + MSVC: Enable OpenSSL, and translate -lcrypto
 + mingw: enable OpenSSL
 + mingw: wrap SSL_set_(w|r)fd to call _get_osfhandle
 + imap-send: build imap-send on Windows
 + imap-send: fix compilation-error on Windows
 + imap-send: use run-command API for tunneling
 + imap-send: use separate read and write fds
 + imap-send: remove useless uid code

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
fix it, but the "temporarily" turned out to be very loooong.  Sigh...

* jh/notes (2009-10-09) 22 commits.
 - fast-import: Proper notes tree manipulation using the notes API
 - Refactor notes concatenation into a flexible interface for combining notes
 - Notes API: Allow multiple concurrent notes trees with new struct notes_tree
 - Notes API: for_each_note(): Traverse the entire notes tree with a callback
 - Notes API: get_note(): Return the note annotating the given object
 - Notes API: add_note(): Add note objects to the internal notes tree structure
 - Notes API: init_notes(): Initialize the notes tree from the given notes ref
 - Notes API: get_commit_notes() -> format_note() + remove the commit restriction
  (merged to 'next' on 2009-11-01 at 948327a)
 + Add selftests verifying concatenation of multiple notes for the same commit
 + Refactor notes code to concatenate multiple notes annotating the same object
 + Add selftests verifying that we can parse notes trees with various fanouts
 + Teach the notes lookup code to parse notes trees with various fanout schemes
 + Teach notes code to free its internal data structures on request
 + Add '%N'-format for pretty-printing commit notes
 + Add flags to get_commit_notes() to control the format of the note string
 + t3302-notes-index-expensive: Speed up create_repo()
 + fast-import: Add support for importing commit notes
 + Teach "-m <msg>" and "-F <file>" to "git notes edit"
 + Add an expensive test for git-notes
 + Speed up git notes lookup
 + Add a script to edit/inspect notes
 + Introduce commit notes

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
