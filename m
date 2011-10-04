From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH]: reverse bisect v 2.0
Date: Tue, 4 Oct 2011 06:30:56 -0400
Message-ID: <20111004103056.GB11236@sigill.intra.peff.net>
References: <20110929142027.GA4936@zelva.suse.cz>
 <20110930114220.GA742@zelva.suse.cz>
 <7v62k9q4oq.fsf@alter.siamese.dyndns.org>
 <20111003104112.GE16078@sigill.intra.peff.net>
 <7vfwjaggd2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Vyskocil <mvyskocil@suse.cz>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 12:31:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB2HB-0003DL-FG
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 12:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911Ab1JDKbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 06:31:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52081
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755819Ab1JDKa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 06:30:59 -0400
Received: (qmail 6952 invoked by uid 107); 4 Oct 2011 10:36:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 06:36:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 06:30:56 -0400
Content-Disposition: inline
In-Reply-To: <7vfwjaggd2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182754>

On Mon, Oct 03, 2011 at 10:00:25AM -0700, Junio C Hamano wrote:

> > I like this idea a lot. My "yes/no" thing was a "if I were designing
> > bisect from scratch today..." suggestion, but having something like
> > --used-to makes it a natural addition to the regular good/bad interface.
> > And I really like the prompt to help people remember what it is they're
> > declaring each time.
> 
> I forgot to clarify that "tested" was only to help users who wanted
> reminder; if the user is confident with the usual "yes/no", the
> interactivity is not required.

That makes sense to me. I think in either case, it would be nice to
mention the --used-to text when we take each step. We're already
outputting some status information there (like how many commits left).

> > However, --used-to feels a bit backwards to me. I think of it as
> > "--has-property" or something similar.
> 
> I do not think --used-to='frotz says xyzzy' is a good phrasing at all; it
> is grammatically incorrect. But --has-property has one large downside.  At
> least --used-to makes it clear that the user is supposed to decribe the
> property of the tree in the past.
> 
> Let's step back a bit to understand why I think this is not optimal.

What you say makes sense, but isn't it just a problem of the name? IOW,
a much better name than "--has-property" would be "--started-to". That
would imply the exact same cutoff as --used-to, but negate only the
yes/no bit.

So you could say:

  # find a bug:
  git bisect start --used-to='work with --foo=bar'

  # or if you are looking for a specific undesirable behavior, you might
  # write:
  git bisect start --used-to='not segfault with --foo=bar'

  # but now you have a negation in your condition. So it might be more
  # natural to write it as:
  git bisect start --started-to='segfault with --foo=bar'

  # Or we can find a feature
  git bisect start --used-to='not respect core.foo'

  # but again, we have a negation. Instead:
  git bisect start --started-to='respect core.foo'

And the --started-to would literally be implemented as flipping the
meaning of "git bisect yes" and "git bisect no", and nothing more. IOW,
it's just another way of spelling "git bisect --reverse".

I know you wanted to emphasize the "older tree has this property" of
--used-to, but I think it is clear with --started-to that the older tree
obviously obviously had the negation of the property.

-Peff
