Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFAFD1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933743AbeBVS1A (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:27:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:32910 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933521AbeBVS1A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:27:00 -0500
Received: (qmail 25363 invoked by uid 109); 22 Feb 2018 18:27:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Feb 2018 18:27:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5304 invoked by uid 111); 22 Feb 2018 18:27:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Feb 2018 13:27:47 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Feb 2018 13:26:58 -0500
Date:   Thu, 22 Feb 2018 13:26:58 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        stolee@gmail.com, git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 14/35] connect: request remote refs using v2
Message-ID: <20180222182657.GE19035@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-15-bmwill@google.com>
 <20180221145411.35b2ea84747518a499276bdd@google.com>
 <20180222181922.GD185096@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180222181922.GD185096@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 10:19:22AM -0800, Brandon Williams wrote:

> On 02/21, Jonathan Tan wrote:
> > On Tue,  6 Feb 2018 17:12:51 -0800
> > Brandon Williams <bmwill@google.com> wrote:
> > 
> > > +extern struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
> > > +				    struct ref **list, int for_push,
> > > +				    const struct argv_array *ref_patterns);
> > 
> > I haven't looked at the rest of this patch in detail, but the type of
> > ref_patterns is probably better as struct string_list, since this is not
> > a true argument array (e.g. with flags starting with --). Same comment
> > for the next few patches that deal with ref patterns.
> 
> Its just a list of strings which don't require having a util pointer
> hanging around so actually using an argv_array would be more memory
> efficient than a string_list.  But either way I don't think it matters
> much.

I agree that it shouldn't matter much here. But if the name argv_array
is standing in the way of using it, I think we should consider giving it
a more general name. I picked that not to evoke "this must be arguments"
but "this is terminated by a single NULL".

In general I think it should be the preferred structure for string
lists, just because it actually converts for free to the "other" common
format (whereas you can never pass string_list.items to a function that
doesn't know about string lists).

-Peff
