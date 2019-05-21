Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 704611F462
	for <e@80x24.org>; Tue, 21 May 2019 21:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfEUV1q (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 17:27:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:35390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727222AbfEUV1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 17:27:46 -0400
Received: (qmail 1510 invoked by uid 109); 21 May 2019 21:27:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 May 2019 21:27:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17323 invoked by uid 111); 21 May 2019 21:28:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 May 2019 17:28:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 May 2019 17:27:44 -0400
Date:   Tue, 21 May 2019 17:27:44 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] trace2: fix tracing when NO_PTHREADS is defined
Message-ID: <20190521212744.GC14807@sigill.intra.peff.net>
References: <pull.222.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.222.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 21, 2019 at 12:33:58PM -0700, Jeff Hostetler via GitGitGadget wrote:

> As Duy suggested, pthread_getspecific() just returns NULL when NO_PTHREADS
> is defined. And pthread_setspecific() silently does not nothing. So this
> problem was hidden from view.
> 
> I have to wonder if we should update pthread_*specific() to call BUG() when
> NO_PTHREADS is defined as a way to catch unguarded usages easier or make
> this issue more clear.

I think it should actually store the data asked for by the caller, as if
we were the single thread running. We discussed this as the time of
refactoring NO_PTHREADS, but there was only one caller that would have
benefited. Now there are two. ;)

Discussion in the subthread of this patch:

  https://public-inbox.org/git/20181027071003.1347-2-pclouds@gmail.com/

-Peff
