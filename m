Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C50520248
	for <e@80x24.org>; Tue,  5 Mar 2019 04:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfCEEMB (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 23:12:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:38754 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726522AbfCEEMA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 23:12:00 -0500
Received: (qmail 659 invoked by uid 109); 5 Mar 2019 04:12:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 04:12:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28482 invoked by uid 111); 5 Mar 2019 04:12:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 23:12:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 23:11:58 -0500
Date:   Mon, 4 Mar 2019 23:11:58 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>
Subject: Re: [PATCH 1/2] fetch: avoid calling write_or_die()
Message-ID: <20190305041158.GB19800@sigill.intra.peff.net>
References: <20190303165447.GA31116@sigill.intra.peff.net>
 <20190303165537.GA23755@sigill.intra.peff.net>
 <CACsJy8BWp9+SDwcXv_a6aFN=YSoQN3E7sOGDRm5a6Pi7QhzexQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BWp9+SDwcXv_a6aFN=YSoQN3E7sOGDRm5a6Pi7QhzexQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 04, 2019 at 08:42:40PM +0700, Duy Nguyen wrote:

> > -       } else
> > -               write_or_die(fd, buf->buf, buf->len);
> > +       } else {
> > +               if (write_in_full(fd, buf->buf, buf->len) < 0)
> > +                       die_errno("unable to write to remote");
> 
> maybe _() these strings.

Good thinking. I just sent an update in another part of the thread.

-Peff
