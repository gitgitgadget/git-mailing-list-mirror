Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D7AE1F42D
	for <e@80x24.org>; Wed, 23 May 2018 22:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934516AbeEWWMw (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 18:12:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:50682 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934491AbeEWWMv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 18:12:51 -0400
Received: (qmail 26532 invoked by uid 109); 23 May 2018 22:12:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 May 2018 22:12:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19562 invoked by uid 111); 23 May 2018 22:12:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 23 May 2018 18:12:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 May 2018 18:12:49 -0400
Date:   Wed, 23 May 2018 18:12:49 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, B.Steinbrink@gmx.de
Subject: Re: [PATCH 1/2] t6101: add a test for rev-parse $garbage^@
Message-ID: <20180523221249.GC32171@sigill.intra.peff.net>
References: <CABPp-BFOwWvDpfLFa2yrUDU_3BU6F68oLTtO5FvQo8nr62_WtQ@mail.gmail.com>
 <20180523204613.11333-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180523204613.11333-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 23, 2018 at 01:46:12PM -0700, Elijah Newren wrote:

> diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
> index 8c617981a3..7b1b2dbdf2 100755
> --- a/t/t6101-rev-parse-parents.sh
> +++ b/t/t6101-rev-parse-parents.sh
> @@ -214,4 +214,8 @@ test_expect_success 'rev-list merge^-1x (garbage after ^-1)' '
>  	test_must_fail git rev-list merge^-1x
>  '
>  
> +test_expect_failure 'rev-parse $garbage^@ should not segfault' '
> +	git rev-parse ffffffffffffffffffffffffffffffffffffffff^@
> +'

Two small nits. :)

It may just be me, but for a trivial test+fix like this, I'd rather see
them in the same commit (both for reviewing, and when I'm digging in the
history later).

The second nit is that we may want to use something a little more
symbolic and easier to read here. Thirty-nine f's behaves quite
differently than forty. And eventually we'd like to move away from
having hard-coded commit ids anyway (this is obviously a fake one, but
the length may end up changing).

Perhaps "git rev-parse $EMPTY_TREE^@", which triggers the same bug?

-Peff
