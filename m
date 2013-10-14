From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] split_ident: parse timestamp from end of line
Date: Mon, 14 Oct 2013 19:29:49 -0400
Message-ID: <20131014232949.GA10415@sigill.intra.peff.net>
References: <20131014202734.GA7007@sigill.intra.peff.net>
 <xmqqwqlfebhi.fsf@gitster.dls.corp.google.com>
 <20131014223137.GA12744@sigill.intra.peff.net>
 <xmqqsiw3eajt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 01:29:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVraG-0005Pd-4U
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 01:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284Ab3JNX3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 19:29:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:49378 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757158Ab3JNX3v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 19:29:51 -0400
Received: (qmail 23647 invoked by uid 102); 14 Oct 2013 23:29:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Oct 2013 18:29:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Oct 2013 19:29:49 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsiw3eajt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236149>

On Mon, Oct 14, 2013 at 03:45:42PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, you are right[1]. I'm happy to re-roll. I wonder if we even need
> > to worry about a compatibility wrapper. We are already doing pointer
> > manipulations, and it is probably just as readable to roll the loop by
> > hand.
> 
> Yeah, unrolling the loop is probably better.  You may even be able
> to do so in a single pass with an extra "last > seen" pointer
> variable without too much additional code complexity, I would think.

I'm not sure what you mean here.

If you mean doing a single pass to find the final ">", that is easy,
because we know the length of the line already and can jump past and
start from the back.

If you mean rolling it into the loop directly below, where we jump past
the whitespace, I think it's a bit more complicated. We would not want
to stop when we see something date-like, because parsing:

  Name <<bogus.email> 5678> 1234 -0500

you would want to find "1234" as the date. You can, while you are
scanning right, keep track of the end of the whitespace after ">", but I
do not think the complication is worth much. There should typically only
be one space, so you are only saving looking at a single character.

-Peff
