From: Junio C Hamano <junkio@cox.net>
Subject: Re: openbsd version?
Date: Mon, 10 Oct 2005 14:31:08 -0700
Message-ID: <7v4q7p2h5v.fsf@assigned-by-dhcp.cox.net>
References: <8664s5gxl9.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0510100939320.14597@g5.osdl.org>
	<7vvf0542fs.fsf@assigned-by-dhcp.cox.net>
	<864q7pdvcn.fsf@blue.stonehenge.com>
	<7vll113yjs.fsf@assigned-by-dhcp.cox.net>
	<86ek6tcdou.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 23:33:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP5F2-0000ja-Hq
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 23:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVJJVbL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 17:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVJJVbK
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 17:31:10 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:54479 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751262AbVJJVbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 17:31:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051010213048.MUNH24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Oct 2005 17:30:48 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86ek6tcdou.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "10 Oct 2005 13:36:01 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9943>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> <sarcasm>Undocumented secret switches.  Nice.</sarcasm>  No wonder
> I couldn't find it.

Sorry.  This is taken from the log message from the commit that
introduced the switch.

    git-branch -d <branch>: delete unused branch.
    
    The new flag '-d' lets you delete a branch.  For safety, it does not
    lets you delete the branch you are currently on, nor a branch that
    has been fully merged into your current branch.
    
    The credit for the safety check idea goes to Daniel Barkalow.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>

There should be a document in Documentation/howto/ to describe
how to find the commit that introduced a particular feature.
What I did to find the above is this:

   1. Look at git-branch.sh and notice that there is this line:

    echo >&2 "usage: $(basename $0)"' [-d <branch>] | [<branch> [start-point]]

   Make an educated guess that this line, especially the
   "[-d <branch>]" part, must have changed when the feature was
   added (that is, pre-modification file would not have had "[-d
   <branch>]" in it, but post-modification file would).

   2. Find such a change with pickaxe (-S):

    $ git whatchanged -S'[-d <branch>]' git-branch.sh

By mentioning this, I do not mean to say that you could have
figuired this out yourself -- the above sequence is useful for
somebody who knows the code already to do archaeology; IOW you
still need to know what to look for, so the above procedure
would not have helped at all even if you knew about pickaxe.

> Do these also flush any related object files?  Or do I need git-fsck still?

The latter.  I think there should be a general description in
the tutorial to advice the user to run git-fsck-objects every
once in a while, while mentioning that there is no need to do it
too often -- disk space is cheap and the time you spend waiting
for fsck-objects to finish tends to be more expensive.
