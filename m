Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B1A2090A
	for <e@80x24.org>; Mon, 20 Mar 2017 20:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932277AbdCTU22 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 16:28:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:48054 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932244AbdCTU2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 16:28:24 -0400
Received: (qmail 22875 invoked by uid 109); 20 Mar 2017 20:27:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 20:27:59 +0000
Received: (qmail 6143 invoked by uid 111); 20 Mar 2017 20:28:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 16:28:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 16:27:55 -0400
Date:   Mon, 20 Mar 2017 16:27:55 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     'git' <git@vger.kernel.org>,
        "Jeff Hostetler (jeffhost@microsoft.com)" 
        <Jeff.Hostetler@microsoft.com>, Ben Peart <benpeart@microsoft.com>
Subject: Re: Safe to use stdatomic.h?
Message-ID: <20170320202755.ospj7o6dfczti6wp@sigill.intra.peff.net>
References: <000801d2a1b7$1ec41620$5c4c4260$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000801d2a1b7$1ec41620$5c4c4260$@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 04:18:20PM -0400, Ben Peart wrote:

> My college Jeff is working on a patch series to further parallelize the
> loading of the index.  As part of that patch, it would be nice to use the
> atomic_fetch_add function as that would be more efficient than creating a
> mutex simply to protect a variable so that it can be incremented.  I haven't
> seen any use of atomics yet in Git, nor anything that includes
> <stdatomic.h>.
> 
> GCC has supported them since 4.9 and Clang has supported them by default
> since 3.3.  Are there any compilers currently in use by Git that don't
> support these C11 functions?

Yes, there definitely are older compilers in use. However, if you can
abstract the operation you want to perform into its own function, it's
perfectly fine to #ifdef it to use the atomics when available and fall
back to a mutex otherwise.

-Peff
