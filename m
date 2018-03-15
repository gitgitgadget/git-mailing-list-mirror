Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71F491F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbeCOR7i (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:59:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:58516 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752262AbeCOR7i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:59:38 -0400
Received: (qmail 2854 invoked by uid 109); 15 Mar 2018 17:59:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Mar 2018 17:59:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20176 invoked by uid 111); 15 Mar 2018 18:00:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Mar 2018 14:00:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Mar 2018 13:59:35 -0400
Date:   Thu, 15 Mar 2018 13:59:35 -0400
From:   Jeff King <peff@peff.net>
To:     Michele Locati <michele@locati.it>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] filter-branch: return 2 when nothing to rewrite
Message-ID: <20180315175935.GA8752@sigill.intra.peff.net>
References: <20180315130359.6108-1-michele@locati.it>
 <20180315170918.1984-1-michele@locati.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315170918.1984-1-michele@locati.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 06:09:18PM +0100, Michele Locati wrote:

> Using the --state-branch option allows us to perform incremental filtering.
> This may lead to having nothing to rewrite in subsequent filtering, so we need
> a way to recognize this case.
> So, let's exit with 2 instead of 1 when this "error" occurs.

Thanks, this looks good to me.

I did have one other thought while reading this, but I think it's OK to
leave as-is:

> +EXIT STATUS
> +-----------
> +
> +On success, the exit status is `0`.  If the filter can't find any commits to
> +rewrite, the exit status is `2`.  On any other error, the exit status may be
> +any other non-zero value.

I wondered if people might take "any commits to rewrite" to also mean
the case where the filters do not actually change any commits (e.g, and
index filter which removes a path that does not exist). That's currently
a successful outcome but does issue a warning; it's not changed by this
patch at all (and nor should it be).

If we wanted to make that more clear, we could perhaps mention the
--state-branch option here explicitly. Not sure if it's worth it.

-Peff
