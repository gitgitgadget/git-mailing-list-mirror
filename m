Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44F5C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 10:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9504461073
	for <git@archiver.kernel.org>; Wed, 19 May 2021 10:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345507AbhESKME (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 06:12:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:58802 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233957AbhESKMC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 06:12:02 -0400
Received: (qmail 22774 invoked by uid 109); 19 May 2021 10:10:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 May 2021 10:10:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18057 invoked by uid 111); 19 May 2021 10:10:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 May 2021 06:10:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 May 2021 06:10:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] help: colorize man pages
Message-ID: <YKTkIgdJgBomzieH@coredump.intra.peff.net>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <87im3fqci9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87im3fqci9.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 11:26:12AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > There's a big difference between Git coloring a Git UI, like a diff, and
> > Git coloring a separate program that already has sensible, standard
> > defaults.  A user who has not configured any color settings would
> > probably not want Git to render manual pages one way, cargo to render
> > manual pages a second way, and still other programs to render manual
> > pages in other, incompatible ways.  We need to consider not only the
> > impact that our decisions have in a vacuum, but what results similar
> > decisions from other projects would produce in the software ecosystem as
> > a whole.
> >
> > Would you consider various projects coloring their respective manual
> > pages differently to be a desirable state of affairs?
> 
> I think it's an important distinction that we're not coloring any manual
> pages, it's a question of whether we invoke "man" invoked by "git help
> <whatever>" with the exact same paramaters/options a user would get with
> "man git-<whatever>".
> 
> Right now our documentation seems to suggest that we won't do any such
> magic, but you can also set man.viewer to e.g. invoke a web browser or
> something instead of man(1).
> 
> I don't think it's confusing in that context if we learn to do some "man
> with fancy on top" in this mode.

I agree that we could explain it as "man with fancy on top". But it
makes me wonder: why is this Git's responsibility to do the fancy at
all?

I.e., if you want colorized manpages, why don't you configure man to do
so? Sure, it's a bit of a pain to do so since it involves setting a
bunch of obscure environment variables. But if that's what you want,
wouldn't you want it for all manpages, whether you ran "git help log" or
"man git-log" or "man ls"?

This seems like a "man" feature and not a "git" feature. And arguably
some of it is really a "less" feature (it is trying to set "standout"
mode for its prompt, so configuring "so" and "se" termcap entries is
just reinterpreting that. If you like, wouldn't you want it on for all
"less" invocations?).

-Peff
