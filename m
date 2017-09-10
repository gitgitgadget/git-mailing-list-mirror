Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E0851FAD6
	for <e@80x24.org>; Sun, 10 Sep 2017 08:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbdIJIu7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 04:50:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:33720 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751196AbdIJIu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 04:50:58 -0400
Received: (qmail 24047 invoked by uid 109); 10 Sep 2017 08:50:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 10 Sep 2017 08:50:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18457 invoked by uid 111); 10 Sep 2017 08:51:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 10 Sep 2017 04:51:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Sep 2017 04:50:56 -0400
Date:   Sun, 10 Sep 2017 04:50:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] shortlog: skip format/parse roundtrip for internal
 traversal
Message-ID: <20170910085056.ovwlfjj3unxtmykc@sigill.intra.peff.net>
References: <20170830180037.20950-1-l.s.r@web.de>
 <20170830180037.20950-8-l.s.r@web.de>
 <xmqqtw0f61xr.fsf@gitster.mtv.corp.google.com>
 <20170907043354.fwxiifzbqf3yt5rr@sigill.intra.peff.net>
 <xmqqzia61125.fsf@gitster.mtv.corp.google.com>
 <20170908035648.jhm6ypxkwwms4bqu@sigill.intra.peff.net>
 <20170908043633.smytugbn7ge4twlm@sigill.intra.peff.net>
 <xmqqk219zobb.fsf@gitster.mtv.corp.google.com>
 <20170908092126.55o3342macegtlga@sigill.intra.peff.net>
 <0239ea26-199c-b39e-91a9-5ea5c470af8f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0239ea26-199c-b39e-91a9-5ea5c470af8f@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2017 at 10:44:46AM +0200, René Scharfe wrote:

> Am 08.09.2017 um 11:21 schrieb Jeff King:
> > Note that the non-stdin path no longer looks at the "mailmap" entry of
> > "struct shortlog" (instead we use the one cached inside pretty.c). But
> > we still waste time loading it. I'm not sure if it's worth addressing
> > that. It's only once per program invocation, and it's a little tricky to
> > fix (we do shortlog_init() before we know whether or not we're using
> > stdin). We could just load it lazily, though, which would cover the
> > stdin case.
> 
> The difference in performance and memory usage will only be measurable
> with really big mailmap files.  However, it may be an opportunity for
> simplifying the mailmap API in general.  Conceptually the map data
> should fit into struct repository instead of being read and stored by
> each user, right?

Yes, I think it would be fine to have a single "the_mailmap", and in
post-struct-repository world, that's where it should go.

-Peff
