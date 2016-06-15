From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2009, #04; Wed, 21)
Date: Wed, 21 Oct 2009 23:52:30 -0700
Message-ID: <7veiovly35.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 08:52:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0rXR-0006km-Pt
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 08:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284AbZJVGwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 02:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753168AbZJVGwd
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 02:52:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57832 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbZJVGwc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 02:52:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4AAB5816A0;
	Thu, 22 Oct 2009 02:52:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=S2o0
	QaM/bbcEowWMPsxa27gUC44=; b=F233Sq/Gb55sno/CUJ+PMDXQSPp5Dy3FGeWo
	PjNd4kGuVxTwLufv77ufHcNLqLsDe67ssBoq8cAj+r1iTuShQ8zJpfvHdEuQIwzT
	bBpk0LEMX86U+S4uLmYg7rNWAiyXnLQopUopDVA5jbEtf5jecAOI0cpLciUvivKw
	VzrTn+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=sCr
	dgP9JwU7ST1glcMu0T8EyIQy42/XnJcVYxKGKP55ee19W3KoRSPXJSQ5A89Zm1KS
	HMrpqxE2SHT25a/dP0PFDk4geHxEqIxURZ+FRoJZ8civ6ki2YLC4CzpFLOffR4AH
	mWJ/dxPxKjx/9WfJz2nE5sL/7zhj7vM2Hc+YJjLM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 394478169F;
	Thu, 22 Oct 2009 02:52:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 99F0F8169E; Thu, 22 Oct 2009
 02:52:32 -0400 (EDT)
X-master-at: 3694209ca16c033fb4c539cc23b0b370e48952dd
X-next-at: fef13efd27479ba3d90fd511ea198445ed434a73
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7A81D026-BED7-11DE-A408-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130998>

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

* gb/maint-gitweb-esc-param (2009-10-13) 1 commit.
  (merged to 'next' on 2009-10-14 at 105f997)
 + gitweb: fix esc_param
 (this branch is used by sb/gitweb-link-author.)

--------------------------------------------------
[New Topics]

* vl/git-gui (2009-10-16) 1 commit.
 - git-gui: adjust the minimum height of diff pane for shorter screen height

Shawn?

* cb/doc-fetch-pull-merge (2009-10-21) 1 commit.
  (merged to 'next' on 2009-10-21 at 1d9190d)
 + modernize fetch/merge/pull examples

* ja/fetch-doc (2009-10-21) 1 commit.
  (merged to 'next' on 2009-10-21 at bf09f62)
 + Documentation/fetch-options.txt: order options alphabetically

Helps 'git-fetch.{1,html}' without helping 'git-pull.{1,html}'.

* jc/1.7.0-no-commit-no-ff-2 (2009-10-21) 1 commit.
 - git-merge: forbid fast-forward and up-to-date when --no-commit is given

This makes "git merge --no-commit" fail when it results in fast-forward or
up-to-date.  I haven't described this at the beginning of this message
yet, as it is not clear if this is even necessary, but since I already
wrote it and many people seem to be interested in UI and behaviour
warts,...

Some tests expect the traditional behaviour of silently ignoring --no-commit
upon fast-forward, and tonight's 'pu' does not pass them.

* jc/1.7.0-no-commit-no-ff (2009-10-21) 1 commit.
 . git-merge: imply --no-ff when --no-commit is given

This is an alternative patch to the same issue.

* jc/fsck-default-full (2009-10-20) 1 commit
  (merged to 'next' on 2009-10-21 at 1375192)
 + fsck: default to "git fsck --full"

Should be safe enough to be in 'master' soon.

* jc/maint-fix-unpack-zlib-check (2009-10-21) 1 commit.
 - Fix incorrect error check while reading deflated pack data

This is the final round from 2009-10-21, not my earlier botched attempts.

* jc/receive-pack-auto (2009-10-20) 2 commits.
  (merged to 'next' on 2009-10-21 at fef13ef)
 + receive-pack: run "gc --auto --quiet" and optionally "update-server-info"
 + gc --auto --quiet: make the notice a bit less verboase

* jp/dirty-describe (2009-10-21) 1 commit.
 - Teach "git describe" --dirty option

Ack?

* tr/filter-branch (2009-10-21) 2 commits.
 - filter-branch: nearest-ancestor rewriting outside subdir filter
 - filter-branch: stop special-casing $filter_subdir argument

