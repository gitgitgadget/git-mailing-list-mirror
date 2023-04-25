Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87849C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 06:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjDYGKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 02:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjDYGKc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 02:10:32 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02112AD39
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 23:10:30 -0700 (PDT)
Received: (qmail 21918 invoked by uid 109); 25 Apr 2023 06:10:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Apr 2023 06:10:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1179 invoked by uid 111); 25 Apr 2023 06:10:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Apr 2023 02:10:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Apr 2023 02:10:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: git-checkout: trivial callout cleanup
Message-ID: <20230425061029.GA4015844@coredump.intra.peff.net>
References: <20230418070048.2209469-1-felipe.contreras@gmail.com>
 <20230418070048.2209469-2-felipe.contreras@gmail.com>
 <xmqq8ren8xz1.fsf@gitster.g>
 <644684018a766_aba29424@chronos.notmuch>
 <xmqq8reg96cu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8reg96cu.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2023 at 05:02:25PM -0700, Junio C Hamano wrote:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > No, it's for the formatting machinery.
> >
> > The fact that both asciidoc and asciidoctor happen to understand our quircky
> > formatting in this particualr situation doesn't mean it isn't quirky.
> >
> > In this particular case the parsers do understand what we are trying to do,
> > because we just just pepper list continuations (`+`) everywhere and it happens
> > to work.
> 
> I'll stop at pointing out that the first "no" sounds much stronger
> than the text that tries to substantiate it, which says that the
> machinery works fine without the changes.
> 
> > This discrepancy confused Jeff in [1].
> 
> And this is a good reason to add this change for humans.

Since I'm being used as the example, I'd like to point that I think this
is somewhat tangential to what actually confused me there.

What confused me in that earlier message was that having "+" as the
continuation between a code-block and its call-out list is odd, since
"+" is about continuing a list item. It happens to work because we're in
a larger list item, but it breaks when you put the two of them in their
own block (which is the part that got me).

Using just a blank line between the code block and the call-out list
(instead of the "+") works for asciidoc (it is happy to keep the two
together) but not asciidoctor (it ends the outer ordered list before
starting the callout list).

So the second hunk in the patch, to drop the extra continuation between
the code block and the callout, makes perfect sense to me.

The first hunk seems less obviously good to me. We're not part of a
list, so there's no continuation. We might say that it is good to always
stick the callout list directly adjacent to the associated code block,
since it does matter in other cases. But dropping the blank lines
between the paragraph-sized callout blocks makes the source less
readable, and empty lines between list elements are a pretty normal
thing in asciidoc.

That said, I don't feel _too_ strongly about it, so I'm OK with the
patch as-is.

-Peff
