Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 504A71FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 15:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbdBFPuQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 10:50:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:49797 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752109AbdBFPuP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 10:50:15 -0500
Received: (qmail 10954 invoked by uid 109); 6 Feb 2017 15:50:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 15:50:15 +0000
Received: (qmail 13924 invoked by uid 111); 6 Feb 2017 15:50:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 10:50:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2017 16:50:13 +0100
Date:   Mon, 6 Feb 2017 16:50:13 +0100
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w5h5dmluZCBBIC4=?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 3/5] stash: add test for the create command line
 arguments
Message-ID: <20170206155012.rb2vydjvlquchwk2@sigill.intra.peff.net>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170205202642.14216-4-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170205202642.14216-4-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 05, 2017 at 08:26:40PM +0000, Thomas Gummerer wrote:

> +test_expect_success 'create stores correct message' '
> +	>foo &&
> +	git add foo &&
> +	STASH_ID=$(git stash create "create test message") &&
> +	echo "On master: create test message" >expect &&
> +	git show --pretty=%s ${STASH_ID} | head -n1 >actual &&
> +	test_cmp expect actual
> +'

This misses failure exit codes from "git show" because it's on the left
side of a pipe. Perhaps "git show -s" or "git log -1" would get you the
same output without needing "head" (and saving a process and the time
spent generating the diff, as a bonus).

Ditto in the other tests from this patch and later ones.

-Peff
