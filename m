From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/7] move setting of object->type to alloc_* functions
Date: Mon, 14 Jul 2014 01:57:27 -0400
Message-ID: <20140714055727.GA5593@sigill.intra.peff.net>
References: <20140711084141.GA5521@sigill.intra.peff.net>
 <20140711084611.GB5625@sigill.intra.peff.net>
 <53C149B6.7010705@ramsay1.demon.co.uk>
 <20140712180539.GA13806@sigill.intra.peff.net>
 <20140713064116.GA4768@sigill.intra.peff.net>
 <53C2DDB7.2070708@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Jul 14 07:57:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6ZGX-000265-E9
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 07:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbaGNF5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 01:57:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:33429 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752785AbaGNF53 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 01:57:29 -0400
Received: (qmail 32587 invoked by uid 102); 14 Jul 2014 05:57:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jul 2014 00:57:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jul 2014 01:57:27 -0400
Content-Disposition: inline
In-Reply-To: <53C2DDB7.2070708@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253474>

On Sun, Jul 13, 2014 at 08:27:51PM +0100, Ramsay Jones wrote:

> > Thinking on this more, writing out the definitions is the only sane
> > thing to do here, now that alloc_commit_node does not use the macro.
> > Otherwise you are inviting people to modify the macro, but fail to
> > notice that the commit allocator also needs updating.
> 
> Hmm, well I could argue that using the macro for all allocators, apart
> from alloc_commit_node(), clearly shows which allocator is the odd-man
> out (and conversely, that all others are the same)! :-P
> 
> No, I don't think this is a telling advantage; I don't think it makes
> that much difference. (six of one, half-a-dozen of the other).

Yeah, I agree with your final statement in parentheses. I am OK with it
either way (but I have a slight preference for what I posted).

> I was slightly concerned, when reading through this new series, that the
> alloc_node() function may no longer be inlined in the new allocators.
> However, I have just tested on Linux (only using gcc this time), and it
> was just fine. I will test the new series on the above systems later
> (probably tomorrow) but don't expect to find any problems.

That should not be due to my patches (which are just expanding macros),
but rather to your 1/8, right?

I do not know that it matters that much anyway. Yes, we allocate a lot
of objects in some workloads. But I think it is not so tight a loop that
the extra function call is going to kill us (and we tend to _read_ the
allocated objects much more than we allocate them).

> > Here's a re-roll. The interesting bit is the addition of the second
> > patch (but the rest needed to be rebased on top).
> 
> Yep, this looks good. Thanks!

Thanks for reviewing, as usual.

-Peff
