From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2009, #03; Sun, 15)
Date: Sun, 15 Nov 2009 02:23:15 -0800
Message-ID: <7vtywwm6i4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 11:23:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9cGa-0003yH-Ox
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 11:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbZKOKXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 05:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbZKOKXU
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 05:23:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbZKOKXR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2009 05:23:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2657E99654;
	Sun, 15 Nov 2009 05:23:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=6qKdiuNLgYHjPCCGWe/68nLZR
	7U=; b=hLeQAVluHCt72Qv6C6MkqR4i8zRP72myG1H+42Egr5p6lNFV809l0SPaa
	+rojD4irbpWZB8xPT6J4v0coX6S36pAPXblNUgSg8AXVNNnmTZAZjKJ0TB1cOShJ
	uyhe7R3pCVhiQ1ZycLm3dXR5sfNWgqRgXJgP+3DfpFfJ8OZzPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Ma6AthKm6VAx7BHYQs3
	WA7Q3WhgJHAyf8eRAh041Zb0UQorXUz3rsg79Wfnqe0DJ6AG9pMcL+G5l1EElwSJ
	cVSbdnwP8Ky4JR3igS5s7zEK0t1Do3jdlRE9/oAg4NwOTTBP4RXK1YavU2tlwvXW
	1yt5WbLLb5h5gc9lHB82U/ew=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0CDB199653;
	Sun, 15 Nov 2009 05:23:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 86FD299651; Sun, 15 Nov 2009
 05:23:17 -0500 (EST)
X-master-at: b7fba061e05d16fd2c61db5c279b6ad4db98aba4
X-next-at: 2a326b29e43e05e9ccc1bcf1af09cb27ff606193
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E5663236-D1D0-11DE-AAA4-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132930>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I=
 am
still holding onto them.

In 1.7.0, we plan to correct handful of warts in the interfaces everybo=
dy
agrees that they were mistakes.  The resulting system may not be strict=
ly
backward compatible.  Currently planned changes are:

 * refuse push to update the checked out branch in a non-bare repo by
   default

   Make "git push" into a repository to update the branch that is check=
ed
   out fail by default.  You can countermand this default by setting a
   configuration variable in the receiving repository.

   http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=3D=
108007

 * refuse push to delete the current branch by default

   Make "git push $there :$killed" to delete the branch that is pointed=
 at
   by its HEAD fail by default.  You can countermand this default by
   setting a configuration variable in the receiving repository.

   http://thread.gmane.org/gmane.comp.version-control.git/108862/focus=3D=
108936

 * git-send-email won't make deep threads by default

   Many people said that by default when sending more than 2 patches th=
e
   threading git-send-email makes by default is hard to read, and they
   prefer the default be one cover letter and each patch as a direct
   follow-up to the cover letter.  You can countermand this by setting =
a
   configuration variable.

   http://article.gmane.org/gmane.comp.version-control.git/109790

 * git-status won't be "git-commit --dry-run" anymore

   http://thread.gmane.org/gmane.comp.version-control.git/125989/focus=3D=
125993

 * "git-diff -w --exit-code" will exit success if only differences it
   found are whitespace changes that are stripped away from the output.

   http://thread.gmane.org/gmane.comp.version-control.git/119731/focus=3D=
119751

I wasn't fully functioning for the past few days, so this round we have
only added new topics and new patches to existing ones, without changin=
g
the status of individual topics very much.

--------------------------------------------------
[Graduated to "master"]

* jk/maint-format-patch-p-suppress-stat (2009-11-04) 1 commit.
  (merged to 'next' on 2009-11-08 at 0943296)
 + format-patch: make "-p" suppress diffstat
 (this branch is used by bg/format-patch-doc-update.)

* vl/maint-openssl-signature-change (2009-10-31) 1 commit.
  (merged to 'next' on 2009-10-31 at 0e1ce6b)
 + imap-send.c: fix compiler warnings for OpenSSL 1.0

Prepare ourselves before newer versions of OpenSSL hits more platforms.

* pb/maint-gitweb-blob-lineno (2009-11-06) 1 commit.
  (merged to 'next' on 2009-11-06 at 27b86ec)
 + gitweb: Fix blob linenr links in pathinfo mode

