Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CF012018E
	for <e@80x24.org>; Fri,  5 Aug 2016 07:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759433AbcHEHqj (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 03:46:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:55132 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757639AbcHEHp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 03:45:57 -0400
Received: (qmail 9844 invoked by uid 102); 5 Aug 2016 07:45:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 03:45:58 -0400
Received: (qmail 23917 invoked by uid 107); 5 Aug 2016 07:46:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 03:46:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2016 03:45:53 -0400
Date:	Fri, 5 Aug 2016 03:45:53 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #02; Thu, 4)
Message-ID: <20160805074552.6ow4h3lwdy7yxqva@sigill.intra.peff.net>
References: <xmqqshukyxqw.fsf@gitster.mtv.corp.google.com>
 <20160804233435.GA31403@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160804233435.GA31403@dcvr>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 11:34:35PM +0000, Eric Wong wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > [Graduated to "master"]
> 
> > * ew/http-walker (2016-07-18) 4 commits
> >   (merged to 'next' on 2016-07-18 at a430a97)
> >  + list: avoid incompatibility with *BSD sys/queue.h
> >   (merged to 'next' on 2016-07-13 at 8585c03)
> >  + http-walker: reduce O(n) ops with doubly-linked list
> 
> Yay!  This finally introduces the Linux kernel linked list
> into git.  I'm not sure if it's worth the effort to introduce
> cleanup commits to start using it in places where we already
> have doubly-linked list implementations:
> 
> (+Cc Nicolas and Lukas)
> * sha1_file.c delta_base_cache_lru is open codes this
> * builtin/pack-redundant.c could probably be adapted, too
>  ... any more?

I just introduced another doubly-linked list in [1]. It adds some MRU
features on top of the list, but it could in theory be built on top of a
generic doubly-linked list.

It's also possible the delta-base-cache stuff could build on top of that
same code, but I didn't look closely at it.

-Peff

[1] http://public-inbox.org/git/20160729040659.GC22408@sigill.intra.peff.net/
