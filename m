From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 5/6] Do linear-time/space rename logic for exact renames
Date: Thu, 25 Oct 2007 16:23:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710251606280.7345@iabervon.org>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.org>
 <alpine.LFD.0.999.0710251120590.30120@woody.linux-foundation.org>
 <Pine.LNX.4.64.0710251522190.7345@iabervon.org> <20071025194859.GB27745@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 22:23:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il9FE-0002Uu-9M
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 22:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbXJYUXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 16:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbXJYUXl
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 16:23:41 -0400
Received: from iabervon.org ([66.92.72.58]:49292 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751564AbXJYUXk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 16:23:40 -0400
Received: (qmail 11590 invoked by uid 1000); 25 Oct 2007 20:23:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Oct 2007 20:23:37 -0000
In-Reply-To: <20071025194859.GB27745@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62368>

On Thu, 25 Oct 2007, Jeff King wrote:

> On Thu, Oct 25, 2007 at 03:43:46PM -0400, Daniel Barkalow wrote:
> 
> > Creating a list of the pointers doesn't work correctly with the grow 
> > implementation, because growing the hash may turn a collision into a 
> > non-collision, at which point items other than the first cannot be found 
> > (since they're listed inside a bucket that's now wrong for them). AFAIK, 
> > resizing a hash table requires being able to figure out what happened with 
> > collisions.
> 
> I thought this at first, too, but there are two types of collisions in
> this hash implementation: those that come from having the actual 32-bit
> hash collide, and those that come from not having enough buckets.
> 
> The client code gets a pointer kicked back to it when there is a
> collision on the actual hash value (i.e., two things had the exact same
> hash value). The number of buckets grows when you simply have more
> buckets filled than you like. Two different hashes that would be in the
> same bucket don't actually occupy the same bucket -- the second one to
> arrive gets shoved into the next available bucket.

Ah, right, nevermind. The comment might be a bit misleading in that case, 
if we both missed this at first.

	-Daniel
*This .sig left intentionally blank*
