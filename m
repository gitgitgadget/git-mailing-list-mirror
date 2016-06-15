From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2015, #02; Wed, 12)
Date: Wed, 12 Aug 2015 15:50:43 -0700
Message-ID: <xmqqegj8jf3w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 00:50:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPerE-00024X-6f
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 00:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbbHLWur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 18:50:47 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33109 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbHLWuo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 18:50:44 -0400
Received: by pabyb7 with SMTP id yb7so23491509pab.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=GXLYjyV4dyDwGktik9qBwAaWp4O0vXcmh+zIezZEZ+A=;
        b=kLMzm7ZtPWnoOh4nvjs856Y/FhOd4j3CH+ql1Z2ooj/BElNmRncPaTKaqU9LplSpbZ
         8hykAN0rHjOYF0/oW+8/+0gUKC28uwecTtBpTEoqvBqEZVrLOy845q8x7GFkgbNGdns1
         bE3OcKKOPbVs+GpxQ2JGchuzwL3yBu9/feDk9uFQ0zVB2jrrAzkpXxQOREspCGZx5LZ+
         hOh69fUAPkD6QwpnKBKgzGwxVJxLjLzlUrj9kMGQNeYnrRbiMbZwUsdiCmABOqjX8Trm
         FlCD6EjwW33rFZHEmZbC1M3FICSMxcTT/C9RC30uOmGeo2Trf8sNtQj0T886oFlcr5li
         OScg==
X-Received: by 10.68.166.196 with SMTP id zi4mr71143819pbb.83.1439419844278;
        Wed, 12 Aug 2015 15:50:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id fv5sm190144pdb.19.2015.08.12.15.50.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 15:50:43 -0700 (PDT)
X-master-at: 130be8eeb8b9b7c89751c3cab3bc54dc6f2d43e6
X-next-at: dc45ae627aaa61b73b573b0f51469393f122b5f6
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275826>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The second batch of topics have graduated to 'master'.  Most
notably, the rewritten "git am" is in.  Also "worktree add" is
getting improved.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ad/bisect-cleanup (2015-08-03) 6 commits
  (merged to 'next' on 2015-08-03 at 13b9314)
 + bisect: don't mix option parsing and non-trivial code
 + bisect: simplify the addition of new bisect terms
 + bisect: replace hardcoded "bad|good" by variables
 + Documentation/bisect: revise overall content
 + Documentation/bisect: move getting help section to the end
 + bisect: correction of typo
 (this branch is used by ad/bisect-terms.)

 Originally merged to 'next' on 2015-07-09

 Code and documentation clean-up to "git bisect".


* dt/reflog-tests (2015-07-28) 2 commits
  (merged to 'next' on 2015-08-03 at 9d2fa1a)
 + tests: remove some direct access to .git/logs
 + t/t7509: remove unnecessary manipulation of reflog

 Tests that assume how reflogs are represented on the filesystem too
 much have been corrected.


* dt/unpack-trees-cache-tree-revalidate (2015-07-28) 1 commit
  (merged to 'next' on 2015-08-03 at 5b0d620)
 + unpack-trees: populate cache-tree on successful merge

 The code to perform multi-tree merges has been taught to repopulate
 the cache-tree upon a successful merge into the index, so that
 subsequent "diff-index --cached" (hence "status") and "write-tree"
 (hence "commit") will go faster.

 The same logic in "git checkout" may now be removed, but that is a
 separate issue.


* es/worktree-add (2015-07-20) 5 commits
  (merged to 'next' on 2015-08-03 at 9771a44)
 + config: rename "gc.pruneWorktreesExpire" to "gc.worktreePruneExpire"
 + Documentation/git-worktree: wordsmith worktree-related manpages
 + Documentation/config: fix stale "git prune --worktree" reference
 + Documentation/git-worktree: fix incorrect reference to file "locked"
 + Documentation/git-worktree: consistently use term "linked working tree"
 (this branch is used by dt/notes-multiple and es/worktree-add-cleanup.)

 Originally merged to 'next' on 2015-07-20

 Remove remaining cruft from  "git checkout --to", which
 transitioned to "git worktree add".


