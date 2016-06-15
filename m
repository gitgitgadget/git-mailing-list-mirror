From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2009, #06; Wed, 25)
Date: Wed, 25 Nov 2009 17:03:33 -0800
Message-ID: <7v8wduksgq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 02:03:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSlu-0007Nh-AG
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 02:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759912AbZKZBDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 20:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759901AbZKZBDe
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 20:03:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759855AbZKZBDd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 20:03:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 99C57829EA;
	Wed, 25 Nov 2009 20:03:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=w3z6
	wyEdcHCArF2JsmozzxnaRtw=; b=msM1E8qZSskSRt+IIfJ45Eey5l6whLgWExoZ
	5vVkajxmx++gZBKJfME6zHP3UomaHL7b8+ayRNLIgAJYhJYuP+IEBggfA6IyKGeK
	oon0wUhIBi6OpYT2cefQDM6IdGS7NPxJv1diLiQnYRGQUzuAbKBierOKjdtxEZPm
	ChDXBak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=YCE
	7Pn2j83mYjTv14Jk4jF5woFFaJspQKIwQ+QI0MOxsYO7c3ngAh1pH8znqyNCXmIW
	GvWLHGGAmrJPt5fETXVrP1aAScYzTLV469Y/LZyKpay9/vqgaExlwHSbCUHioL4m
	5LK+Ond/aiuKtUxk6XVc9KXyN5l3jeEC5nLM0YgY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 634FE829E9;
	Wed, 25 Nov 2009 20:03:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 155BF829E8; Wed, 25 Nov
 2009 20:03:34 -0500 (EST)
X-master-at: ad7ace714d353ef49045bc37c1363e8fc904792d
X-next-at: 71380f5fbda0088bc2b94876e2a3b3bf74d6651f
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8726C370-DA27-11DE-89EF-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133748>

I wanted to do a 1.6.6-rc1 but somehow ended up spending too much time in
mail compose buffer instead of in C-mode today.  There are a few topics
that are in "stalled" state that may be worthy of being in 1.6.6.

We should start updating the Release Notes to make the 1.7.0 warning a bit
more visible.

-- >8 --

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

In 1.7.0, we plan to correct handful of warts in the interfaces everybody
agrees that they were mistakes.  The resulting system may not be strictly
backward compatible.  Currently planned changes are:

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

 * "git send-email" won't make deep threads by default

   Many people said that by default when sending more than 2 patches the
   threading git-send-email makes by default is hard to read, and they
   prefer the default be one cover letter and each patch as a direct
   follow-up to the cover letter.  You can countermand this by setting a
   configuration variable.

   http://article.gmane.org/gmane.comp.version-control.git/109790

 * "git status" won't be "git-commit --dry-run" anymore

   http://thread.gmane.org/gmane.comp.version-control.git/125989/focus=125993

 * "git diff -w --exit-code" will exit success if only differences it
   found are whitespace changes that are stripped away from the output.

   http://thread.gmane.org/gmane.comp.version-control.git/119731/focus=119751

 * "git diff -w/-b" won't even produce "diff --git" header when all changes
   are about whitespaces.

   http://thread.gmane.org/gmane.comp.version-control.git/133256

--------------------------------------------------
[Graduated to "master"]

* bg/fetch-multi (2009-11-10) 9 commits.
  (merged to 'next' on 2009-11-21 at 282f464)
 + Re-implement 'git remote update' using 'git fetch'
 + builtin-fetch: add --dry-run option
 + builtin-fetch: add --prune option
 + teach warn_dangling_symref to take a FILE argument
 + remote: refactor some logic into get_stale_heads()
 + Add missing test for 'git remote update --prune'
 + Add the configuration option skipFetchAll
 + Teach the --multiple option to 'git fetch'
 + Teach the --all option to 'git fetch'

* bg/apply-doc (2009-11-22) 4 commits
  (merged to 'next' on 2009-11-22 at b42fece)
 + apply: Use the term "working tree" consistently
 + apply: Format all options using back-quotes
 + apply: apply works outside a repository
 + Clarify and correct -z

* cc/replace (2009-11-19) 3 commits
  (merged to 'next' on 2009-11-21 at 2aaf84b)
 + Documentation: talk a little bit about GIT_NO_REPLACE_OBJECTS
 + Documentation: fix typos and spelling in replace documentation
 + replace: use a GIT_NO_REPLACE_OBJECTS env variable

