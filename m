Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24B7A1F991
	for <e@80x24.org>; Tue,  8 Aug 2017 07:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbdHHH3C (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 03:29:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:60032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751880AbdHHH3C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 03:29:02 -0400
Received: (qmail 5074 invoked by uid 109); 8 Aug 2017 07:29:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Aug 2017 07:29:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13618 invoked by uid 111); 8 Aug 2017 07:29:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Aug 2017 03:29:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Aug 2017 03:28:59 -0400
Date:   Tue, 8 Aug 2017 03:28:59 -0400
From:   Jeff King <peff@peff.net>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: reftable [v6]: new ref storage format
Message-ID: <20170808072859.iho6uns5q7mc5ydc@sigill.intra.peff.net>
References: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 06, 2017 at 06:47:06PM -0700, Shawn Pearce wrote:

> Changes from v5:
> - extensions.refStorage = reftable is used to select this format.

Thanks, I think this is a better scheme going forward. Just a few notes
on compatibility while I'm thinking about it:

  - existing versions will complain that they don't know what the
    "refStorage" extension is

  - presumably we'd add new code that recognizes the extension, and then
    makes sure the value is something we understand.

  - then we'd finally mark "reftable" as understood once we had an
    implementation. We _could_ then also check other config (like
    "reftable.*") and complain about unknown keys. But I think we could
    declare any such keys as optional, and just rely on the version
    number inside the reftable file for parsing it.

-Peff
