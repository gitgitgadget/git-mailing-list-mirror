Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932A8C77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 19:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjDJT4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 15:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDJT4q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 15:56:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC061E73
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 12:56:45 -0700 (PDT)
Received: (qmail 2770 invoked by uid 109); 10 Apr 2023 19:56:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 Apr 2023 19:56:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 509 invoked by uid 111); 10 Apr 2023 19:56:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Apr 2023 15:56:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Apr 2023 15:56:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] branch, for-each-ref: add option to omit empty lines
Message-ID: <20230410195644.GA104097@coredump.intra.peff.net>
References: <20230330112133.4437-1-oystwa@gmail.com>
 <20230330112133.4437-3-oystwa@gmail.com>
 <44e7ac0f-2fd9-fd01-89da-a8d036d2e400@dunelm.org.uk>
 <xmqqjzywg7sg.fsf@gitster.g>
 <CAFaJEqtxNa+fuuKzkKPLkF3qdYwZUj+tMKXB3u2ok6H008vjHA@mail.gmail.com>
 <20230406171203.GB2709660@coredump.intra.peff.net>
 <xmqqo7o0q3e4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7o0q3e4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2023 at 11:20:03AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It might be enough to flip the default unconditionally (no config), but
> > I think we may still want "--no-omit-empty-lines" as an escape hatch. I
> > dunno. Maybe that is somehow choosing the worst of both worlds.
> 
> It is very tempting, indeed.  We can add the escape hatch and flip
> the default, and only when somebody complains, come back and say
> "oh, sorry, we didn't know anybody used it" and flip the default
> back, perhaps?

I don't think flipping back after such an incident is a good idea, as it
just creates more confusion. But if the option exists, then at least you
can say "oh, sorry; you can still do what you want by passing this
option", rather than "oh, sorry; there's no way to get what you want".

But either way, the first step before flipping any defaults is adding an
option, which is what this patch is doing, so I am all for it. :)

> This is a totally unrelated tangent, but it is a bit unfortunate
> that with our parse-options API, it is not trivial to
> 
>  - mark that "--keep-empty-lines" and "--omit-empty-lines" toggle
>    the same underlying Boolean variable,
> 
>  - accept "--no-keep" and "--no-omit" as obvious synonyms for
>    "--omit" and "--keep", 
> 
>  - have "git foo -h" listing to show "--keep" and "--omit" together,
> 
>  - omit these "--no-foo" variants from "git foo -h" listing.
> 
> by the way.

Yeah, "--no-" is special in our parser in a way that "--keep" and
"--omit" aren't. It might be possible to make this pattern easier to
support. OTOH, perhaps it is a sign that we are straying too far from
existing patterns. It is not just parse-options.c, but also users
themselves, who benefit from consistency.

-Peff
