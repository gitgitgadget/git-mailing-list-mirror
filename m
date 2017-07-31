Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E0A120899
	for <e@80x24.org>; Mon, 31 Jul 2017 03:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbdGaDiP (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 23:38:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:53106 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751615AbdGaDiO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 23:38:14 -0400
Received: (qmail 28366 invoked by uid 109); 31 Jul 2017 03:38:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 31 Jul 2017 03:38:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22926 invoked by uid 111); 31 Jul 2017 03:38:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 30 Jul 2017 23:38:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Jul 2017 23:38:12 -0400
Date:   Sun, 30 Jul 2017 23:38:12 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 06/10] t7006: add tests for how git tag paginates
Message-ID: <20170731033812.tvclfckx3ascxa2m@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com>
 <cover.1500321657.git.martin.agren@gmail.com>
 <f4334503b677bbbeb19660e501ad2d7213428953.1500321658.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4334503b677bbbeb19660e501ad2d7213428953.1500321658.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 17, 2017 at 10:10:48PM +0200, Martin Ågren wrote:

> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index 20b4d83c2..e7430bc93 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -134,6 +134,74 @@ test_expect_success TTY 'configuration can enable pager (from subdir)' '
>  	}
>  '
>  
> +test_expect_success TTY 'git tag -l defaults to not paging' '
> +	rm -f paginated.out &&
> +	test_terminal git tag -l &&
> +	! test -e paginated.out
> +'

I don't mind an expect_success like this, where it documents a sane and
existing default, even if we're going to flip that default later in the
series.

But here...

> +test_expect_success TTY 'git tag -a respects pager.tag' '
> +	test_when_finished "git tag -d newtag" &&
> +	rm -f paginated.out &&
> +	test_terminal git -c pager.tag tag -am message newtag &&
> +	test -e paginated.out
> +'

I think this behavior is just buggy, and it might be better introduced
as a test_expect_failure on "git tag -a does not respect pager.tag".

Kind of a minor nit, as the series should end up in the right place
either way, but it can be helpful if you end up digging back in history
to the introduction of the test.

-Peff
