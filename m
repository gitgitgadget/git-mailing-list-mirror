Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57903C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 16:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D74E61029
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 16:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhG0Qqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 12:46:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:58706 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhG0Qqk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 12:46:40 -0400
Received: (qmail 30720 invoked by uid 109); 27 Jul 2021 16:46:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jul 2021 16:46:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32731 invoked by uid 111); 27 Jul 2021 16:46:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jul 2021 12:46:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jul 2021 12:46:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        emilyshaffer@google.com, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] send-pack: fix push nego. when remote has refs
Message-ID: <YQA4bzFxdOHSQva7@coredump.intra.peff.net>
References: <cover.1624486920.git.jonathantanmy@google.com>
 <cover.1626370766.git.jonathantanmy@google.com>
 <c8416933035849e40b88c29f1d5fa91064ca0c8a.1626370766.git.jonathantanmy@google.com>
 <87v94wqi6k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v94wqi6k.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 10:09:35AM +0200, Ævar Arnfjörð Bjarmason wrote:

> I.e. now we make the implicit assumption that an OID we see in the
> advertisement is one the server isn't going to aggressively prune while
> our push is underday (Jeff King has a good E-Mail summarizing that
> somewhere, not digging it up now, but I could...).
> 
> So such a remote will negotiate with us using that OID, but unlike with
> advertised OIDs we can't safely assume that the OID won't be racily
> deleted during our negotiation.

I haven't been following the push-negotiation stuff closely, nor do I
have a specific email in mind that summarizes this. So take my input
with a grain of salt. But...

Wouldn't this also be a problem for multi-round fetch negotiation? An
object may become unreachable or even go away entirely during the course
of a fetch. I'd expect that to be rare, but when it does happen, for the
fetch to end up barfing (the server says "hey, I don't know about that
object").

-Peff
