Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1F9C38145
	for <git@archiver.kernel.org>; Sat,  3 Sep 2022 01:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiICBHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 21:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiICBHl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 21:07:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E692F036
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 18:07:39 -0700 (PDT)
Received: (qmail 2425 invoked by uid 109); 3 Sep 2022 01:07:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 03 Sep 2022 01:07:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2110 invoked by uid 111); 3 Sep 2022 01:07:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Sep 2022 21:07:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 2 Sep 2022 21:07:38 -0400
From:   Jeff King <peff@peff.net>
To:     Lana Deere <lana.deere@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
Message-ID: <YxKo2l5nBoOa9Jfa@coredump.intra.peff.net>
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 02, 2022 at 03:27:55PM -0400, Lana Deere wrote:

> I'm testing an upgrade to git 2.37.2 from the current version we're
> using of 2.18.0.  When I try to pull in my development tree, 2.37.2
> gives me an error but 2.18.0 things all is fine:
> 
> $ /tools/linux-x86_64/git/2.37.2/bin/git pull
> Your configuration specifies to merge with the ref
> 'refs/heads/feature/switch-to-qt5'
> from the remote, but no such ref was fetched.
> 
> $ /tools/linux-x86_64/git/2.18.0/bin/git pull
> From http://githost:7990/scm/dp/sw
>  * branch                  feature/switch-to-qt5 -> FETCH_HEAD
> Already up to date.
> 
> Anyone have any ideas about this?  All I could find on google was a
> suggestion that the "no such ref" message indicates the remote branch
> was deleted, but that's not the case here.

It's curious that the older version shows us fetching into FETCH_HEAD,
but the new one doesn't. I wonder if you have some unusual refspecs. Or
perhaps a branch.*.remote config option which fetches from a different
remote. The "git config" output brian asked for may be instructive
there.

If it's possible for you to build Git from source, it may also be
interesting to bisect to find the commit that caused the change.

-Peff
