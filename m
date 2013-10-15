From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] split_ident: parse timestamp from end of line
Date: Tue, 15 Oct 2013 14:03:12 -0400
Message-ID: <20131015180312.GA26845@sigill.intra.peff.net>
References: <20131014202734.GA7007@sigill.intra.peff.net>
 <xmqqwqlfebhi.fsf@gitster.dls.corp.google.com>
 <20131014223137.GA12744@sigill.intra.peff.net>
 <xmqqsiw3eajt.fsf@gitster.dls.corp.google.com>
 <20131014232949.GA10415@sigill.intra.peff.net>
 <xmqqob6qe808.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 20:03:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW8xl-0000eM-E4
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 20:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933460Ab3JOSDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 14:03:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:49862 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932555Ab3JOSDO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 14:03:14 -0400
Received: (qmail 12093 invoked by uid 102); 15 Oct 2013 18:03:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Oct 2013 13:03:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Oct 2013 14:03:12 -0400
Content-Disposition: inline
In-Reply-To: <xmqqob6qe808.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236191>

On Tue, Oct 15, 2013 at 10:52:55AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Yeah, unrolling the loop is probably better.  You may even be able
> >> to do so in a single pass with an extra "last > seen" pointer
> >> variable without too much additional code complexity, I would think.
> >
> > I'm not sure what you mean here.
> 
> > If you mean doing a single pass to find the final ">", that is easy,
> > because we know the length of the line already and can jump past and
> > start from the back.
> 
> I meant a single forward pass, like this.

Ah, I see. You are combining with the pass before, not the pass after.

I do not think this is any more (nor less) efficient than what I posted.
We still pass over the space after split->mail_end one additional time
searching for the closing bracket. Mine is _slightly_ more efficient in
that by going backwards we can stop when we see the first '>', avoiding
looking at the space between "mail_end" and "last_ket". But that space
is 0 in the normal case, and even if it is not, we are talking about
tens of bytes at most. So I doubt it would ever matter.

My version seems a little clearer to me, but that is probably because I
wrote it. If you strongly prefer the other, feel free to mark up my
patch.

-Peff

PS I learned a new term, "ket". I always called it "closing angle
   bracket".
