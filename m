Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9216F201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 20:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbdBYUNH (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 15:13:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:34127 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751879AbdBYUNG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 15:13:06 -0500
Received: (qmail 2914 invoked by uid 109); 25 Feb 2017 20:12:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 20:12:40 +0000
Received: (qmail 21398 invoked by uid 111); 25 Feb 2017 20:12:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 15:12:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Feb 2017 15:12:38 -0500
Date:   Sat, 25 Feb 2017 15:12:38 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] commit: be more precise when searching for headers
Message-ID: <20170225201238.wkujdwg4jyvovelm@sigill.intra.peff.net>
References: <23989e76-24ba-90a4-91a9-9f66bfccb7c9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23989e76-24ba-90a4-91a9-9f66bfccb7c9@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 25, 2017 at 08:21:52PM +0100, René Scharfe wrote:

> Search for a space character only within the current line in
> read_commit_extra_header_lines() instead of searching in the whole
> buffer (and possibly beyond, if it's not NUL-terminated) and then
> discarding any results after the end of the current line.
> [...]
> -		eof = strchr(line, ' ');
> -		if (next <= eof)
> +		eof = memchr(line, ' ', next - line);
> +		if (!eof)
>  			eof = next;

Nice. More efficient, and I think the intent is more clear.

-Peff
