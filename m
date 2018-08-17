Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45E9F1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 22:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeHRBuy (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 21:50:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:59450 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728271AbeHRBuy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 21:50:54 -0400
Received: (qmail 12790 invoked by uid 109); 17 Aug 2018 22:45:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Aug 2018 22:45:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29900 invoked by uid 111); 17 Aug 2018 22:45:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 17 Aug 2018 18:45:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Aug 2018 18:45:39 -0400
Date:   Fri, 17 Aug 2018 18:45:39 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 5/6] pack-bitmap: save "have" bitmap from walk
Message-ID: <20180817224539.GA4158@sigill.intra.peff.net>
References: <20180817205427.GA19580@sigill.intra.peff.net>
 <20180817205920.GE20088@sigill.intra.peff.net>
 <CAGZ79kaP3GPZi_5vSCspgbim5VwsTMRa-fLYbjgECqsx9BTaeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaP3GPZi_5vSCspgbim5VwsTMRa-fLYbjgECqsx9BTaeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 03:39:29PM -0700, Stefan Beller wrote:

> > diff --git a/pack-bitmap.h b/pack-bitmap.h
> > index 4555907dee..02a60ce670 100644
> > --- a/pack-bitmap.h
> > +++ b/pack-bitmap.h
> > @@ -50,6 +50,13 @@ int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping
> >                              khash_sha1 *reused_bitmaps, int show_progress);
> >  void free_bitmap_index(struct bitmap_index *);
> >
> > +/*
> > + * After a traversal has been performed on the bitmap_index, this can be
> > + * queried to see if a particular object was reachable from any of the
> > + * objects flagged as UNINTERESTING.
> 
> If the traversal has not been performed, we pretend the
> object was not reachable?

If the traversal hasn't been performed, the results are not defined
(though I suspect yeah, it happens to say "no").

> Is this a good API design, as it can be used when you do not
> have done all preparations? similarly to prepare_bitmap_walk
> we could have
> 
>     if (!bitmap_git->result)
>         BUG("failed to perform bitmap walk before querying");

That seems like a reasonable precaution.

> > +int bitmap_has_sha1_in_uninteresting(struct bitmap_index *, const unsigned char *sha1);
> 
> You seem to have rebased it to master resolving conflicts only. ;-)
> Do we want to talk about object ids here instead?

See the discussion in the commit message.

-Peff
