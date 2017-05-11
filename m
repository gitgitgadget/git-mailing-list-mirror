Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E52921FF34
	for <e@80x24.org>; Thu, 11 May 2017 06:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754534AbdEKGfx (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 02:35:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:49139 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753820AbdEKGfw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 02:35:52 -0400
Received: (qmail 23006 invoked by uid 109); 11 May 2017 06:35:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 06:35:51 +0000
Received: (qmail 9475 invoked by uid 111); 11 May 2017 06:36:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 02:36:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 02:35:49 -0400
Date:   Thu, 11 May 2017 02:35:49 -0400
From:   Jeff King <peff@peff.net>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Jonny Gilchrist <jonnygilchrist@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git log --follow after subtree merge
Message-ID: <20170511063549.fniwyggsj7wffgf5@sigill.intra.peff.net>
References: <CA+qhfwO4=1X9fNCW2PeKSgqUHV-z26qhvr_yXfz1QGApJ_roRQ@mail.gmail.com>
 <CAJZjrdX-oAP7GFcPJ_FVNCMuErF7DNkq97KhjwgBX_G5tGXoFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZjrdX-oAP7GFcPJ_FVNCMuErF7DNkq97KhjwgBX_G5tGXoFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 02:15:23PM -0500, Samuel Lijin wrote:

> On Wed, May 10, 2017 at 9:46 AM, Jonny Gilchrist
> <jonnygilchrist@gmail.com> wrote:
> > Hi,
> >
> > After doing a subtree merge, using 'git log' and 'git log --follow' on
> > files in the subtree show only the merge commit in which they were
> > added.
> >
> > After reading around I understand that the issue is that git log
> > --follow doesn't track renames that occur during a merge.
> 
> Try git log --follow -M. (You may also want to combine this with -l and/or -C).

You shouldn't need to specify "-M" with --follow, as the diff done by
try_to_follow_renames() turns on rename (and copy) detection explicitly.
I suspect the problem is that git-log does not do merge diffs at all by
default, and you'd need "-c" or "--cc" (or maybe even "-m") to turn them
on.

I wouldn't be surprised if there are other problems where that code path
isn't quite ready to handle merge commits, though.

-Peff
