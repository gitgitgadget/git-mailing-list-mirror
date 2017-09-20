Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0244220A29
	for <e@80x24.org>; Wed, 20 Sep 2017 18:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbdITSvX (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 14:51:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:44944 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751365AbdITSvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 14:51:22 -0400
Received: (qmail 7855 invoked by uid 109); 20 Sep 2017 18:51:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 18:51:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15194 invoked by uid 111); 20 Sep 2017 18:51:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 14:51:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2017 14:51:20 -0400
Date:   Wed, 20 Sep 2017 14:51:20 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 13/21] packed_ref_cache: keep the `packed-refs` file
 mmapped if possible
Message-ID: <20170920185119.upnyomtlxobxwvlw@sigill.intra.peff.net>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
 <b32234e07a1bd1e60442a13d97d7c4e51edf3336.1505799700.git.mhagger@alum.mit.edu>
 <20170920184058.w3tipgsz54ig7dm5@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170920184058.w3tipgsz54ig7dm5@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2017 at 02:40:58PM -0400, Jeff King wrote:

> > +enum mmap_strategy {
> > +	/*
> > +	 * Don't use mmap() at all for reading `packed-refs`.
> > +	 */
> > +	MMAP_NONE,
> > +
> > +	/*
> > +	 * Can use mmap() for reading `packed-refs`, but the file must
> > +	 * not remain mmapped. This is the usual option on Windows,
> > +	 * where you cannot rename a new version of a file onto a file
> > +	 * that is currently mmapped.
> > +	 */
> > +	MMAP_TEMPORARY,
> 
> I suspect you originally distinguished these cases so that NO_MMAP does
> not read into a fake-mmap buffer, followed by us copying it into another
> buffer. But AFAICT we handle the "NONE" and "TEMPORARY" cases exactly
> the same (by just doing a read_in_full() into our own buffer). Do we
> actually need separate strategies?

In case you are reading these sequentially, I think I talked myself into
the utility of this during the next patch. ;)

-Peff
