From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] introduce git root
Date: Thu, 4 Dec 2014 04:22:52 -0500
Message-ID: <20141204092251.GC27455@peff.net>
References: <1417291211-32268-1-git-send-email-arjun024@gmail.com>
 <2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
 <CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
 <vpqoaro99xd.fsf@anie.imag.fr>
 <xmqqd284rryz.fsf@gitster.dls.corp.google.com>
 <CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
 <20141202070415.GC1948@peff.net>
 <xmqqd282m09j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 10:23:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwScn-0006Pq-Qc
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 10:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbaLDJW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 04:22:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:48254 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753335AbaLDJWy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 04:22:54 -0500
Received: (qmail 23404 invoked by uid 102); 4 Dec 2014 09:22:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 03:22:54 -0600
Received: (qmail 4850 invoked by uid 107); 4 Dec 2014 09:22:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 04:22:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2014 04:22:52 -0500
Content-Disposition: inline
In-Reply-To: <xmqqd282m09j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260750>

On Tue, Dec 02, 2014 at 09:26:00AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There is also "git var", which is a catch-all for printing some deduced
> > environmental defaults. I'd be just as happy to see it go away, though.
> > Having:
> >
> >   git --exec-path
> >   git --toplevel
> >   git --author-ident
> >
> > all work would make sense to me (I often get confused between "git
> > --foo" and "git rev-parse --foo" when trying to get the exec-path and
> > git-dir). And I don't think it's too late to move in this direction.
> > We'd have to keep the old interfaces around, of course, but it would
> > immediately improve discoverability and consistency.
> 
> Yeah, I too think the above makes sense.  I forgot about "var", but
> it should go at the same time we move kitchen-sink options out of
> "rev-parse".  One less command to worry about at the UI level means
> you do not have to say "if you want to learn about X, ask 'var', if
> you want to learn about Y, ask 'rev-parse', use 'git' itself for Z".

Christian raised the issue of cluttering the "git --option" namespace,
and I do agree that's a potential issue. My proposal was to drop "git
var", but I'd also be OK with making "git var" the new kitchen sink.  It
doesn't accept many options now, so it's fairly wide open for changing
without losing backwards compatibility. AFAICT, the "-l" option is
utterly useless, but other than that, it just takes a variable name. We
could introduce dashed options, or just define a sane variable namespace.

Some of the discussion has involved mixing config options into this
kitchen sink, but that does not make any sense to me (and is why I find
"git var -l" so odd). Config options are fundamentally different, in
that they are set and retrieved, not computed (from other config
variables, or from hard-coded values). And we already have a nice tool
for working with them (well...nice-ish, let's say).

-Peff
