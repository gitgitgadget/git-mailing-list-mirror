Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396512095B
	for <e@80x24.org>; Tue, 21 Mar 2017 22:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932810AbdCUWNA (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 18:13:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:49044 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932773AbdCUWM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 18:12:59 -0400
Received: (qmail 27669 invoked by uid 109); 21 Mar 2017 22:12:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 22:12:56 +0000
Received: (qmail 21580 invoked by uid 111); 21 Mar 2017 22:13:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 18:13:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Mar 2017 18:12:52 -0400
Date:   Tue, 21 Mar 2017 18:12:52 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC 3/3] stash: pass the pathspec argument to git reset
Message-ID: <20170321221252.eslboc7kcldg6o43@sigill.intra.peff.net>
References: <20170318183658.GC27158@hank>
 <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170319202351.8825-4-t.gummerer@gmail.com>
 <20170320190843.aw3fsenjvcek7a44@sigill.intra.peff.net>
 <20170321211424.GE27158@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321211424.GE27158@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 09:14:24PM +0000, Thomas Gummerer wrote:

> > I don't think read-tree takes pathspecs, so it would have to drop the
> > "-u" and replace it with checkout-index. I'm confused about why we would
> > need it in the first place, though. We should have already dealt with
> > the working tree files in the earlier block, so there should be nothing
> > to checkout.
> > 
> > The "-u" goes all the way back to 7bedebcaa (stash: introduce 'stash
> > save --keep-index' option, 2008-06-27). I wonder if it has always been
> > unnecessary, but we never noticed because it's just a noop.
> 
> I do think the "-u" is necessary.  Say we have a repository with
> changes in 'foo' and 'bar', where the changes in bar are added to the
> index.
> 
> Then 'git stash -k' would wipe out the changes in both 'foo' and 'bar'
> through 'git reset --hard', but we do want the changes in 'bar' to
> still exist on disk, which they wouldn't without the "-u".

Yeah, you're right. It makes me wonder if the "-k" case should be
skipping the "reset --hard". But as this series has shown, this
procedure is sufficiently tricky that it may be a good idea to make the
minimal change.

> But I'll replace the "-u" with checkout-index, so we can respect the
> pathspec.

That makes sense.

-Peff
