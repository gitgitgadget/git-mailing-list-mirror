From: Eli Barzilay <eli@barzilay.org>
Subject: git-svn and subversion revprops
Date: Sun, 31 Jan 2010 06:39:03 -0500
Message-ID: <19301.27607.993690.703245@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 13:08:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbYbG-0008R4-OP
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 13:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984Ab0AaMIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 07:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087Ab0AaMIQ
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 07:08:16 -0500
Received: from winooski.ccs.neu.edu ([129.10.115.117]:36429 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224Ab0AaMIP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 07:08:15 -0500
X-Greylist: delayed 1749 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Jan 2010 07:08:15 EST
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1NbY8u-0002fY-0C; Sun, 31 Jan 2010 06:39:04 -0500
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138541>

[This is possible an RTFM -- but as much as I've been digging around,
I couldn't find anything about it.]

I'm trying to play with git-svn in a project that uses subversion, and
there's one feature that I'd like to have -- make git-svn specify some
revision properties (eg, the `--with-revprop' to `svn commit') that
will identify it as coming from git-svn.

The thing is that we have a continuous build server that runs a
complete build (and runs all tests) for every revision -- and I'm
trying to figure out a way to make it skip intermediate commits that
come from a git-svn.  The simplest way to do that would be a way to
mark all git-svn revisions somehow, and I can later unmark the last
one in the chain so only that one will get built and tested.  It would
be even more convenient if I have a way to control the revprops on the
last commit separately, so there's no additional step involved.

The only other alternative that I see is some wrapper around git-svn
that connects to some script that will run on the server before and
after dcommitting changes, and that script will do the necessary work.
Is there a way to specify hook scripts to run around a dcommit?

Actually, such hooks can also be used to lock the svn reposity while
git-svn is working -- I couldn't figure out what happens when there's
some commit that comes in while git-svn is running.  My guess is
that it'll either get stuck and throw an error, or maybe try to
continue if possible.  Such hooks could make that part more robust, as
well as guarantee that each batch of svn-git commits are always
together.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
