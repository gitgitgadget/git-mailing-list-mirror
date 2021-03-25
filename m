Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF69FC433E5
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 00:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832E561A13
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 00:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbhCYAeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 20:34:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:48220 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232365AbhCYAdk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 20:33:40 -0400
Received: (qmail 16778 invoked by uid 109); 25 Mar 2021 00:33:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Mar 2021 00:33:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24179 invoked by uid 111); 25 Mar 2021 00:33:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Mar 2021 20:33:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Mar 2021 20:33:38 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 05/10] userdiff: add and use for_each_userdiff_driver()
Message-ID: <YFvaYokQJpvwSzJ6@coredump.intra.peff.net>
References: <20210224195129.4004-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
 <patch-05.11-64ea5e8443f-20210324T014604Z-avarab@gmail.com>
 <YFuPMMMYicFK6A/S@coredump.intra.peff.net>
 <87im5gp2ze.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87im5gp2ze.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 25, 2021 at 12:05:09AM +0100, Ævar Arnfjörð Bjarmason wrote:

> >   As an aside, it feels like this is something we ought to be able to
> >   ask git-config about, rather than having a test-helper. This is
> >   basically "baked-in" config, and if we represented it as such, and
> >   parsed it into a struct just like regular config, then probably "git
> >   config --list --source" could be used to find it (and differentiate it
> >   from user-provided config). Possible downsides:
> >
> >     1. Would people find it confusing that "git config --list" suddenly
> >        gets way bigger? Maybe we'd want an "--include-baked-in" option
> >        or something.
> >
> >     2. Is the cost of parsing the config measurably bad? Obviously a
> >        user could provide the same content and we'd have to parse it,
> >        but there's a lot more rules here than most users would probably
> >        provide.
> 
> Also:
> 
>  3. Only the PATTERNS() macro translates as-is to config syntax. We
>     don't have a way to do what IPATTERN() does in the config syntax
>     currently.
> 
>     We could add a ifuncname and xifuncname or whatever for it I guess,
>     but currently the ICASE behavior in the C code is magic.

Good point. IMHO that is something we should consider fixing
independently. It was a mistake to add builtins that couldn't be
replicated via the config (though I notice it happened quite a while
ago, and nobody seems to have cared, so perhaps it isn't that
important).

I have also wondered if we should just ship a file which could be
installed as /etc/gitconfig.filetypes and include it the stock
/etc/gitconfig. That is effectively the same as "baked in", but
hopefully makes it more clear to users how they can modify things.  But
all of that is somewhat orthogonal to what you're doing here.

-Peff
