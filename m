Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03B961F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 19:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbeGMT5V (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 15:57:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:58866 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730149AbeGMT5V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 15:57:21 -0400
Received: (qmail 619 invoked by uid 109); 13 Jul 2018 19:41:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Jul 2018 19:41:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6673 invoked by uid 111); 13 Jul 2018 19:41:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 13 Jul 2018 15:41:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2018 15:41:19 -0400
Date:   Fri, 13 Jul 2018 15:41:19 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
Message-ID: <20180713194119.GC10354@sigill.intra.peff.net>
References: <0a18acbd-0124-1c92-0046-05b8b035dd28@ramsayjones.plus.com>
 <20180628174501.GC31766@sigill.intra.peff.net>
 <db7683ab-1025-d7bb-d0ce-fc4ee28681e1@ramsayjones.plus.com>
 <20180628220332.GA5128@sigill.intra.peff.net>
 <9162ed69-d245-8b2f-0dcc-3b345264b029@ramsayjones.plus.com>
 <20180703143416.GA23556@sigill.intra.peff.net>
 <80fad203-8196-c4b6-ed9e-10def0890d59@ramsayjones.plus.com>
 <20180707013239.GA4687@sigill.intra.peff.net>
 <2ad1b00c-70ff-c4b2-8cbc-9ef55c174221@ramsayjones.plus.com>
 <6b323eff-a0a6-d8d3-1e40-70af8299db5f@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b323eff-a0a6-d8d3-1e40-70af8299db5f@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 13, 2018 at 08:37:46PM +0100, Ramsay Jones wrote:

> OK, so I found some time to test this tonight. It is not good
> news (assuming that I haven't messed up the testing, of course). :(

I think you may have. :)

>   not ok 18 - push rejects corrupt .gitmodules (policy)
>   #	
>   #		rm -rf dst.git &&
>   #		git init --bare dst.git &&
>   #		git -C dst.git config transfer.fsckObjects true &&
>   #		git -C dst.git config fsck.gitmodulesParse error &&
>   #		test_must_fail git -C corrupt push ../dst.git HEAD 2>output &&
>   #		grep gitmodulesParse output &&
>   #		test_i18ngrep ! "bad config" output

There are separate config slots for local fsck versus receiving objects.
So I think you need to be setting receive.fsck.gitmodulesParse.

-Peff
