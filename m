Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E65A220A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 09:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbeLKJub (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 04:50:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:37800 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726441AbeLKJu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 04:50:27 -0500
Received: (qmail 12194 invoked by uid 109); 11 Dec 2018 09:50:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 09:50:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3491 invoked by uid 111); 11 Dec 2018 09:49:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 04:49:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 04:50:02 -0500
Date:   Tue, 11 Dec 2018 04:50:02 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        stolee@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v3 2/3] commit-graph: fix buffer read-overflow
Message-ID: <20181211095002.GB31588@sigill.intra.peff.net>
References: <cover.1544127439.git.steadmon@google.com>
 <cover.1544221121.git.steadmon@google.com>
 <675d58ecea2f315bd05d2a21f6a473e9de1105a0.1544221121.git.steadmon@google.com>
 <xmqqsgz74acm.fsf@gitster-ct.c.googlers.com>
 <20181210215649.GC37614@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181210215649.GC37614@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 01:56:49PM -0800, Josh Steadmon wrote:

> > "stat(1)" is not so portable, so you'll get complaints from minority
> > platform users later.  So is "truncate(1)".
> 
> Ack, thanks for the catch. I have a workaround for stat in the form of
> "wc -c", and for truncate with a combination of dd and /dev/zero.
> However, I'm finding conflicting information about whether or not
> /dev/zero exists on macOS. At the least, it sounds like it might not
> work on very old versions. Would this be acceptable, or should I add a
> new test function to do this?

If you're just interested in truncation (and not a bunch of zero bytes),
you can dd from /dev/null.

Another way to truncate is to move the file elsewhere, and then copy
only some of the bytes back (see t1450's "fsck detects truncated loose
object").

-Peff
