Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8DF1F404
	for <e@80x24.org>; Sat, 27 Jan 2018 16:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeA0Qri (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 11:47:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:59796 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752397AbeA0Qri (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 11:47:38 -0500
Received: (qmail 17218 invoked by uid 109); 27 Jan 2018 16:47:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 27 Jan 2018 16:47:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24769 invoked by uid 111); 27 Jan 2018 16:48:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 27 Jan 2018 11:48:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Jan 2018 11:47:35 -0500
Date:   Sat, 27 Jan 2018 11:47:35 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] format-patch: reduce patch diffstat width to 72
Message-ID: <20180127164735.GA23478@sigill.intra.peff.net>
References: <20180122123154.8301-1-pclouds@gmail.com>
 <20180125115927.16196-1-pclouds@gmail.com>
 <20180125115927.16196-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180125115927.16196-3-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 06:59:27PM +0700, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
> index 9f563db20a..1e62333b46 100755
> --- a/t/t4052-stat-output.sh
> +++ b/t/t4052-stat-output.sh
> @@ -60,7 +60,7 @@ do
>  		test_cmp expect actual
>  	'
>  done <<\EOF
> -format-patch -1 --stdout
> +format-patch --stat=80 -1 --stdout
>  diff HEAD^ HEAD --stat
>  show --stat
>  log -1 --stat

This hunk confused me. I think what is going on is this:

  - we have a loop that runs the same test on several commands

  - that loop expects format-patch, diff, etc, to have the same output

  - now that format-patch differs from the other commands in its default
    length, we need to use a manual --stat-width to get identical output

It seems like that kind of nullifies the point of some of the tests in
the loop, though, since they are meant to check the behavior without
--stat.

OTOH, I think that case is tested later (in the other tests you
adjusted). So I guess these tests are just covering the "name vs bar
length" part?

-Peff
