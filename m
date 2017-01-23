Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 284F020A17
	for <e@80x24.org>; Mon, 23 Jan 2017 23:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbdAWXyt (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 18:54:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:43530 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbdAWXys (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 18:54:48 -0500
Received: (qmail 6331 invoked by uid 109); 23 Jan 2017 23:54:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Jan 2017 23:54:47 +0000
Received: (qmail 28032 invoked by uid 111); 23 Jan 2017 23:55:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Jan 2017 18:55:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jan 2017 18:54:45 -0500
Date:   Mon, 23 Jan 2017 18:54:45 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] string-list: make string_list_sort() reentrant
Message-ID: <20170123235445.qsejumltutd2vrhd@sigill.intra.peff.net>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 22, 2017 at 06:47:18PM +0100, René Scharfe wrote:

> Use qsort_s() from C11 Annex K to make string_list_sort() safer, in
> particular when called from parallel threads.
> 
> Changes from v1:
> * Renamed HAVE_QSORT_S to HAVE_ISO_QSORT_S in Makefile to disambiguate.
> * Added basic perf test (patch 3).
> * Converted a second caller to QSORT_S, in ref-filter.c (patch 5).

This looks nicely done overall, and I appreciate the perf test.

The speed looks like a reasonable outcome. I'm torn on the qsort_r()
demo patch. I don't think it looks too bad. OTOH, I don't think I would
want to deal with the opposite-argument-order versions.

Is there any interest in people adding the ISO qsort_s() to their libc
implementations? It seems like it's been a fair number of years by now.

-Peff
