Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D352C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 05:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A67061278
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 05:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbhGOFTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 01:19:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:50418 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238195AbhGOFTR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 01:19:17 -0400
Received: (qmail 6410 invoked by uid 109); 15 Jul 2021 05:16:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jul 2021 05:16:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31728 invoked by uid 111); 15 Jul 2021 05:16:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jul 2021 01:16:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Jul 2021 01:16:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs file backend: remove dead "errno == EISDIR" code
Message-ID: <YO/EpxU0NG+HVSlx@coredump.intra.peff.net>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <YO8PBBJZ2Q+5ZqFs@coredump.intra.peff.net>
 <871r801yp6.fsf@evledraar.gmail.com>
 <YO9wCqetxHii+TvK@coredump.intra.peff.net>
 <875yxczbd6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yxczbd6.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 02:02:40AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Maybe that is splitting hairs, but I definitely try to err on the side
> > of caution and over-analysis when touching tricky code (and the
> > ref-backend code is in my experience one of the trickiest spots for
> > corner cases, races, etc).
> 
> I'd entirely forgotten about this, but I had a patch to remove that
> "oid" call entirely, as it's really an unrelated bug/undesired behavior
> 
> You also looked at it at the time & Michael Haggerty reviewed it:
> https://lore.kernel.org/git/20190315155959.12390-9-avarab@gmail.com/
> 
> The state of that patch was that I needed to get to some minor issues
> with it (commit message rewording, cleaning up some related callers),
> but the fundamental approach seemed good.
> 
> I then split it off from the v4 of that series to get the non-tricky
> changes in:
> https://lore.kernel.org/git/20190328161434.19200-1-avarab@gmail.com/
> 
> I then just never got to picking it up again, I'll probably re-roll it &
> make it a part of this series, then we can remove this whole OID != NULL
> case and will be sure nothing fishy's going on.

Yeah, that sounds like a good path forward. I do think the patch under
discussion here is probably the right thing to do. But it becomes all
the more obvious if lock_ref_oid_basic() ends up dropping that parameter
entirely.

-Peff
