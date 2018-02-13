Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58CFA1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 22:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965993AbeBMWWu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 17:22:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:51406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965935AbeBMWWt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 17:22:49 -0500
Received: (qmail 31565 invoked by uid 109); 13 Feb 2018 22:22:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 13 Feb 2018 22:22:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23950 invoked by uid 111); 13 Feb 2018 22:23:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 13 Feb 2018 17:23:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Feb 2018 17:22:47 -0500
Date:   Tue, 13 Feb 2018 17:22:47 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t6300-for-each-ref: fix "more than one quoting style"
 tests
Message-ID: <20180213222247.GA18401@sigill.intra.peff.net>
References: <20180213003601.7396-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180213003601.7396-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 01:36:01AM +0100, SZEDER Gábor wrote:

> 'git for-each-ref' should error out when invoked with more than one
> quoting style options.  The tests checking this have two issues:
> 
>   - They run 'git for-each-ref' upstream of a pipe, hiding its exit
>     code, thus don't actually checking that 'git for-each-ref' exits
>     with error code.
> 
>   - They check the error message in a rather roundabout way.
> 
> Ensure that 'git for-each-ref' exits with an error code using the
> 'test_must_fail' helper function, and check its error message by
> grepping its saved standard error.

Yeah, this looks much nicer than the original.

>  for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
>  	test_expect_success "more than one quoting style: $i" "
> -		git for-each-ref $i 2>&1 | (read line &&
> -		case \$line in
> -		\"error: more than one quoting style\"*) : happy;;
> -		*) false
> -		esac)
> +		test_must_fail git for-each-ref $i 2>err &&
> +		grep '^error: more than one quoting style' err

I suspect in the long run this ought to be test_i18ngrep, but since it's
not localized yet, it makes sense to stop here with this patch.

-Peff