* es/worktree-add-cleanup (2015-08-05) 25 commits
  (merged to 'next' on 2015-08-12 at 9168b42)
 + Documentation/git-worktree: fix duplicated 'from'
 + Documentation/config: mention "now" and "never" for 'expire' settings
 + Documentation/git-worktree: fix broken 'linkgit' invocation
 + checkout: drop intimate knowledge of newly created worktree
 + worktree: populate via "git reset --hard" rather than "git checkout"
 + worktree: avoid resolving HEAD unnecessarily
 + worktree: make setup of new HEAD distinct from worktree population
 + worktree: detect branch-name/detached and error conditions locally
 + worktree: add_worktree: construct worktree-population command locally
 + worktree: elucidate environment variables intended for child processes
 + worktree: make branch creation distinct from worktree population
 + worktree: add: suppress auto-vivication with --detach and no <branch>
 + worktree: make --detach mutually exclusive with -b/-B
 + worktree: introduce options container
 + worktree: simplify new branch (-b/-B) option checking
 + worktree: improve worktree setup message
 + branch: publish die_if_checked_out()
 + checkout: teach check_linked_checkout() about symbolic link HEAD
 + checkout: check_linked_checkout: simplify symref parsing
 + checkout: check_linked_checkout: improve "already checked out" aesthetic
 + checkout: generalize die_if_checked_out() branch name argument
 + checkout: die_if_checked_out: simplify strbuf management
 + checkout: improve die_if_checked_out() robustness
 + checkout: name check_linked_checkouts() more meaningfully
 + checkout: avoid resolving HEAD unnecessarily
 (this branch is used by dt/notes-multiple; uses es/worktree-add.)

 Originally merged to 'next' on 2015-07-29

 The "new-worktree-mode" hack in "checkout" that was added in
 nd/multiple-work-trees topic has been removed by updating the
 implementation of new "worktree add".


* pt/am-builtin (2015-08-04) 46 commits
  (merged to 'next' on 2015-08-12 at 10d0c56)
 + git-am: add am.threeWay config variable
 + builtin-am: remove redirection to git-am.sh
 + builtin-am: check for valid committer ident
 + builtin-am: implement legacy -b/--binary option
 + builtin-am: implement -i/--interactive
 + builtin-am: support and auto-detect mercurial patches
 + builtin-am: support and auto-detect StGit series files
 + builtin-am: support and auto-detect StGit patches
 + builtin-am: rerere support
 + builtin-am: invoke post-applypatch hook
 + builtin-am: invoke pre-applypatch hook
 + builtin-am: invoke applypatch-msg hook
 + builtin-am: support automatic notes copying
 + builtin-am: invoke post-rewrite hook
 + builtin-am: implement -S/--gpg-sign, commit.gpgsign
 + builtin-am: implement --committer-date-is-author-date
 + builtin-am: implement --ignore-date
 + builtin-am: pass git-apply's options to git-apply
 + builtin-am: implement --[no-]scissors
 + builtin-am: support --keep-cr, am.keepcr
 + builtin-am: implement --[no-]message-id, am.messageid
 + builtin-am: implement -k/--keep, --keep-non-patch
 + builtin-am: implement -u/--utf8
 + builtin-am: handle stray state directory
 + builtin-am: bypass git-mailinfo when --rebasing
 + builtin-am: implement --rebasing mode
 + builtin-am: implement --3way
 + cache-tree: introduce write_index_as_tree()
 + builtin-am: implement -s/--signoff
 + builtin-am: exit with user friendly message on failure
 + builtin-am: implement -q/--quiet
 + builtin-am: reject patches when there's a session in progress
 + builtin-am: implement --abort
 + builtin-am: implement --skip
 + builtin-am: don't parse mail when resuming
 + builtin-am: implement --resolved/--continue
 + builtin-am: refuse to apply patches if index is dirty
 + builtin-am: implement committing applied patch
 + builtin-am: apply patch with git-apply
 + builtin-am: extract patch and commit info with git-mailinfo
 + builtin-am: auto-detect mbox patches
 + builtin-am: split out mbox/maildir patches with git-mailsplit
 + builtin-am: implement patch queue mechanism
 + builtin-am: implement skeletal builtin am
 + wrapper: implement xfopen()
 + wrapper: implement xopen()
 (this branch is used by pt/am-builtin-options.)

 Originally merged to 'next' on 2015-07-23

 Rewrite "am" in "C".


