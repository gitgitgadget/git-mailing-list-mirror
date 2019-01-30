Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2A411F453
	for <e@80x24.org>; Wed, 30 Jan 2019 12:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfA3Mng (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 07:43:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:54868 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726548AbfA3Mng (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 07:43:36 -0500
Received: (qmail 1469 invoked by uid 109); 30 Jan 2019 12:43:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 30 Jan 2019 12:43:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16285 invoked by uid 111); 30 Jan 2019 12:43:42 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 30 Jan 2019 07:43:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jan 2019 07:43:32 -0500
Date:   Wed, 30 Jan 2019 07:43:32 -0500
From:   Jeff King <peff@peff.net>
To:     Sebastian Staudt <koraktor@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/3] Add tests for describe with --work-tree
Message-ID: <20190130124331.GA2273@sigill.intra.peff.net>
References: <20190129051859.12830-1-koraktor@gmail.com>
 <20190129130031.GA22211@sigill.intra.peff.net>
 <xmqqmunj8ifc.fsf@gitster-ct.c.googlers.com>
 <CA+xP2Sb1--LQJs+GXqKVE3FjNHujSn6Q-Ow=-LEHtRLcFJJMGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+xP2Sb1--LQJs+GXqKVE3FjNHujSn6Q-Ow=-LEHtRLcFJJMGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 11:23:14AM +0100, Sebastian Staudt wrote:

> > >> +    grep 'A-\d\+-g[0-9a-f]\+' '$TRASH_DIRECTORY/out'
> > >
> > > Using "\d" isn't portable.
> >
> > True, but not just \d.  I think using \ before special characters to
> > force an otherwise basic regular expression to be ERE (i.e. \+ at
> > the end) is a GNUism.
> >
> 
> I guess I’ll use the even broader but apparently more portable A-*[0-9a-f]
> then. It’s used in the other checks, so this should be OK?

Yeah, that is OK, as long as you use it with `case` like check_describe
does. Because it's a glob and not a regex, you do not have to worry
about the anchoring issue.

Or if you mean to do an anchored but more general regex like:

  ^A-.*[0-9a-f]$

that is OK, too.

> > > If that's indeed what we're checking, then an easier check is perhaps:
> > >
> > >   ! grep dirty ...
> >
> > Good.
> 
> This was copied and pasted from the existing check for describe with a
> clean working tree. So this should be changed, too.

I do think that makes what we're checking more obvious, so I wouldn't
mind seeing the other tests converted to use this. But it may be hard if
they are relying on check_describe().

I'm OK with anything that works and is robust. :)

-Peff
