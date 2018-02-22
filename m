Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A32451F404
	for <e@80x24.org>; Thu, 22 Feb 2018 23:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeBVXX3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 18:23:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:33510 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751553AbeBVXX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 18:23:28 -0500
Received: (qmail 6108 invoked by uid 109); 22 Feb 2018 23:23:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Feb 2018 23:23:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9889 invoked by uid 111); 22 Feb 2018 23:24:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Feb 2018 18:24:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Feb 2018 18:23:26 -0500
Date:   Thu, 22 Feb 2018 18:23:26 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180222232326.GA8585@sigill.intra.peff.net>
References: <20180222095833.GC12442@sigill.intra.peff.net>
 <20180222180715.GB185096@google.com>
 <20180222181400.GA19035@sigill.intra.peff.net>
 <20180222193814.GA256918@aiede.svl.corp.google.com>
 <20180222201940.GB23561@sigill.intra.peff.net>
 <20180222212402.GB256918@aiede.svl.corp.google.com>
 <20180222214402.GA30638@sigill.intra.peff.net>
 <20180222222146.GA30988@sigill.intra.peff.net>
 <20180222224235.GD256918@aiede.svl.corp.google.com>
 <20180222230515.GA976@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180222230515.GA976@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 06:05:15PM -0500, Jeff King wrote:

> On Thu, Feb 22, 2018 at 02:42:35PM -0800, Jonathan Nieder wrote:
> 
> > > I couldn't quite get it to work, but I think it's because I'm doing
> > > something wrong with the submodules. But I also think this attack would
> > > _have_ to be done over ssh, because on a local system the submodule
> > > clone would a hard-link rather than a real fetch.
> > 
> > What happens if the submodule URL starts with file://?
> 
> Ah, that would do it. Or I guess any follow-up fetch.
> 
> I'm still having trouble convincing submodules to fetch _just_ the
> desired sha1, though. It always just fetches everything. I know there's
> a way that this kicks in (that's why we have things like
> allowReachableSHA1InWant), but I'm not sufficiently well-versed in
> submodules to know how to trigger it.

<facepalm> This won't work anyway. I was right when I said that we don't
redirect stderr for rev-list, but of course it's stdout that determines
the pager behavior. So I don't think you could get rev-list to trigger a
pager here.

I don't think there's currently any vulnerability, but it's more to do
with luck than any amount of carefulness on our part.

-Peff
