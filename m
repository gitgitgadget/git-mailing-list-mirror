Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA2981F463
	for <e@80x24.org>; Tue, 10 Sep 2019 16:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436876AbfIJQfn (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 12:35:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:45534 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2436803AbfIJQfn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 12:35:43 -0400
Received: (qmail 498 invoked by uid 109); 10 Sep 2019 16:35:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Sep 2019 16:35:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16920 invoked by uid 111); 10 Sep 2019 16:37:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Sep 2019 12:37:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Sep 2019 12:35:42 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Freese <ericdfreese@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] for-each-ref: do not output empty lines
Message-ID: <20190910163541.GA13873@sigill.intra.peff.net>
References: <20190910051705.2765-1-ericdfreese@gmail.com>
 <20190910051705.2765-2-ericdfreese@gmail.com>
 <xmqqpnk8heow.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpnk8heow.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 09, 2019 at 11:02:07PM -0700, Junio C Hamano wrote:

> Eric Freese <ericdfreese@gmail.com> writes:
> 
> > If the format string expands to an empty string for a given ref, do not
> > print the empty line.
> >
> > This is helpful when wanting to print only certain kinds of refs that
> > you can't already filter for.
> 
> We tend to prefer stating the reason why we want to do so first and
> then give a command to the codebase to "become like so".  Here is to
> illustrate how you would do it:
> 
>     The custom format specifier "--format=<format>" can be used to
>     tell the for-each-ref command to say nothing for certain kind of
>     refs, e.g.
> 
>        --format="%(if)%(symref)%(then)%(else)%(refname)%(end)"
> 
>     may be used to show the refname only for refs that are not
>     symbolic refs.  Except that the command still would show one
>     blank line per each symbolic ref, which is fairly useless.
> 
>     Introduce the `--omit-empty-lines` option to squelch these
>     useless lines from the output.

Your proposed commit message (and the suggested code below) have a
command-line option, but Eric's patch does it by default. Which do we
want? :)

I'm inclined to say that this new behavior should be the default; even
though it's technically a compatibility change, I find it hard to
imagine people would see it as a regression.

But we could also introduce "--omit-empty-lines", and then flip the
default. That gives an escape hatch of "--no-omit-empty-lines", at the
minor cost of having to carry an option that we assume nobody would ever
use.

-Peff
