Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E761F462
	for <e@80x24.org>; Sun,  9 Jun 2019 12:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfFIMgi (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 08:36:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:50058 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728319AbfFIMgi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 08:36:38 -0400
Received: (qmail 23639 invoked by uid 109); 9 Jun 2019 12:36:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Jun 2019 12:36:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19327 invoked by uid 111); 9 Jun 2019 12:37:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 09 Jun 2019 08:37:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2019 08:36:36 -0400
Date:   Sun, 9 Jun 2019 08:36:36 -0400
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190609123636.GA23555@sigill.intra.peff.net>
References: <20190531211041.GA19792@sigill.intra.peff.net>
 <20190601001231.GF4641@comcast.net>
 <20190603123435.GA18953@sigill.intra.peff.net>
 <20190603222247.GG4641@comcast.net>
 <20190604161332.GA29603@sigill.intra.peff.net>
 <20190604171952.GI4641@comcast.net>
 <20190604185108.GA14738@sigill.intra.peff.net>
 <20190604225921.GA43275@comcast.net>
 <20190604231418.GA12501@sigill.intra.peff.net>
 <20190604234951.GB43275@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190604234951.GB43275@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 04, 2019 at 04:49:51PM -0700, Matthew DeVore wrote:

> I tried to do it anyway :) I think this makes the strbuf API a bit easier to
> reason about, and strbuf.h is a bit more self-documenting. WDYT?
>
> [...]
>
> +typedef int (*char_predicate)(char ch);
> +
> +int is_rfc3986_unreserved(char ch);
> +int is_rfc3986_reserved_or_unreserved(char ch);
> +
>  void strbuf_addstr_urlencode(struct strbuf *sb, const char *name,
> -			     int reserved);
> +			     char_predicate allow_unencoded_fn);

Yeah, that seems reasonable. I worry slightly about adding function-call
overhead to something that's processing a string character-by-character,
but these strings tend to be short and infrequent.

-Peff
