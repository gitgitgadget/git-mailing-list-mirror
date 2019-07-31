Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15FB21F731
	for <e@80x24.org>; Wed, 31 Jul 2019 04:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfGaEal (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 00:30:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:56476 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726601AbfGaEak (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 00:30:40 -0400
Received: (qmail 11303 invoked by uid 109); 31 Jul 2019 04:30:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 04:30:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13511 invoked by uid 111); 31 Jul 2019 04:32:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 00:32:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 00:30:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        git@vger.kernel.org, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
Message-ID: <20190731043039.GB26237@sigill.intra.peff.net>
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com>
 <20190730194938.GZ4545@pobox.com>
 <20190730200203.GA4882@sigill.intra.peff.net>
 <20190730205624.GR20404@szeder.dev>
 <20190731005933.GA9610@sigill.intra.peff.net>
 <20190731012336.GA13880@sigill.intra.peff.net>
 <20190731015917.GB4545@pobox.com>
 <20190731032735.GA14684@sigill.intra.peff.net>
 <b32a178d-0255-6c82-a3fd-ced2ec828fc8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b32a178d-0255-6c82-a3fd-ced2ec828fc8@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 31, 2019 at 06:06:02AM +0200, René Scharfe wrote:

> Am 31.07.19 um 05:27 schrieb Jeff King:
> > One thing that makes it all a bit funky is that the "put" lines also
> > output the old value (which is what all those NULLs) are. And I think
> > that solves my "value3" puzzlement from earlier. It is not part of the
> > iteration at all, but rather the result of the duplicate "put".
> >
> > That would perhaps be clearer if the "hashmap" tool actually did the
> > sorting itself (so we'd sort _just_ the iteration, not the whole
> > output). Something like this, though I'm on the fence about whether it
> > is worth it:
> 
> We already have a few other tests that sort and compare.  Perhaps it's
> time for a test_cmp_ignore_order?

That would be OK with me, but I think it would just replace the calls to
"sort". To do the "just sort the iteration, but not the rest of the
output that I'm talking about above", the change _has_ to go into
test-hashmap.c (but I think I still favor just sorting the whole thing
for simplicity).

> And perhaps something like this might even be worth implementing as a
> diff option?  https://github.com/l0b0/diff-ignore-moved-lines has
> post-processing script for that..

Given that we don't actually care that much about looking at the
resulting diff (and so we don't care about preserving order), I think
just sorting both sides gives equivalent results and is much simpler.

-Peff
