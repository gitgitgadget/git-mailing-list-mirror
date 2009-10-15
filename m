From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD  was
Date: Thu, 15 Oct 2009 15:31:13 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>  <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>  <alpine.LNX.2.00.0910141509200.32515@iabervon.org>  <alpine.LFD.2.00.0910141616530.20122@xanadu.home>  <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
  <alpine.LFD.2.00.0910141647390.20122@xanadu.home>  <7vws2xa9lu.fsf@alter.siamese.dyndns.org>  <20091014230934.GC29664@coredump.intra.peff.net> <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 21:39:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyWAQ-0004W8-Vq
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 21:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758562AbZJOTbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 15:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756137AbZJOTbu
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 15:31:50 -0400
Received: from iabervon.org ([66.92.72.58]:49238 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755179AbZJOTbu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 15:31:50 -0400
Received: (qmail 23323 invoked by uid 1000); 15 Oct 2009 19:31:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Oct 2009 19:31:13 -0000
In-Reply-To: <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130415>

On Thu, 15 Oct 2009, James Pickens wrote:

> On Wed, Oct 14, 2009 at 4:09 PM, Jeff King <peff@peff.net> wrote:
> > That makes the most sense to me. If "git checkout" could write metadata
> > into HEAD (or into DETACH_HEAD, as in Daniel's patch), then checkout
> > could record an "ok to commit" bit. And could also be used to change it
> > after the fact. E.g.:
> >
> >  $ git checkout --detach=commit origin/master
> >  $ git commit ;# should be ok
> >
> >  $ git checkout --detach=examine origin/master
> >  $ git commit ;# complain
> >  $ git checkout --detach=commit HEAD
> >  $ git commit ;# ok
> >
> > I guess something like "rebase" should detach with "ok to commit", since
> > it is planning on attaching the commits later. I'm not sure about "git
> > bisect". I guess probably it should be "not ok to commit" to be on the
> > safe side, and then somebody can "git checkout --detach=commit" if they
> > want to.
> 
> How about not detaching the head at all if the user checks out any ref, and
> reject commits if he checked out a tag or remote branch.  For example:
> 
> $ git checkout origin/master
> $ git status
> # On branch origin/master
> $ git commit ;# complain

 $ git checkout origin/master
 $ git fetch
 $ git checkout origin/next
 Uncommited file '...' would be overwritten.

If HEAD is a symref to refs/remotes/origin/master, and you update 
refs/remotes/origin/master, git will subsequently see that your index 
doesn't match HEAD, and when you switch branches, it will try to apply a 
revert to the branch you're switching to. It's the same issue as pushing 
into a non-bare repository.

	-Daniel
*This .sig left intentionally blank*
