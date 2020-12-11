Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C504AC4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 17:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ABC323DC2
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 17:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404541AbgLKQLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 11:11:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:58504 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732956AbgLKQLL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 11:11:11 -0500
Received: (qmail 9728 invoked by uid 109); 11 Dec 2020 16:10:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Dec 2020 16:10:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8278 invoked by uid 111); 11 Dec 2020 16:10:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Dec 2020 11:10:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Dec 2020 11:10:25 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 2/6] config: add new way to pass config via
 `--config-env`
Message-ID: <X9OZ8YcydvXQZCap@coredump.intra.peff.net>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <766ffe31a6f14c55d1b58a8f53edbb7f731b1b24.1607514692.git.ps@pks.im>
 <871rfzxctq.fsf@evledraar.gmail.com>
 <X9D6IyPchkGkYgeB@coredump.intra.peff.net>
 <X9NzEfzjvdnvnX42@ncase>
 <X9OAcgPxyYIJo+J/@coredump.intra.peff.net>
 <X9OICyWMn0sSRb/3@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X9OICyWMn0sSRb/3@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 03:54:03PM +0100, Patrick Steinhardt wrote:

> > Yeah, if you're willing to. I don't mind spinning it off into its own
> > series if you don't want to (the tricky part is that we're touching a
> > couple of the same spots, though, so if you're willing to pick them up,
> > I think that makes coordination easier).
> > 
> 
> I can do so. The only question that I have is whether I should rebase it
> on top of 6/6 or on top of 2/6. It's hard for me to gauge whether 6/6 is
> going to make it in or not due to the conflicting opinions on it. It
> currently seems to me like we tend towards a "no", which is also what
> the "What's cooking" report said. But there were also some opinions in
> favor of it, which made me wonder. If this is a definitive "no", then
> I'm happy to stop bothering with them to make the patch series easier to
> manage.

I'd probably do it on top of 2/6 (well, perhaps shuffling 4/6 forward is
needed, then, I think). And then that punts the decision.

As for the general idea of 6/6, I think I'm a soft "no" there. Normally
my opinion for things I wouldn't use myself is "hey, go to town, if
you're willing to write the patch and it won't hurt anybody else". My
only reservation is that it's a public-facing interface, so we'll have
to support it forever. And I don't love the interface.

That's not a reflection on how you did the series, btw. I think you've
done a very good job of trying to address everyone's concerns, and
balance them with having a way to get data through the environment that
doesn't require error-prone quoting and parsing. But at the end, I think
we are left with a fundamental tradeoff: an interface that is clunky
because of the counted variables, or one if that is clunky because of
the quoting.

(And by "soft no", I just mean that I wouldn't pursue it further in your
shoes, but I'm not going to strenuously object if you and others want to
go forward).

-Peff
