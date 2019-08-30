Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3F2E1F4B7
	for <e@80x24.org>; Fri, 30 Aug 2019 19:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfH3Twl (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 15:52:41 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57218 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbfH3Twl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 15:52:41 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id EF7D31F461;
        Fri, 30 Aug 2019 19:52:40 +0000 (UTC)
Date:   Fri, 30 Aug 2019 19:52:40 +0000
From:   Eric Wong <e@80x24.org>
To:     phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 04/11] hashmap_entry: detect improper initialization
Message-ID: <20190830195240.ephg6r6zjbrkabvp@dcvr>
References: <20190826024332.3403-1-e@80x24.org>
 <20190826024332.3403-5-e@80x24.org>
 <nycvar.QRO.7.76.6.1908271108410.46@tvgsbejvaqbjf.bet>
 <20190827094923.6qhwqosiucsi43td@whir>
 <8beefab6-b7ef-28d3-41d6-c5a5c042ae9a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8beefab6-b7ef-28d3-41d6-c5a5c042ae9a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> wrote:
> Hi Eric
> 
> On 27/08/2019 10:49, Eric Wong wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > Hi Eric,
> > > 
> > > On Mon, 26 Aug 2019, Eric Wong wrote:
> > > 
> > > > By renaming the "hash" field to "_hash", it's easy to spot
> > > > improper initialization of hashmap_entry structs which
> > > > can leave "hashmap_entry.next" uninitialized.
> > > 
> > > Would you mind elaborating a bit? This explanation does not enlighten
> > > me, sadly, all I see is that it makes it (slightly) harder for me to
> > > maintain Git for Windows' patches on top of `pu`, as the FSCache patches
> > > access that field directly (so even if they rebase cleanly, the build
> > > breaks).
> > 
> > I renamed it to intentionally break my build.
> > 
> > That way I could easily spot if there were any other improper
> > initializations of the .hash field.  It's fine to revert,
> > actually, it could be more of a "showing my work" patch.
> 
> I'm still a bit confused as the changed initializations already used
> hashmap_entry_init() and so presumably were already initializing
> hashmap_entry.next correctly. Is there a way to get 'make coccicheck' detect
> incorrect initializations, this renaming wont prevent bad code being added
> in the future.

Yeah I forgot we had coccicheck :x

I think this patch to rename the field can be dropped entirely.
I changed some usages of hashmap_entry_init to avoid reading the
.hash field entirely, since the result of memhash() could be
stored locally for multiple uses of hashmap_entry_init.
