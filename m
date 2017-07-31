Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 908B3208A0
	for <e@80x24.org>; Mon, 31 Jul 2017 03:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbdGaDkk (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 23:40:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:53114 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751674AbdGaDkj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 23:40:39 -0400
Received: (qmail 28475 invoked by uid 109); 31 Jul 2017 03:40:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 31 Jul 2017 03:40:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22945 invoked by uid 111); 31 Jul 2017 03:40:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 30 Jul 2017 23:40:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Jul 2017 23:40:37 -0400
Date:   Sun, 30 Jul 2017 23:40:37 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 08/10] tag: respect `pager.tag` in list-mode only
Message-ID: <20170731034037.smkfrfd3nuka3zlc@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com>
 <cover.1500321657.git.martin.agren@gmail.com>
 <ca309a7d46027c2804b82813600aaf96f65ca01b.1500321658.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca309a7d46027c2804b82813600aaf96f65ca01b.1500321658.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 17, 2017 at 10:10:50PM +0200, Martin Ågren wrote:

>  test_expect_success TTY 'git tag -a respects --paginate' '
>  	test_when_finished "git tag -d newtag" &&
>  	rm -f paginated.out &&
> -	test_terminal git -c pager.tag=false --paginate \
> -		tag -am message newtag &&
> +	test_terminal git --paginate tag -am message newtag &&
> +	test -e paginated.out
> +'

This changes, I guess, because pager.tag should not be having any impact
at all. So it would not hurt to leave it, but the in the final state of
the test what is interesting is that "--paginate" kicks in. I do wonder
if it could just drop the pager.tag bit when it is added in the first
place. We test elsewhere that the command-line overrides the config (for
a case that actually _does_ respect the config).

I'm OK with it either way, though.

-Peff
