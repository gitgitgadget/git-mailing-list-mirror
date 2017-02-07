Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 607D31FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 19:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755491AbdBGTtZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 14:49:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:50717 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755224AbdBGTtX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 14:49:23 -0500
Received: (qmail 22819 invoked by uid 109); 7 Feb 2017 19:42:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Feb 2017 19:42:41 +0000
Received: (qmail 27631 invoked by uid 111); 7 Feb 2017 19:42:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Feb 2017 14:42:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2017 14:42:39 -0500
Date:   Tue, 7 Feb 2017 14:42:39 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list-options.txt: update --all about detached HEAD
Message-ID: <20170207194239.icyqawhja2losjul@sigill.intra.peff.net>
References: <20170207133850.14056-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170207133850.14056-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 07, 2017 at 08:38:49PM +0700, Nguyễn Thái Ngọc Duy wrote:

> This is the document patch for f0298cf1c6 (revision walker: include a
> detached HEAD in --all - 2009-01-16)
> [...]
>  --all::
> -	Pretend as if all the refs in `refs/` are listed on the
> -	command line as '<commit>'.
> +	Pretend as if all the refs in `refs/` (and HEAD if detached)
> +	are listed on the command line as '<commit>'.

I think this is an improvement, but I'm not sure about the "if detached"
bit. We always read HEAD, no matter what.

If you only care about reachability, then reading HEAD only has an
impact if it is detached, since otherwise we know that we will grab the
ref via refs/.

I'm not sure if it would matter for some other cases, though. For
example, with "--source", do we report HEAD or the matching ref? It
looks like the latter (because we read the refs first).

I suspect you could also construct a case with excludes like:

  $ git checkout foo
  $ git rev-list --exclude=refs/heads/foo --all

where it is relevant that we read HEAD separately from refs/heads/foo.

So I think just "and HEAD" is better, like:

  Pretend as if all the refs in `refs/`, along with `HEAD`, are
  listed...

-Peff
