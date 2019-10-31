Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A70551F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 15:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfJaPsj (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 11:48:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:35040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726664AbfJaPsj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 11:48:39 -0400
Received: (qmail 17887 invoked by uid 109); 31 Oct 2019 15:48:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Oct 2019 15:48:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2518 invoked by uid 111); 31 Oct 2019 15:51:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2019 11:51:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Oct 2019 11:48:37 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] vreportf(): avoid relying on stdio buffering
Message-ID: <20191031154837.GB30187@sigill.intra.peff.net>
References: <pull.428.v2.git.1572356272.gitgitgadget@gmail.com>
 <pull.428.v3.git.1572379280.gitgitgadget@gmail.com>
 <fce0894ee46f737322551b51edf5cd2a53413a50.1572379280.git.gitgitgadget@gmail.com>
 <20191029203259.GB12337@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910300947410.46@tvgsbejvaqbjf.bet>
 <20191031062454.GB20830@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910311123010.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910311123010.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 31, 2019 at 11:26:30AM +0100, Johannes Schindelin wrote:

> > Another more far-fetched one: IIRC our stdio wrappers on Windows do some
> > magic to convert ANSI color codes into actual terminal codes. Could that
> > be a problem here? I think we'd kill off any color codes in the actual
> > message due to the control-code replacement. In theory the prefix could
> > have them. I don't think any code does now, but the PUSH_COLOR_ERROR
> > stuff in builtin/push.c is getting close. I wouldn't be surprised for
> > that to eventually get folded into error().
> 
> A valid concern!
> 
> As per eac14f8909d (Win32: Thread-safe windows console output,
> 2012-01-14), `write()` _implicitly_ gets the ANSI emulation of
> `winansi.c`.
> 
> So I think we're good.
> 
> Thanks for thinking of all kinds of angles,

Good. Thanks for humoring my wild speculation. :)

I remember being confused by this not too long ago, so I did a quick dig
in the archive. And indeed, there was a confusing comment which caught
me in 2016, and which you removed back then (via 3d0a83382f26). I even
reviewed the patch. Maybe this time I will remember the outcome!

-Peff
