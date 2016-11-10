Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CDBF20229
	for <e@80x24.org>; Thu, 10 Nov 2016 22:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936132AbcKJWf0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 17:35:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:41390 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932739AbcKJWfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 17:35:25 -0500
Received: (qmail 15682 invoked by uid 109); 10 Nov 2016 22:35:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 22:35:25 +0000
Received: (qmail 8722 invoked by uid 111); 10 Nov 2016 22:35:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 17:35:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2016 17:35:22 -0500
Date:   Thu, 10 Nov 2016 17:35:22 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andreas Schwab <schwab@suse.de>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] t6026-merge-attr: don't fail if sleep exits early
Message-ID: <20161110223522.4b35ojaz5nhk4sll@sigill.intra.peff.net>
References: <mvmtwbhdhvb.fsf@hawking.suse.de>
 <20161108200543.7ivo3xoafdl4uw6h@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611091437280.72596@virtualbox>
 <mvmzil8btzb.fsf@hawking.suse.de>
 <20161109153128.aqm2lgdntdlycnaq@sigill.intra.peff.net>
 <mvm8tsrbusp.fsf_-_@hawking.suse.de>
 <xmqqbmxn6t11.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611102254340.24684@virtualbox>
 <xmqq60nv55o3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60nv55o3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2016 at 02:30:36PM -0800, Junio C Hamano wrote:

> As everybody knows there is no appropriate timeout value that is
> good for everybody.  I wonder if we can replace the sleep 1 with
> something like
> 
> 	( while sleep 3600; do :; done ) &
> 
> so that leaked fd will be kept even in any heavily loaded
> environment instead?

I think you may have missed:

  http://public-inbox.org/git/16dc9f159b214997f7501006a8d1d8be2ef858e8.1478699463.git.johannes.schindelin@gmx.de/

which does roughly that. It does not loop, but I suspect 3600 is plenty
in practice.

I do think the test would be a lot more obvious if it confirmed at the
end of the test that the process was still running, as opposed to
relying on test_when_finished to check it.

-Peff
