Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F1020189
	for <e@80x24.org>; Wed, 22 Jun 2016 17:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbcFVRMH (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 13:12:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:58613 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751059AbcFVRMG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 13:12:06 -0400
Received: (qmail 1111 invoked by uid 102); 22 Jun 2016 17:12:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Jun 2016 13:12:04 -0400
Received: (qmail 3288 invoked by uid 107); 22 Jun 2016 17:12:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Jun 2016 13:12:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jun 2016 13:12:02 -0400
Date:	Wed, 22 Jun 2016 13:12:02 -0400
From:	Jeff King <peff@peff.net>
To:	Armin Kunaschik <megabreit@googlemail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: Re: t7610-mergetool.sh test failure
Message-ID: <20160622171202.GB10056@sigill.intra.peff.net>
References: <CAPc5daWmhYKNXZJxnZYuCe90vOti7Su-Uab7=9JvvsFYfw1s_Q@mail.gmail.com>
 <20160525231615.GC2634@sigill.intra.peff.net>
 <20160526015114.GA12851@sigill.intra.peff.net>
 <20160527044027.GA26143@gmail.com>
 <20160527050054.GA25774@sigill.intra.peff.net>
 <xmqqshx4row8.fsf@gitster.mtv.corp.google.com>
 <20160527182444.GA1871@sigill.intra.peff.net>
 <CAPc5daV1zAwAHDmkc93kGvwCEFoioZNVta2xGsFJj9jq1H1H4A@mail.gmail.com>
 <20160527200122.GA26608@sigill.intra.peff.net>
 <CALR6jEisU=ZCZADcTx685vSrz96jUaxfAbKMEPQn0KRFqtVw=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALR6jEisU=ZCZADcTx685vSrz96jUaxfAbKMEPQn0KRFqtVw=A@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 22, 2016 at 06:53:40PM +0200, Armin Kunaschik wrote:

> Another thread I'm trying to revive... the discussion went away quite a bit
> from the suggested patch to conditionally run this one test only when mktemp
> is available.
> 
> I'll create a patch when there are chances it is accepted.
> 
> I could think of a way to replace mktemp with a perl one-liner (or
> small script)...
> conditionally, when mktemp is not available... maybe in the build process?
> As far as I can see, perl is absolutely necessary and can therefore be used to
> "solve" the mktemp problem...
> 
> ...or maybe I should stop bringing this up again :-)

I think perl is necessary for the test suite, but not for git-mergetool
itself. And this is a problem in the script itself, IIRC; so it really
is broken on your system (albeit in a really tiny way), and not just a
test portability thing.

So the viable solutions to me are one of:

  1. Accept that this little part of mergetool doesn't work on systems
     without "mktemp", make sure we fail gracefully (we seem to), and make
     sure the test suite can handle this case (which was the earlier
     patch, I think).

  2. Implement our own git-mktemp (or similar abstraction) in C. We
     already have all the code, so it really is just a thin wrapper.

I don't mind (2), but given the lack of people clamoring for a fix to
mergetool itself, I'm perfectly happy with (1).

-Peff
