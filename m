Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD891FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 18:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbcLFSb2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 13:31:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:52637 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbcLFSbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 13:31:25 -0500
Received: (qmail 4569 invoked by uid 109); 6 Dec 2016 18:24:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 18:24:16 +0000
Received: (qmail 15674 invoked by uid 111); 6 Dec 2016 18:24:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 13:24:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 13:24:14 -0500
Date:   Tue, 6 Dec 2016 13:24:14 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v2] jk/http-walker-limit-redirect rebased to maint-2.9
Message-ID: <20161206182414.466uotqfufcimpqb@sigill.intra.peff.net>
References: <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480623959-126129-5-git-send-email-bmwill@google.com>
 <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
 <20161201230738.GJ54082@google.com>
 <xmqqh96n6x63.fsf@gitster.mtv.corp.google.com>
 <20161201235856.GL54082@google.com>
 <xmqqr35m3zx7.fsf@gitster.mtv.corp.google.com>
 <20161206135113.i7nlr45vg7uzgfcn@sigill.intra.peff.net>
 <xmqq60mx2bbi.fsf@gitster.mtv.corp.google.com>
 <20161206181008.yaz2md3343pukaov@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161206181008.yaz2md3343pukaov@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2016 at 01:10:08PM -0500, Jeff King wrote:

> > I think I merged yours and then Brandon's on jch/pu branches in that
> > order, and the conflict resolution should look OK.
> > 
> > I however forked yours on v2.11.0-rc1, which would need to be
> > rebased to one of the earlier maintenance tracks, before we can
> > merge it to 'next'.
> 
> Yeah, I built it on top of master.
> 
> It does depend on some of the http-walker changes Eric made a few months
> ago. In particular, 17966c0a6 (http: avoid disconnecting on 404s for
> loose objects, 2016-07-11) added some checks against the HTTP status
> code, and my series modifies the checks (mostly so that ">= 400" becomes
> ">= 300").
> 
> Rebasing on maint-2.9 means omitting those changes. That preserves the
> security properties, but means that the error handling is worse when we
> see an illegal redirect. That may be OK, though.
> 
> Since the resolution is to omit the changes entirely from my series,
> merging up to v2.11 wouldn't produce any conflicts. We'd need to have a
> separate set of patches adding those changes back in.

This actually turned out to be pretty easy. The final patch from my
original series is the one that tweaks the error-handling from
17966c0a6. The rest of them are _almost_ untouched, except that one of
the error-handling tweaks gets bumped to the final patch.

So here's a resend of the patches, rebased on your maint-2.9 branch.
Patches 1-5 should be applied directly there.

On maint-2.10, you can merge up maint-2.9, and then apply patch 6.

Hopefully that makes sense, but I've pushed branches
jk/maint-X-http-redirect to https://github.com/peff/git that show the
final configuration (and a diff of jk/maint-2.10-http-redirect shows the
outcome is identical to applying the original series on top of 2.10).

Merging up to 2.11 should be trivial.

  [1/6]: http: simplify update_url_from_redirect
  [2/6]: http: always update the base URL for redirects
  [3/6]: remote-curl: rename shadowed options variable
  [4/6]: http: make redirects more obvious
  [5/6]: http: treat http-alternates like redirects
  [6/6]: http-walker: complain about non-404 loose object errors

-Peff
