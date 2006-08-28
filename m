From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Mon, 28 Aug 2006 00:19:36 -0700
Message-ID: <7vodu5qqd3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 09:19:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHbP7-0005qO-2o
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 09:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWH1HTT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 03:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWH1HTT
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 03:19:19 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:14580 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932403AbWH1HTS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 03:19:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060828071917.SEQA6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Mon, 28 Aug 2006 03:19:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id FKK91V0074Noztg0000000
	Mon, 28 Aug 2006 03:19:15 -0400
To: git@vger.kernel.org
X-maint-at: 60a6bf5f53635005f4f68d8b8a33172309193623
X-master-at: 370e0966ef4abff81f08c9ea5c7d167eb0b0d354
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26146>

This is CC'ed to the kernel list as well because the "master"
update is rather large.

On the "maint" front, I've been wanting to cut 1.4.2.1 for some
time, but various time constraints prevented me doing so so far.
I have a vague suspicion that 1.4.3 might happen before that.

Also I have been sort-of waiting for the x86-32 machine at
kernel.org to become available again so that I can do an RPM for
end users, which unfortunately hasn't happened yet.

* The 'maint' branch has these fixes since the last announcement.

   Johannes Schindelin:
      git-mv: special case destination "."
      git-mv: fix off-by-one error
      builtin-mv: readability patch

* The 'master' branch has these since the last announcement.

  - Johannes's reimplementation of merge-recursive in C is in
    'master' for early adopter testing.  Currently it is called
    'merge-recur', so you either (1) invoke it explicitly with
    the -s option to 'git pull' and/or 'git merge', or (2) have
    an environment variable GIT_USE_RECUR_FOR_RECURSIVE set to
    non-empty string, in which case places that call
    'git-merge-recursive' would use 'git-merge-recur' instead.

    This has been tested in 'next' for some time, and Johannes
    ran tests to reproduce all merges in post 2.6.12-rc2 kernel
    history to validate it produces the same result as the
    current merge-recursive.  The only difference is that it is
    about 6x-10x faster and you do not have to have Python
    installed.

    I intend to retire the current merge-recursive.py and
    replace it with merge-recur before 1.4.3 happens.

  - Various calls to memcmp/memcpy/memset with length '20' to
    compare, copy and clear object names have been abstracted
    out to hashcmp/hashcpy/hashclr wrappers, spearheaded by
    David Rientjes.  This would make it easier to migrate the
    code to hashes of other lengths if it is ever needed.

    Obviously migrating the existing data is another story.

  - Updates to git-svn by Eric Wong.

  - git-apply can be given --reject to produce *.rej files,
    instead of failing the whole patch atomically.  It also can
    be given --verbose to report what it is doing.

  - Rene Scharfe helped git-tar-tree find its soulmate
    git-zip-tree.

  - Tilman Sauerbeck taught git-daemon to setuid/setgid before
    serving the clients.

  - Various small fixes and clean-ups by Haavard Skinnemoen, Jakub
    Narebski, Jonas Fonseca, Pierre Habouzit, Rene Scharfe,
    Shawn Pearce, and Tilman Sauerbeck.

  - Various documentation clean-ups by Jonas Fonseca, and Rene
    Scharfe.

  - The internal is readied to be able to say "32 hours ago" in
    "git log" and friends by Linus; we do not have an UI to
    enable it yet.


* The 'next' branch, in addition, has these.

  - Various gitweb updates by Jakub Narebski with help from
    Aneesh Kumar, Luben Tuikov, and Martin Waitz.  The most
    attractive thing these updates have is that we finally got
    rid of having to use temporary files to show diffs.

    I'd like to push this out to "master" soonish.  You can get
    a taste of how it works at the site Jakub maintains

	http://front.fuw.edu.pl/cgi-bin/jnareb/gitweb.cgi

  - Git.pm by Pasky with help from Dennis Stosberg, Eric Wong,
    Johannes, and Pavel Roskin.  During the next round I'd like
    to push this out to "master" to see who screams ;-).

  - upload-pack has a bit of updates still held back.

  - git-daemon is taught to optionally serve git-tar-tree
    output.


* In the 'pu' branch, I have my WIP of a library to walk the
  index, the working tree, and zero or more tree objects in
  parallel.  Its test program does something that vaguely looks
  like diff-index with and without --cached in parallel, but it
  is not polished enough for public testing/consumption yet.
