Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848DF1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 06:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJINym (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 09:54:42 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:34691
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbeJINym (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 09:54:42 -0400
X-IronPort-AV: E=Sophos;i="5.54,359,1534802400"; 
   d="scan'208";a="281497157"
Received: from 89-157-201-244.rev.numericable.fr (HELO hadrien) ([89.157.201.244])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 08:39:15 +0200
Date:   Tue, 9 Oct 2018 08:39:15 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: git log -S or -G
In-Reply-To: <CA+P7+xpnVeWrW5r6uj4E4NSFPjhA_f0iwaCTJb8-WFqZChHEvA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1810090837270.2430@hadrien>
References: <alpine.DEB.2.21.1810061712260.2402@hadrien> <CACBZZX6PmG=-8563eYE4z98yvHePenZf_Kz1xgpse0ngjB5QyA@mail.gmail.com> <xmqqd0smvay0.fsf@gitster-ct.c.googlers.com> <alpine.DEB.2.21.1810070719200.2347@hadrien> <xmqq8t38t4r7.fsf@gitster-ct.c.googlers.com>
 <20181009032124.GE6250@sigill.intra.peff.net> <CA+P7+xpnVeWrW5r6uj4E4NSFPjhA_f0iwaCTJb8-WFqZChHEvA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Mon, 8 Oct 2018, Jacob Keller wrote:

> On Mon, Oct 8, 2018 at 8:22 PM Jeff King <peff@peff.net> wrote:
> >
> > On Tue, Oct 09, 2018 at 08:09:32AM +0900, Junio C Hamano wrote:
> >
> > > Julia Lawall <julia.lawall@lip6.fr> writes:
> > >
> > > >> Doing the same for -S is much harder at the machinery level, as it
> > > >> performs its thing without internally running "diff" twice, but just
> > > >> counts the number of occurrences of 'foo'---that is sufficient for
> > > >> its intended use, and more efficient.
> > > >
> > > > There is still the question of whether the number of occurrences of foo
> > > > decreases or increases.
> > >
> > > Hmph, taking the changes that makes the number of hits decrease
> > > would catch a subset of "changes that removes 'foo' only---I am not
> > > interested in the ones that adds 'foo'".  It will avoid getting
> > > confused by a change that moves an existing 'foo' to another place
> > > in the same file (as the number of hits does not change), but at the
> > > same time, it will miss a change that genuinely removes an existing
> > > 'foo' and happens to add a 'foo' at a different place in the same
> > > file that is unrelated to the original 'foo'.  Depending on the
> > > definition of "I am only interested in removed ones", that may or
> > > may not be acceptable.
> >
> > I think that is the best we could do for "-S", though, which is
> > inherently about counting hits.
> >
> > For "-G", we are literally grepping the diff. It does not seem
> > unreasonable to add the ability to grep only "-" or "+" lines, and the
> > interface for that should be pretty straightforward (a tri-state flag to
> > look in remove, added, or both lines).
> >
> > -Peff
>
> Yea. I know I've wanted something like this in the past.

It could also be nice to be able to specify multiple patterns, with and
and or between them.  So -A&-B would be remove A somewhere and remove B
somewhere.

julia
