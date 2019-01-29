Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62CA31F453
	for <e@80x24.org>; Tue, 29 Jan 2019 22:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfA2Wv0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 17:51:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:54100 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727426AbfA2Wv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 17:51:26 -0500
Received: (qmail 22413 invoked by uid 109); 29 Jan 2019 22:51:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Jan 2019 22:51:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11820 invoked by uid 111); 29 Jan 2019 22:51:31 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 Jan 2019 17:51:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2019 17:51:22 -0500
Date:   Tue, 29 Jan 2019 17:51:22 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Dmitriy Smirnov <dmitriy.smirnov@jetbrains.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org,
        Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
        Aleksey Pivovarov <aleksey.pivovarov@jetbrains.com>
Subject: Re: git add =?utf-8?B?4oCUaWdub3JlLWVycm9y?= =?utf-8?Q?s?= causes
 --renormalize
Message-ID: <20190129225121.GD1895@sigill.intra.peff.net>
References: <401130AF-056B-40BF-8001-8492223B8A6B@jetbrains.com>
 <20190117162711.GA7935@sigill.intra.peff.net>
 <20190129213533.GE13764@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129213533.GE13764@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 10:35:33PM +0100, SZEDER Gábor wrote:

> t0025 with '--stress' usually fails within seconds when run on the
> merge of 'jk/add-ignore-errors-bit-assignment-fix' and 'master' [1]:

Thanks for the pointer. I mostly cargo-culted the test from the rest of
that script, so I didn't think too hard about race conditions. I think
the key difference is that the other tests are _actually_ using
--renormalize, which is going to re-hash the files and notice the line
ending change. And my test is not, so it will sometimes notice and
sometimes not.

It seems like we could probably solve it through some clever tweaking of
mtimes to make sure we have a consistent timestamp setup, but it's
resisting my quick efforts. I'm at an airport traveling right now, so I
may not get to it for a day or three.

-Peff
