Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB5BC48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 23:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBBC611CB
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 23:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhFXABP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 20:01:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:58940 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229726AbhFXABP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 20:01:15 -0400
Received: (qmail 8541 invoked by uid 109); 23 Jun 2021 23:57:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Jun 2021 23:57:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8242 invoked by uid 111); 23 Jun 2021 23:58:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jun 2021 19:58:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Jun 2021 19:58:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7] help: colorize man pages if man.color=true under
 less(1)
Message-ID: <YNPKwIuZvpyWSNXH@coredump.intra.peff.net>
References: <xmqq4ke8pig9.fsf@gitster.g>
 <patch-1.1-a950ef49e28-20210621T083254Z-avarab@gmail.com>
 <xmqqfsxbika3.fsf@gitster.g>
 <87mtrj2faq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtrj2faq.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 09:08:20PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > [snip] I think it would be easier to understand to end-users
> > if this were exposed as a new "mode", like "git help --web" and "git
> > help --info" are different modes from the "git help --man",
> > something like "git help --fancy-man" (or whatever is easy to type
> > and explain, and also add it to the variants help.format knows about
> > to make it easy to set the default).
> >
> > One advantage of doing so is that we do not have to worry about "ah,
> > user has LESS_BLAH environment variable so we should disable this
> > new mode here" etc.  As long as the new mode is requested either via
> > the command line option or help.format configuration, it can
> > completely take it over.  That simplifies the necessary explanation
> > given to the users quite a lot, no?
> 
> The interaction between "git help" and "man"/"less" doesn't really have
> an equivalent in the rest of git as far as color output goes. Usually we
> emit colors via our own programs.
> 
> But no, I think it makes the most sense to consider this orthagonal to
> help.format=man or man.viewer=<cmd>.
> 
> We're not invoking a different man viewer or command, we're just
> expecting that mode to invoke the pager, and if that pager is less to
> have these variables tweak our color preferences.

FWIW, if we are going to do this, then just having it as "color.man"
makes the most sense to me. It is easily explained as "when we invoke
man, set up some environment variables that may enable colors in the
output".

I'm still entirely unconvinced that this should be in Git at all;
pointing GIT_MAN_VIEWER or man.*.cmd at a color-man wrapper seems like
it would be sufficient. But it feels like that conversation was not
going anywhere productive; I mention it here only to indicate that my
response above is not an endorsement of the concept.

-Peff
