From: Junio C Hamano <gitster@pobox.com>
Subject: Draft release notes for 1.5.4 as of -rc1
Date: Wed, 19 Dec 2007 18:58:47 -0800
Message-ID: <7vhciers0o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 03:59:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5BdH-0003nW-Qm
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 03:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbXLTC7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 21:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbXLTC7B
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 21:59:01 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbXLTC7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 21:59:00 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F316A84B8;
	Wed, 19 Dec 2007 21:58:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DDF6849D;
	Wed, 19 Dec 2007 21:58:50 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68966>

This one is as of v1.5.4-rc1 which I tagged tonight.  It hints that a
set of big change is coming in 1.6.0 without saying if there will be
1.5.5 before that, nor committing to the schedule for 1.6.0 firmly.

Much of the text is unchanged since -rc0 as recent changes to 'master'
have mostly been fixes to regression introduced since 1.5.3.  We did not
describe that we introduced regression on purpose, so it is confusing if
we described the regression fixes.

GIT v1.5.4 Release Notes
========================

Removal
-------

 * "git svnimport" was removed in favor of "git svn".  It is still there
   in the source tree (contrib/examples) but unsupported.

 * As git-commit and git-status have been rewritten, "git runstatus"
   helper script lost all its users and has been removed.


Deprecation notices
-------------------

 * Next feature release of git (this change is scheduled for v1.6.0)
   will by default install dashed form of commands (e.g. "git-commit")
   outside of users' normal $PATH, and will install only selected
   commands ("git" itself, and "gitk") in $PATH.  This implies:

   - Using dashed form of git commands (e.g. "git-commit") from the
     command line has been informally deprecated since early 2006, but
     now it officially is, and will be removed in the future.  Use
     dashless form (e.g. "git commit") instead.

   - Using dashed from from your scripts, without first prepending the
     return value from "git --exec-path" to the scripts' PATH, has been
     informally deprecated since early 2006, but now it officially is.

   - Use of dashed form with "PATH=$(git --exec-path):$PATH; export
     PATH" early in your script is not deprecated with this change.

  Users are strongly encouraged to adjust their habits and scripts now
  to prepare for this.

 * The post-receive hook was introduced in March 2007 to supersede
   post-update hook, primarily to overcome the command line length
   limitation of the latter.  Use of post-update hook will be deprecated
   in future versions of git, starting from v1.6.0.

 * "git lost-found" was deprecated in favor of "git fsck"'s --lost-found
   option, and will be removed in the future.

 * "git peek-remote" is deprecated, as "git ls-remote" was written in C
   and works for all transports, and will be removed in the future.

 * From v1.6.0, the repack.usedeltabaseoffset config option will default
   to true, which will give denser packfile (i.e. more efficient storage).
   The downside is that git older than version 1.4.4 will not be able
   to directly use a repository packed using this setting.

 * From v1.6.0, the pack.indexversion config option will default to 2,
   which is slightly more efficient, and makes repacking more immune to
   data corruptions.  Git older than version 1.5.2 may revert to version 1
   of the pack index with a manual "git index-pack" to be able to directly
   access corresponding pack files.


