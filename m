From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t8005: avoid grep on non-ASCII data
Date: Sun, 21 Feb 2016 18:35:33 -0500
Message-ID: <20160221233533.GD4094@sigill.intra.peff.net>
References: <20160219193310.GA1299@sigill.intra.peff.net>
 <cover.1456075680.git.john@keeping.me.uk>
 <81ec83acd004ef050a4c8df62fb158b41f0a0a80.1456075680.git.john@keeping.me.uk>
 <CAPig+cQ9n4Eg73Uyeg_g_4wzebuwn8=0R-LMb8F9QLFxanwVVg@mail.gmail.com>
 <20160221231913.GA4094@sigill.intra.peff.net>
 <CAPig+cSXsk4Pp9adi4KvYjdCwaw4R0Jrv2vwC0JTCyzomWxaww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 00:35:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXdXP-0007wV-Vq
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 00:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbcBUXfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 18:35:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:46414 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752434AbcBUXfg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 18:35:36 -0500
Received: (qmail 25048 invoked by uid 102); 21 Feb 2016 23:35:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 21 Feb 2016 18:35:36 -0500
Received: (qmail 13336 invoked by uid 107); 21 Feb 2016 23:35:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 21 Feb 2016 18:35:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Feb 2016 18:35:33 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cSXsk4Pp9adi4KvYjdCwaw4R0Jrv2vwC0JTCyzomWxaww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286848>

On Sun, Feb 21, 2016 at 06:31:08PM -0500, Eric Sunshine wrote:

> > Something like the patch below works for me. I think we could make it
> > shorter by using $PERLIO to get the raw behavior, but using binmode will
> > work even on ancient versions of perl.
> >
> > +filter_blame () {
> > +       perl -e '
> > +               binmode STDIN;
> > +               binmode STDOUT;
> 
> I was worried about binmode() due to some vague recollection from
> years and years ago of it being problematic on Windows, but I see
> these tests are all protected by !MINGW anyhow...

Thanks for mentioning that. I meant to put a note on that at the end of
_my_ message, but forgot. :)

It does mean we won't do CRLF processing. We could get around that with
some explicit `chomp`-ing, I think. Or just leave it as-is and assume
these will lose the !MINGW prereq.

I see Junio just mentioned elsewhere that we can simply avoid the
extended regular expressions by using two sed commands. That would be
fine with me, too.

-Peff