* bg/merge-ff-only (2009-10-29) 1 commit
  (merged to 'next' on 2009-10-31 at b6b49aa)
 + Teach 'git merge' and 'git pull' the option --ff-only

* jk/maint-1.6.3-ls-files-i (2009-10-30) 1 commit.
  (merged to 'next' on 2009-10-31 at 3a31fcc)
 + ls-files: unbreak "ls-files -i"

* tr/describe-advice (2009-10-28) 1 commit
  (merged to 'next' on 2009-10-31 at 8084850)
 + describe: when failing, tell the user about options that work

* jp/dirty-describe (2009-10-21) 1 commit.
  (merged to 'next' on 2009-10-30 at 19c7fc7)
 + Teach "git describe" --dirty option

* jk/gitignore-anchored (2009-10-26) 1 commit
  (merged to 'next' on 2009-10-30 at 9391a93)
 + gitignore: root most patterns at the top-level directory

* jk/maint-push-config (2009-10-25) 1 commit.
  (merged to 'next' on 2009-10-30 at 934e3c5)
 + push: always load default config

* sr/blame-incomplete (2009-10-19) 1 commit.
  (merged to 'next' on 2009-10-22 at 133e0ce)
 + blame: make sure that the last line ends in an LF

I think this is _good enough_ as-is; although it would be better if we
added some hint to the output for Porcelain implementations, that can b=
e
done as a follow-up fix.

--------------------------------------------------
[New Topics]

* jn/help-everywhere (2009-11-09) 21 commits
 - diff --no-index: make the usage string less scary
 - merge-{recursive,subtree}: use usagef() to print usage
 - Introduce usagef() that takes a printf-style format
 - Let 'git <command> -h' show usage without a git dir
 - Show usage string for 'git http-push -h'
 - Let 'git http-fetch -h' show usage outside any git repository
 - Show usage string for 'git stripspace -h'
 - Show usage string for 'git unpack-file -h'
 - Show usage string for 'git show-index -h'
 - Show usage string for 'git rev-parse -h'
 - Show usage string for 'git merge-one-file -h'
 - Show usage string for 'git mailsplit -h'
 - Show usage string for 'git imap-send -h'
 - Show usage string for 'git get-tar-commit-id -h'
 - Show usage string for 'git fast-import -h'
 - Show usage string for 'git check-ref-format -h'
 - Show usage string for 'git show-ref -h'
 - Show usage string for 'git merge-ours -h'
 - Show usage string for 'git commit-tree -h'
 - Show usage string for 'git cherry -h'
 - Show usage string for 'git grep -h'
 (this branch uses jn/maint-http-fetch-mingw and jn/remove-fetch--tool.=
)

There were unrelated but still worthy fixes, so I reordered some of the=
m;
also the "usage()" change is different from the one that was posted (se=
e
my comment in $gmane/132592).

* jn/maint-http-fetch-mingw (2009-11-09) 1 commit.
 - http-fetch: add missing initialization of argv0_path
 (this branch is used by jn/help-everywhere.)

* jn/remove-fetch--tool (2009-11-09) 1 commit
 - Retire fetch--tool helper to contrib/examples
 (this branch is used by jn/help-everywhere.)

These two were originally part of the "help-everywhere" topic but
they can stand on their own.

* jc/log-stdin (2009-11-03) 1 commit
 - Teach --stdin option to "log" family

This is not signed-off (see $gmane/131971 for list of things you can do=
 to
help advancing this topic).

* jn/gitweb-log-history (2009-11-13) 3 commits
 - gitweb: Make 'history' view (re)use git_log_generic()
 - gitweb: Refactor common parts of 'log' and 'shortlog' views
 - gitweb: Refactor 'log' action generation, adding git_log_body()

* jn/rfc-pull-rebase-error-message (2009-11-12) 1 commit
 - git-pull.sh --rebase: overhaul error handling when no candidates are=
 found

* np/maint-sideband-favor-status (2009-11-11) 1 commit.
 - give priority to progress messages

This looked obviously correct but I wasn't fully up to speed after bein=
g
ill for a few days, so it is queued in 'pu' with everything else.

* rg/doc-workflow (2009-11-14) 2 commits.
 - Corrections to release management section in gitworkflows.txt
 - Add branch management for releases to gitworkflows

