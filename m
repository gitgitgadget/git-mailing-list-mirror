Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59F8C77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 19:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjERTWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 15:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjERTWu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 15:22:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8786818F
        for <git@vger.kernel.org>; Thu, 18 May 2023 12:22:49 -0700 (PDT)
Received: (qmail 2144 invoked by uid 109); 18 May 2023 19:22:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 May 2023 19:22:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23832 invoked by uid 111); 18 May 2023 19:22:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 May 2023 15:22:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 May 2023 15:22:48 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [BUG 2.41.0] t/lib-httpd/apache.conf incompatible with
 RHEL/CentOS 7
Message-ID: <20230518192248.GB1514485@coredump.intra.peff.net>
References: <ZGUlqu7sP7yxbaTI@pobox.com>
 <20230518184532.GC557383@coredump.intra.peff.net>
 <ZGZ5KsbkwoT68J1S@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZGZ5KsbkwoT68J1S@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2023 at 03:14:50PM -0400, Todd Zullinger wrote:

> >   1. You use the looser value of GIT_TEST_HTTPD for CentOS tests, which
> >      would do the right thing. The downside is that if server setup
> >      failed for other reasons, we wouldn't notice and would silently
> >      skip the HTTP tests.
> > 
> >   2. We do some kind of version check in enable_cgipassauth(),
> >      and skip tests manually if it doesn't pass.
> > 
> >   3. You just skip the test manually on that platform with
> >      GIT_SKIP_TESTS=t5563.
> > 
> > Obviously (1) and (3) are the least work for us upstream, but I don't
> > think (2) would be too hard to do.
> 
> Yeah, the path of least effort seems ideal here.  If the
> tests are split I can easily skip them for CentOS 7.  For
> something that's going away in little over a year, it's good
> to put at least some of the onus on folks packaging for it.
> And that's less cruft in the test suite after CentOS 7 is
> gone (or any other ancient httpd's git may wish to support).

Too late. :) I just sent a patch with (2), as it was only a few extra
lines.

> Thanks Peff!  I'm really glad you know your way around the
> test suite so well.  It'd take me far longer to figure out a
> good plan for something like this.

I was able to cheat a little, having had to figure out a similar
solution for HTTP/2 not too long ago. :)

-Peff
