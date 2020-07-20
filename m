Return-Path: <SRS0=kUNO=A7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9852C433E2
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 20:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F503207DF
	for <git@archiver.kernel.org>; Mon, 20 Jul 2020 20:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgGTUVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:21:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:33782 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728973AbgGTUVl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 16:21:41 -0400
Received: (qmail 24741 invoked by uid 109); 20 Jul 2020 20:21:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Jul 2020 20:21:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16301 invoked by uid 111); 20 Jul 2020 20:21:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Jul 2020 16:21:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Jul 2020 16:21:40 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, chriscool@tuxfamily.org
Subject: Re: [PATCH 2/4] upload-pack.c: allow banning certain object filter(s)
Message-ID: <20200720202140.GA2059161@coredump.intra.peff.net>
References: <cover.1593720075.git.me@ttaylorr.com>
 <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
 <20200715100043.GG11341@szeder.dev>
 <20200715105521.GB3262157@coredump.intra.peff.net>
 <20200720200739.GB91942@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720200739.GB91942@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 20, 2020 at 04:07:39PM -0400, Taylor Blau wrote:

> Heh. I was hoping to be rid of those errors with Christian's patches,
> but it sounds like the problem is coming from outside of 'upload-pack'
> and instead in 'clone'.

Yes, it's definitely on the client side.

> That reasoning seems sound to me, but I'd rather not touch clone in this
> patch series if I don't have to. What I'd rather do is something like:
> 
>   - Introduce this patch series with the 'test_must_fail ok=sigpipe',
>     and no error checking.
> 
>   - Modify clone to swallow these errors and eat a packet or two.
> 
>   - Then, drop the 'ok=sigpipe' from t5616 after 'git clone' is a little
>     bit smarter here.
> 
> Maybe more steps than is strictly necessary, but I think it keeps the
> scope of the review on this series reasonable, which is a tradeoff that
> I'm willing to make.

I think that's reasonable.

It doesn't look like the "pump the read side after EPIPE" patch is even
on the "seen" branch yet, and you'd need to further extend it to clone.
It's definitely a big enough change that it's better not to lump it in
with this series.

-Peff
