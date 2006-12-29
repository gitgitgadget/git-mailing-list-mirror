From: Junio C Hamano <junkio@cox.net>
Subject: Re: branch.pu.forcefetch
Date: Thu, 28 Dec 2006 18:30:16 -0800
Message-ID: <7v8xgrsabr.fsf@assigned-by-dhcp.cox.net>
References: <1167251519.2247.10.camel@dv>
	<7vfyb159dn.fsf@assigned-by-dhcp.cox.net>
	<1167341346.12660.17.camel@dv>
	<7vzm97tzbt.fsf@assigned-by-dhcp.cox.net>
	<1167355326.15189.34.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 03:30:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H07Vn-0007rJ-VQ
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 03:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbWL2CaS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 21:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755041AbWL2CaS
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 21:30:18 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:64015 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbWL2CaR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 21:30:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229023017.PEXH25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 21:30:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4SWW1W00P1kojtg0000000; Thu, 28 Dec 2006 21:30:30 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1167355326.15189.34.camel@dv> (Pavel Roskin's message of "Thu,
	28 Dec 2006 20:22:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35575>

Pavel Roskin <proski@gnu.org> writes:

>> Are you talking about "remote.origin.fetch = +pu:refs/heads/pu"?
>
> Yes, I'm talking about that line.  And I don't like that I have to use a
> magic token "refs/heads/pu" that doesn't correspond to a real file to
> make it possible to keep git up-to-date.

I think we misunderstood each other.  That line is inconsistent
with what your config has, which is the separate-remote layout,
which I did not know you were using.  In separate-remote layout,
you don't have refs/heads/pu so if we do not do the patches you
are agreeing to, you would want to have something like:

	[remote "origin"]
                fetch = +refs/heads/pu:refs/remotes/origin/pu
        	fetch = refs/heads/*:refs/remotes/origin/*

In other words, "path does not correspond to a real file"
problem does not exist.  If you tell git to track 'pu' at
refs/remotes/origin/pu, it will use that path -- so that path
has a corresponding real file.

> Unfortunately, updating the current branch fails because pu is not
> fast-forwarding.  Why fail if I'm not even on pu?

Your being not on 'pu' does not have anything to do with it.  In
fact, you do not even want to be _on_ any of your tracking
branches.  In the separate-remote layout, you cannot even be on
remotes/origin/pu branch.

What you are seeing is fetch's safety feature that stops and
notifies you the situation when the remote rewinds/rebases the
branch you are tracking with tracking branches.  We have had it
turned on by default for a long time, and you have it turned on
in your config because that is the default.  If you do not want
to use that feature (and for git.git, you certainly don't), just
turn it off.  When you know you do not want to use a feature,
you do not have to.

Turning it off by default was not a wise thing to do in general
for a long time, because rewound/rebased tip loses information,
and we did not have reflog enabled by default.  Your message
raised this issue to attention of the list, and I suggested two
patches out of it, both of which I think are sane things to do.
If the list agrees, we can turn it off by default now.
