Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 716451F90A
	for <e@80x24.org>; Thu, 12 Jul 2018 15:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeGLQGN (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 12:06:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:56944 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726725AbeGLQGN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 12:06:13 -0400
Received: (qmail 1379 invoked by uid 109); 12 Jul 2018 15:56:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Jul 2018 15:56:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23497 invoked by uid 111); 12 Jul 2018 15:56:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 12 Jul 2018 11:56:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jul 2018 11:56:03 -0400
Date:   Thu, 12 Jul 2018 11:56:03 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] t5541: clean up truncating access log
Message-ID: <20180712155602.GA8889@sigill.intra.peff.net>
References: <20180711125647.16512-1-szeder.dev@gmail.com>
 <20180712122216.12691-1-szeder.dev@gmail.com>
 <20180712122216.12691-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180712122216.12691-2-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 02:22:14PM +0200, SZEDER Gábor wrote:

> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> index a2af693068..5c9ca19401 100755
> --- a/t/t5541-http-push-smart.sh
> +++ b/t/t5541-http-push-smart.sh
> @@ -38,6 +38,10 @@ GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
>  POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
>  EOF
>  test_expect_success 'no empty path components' '
> +	# Clear the log, so that it does not affect the "used receive-pack
> +	# service" test which reads the log too.
> +	test_when_finished ">\"$HTTPD_ROOT_PATH\"/access.log" &&

I think you want to escape the $ here, too, so the eval sees the
variable and not its expanded value.

Other than that, this iteration looks good (and patch 3 is much easier
to read).

-Peff
