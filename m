Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E470220282
	for <e@80x24.org>; Fri, 23 Jun 2017 18:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754853AbdFWS7q (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 14:59:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:50886 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754327AbdFWS7q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 14:59:46 -0400
Received: (qmail 10206 invoked by uid 109); 23 Jun 2017 18:59:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 18:59:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17900 invoked by uid 111); 23 Jun 2017 18:59:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 14:59:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 14:59:43 -0400
Date:   Fri, 23 Jun 2017 14:59:43 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 01/29] t1408: add a test of stale packed refs covered
 by loose refs
Message-ID: <20170623185943.noczrssjjigomezx@sigill.intra.peff.net>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
 <4eca5010979e86fa25d95b68d3f266d7f74d168b.1498200513.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4eca5010979e86fa25d95b68d3f266d7f74d168b.1498200513.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 09:01:19AM +0200, Michael Haggerty wrote:

> +test_expect_success setup '
> +	test_tick &&
> +	git commit --allow-empty -m one &&
> +	one=$(git rev-parse HEAD) &&
> +	git for-each-ref >actual &&
> +	echo "$one commit	refs/heads/master" >expect &&
> +	test_cmp expect actual &&
> +
> +	git pack-refs --all &&
> +	git for-each-ref >actual &&
> +	echo "$one commit	refs/heads/master" >expect &&
> +	test_cmp expect actual &&
> +
> +	cat .git/packed-refs &&

I think we'd usually drop debugging "cat"s like these in the name of
keeping the process count down. Unless they really are intended to
confirm that .git/packed-refs exists (although test_path_is_file is a
less expensive way of checking that).

That's a minor nit, though.

-Peff
