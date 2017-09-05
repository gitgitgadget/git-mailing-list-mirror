Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 129B51F4DD
	for <e@80x24.org>; Tue,  5 Sep 2017 09:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbdIEJEg (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 05:04:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:57014 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750709AbdIEJEf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 05:04:35 -0400
Received: (qmail 19054 invoked by uid 109); 5 Sep 2017 09:04:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 09:04:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7529 invoked by uid 111); 5 Sep 2017 09:05:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 05:05:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 05:04:33 -0400
Date:   Tue, 5 Sep 2017 05:04:33 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] refs/files-backend: add longer-scoped copy of
 string to list
Message-ID: <20170905090433.elysfemrgxhze2xn@sigill.intra.peff.net>
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
 <4b4c0d178ad2216eecbc49fb6f54dd8a1d1ac119.1504024261.git.martin.agren@gmail.com>
 <20170905084507.wntm3bfzfezgimcz@sigill.intra.peff.net>
 <CAMy9T_F5HWF=hinxdp0C+pgyH_8MnR31p=XK1rjyMiM3UwST_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMy9T_F5HWF=hinxdp0C+pgyH_8MnR31p=XK1rjyMiM3UwST_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2017 at 11:03:36AM +0200, Michael Haggerty wrote:

> > It feels pretty dirty, though. It would certainly be a bug if we ever
> > decided to switch affected_refnames to duplicate its strings.
> >
> > So given that your solution is only a constant-time factor worse in
> > efficiency, we should probably prefer it as the more maintainable
> > option.
> 
> This is clever, but I don't like that it requires outside code to
> change internal `string_list` structures in a way that is not
> documented to be OK.
> 
> If we cared about getting rid of the extra `O(lg N)` search (and I
> agree with you that it doesn't matter in this case), I think the clean
> way to do it would be for `string_list` to expose a method like
> 
>     struct string_list_item *string_list_insert_at_index(struct
> string_list *list, size_t index, const char *string);
> 
> and to use it, together with `string_list_find_insert_index()`, to
> avoid having to search twice.

Yes, agreed on all counts.

-Peff
