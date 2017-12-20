Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECEDF1F404
	for <e@80x24.org>; Wed, 20 Dec 2017 13:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754835AbdLTNIO (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 08:08:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:44022 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754310AbdLTNIO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 08:08:14 -0500
Received: (qmail 9166 invoked by uid 109); 20 Dec 2017 13:08:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Dec 2017 13:08:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12444 invoked by uid 111); 20 Dec 2017 13:08:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 20 Dec 2017 08:08:39 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Dec 2017 08:08:12 -0500
Date:   Wed, 20 Dec 2017 08:08:12 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] revision: introduce prepare_revision_walk_extended()
Message-ID: <20171220130811.GD17569@sigill.intra.peff.net>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <20171218151043.GA9449@sigill.intra.peff.net>
 <39581cd0-0bfd-c8d1-642b-1245cf425ab4@web.de>
 <20171219114906.GB24558@sigill.intra.peff.net>
 <xmqq7etiworw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7etiworw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 19, 2017 at 10:33:55AM -0800, Junio C Hamano wrote:

> >> Why does prepare_revision_walk() clear the list of pending objects at
> >> all?  Assuming the list is append-only then perhaps remembering the
> >> last handled index would suffice.
> 
> For that matter, why does it copy, instead of using revs->pending
> directly?  I do not think I can answer this, as I think the design
> decisions led to this code predates me.

Me too, then. :) I think part of that copy is that we're moving the
items over to revs->commits, and dropping any non-commit objects.

> In any case, it seems that the discussion has veered into an
> interesting tangent but at this point it seems to me that it is not
> likely to produce an immediate improvement over the posted patch.

Fair enough.

> Should we take the patch posted as-is and move forward?

I suppose so.  I don't really have anything against the patch. My main
complaint was just that I don't think it's actually cleaning up the
gross parts of the interface. It's just substituting one gross thing (a
funny struct flag) for another (a special version of the prepare
function that takes a funny out-parameter).

-Peff
