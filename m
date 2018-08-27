Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D089A1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 23:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeH1Cxh (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 22:53:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:58084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726994AbeH1Cxh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 22:53:37 -0400
Received: (qmail 8302 invoked by uid 109); 27 Aug 2018 23:04:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Aug 2018 23:04:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26956 invoked by uid 111); 27 Aug 2018 23:05:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 27 Aug 2018 19:05:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2018 19:04:52 -0400
Date:   Mon, 27 Aug 2018 19:04:52 -0400
From:   Jeff King <peff@peff.net>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can
 use bitmap' test
Message-ID: <20180827230452.GC10402@sigill.intra.peff.net>
References: <20180814114721.25577-1-szeder.dev@gmail.com>
 <20180827102238.GA26738@deco.navytux.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180827102238.GA26738@deco.navytux.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 10:22:46AM +0000, Kirill Smelkov wrote:

> A minor comment from outside observer: running tests under something
> like
> 
> 	-e and -o pipefail
> 
> would automatically catch the mistake in the first place. Maybe `-o
> pipefail` is bashism (I had not checked), but `git grep " | " t/` shows
> there are a lot of pipelines being used, and thus similar errors might be
> silently resting there. Something like -o pipefail would catch all such
> problems automatically.

Yes, "pipefail" is a bash-ism that we can't rely on.

I will say that I have been bitten before by "set -e -o pipefail" and
its subtle handling of SIGPIPE. Try this:

  set -e -o pipefail
  yes | head

-Peff
