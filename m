Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79EF1F406
	for <e@80x24.org>; Fri, 12 Jan 2018 14:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933864AbeALOjP (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 09:39:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:42210 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933764AbeALOjO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 09:39:14 -0500
Received: (qmail 7157 invoked by uid 109); 12 Jan 2018 14:39:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 12 Jan 2018 14:39:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31260 invoked by uid 111); 12 Jan 2018 14:39:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 12 Jan 2018 09:39:48 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jan 2018 09:39:12 -0500
Date:   Fri, 12 Jan 2018 09:39:12 -0500
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'git mailing list' <git@vger.kernel.org>
Subject: Re: [BUG] Weird breakages in t1450 #2 on NonStop
Message-ID: <20180112143912.GB9088@sigill.intra.peff.net>
References: <003601d38aea$e0e08ff0$a2a1afd0$@nexbridge.com>
 <000201d38b24$9e27ac40$da7704c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000201d38b24$9e27ac40$da7704c0$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 11, 2018 at 04:39:04PM -0500, Randall S. Becker wrote:

> > executed because the test_commit fails with a non-zero git commit
> > completion code. There is no rn---- (actual r n 252 252 252 252) in
> > the objects directory - even the 'rn' does not correspond to
> > anything.. I am suspecting an unterminated string that ran into
> > freed memory somewhere, but that's speculative.
> 
> Does anyone recall fixing this one at or near
> dfe46c5ce6e68d682f80f9874f0eb107e9fee797? There was a rewrite of
> sha1_file.c including link_alt_odb_entry where I am finding memory
> corruptions. I think I'm chasing something that was already fixed some
> time after 2.13.5 but the common parent to where I am is pretty far
> back compared to master.

I did a lot of work on link_alt_odb_entry() in the past year or so, and
I seem to recall seeing some cases where we could run into unterminated
memory in the error message.

Maybe dc732bd5cb (read_info_alternates: read contents into strbuf,
2017-09-19)?

-Peff
