From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] t3030: fix accidental success in symlink rename
Date: Fri, 25 Mar 2011 13:51:24 -0400
Message-ID: <20110325175124.GA24513@sigill.intra.peff.net>
References: <20110325160013.GA25851@sigill.intra.peff.net>
 <20110325160326.GA26635@sigill.intra.peff.net>
 <7v1v1v6qs2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>,
	Ken Schalk <ken.schalk@intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:51:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3BAa-0002VJ-2U
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 18:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252Ab1CYRv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 13:51:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48935
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360Ab1CYRv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 13:51:26 -0400
Received: (qmail 15942 invoked by uid 107); 25 Mar 2011 17:52:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 13:52:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 13:51:24 -0400
Content-Disposition: inline
In-Reply-To: <7v1v1v6qs2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170003>

On Fri, Mar 25, 2011 at 10:42:05AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In this test, we have merge two branches. On one branch, we
> > renamed "a" to "e". On the other, we renamed "a" to "e" and
> > then added a symlink pointing at "a" pointing to "e".
> 
> I read this five times but still couldn't figure out that you meant that
> the other side 'added a symlink "a" to allow people keep referring to "e"
> with the old name "a"' until I actually read the actual test you are
> describing here.

Hmph. I edited it to try to be more clear, and obviously left in a typo.
I clearly need to proofread more.

> Besides, /we have merge/s/have//, I think.

It was actually s/have merge/merge.  So what I intended to write was:

  In this test, we merge two branches. On one branch, we renamed "a" to
  "e". On the other, we renamed "a" to "e" and then added a symlink "a"
  pointing to "e".

If that's not clear enough, then feel free to swap it out for something
better.

> > The only sensible resolution is to keep the symlink.
> 
> I agree.
> 
> We should treat structural changes and do a 3-way on that, and then
> another 3-way on content changes, treating them as an independent thing.
> One side has "create 'e' out of 'a', removing 'a'" and "_create_ 'a', that
> is unrelated to the original 'a'", the other side has "create 'e' out of
> 'a', removing 'a'", so the end result should be that we do both,
> i.e. "create 'e' out of 'a', removing 'a'" and "create 'a'".  At the
> content level, the result in 'e' may have to be decided by 3-way.  The
> result in 'a' should be a clean merge taken from the former "with b/c
> link" branch, as this is not even a create (by the side that added a
> backward compatibility symbolic link) vs a delete (by pure-rename side)
> conflict.

Good, I think we are on the same page. Hopefully you will find my 2/3
correct at least in spirit, then, if not implementation. :)

-Peff
