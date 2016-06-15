From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2009, #04; Wed, 16)
Date: Wed, 16 Sep 2009 23:12:50 -0700
Message-ID: <7v1vm6kskd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 08:13:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoAEv-0001t6-BE
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 08:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbZIQGMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 02:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbZIQGMy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 02:12:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48345 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040AbZIQGMw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 02:12:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7ACD553130;
	Thu, 17 Sep 2009 02:12:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=BIe6
	D1KB+Oj9aKOqHwn2Q3ohAJM=; b=A8kPbo2fHC8qPKstSTlqobEedvopzpPEQdgi
	8FRAQhpfqtsXyVoM6WLlawv2Ulr7z5ql1nfXt9bJ2UzEuGW8+uasVI+GwpdaDOzG
	bjenQNph7Awgitvdu1z8a4InLWh8p6YrQIfvjHvvhpZ5LE0yhCf4kdh/RzMpEduR
	K2wz7uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=owL
	skvSF+oNKLB8rDL474YqUsJ8KOZHTdace3lc9dcQNnu9jCbn+tAlkXGBiIfwq+oj
	hMrmE+2LntV6rxqapbaBDgyRE//T9fUkzaCGA7oMGb+P75OzD3B18MUuieQXF9Gi
	i2AgUBrw9GDkFR0EVo0N3gcCm2VpZiqL4RzMpef8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 69F745312F;
	Thu, 17 Sep 2009 02:12:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 33C375312C; Thu, 17 Sep 2009
 02:12:51 -0400 (EDT)
X-master-at: 8426f672fc65239135b1f1580bb79ecb16fd05f0
X-next-at: 63b02d52a162438e5262062b3e6768beb3962be8
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2313DE5C-A351-11DE-A509-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128715>

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

We are in pre-release feature freeze.  'next' will hold topics meant for
1.6.6 and 1.7.0.

Except for possibly gfi-options series from Sverre, and updates to
subsystems (svn, gitk, gui, and gitweb) may still need to be merged in,
but otherwise 'master' is ready for -rc2.  I am still hoping that I can
tag the final before I take a vacation starting on 24th for a week, but we
may have to give the final -rc a week to shake out any possible last
minute regressions and release 1.6.5 at the beginning of next month.

--------------------------------------------------
[Graduated to "master"]

* rc/maint-http-no-head-pack-check (2009-09-14) 2 commits.
 + http.c: avoid freeing an uninitialized pointer
 + http.c: remove verification of remote packs

Graduated to master and maint but then needed a small fixup.

--------------------------------------------------
[New Topics]

* jc/maint-blank-at-eof (2009-09-15) 0 commits.
 (this branch uses jc/maint-1.6.0-blank-at-eof.)

The series does not have a commit of its own but is a preparation for
merging the original jc/1.6.0-maint-blank-at-eof topic to 'maint' and then
'master'.  It is a fix for longstanding bug and 1.6.5 will likely to ship
without this topic.

--------------------------------------------------
[Stalled]

* je/send-email-no-subject (2009-08-05) 1 commit
  (merged to 'next' on 2009-08-30 at b6455c2)
 + send-email: confirm on empty mail subjects

