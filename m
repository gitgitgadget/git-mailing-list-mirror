From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Wed, 14 Oct 2009 21:47:37 -0400
Message-ID: <20091015014737.GA9923@coredump.intra.peff.net>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <alpine.LFD.2.00.0910141926170.20122@xanadu.home>
 <7viqeha2zv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 03:50:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyFTd-0001zT-DG
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 03:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbZJOBsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 21:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbZJOBsQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 21:48:16 -0400
Received: from peff.net ([208.65.91.99]:35004 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932155AbZJOBsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 21:48:16 -0400
Received: (qmail 1958 invoked by uid 107); 15 Oct 2009 01:51:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Oct 2009 21:51:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Oct 2009 21:47:37 -0400
Content-Disposition: inline
In-Reply-To: <7viqeha2zv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130354>

On Wed, Oct 14, 2009 at 05:56:52PM -0700, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Can't the user confusion be dealt with through some means other than 
> > making the tool less flexible?  I don't mind extra help message to be 
> > displayed after a headless commit is made for example.  But trying to 
> > make the tool more friendly should perhaps come from better education 
> > rather than added restrictions.
> >
> > My thoughts only.
> 
> I actually share that but there apparently are people who have given up on
> the education route.

I am personally undecided on this issue (my "this is the best option"
was the best of "a -f switch to commit, an 'expert' config option', or a
session-based option to commit").

But we really seem to have reached an impasse with how to proceed with
git ui.

People like Dscho are fed up with user complaints about parts of git
that can be unfriendly to new users. And I can understand that.  There
_is_ a perception that git is hard for beginners to use, and I don't
think that perception is entirely without merit. We expect the user to
understand the basic concepts of git, like history graphs, named refs
versus detached heads, tracking refs, the index, etc.

At the same time, I think that is what many of us _like_ about git. It
is based around simple and powerful concepts, and it doesn't get in your
way when you want to use those concepts in a powerful and flexible
manner. And I can understand resistance to making those features hard or
inconvenient to access; detached HEADs were invented for a reason, and
we want to use them.

So what is the right way to mediate between those desires? We have tried
or suggested several options, including:

  1. Educate users. Keep exposing them to the concepts, but make
     messages more clear. Improve documentation. This is largely the
     route taken with the index. Has it worked? I think there is still a
     perception among new users that the index is confusing.

  2. Use configuration options to differentiate behavior. This comes in
     the form of the sometimes-requested "expert/beginner mode" option.
     But it can also mean a config option for a specific behavior. The
     argument against it I have seen is that it can make git
     unpredictable for new versus old users. An old-timer helping a new
     person is more out-of-touch with what the new person's setup will
     do (which hurts when sitting at their terminal or when giving them
     advice online).

  3. Make a new porcelain interface that wraps the git plumbing. We have
     seen some examples of this. Obviously cogito was the first, and it
     has fallen by the wayside as people moved towards core git. That
     may be an artifact of its timing, though, as core git was a rapidly
     moving target, and power users wanted to use the new features. More
     recently we've had 'eg'. I don't know how many people are using it,
     but it is certainly not discussed on this list much. There are also
     GUIs wrapping git. I think these are subject to the same argument
     as (2), but even more so. An entirely new interface like 'eg' is
     really splitting the user base. As a git old-timer, I can keep up
     with what newbie options might impact git's behavior. But I haven't
     a clue how to do anything in 'eg'.

  4. Hide potentially dangerous behavior behind "-f" or similar options,
     or make it even more inaccessible. We have done this with some
     obviously dangerous cases, like "push -f" or "checkout -f", which
     can throw away data. But I think in cases where the behavior is
     simply confusing and not dangerous, we tend not to do this (at
     least I couldn't think of any examples off the top of my head). The
     obvious argument against it is that it inconveniences more
     experienced users. Dscho advocated "the good of the many" versus
     "the good of the few". And I can see some logic in that. At the
     same time, open source is about scratching itches. Is anyone really
     interested in doing something that makes our own itch worse?
     Everytime you use it, won't you be thinking about scratching?

So I don't know what the solution is. And maybe this is just useless
pontificating. But I feel like we have this discussion over and over,
every few months, about a different feature. I wish there were some way
to fix that.

Out of ideas,
-Peff
