Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82F7C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB5E2078D
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHMPSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:18:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:57836 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMPSc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 11:18:32 -0400
Received: (qmail 20087 invoked by uid 109); 13 Aug 2020 15:18:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 15:18:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14806 invoked by uid 111); 13 Aug 2020 15:18:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 11:18:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 11:18:31 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] drop vcs-svn experiment
Message-ID: <20200813151831.GB892741@coredump.intra.peff.net>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813150017.GE891370@coredump.intra.peff.net>
 <20200813151136.GC2244@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813151136.GC2244@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 11:11:36AM -0400, Taylor Blau wrote:

> > So it seems like the result is not really usable by anybody in practice.
> > It would be wonderful if somebody wanted to pick up the topic again, and
> > potentially it's worth carrying around for that reason. But the flip
> > side is that people doing tree-wide operations have to deal with this
> > code.  And you can see the list with (replace "HEAD" with this commit as
> > appropriate):
> 
> I have nothing to add to this email other than to say that I think it
> makes sense to remove this. I agree it would be nice if somebody picked
> it up, but given that nothing has really changed since ~8 years ago, I
> think that it's unlikely to happen in the next ~8 years ;).
> 
> At least, it seems unlikely enough that dropping 2MB from the
> installation size is worth it. If someone *is* interested in picking it
> up, I'm sure that they won't have trouble finding this patch and
> reverting it.

TBH I care less about the installation size (which we could easily fix
by just not installing git-remote-testsvn) and more that it's 3000 lines
of basically-dead code. That keeps getting touched for tree-wide
refactors (most recently for strvec, but my -Wunused-parameters series
was the straw that caused me to just delete it instead).

I don't think resurrecting it will be quite as easy as reverting this.
Because the rest of the code will move on, so it will probably need
some fixups, depending on how long it has been. But those fixups are the
exact same changes we're saving regular git developers from doing. So
it's really just gambling that we won't need to do them (and also
shifting the work from everybody onto whoever chooses to work on this).

It would be nice if it could be spun out independently, but it does use
a bunch of data structures from libgit.a, which complicates that.

-Peff