The existing tests to covers the positive case (i.e. as long as the user
says "yes" to the "do you really want to send this message that lacks
subject", the message is sent) of this feature, but the feature itself
needs its own test to verify the negative case (i.e. does it correctly
stop if the user says "no"?)

* jh/cvs-helper (2009-08-18) 8 commits
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

* ne/rev-cache (2009-09-07) 7 commits
 . support for commit grafts, slight change to general mechanism
 . support for path name caching in rev-cache
 . full integration of rev-cache into git, completed test suite
 . administrative functions for rev-cache, start of integration into git
 . support for non-commit object caching in rev-cache
 . basic revision cache system, no integration or features
 . man page and technical discussion for rev-cache

Replaced but I do not think this is ready for 'pu' yet.

--------------------------------------------------
[Cooking]

* db/vcs-helper-rest (2009-09-03) 6 commits
 - Allow helpers to report in "list" command that the ref is unchanged
 - Add support for "import" helper command
 - Add a config option for remotes to specify a foreign vcs
 - Allow programs to not depend on remotes having urls
 - Allow fetch to modify refs
 - Use a function to determine whether a remote is valid
 (this branch is used by jh/cvs-helper.)

This holds the remainder of the db/vcs-helper topic that has already
merged for 1.6.5.

* jh/notes (2009-09-12) 13 commits
 - Selftests verifying semantics when loading notes trees with various fanouts
 - Teach the notes lookup code to parse notes trees with various fanout schemes
 - notes.[ch] fixup: avoid old-style declaration
 - Teach notes code to free its internal data structures on request.
 - Add '%N'-format for pretty-printing commit notes
 - Add flags to get_commit_notes() to control the format of the note string
 - t3302-notes-index-expensive: Speed up create_repo()
 - fast-import: Add support for importing commit notes
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes
 (this branch uses sr/gfi-options.)

Rerolled and queued.

* jn/gitweb-show-size (2009-09-07) 1 commit
 - gitweb: Add 'show-sizes' feature to show blob sizes in tree view

* lt/maint-traverse-trees-fix (2009-09-06) 1 commit.
 - Prepare 'traverse_trees()' for D/F conflict lookahead

Beginning of the fix to a rather nasty longstanding issue of merging trees
with ("a" "a-b"), ("a/b" "a-b") and just ("a-b"), but my reading of it is
that it is just the first step to demonstrate one-entry lookahead and not
a full solution yet.

I started writing a replacement series but the progress is a bit slower
than I would have liked.

* jc/maint-1.6.0-blank-at-eof (2009-09-14) 15 commits.
  (merged to 'next' on 2009-09-15 at 9cbfa00)
 + diff -B: colour whitespace errors
 + diff.c: emit_add_line() takes only the rest of the line
 + diff.c: split emit_line() from the first char and the rest of the line
 + diff.c: shuffling code around
 + diff --whitespace: fix blank lines at end
  (merged to 'next' on 2009-09-07 at 165dc3c)
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

Will not be in 1.6.5.

* jn/gitweb-blame (2009-09-01) 5 commits
 - gitweb: Minify gitweb.js if JSMIN is defined
 - gitweb: Create links leading to 'blame_incremental' using JavaScript
  (merged to 'next' on 2009-09-07 at 3622199)
 + gitweb: Colorize 'blame_incremental' view during processing
 + gitweb: Incremental blame (using JavaScript)
 + gitweb: Add optional "time to generate page" info in footer

Ajax-y blame.

* sr/gfi-options (2009-09-06) 6 commits
  (merged to 'next' on 2009-09-07 at 5f6b0ff)
 + fast-import: test the new option command
 + fast-import: add option command
 + fast-import: test the new feature command
 + fast-import: add feature command
 + fast-import: put marks reading in it's own function
 + fast-import: put option parsing code in separate functions
 (this branch is used by jh/notes.)

Ping?

* nd/sparse (2009-08-20) 19 commits
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

* jk/1.7.0-status (2009-09-05) 5 commits
 - docs: note that status configuration affects only long format
  (merged to 'next' on 2009-09-07 at 8a7c563)
 + commit: support alternate status formats
 + status: add --porcelain output format
 + status: refactor format option parsing
 + status: refactor short-mode printing to its own function
 (this branch uses jc/1.7.0-status.)

Gives the --short output format to post 1.7.0 "git commit --dry-run" that
is similar to that of post 1.7.0 "git status".

* jc/1.7.0-status (2009-09-05) 4 commits
  (merged to 'next' on 2009-09-06 at 19d4beb)
 + status: typo fix in usage
  (merged to 'next' on 2009-08-22 at b3507bb)
 + git status: not "commit --dry-run" anymore
 + git stat -s: short status output
 + git stat: the beginning of "status that is not a dry-run of commit"
 (this branch is used by jk/1.7.0-status.)

With this, "git status" is no longer "git commit --dry-run".

* jc/1.7.0-send-email-no-thread-default (2009-08-22) 1 commit
  (merged to 'next' on 2009-08-22 at 5106de8)
 + send-email: make --no-chain-reply-to the default

* jc/1.7.0-diff-whitespace-only-status (2009-08-30) 4 commits.
  (merged to 'next' on 2009-08-30 at 0623572)
 + diff.c: fix typoes in comments
  (merged to 'next' on 2009-08-27 at 81fb2bd)
 + Make test case number unique
  (merged to 'next' on 2009-08-02 at 9c08420)
 + diff: Rename QUIET internal option to QUICK
 + diff: change semantics of "ignore whitespace" options

This changes exit code from "git diff --ignore-whitespace" and friends
when there is no actual output.  It is a backward incompatible change, but
we could argue that it is a bugfix.

* jc/1.7.0-push-safety (2009-02-09) 2 commits
  (merged to 'next' on 2009-08-02 at 38b82fe)
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
