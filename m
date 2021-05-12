Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5819BC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3012D6192B
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhELAvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 20:51:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:51660 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhELAvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 20:51:07 -0400
Received: (qmail 25270 invoked by uid 109); 12 May 2021 00:49:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 May 2021 00:49:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30781 invoked by uid 111); 12 May 2021 00:50:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 20:50:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 20:49:58 -0400
From:   Jeff King <peff@peff.net>
To:     Gregory Anders <greg@gpanders.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJsmNoLu9B0SgWz7@coredump.intra.peff.net>
References: <20210511204044.69047-1-greg@gpanders.com>
 <20210511234935.65147-1-greg@gpanders.com>
 <YJsas0d4XPsYYpI7@camp.crustytoothpaste.net>
 <YJsi1jbtNFDRKXmq@coredump.intra.peff.net>
 <YJslRhzOmSwD7V2E@gpanders.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJslRhzOmSwD7V2E@gpanders.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 06:45:58PM -0600, Gregory Anders wrote:

> > > Elsewhere we use the ! syntax we invoke the shell, and I would suggest
> > > that we do the same here.  That means we'll get PATH functionality by
> > > default and we'll let people do a modicum of scripting if they like.
> > 
> > Thanks for bringing that up. I agree it makes things more consistent
> > with other uses of "!", and certainly it's more flexible. It does
> > introduce an inconsistency with the absolute-path form, as I mentioned
> > in https://lore.kernel.org/git/YJsiKDNbKclFU00b@coredump.intra.peff.net/.
> > 
> > I don't know if that's a show-stopper or not. Certainly the
> > documentation can explain the difference, but it's nice to keep the
> > rules as simple as possible.
> > 
> > (My gut feeling is that consistency with other "!" places is more
> > important than consistency with the absolute-path form).
> > 
> > -Peff
> 
> We already have sendemail.smtpServerOption to add options:
> 
>     [sendemail]
>             smtpServer = !msmtp
>             smtpServerOption = -f
>             smtpServerOption = greg@gpanders.com
> 
> I agree that it's not the prettiest and it's a little annoying to have to
> specify the option multiple times, but I thought it worth mentioning before
> considering another way to do the same thing.

Thanks for bringing that up. I agree that does give back some of the
flexibility, but it is inconsistent with most other parts of Git.

> I also am curious what other's thoughts are on Felipe's suggestion to add a
> sendemail.program option, which would altogether remove the need to further
> overload sendemail.smtpServer:
> https://lore.kernel.org/git/609b0017a323b_6064920888@natae.notmuch/
> 
> IMO if we want to add the capability to run an arbitrary shell command as
> the smtpServer, this makes more sense to add as a dedicated
> sendemail.program option that has that functionality baked right in:
> 
>     [sendemail]
>             program = "msmtp -f greg@gpanders.com"

Our mails just crossed, but yeah, I think that would be a fine
direction.

-Peff
