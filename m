Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 538971F461
	for <e@80x24.org>; Fri, 12 Jul 2019 21:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfGLV6Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 17:58:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:35336 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727245AbfGLV6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 17:58:24 -0400
Received: (qmail 30892 invoked by uid 109); 12 Jul 2019 21:58:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Jul 2019 21:58:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5054 invoked by uid 111); 12 Jul 2019 21:59:20 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Jul 2019 17:59:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2019 16:58:16 -0500
Date:   Fri, 12 Jul 2019 16:58:16 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 0/5] oidmap: handle entries with the same key
Message-ID: <20190712215815.GB3593@sigill.intra.peff.net>
References: <20190707083002.7037-1-chriscool@tuxfamily.org>
 <xmqqd0ikxok6.fsf@gitster-ct.c.googlers.com>
 <xmqqlfx3p0zo.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfx3p0zo.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 12, 2019 at 11:21:47AM -0700, Junio C Hamano wrote:

> > Christian Couder <christian.couder@gmail.com> writes:
> >
> >> This is an RFC patch series that is not intended to be merged for now,
> >> as it looks like we don't need oidmaps that can handle several entries
> >> with the same key yet.
> >
> > What does it even mean for a map to allow multiple entries per key?
> 
> Ah, one thing that I was missing (perhaps it was obvious to
> everybody else but me X-<) was that this is merely to expose what is
> already available in the underlying hashmap API, so let's not bother
> with the "don't people usually do a single key to a value, which
> happens to be a bag of stuff (not just a single stuff)?" question.
> 
> And from that "a generic hashmap can do this, and an upcoming code
> needs to use a hashmap keyed with oid in the same fashion" point of
> view, the new wrappers the patches add all made sense to me.

FWIW, I went through the same thought process. :)

One devil's advocate point against, though: we found recently that khash
performs much better than hashmap.[ch] for the oidset data structure.
AFAIK nobody has looked at whether the same is true for oidmap. But if
it is, then this strategy may make it harder to switch.

(OTOH, we already have kh_oid_map, so the two could probably co-exist
and we could just convert particular callers from one to the other).

> > I actually think that showing how it is used in the real application
> > (reftable?) is the best way to illustrate why this is useful and to
> > get opinions from others.
> 
> This part still stands, though.

Agreed.

-Peff
