Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C7CC34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 05:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E1D2176D
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 05:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgBRFYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 00:24:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:46522 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725832AbgBRFYj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 00:24:39 -0500
Received: (qmail 14426 invoked by uid 109); 18 Feb 2020 05:24:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 05:24:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14578 invoked by uid 111); 18 Feb 2020 05:33:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 00:33:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 00:24:38 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 06/15] rev-list: make --count work with --objects
Message-ID: <20200218052438.GB1641086@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
 <20200214182220.GF150965@coredump.intra.peff.net>
 <20200215004216.GA15192@syl.local>
 <20200215064818.GB1633703@coredump.intra.peff.net>
 <xmqqwo8mm7ii.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwo8mm7ii.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 16, 2020 at 03:34:13PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> > +	if (revs->count) {
> >> > +		revs->count_right++;
> >> > +		return;
> >> > +	}
> >> > +
> >> 
> >> Hmm. This puzzled me at first. Do you think that it could benefit from a
> >> comment?
> >
> > What would it say (i.e., I'm not sure what confused you)?
> 
> I think the question reader had was "why *right*?"

Ah. The answer is: because it's not SYMMETRIC_LEFT. ;)

The counting code accumulates there by default when there are no side
markings, so that's what it will report when there's no left_right or
cherry_mark (which we know will be the case here, since we die()
otherwise).

-Peff
