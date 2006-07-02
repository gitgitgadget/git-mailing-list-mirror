From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sun, 02 Jul 2006 00:45:56 -0700
Message-ID: <7vr7145u17.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 02 09:46:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwweX-00088e-9e
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 09:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWGBHp6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 03:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWGBHp6
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 03:45:58 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:48260 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751532AbWGBHp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 03:45:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060702074557.QRYE8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 03:45:57 -0400
To: git@vger.kernel.org
X-maint-at: 0556a11a0df6b4119e01aa77dfb795561e62eb34
X-master-at: 0556a11a0df6b4119e01aa77dfb795561e62eb34
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23095>

The 'master' branch has been pushed out as GIT 1.4.1 tonight to
celebrate the birthday of lady gitster.

In "next", there are the following series:

 - rationalize diff output options by Timo Hirvonen.

   This makes "diff --patch --stat" operate sensibly.  I have
   added about 100 tests to make sure that this does not regress
   diff/log commands, and made small fixups to Timo's version
   here and there.

   There are still slight differences in output between the
   current "master" version and Timo's version, but I believe
   they are all improvements.  Curious people may want to take a
   look at the following two commits that updates the tests to
   match Timo's output:

	commit 026625e78eaf8ea2ae960525c367b5e8f1629fd4
	commit 9e76bab14e50c46c624ae35f13c527a7a1b1185d

   I think this is ready to be merged into "master", but further
   testing is appreciated.

 - A few Makefile clean-ups by Jakub Narebski.

   This is part of Jakub's "optionally manage config.mk with
   autoconf generated configure script" series.  I have not been
   queueing the rest of the series but judging from the list
   traffic and the size and quality of the later pieces, the
   patch series might have stabilized enough to be resubmitted
   for consideration.  Honestly, I am still somewhat reluctant,
   but my impression was it was still strictly "opt-in" so it
   might be OK.

 - git_merge_bases() by Johannes.

   Calling commit ancestry walkers more than once correctly is
   hard, and that is why I have accepted the libifying part with
   the change to use the lib by one caller that calls the
   function only once, without merging anything that calls the
   function more than once.

   I think this library part, with the clean-up by Rene Scharfe
   in "pu", is in good shape to be tested further.  The '...'
   operator work would be a good demonstration to prove the
   libification is sound, before proceeding to bigger and more
   interesting users, like merge-recursive in C by Alex Riesen.

   Alex/Johannes team's effort seems to be progressing nicely
   and I am looking forward to seeing a version that is stable
   enough for testing.

 - gitweb updates by Dennis Stosberg and Luben Tuikov.

   I am personally running this on my private machine to see the
   progress made by Jakub so far with these updates, and am
   generally happy.  I'd like to see the code further refactored
   before picking up any more new features, though.  I see Jakub
   is talking with xmms2 team and am hoping to see we can see
   more cleanups they made in our tree soon (thanks Jakub).

 - instaweb by Eric Wong.

   I made a mismerge when accepting this series and "next" ended
   up with two copies of three "gitweb" related patches.  Sorry
   for cluttering the history.

 - "A better scheduled PPC SHA-1 implementation" by linux@horizon.com

 - git-merge-tree WIP by Linus.

   I should take a look at this and follow it through but
   haven't spent as much time as I should have nor I would have
   liked yet.


In "pu", there are more interesting pieces:

 - updates to git-merge-bases with '...' operator by Rene Scharfe.

   This should come in "next" but I think Johannes has a point
   that library interface should be the easier-to-use version.

   Maybe we should have get_merge_bases_unclean() as an oddball
   function that does not clean up for performance, and make
   git-merge-base call that, and keep the name of the function
   for generic callers that does clean up short and sweet
   get_merge_bases().

 - updates to diff options rationalization by Timo Hirvonen.

   This makes --name-only, --name-status, --check and -s
   mutually exclusive, and makes 'git diff-files -s' behave like
   other diff commands (i.e. -s means "silent" -- so no output
   is seen).  These are both optional.

 - "Perly Git" series by Pasky and Pavel Roskin.

   I've heard success stories from some but negatives from
   others.  Feedback from people other than who are on Linux
   i386/x86-64 with Perl 5.8 are appreciated.

   In order to get a bit wider exposure without disrupting
   people, we might want to revert the fmt-merge-msg conversion
   with a workaround option in Makefile to allow skipping the
   build of perl/ subdirectory, and merge the result to "next".

 - GIT_TRACE by Matthias Lederhofer.
 - "git grep boolean expression" by me.

   I am not personally interested in these two very much, but I
   do not think they break anything.  I may push them to "next"
   or keep them lingering on in "pu".  I do not care too much
   either way myself -- people who are interested need to push
   my back.