* mm/maint-hint-failed-merge (2009-11-22) 2 commits.
  (merged to 'next' on 2009-11-22 at c0f64c2)
 + user-manual: Document that "git merge" doesn't like uncommited changes.
 + merge-recursive: point the user to commit when file would be overwritten.

* rj/maint-cygwin-count-objects (2009-11-19) 2 commits.
  (merged to 'next' on 2009-11-22 at 4ba5880)
 + ST_BLOCKS_COUNTS_IN_BLKSIZE to say on-disk size is (st_blksize * st_blocks)
 + git-count-objects: Fix a disk-space under-estimate on Cygwin

* rs/color-escape-has-zero-width (2009-11-23) 1 commit
 + Teach %w() that color escape codes have zero width

* jc/log-stdin (2009-11-23) 5 commits
  (merged to 'next' on 2009-11-23 at ea71363)
 + Add trivial tests for --stdin option to log family
  (merged to 'next' on 2009-11-21 at c3e2e52)
 + Make --stdin option to "log" family read also pathspecs
 + setup_revisions(): do not call get_pathspec() too early
 + Teach --stdin option to "log" family
 + read_revision_from_stdin(): use strbuf

* mr/gitweb-snapshot (2009-11-07) 4 commits.
  (merged to 'next' on 2009-11-21 at e825ad9)
 + gitweb: Smarter snapshot names
 + gitweb: Document current snapshot rules via new tests
 + t/gitweb-lib.sh: Split gitweb output into headers and body
  (merged to 'next' on 2009-10-11 at 22ba047)
 + gitweb: check given hash before trying to create snapshot

* rs/work-around-grep-opt-insanity (2009-11-23) 2 commits.
  (merged to 'next' on 2009-11-25 at bf972d8)
 + Protect scripted Porcelains from GREP_OPTIONS insanity
 + mergetool--lib: simplify guess_merge_tool()

--------------------------------------------------
[New Topics]

* jc/botched-maint-cygwin-count-objects (2009-11-24) 2 commits
  (merged to 'next' on 2009-11-25 at 8aa62a0)
 + Revert "ST_BLOCKS_COUNTS_IN_BLKSIZE to say on-disk size is (st_blksize * st_blocks)"
  (merged to 'next' on 2009-11-22 at 4ba5880)
 + ST_BLOCKS_COUNTS_IN_BLKSIZE to say on-disk size is (st_blksize * st_blocks)

This is a revert of the tip one I merged prematurely to 'next'.  The real
fix from Ramsay is already in 'master'.

* jc/grep-full-tree (2009-11-24) 1 commit.
 - grep: --full-tree

We probably would want test, doc and a configuration variable to make it
default (or non-default) before we can merge it to 'master'.

* uk/maint-shortlog-encoding (2009-11-25) 1 commit.
 - shortlog: respect commit encoding

The fix is a maint material but the patch was against next, so I
back-rebased it myself.  I tried to be careful but please double check the
result.

Perhaps merge it to 'master' before 1.6.6-rc1?

--------------------------------------------------
[Stalled]

* je/send-email-no-subject (2009-08-05) 1 commit.
  (merged to 'next' on 2009-10-11 at 1b99c56)
 + send-email: confirm on empty mail subjects

The existing tests cover the positive case (i.e. as long as the user says
"yes" to the "do you really want to send this message that lacks subject",
the message is sent) of this feature, but the feature itself needs its own
test to verify the negative case (i.e. does it correctly stop if the user
says "no"?)

* fc/send-email-envelope (2009-11-22) 1 commit.
 - t9001: test --envelope-sender option of send-email

The new feature itself looked promising; this is just an unrelated test
patch.

* jn/rfc-pull-rebase-error-message (2009-11-12) 1 commit
 - git-pull.sh --rebase: overhaul error handling when no candidates are found

I heard this needs at least retitling among other changes?

* sr/vcs-helper (2009-11-18) 12 commits
 - Add Python support library for remote helpers
 - Basic build infrastructure for Python scripts
 - Allow helpers to report in "list" command that the ref is unchanged
 - Fix various memory leaks in transport-helper.c
 - Allow helper to map private ref names into normal names
 - Add support for "import" helper command
 - Allow specifying the remote helper in the url
 - Add a config option for remotes to specify a foreign vcs
 - Allow fetch to modify refs
 - Use a function to determine whether a remote is valid
 - Allow programs to not depend on remotes having urls
 - Fix memory leak in helper method for disconnect

