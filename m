Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5132920958
	for <e@80x24.org>; Thu, 30 Mar 2017 01:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933303AbdC3Bhj (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 21:37:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:53909 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933103AbdC3Bhi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 21:37:38 -0400
Received: (qmail 28649 invoked by uid 109); 30 Mar 2017 01:37:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 01:37:36 +0000
Received: (qmail 27389 invoked by uid 111); 30 Mar 2017 01:37:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Mar 2017 21:37:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Mar 2017 21:37:33 -0400
Date:   Wed, 29 Mar 2017 21:37:33 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/21] builtin/receive-pack: convert portions to
 struct object_id
Message-ID: <20170330013733.mr7ocka63iddmdj7@sigill.intra.peff.net>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
 <20170326160143.769630-8-sandals@crustytoothpaste.net>
 <20170328070712.p2o7wziysy7n2vxk@sigill.intra.peff.net>
 <20170329232152.lpz3biuk6eq43ftb@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170329232152.lpz3biuk6eq43ftb@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2017 at 11:21:52PM +0000, brian m. carlson wrote:

> On Tue, Mar 28, 2017 at 03:07:12AM -0400, Jeff King wrote:
> > It took me a while to find it. This is the switch from "len == 48" to
> > "len > 8" when matching "shallow" lines. I think this makes sense.
> > 
> > > Note that in queue_command we are guaranteed to have a NUL-terminated
> > > buffer or at least one byte of overflow that we can safely read, so the
> > > linelen check can be elided.  We would die in such a case, but not read
> > > invalid memory.
> > 
> > I think linelen is always just strlen(line). Since the queue_command
> > function no longer cares about it, perhaps we can just omit it?
> 
> I've just looked at this to put in a fix, and I don't agree.  We are
> guaranteed that we'll have overflow, but linelen can point to a newline,
> not just a NUL, so it isn't always strlen(line).  This is the case in
> queue_commands_from_cert.
> 
> We do use this value, in computing the reflen value, so I think it's
> better to keep it for now.  I agree that a future refactor could convert
> it to be NUL-terminated, but I'd rather not make that change here.

Yeah, you might have missed my followup:

  http://public-inbox.org/git/20170328173536.ylwesrj7jbreztcy@sigill.intra.peff.net/

Basically yes, I agree it's probably not worth trying to refactor
further.

-Peff
