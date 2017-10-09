Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5776120372
	for <e@80x24.org>; Mon,  9 Oct 2017 13:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754801AbdJINm5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 09:42:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:46886 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755076AbdJINm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 09:42:56 -0400
Received: (qmail 14868 invoked by uid 109); 9 Oct 2017 13:37:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Oct 2017 13:37:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16332 invoked by uid 111); 9 Oct 2017 13:42:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Oct 2017 09:42:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Oct 2017 09:42:53 -0400
Date:   Mon, 9 Oct 2017 09:42:53 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        ramsay@ramsayjones.plus.com, sbeller@google.com
Subject: Re: [PATCH v4 3/4] sha1_name: parse less while finding common prefix
Message-ID: <20171009134253.y2chrtd2hjaaaimm@sigill.intra.peff.net>
References: <20171008184942.69444-1-dstolee@microsoft.com>
 <20171008184942.69444-4-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171008184942.69444-4-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 08, 2017 at 02:49:41PM -0400, Derrick Stolee wrote:

> +static inline char get_hex_char_from_oid(const struct object_id *oid,
> +					 int pos)
> +{
> +	static const char hex[] = "0123456789abcdef";
> +
> +	if ((pos & 1) == 0)
> +		return hex[oid->hash[pos >> 1] >> 4];
> +	else
> +		return hex[oid->hash[pos >> 1] & 0xf];
> +}

Should "pos" be unsigned? I don't think it matters much in practice (as
long as it's not negative, the results are well defined by the standard,
and this clearly will be between 0 and 40). But it seems funny that we
consistently use unsigned in the rest of the caller and then implicitly
convert to signed here.

-Peff
