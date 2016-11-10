Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A101120229
	for <e@80x24.org>; Thu, 10 Nov 2016 23:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933704AbcKJXEA (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 18:04:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:41431 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756140AbcKJXD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 18:03:59 -0500
Received: (qmail 17486 invoked by uid 109); 10 Nov 2016 23:03:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 23:03:59 +0000
Received: (qmail 9244 invoked by uid 111); 10 Nov 2016 23:04:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 18:04:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2016 18:03:56 -0500
Date:   Thu, 10 Nov 2016 18:03:56 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andreas Schwab <schwab@suse.de>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] t6026-merge-attr: don't fail if sleep exits early
Message-ID: <20161110230356.3is53qysegv637hf@sigill.intra.peff.net>
References: <20161108200543.7ivo3xoafdl4uw6h@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611091437280.72596@virtualbox>
 <mvmzil8btzb.fsf@hawking.suse.de>
 <20161109153128.aqm2lgdntdlycnaq@sigill.intra.peff.net>
 <mvm8tsrbusp.fsf_-_@hawking.suse.de>
 <xmqqbmxn6t11.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611102254340.24684@virtualbox>
 <xmqq60nv55o3.fsf@gitster.mtv.corp.google.com>
 <20161110223522.4b35ojaz5nhk4sll@sigill.intra.peff.net>
 <xmqq1syj54j9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1syj54j9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2016 at 02:55:06PM -0800, Junio C Hamano wrote:

> If we ensure that the process is still running, then such a check is
> a good belt-and-suspenders way to catch a breakage in the mechanism
> we choose to ensure it.  So probably we can require that the kill in
> the "when finished" part to actually send a signal to a process that
> is still running.
> 
> Is there an equivalent to pause(2) available to shell scripts?  I
> really hate a single "sleep 3600" or anything with a magic number.

I think it is usually spelled "read <some-fifo", but we can't use FIFOs
here because Windows doesn't have them. You could probably do something
with "read <&9" and set up descriptor 9 in the test code. But frankly,
that gets complex pretty quickly, as you have to background things.

This minor issue isn't worth it.  Just bumping the sleep to 3600 makes
the raciness problem go away, and everything works in practice. That's
probably good enough for our purposes.

-Peff