* sb/ls-tree-parseopt (2009-11-13) 2 commits.
 - ls-tree: migrate to parse-options
 - t3101: test more ls-tree options

* tz/maint-rpm (2009-11-11) 1 commit.
 - Makefile: Ensure rpm packages can be read by older rpm versions

--------------------------------------------------
[Stalled]

* jl/submodule-add-noname (2009-09-22) 1 commit.
 - git submodule add: make the <path> parameter optional

Dscho started an interesting discussion regarding the larger workflow i=
n
which the "submodule add" is used.  I think the patch itself makes sens=
e
but at the same time it probably makes sense to also take the <path> an=
d
infer the <repository> as Dscho suggested, probably in "git submodule
add", not in "git add" proper, at least initially.

Any objections against merging this to 'next'?

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

This has some stupid bugs and temporarily reverted from 'next' until I =
can
fix it, but the "temporarily" turned out to be very loooong.  Sigh...

* jh/notes (2009-10-09) 22 commits.
 - fast-import: Proper notes tree manipulation using the notes API
 - Refactor notes concatenation into a flexible interface for combining=
 notes
 - Notes API: Allow multiple concurrent notes trees with new struct not=
es_tree
 - Notes API: for_each_note(): Traverse the entire notes tree with a ca=
llback
 - Notes API: get_note(): Return the note annotating the given object
 - Notes API: add_note(): Add note objects to the internal notes tree s=
tructure
 - Notes API: init_notes(): Initialize the notes tree from the given no=
tes ref
 - Notes API: get_commit_notes() -> format_note() + remove the commit r=
estriction
  (merged to 'next' on 2009-11-01 at 948327a)
 + Add selftests verifying concatenation of multiple notes for the same=
 commit
 + Refactor notes code to concatenate multiple notes annotating the sam=
e object
 + Add selftests verifying that we can parse notes trees with various f=
anouts
 + Teach the notes lookup code to parse notes trees with various fanout=
 schemes
 + Teach notes code to free its internal data structures on request
 + Add '%N'-format for pretty-printing commit notes
 + Add flags to get_commit_notes() to control the format of the note st=
ring
 + t3302-notes-index-expensive: Speed up create_repo()
 + fast-import: Add support for importing commit notes
 + Teach "-m <msg>" and "-F <file>" to "git notes edit"
 + Add an expensive test for git-notes
 + Speed up git notes lookup
 + Add a script to edit/inspect notes
 + Introduce commit notes

I somehow thought that the later API part was waiting for updates but
nothing seems to be happening.

* jn/gitweb-blame (2009-09-01) 5 commits.
 - gitweb: Minify gitweb.js if JSMIN is defined
 - gitweb: Create links leading to 'blame_incremental' using JavaScript
  (merged to 'next' on 2009-10-11 at 73c4a83)
 + gitweb: Colorize 'blame_incremental' view during processing
 + gitweb: Incremental blame (using JavaScript)
 + gitweb: Add optional "time to generate page" info in footer

Ajax-y blame.  Any progress or RFH?

* sr/gfi-options (2009-09-06) 6 commits.
 - fast-import: test the new option command
 - fast-import: add option command
 - fast-import: test the new feature command
 - fast-import: add feature command
 - fast-import: put marks reading in it's own function
 - fast-import: put option parsing code in separate functions

It seemed to be moving again soon, but nothing has happened yet...

* je/send-email-no-subject (2009-08-05) 1 commit.
  (merged to 'next' on 2009-10-11 at 1b99c56)
 + send-email: confirm on empty mail subjects

The existing tests cover the positive case (i.e. as long as the user sa=
ys
"yes" to the "do you really want to send this message that lacks subjec=
t",
the message is sent) of this feature, but the feature itself needs its =
own
test to verify the negative case (i.e. does it correctly stop if the us=
er
says "no"?)

--------------------------------------------------
[Cooking]

* sc/protocol-doc (2009-11-03) 1 commit.
 - Update packfile transfer protocol documentation

* tr/filter-branch (2009-11-10) 2 commits.
 - filter-branch: nearest-ancestor rewriting outside subdir filter
 - filter-branch: stop special-casing $filter_subdir argument

Updated again.  Looked sane, except that the option might not be
necessary.  But that can be fixed while in 'next', so unless anybody
sees further issues, I'll move this to 'next' soon.

