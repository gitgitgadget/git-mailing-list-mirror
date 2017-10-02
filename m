Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4CA202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750978AbdJBFvB (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:51:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:57196 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750944AbdJBFvA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:51:00 -0400
Received: (qmail 7592 invoked by uid 109); 2 Oct 2017 05:51:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 05:51:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25899 invoked by uid 111); 2 Oct 2017 05:51:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 01:51:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 01:50:58 -0400
Date:   Mon, 2 Oct 2017 01:50:58 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 07/11] apply: remove `newfd` from `struct apply_state`
Message-ID: <20171002055058.uue7uajfqtkntxjg@sigill.intra.peff.net>
References: <cover.1506862824.git.martin.agren@gmail.com>
 <cede314e90ece6e4168634f5469f6c6f9883e375.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cede314e90ece6e4168634f5469f6c6f9883e375.1506862824.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 04:56:08PM +0200, Martin Ågren wrote:

> Similar to a previous patch, we do not need to use `newfd` to signal
> that we have a lockfile to clean up. We can just unconditionally call
> `rollback_lock_file`. If we do not hold the lock, it will be a no-op.
> 
> Where we check `newfd` to decide whether we need to take the lock, we
> can instead use `is_lock_file_locked()`.

Looks good. I was surprised you didn't have to replace any writing to
"newfd". But the writing it all happens via write_locked_index(), which
directly accesses the lock's fd member.

-Peff