* sb/parse-options-codeformat (2015-07-29) 1 commit
  (merged to 'next' on 2015-08-03 at f81993b)
 + parse-options: align curly braces for all options


* sb/remove-unused-var-from-builtin-add (2015-07-31) 1 commit
  (merged to 'next' on 2015-08-03 at f5e568e)
 + add: remove dead code

--------------------------------------------------
[New Topics]

* bb/remote-get-url (2015-08-05) 1 commit
 - remote: add get-url subcommand

 "git remote" learned "get-url" subcommand to show the URL for a
 given remote name used for fetching and pushing.

 Waiting for a reroll.
 ($gmane/275401)


* cb/open-noatime-clear-errno (2015-08-12) 1 commit
 - git_open_noatime: return with errno=0 on success

 When trying to see that an object does not exist, a state errno
 leaked from our "first try to open a packfile with O_NOATIME and
 then if it fails retry without it" logic on a system that refuses
 O_NOATIME.  This confused us and caused us to die, saying that the
 packfile is unreadable, when we should have just reported that the
 object does not exist in that packfile to the caller.

 Will merge to 'next'.


* jk/guess-repo-name-regression-fix (2015-08-10) 2 commits
  (merged to 'next' on 2015-08-12 at 4cba33c)
 + clone: use computed length in guess_dir_name
 + clone: add tests for output directory
 (this branch is used by ps/guess-repo-name-at-root.)

 "git clone $URL" in recent releases of Git contains a regression in
 the code that invents a new repository name incorrectly based on
 the $URL.  This has been corrected.

 Will merge to 'master'.


