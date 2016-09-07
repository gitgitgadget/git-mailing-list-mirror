Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 234751F859
	for <e@80x24.org>; Wed,  7 Sep 2016 20:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932867AbcIGULn (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 16:11:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:39615 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752124AbcIGULM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 16:11:12 -0400
Received: (qmail 22455 invoked by uid 109); 7 Sep 2016 20:11:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 20:11:10 +0000
Received: (qmail 7616 invoked by uid 111); 7 Sep 2016 20:11:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 16:11:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 16:11:07 -0400
Date:   Wed, 7 Sep 2016 16:11:07 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Wendler <polynomial-c@gentoo.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Knut Franke <k.franke@science-computing.de>,
        git@vger.kernel.org, "Robin H. Johnson" <robbat2@gentoo.org>,
        lekto@o2.pl
Subject: Re: segfault in http.c when https URL is mistyped
Message-ID: <20160907201107.sgb7upqpzyap45bd@sigill.intra.peff.net>
References: <20160907151607.2b288034@abudhabi.paradoxon.rec>
 <20160907154404.107fe6e6@abudhabi.paradoxon.rec>
 <20160907200642.5o3otxxt7ybw6x4c@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160907200642.5o3otxxt7ybw6x4c@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2016 at 04:06:42PM -0400, Jeff King wrote:

> +test_expect_success 'remote-http complains cleanly about malformed urls' '
> +	# do not actually issue "list" or other commands, as we do not
> +	# want to rely on what curl would actually do with such a broken
> +	# URL. This is just about making sure we do not segfault during
> +	# initialization.
> +	test_must_fail git remote-http http::/example.com/repo.git
> +'

Actually, I guess remote-http actually sees just "/example.com/repo.git"
for the case we're discussing. It segfaults with either input without
this patch, and works with it, though.

(I didn't test "git clone" directly because it hides the segfault made
by the remote helper, so we cannot tell the difference between a
segfault and "this URL is broken").

-Peff
