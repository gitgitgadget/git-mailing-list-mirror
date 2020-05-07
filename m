Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C91C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 14:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6213E20575
	for <git@archiver.kernel.org>; Thu,  7 May 2020 14:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgEGOrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 10:47:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:40304 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726218AbgEGOrM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 10:47:12 -0400
Received: (qmail 32664 invoked by uid 109); 7 May 2020 14:47:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 14:47:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18200 invoked by uid 111); 7 May 2020 14:47:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 10:47:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 10:47:10 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] upload-pack: fix filter options scope
Message-ID: <20200507144710.GA3063766@coredump.intra.peff.net>
References: <20200507095829.16894-1-chriscool@tuxfamily.org>
 <20200507113624.GA3027470@coredump.intra.peff.net>
 <CAP8UFD3AqUGrE2W3Qg_+z6HnobmRpOEyNEdspmDPGggKUqyK+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3AqUGrE2W3Qg_+z6HnobmRpOEyNEdspmDPGggKUqyK+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 02:32:39PM +0200, Christian Couder wrote:

> > A client who does this is stupid and wrong (and I didn't check the
> > protocol spec, but it could very well be violating the spec). So I don't
> > think it's _that_ big a deal. But it would be nice if all of those
> > globals got moved into upload_pack_data, and both v1 and v2 just used it
> > consistently.
> 
> Unfortunately as I discuss a bit above 'struct upload_pack_data' is
> not used by v1, only by v2. I think making v1 use upload_pack_data
> might be nice, but it's a separate issue. So I am tempted to just
> improve the commit message, adding some information from you and from
> this discussion, and then re-sending.
> 
> Another intermediate solution would be to add filter_options to
> 'struct upload_pack_data' for v2 and to use filter_options directly
> for v1.

I think we do want the v1 path to use upload_pack_data in the long run,
just to keep things less confusing.

But if you don't want to go that far now, I'd strongly prefer the second
option, pushing v2 towards how we ultimately want it to look, and
plumbing a local variable through v1 paths as necessary. Or perhaps just
renaming the global to filter_options_v1 or something, so that v2 code
paths aren't tempted to use it.

-Peff
