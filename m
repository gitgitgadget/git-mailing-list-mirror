Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,URIBL_RED shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05CC020988
	for <e@80x24.org>; Mon, 17 Oct 2016 08:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758566AbcJQIiI (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 04:38:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:52722 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758316AbcJQIiG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 04:38:06 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LxxKu-1cyvaP22Ka-015GEn; Mon, 17 Oct 2016 10:37:53
 +0200
Date:   Mon, 17 Oct 2016 10:37:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/25] sequencer: completely revamp the "todo" script
 parsing
In-Reply-To: <20161016194238.wbge2pas5xr46av7@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1610171025470.197091@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de> <4e73ba3e8c1700259ffcc3224d1f66e6a760142d.1476120229.git.johannes.schindelin@gmx.de> <933b13d6-5f24-c03a-a1a0-712ceb8ddcc8@web.de>
 <20161015171926.qgtvrjcaqwb436hx@sigill.intra.peff.net> <d9f4f658-94fb-cb9e-7da8-3a2fac120a9e@web.de> <20161015174656.fmgk3le2b34nnjpx@sigill.intra.peff.net> <alpine.DEB.2.20.1610161006080.197091@virtualbox>
 <20161016194238.wbge2pas5xr46av7@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:b1qIW+Ro/6ygzXY/Zrz7LNijutn9F1QRpa3K4D8SnoStq2rF3Z+
 XGma+1jX6eserr0w5VvhysN4z8EsCEBgjbVRrRSqzQrjWYqLqy4BgExd5yJXpraMbi+y5U4
 lza6XdK6p4j4ofv+HlcJ6S4ZcOY6OlIsMMup+9T+vPv2ouKA45MTGgMjxQtkNZ6Alkk8Wz9
 WpBNYBb39zRJ2sQRfs9qQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r4FI2jpqFHw=:vR82RzRa7iintYCUx//nGa
 QaQviXnpMoPQNTFVOcsOMspXidOPBNKIQ+/J2LVSIxt1lwcEA3ZQYjrwWtlVTlC6e7jZGHF6+
 lo8gP/0qQ7hAXdBvHtorrtyWAi/3sUElbnNFT3zWx1M5rGpKuEeTyanaNtJern1nluQl6ljZT
 1MKYBqYvgfiIqXtKXgbYb0oARw0xX152QRFNcZuM1gEmGhcEiczG9XsHTvjm+IZlmfSKdZ9F6
 Vwt9RS8ePlpnQwkSb0AkpP5ank0AWeVLWExScwQeyLzgAMY/wqQWjSodr871HBjTeICgVGs6n
 lotSyZzcpY+a3nK/7xiCan0/ZRxnoKWbfpX5lTzNWIHunQoKgua0Dz/K/rqtEk63rot6HC1uM
 z8qhYzmHZVgCFYixfUUENcDwrF8ZrcZeE5wYRRZ2khEtodCe5Z3n5FigOWQbOGIDaXGll34De
 5ENEUCxbyKnpCROM8mVqTqB0/zNN7FKILP7ZnzxC0rwttqZpQbKe6DKz8MEaHbwLVwp7irRa4
 KbORXQHjRdBjOuIYA5kJPrb4NqXo4gPeHzaWFd1gTNtu1AtFlnYZHrIBL4OWU2Oclw7TIARHW
 cVxAxDxoaHVJRNiRZTuLlmZhweJzpL0dbjhUgyO7Ovj7uXje8mL+ZyEoZUwawszYmzXvLt3G8
 PikoJXfeCFHt59tbHt1Fz/8/bxjnUH32j+DjcNvUoLRv9RfhcyaDtwRkdEhRQH2K+MSpWqnan
 AvF0xmoRyXObY8qDQbrFvi7wI48Rbt0kAhiabwxnKCfu62ULG47i7d7oV09ReZlM0xtY9edQI
 eVFEpnz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sun, 16 Oct 2016, Jeff King wrote:

> On Sun, Oct 16, 2016 at 10:09:12AM +0200, Johannes Schindelin wrote:
> 
> > > Good catch. It technically needs to check the lower bound, too. In
> > > theory, if somebody wanted to add an enum value that is negative, you'd
> > > use a signed cast and check against both 0 and ARRAY_SIZE(). In
> > > practice, that is nonsense for this case, and using an unsigned type
> > > means that any negative values become large, and the check catches them.
> > 
> > I am pretty certain that I disagree with that warning: enums have been
> > used as equivalents of ints for a long time, and will be, for a long time
> > to come.
> 
> I'm not sure I agree. IIRC, Assigning values outside the range of an enum has
> always been fishy according to the standard, and a compiler really is
> allowed to allocate a single bit for storage for this enum.

Really? I did see my share of code that completely violated this freedom,
by assuming that it was really okay to cast a -1 to an enum and then test
for that value later, when -1 was not a legal enum value.

In any case, the fact that even one compiler used to build Git *may*
violate that standard, and that we therefore need such safety guards as
the one under discussion, still makes me think that this warning, while
certainly well-intentioned, is poison for cross-platform projects.

> > Given that this test is modified to `if (command < TODO_NOOP)` later, I
> > hope that you agree that it is not worth the trouble to appease that
> > compiler overreaction?
> 
> I don't mind if there are transient warnings on some compilers in the
> middle of a series, but I'm not sure when "later" is. The tip of "pu"
> has this warning right now when built with clang.

"Later" is the sequencer-i patch series I already sent out for review
[*1*], in particular the patch titled "sequencer (rebase -i):
differentiate between comments and 'noop'" [*2*].

> I'm happy to test the TODO_NOOP version against clang (and prepare a
> patch on top if it still complains), but that doesn't seem to have
> Junio's tree at all yet.

Junio chose to pick up only one patch series out of the rebase--helper
thicket at a time, it seems. I did send out at least one revision per
patch series prior to integrating them into Git for Windows v2.10.0,
though. Plus, I kept updating the `interactive-rebase` branch in my
repository on GitHub (https://github.com/dscho/git).

Ciao,
Dscho

Footnote *1*:
https://public-inbox.org/git/cover.1472633606.git.johannes.schindelin@gmx.de/

Footnote *2*:
https://public-inbox.org/git/736bcb8e860c876e32e8f89f68b0b901abedc187.1472633606.git.johannes.schindelin@gmx.de/t/#u

P.S.: I cannot wait for the day when somebody with an artistic touch
provides .css for the public-inbox.org site so it stops threatening
causing eye cancer to me.
