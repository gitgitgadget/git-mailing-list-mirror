Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BFFC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA6F610A6
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhHYAQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 20:16:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:58326 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233890AbhHYAQO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 20:16:14 -0400
Received: (qmail 21033 invoked by uid 109); 25 Aug 2021 00:15:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Aug 2021 00:15:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3301 invoked by uid 111); 25 Aug 2021 00:15:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Aug 2021 20:15:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Aug 2021 20:15:26 -0400
From:   Jeff King <peff@peff.net>
To:     Marvin =?utf-8?Q?H=C3=A4user?= <mhaeuser@posteo.de>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] send-email propagates "In-Reply-To"
Message-ID: <YSWLnlkF/BuyI0yi@coredump.intra.peff.net>
References: <4db7759c-2123-533b-9f89-954c07f5832a@posteo.de>
 <YSPOOGxTMEgStdjJ@coredump.intra.peff.net>
 <5cd5a58b-ac9e-4628-a8d3-836b1f795732@posteo.de>
 <YSPomC95hxZZTHRe@coredump.intra.peff.net>
 <2412df60-f8ee-ab0f-08b2-20a0b6b641fa@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2412df60-f8ee-ab0f-08b2-20a0b6b641fa@posteo.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 09:47:28PM +0000, Marvin Häuser wrote:

> > You'd want something like the patch below (and possibly something
> > similar for the $subject handling).
> 
> Thanks a lot! my last question for the patch would now be, how do I use your
> snippet? Do I add you to S-o-b of the single patch, do I split the patches
> with the second S-o-b being yours, or do I submit only the first and you
> will submit the second?

The usual thing is to just squash it into your patch. You can say
something like "Test cases from Jeff King." in the commit message to
give credit (though I am happy either way). And then ideally you'd have
my sign-off to make it clear the code matches the DCO. So here it is
(and you can just stick this before your sign-off at the end of the
commit message):

Signed-off-by: Jeff King <peff@peff.net>

And then for the rest, you can follow the guide in
Documentation/SubmittingPatches. Presumably you're comfortable using
send-email, given the topic of the patch. :) But since you're got the
patch on GitHub already, you can also use https://gitgitgadget.github.io.

> > Both of the new tests fail without your patch and pass with it, but:
> > 
> >    - note the weird behavior I found with --in-reply-to; this is
> >      something we might want to address at the same time
> 
> I think this case must error? The definition of the "--in-reply-to" does not
> declare it as a default, so it must be enforced (and it is), but it's also
> very unintuitive the file value is discarded. Who would decide the behaviour
> spec?

Given the text Carlo found in the documentation, I think this is the
intended behavior. So I think we can make it part of the expected
behavior in the test. I do still think that second test is worth having.
An obvious-but-wrong thing to do here would be to set $in_reply_to to
undef after the first iteration through the loop, rather than the value
given on the command-line. The test makes sure we get that right.

-Peff
