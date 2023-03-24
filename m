Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30288C76195
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 22:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjCXWHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 18:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjCXWHV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 18:07:21 -0400
Received: from bluemchen.kde.org (unknown [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B29317163
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 15:07:12 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id E6E2124382
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 18:06:55 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfpYl-W5A-00
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 23:06:55 +0100
Date:   Fri, 24 Mar 2023 23:06:55 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: limiting git branch --contains
Message-ID: <ZB4e/yE+25W66z6S@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <ZBygZbz5E6jVNp3y@ugly>
 <xmqqpm8z8dab.fsf@gitster.g>
 <ZBy6Ku+znv/wuOix@ugly>
 <594a358e-7bd4-e7a1-ad0f-7e41ca1fe767@github.com>
 <ZB3o0seQJVbtPa+j@ugly>
 <85f81579-5876-a573-6d35-88b35ab0f290@github.com>
 <ZB3z3e5G3Lrv9g3Y@ugly>
 <20230324191302.GB536967@coredump.intra.peff.net>
 <ZB4A7+LMY+NSaPYE@ugly>
 <20230324204504.GB549549@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230324204504.GB549549@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2023 at 04:45:04PM -0400, Jeff King wrote:
>On Fri, Mar 24, 2023 at 08:58:39PM +0100, Oswald Buddenhagen wrote:
>> so i tried git log --graph ... and still nothing?!
>
>That "--graph" option is unrelated. It asks for Git to draw a graph in
>the output.
>
i know. it just happens to be the go-to example from derrick's blog post 
about commit-graph, so that not working was a dead giveaway that 
something is really wrong.

>> a3628e41a9946c4fe93d9b2ae5906e1b2184fa8e refs/replace/1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
>
>Ah, that is your problem. When "replace" refs are in use, the data
>stored in the commit-graph can't reliably be used. [...]
>
why isn't the commit-graph built with the replaces applied (and tagged 
by a hash of the used replaces, so we know when to ignore it)?

at minimum, i'd expect a warning giving a reason when the graph is 
ignored.

>  git -c core.useReplaceRefs=false branch --contains ...
>
>which I think should get faster.
>
yes, that works. and _rather_ convincingly, to put it that way.

>I'd still be curious to see the
>difference between "just commit graphs" and "commit graphs plus the
>patch I showed earlier". I think it should make things faster, but if
>it's only a few milliseconds on average, it's not that urgent to pursue.
>
if there is a speed difference at all, it gets drowned out by the noise.
