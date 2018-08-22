Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E224A1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeHVTzg (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:55:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:51836 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726550AbeHVTzg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:55:36 -0400
Received: (qmail 21080 invoked by uid 109); 22 Aug 2018 16:30:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Aug 2018 16:30:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1177 invoked by uid 111); 22 Aug 2018 16:30:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 12:30:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 12:30:00 -0400
Date:   Wed, 22 Aug 2018 12:30:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] t0020-crlf: check the right file
Message-ID: <20180822163000.GB11904@sigill.intra.peff.net>
References: <20180822124437.11242-1-szeder.dev@gmail.com>
 <xmqqo9du5qlf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9du5qlf.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 09:11:08AM -0700, Junio C Hamano wrote:

> This originates from fd777141 ("t0020: fix ignored exit code inside
> loops", 2015-03-25) where a loop
> 
>     for f in one dir/two
>     do
>             do things on "$f" || break
>     done
> 
> was unrolled to correctly break out of the &&-chain.  The filenames
> on the update-index line correctly copied one and dir/two, but the
> has_cr line somehow lost dir/ prefix.
> 
> Thanks.  Will queue.

Whoops, my error. Thanks for catching it.

> > diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
> > index 5f056982a5..854da0ae16 100755
> > --- a/t/t0020-crlf.sh
> > +++ b/t/t0020-crlf.sh
> > @@ -160,7 +160,7 @@ test_expect_success 'checkout with autocrlf=input' '
> >  	git config core.autocrlf input &&
> >  	git read-tree --reset -u HEAD &&
> >  	test_must_fail has_cr one &&
> > -	test_must_fail has_cr two &&
> > +	test_must_fail has_cr dir/two &&

I think I'm also responsible for these mis-uses of test_must_fail, which
probably ought to be "!".

-Peff
