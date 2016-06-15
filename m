From: Junio C Hamano <junkio@cox.net>
Subject: An early draft of v1.5.0 release notes (2nd ed)
Date: Wed, 27 Dec 2006 17:45:01 -0800
Message-ID: <7vvejw3iaq.fsf@assigned-by-dhcp.cox.net>
References: <7vvejx948y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Dec 28 02:45:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzkKT-0003IS-EN
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 02:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWL1BpG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 20:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWL1BpF
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 20:45:05 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:39343 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964860AbWL1BpD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 20:45:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228014502.HKYT15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 20:45:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 41lF1W0161kojtg0000000; Wed, 27 Dec 2006 20:45:16 -0500
To: git@vger.kernel.org
In-Reply-To: <7vvejx948y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 26 Dec 2006 23:39:41 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35505>

This incorporates comments from the list (thanks).  Maybe I
should park this in 'todo' branch so that people can review the
updates more easily.

-- >8 --

Major changes that are not news
-------------------------------

There were a handful big changes that happened before this major
release.

This section is for people who are upgrading from ancient
versions.  Some of them are one-way street upgrades -- once you
use the feature your repository cannot be used with ancient git.

 - There is a new configuration variable core.legacyheaders that
   changes the format of loose objects to more efficient to pack
   and send out of the repository over git native protocol.
   However, this format cannot be read by git older than v1.4.2;
   people fetching from your repository using older clients over
   dumb transports (e.g. http) will also be affected.  This is
   not enabled by default.

 - Another configuration repack.usedeltabaseoffset further
   allows packfile to be created in more space efficient format,
   which cannot be read  by git older than v1.4.3.  This is not
   enabled by default.

 - 'git pack-refs' appeared in v1.4.4; this command allows tags
   to be accessed much more efficiently than the traditional
   'one-file-per-tag' format.  Older git-native client can fetch
   from a repository that packed its tags, but older dumb
   transports cannot.  This is done by an explicit user action,
   either by use of "git pack-refs --prune" command or by use of
   "git gc" command.

 - 'git -p' to paginate anything -- many commands do pagination
   by default on a tty.  Introduced between v1.4.1 and v1.4.2;
   this may surprise old timer users.

 - 'git archive' superseded 'git tar' in v1.4.3;

 - 'git cvsserver' was new invention in v1.3.0;

 - 'git repo-config', 'git grep', 'git rebase' and 'gitk' were
   seriously enhanced during v1.4.0 timeperiod.

 - 'gitweb' became part of git.git during v1.4.0 timeperiod and
   seriously modified since then.

 - reflog is an v1.4.0 invention.


Updates in v1.5.0 since v1.4.4 series
-------------------------------------

* Index manipulation

 - git-add is to add contents to the index (aka "staging area"
   for the next commit), whether the file the contents happen to
   be is an existing one or a newly created one.

 - git-add without any argument does not add everything
   anymore.  Use 'git-add .' instead.  Also you can add
   otherwise ignored files with an -f option.

 - git-add tries to be more friendly to users by offering an
   interactive mode.

 - git-commit <path> used to refuse to commit if <path> was
   different between HEAD and the index (i.e. update-index was
   used on it earlier).  This check was removed.

 - git-rm is much saner and safer.  It is used to remove paths
   from both the index file and the working tree, and makes sure
   you are not losing any local modification before doing so.

 - git-reset <tree> <paths>... can be used to revert index
   entries for selected paths.

 - git-update-index is much less visible.


* Repository layout and objects transfer

 - The data for origin repository is stored in the configuration
   file $GIT_DIR/config, not in $GIT_DIR/remotes/, for newly
   created clones (the latter is still supported).

 - git-clone always uses what is known as "separate remote"
   layout for a newly created repository with a working tree;
   i.e. tracking branches in $GIT_DIR/refs/remotes/origin/ are
   used to track branches from the origin.  New branches that
   appear on the origin side after a clone is made are also
   tracked automatically.

 - git-branch and git-show-branch know remote tracking branches.

 - git-push can now be used to delete a remote branch or a tag.
   This requires the updated git on the remote side.

 - git-push more agressively keeps the transferred objects
   packed.  Earlier we recommended to monitor amount of loose
   objects and repack regularly, but you should repack when you
   accumulated too many small packs this way as well.  Updated
   git-count-objects helps you with this.


* Reflog

 - Reflog records the history of where the tip of each branch
   was at each moment.  This facility is enabled by default for
   repositories with working trees, and can be accessed with the
   "branch@{time}" and "branch@{Nth}" notation.

 - "git show-branch" learned showing the reflog data with the
   new --reflog option.

 - The commits referred to by reflog entries are now protected
   against pruning.  The new command "git reflog expire" can be
   used to truncate older reflog entries and entries that refer
   to commits that have been pruned away previously with older
   versions of git.

   Existing repositories that have been using reflog may get
   complaints from fsck-objects; please run "git reflog expire
   --all" first to remove reflog entries that refer to commits
   that are no longer in the repository before attempting to
   repack it.

 - git-branch knows how to rename branches and moves existing
   reflog data from the old branch to the new one.


* Packed refs

 - Repositories with hundreds of tags have been paying large
   overhead, both in storage and in runtime.  A new command,
   git-pack-refs, can be used to "pack" them in more efficient
   representation.

 - Clones and fetches over dumb transports are now aware of
   packed refs and can download from repositories that use
   them.


* Configuration

 - configuration related to colorize setting are consolidated
   under color.* namespace (older diff.color.*, status.color.*
   are still supported).


* Less external dependency

 - We no longer require the "merge" program from the RCS suite.
   All 3-way file-level merges are now done internally.

 - The original implementation of git-merge-recursive which was
   in Python has been removed; we have C implementation of it
   now.

 - git-shortlog is no longer a Perl script.  It no longer
   requires output piped from git-log; it can accept revision
   parameters directly on the command line.


* I18n

 - We have always encouraged the commit message to be encoded in
   UTF-8, but the users are allowed to use legacy encoding as
   appropriate for their projects.  This will continue to be the
   case.  However, a non UTF-8 commit encoding _must_ be
   explicitly set with i18n.commitencoding in the repository
   where a commit is made; otherwise git-commit-tree will
   complain if the log message does not look like a valid UTF-8
   string.

 - The value of i18n.commitencoding in the originating
   repository is recorded in the commit object on the "encoding"
   header, if it is not UTF-8.  git-log and friends notice this,
   and reencodes the message to the log output encoding when
   displaying, if they are different.  The log output encoding
   is determined by "git log --encoding=<encoding>",
   i18n.logoutputencoding configuration, or i18n.commitencoding
   configuration, in the decreasing order of preference, and
   defaults to UTF-8. 


* User support

 - Quite a lot of documentation updates.

 - Bash completion scripts have been updated heavily.

 - Better error messages for often used Porcelainish commands.