Replaced again, and looking good.  Perhaps Daniel has some comments?

* jh/notes (2009-11-20) 10 commits
 - Add more testcases to test fast-import of notes
 - Rename t9301 to t9350, to make room for more fast-import tests
 - fast-import: Proper notes tree manipulation using the notes API
 - Refactor notes concatenation into a flexible interface for combining notes
 - Notes API: Allow multiple concurrent notes trees with new struct notes_tree
 - Notes API: for_each_note(): Traverse the entire notes tree with a callback
 - Notes API: get_note(): Return the note annotating the given object
 - Notes API: add_note(): Add note objects to the internal notes tree structure
 - Notes API: init_notes(): Initialize the notes tree from the given notes ref
 - Notes API: get_commit_notes() -> format_note() + remove the commit restriction

Johan waits for an Ack from Shawn on "fast-import" one.

* tr/maint-merge-ours-clarification (2009-11-15) 1 commit
  (merged to 'next' on 2009-11-21 at fadaf7b)
 + rebase: refuse to rebase with -s ours

I do not think we reached a concensus for solving conflicts between "give
them rope" and "protect users from clearly meaningless combinations".  The
author obviously is for the latter (and I am inclined to agree); Dscho
seems to think otherwise.

* jc/fix-tree-walk (2009-10-22) 8 commits
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

This has some stupid bugs and reverted from 'next' until I can fix it, but
the "temporarily" turned out to be very loooong.  Sigh...

* sr/gfi-options (2009-09-06) 6 commits.
 - fast-import: test the new option command
 - fast-import: add option command
 - fast-import: test the new feature command
 - fast-import: add feature command
 - fast-import: put marks reading in it's own function
 - fast-import: put option parsing code in separate functions

Sverre is working on a re-roll to address comments from Shawn.

--------------------------------------------------
[Cooking]

* jc/mailinfo-remove-brackets (2009-07-15) 1 commit.
  (merged to 'next' on 2009-11-25 at 09d498f)
 + mailinfo: -b option keeps [bracketed] strings that is not a [PATCH] marker

Jim Meyering sent a patch to do a subset of what this does; to allow
keeping '[SECURITY]' when the subject says '[SECURITY][PATCH]', you need
to also teach "am" to pass the new -b option, but that is independent of
what Jim showed the need in real-world, so I think this can go in as-is.

Perhaps merge it to 'master' before 1.6.6-rc1?

* jc/checkout-merge-base (2009-11-20) 2 commits
 - "rebase --onto A...B" replays history on the merge base between A and B
 - "checkout A...B" switches to the merge base between A and B

I've been using the first one for a while myself but do not see many users
want this (yet); the new feature is not urgent anyway.

* tr/reset-checkout-patch (2009-11-19) 1 commit.
  (merged to 'next' on 2009-11-22 at b224950)
 + {checkout,reset} -p: make patch direction configurable

I do not particularly like a configuration like this that changes the
behaviour of a command in a drastic way---it will make helping others much
harder.

Perhaps merge it to 'master' before 1.6.6-rc1?

* jn/gitweb-blame (2009-11-24) 8 commits.
  (merged to 'next' on 2009-11-25 at 0a5b649)
 + gitweb.js: fix padLeftStr() and its usage
 + gitweb.js: Harden setting blamed commit info in incremental blame
 + gitweb.js: fix null object exception in initials calculation
 + gitweb: Minify gitweb.js if JSMIN is defined
 + gitweb: Create links leading to 'blame_incremental' using JavaScript
  (merged to 'next' on 2009-10-11 at 73c4a83)
 + gitweb: Colorize 'blame_incremental' view during processing
 + gitweb: Incremental blame (using JavaScript)
 + gitweb: Add optional "time to generate page" info in footer

Ajax-y blame, with further fixes.  As this does not seem to break existing
features, I am inclined to say that we push this out early, as a new
feature with known breakages, to give it wider audience.

* em/commit-claim (2009-11-04) 1 commit
  (merged to 'next' on 2009-11-23 at b5df6fd)
 + commit -c/-C/--amend: reset timestamp and authorship to committer with --reset-author

I am not sure if the option name does a good job at explaining it to the
end users, but I think the code and feature is solid.

