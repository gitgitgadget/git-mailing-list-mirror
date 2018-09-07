Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A8F1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 00:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbeIGEmX (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 00:42:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:42122 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725921AbeIGEmX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 00:42:23 -0400
Received: (qmail 6501 invoked by uid 109); 7 Sep 2018 00:04:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Sep 2018 00:04:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10001 invoked by uid 111); 7 Sep 2018 00:04:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 20:04:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 20:04:24 -0400
Date:   Thu, 6 Sep 2018 20:04:24 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 01/11] string_list: print_string_list to use trace_printf
Message-ID: <20180907000423.GA16764@sigill.intra.peff.net>
References: <20180904230149.180332-1-sbeller@google.com>
 <20180904230149.180332-2-sbeller@google.com>
 <xmqqh8j236wj.fsf@gitster-ct.c.googlers.com>
 <20180906165602.GA19367@sigill.intra.peff.net>
 <CAGZ79kbRyVZ_1QpX0pPigN+2Pt2dV1eYvLyoWeSWejbLxko4YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbRyVZ_1QpX0pPigN+2Pt2dV1eYvLyoWeSWejbLxko4YQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 03:16:21PM -0700, Stefan Beller wrote:

> > It seems funny that we'd iterate through the list checking over and over
> > whether tracing is enabled.
> >
> > Should this do:
> >
> >   if (!trace_want(&trace_default_key))
> >         return;
> >
> > at the top? (Or possibly even take a trace key from the caller, so that
> > it can use whatever context makes sense for this particular list?)
> 
> I added this check as well as rewording the commit message
> to recite Junios understanding of the patch as well.
> 
> However I would want to not derail this patch any further.
> This function was used as an aid by me some time ago, so I
> am willing to share the modifications needed for efficient
> printf debugging here, but I do not want to be dragged into
> a rabbit hole.
> 
> For example taking the trace key is much overkill IMHO
> for a pure debugging aid (and so is the shortcutting return
> that you proposed, but I added that already for the resend),
> so if anyone needs this function outside of printf-debugging,
> I would recommend patches on top.

I guess the question is: is this a thing we would want to make available
to code to leave in all the time? Or is it just for sticking in
temporarily for a quick dump?

If the former, then I think it needs the early-return at the least (and
probably _should_ have the key parameter).

But I get the feeling that you really just want the latter, and are only
grudgingly being pushed into the former by Junio's suggestion.

-Peff
