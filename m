From: Junio C Hamano <junkio@cox.net>
Subject: Re: An early draft of v1.5.0 release notes (3rd ed)
Date: Tue, 09 Jan 2007 23:58:26 -0800
Message-ID: <7vsleje2jh.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vvejx948y.fsf@assigned-by-dhcp.cox.net>
	<7vvejw3iaq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 10 08:58:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4YLv-0004JX-L6
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 08:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbXAJH62 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 02:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932735AbXAJH62
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 02:58:28 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:45073 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932600AbXAJH61 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 02:58:27 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110075826.MAQN2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 02:58:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9Kxc1W0091kojtg0000000; Wed, 10 Jan 2007 02:57:36 -0500
To: git@vger.kernel.org
In-Reply-To: <7vvejw3iaq.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 27 Dec 2006 17:45:01 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36485>

Instead of sending the full text, I'll send out the diff against
the one I sent out on the 27th last month.

 Highlights:

 * Introductory notes have been reworded heavily;

 * I intend to merge bare repository support and detached HEAD
   before v1.5.0, so a section each for them has been added;

 * Sliding mmap and shallow clone are also mentioned.

The full text is available as v1.5.0.txt in 'todo' branch.

--
 v1.5.0.txt |  180 +++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 149 insertions(+), 31 deletions(-)

diff --git a/v1.5.0.txt b/v1.5.0.txt
index 671c14b..9bbe825 100644
--- a/v1.5.0.txt
+++ b/v1.5.0.txt
@@ -1,37 +1,54 @@
-Major changes that are not news
--------------------------------
+GIT v1.5.0 Release Notes
+========================
 
-There were a handful big changes that happened before this major
-release.
+Old news
+--------
 
 This section is for people who are upgrading from ancient
-versions.  Some of them are one-way street upgrades -- once you
-use the feature your repository cannot be used with ancient git.
-
- - There is a new configuration variable core.legacyheaders that
-   changes the format of loose objects to more efficient to pack
-   and send out of the repository over git native protocol.
-   However, this format cannot be read by git older than v1.4.2;
-   people fetching from your repository using older clients over
-   dumb transports (e.g. http) will also be affected.  This is
-   not enabled by default.
-
- - Another configuration repack.usedeltabaseoffset further
-   allows packfile to be created in more space efficient format,
-   which cannot be read  by git older than v1.4.3.  This is not
-   enabled by default.
+versions of git.  Although all of the changes in this section
+happened before the current v1.4.4 release, they are summarized
+here in the v1.5.0 release notes for people who skipped earlier
+versions.
+
+In general, you should not have to worry about incompatibility,
+and there is no need to perform "repository conversion" if you
+are updating to v1.5.0.  However, some of the changes are
+one-way street upgrades; once you use them your repository
+can no longer be used with ancient git.
+
+ - There is a configuration variable core.legacyheaders that
+   changes the format of loose objects so that they are more
+   efficient to pack and to send out of the repository over git
+   native protocol, since v1.4.2.  However, loose objects
+   written in the new format cannot be read by git older than
+   that version; people fetching from your repository using
+   older clients over dumb transports (e.g. http) using older
+   versions of git will also be affected.
+
+ - Since v1.4.3, configuration repack.usedeltabaseoffset allows
+   packfile to be created in more space efficient format, which
+   cannot be read by git older than that version.
+
+The above two are not enabled by default and you explicitly have
+to ask for them, because these two features make repositories
+unreadable by older versions of git, and in v1.5.0 we still do
+not enable them by default for the same reason.  We will change
+this default probably 1 year after 1.4.2's release, when it is
+reasonable to expect everybody to have new enough version of
+git.
 
  - 'git pack-refs' appeared in v1.4.4; this command allows tags
    to be accessed much more efficiently than the traditional
-   'one-file-per-tag' format.  Older git-native client can fetch
-   from a repository that packed its tags, but older dumb
-   transports cannot.  This is done by an explicit user action,
-   either by use of "git pack-refs --prune" command or by use of
-   "git gc" command.
+   'one-file-per-tag' format.  Older git-native clients can
+   still fetch from a repository that packed and pruned refs
+   (the server side needs to run the up-to-date version of git),
+   but older dumb transports cannot.  Packing of refs is done by
+   an explicit user action, either by use of "git pack-refs
+   --prune" command or by use of "git gc" command.
 
  - 'git -p' to paginate anything -- many commands do pagination
    by default on a tty.  Introduced between v1.4.1 and v1.4.2;
-   this may surprise old timer users.
+   this may surprise old timers.
 
  - 'git archive' superseded 'git tar' in v1.4.3;
 
@@ -43,7 +60,10 @@ use the feature your repository cannot be used with ancient git.
  - 'gitweb' became part of git.git during v1.4.0 timeperiod and
    seriously modified since then.
 
