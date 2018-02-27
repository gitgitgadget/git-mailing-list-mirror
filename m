Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC211F404
	for <e@80x24.org>; Tue, 27 Feb 2018 22:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeB0WI0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 17:08:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:39548 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751801AbeB0WIY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 17:08:24 -0500
Received: (qmail 9879 invoked by uid 109); 27 Feb 2018 22:08:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Feb 2018 22:08:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28082 invoked by uid 111); 27 Feb 2018 22:09:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Feb 2018 17:09:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Feb 2018 17:08:21 -0500
Date:   Tue, 27 Feb 2018 17:08:21 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] test_must_be_empty: make sure the file exists, not just
 empty
Message-ID: <20180227220821.GC11187@sigill.intra.peff.net>
References: <20180223233951.11154-1-szeder.dev@gmail.com>
 <20180223233951.11154-5-szeder.dev@gmail.com>
 <xmqqtvu2p2kx.fsf@gitster-ct.c.googlers.com>
 <xmqqpo4qp290.fsf@gitster-ct.c.googlers.com>
 <xmqqh8q2p1ha.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8q2p1ha.fsf_-_@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 01:27:29PM -0800, Junio C Hamano wrote:

> The helper function test_must_be_empty is meant to make sure the
> given file is empty, but its implementation is:
> 
> 	if test -s "$1"
> 	then
> 		... not empty, we detected a failure ...
> 	fi
> 
> Surely, the file having non-zero size is a sign that the condition
> "the file must be empty" is violated, but it misses the case where
> the file does not even exist.  It is an accident waiting to happen
> with a buggy test like this:
> 
> 	git frotz 2>error-message &&
> 	test_must_be_empty errro-message
> 
> that won't get caught until you deliberately break 'git frotz' and
> notice why the test does not fail.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This seems like a huge and obvious improvement to me. I'm amazed it
hasn't come up before (and that this doesn't reveal any existing typos
like the one you showed).

-Peff
