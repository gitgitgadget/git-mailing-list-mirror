Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF26C11D04
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 11:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912E32071E
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 11:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgBTLZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:25:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:49124 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726837AbgBTLZk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 06:25:40 -0500
Received: (qmail 3305 invoked by uid 109); 20 Feb 2020 11:25:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Feb 2020 11:25:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3516 invoked by uid 111); 20 Feb 2020 11:34:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Feb 2020 06:34:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 Feb 2020 06:25:39 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        rhi@pengutronix.de
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
Message-ID: <20200220112539.GB1252160@coredump.intra.peff.net>
References: <fcf19a46b80322c5579142efe4ec681a4dcbdd28.1581802264.git.matheus.bernardino@usp.br>
 <20200216065101.GA2937208@coredump.intra.peff.net>
 <xmqqd0abk7zc.fsf@gitster-ct.c.googlers.com>
 <20200218195402.GA21586@coredump.intra.peff.net>
 <xmqq4kvnijim.fsf@gitster-ct.c.googlers.com>
 <xmqqzhdfh3vr.fsf@gitster-ct.c.googlers.com>
 <20200219015733.GA81560@coredump.intra.peff.net>
 <xmqqr1yrgt2d.fsf@gitster-ct.c.googlers.com>
 <20200219035650.GA84414@coredump.intra.peff.net>
 <xmqqftf6hlrt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftf6hlrt.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 03:14:14AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think a left a few things unsaid in my "v1.0-bob" example. I was
> > imagining that there are _two_ v1.0 tags floating around. One that you
> > consider "wrong", tagged by Bob, and one you like. You keep the latter
> > in refs/tags/v1.0.
> 
> Ahh, OK.  
> 
> To continue playing devil's advocate and to step back a bit,
> 
>  - The "git describe" command finds that the given commit is
>    "closest" to that tag Bob called "v1.0".
> 
>  - But if it outputs "v1.0" like the current code does, it cannot be
>    fed back to get_oid() to name the right object, if the given commit
>    is "at" the tag (i.e. there is no "-$number-g$objectname" suffix),
>    which is a problem.  We want "git describe" to give an output
>    usable with get_oid() and the name must refer to the correct
>    object (i.e. the one given to "git describe" as an input).
> 
> There are multiple approaches to make it possible to feed the output
> back to get_oid() to obtain correct result:
> [...]

Thanks for clearly laying out your thinking. All of what you wrote makes
sense to me and I'd be OK with any of the options you described.

The "-g$objectname" one is kind of clever, and definitely not something
I had thought of. We already have "--long", and of course we'd show the
long version for any name that isn't an exact match anyway. So as an
added bonus, it seems unlikely to surprise anybody who is expecting the
current "show the tag, not the refname" output (though again, this is
rare enough that I think people simply expect them to be the same ;) ).

-Peff
