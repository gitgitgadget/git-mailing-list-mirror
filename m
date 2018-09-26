Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B26A1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 03:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbeIZJby (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 05:31:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:59726 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726213AbeIZJby (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 05:31:54 -0400
Received: (qmail 14832 invoked by uid 109); 26 Sep 2018 03:21:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Sep 2018 03:21:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14660 invoked by uid 111); 26 Sep 2018 03:20:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 25 Sep 2018 23:20:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Sep 2018 23:21:08 -0400
Date:   Tue, 25 Sep 2018 23:21:08 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180926032107.GB32064@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
 <xmqqfty2v9qj.fsf@gitster-ct.c.googlers.com>
 <20180926010606.GJ4364@syl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180926010606.GJ4364@syl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 06:06:06PM -0700, Taylor Blau wrote:

> > > +extract_haves () {
> > > +	depacketize - | grep '\.have' | sed -e 's/\\0.*$//g'
> > > +}
> >
> > Don't pipe grep into sed, especially when both the pattern to filter
> > and the operation to perform are simple.
> >
> > I am not sure what you are trying to achive with 'g' in
> > s/pattern$//g; The anchor at the rightmost end of the pattern makes
> > sure that the pattern matches only once per line at the end anyway,
> > so "do this howmanyever times as we have match on each line" would
> > not make any difference, no?
> 
> I admit to not fully understanding when the trailing `/g` is and is not
> useful. Anyway, I took Peff's suggestion below to convert this 'grep |
> sed' pipeline into a Perl invocation, which I think ended up much
> cleaner.

It makes the replacement global in the line. Without we substitute only
the first match. So try:

  echo foo | sed s/o/X/

versus:

  echo foo | sed s/o/X/g

-Peff
