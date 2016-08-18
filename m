Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BAB31F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 13:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbcHRNrd (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 09:47:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:57384 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754101AbcHRNrc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 09:47:32 -0400
Received: (qmail 7449 invoked by uid 109); 18 Aug 2016 13:47:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Aug 2016 13:47:30 +0000
Received: (qmail 14133 invoked by uid 111); 18 Aug 2016 13:47:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Aug 2016 09:47:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Aug 2016 09:47:27 -0400
Date:	Thu, 18 Aug 2016 09:47:27 -0400
From:	Jeff King <peff@peff.net>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 0/3] limit the size of the packs we receive
Message-ID: <20160818134727.qqfsxpmek73dgi5h@sigill.intra.peff.net>
References: <20160818131553.22580-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160818131553.22580-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 18, 2016 at 03:15:50PM +0200, Christian Couder wrote:

> Diff with previous v1 version
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> diff --git a/t/t5546-push-limits.sh b/t/t5546-push-limits.sh
> index b38d508..09e958f 100755
> --- a/t/t5546-push-limits.sh
> +++ b/t/t5546-push-limits.sh
> @@ -11,11 +11,11 @@ test_expect_success 'create remote repository' '
>  # When the limit is 1, `git receive-pack` will call `git index-pack`.
>  # When the limit is 10, `git receive-pack` will call `git unpack-objects`.
>  
> -while read unpacklimit filesize filename
> +while read unpacklimit filesize filename seed
>  do
>  
>  	test_expect_success "create known-size ($filesize bytes) commit '$filename'" '
> -		test-genrandom foo "$filesize" >"$filename" &&
> +		test-genrandom "$seed" "$filesize" >"$filename" &&
>  		git add "$filename" &&
>  		test_commit "$filename"
>  	'
> @@ -35,8 +35,8 @@ do
>  	'
>  
>  done <<\EOF
> -1 1024 one-k-file
> -10 2048 two-k-file
> +1 1024 one-k-file foo
> +10 1024 other-one-k-file bar
>  EOF
>  
>  test_done

This is still not quite what I would have written, but I don't think
it's worth arguing over.

This version looks OK to me. Thanks.

-Peff
