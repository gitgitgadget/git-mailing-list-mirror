From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD  was
Date: Thu, 15 Oct 2009 17:35:10 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910151653480.32515@iabervon.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com> <alpine.LNX.2.00.0910141509200.32515@iabervon.org> <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home> <7vws2xa9lu.fsf@alter.siamese.dyndns.org> <20091014230934.GC29664@coredump.intra.peff.net> <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com> <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <7v3a5k4cri.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 23:43:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyY6N-0000o0-Ob
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 23:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933521AbZJOVfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 17:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933492AbZJOVfs
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 17:35:48 -0400
Received: from iabervon.org ([66.92.72.58]:50300 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933442AbZJOVfr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 17:35:47 -0400
Received: (qmail 2033 invoked by uid 1000); 15 Oct 2009 21:35:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Oct 2009 21:35:10 -0000
In-Reply-To: <7v3a5k4cri.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130425>

On Thu, 15 Oct 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >  $ git checkout origin/master
> >  $ git fetch
> >  $ git checkout origin/next
> >  Uncommited file '...' would be overwritten.
> >
> > If HEAD is a symref to refs/remotes/origin/master, and you update 
> > refs/remotes/origin/master, git will subsequently see that your index 
> > doesn't match HEAD, and when you switch branches, it will try to apply a 
> > revert to the branch you're switching to. It's the same issue as pushing 
> > into a non-bare repository.
> 
> I think the idea here is to allow HEAD to point at outside refs/heads/,
> e.g. refs/remotes/origin/master, but forbid commit and other commands from
> updating HEAD and its underlying ref via update_ref() unless HEAD is
> detached or points at a local branch.

 $ git checkout origin/master
 $ git fetch
 (Some error)

I think it would be much more confusing for many users if you couldn't 
do:

 $ git checkout origin/master
 (look at origin/master)
 (wait a day)
 $ git fetch
 $ git checkout origin/next
 (look at origin/next)

Part of the original point of detached HEAD was to support this pattern 
without creating an undesired local branch (which falls out of date),
having problems with updating the tracking branches, or having problems 
with direct changes to the ref that HEAD points to.

Currently, HEAD is never a symref to anything that will ever be updated 
normally except though the symref. That's a really handy property that 
avoids making us deal with lots of special cases in weird places. And 
those special cases would not only be annoying to have to handle again, 
but they'd be complexity that users would have to be exposed to.

	-Daniel
*This .sig left intentionally blank*