J6t already has some comments on this.

* tr/maint-roff-quote (2009-10-21) 2 commits.
 - Document GNU_ROFF in Makefile
 - Quote ' as \(aq in manpages

The doc may need to be clarified a bit more.

* bg/clone-doc (2009-10-20) 1 commit.
  (merged to 'next' on 2009-10-21 at 3016736)
 + git-clone.txt: Fix grammar and formatting

Should be correct enough to be in 'master' soon.

* iv/tar-lzma-xz (2009-10-20) 1 commit.
  (merged to 'next' on 2009-10-21 at cb0df8a)
 + import-tars: Add support for tarballs compressed with lzma, xz

Should be safe enough to be in 'master' soon.

* rs/pretty-wrap (2009-10-17) 1 commit
 - Implement wrap format %w() as if it is a mode switch
 (this branch uses js/log-rewrap; is related to jc/strbuf-nested-expand.)

When it comes to design issues to keep unnecessary complexity out, I tend
to trust R$BC)(Bne (and Nico) a lot more than I trust myself.  Tonight's 'pu'
queues this series instead of my "nested" one.

* sr/blame-incomplete (2009-10-19) 1 commit.
 - blame: make sure that the last line ends in an LF

I think this is _good enough_ as-is; although it would be better if we
added some hint to the output for Porcelain implementations, that can be
done as a follow-up fix.

--------------------------------------------------
[Stalled]

* mr/gitweb-snapshot (2009-09-26) 2 commits.
 - gitweb: append short hash ids to snapshot files
  (merged to 'next' on 2009-10-11 at 22ba047)
 + gitweb: check given hash before trying to create snapshot

I lost track of the discussion around the tip commit.  The bottom one may
better go to 'master' regardless.

* db/vcs-helper-rest (2009-09-03) 6 commits.
 - Allow helpers to report in "list" command that the ref is unchanged
 - Add support for "import" helper command
 - Add a config option for remotes to specify a foreign vcs
 - Allow programs to not depend on remotes having urls
 - Allow fetch to modify refs
 - Use a function to determine whether a remote is valid
 (this branch is used by jh/cvs-helper.)

This holds the remainder of the db/vcs-helper topic that has already
merged in 1.6.5.  If people want to replace this with improvements it
would be a good time to do so.

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

* je/send-email-no-subject (2009-08-05) 1 commit.
  (merged to 'next' on 2009-10-11 at 1b99c56)
 + send-email: confirm on empty mail subjects

The existing tests cover the positive case (i.e. as long as the user says
"yes" to the "do you really want to send this message that lacks subject",
the message is sent) of this feature, but the feature itself needs its own
test to verify the negative case (i.e. does it correctly stop if the user
says "no"?)

* jh/cvs-helper (2009-08-18) 8 commits.
 . More fixes to the git-remote-cvs installation procedure
 . Fix the Makefile-generated path to the git_remote_cvs package in git-remote-cvs
 . Add simple selftests of git-remote-cvs functionality
 . git-remote-cvs: Remote helper program for CVS repositories
 . 2/2: Add Python support library for CVS remote helper
 . 1/2: Add Python support library for CVS remote helper
 . Basic build infrastructure for Python scripts
 . Allow helpers to request marks for fast-import
 (this branch uses db/vcs-helper-rest.)

* jc/strbuf-nested-expand (2009-10-18) 3 commits
 . Teach --wrap to only indent without wrapping
 . Add %[wrap(width,in1,in2)<<any-string>>%] implementation
 . strbuf_nested_expand(): allow expansion to interrupt in the middle
 (this branch uses js/log-rewrap; is related to rs/pretty-wrap.)

Ejected from 'pu' to let rs/pretty-wrap in as described above.

--------------------------------------------------
[Cooking]

* ne/rev-cache (2009-10-19) 7 commits.
 - support for commit grafts, slight change to general mechanism
 - support for path name caching in rev-cache
 - full integration of rev-cache into git, completed test suite
 - administrative functions for rev-cache, start of integration into git
 - support for non-commit object caching in rev-cache
 - basic revision cache system, no integration or features
 - man page and technical discussion for rev-cache

Still unstable?  Has an extra test squashed in; tonight's 'pu' does not
pass tests.

* ak/bisect-reset-to-switch (2009-10-13) 1 commit.
 - bisect reset: Allow resetting to any commit, not just a branch

Soon in 'next'.

* fc/doc-fast-forward (2009-10-11) 1 commit.
 - user-manual: use 'fast-forward'

* jc/maint-1.6.3-graft-trailing-space (2009-10-14) 1 commit.
 - info/grafts: allow trailing whitespaces at the end of line

Soon in 'next'.

* jk/maint-cvsimport-pathname (2009-10-19) 1 commit.
  (merged to 'next' on 2009-10-19 at 77824f2)
 + cvsimport: fix relative argument filenames

Should be safe enough to be in 'master' soon.

* jn/show-normalized-refs (2009-10-12) 3 commits.
 - check-ref-format: simplify --print implementation
 - git check-ref-format --print
 - Add tests for git check-ref-format

This was for helping Porcelains like git-gui to sanely cope with user
input that has redundant // in refnames.  Are potential users happy with
the series?  I think this is ready for 'next'.

* sb/gitweb-link-author (2009-10-15) 1 commit
 - gitweb: linkify author/committer names with search

Soon in 'next'.

* jc/checkout-auto-track (2009-10-18) 3 commits
 - git checkout --no-guess
 - DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
 - check_filename(): make verify_filename() callable without dying

The final shape of this series ended up to be more or less exactly what
Dscho hinted he wanted to have in one of the discussion. Is everybody
happy with this kind of new user-friendliness?  I think it is safe enough
to be queued to 'next'.

* tr/stash-format (2009-10-19) 5 commits
 - stash list: drop the default limit of 10 stashes
 - stash list: use new %g formats instead of sed
 - Introduce new pretty formats %g[sdD] for reflog information
 - reflog-walk: refactor the branch@{num} formatting
 - Refactor pretty_print_commit arguments into a struct

Soon in 'next'.

* ks/precompute-completion (2009-10-05) 1 commit.
  (merged to 'next' on 2009-10-14 at adf722a)
 + Speedup bash completion loading

Are people happy with this?

* sp/smart-http (2009-10-14) 17 commits
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

What's the doneness of this series?

* ef/msys-imap (2009-10-21) 8 commits.
 - MSVC: Enable OpenSSL, and translate -lcrypto
 - mingw: enable OpenSSL
 - mingw: wrap SSL_set_(w|r)fd to call _get_osfhandle
 - imap-send: build imap-send on Windows
 - imap-send: fix compilation-error on Windows
 - imap-send: use run-command API for tunneling
 - imap-send: use separate read and write fds
 - imap-send: remove useless uid code

Another re-roll.  Waiting for an Ack from MSVC folks but otherwise it is
ready for 'next', I think.

* jc/pretty-lf (2009-10-04) 1 commit.
 - Pretty-format: %[+-]x to tweak inter-item newlines

* js/log-rewrap (2008-11-10) 2 commits
 - Add strbuf_add_wrapped_text() to utf8.[ch]
 - print_wrapped_text(): allow hard newlines
 (this branch is used by jc/strbuf-nested-expand and rs/pretty-wrap.)

Soon in 'next'; regardless of how wrapping is exposed to --pretty=format,
this code will be used, and it seems to be leak-free and reasonably done.

We _might_ want to cherry-pick the tip of jc/strbuf-nested-expand to this
series, though.

* js/diff-verbose-submodule (2009-10-14) 2 commits.
 - add tests for git diff --submodule-summary
 - Add the --submodule option to the diff option family

I should retitle and fix some comments in the tip commit (the tests have
already been adjusted to use the real option name), but otherwise I think
this is ready for 'next'.

* jc/fix-tree-walk (2009-09-14) 10 commits.
 - read-tree --debug-unpack
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

This is my replacement for Linus's lt/maint-traverse-trees-fix patch.  It
is not so much as a counter-proposal; I originally thought it might make
sense to walk the index and drive the walker to return the entries from
trees to match entries from the index, but I ended up doing pretty much
what Linus outlined --- walk the trees, and have the index walker follow
it.  It turned out that the index side also needed some hairy look-ahead,

This includes the fix to aggressive mode of three-way merge used by the
resolve strategy.

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

Rebased so that it does not pull in anything else.  Presumably it is ready
for next?

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

* jg/log-format-body-indent (2009-09-19) 1 commit.
 . git-log --format: Add %B tag with %B(x) option