* em/commit-claim (2009-11-04) 1 commit
 - commit -c/-C/--amend: reset timestamp and authorship to committer wi=
th --reset-author

I just picked better bits from both versions, but this needs to be
rethought.

* bg/format-patch-doc-update (2009-11-07) 4 commits
 - format-patch: Add "--no-stat" as a synonym for "-p"
 - format-patch documentation: Fix formatting
 - format-patch documentation: Remove diff options that are not useful
 - format-patch: Always generate a patch

Looked sensible, even though this may want to wait for 1.7.0.  We'll se=
e
when we merge this to 'next'.  I tweaked the --no-stat patch with noneg
bit; please check for sanity.

* rj/maint-simplify-cygwin-makefile (2009-10-27) 1 commit.
 - Makefile: merge two Cygwin configuration sections into one
 (this branch is used by rj/cygwin-msvc.)

This is one of the most obviously correct bit from "Compiling on Cygwin
using MSVC fails" topic.

* rj/cygwin-msvc (2009-11-09) 3 commits.
 - Add explicit Cygwin check to guard WIN32 header inclusion
 - MSVC: Add support for building with NO_MMAP
 - Makefile: keep MSVC and Cygwin configuration separate
 (this branch uses rj/maint-simplify-cygwin-makefile.)

I think J6t was not happy with the tip one.

* bg/fetch-multi (2009-11-10) 9 commits
 - Re-implement 'git remote update' using 'git fetch'
 - builtin-fetch: add --dry-run option
 - builtin-fetch: add --prune option
 - teach warn_dangling_symref to take a FILE argument
 - remote: refactor some logic into get_stale_heads()
 - Add missing test for 'git remote update --prune'
 - Add the configuration option skipFetchAll
 - Teach the --multiple option to 'git fetch'
 - Teach the --all option to 'git fetch'

This series from Bj=C3=B6rn Gustavsson contains 4 patches from Jay Soff=
ian as
well.  I haven't looked at the code very closely yet.

* bs/maint-pre-commit-hook-sample (2009-11-05) 1 commit.
  (merged to 'next' on 2009-11-06 at d70f646)
 + pre-commit.sample: Diff against the empty tree when HEAD is invalid

Looked Ok.

* cc/bisect-doc (2009-11-08) 1 commit
 - Documentation: add "Fighting regressions with git bisect" article

Any comments?  Should it go to Documentation/technical instead?

* sb/tutorial-test (2009-11-06) 4 commits
 - t1200: prepare for merging with Fast-forward bikeshedding
 - t1200: further modernize test script style
 - t1200: Make documentation and test agree
 - t1200: cleanup and modernize test style

Ready for 'next', I think.

* jn/editor-pager (2009-10-30) 9 commits
 - Provide a build time default-pager setting
 - Provide a build time default-editor setting
 - am -i, git-svn: use "git var GIT_PAGER"
 - add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR"
 - Teach git var about GIT_PAGER
 - Teach git var about GIT_EDITOR
 - Suppress warnings from "git var -l"
 - Do not use VISUAL editor on dumb terminals
 - Handle more shell metacharacters in editor names

* bw/autoconf-more (2009-11-04) 2 commits
 - configure: add settings for gitconfig, editor and pager
 - configure: add macro to set arbitrary make variables

This will follow jn/editor-pager series.

* js/maint-diff-color-words (2009-10-30) 3 commits.
  (merged to 'next' on 2009-11-10 at 5619714)
 + diff --color-words: bit of clean-up
 + diff --color-words -U0: fix the location of hunk headers
 + t4034-diff-words: add a test for word diff without context

=46ixes a corner case of running --color-words with -U0.

* sc/difftool-p4merge (2009-10-28) 1 commit
  (merged to 'next' on 2009-10-31 at 194b5c5)
 + mergetool--lib: add p4merge as a pre-configured mergetool option

I do not do p4 nor use difftool, so it's much easier for me to merge th=
is
to 'master' and wait for anybody to scream if there is breakage.  I'll =
do
so, unless I hear objections in a few days.