- - reflog is an v1.4.0 invention.
+ - reflog is an v1.4.0 invention.  This allows you to name a
+   revision that a branch used to be at (e.g. "git diff
+   master@{yesterday} master" allows you to see changes since
+   yesterday's tip of the branch).
 
 
 Updates in v1.5.0 since v1.4.4 series
@@ -80,7 +100,9 @@ Updates in v1.5.0 since v1.4.4 series
 
  - The data for origin repository is stored in the configuration
    file $GIT_DIR/config, not in $GIT_DIR/remotes/, for newly
-   created clones (the latter is still supported).
+   created clones.  The latter is still supported and there is
+   no need to convert your existing repository if you are
+   already comfortable with your workflow with the layout.
 
  - git-clone always uses what is known as "separate remote"
    layout for a newly created repository with a working tree;
@@ -100,6 +122,26 @@ Updates in v1.5.0 since v1.4.4 series
    accumulated too many small packs this way as well.  Updated
    git-count-objects helps you with this.
 
+ - A new command, git-remote, can help you manage your remote
+   tracking branch definitions.
+
+
+* Bare repositories
+
+ - Certain commands change their behaviour in a bare repository
+   (i.e. a repository without associated working tree).  We use
+   a fairly conservative heuristic (if $GIT_DIR is ".git", or
+   ends with "/.git", the repository is not bare) to decide if a
+   repository is bare, but "core.bare" configuration variable
+   can be used to override the heuristic when it misidentifies
+   your repository.
+
+ - git-fetch used to complain updating the current branch but
+   this is now allowed for a bare repository.
+
+ - NEEDSWORK: We should disable Porcelain-ish commands that
+   require a working tree in a bare repository.
+
 
 * Reflog
 
@@ -118,15 +160,42 @@ Updates in v1.5.0 since v1.4.4 series
    versions of git.
 
    Existing repositories that have been using reflog may get
-   complaints from fsck-objects; please run "git reflog expire
-   --all" first to remove reflog entries that refer to commits
-   that are no longer in the repository before attempting to
-   repack it.
+   complaints from fsck-objects and may not be able to run
+   git-repack; please run "git reflog expire --all" first to
+   remove reflog entries that refer to commits that are no
+   longer in the repository when that happens.
 
  - git-branch knows how to rename branches and moves existing
    reflog data from the old branch to the new one.
 
 
+* Detached HEAD
+
+ - You can give non-branch to "git checkout" now.  This will
+   dissociate your HEAD from any of your branches.  A typical
+   use of this feature is to "look around".  E.g.
+
+	$ git checkout v2.6.16
+	... compile, test, etc.
+	$ git checkout v2.6.17
+	... compile, test, etc.
+
+ - After detaching your HEAD, you can go back to an existing
+   branch with usual "git checkout $branch".  Also you can
+   start a new branch using "git checkout -b $newbranch".
+
+ - You can even pull from other repositories, make merges and
+   commits while your HEAD is detached.  Also you can use "git
+   reset" to jump to arbitrary commit.
+
+   Going back to undetached state by "git checkout $branch" can
+   lose the current stat you arrived in these ways, and "git
+   checkout" refuses when the detached HEAD is not pointed by
+   any existing ref (an existing branch, a remote tracking
+   branch or a tag).  This safety can be overriden with "git
+   checout -f".
+
+
 * Packed refs
 
  - Repositories with hundreds of tags have been paying large
@@ -181,6 +250,24 @@ Updates in v1.5.0 since v1.4.4 series
    configuration, in the decreasing order of preference, and
    defaults to UTF-8. 
 
+ - Tools for e-mailed patch application now default to -u
+   behaviour; i.e. it always re-codes from the e-mailed encoding
+   to the encoding specified with i18n.commitencoding.  This
+   unfortunately forces projects that have happily using a
+   legacy encoding without setting i18n.commitencoding, but
+   taken with other improvement, please excuse us for this very
+   minor one-time inconvenience.
+
+
+* Foreign SCM interfaces
+
+  - git-svn now requires the Perl SVN:: libraries, the
+    command-line backend was too slow and limited.
+
+  - the 'commit' subcommand of git-svn has been renamed to
+    'set-tree', and 'dcommit' is the recommended replacement for
+    day-to-day work.
+
 
 * User support
 
@@ -191,4 +278,35 @@ Updates in v1.5.0 since v1.4.4 series
  - Better error messages for often used Porcelainish commands.
 
 
+* Sliding mmap
+
+ - We used to assume that we can mmap the whole packfile while
+   in use, but with a large project this consumes huge virtual
+   memory space and truly huge ones would not fit in the
+   userland address space on 32-bit platforms.  We now mmap huge
+   packfile in pieces to avoid this problem.
+
+
+* Shallow clones
+
+ - There is a partial support for 'shallow' repositories that
+   keeps only recent history now.  A 'shallow clone' is created
+   by specifying how deep that truncated history should be.
+
+   Currently a shallow repository has number of limitations:
+
+   - Cloning and fetching _from_ a shallow clone are not
+     supported (nor tested -- so they might work by accident but
+     they are not expected to).
+
+   - Pushing from nor into a shallow clone are not expected to
+     work.
+
+   - Merging inside a shallow repository would work as long as a
+     merge base is found in the recent history, but otherwise it
+     will be like merging unrelated histories and may result in
+     huge conflicts.
 
+   but this would be more than adequate for people who want to
+   look at near the tip of a big project with a deep history and
+   send patches in e-mail format.
