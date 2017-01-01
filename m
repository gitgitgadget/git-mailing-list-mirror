Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2411C1FEB3
	for <e@80x24.org>; Sun,  1 Jan 2017 05:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750839AbdAAF7x (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 00:59:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:33677 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbdAAF7x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 00:59:53 -0500
Received: (qmail 27369 invoked by uid 109); 1 Jan 2017 05:59:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 01 Jan 2017 05:59:53 +0000
Received: (qmail 6412 invoked by uid 111); 1 Jan 2017 06:00:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 01 Jan 2017 01:00:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Jan 2017 00:59:48 -0500
Date:   Sun, 1 Jan 2017 00:59:48 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 21/23] try_remove_empty_parents(): don't accommodate
 consecutive slashes
Message-ID: <20170101055947.7b5jxih3wlprqcil@sigill.intra.peff.net>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <c7a89febcbf7bdffb44f8fdf63a43f11339a0289.1483153436.git.mhagger@alum.mit.edu>
 <xmqqvatz4imu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvatz4imu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 31, 2016 at 06:30:01PM -0800, Junio C Hamano wrote:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > "refname" has already been checked by check_refname_format(), so it
> > cannot have consecutive slashes.
> 
> In the endgame state, this has two callers.  Both use what came in
> the transaction->updates[] array.  Presumably "has already been
> checked by check_refname_format()" says that whoever created entries
> in that array must have called the function, but it would be helpful
> to be more explicit here.

Hmm, yeah. This is called when we are deleting a ref, and I thought we
explicitly _didn't_ do check_refname_format() when deleting, so that
funny-named refs could be deleted. It's only is_refname_safe() that we
must pass.

So I have no idea if that's a problem in the code or not, but it is at
least not immediately obvious who is responsible for calling
check_refname_format() here.

-Peff