Perhaps merge it to 'master' before 1.6.6-rc1?

* cc/bisect-doc (2009-11-08) 1 commit
 - Documentation: add "Fighting regressions with git bisect" article

Nobody seems to think this should go to Documentation/technical instead,
so unless I hear otherwise, we will have it as-is in 'next' shortly.

Perhaps merge it to 'master' before 1.6.6-rc1?

* nd/sparse (2009-11-25) 20 commits.
  (merged to 'next' on 2009-11-25 at 71380f5)
 + tests: rename duplicate t1009
  (merged to 'next' on 2009-11-23 at f712a41)
 + sparse checkout: inhibit empty worktree
 + Add tests for sparse checkout
 + read-tree: add --no-sparse-checkout to disable sparse checkout support
 + unpack-trees(): ignore worktree check outside checkout area
 + unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final index
 + unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/sparse-checkout
 + unpack-trees.c: generalize verify_* functions
 + unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
 + Introduce "sparse checkout"
 + dir.c: export excluded_1() and add_excludes_from_file_1()
 + excluded_1(): support exclude files in index
 + unpack-trees(): carry skip-worktree bit over in merged_entry()
 + Read .gitignore from index if it is skip-worktree
 + Avoid writing to buffer in add_excludes_from_file_1()
 + Teach Git to respect skip-worktree bit (writing part)
 + Teach Git to respect skip-worktree bit (reading part)
 + Introduce "skip-worktree" bit in index, teach Git to get/set this bit
 + Add test-index-version
 + update-index: refactor mark_valid() in preparation for new options

* jc/pretty-lf (2009-10-04) 1 commit.
 - Pretty-format: %[+-]x to tweak inter-item newlines

Perhaps drop the "%-x" part and merge it to 'next' and to 'master' before
1.6.6?

--------------------------------------------------
[For 1.7.0]

* jk/1.7.0-status (2009-09-05) 5 commits.
  (merged to 'next' on 2009-11-21 at 884bb56)
 + docs: note that status configuration affects only long format
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

* gb/1.7.0-diff-whitespace-only-outout (2009-11-19) 1 commit
  (merged to 'next' on 2009-11-21 at 3375bf4)
 + No diff -b/-w output for all-whitespace changes

* jc/1.7.0-push-safety (2009-02-09) 2 commits.
  (merged to 'next' on 2009-10-11 at 81b8128)
 + Refuse deleting the current branch via push
 + Refuse updating the current branch in a non-bare repository via push

--------------------------------------------------
[I have been too busy to purge these]

* jc/log-tz (2009-03-03) 1 commit.
 - Allow --date=local --date=other-format to work as expected

Maybe some people care about this.  I dunno.

* jc/1.7.0-no-commit-no-ff-2 (2009-10-22) 1 commit.
 . git-merge: forbid fast-forward and up-to-date when --no-commit is given

This makes "git merge --no-commit" fail when it results in fast-forward or
up-to-date.  It appears nobody wants to have this, so I dropped it.

* ne/rev-cache (2009-10-19) 7 commits.
 . support for commit grafts, slight change to general mechanism
 . support for path name caching in rev-cache
 . full integration of rev-cache into git, completed test suite
 . administrative functions for rev-cache, start of integration into git
 . support for non-commit object caching in rev-cache
 . basic revision cache system, no integration or features
 . man page and technical discussion for rev-cache

The author indicated that there is another round coming.  Does not seem to
pass the tests when merged to 'pu', so it has been ejected for now.

* pb/gitweb-no-project-list (2009-11-06) 3 commits.
 . gitweb: Polish the content tags support
 . gitweb: Support for no project list on gitweb front page
 . gitweb: Refactor project list routines

I picked these up but didn't queue as Warthog9's comments made certain
amount of sense to me.

* ks/precompute-completion (2009-11-15) 4 commits.
  (merged to 'next' on 2009-11-15 at 23cdb96)
 + Revert ks/precompute-completion series
  (merged to 'next' on 2009-10-28 at cd5177f)
 + completion: ignore custom merge strategies when pre-generating
  (merged to 'next' on 2009-10-22 at f46a28a)
 + bug: precomputed completion includes scripts sources
  (merged to 'next' on 2009-10-14 at adf722a)
 + Speedup bash completion loading

Reverted out of 'next', to be replaced with jn/faster-completion-startup
topic.