* ps/guess-repo-name-at-root (2015-08-10) 3 commits
  (merged to 'next' on 2015-08-12 at 088860f)
 + clone: abort if no dir name could be guessed
 + clone: do not use port number as dir name
 + clone: do not include authentication data in guessed dir
 (this branch uses jk/guess-repo-name-regression-fix.)

 "git clone $URL", when cloning from a site whose sole purpose is to
 host a single repository (hence, no path after <scheme>://<site>/),
 tried to use the site name as the new repository name, but did not
 remove username or password when <site> part was of the form
 <user>@<pass>:<host>.  The code is taught to redact these.

 Will merge to 'master'.


* jk/notes-merge-config (2015-08-05) 4 commits
 - SQUASH???
 - notes: add notes.merge option to select default strategy
 - notes: add tests for --commit/--abort/--strategy exclusivity
 - notes: document cat_sort_uniq rewriteMode

 "git notes merge" can be told with "--strategy=<how>" option how to
 automatically handle conflicts; this can now be configured by
 setting notes.merge configuration variable.

 The last step to add more specific notes.$ref.merge looked
 questionable.  What is queued is v3, v4 exists, but needs an
 update.

 Waiting for a reroll.
 ($gmane/275749)


* mk/submodule-gitdir-path (2015-08-05) 2 commits
 - path: implement common_dir handling in git_path_submodule()
 - submodule refactor: use git_path_submodule() in add_submodule_odb()

 The submodule code has been taught to work better with separate
 work trees created via "git worktree add".

 Waiting for a review.
 ($gmane/275340).


* mm/pull-upload-pack (2015-07-30) 1 commit
  (merged to 'next' on 2015-08-12 at 14d2a52)
 + pull.sh: quote $upload_pack when passing it to git-fetch

 "git pull" in recent releases of Git has a regression in the code
 that allows custom path to the --upload-pack=<program>.  This has
 been corrected.

 Will merge to 'maint'.

 Note that this is irrelevant for 'master' with "git pull" rewritten
 in C.


* ps/t1509-chroot-test-fixup (2015-08-05) 2 commits
  (merged to 'next' on 2015-08-12 at 6d10ea5)
 + tests: fix cleanup after tests in t1509-root-worktree
 + tests: fix broken && chains in t1509-root-worktree

 t1509 test that requires a dedicated VM environment had some
 bitrot, which has been corrected.

 Will merge to 'master'.


* pt/am-builtin-options (2015-08-12) 3 commits
  (merged to 'next' on 2015-08-12 at e57f754)
 + am: let --signoff override --no-signoff
 + am: let command-line options override saved options
 + test_terminal: redirect child process' stdin to a pty

 After "git am --opt1" stops, running "git am --opt2" pays attention
 to "--opt2" only for the patch that caused the original invocation
 to stop.

 Will merge to 'master'.


* sb/remove-get-pathspec (2015-08-03) 1 commit
 - builtin/mv: remove get_pathspec()

 Expecting a reroll.
 ($gmane/275224)


* sb/submodule-helper (2015-08-07) 1 commit
 - submodule: implement `module_list` as a builtin helper

 The beginning of "git submodule" rewritten in C.


* tb/complete-rebase-i-edit-todo (2015-08-05) 1 commit
  (merged to 'next' on 2015-08-12 at 9606c21)
 + completion: offer '--edit-todo' during interactive rebase

 The command-line completion script (in contrib/) has been updated.

 Will merge to 'master'.


* dt/untracked-subdir (2015-08-07) 2 commits
 - DONTMERGE: wait for Duy to Ack or comment
 - untracked-cache: fix subdirectory handling
 (this branch uses dt/untracked-sparse.)

 Waiting for a review.


* jk/test-with-x (2015-08-07) 2 commits
  (merged to 'next' on 2015-08-12 at 06576a1)
 + test-lib: disable trace when test is not verbose
 + test-lib: turn off "-x" tracing during chain-lint check

 Running tests with the "-x" option to make them verbose had some
 unpleasant interactions with other features of the test suite.

 Will merge to 'master'.


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* bc/connect-plink (2015-08-11) 1 commit
 - t5601-clone: remove broken and pointless check for plink.exe

 Test updates for Windows.

 Seems controversial.
 Will hold.
 for now ($gmane/275758).


* ee/clean-remove-dirs (2015-08-11) 1 commit
  (merged to 'next' on 2015-08-12 at fc41b09)
 + t7300-clean: require POSIXPERM for chmod 0 test

 Test updates for Windows.

 Will merge to 'master'.


* jc/finalize-temp-file (2015-08-10) 1 commit
  (merged to 'next' on 2015-08-12 at 6fe62fe)
 + sha1_file.c: rename move_temp_to_file() to finalize_object_file()

 Long overdue micro clean-up.

 Will merge to 'master'.


* jk/git-path (2015-08-10) 16 commits
  (merged to 'next' on 2015-08-12 at 7ebe864)
 + memoize common git-path "constant" files
 + get_repo_path: refactor path-allocation
 + find_hook: keep our own static buffer
 + refs.c: remove_empty_directories can take a strbuf
 + refs.c: avoid git_path assignment in lock_ref_sha1_basic
 + refs.c: avoid repeated git_path calls in rename_tmp_log
 + refs.c: simplify strbufs in reflog setup and writing
 + path.c: drop git_path_submodule
 + refs.c: remove extra git_path calls from read_loose_refs
 + remote.c: drop extraneous local variable from migrate_file
 + prefer mkpathdup to mkpath in assignments
 + prefer git_pathdup to git_path in some possibly-dangerous cases
 + add_to_alternates_file: don't add duplicate entries
 + t5700: modernize style
 + cache.h: complete set of git_path_submodule helpers
 + cache.h: clarify documentation for git_path, et al

 git_path() and mkpath() are handy helper functions but it is easy
 to misuse, as the callers need to be careful to keep the number of
 active results below 4.  Their uses have been reduced.

 Will merge to 'master'.


* jk/long-error-messages (2015-08-11) 2 commits
  (merged to 'next' on 2015-08-12 at 36303cd)
 + vreportf: avoid intermediate buffer
 + vreportf: report to arbitrary filehandles

 The codepath to produce error messages had a hard-coded limit to
 the size of the message, primarily to avoid memory allocation while
 calling die().

 Will merge to 'master'.


* nd/dwim-wildcards-as-pathspecs (2015-08-11) 1 commit
  (merged to 'next' on 2015-08-12 at bb73f4d)
 + t2019: skip test requiring '*' in a file name non Windows

 Test updates for Windows.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* nd/list-files (2015-02-09) 21 commits
 - t3080: tests for git-list-files
 - list-files: -M aka diff-cached
 - list-files -F: show submodules with the new indicator '&'
 - list-files: add -F/--classify
 - list-files: show directories as well as files
 - list-files: do not show duplicate cached entries
 - list-files: sort output and remove duplicates
 - list-files: add -t back
 - list-files: add -1 short for --no-column
 - list-files: add -R/--recursive short for --max-depth=-1
 - list-files: -u does not imply showing stages
 - list-files: make alias 'ls' default to 'list-files'
 - list-files: a user friendly version of ls-files and more
 - ls-files: support --max-depth
 - ls-files: add --column
 - ls-files: add --color to highlight file names
 - ls-files: buffer full item in strbuf before printing
 - ls_colors.c: highlight submodules like directories
 - ls_colors.c: add a function to color a file name
 - ls_colors.c: parse color.ls.* from config file
 - ls_colors.c: add $LS_COLORS parsing code

 A new "git list-files" Porcelain command, "ls-files" with bells and
 whistles.

 Reroll to base on wt-status work ($gmane/265142) has seen some
 positive discussions.

 Waiting for a further polished reroll ($gmane/265534).


* mh/numparse (2015-03-19) 14 commits
 . diff_opt_parse(): use convert_i() when handling --abbrev=<num>
 . diff_opt_parse(): use convert_i() when handling "-l<num>"
 . opt_arg(): simplify pointer handling
 . opt_arg(): report errors parsing option values
 . opt_arg(): use convert_i() in implementation
 . opt_arg(): val is always non-NULL
 . builtin_diff(): detect errors when parsing --unified argument
 . handle_revision_opt(): use convert_ui() when handling "--abbrev="
 . strtoul_ui(), strtol_i(): remove functions
 . handle_revision_opt(): use convert_i() when handling "-<digit>"
 . handle_revision_opt(): use skip_prefix() in many places
 . write_subdirectory(): use convert_ui() for parsing mode
 . cacheinfo_callback(): use convert_ui() when handling "--cacheinfo"
 . numparse: new module for parsing integral numbers

 Many codepaths use unchecked use of strtol() and friends (or even
 worse, atoi()).  Introduce a set of wrappers that try to be more
 careful.

 Expecting a reroll.
 ($gmane/268058).


* kk/log-merges-config (2015-04-21) 5 commits
 - bash-completion: add support for git-log --merges= and log.merges
 - t4202-log: add tests for --merges=
 - Documentation: add git-log --merges= option and log.merges config. var
 - log: honor log.merges= option
 - revision: add --merges={show|only|hide} option

 "git log" (but not other commands in the "log" family) learned to
 pay attention to the log.merges configuration variable that can be
 set to "show" (the normal behaviour), "only" (hide non-merge
 commits), or "hide" (hide merge commits).  --merges=(show|only|hide)
 can be used to override the setting from the command line.

 The documentation may need to be updated once more ($gmane/267250).
 Waiting for a reroll.


* mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
 - t/lib-git-svn: check same httpd module dirs as lib-httpd
 - t/lib-httpd: load mod_unixd

 This is the first two commits in a three-patch series $gmane/266962

 Expecting a reroll.
 with updated log message ($gmane/268061).


* bw/portability-solaris (2015-07-20) 3 commits
 - tests: fix sed usage in tests to work around broken xpg4/sed on Solaris
 - tests: fix sed usage in tests to work around broken xpg4/sed on Solaris
 - tests: modify tr expressions so that xpg4/tr handles it on Solaris

 Needs another reroll?
 ($gmane/274296)


* jc/clone-bundle (2015-04-30) 1 commit
 - repack: optionally create a clone.bundle

 Waiting for further work.
 Still an early WIP.


* mg/index-read-error-messages (2015-06-01) 2 commits
 - messages: uniform error messages for index write
 - show-index: uniform error messages for index read

 The tip was RFC.
 Expecting a reroll.


* hv/submodule-config (2015-06-15) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config API for lookup of .gitmodules values

 The gitmodules API accessed from the C code learned to cache stuff
 lazily.

 Needs another reroll?
 ($gmane/273743)


* jk/log-missing-default-HEAD (2015-06-03) 1 commit
 - log: diagnose empty HEAD more clearly

 "git init empty && git -C empty log" said "bad default revision 'HEAD'",
 which was found to be a bit confusing to new users.

 What's the status of this one?


* wp/sha1-name-negative-match (2015-06-08) 2 commits
 - sha1_name.c: introduce '^{/!-<negative pattern>}' notation
 - test for '!' handling in rev-parse's named commits

 Introduce "branch^{/!-<pattern>}" notation to name a commit
 reachable from branch that does not match the given pattern.

 Expecting a reroll.


* mk/utf8-no-iconv-warn (2015-06-08) 1 commit
 - utf8.c: print warning about disabled iconv

 Warn when a reencoding is requested in a build without iconv
 support, as the end user is likely to get an unexpected result.  I
 think the same level of safety should be added to a build with
 iconv support when the specified encoding is not available, but the
 patch does not go there.

 Expecting a reroll.


* ak/format-patch-odir-config (2015-06-19) 1 commit
 - format-patch: introduce format.outputDirectory configuration

 Reroll exists but didn't pick it up as it seemed to be still
 collecting review comments.

 Expecting a reroll.
 ($gmane/272180).


* ad/bisect-terms (2015-08-03) 4 commits
 - bisect: allow setting any user-specified in 'git bisect start'
 - bisect: add 'git bisect terms' to view the current terms
 - bisect: add the terms old/new
 - bisect: sanity check on terms

 The use of 'good/bad' in "git bisect" made it confusing to use when
 hunting for a state change that is not a regression (e.g. bugfix).
 The command learned 'old/new' and then allows the end user to
 say e.g. "bisect start --term-old=fast --term=new=slow" to find a
 performance regression.

 Michael's idea to make 'good/bad' more intelligent does have
 certain attractiveness ($gname/272867), and makes some of the work
 on this topic a moot point.

 Will hold.


* mh/notes-allow-reading-treeish (2015-07-13) 1 commit
 - notes: allow treeish expressions as notes ref

 Some "git notes" operations, e.g. "git log --notes=<note>", should
 be able to read notes from any tree-ish that is shaped like a notes
 tree, but the notes infrastructure required that the argument must
 be a ref under refs/notes/.  Loosen it to require a valid ref only
 when the operation would update the notes (in which case we must
 have a place to store the updated notes tree, iow, a ref).

 Needs update to docs.
 ($gmane/273928)


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.


* pw/remote-set-url-fetch (2014-11-26) 1 commit
 . remote: add --fetch and --both options to set-url

 Ejected.


* tr/remerge-diff (2014-11-10) 9 commits
 - t4213: avoid "|" in sed regexp
 - log --remerge-diff: show what the conflict resolution changed
 - name-hash: allow dir hashing even when !ignore_case
 - merge-recursive: allow storing conflict hunks in index
 - merge_diff_mode: fold all merge diff variants into an enum
 - combine-diff: do not pass revs->dense_combined_merges redundantly
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Waiting for a reroll.
 ($gmane/256591).


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/show-branch (2014-03-24) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit.

--------------------------------------------------
[Cooking]

* sg/config-name-only (2015-08-10) 2 commits
  (merged to 'next' on 2015-08-12 at c658fe4)
 + completion: list variable names reliably with 'git config --name-only'
 + config: add '--name-only' option to list only variable names

 "git config --list" output was hard to parse when values consist of
 multiple lines.  "--name-only" option is added to help this.

 Will merge to 'master'.


* mh/tempfile (2015-08-12) 16 commits
  (merged to 'next' on 2015-08-12 at 80efcb7)
 + credential-cache--daemon: use tempfile module
 + credential-cache--daemon: delete socket from main()
 + gc: use tempfile module to handle gc.pid file
 + lock_repo_for_gc(): compute the path to "gc.pid" only once
 + diff: use tempfile module
 + setup_temporary_shallow(): use tempfile module
 + write_shared_index(): use tempfile module
 + register_tempfile(): new function to handle an existing temporary file
 + tempfile: add several functions for creating temporary files
 + prepare_tempfile_object(): new function, extracted from create_tempfile()
 + tempfile: a new module for handling temporary files
 + commit_lock_file(): use get_locked_file_path()
 + lockfile: add accessor get_lock_file_path()
 + lockfile: add accessors get_lock_file_fd() and get_lock_file_fp()
 + create_bundle(): duplicate file descriptor to avoid closing it twice
 + lockfile: move documentation to lockfile.h and lockfile.c

 The "lockfile" API has been rebuilt on top of a new "tempfile" API.

 Will merge to 'master'.


* jh/strbuf-read-use-read-in-full (2015-08-10) 1 commit
  (merged to 'next' on 2015-08-12 at db16247)
 + strbuf_read(): skip unnecessary strbuf_grow() at eof

 strbuf_read() used to have one extra iteration (and an unnecessary
 strbuf_grow() of 8kB), which was eliminated.

 Will merge to 'master'.


* sb/check-return-from-read-ref (2015-08-03) 1 commit
  (merged to 'next' on 2015-08-12 at 4a1c801)
 + transport-helper: die on errors reading refs.

 Will merge to 'master'.


* jk/negative-hiderefs (2015-08-07) 2 commits
  (merged to 'next' on 2015-08-12 at bdc478d)
 + refs: support negative transfer.hideRefs
 + docs/config.txt: reorder hideRefs config

 A negative !ref entry in multi-value transfer.hideRefs
 configuration can be used to say "don't hide this one".

 Will merge to 'master'.


* mh/get-remote-group-fix (2015-07-28) 4 commits
  (merged to 'next' on 2015-08-12 at b77820e)
 + get_remote_group(): use skip_prefix()
 + get_remote_group(): eliminate superfluous call to strcspn()
 + get_remote_group(): rename local variable "space" to "wordlen"
 + get_remote_group(): handle remotes with single-character names

 An off-by-one error made "git remote" to mishandle a remote with a
 single letter nickname.

 Will merge to 'master'.


* ta/docfix-index-format-tech (2015-07-28) 1 commit
  (merged to 'next' on 2015-08-12 at 662d88a)
 + typofix for index-format.txt

 Will merge to 'master'.


* dt/notes-multiple (2015-08-11) 2 commits
  (merged to 'next' on 2015-08-12 at 0052055)
 + notes: handle multiple worktrees
 + worktrees: add find_shared_symref

 When linked worktree is used, simultaneous "notes merge" instances
 for the same ref in refs/notes/* are prevented from stomping on
 each other.

 Will merge to 'master'.


* dt/refs-pseudo (2015-08-11) 6 commits
  (merged to 'next' on 2015-08-12 at 7078eb6)
 + pseudoref: check return values from read_ref()
  (merged to 'next' on 2015-08-03 at 3eafd33)
 + sequencer: replace write_cherry_pick_head with update_ref
 + bisect: use update_ref
 + pseudorefs: create and use pseudoref update and delete functions
 + refs: add ref_type function
 + refs: introduce pseudoref and per-worktree ref concepts

 To prepare for allowing a different "ref" backend to be plugged in
 to the system, update_ref()/delete_ref() have been taught about
 ref-like things like MERGE_HEAD that are per-worktree (they will
 always be written to the filesystem inside $GIT_DIR).

 Will merge to 'master'.


* dt/untracked-sparse (2015-07-31) 1 commit
  (merged to 'next' on 2015-08-12 at 234434d)
 + untracked-cache: support sparse checkout
 (this branch is used by dt/untracked-subdir.)

 Allow untracked cache (experimental) to be used when sparse
 checkout (experimental) is also in use.

 Will merge to 'master'.


* kd/pull-rebase-autostash (2015-07-22) 1 commit
  (merged to 'next' on 2015-08-12 at de88e8e)
 + pull: allow dirty tree when rebase.autostash enabled

 "git pull --rebase" has been taught to pay attention to
 rebase.autostash configuration.

 Will merge to 'master'.


* kn/for-each-tag-branch (2015-08-03) 11 commits
  (merged to 'next' on 2015-08-03 at d9e94b9)
 + for-each-ref: add '--contains' option
 + ref-filter: implement '--contains' option
 + parse-options.h: add macros for '--contains' option
 + parse-option: rename parse_opt_with_commit()
 + for-each-ref: add '--merged' and '--no-merged' options
 + ref-filter: implement '--merged' and '--no-merged' options
 + ref-filter: add parse_opt_merge_filter()
 + for-each-ref: add '--points-at' option
 + ref-filter: implement '--points-at' option
 + tag: libify parse_opt_points_at()
 + t6302: for-each-ref tests for ref-filter APIs

 Originally merged to 'next' on 2015-07-15

 Some features from "git tag -l" and "git branch -l" have been made
 available to "git for-each-ref" so that eventually the unified
 implementation can be shared across all three, in a follow-up
 series or two.


* jc/rerere (2015-07-30) 21 commits
 - rerere: un-nest merge() further
 - rerere: use "struct rerere_id" instead of "char *" for conflict ID
 - rerere: call conflict-ids IDs
 - rerere: further clarify do_rerere_one_path()
 - rerere: further de-dent do_plain_rerere()
 - rerere: refactor "replay" part of do_plain_rerere()
 - rerere: explain the remainder
 - rerere: explain "rerere forget" codepath
 - rerere: explain the primary codepath
 - rerere: explain MERGE_RR management helpers
 - rerere: fix benign off-by-one non-bug and clarify code
 - rerere: explain the rerere I/O abstraction
 - rerere: do not leak mmfile[] for a path with multiple stage #1 entries
 - rerere: stop looping unnecessarily
 - rerere: drop want_sp parameter from is_cmarker()
 - rerere: report autoupdated paths only after actually updating them
 - rerere: write out each record of MERGE_RR in one go
 - rerere: lift PATH_MAX limitation
 - rerere: plug conflict ID leaks
 - rerere: handle conflicts with multiple stage #1 entries
 - rerere: fix an off-by-one non-bug
 (this branch is used by jc/rerere-multi.)

 Code clean-up and minor fixes (so far).


* jc/rerere-multi (2015-07-31) 7 commits
 . t4200: rerere a merge with two identical conflicts
 . WIP
 . rerere: allow multiple variants to exist
 - rerere: delay the recording of preimage
 - rerere: handle leftover rr-cache/$ID directory and postimage files
 - rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
 - rerere: split conflict ID further
 (this branch uses jc/rerere.)

 This is a contination of jc/rerere topic.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2015-08-03 at a52c2b2)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Originally merged to 'next' on 2015-05-28

 Stop supporting "git merge <message> HEAD <commit>" syntax that
 has been deprecated since October 2007.

 Will keep in 'next' during the 2.6 cycle.

--------------------------------------------------
[Discarded]

* tf/gitweb-project-listing (2015-03-19) 4 commits
 - gitweb: make category headings into links when they are directories
 - gitweb: optionally set project category from its pathname
 - gitweb: add a link under the search box to clear a project filter
 - gitweb: if the PATH_INFO is incomplete, use it as a project_filter

 Update gitweb to make it more pleasant to deal with a hierarchical
 forest of repositories.

 A fresh restart will not be rejected, but ejected from my tree for
 now.


* jc/a-lone-dash-stands-for-previous-branch (2015-03-16) 1 commit
 - "-" and "@{-1}" on various programs

 Lose special case code to make a lone dash "-" mean the previous
 branch aka "@{-1}" from a handful subcommands, and instead support
 the notation throughout the system by reimplementing it at the
 revisions layer.

 Needs tests, documentation updates, etc.  Also does only a half-way
 job dealing with range notation, which needs to be fixed before the
 series goes anywhere.


* jc/push-tags-also (2015-05-29) 1 commit
 - push --tags: push tags *in addition to* other stuff

 "git fetch --tags" learned to fetch tags in addition to other stuff
 a few years ago, but "git push --tags" didn't.  Now it does.

 A change to push out more than before always invites "what if the
 user makes a mistake" worries.

 Will discard.


* nd/pathspec-strip-fix (2015-04-18) 1 commit
 - pathspec: adjust prefixlen after striping trailing slash

 Does not quite fix ($gmane/267614).
 Will discard.
