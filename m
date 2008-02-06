From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/9] Add flag to make unpack_trees() not print errors.
Date: Tue, 5 Feb 2008 20:11:14 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802052006450.13593@iabervon.org>
References: <alpine.LNX.1.00.0802041335390.13593@iabervon.org> <alpine.LSU.1.00.0802050112380.8543@racer.site> <alpine.LNX.1.00.0802051439200.13593@iabervon.org> <7v7ihj7yv8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 02:11:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMYpJ-0002KX-LJ
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 02:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756644AbYBFBLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 20:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753024AbYBFBLR
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 20:11:17 -0500
Received: from iabervon.org ([66.92.72.58]:54353 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbYBFBLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 20:11:16 -0500
Received: (qmail 22970 invoked by uid 1000); 6 Feb 2008 01:11:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2008 01:11:14 -0000
In-Reply-To: <7v7ihj7yv8.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72741>

On Tue, 5 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Tue, 5 Feb 2008, Johannes Schindelin wrote:
> > ...
> >> > Additionally, if unpack_trees() returns with an error, but without 
> >> > printing anything, it will roll back any changes to the index (by 
> >> > rereading the index, currently). This obviously could be done by the 
> >> > caller, but chances are that the caller would forget and debugging this 
> >> > is difficult.
> >> 
> >> Granted, it is easy to forget.  But maybe the caller does not need the 
> >> index?  Or maybe it wants a different one?  I'd prefer the caller to clean 
> >> up, if necessary.
> >
> > That's what makes it "gently" instead of just "silent"; it has no effect 
> > if it doesn't succeed. Longer term, I'd like to have unpack_trees() unpack 
> > into a separate index, which should actually be faster (since it doesn't 
> > have to keep shifting the entries in the index it's working on) and make 
> > this moot.
> 
> Absolutely.  That is the original motivation I did the_index
> thing for.
> 
> But "re-reading" may not be quite nice.  It would defeat the
> optimization introduced by the change to use CE_UPTODATE flag to
> avoid unnecessary lstat(2) calls.

For now, I want to re-read the index, because I need the changes undone 
and I don't have any way of reverting them. That's another reason to have 
unpack_trees return with the index unchanged: it may have a better way of 
getting there than the caller does, such as having never changed that 
memory in the first place. I'll add doing it efficiently to my list of 
things to do, but I want to keep it from being necessary for correctness 
of this series.

	-Daniel
*This .sig left intentionally blank*
