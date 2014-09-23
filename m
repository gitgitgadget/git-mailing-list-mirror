From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mailinfo: resolve -Wstring-plus-int warning
Date: Tue, 23 Sep 2014 03:51:46 -0400
Message-ID: <20140923075146.GA11104@peff.net>
References: <1411290838-45622-1-git-send-email-sunshine@sunshineco.com>
 <xmqqk34vlfhz.fsf@gitster.dls.corp.google.com>
 <CAPig+cTAFaG5H8rmf1jrvFwr_OOH7u19JMKDUE12UddokUmfaQ@mail.gmail.com>
 <20140923060407.GA23861@peff.net>
 <CAPc5daUbXtNXSn8_tspvdF+SH5aeX+jVJTramtOm96Dc1wCqtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 09:52:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWKt7-0005mF-Uc
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 09:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbaIWHvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 03:51:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:50823 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750797AbaIWHvt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 03:51:49 -0400
Received: (qmail 5759 invoked by uid 102); 23 Sep 2014 07:51:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 02:51:49 -0500
Received: (qmail 25077 invoked by uid 107); 23 Sep 2014 07:52:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 03:52:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Sep 2014 03:51:46 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daUbXtNXSn8_tspvdF+SH5aeX+jVJTramtOm96Dc1wCqtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257398>

On Mon, Sep 22, 2014 at 11:26:14PM -0700, Junio C Hamano wrote:

> On Mon, Sep 22, 2014 at 11:04 PM, Jeff King <peff@peff.net> wrote:
> >
> > I don't mind silencing this one warning (even though I find it a little
> > ridiculous). I'm slightly concerned that more brain-damage may be coming
> > our way, but we can deal with that if it ever does.
> >
> > Like Junio, I prefer keeping strlen() rather than switching to sizeof,
> > as it is less error-prone (no need for extra "-1" dance, and it won't
> > silently do the wrong thing if the array is ever converted to a
> > pointer).
> 
> I actually do not mind losing the sample[] array too much.
> 
> The early 45 bytes or so of that array (or a string constant) is not used
> by the code at all; I didn't want to count "From " (that's 5), 40-hex and
> then a SP -- ah, see, it is 46 bytes and I didn't want such miscounting.
> The only real contents that matter in that sample[] array is the tail part
> that is meant as the magic(5) cue. I'd be OK if the code checked the
> length of the line against a hardcoded constant and then did strcmp()
> starting from a hardcoded offset of the string and the magic cue string,
> and that would also avoid the warning from Eric's compiler.
> 
> But personally, I think the way it is coded is much easier to read,
> and is much harder to get it wrong while maintaining it.  So...

I agree. I was going to suggest switching to a static const array
instead of a string literal, but retaining strlen()...but I see you
already queued that in pu. So if what is there works for Eric (I do not
have the compiler in question to test with), that seems reasonable.

-Peff
