From: Jeff King <peff@peff.net>
Subject: Re: Keeping reflogs on branch deletion
Date: Thu, 14 Feb 2008 10:17:52 -0500
Message-ID: <20080214151752.GB3889@coredump.intra.peff.net>
References: <76718490802131739n22c56cadn39c1871ea1762dc3@mail.gmail.com> <ee77f5c20802131745p23aa1db3j47207f1e6538b0e@mail.gmail.com> <18355.42595.377377.433309@lisa.zopyra.com> <ee77f5c20802131903i45b1629fpcb4a5c6e4f483052@mail.gmail.com> <7vr6fgkxt2.fsf@gitster.siamese.dyndns.org> <20080214140152.GT27535@lavos.net> <alpine.LFD.1.00.0802140945520.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Downing <bdowning@lavos.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Symonds <dsymonds@gmail.com>,
	Bill Lear <rael@zopyra.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 16:18:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPfr8-00026f-Ke
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 16:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbYBNPR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 10:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbYBNPR5
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 10:17:57 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4704 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003AbYBNPRz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 10:17:55 -0500
Received: (qmail 7565 invoked by uid 111); 14 Feb 2008 15:17:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 14 Feb 2008 10:17:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2008 10:17:52 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802140945520.2732@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73881>

On Thu, Feb 14, 2008 at 10:00:58AM -0500, Nicolas Pitre wrote:

> > When deleting a branch, is there any reason we can't add a deletion
> > entry into the reflog and keep the reflog around?  This would seem to be
> > a lot safer; I know I've been burned by expecting the reflog safety net
> > to be there, and surprised that it's not when I've deleted a branch.
> 
> No.  That would only accumulate dead reflog files in the repository.

How is that any different than accumulating old entries in reflog files
for branches that _do_ exist? In both cases, they should be dealt with
via time-based pruning.

> And as Junio said above, the "HEAD" reflog contains everything you moved 
> to, including detached heads, and of course branch heads that might now 
> be deleted.  You can easily retrieve a deleted branch head from there.

By that rationale, why do we bother keeping any reflog besides HEAD in
the first place? I can think of two reasons:

  1. it's much more convenient to type branch@{1} than to sift through
     HEAD's reflog looking for checkout events and guessing which branch
     we were on
  2. it's possible to change a ref without it being on the HEAD, in
     which case the HEAD reflog doesn't contain the change.

In other words, I don't see "oops, I deleted this branch and its history
is valuable to me" as significantly less likely than "oops, I got rid of
this commit and its history is valuable to me."

-Peff
