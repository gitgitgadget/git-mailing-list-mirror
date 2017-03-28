Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE4E1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 20:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932098AbdC1UAL (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 16:00:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:53219 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752808AbdC1UAL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 16:00:11 -0400
Received: (qmail 12661 invoked by uid 109); 28 Mar 2017 20:00:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 20:00:10 +0000
Received: (qmail 14078 invoked by uid 111); 28 Mar 2017 20:00:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 16:00:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 16:00:07 -0400
Date:   Tue, 28 Mar 2017 16:00:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/21] object_id part 7
Message-ID: <20170328200007.rlewwl6py6l7vhp6@sigill.intra.peff.net>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
 <20170328073159.k3xemw6auh3iedgs@sigill.intra.peff.net>
 <20170328111315.i6rhhy4pj6hhf4bs@genre.crustytoothpaste.net>
 <20170328173536.ylwesrj7jbreztcy@sigill.intra.peff.net>
 <20170328174214.t5szqndtf4bwsnhz@sigill.intra.peff.net>
 <xmqqfuhxchqq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuhxchqq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 12:40:29PM -0700, Junio C Hamano wrote:

> > Here's that minor tweak, in case anybody is interested. It's less useful
> > without that follow-on that touches "eol" more, but perhaps it increases
> > readability on its own.
> 
> Yup, the only thing that the original (with Brian's fix) appears to
> be more careful about is it tries very hard to avoid setting boc
> past eoc.  As we are not checking "boc != eoc" but doing the
> comparison, that "careful" appearance does not give us any benefit
> in practice, other than having to do an extra "eol ? eol+1 : eoc";
> the result of this patch is easier to read.
> 
> By the way, eoc is "one past the end" of the array that begins at
> boc, so setting a pointer to eoc+1 may technically be in violation.
> I do not know how much it matters, though ;-)

I think that is OK. We are reading a strbuf, so eoc must either be the
first character of the PGP signature, or the terminating NUL if there
was no signature block[1]. So it's actually _inside_ the array, and
eoc+1 is our "one past".

-Peff

[1] Arguably we should bail when parse_signature() does not find a PGP
    signature at all. We already bail with "malformed push certificate"
    when there are other syntactic anomalies.
