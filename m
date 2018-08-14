Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19CD01F404
	for <e@80x24.org>; Tue, 14 Aug 2018 19:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeHNW2Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 18:28:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:55172 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727881AbeHNW2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 18:28:16 -0400
Received: (qmail 2534 invoked by uid 109); 14 Aug 2018 19:39:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 19:39:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25504 invoked by uid 111); 14 Aug 2018 19:39:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 15:39:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 15:39:32 -0400
Date:   Tue, 14 Aug 2018 15:39:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] cat-file: use a single strbuf for all output
Message-ID: <20180814193932.GD28452@sigill.intra.peff.net>
References: <20180814181358.GA26391@sigill.intra.peff.net>
 <20180814182022.GC26919@sigill.intra.peff.net>
 <567deabf-cdd3-c4e3-bb6a-b593c1f87c6e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <567deabf-cdd3-c4e3-bb6a-b593c1f87c6e@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 09:30:57PM +0200, René Scharfe wrote:

> > -static void batch_object_write(const char *obj_name, struct batch_options *opt,
> > +static void batch_object_write(const char *obj_name,
> > +			       struct strbuf *scratch,
> > +			       struct batch_options *opt,
> >  			       struct expand_data *data)
> >  {
> > -	struct strbuf buf = STRBUF_INIT;
> 
> We could also avoid passing that buffer around by making it static.  I
> shy away from adding static variables because the resulting code won't
> be thread-safe, but that fear might be irrational, especially with
> cat-file.

True, I didn't even think of that after your original got me in the
mindset of passing the buffer down. It's not too bad to do it this way,
and I agree with you that we are better avoiding static variables if we
can. Five years ago I might have said the opposite, but we've cleaned up
a lot of confusing hidden-static bits in that time. Let's not go in the
opposite direction. :)

-Peff
