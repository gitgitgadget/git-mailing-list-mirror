From: Junio C Hamano <junkio@cox.net>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 15:51:51 -0800
Message-ID: <7vacbg4t48.fsf@assigned-by-dhcp.cox.net>
References: <20060322133337.GU20746@lug-owl.de>
	<Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
	<Pine.LNX.4.64.0603221607580.26286@g5.osdl.org>
	<44223B90.3040500@zytor.com>
	<1143128751.6850.35.camel@neko.keithp.com>
	<Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
	<20060323210215.GH26071@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 00:52:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMZaz-0004wk-GG
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 00:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422732AbWCWXv5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 18:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWCWXv5
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 18:51:57 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:38064 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1422732AbWCWXv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 18:51:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060323235152.GPI20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Mar 2006 18:51:52 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060323210215.GH26071@mythryan2.michonline.com> (Ryan
	Anderson's message of "Thu, 23 Mar 2006 16:02:15 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17887>

Ryan Anderson <ryan@michonline.com> writes:

> Git has taken a very pragmatic approach, in that the goal has been "What
> is the smallest number of concepts we can create that let us solve the
> problem, even if we occassionally have to make some tradeoffs?"
> (Thinking of rename detection there, mostly.)

I do not see it as a tradeoff not to record renames.  It _is_ a
feature.

On the other hand, rename detection is an eye candy, which is
sometimes useful but only sometimes.  If you look at the history
of a real project, content movement across multiple files is a
norm, and content movement between two files, one of which
disappears and the other appears, is a rather narrow special
case.  If you think in terms of "renames", you can only talk
about that special case, and rename detection also can only deal
with that special case.

Two good examples were discussed some time ago on the list.  One
was about "where did {powerpc,pcc64}/Makefile come from?" and
the answer was "content migrated over time across multiple
commits, and you cannot really say this Makefile is renamed from
somewhere".  The other was the comment by Linus on how
revision.c evolved in our project.

I am reasonably happy with how our rename detection turned out
to be, but we should keep in mind that detecting file renames is
scratching only a narrowly defined subset of the problem space.

Pickaxe was an attempt to help tracking other forms of content
movement, and it is minimally useful as a building block, but if
we really want to track content movement across file boundaries,
like Linus originally envisioned in 

	http://article.gmane.org/gmane.comp.version-control.git/217

we need to have a bit more Porcelain around it.