* sr/vcs-helper (2009-11-06) 12 commits
 - Add Python support library for remote helpers
 - Basic build infrastructure for Python scripts
 - Allow helpers to request the path to the .git directory
 - Allow helpers to report in "list" command that the ref is unchanged
 - Allow helper to map private ref names into normal names
 - Add support for "import" helper command
 - Allow specifying the remote helper in the url
 - Add a config option for remotes to specify a foreign vcs
 - Allow fetch to modify refs
 - Use a function to determine whether a remote is valid
 - Allow programs to not depend on remotes having urls
 - Fix memory leak in helper method for disconnect

Re-rolled series that contains Daniel's and Johan's.
Any comments?  Is everybody happy?

* mr/gitweb-snapshot (2009-11-07) 4 commits.
 - gitweb: Smarter snapshot names
 - gitweb: Document current snapshot rules via new tests
 - t/gitweb-lib.sh: Split gitweb output into headers and body
  (merged to 'next' on 2009-10-11 at 22ba047)
 + gitweb: check given hash before trying to create snapshot

Replaced commits near the tip with recent updates.

* jp/fetch-cull-many-refs (2009-11-13) 3 commits
  (merged to 'next' on 2009-11-15 at db0f967)
 + remote: fix use-after-free error detected by glibc in ref_remove_dup=
licates
  (merged to 'next' on 2009-11-01 at 1f09ce9)
 + fetch: Speed up fetch of large numbers of refs
 + remote: Make ref_remove_duplicates faster for large numbers of refs

Soon in 'master'.

* jk/maint-add-p-empty (2009-10-27) 1 commit.
  (merged to 'next' on 2009-10-30 at 2bd302f)
 + add-interactive: handle deletion of empty files

Soon in 'master'.

* lt/revision-bisect (2009-10-27) 1 commit.
  (merged to 'next' on 2009-10-30 at 81ee52b)
 + Add '--bisect' revision machinery argument

Soon in 'master'.

* jc/pretty-lf (2009-10-04) 1 commit.
 - Pretty-format: %[+-]x to tweak inter-item newlines

* rs/pretty-wrap (2009-11-08) 2 commits
  (merged to 'next' on 2009-11-08 at 8973fd8)
 + log --format: don't ignore %w() at the start of format string
  (merged to 'next' on 2009-10-30 at 403bbfe)
 + Implement wrap format %w() as if it is a mode switch
 (this branch uses js/log-rewrap.)

Soon in 'master'.

* js/log-rewrap (2009-10-18) 3 commits
  (merged to 'next' on 2009-10-30 at 403bbfe)
 + Teach --wrap to only indent without wrapping
 + Add strbuf_add_wrapped_text() to utf8.[ch]
 + print_wrapped_text(): allow hard newlines
 (this branch is used by rs/pretty-wrap.)

Soon in 'master'.

* fc/doc-fast-forward (2009-10-24) 1 commit.
  (merged to 'next' on 2009-11-01 at faaad90)
 + Use 'fast-forward' all over the place

Soon in 'master'; carrying this in 'next' for too long is turning out t=
o
be quite painful.

* ks/precompute-completion (2009-10-26) 3 commits.
  (merged to 'next' on 2009-10-28 at cd5177f)
 + completion: ignore custom merge strategies when pre-generating
  (merged to 'next' on 2009-10-22 at f46a28a)
 + bug: precomputed completion includes scripts sources
  (merged to 'next' on 2009-10-14 at adf722a)
 + Speedup bash completion loading

I didn't follow the discussion from the past few days closely, but I am
getting an impression that the consensus is we shouldn't precompute, so=
 I
may have to revert this and replace with what's cooking on the list whe=
n
it stabilizes.

