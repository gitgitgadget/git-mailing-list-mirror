Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E63951F462
	for <e@80x24.org>; Tue, 28 May 2019 20:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfE1U6m (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 16:58:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:40430 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726523AbfE1U6l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 16:58:41 -0400
Received: (qmail 4597 invoked by uid 109); 28 May 2019 20:58:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 20:58:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18024 invoked by uid 111); 28 May 2019 20:59:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 16:59:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 16:58:39 -0400
Date:   Tue, 28 May 2019 16:58:39 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] bundle verify: error out if called without an object
 database
Message-ID: <20190528205839.GD24650@sigill.intra.peff.net>
References: <pull.226.git.gitgitgadget@gmail.com>
 <f0545e872344dd25e11db7fe095cde1578b26748.1558987152.git.gitgitgadget@gmail.com>
 <20190528015133.GA29724@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905281309490.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1905281309490.44@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 28, 2019 at 01:17:41PM +0200, Johannes Schindelin wrote:

> > As Gábor noted in the earlier thread, if the bundle doesn't have any
> > prerequisites, this _used_ to work before b1ef400eec (setup_git_env:
> > avoid blind fall-back to ".git", 2016-10-20). I don't know if anybody
> > cares about that case or not, but we could do something like:
> >
> >   if (p->nr)
> > 	verify_prerequisites();
> >
> >   /* otherwise, fall through to the printing portions */
> >
> > and then just check for a repository in verify_prerequisites(), which is
> > the only part that needs to look at the repository object at all.
> 
> I am not so sure that I feel comfortable with optimizing for the no-op
> case. Because that's essentially what this boils down to: if there are no
> prerequisites, there is not a whole lot to do.
> 
> And I'd rather have the command be consistent about its demands, to abide
> by the Law of Least Surprise.

I'm OK with that.

Since the breakage was technically attributable to my commit (I say
technically because flushing out these kinds of bugs was exactly the
point of it), I feel slightly guilty that I might have broken somebody's
oddball workflow. So I tend to err on the side of restoring the original
behavior in that case, even if I can't conceive of it as being
particularly useful. :)

But if nobody is actually in support of it, and given that it has
already been broken for 2 years, I certainly do not mind waiting to see
if anybody screams.

-Peff
