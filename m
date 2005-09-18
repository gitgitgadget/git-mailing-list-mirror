From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 0.99.7
Date: Sun, 18 Sep 2005 16:37:10 -0700
Message-ID: <7vwtleyml5.fsf@assigned-by-dhcp.cox.net>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 01:37:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH8ip-0003pI-VV
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 01:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVIRXhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 19:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVIRXhO
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 19:37:14 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:52150 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932255AbVIRXhN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 19:37:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050918233710.ZWBU26890.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Sep 2005 19:37:10 -0400
To: git@vger.kernel.org
In-Reply-To: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 07 Sep 2005 17:08:31 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8820>

I am hoping that sending this out to the kernel list is not
considered too much of useless spamming, but I promise I
wouldn't do thit next time for 0.99.8, if I hear from somebody
not to.

Here comes GIT 0.99.7

--

Done in 0.99.7
==============

Organization
~~~~~~~~~~~~

Some commands and most scripts are renamed for consistency.

  - We have an official standard terminology list [*1*].  To
    match this, commands that operate on index files now have
    'index' instead of 'cache' in their names, and ones that
    download are called 'fetch' instead of 'pull'.

  - We used to install most of the commands that happen to be
    implemented as scripts as 'git-*-script', which was
    cumbersome to remember and type unless you always used 'git'
    wrapper.  They lost '-script' suffix from their names.

For now, we install synonyms as symbolic links so that old
names continue to work, but they are planned to be removed in
0.99.8 (or later if there are enough objections on the list --
so far I have heard none).

Also ancient environment variables [*2*] are not supported
anymore.


New Features and Commands
~~~~~~~~~~~~~~~~~~~~~~~~~

Downloaders that are not fully git aware have been taught about
the mechanism to borrow objects from other repositories via
objects/info/alternates the server side may be using.  'git
fetch' and 'git pull' commands over rsync and http transport
should be able to handle such repositories [*3*].

People found interesting cases where the 'stupid' three-way
merge mechanism does the wrong thing without noticing.  We have
two new merge algorithms by Daniel and Fredrik that attempt to
do better in such cases.  A new 'git merge' command has been
introduced to make it easier to experiment with and choose among
different merge strategies.  Note that 'git pull' still uses the
traditional three-way merge after downloading, but it is
expected to be switched to use 'git merge' sometime in the
future.

Importing from tla archives has been improved and documentated.

'git branch' command acquired '-d' flag to delete a branch that
has already been merged into the current branch.

'git bisect' command is easier to use by logging the earlier
good/bad choices and make it replayable.

'git repack' has -a' flag to pack the whole repository into a
single pack.

'git grep' is a new command to run grep on files 'git' knows
about.


Fixes
~~~~~

* 'git-diff-*' commands used to mark copy/rename incorrectly
  when an (A,B) => (B,C) rename was made.  We said the new B is
  a copy of old A, not a rename of old A.

* When the user exported CDPATH into environment, 'cd' took
  scripts to unexpected places.  Unset it upfront to guard us.

* 'git format-patch' knows about 'git cherry' and skips patches
  already merged upstream.

* hopefully plugged memory leak in diffcore-rename properly.

* commit walkers incorrectly assumed having a commit means we
  have the whole history leading up to it -- which is not true
  if the previous download was interrupted.  As a safety
  measure, we now only trust the commits that are pointed by the
  existing refs.

* 'git rev-list' uses a lot less memory.

* The build should be a bit friendlier to Solaris and Darwin now.

* 'git ssh-{push,pull}' are friendlier to tcsh.

* http transport is nicer to caching proxies.

* 'git daemon' port is registered with IANA.

* Many documentation updates.


[Footnotes]
*1* http://www.kernel.org/pub/software/scm/git/docs/glossary.html

*2* Ancient environment variable names: SHA1_FILE_DIRECTORIES
AUTHOR_DATE AUTHOR_EMAIL AUTHOR_NAME COMMIT_AUTHOR_EMAIL
COMMIT_AUTHOR_NAME SHA1_FILE_DIRECTORY

*3* But not grafts.