* sp/smart-http (2009-11-11) 35 commits
  (merged to 'next' on 2009-11-15 at 2a326b2)
 + http-backend: Fix bad treatment of uintmax_t in Content-Length
 + t5551-http-fetch: Work around broken Accept header in libcurl
 + t5551-http-fetch: Work around some libcurl versions
 + http-backend: Protect GIT_PROJECT_ROOT from /../ requests
 + Git-aware CGI to provide dumb HTTP transport
  (merged to 'next' on 2009-11-06 at 666837c)
 + http-backend: Test configuration options
 + http-backend: Use http.getanyfile to disable dumb HTTP serving
 + test smart http fetch and push
 + http tests: use /dumb/ URL prefix
 + set httpd port before sourcing lib-httpd
 + t5540-http-push: remove redundant fetches
 + Smart HTTP fetch: gzip requests
 + Smart fetch over HTTP: client side
 + Smart push over HTTP: client side
 + Discover refs via smart HTTP server when available
 + http-backend: more explict LocationMatch
 + http-backend: add example for gitweb on same URL
 + http-backend: use mod_alias instead of mod_rewrite
 + http-backend: reword some documentation
 + http-backend: add GIT_PROJECT_ROOT environment var
 + Smart fetch and push over HTTP: server side
 + Add stateless RPC options to upload-pack, receive-pack
 + Git-aware CGI to provide dumb HTTP transport
 + remote-helpers: return successfully if everything up-to-date
 + Move WebDAV HTTP push under remote-curl
 + remote-helpers: Support custom transport options
 + remote-helpers: Fetch more than one ref in a batch
 + fetch: Allow transport -v -v -v to set verbosity to 3
 + remote-curl: Refactor walker initialization
 + Add multi_ack_detailed capability to fetch-pack/upload-pack
 + Move "get_ack()" back to fetch-pack
 + fetch-pack: Use a strbuf to compose the want list
 + pkt-line: Make packet_read_line easier to debug
 + pkt-line: Add strbuf based functions
 + http-push: fix check condition on http.c::finish_http_pack_request()

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

Soon in 'master', unless I hear objections from msys folks or imap-send
users.

* nd/sparse (2009-08-20) 19 commits.
 - sparse checkout: inhibit empty worktree
 - Add tests for sparse checkout
 - read-tree: add --no-sparse-checkout to disable sparse checkout suppo=
rt
 - unpack-trees(): ignore worktree check outside checkout area
 - unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final ind=
ex
 - unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/spar=
se-checkout
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
 - Introduce "skip-worktree" bit in index, teach Git to get/set this bi=
t
 - Add test-index-version
 - update-index: refactor mark_valid() in preparation for new options

The latest update I didn't look at very closely but I had an impression
that it was touching very generic codepath that would affect non sparse
cases, iow the patch looked very scary (the entire series already is).

--------------------------------------------------
[For 1.7.0]

* jc/1.7.0-no-commit-no-ff-2 (2009-10-22) 1 commit.
 - git-merge: forbid fast-forward and up-to-date when --no-commit is gi=
ven

This makes "git merge --no-commit" fail when it results in fast-forward=
 or
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

Gives the --short output format to post 1.7.0 "git commit --dry-run" th=
at
is similar to that of post 1.7.0 "git status".

The tip one is not in 'next' as I have been hoping that somebody may wa=
nt
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
when there is no actual output.  It is a backward incompatible change, =
but
we could argue that it is a bugfix.

* jc/1.7.0-push-safety (2009-02-09) 2 commits.
  (merged to 'next' on 2009-10-11 at 81b8128)
 + Refuse deleting the current branch via push
 + Refuse updating the current branch in a non-bare repository via push

--------------------------------------------------
[I have been too busy to purge these]

* ne/rev-cache (2009-10-19) 7 commits.
 . support for commit grafts, slight change to general mechanism
 . support for path name caching in rev-cache
 . full integration of rev-cache into git, completed test suite
 . administrative functions for rev-cache, start of integration into gi=
t
 . support for non-commit object caching in rev-cache
 . basic revision cache system, no integration or features
 . man page and technical discussion for rev-cache

The author indicated that there is another round coming.  Does not seem=
 to
pass the tests when merged to 'pu', so it has been ejected for now.

* jc/log-tz (2009-03-03) 1 commit.
 - Allow --date=3Dlocal --date=3Dother-format to work as expected

Maybe some people care about this.  I dunno.

* jc/mailinfo-remove-brackets (2009-07-15) 1 commit.
 - mailinfo: -b option keeps [bracketed] strings that is not a [PATCH] =
marker

Maybe some people care about this.  I dunno.

* pb/gitweb-no-project-list (2009-11-06) 3 commits.
 . gitweb: Polish the content tags support
 . gitweb: Support for no project list on gitweb front page
 . gitweb: Refactor project list routines

I picked these up but didn't queue as Warthog9's comments made certain
amount of sense to me.
