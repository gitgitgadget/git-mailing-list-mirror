From: Nicolas Pitre <nico@cam.org>
Subject: Re: Keeping reflogs on branch deletion
Date: Thu, 14 Feb 2008 11:16:20 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802141103280.2732@xanadu.home>
References: <76718490802131739n22c56cadn39c1871ea1762dc3@mail.gmail.com>
 <ee77f5c20802131745p23aa1db3j47207f1e6538b0e@mail.gmail.com>
 <18355.42595.377377.433309@lisa.zopyra.com>
 <ee77f5c20802131903i45b1629fpcb4a5c6e4f483052@mail.gmail.com>
 <7vr6fgkxt2.fsf@gitster.siamese.dyndns.org> <20080214140152.GT27535@lavos.net>
 <alpine.LFD.1.00.0802140945520.2732@xanadu.home>
 <20080214151752.GB3889@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brian Downing <bdowning@lavos.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Symonds <dsymonds@gmail.com>,
	Bill Lear <rael@zopyra.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 17:17:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPglf-0000qs-Bi
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 17:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbYBNQQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 11:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754085AbYBNQQX
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 11:16:23 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9958 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbYBNQQV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 11:16:21 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW8004LUL78A030@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 Feb 2008 11:16:20 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080214151752.GB3889@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73883>

On Thu, 14 Feb 2008, Jeff King wrote:

> On Thu, Feb 14, 2008 at 10:00:58AM -0500, Nicolas Pitre wrote:
> 
> > > When deleting a branch, is there any reason we can't add a deletion
> > > entry into the reflog and keep the reflog around?  This would seem to be
> > > a lot safer; I know I've been burned by expecting the reflog safety net
> > > to be there, and surprised that it's not when I've deleted a branch.
> > 
> > No.  That would only accumulate dead reflog files in the repository.
> 
> How is that any different than accumulating old entries in reflog files
> for branches that _do_ exist? In both cases, they should be dealt with
> via time-based pruning.

Branches that do exist are more likely to be interesting to you than 
branches that, hopefully in 99% of all cases, you willfully deleted.

> > And as Junio said above, the "HEAD" reflog contains everything you moved 
> > to, including detached heads, and of course branch heads that might now 
> > be deleted.  You can easily retrieve a deleted branch head from there.
> 
> By that rationale, why do we bother keeping any reflog besides HEAD in
> the first place? I can think of two reasons:
> 
>   1. it's much more convenient to type branch@{1} than to sift through
>      HEAD's reflog looking for checkout events and guessing which branch
>      we were on

Exact.  But that doesn't apply to non existent branches, surely?  And 
what would you do with the reflog of a deleted branch when a new branch 
is created with the same name?

>   2. it's possible to change a ref without it being on the HEAD, in
>      which case the HEAD reflog doesn't contain the change.

And in those cases this can't be due to your own modifications, hence 
nothing valuable is lost if you then delete that branch.

> In other words, I don't see "oops, I deleted this branch and its history
> is valuable to me" as significantly less likely than "oops, I got rid of
> this commit and its history is valuable to me."

But you still have it, in the HEAD reflog, at least for your own 
changes. I therefore don't see the value of having to keep named branch 
reflogs around just for the small convenience, especially with the 
semantic issues that comes with it.


Nicolas
