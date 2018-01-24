Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88F511F404
	for <e@80x24.org>; Wed, 24 Jan 2018 20:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932155AbeAXUgs (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 15:36:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:55998 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932072AbeAXUgs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 15:36:48 -0500
Received: (qmail 30210 invoked by uid 109); 24 Jan 2018 20:36:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Jan 2018 20:36:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28377 invoked by uid 111); 24 Jan 2018 20:37:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 15:37:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 15:36:45 -0500
Date:   Wed, 24 Jan 2018 15:36:45 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kim Gybels <kgybels@infogroep.be>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/6] struct snapshot: store `start` rather than
 `header_len`
Message-ID: <20180124203645.GC7773@sigill.intra.peff.net>
References: <cover.1516791909.git.mhagger@alum.mit.edu>
 <2adb70b238a5f7f65f19344007e1743cc96644b8.1516791909.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2adb70b238a5f7f65f19344007e1743cc96644b8.1516791909.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 12:14:11PM +0100, Michael Haggerty wrote:

> Store a pointer to the start of the actual references within the
> `packed-refs` contents rather than storing the length of the header.
> This is more convenient for most users of this field.

This makes sense. It means that the "start" pointer needs to be
invalidated if "buf" ever changes. But that was pretty much the case
already with "header_len" (because "buf" is not a heap buffer that we
might realloc; if it ever changes it is because we re-read the file, and
we would have to re-parse the header length anyway).

-Peff
