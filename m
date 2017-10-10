Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77E922036B
	for <e@80x24.org>; Tue, 10 Oct 2017 18:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932478AbdJJSct (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 14:32:49 -0400
Received: from ikke.info ([178.21.113.177]:37492 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932437AbdJJScs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 14:32:48 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 1EBD144039C; Tue, 10 Oct 2017 20:32:47 +0200 (CEST)
Date:   Tue, 10 Oct 2017 20:32:47 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC] column: show auto columns when pager is active
Message-ID: <20171010183247.GA16800@alpha.vpn.ikke.info>
References: <20171009214543.12986-1-me@ikke.info>
 <20171010141019.3vfowj4fvxdvvl3c@sigill.intra.peff.net>
 <20171010142930.vao2nqg4pv7f2znk@sigill.intra.peff.net>
 <CAN0heSr5EN2Ls5Xd-Sg6b-z9WsJM9s1xB7ZczDkRgv79hxhsaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSr5EN2Ls5Xd-Sg6b-z9WsJM9s1xB7ZczDkRgv79hxhsaA@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 07:04:42PM +0200, Martin Ågren wrote:
> On 10 October 2017 at 16:29, Jeff King <peff@peff.net> wrote:
> > On Tue, Oct 10, 2017 at 10:10:19AM -0400, Jeff King wrote:
> >
> > it will randomly succeed or fail, depending on whether sed manages to
> > read the input before the stdin terminal is closed.
> >
> > I'm not sure of an easy way to fix test-terminal, but we could work
> > around it like this (which also uses "-p" to actually invoke the pager,
> > and uses a pager that makes it clear when it's being run):
> >
> > diff --git a/t/t9002-column.sh b/t/t9002-column.sh
> > index 9441145bf0..d322c3b745 100755
> > --- a/t/t9002-column.sh
> > +++ b/t/t9002-column.sh
> > @@ -180,14 +180,14 @@ EOF
> >
> >  test_expect_success TTY '20 columns, mode auto, pager' '
> >         cat >expected <<\EOF &&
> > -one    seven
> > -two    eight
> > -three  nine
> > -four   ten
> > -five   eleven
> > -six
> > +paged:one    seven
> > +paged:two    eight
> > +paged:three  nine
> > +paged:four   ten
> > +paged:five   eleven
> > +paged:six
> >  EOF
> > -       test_terminal env PAGER="cat|cat" git column --mode=auto <lista >actual &&
> > +       test_terminal env PAGER="sed s/^/paged:/" sh -c "git -p column --mode=auto <lista" >actual &&
> >         test_cmp expected actual
> >  '
> >  test_done
> 
> Makes sense. FWIW, I don't see the flakyness with this.
> 
> > All that said, I think I'd just as soon test a real command like "git
> > tag", which doesn't care about reading from stdin.
> 
> For reference for Kevin, in case you consider testing, e.g., git tag,
> the main reason I referred to the test I posted as "hacky", was that I
> just inserted it at a more-or-less random place in t7006. So it had to
> play with `git reset` to avoid upsetting the later tests. It could
> obviously go to the end instead, but I was too lazy to move it and
> define a pager.

Thanks Jeff and Martin, I will use your tips to build a test based on
git tag instead.
