Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB888202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 23:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965508AbdIYXNL (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 19:13:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:49876 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S964968AbdIYXNL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 19:13:11 -0400
Received: (qmail 10508 invoked by uid 109); 25 Sep 2017 23:13:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 23:13:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30456 invoked by uid 111); 25 Sep 2017 23:13:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 19:13:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 19:13:08 -0400
Date:   Mon, 25 Sep 2017 19:13:08 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/7] files-backend: prefer "0" for write_in_full() error
 check
Message-ID: <20170925231308.hpk7xrelqyqy6clg@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202716.g2wph3ensmzerm44@sigill.intra.peff.net>
 <20170925215927.GZ27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925215927.GZ27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 02:59:27PM -0700, Jonathan Nieder wrote:

> > But during the conflict resolution in c50424a6f0 (Merge
> > branch 'jk/write-in-full-fix', 2017-09-25), this morphed
> > into
> [...]
> Good eyes.  Thanks.

Sort of. :) I usually continually rebase my topics until they end up
empty. So I notice bits like this either during conflict resolution, or
when the topic is left unexpectedly non-empty.

It's not foolproof, though. Sometimes rebasing a topic on itself is so
painful that I "rebase --skip" liberally in the early parts, and would
miss any merge funniness.

> By the way, the description from that merge commit
> 
>     Many codepaths did not diagnose write failures correctly when disks
>     go full, due to their misuse of write_in_full() helper function,
>     which have been corrected.
> 
> does not look accurate to me.  At least the "Many codepaths" part.
> All of those changes except for three should be no-ops.  The scariest
> one is the 'long ret = write_in_full(fd, buf, size)' in notes-merge.c,
> which is about overflowing a "long" on Windows instead of error
> handling.

The ones in config.c are definitely wrong, too. Though I'd agree that
"many" might be overstating it.

-Peff
