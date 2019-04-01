Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74162202BB
	for <e@80x24.org>; Mon,  1 Apr 2019 13:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfDANaC (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 09:30:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:42900 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726834AbfDANaC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 09:30:02 -0400
Received: (qmail 25197 invoked by uid 109); 1 Apr 2019 13:30:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 01 Apr 2019 13:30:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13223 invoked by uid 111); 1 Apr 2019 13:30:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 01 Apr 2019 09:30:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Apr 2019 09:30:00 -0400
Date:   Mon, 1 Apr 2019 09:30:00 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] progress: clear previous progress update
 dynamically
Message-ID: <20190401132959.GB11664@sigill.intra.peff.net>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
 <20190401115217.3423-1-szeder.dev@gmail.com>
 <20190401115217.3423-4-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190401115217.3423-4-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 01, 2019 at 01:52:16PM +0200, SZEDER Gábor wrote:

> diff --git a/progress.c b/progress.c
> index 842db14b72..3149ecd460 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -84,6 +84,7 @@ static void display(struct progress *progress, uint64_t n, const char *done)
>  	const char *tp;
>  	struct strbuf *counters_sb = &progress->counters_sb;
>  	int show_update = 0;
> +	int last_count_len = counters_sb->len;

I don't think it could matter here, as these are meant to be smallish
strings, but I think we should get into the habit of using size_t
consistently to hold string lengths.

It makes auditing for integer overflow problems much simpler (this is on
my mind as I happen to be tracing some bugs around this the past few
days).

(There are a few instances in the next patch, too. Other than this nit,
though, your series looks good to me).

-Peff
