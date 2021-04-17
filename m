Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD000C433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 08:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A119B61152
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 08:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhDQI6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 04:58:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:54940 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhDQI6b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 04:58:31 -0400
Received: (qmail 30012 invoked by uid 109); 17 Apr 2021 08:58:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Apr 2021 08:58:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2536 invoked by uid 111); 17 Apr 2021 08:58:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Apr 2021 04:58:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Apr 2021 04:58:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/8] rev-list: implement object type filter
Message-ID: <YHqjHA6ZUYvT6w1T@coredump.intra.peff.net>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
 <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net>
 <xmqqfsztlwxb.fsf@gitster.g>
 <YHbZNL0gzw0+1k5h@ncase>
 <xmqqmtu0y3r8.fsf@gitster.g>
 <YHgOCUI++AY/7zwX@coredump.intra.peff.net>
 <xmqqczuvsac6.fsf@gitster.g>
 <xmqq8s5jsa5c.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s5jsa5c.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 15, 2021 at 10:57:51AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > ...  But that leads me to
> > wonder into a different direction---coalesce (tag|tree|blob)_objects
> > members into a single bit, say all_objects, have "--objects" and
> > friends set that single bit, and update places like these to check
> > that single bit.
> 
> Just to avoid misunderstanding, I am not saying this topic needs to
> address any of this unifying of three bits.
> 
> It is just an idea for those interested to think about, when they
> have nothing better to do, when the codebase is quiescent.

It does feel like going "backwards" in a sense. We have the three flags
mostly split, and we'd lose that distinction. On the other hand, if the
current split is imperfect, it may be leading people down a confusing
path (I _think_ this "trees must be set in order to see blobs" thing is
the only real gotcha, but there could be others).

There's some other discussion in this old thread:

  https://lore.kernel.org/git/06a84f8c77924b275606384ead8bb2fd7d75f7b6.1487984670.git.jonathantanmy@google.com/

(I didn't remember it, but my spider sense tingling caused me to dig in
the archive a bit).

-Peff
