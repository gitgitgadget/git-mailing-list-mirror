Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2ADFA3740
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 02:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKACED (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 22:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKACEB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 22:04:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5523AF35
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 19:04:00 -0700 (PDT)
Received: (qmail 3856 invoked by uid 109); 1 Nov 2022 02:03:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 02:03:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17949 invoked by uid 111); 1 Nov 2022 02:04:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 Oct 2022 22:04:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 31 Oct 2022 22:03:58 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t5516/t5601: avoid using `localhost` for failing
 HTTPS requests
Message-ID: <Y2B+jn4goN4OIcwL@coredump.intra.peff.net>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <25cc0f6d91a9d23eb1b755e1463d672e4958a4e9.1667245639.git.gitgitgadget@gmail.com>
 <Y2BYKxxkG57XAV/1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2BYKxxkG57XAV/1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 07:20:11PM -0400, Jeff King wrote:

> > - The DNS resolver, or the local firewall, might take a substantial
> >   amount of time (or forever, whichever comes first) to fail to connect,
> >   slowing down the test cases unnecessarily.
> 
> Right. I think we assume that DNS resolution of localhost is fast-ish,
> as we use it in other https tests. But I could certainly imagine a local
> firewall causing issues (especially as this is real port 443, whereas
> our other tests are usually high ports).

Actually, I am wrong about DNS here. We use a bare 127.0.0.1 in
lib-httpd.sh, so DNS may indeed be the source of the issue here. That
_might_ mean that using the bare IP would be safe here, but I would not
want to bet on it. Using different port numbers, plus not expecting a
listener on the other end, might cause different outcomes than we see in
the other tests.

I do think moving these tests to use a real http server is a better
solution, though. I'll provide a patch in a moment.

-Peff