Updates since v1.5.3
--------------------

 * Comes with much improved gitk.

 * Comes with "git gui" 0.9.1 with i18n.

 * gitk is now merged as a subdirectory of git.git project, in
   preparation for its i18n.

 * progress display from many commands are a lot nicer to the eye.
   Transfer commands show throughput data.

 * many commands that pay attention to per-directory .gitignore now do
   so lazily, which makes the usual case go much faster.

 * Output processing for '--pretty=format:<user format>' has been
   optimized.

 * Rename detection of diff family, while detecting exact matches, has
   been greatly optimized.

 * Rename detection of diff family tries to make more naturally looking
   pairing.  Earlier if more than one identical rename sources were
   found in the preimage, they were picked pretty much at random.

 * Value "true" for color.diff and color.status configuration used to
   mean "always" (even when the output is not going to a terminal).
   This has been corrected to mean the same thing as "auto".

 * "git diff" Porcelain now respects diff.external configuration, which
   is another way to specify GIT_EXTERNAL_DIFF.

 * HTTP proxy can be specified per remote repository using
   remote.*.httpproxy configuration, or global http.proxy configuration
   variable.

 * Various Perforce importer updates.

 * Example update and post-receive hooks have been improved.

 * Any command that wants to take a commit object name can now use
   ":/string" syntax to name a commit.

 * "git reset" is now built-in and its output can be squelched with -q.

 * "git send-email" can optionally talk over ssmtp and use SMTP-AUTH.

 * "git rebase" learned --whitespace option.

 * In "git rebase", when you decide not to replay a particular change
   after the command stopped with a conflict, you can say "git rebase
   --skip" without first running "git reset --hard", as the command now
   runs it for you.

 * "git rebase --interactive" mode can now work on detached HEAD.

 * Other minor to serious bugs in "git rebase -i" has been fixed.

 * "git rebase" now detaches head during its operation, so after a
   successful "git rebase" operation, the reflog entry branch@{1} for
   the current branch points at the commit before the rebase was
   started.

 * "git rebase -i" also triggers rerere to help your repeated merges.

 * "git merge" can call the "post-merge" hook.

 * "git pack-objects" can optionally run deltification with multiple
   threads.

 * "git archive" can optionally substitute keywords in files marked with
   export-subst attribute.

 * "git cherry-pick" made a misguided attempt to repeat the original
   command line in the generated log message, when told to cherry-pick a
   commit by naming a tag that points at it.  It does not anymore.

 * "git for-each-ref" learned %(xxxdate:<dateformat>) syntax to show the
   various date fields in different formats.

 * "git gc --auto" is a low-impact way to automatically run a variant of
   "git repack" that does not lose unreferenced objects (read: safer
   than the usual one) after the user accumulates too many loose
   objects.

 * "git clean" has been rewritten in C.

 * You need to explicitly set clean.requireForce to "false" to allow
   "git clean" without -f to do any damage (lack of the configuration
   variable used to mean "do not require -f option to lose untracked
   files", but we now use the safer default).

 * The kinds of whitespace errors "git diff" and "git apply" notice (and
   fix) can be controlled via 'core.whitespace' configuration variable
   and 'whitespace' attribute in .gitattributes file.

 * "git push" learned --dry-run option to show what would happen if a
   push is run.

 * "git push" does not update a tracking ref on the local side when the
   remote refused to update the corresponding ref.

 * "git push" learned --mirror option.  This is to push the local refs
   one-to-one to the remote, and deletes refs from the remote that do
   not exist anymore in the repository on the pushing side.

 * "git push" can remove a corrupt ref at the remote site with the usual
   ":ref" refspec.

 * "git remote" knows --mirror mode.  This is to set up configuration to
   push into a remote repository to store local branch heads to the same
   branch on the remote side, and remove branch heads locally removed
   from local repository at the same time.  Suitable for pushing into a
   back-up repository.

 * "git remote" learned "rm" subcommand.

 * "git cvsserver" can be run via "git shell".

 * "git cvsserver" acts more like receive-pack by running post-receive
   and post-update hooks.

 * "git am" and "git rebase" are far less verbose.

 * "git pull" learned to pass --[no-]ff option to underlying "git
   merge".

 * "git pull --rebase" is a different way to integrate what you fetched
   into your current branch.

 * "git fast-export" produces datastream that can be fed to fast-import
   to reproduce the history recorded in a git repository.

 * "git add -i" takes pathspecs to limit the set of files to work on.

 * "git add -p" is a short-hand to go directly to the selective patch
   subcommand in the interactive command loop and to exit when done.

 * "git add -i" UI has been colorized.

 * "git commit --allow-empty" allows you to create a single-parent
   commit that records the same tree as its parent, overriding the usual
   safety valve.

 * "git commit --amend" can amend a merge that does not change the tree
   from its first parent.

 * "git commit" has been rewritten in C.

 * "git stash random-text" does not create a new stash anymore.  It was
   a UI mistake.  Use "git stash save random-text", or "git stash"
   (without extra args) for that.

 * "git prune --expire <time>" can exempt young loose objects from
   getting pruned.

 * "git branch --contains <commit>" can list branches that are
   descendants of a given commit.

 * "git log" learned --early-output option to help interactive GUI
   implementations.

 * "git bisect" learned "skip" action to mark untestable commits.

 * "git bisect visualize" learned a shorter synonym "git bisect view".

 * "git bisect visualize" runs "git log" in a non-windowed
   environments.  It also can be told what command to run (e.g. "git
   bisect visualize tig").

 * "git format-patch" learned "format.numbered" configuration variable
   to automatically turn --numbered option on when more than one commits
   are formatted.

 * "git ls-files" learned "--exclude-standard" to use the canned set of
   exclude files.

 * "git tag -a -f existing" begins the editor session using the existing
   annotation message.

 * "git tag -m one -m bar" (multiple -m options) behaves similarly to
   "git commit"; the parameters to -m options are formatted as separate
   paragraphs.

 * The format "git show" outputs an annotated tag has been updated to
   include "Tagger: " and "Date: " lines from the tag itself.  Strictly
   speaking this is a backward incompatible change, but this is a
   reasonable usability fix and people's script shouldn't have been
   relying on the exact output from "git show" Porcelain anyway.

 * "git cvsexportcommit" learned -w option to specify and switch to the
   CVS working directory.

 * "git checkout" from a subdirectory learned to use "../path" to allow
   checking out a path outside the current directory without cd'ing up.

 * "git checkout" from and to detached HEAD leaves a bit more
   information in the reflog.

 * "git send-email --dry-run" shows full headers for easier diagnosis.

 * "git merge-ours" is now built-in.

 * "git svn" learned "info" and "show-externals" subcommands.

 * "git svn" run from a subdirectory failed to read settings from the
   .git/config.

 * "git svn" learned --use-log-author option, which picks up more
   descriptive name from From: and Signed-off-by: lines in the commit
   message.

 * "git svn" wasted way too much disk to record revision mappings
   between svn and git; a new representation that is much more compact
   for this information has been introduced to correct this.

 * "git svn" left temporary index files it used without cleaning them
   up; this was corrected.

 * "git status" from a subdirectory now shows relative paths, which
   makes copy-and-pasting for git-checkout/git-add/git-rm easier.  The
   traditional behaviour to show the full path relative to the top of
   the work tree can be had by setting status.relativepaths
   configuration variable to true.

 * "git blame" kept text for each annotated revision in core needlessly;
   this has been corrected.

 * "git shortlog" learned to default to HEAD when the standard input is
   a terminal and the user did not give any revision parameter.

 * "git shortlog" learned "-e" option to show e-mail addresses as well as
   authors' names.

 * "git help" learned "-w" option to show documentation in browsers.

 * In addition there are quite a few internal clean-ups. Notably

   - many fork/exec have been replaced with run-command API,
     brought from the msysgit effort.

   - introduction and more use of the option parser API.

   - enhancement and more use of the strbuf API.


Fixes since v1.5.3
------------------

All of the fixes in v1.5.3 maintenance series are included in
this release, unless otherwise noted.

These fixes are only in v1.5.4 and not backported to v1.5.3 maintenance
series.

 * The way "git diff --check" behaves is much more consistent with the way
   "git apply --whitespace=warn" works.

 * "git svn" talking with the SVN over http will correctly quote branch
   and project names.

 * "git config" did not work correctly on platforms that define
   REG_NOMATCH to an even number.
