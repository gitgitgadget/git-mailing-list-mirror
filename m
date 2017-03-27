Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FE441FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 22:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbdC0WpP (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 18:45:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:52633 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752522AbdC0WpO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 18:45:14 -0400
Received: (qmail 18371 invoked by uid 109); 27 Mar 2017 22:45:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Mar 2017 22:45:08 +0000
Received: (qmail 29213 invoked by uid 111); 27 Mar 2017 22:45:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Mar 2017 18:45:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Mar 2017 18:45:05 -0400
Date:   Mon, 27 Mar 2017 18:45:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 0/2] read-cache: call verify_hdr() in a background
 thread
Message-ID: <20170327224505.ngp2gel3yvqcjrhw@sigill.intra.peff.net>
References: <1490648979-49580-1-git-send-email-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1490648979-49580-1-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2017 at 09:09:37PM +0000, git@jeffhostetler.com wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Version 2 of this patch series simplifies this to just
> turn off the hash verification.  Independent comments
> from Linus and Peff suggested that we could just turn
> this off and not worry about it.  So I've updated this
> patch to do that.  I added a global variable to allow
> the original code path to be used.  I also added a
> t/helper command to demonstrate the differences.
> 
> On the Linux repo, the effect is rather trivial:
> 
>     $ ~/work/gfw/t/helper/test-skip-verify-index -c 3
>     0.029884 0 [cache_nr 57994]
>     0.031035 0 [cache_nr 57994]
>     0.024308 0 [cache_nr 57994]
>     0.028409 0 avg
>     0.018359 1 [cache_nr 57994]
>     0.017025 1 [cache_nr 57994]
>     0.011087 1 [cache_nr 57994]
>     0.015490 1 avg
> 
> On my Windows source tree (450MB index), I'm seeing a
> savings of 0.6 seconds -- read_index() went from 1.2 to 0.6
> seconds.

Very satisfying. I assume that was with OpenSSL as the SHA-1
implementation (sha1dc would have been much slower on 450MB, I think).

-Peff
