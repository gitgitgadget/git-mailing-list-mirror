From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mailinfo: resolve -Wstring-plus-int warning
Date: Tue, 23 Sep 2014 02:04:07 -0400
Message-ID: <20140923060407.GA23861@peff.net>
References: <1411290838-45622-1-git-send-email-sunshine@sunshineco.com>
 <xmqqk34vlfhz.fsf@gitster.dls.corp.google.com>
 <CAPig+cTAFaG5H8rmf1jrvFwr_OOH7u19JMKDUE12UddokUmfaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 08:04:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWJD0-0001st-CU
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 08:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbaIWGEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 02:04:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:50799 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753815AbaIWGEK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 02:04:10 -0400
Received: (qmail 1296 invoked by uid 102); 23 Sep 2014 06:04:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 01:04:10 -0500
Received: (qmail 24385 invoked by uid 107); 23 Sep 2014 06:04:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Sep 2014 02:04:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Sep 2014 02:04:07 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cTAFaG5H8rmf1jrvFwr_OOH7u19JMKDUE12UddokUmfaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257393>

On Mon, Sep 22, 2014 at 05:10:08PM -0400, Eric Sunshine wrote:

> On Mon, Sep 22, 2014 at 1:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> >
> >> The just-released Apple Xcode 6.0.1 has -Wstring-plus-int enabled by
> >> default which complains about pointer arithmetic applied to a string
> >> literal:
> >>
> >>     builtin/mailinfo.c:303:24: warning:
> >>         adding 'long' to a string does not append to the string
> >>             return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) ...
> >>                            ~~~~~~~^~~~~~~~~~~~~
> >
> > And why is that a warning-worthy violation?
> 
> Not being privy to Apple's decision making process, I can only guess
> that it is in response to their new Swift programming language which
> they are pushing heavily on iOS (and soon Mac OS X), in which '+' is
> the string concatenation operator. For projects written in Swift and
> incorporating legacy or portable components in C, C++, or Objective-C,
> the warning may help programmer's avoid the pitfall of thinking that
> '+' is also concatenation in the C-based languages.

That is my reading from the warning text, too, but I have to wonder:
wouldn't that mean they should be warning about pointer + pointer, not
pointer + int?

Also, wouldn't the same advice apply to adding to _any_ char pointer,
not just a string literal?

I know you don't have answers to those questions, but the whole thing
seems rather silly to me.

> > Can we have them fix their compiler instead?
> 
> If the above supposition is correct, then it's likely that Apple
> considers this a feature, not a bug which needs to be fixed.

I don't mind silencing this one warning (even though I find it a little
ridiculous). I'm slightly concerned that more brain-damage may be coming
our way, but we can deal with that if it ever does.

Like Junio, I prefer keeping strlen() rather than switching to sizeof,
as it is less error-prone (no need for extra "-1" dance, and it won't
silently do the wrong thing if the array is ever converted to a
pointer).

-Peff
