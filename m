Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B549E2021E
	for <e@80x24.org>; Fri, 19 May 2017 12:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753531AbdESMZJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:25:09 -0400
Received: from siwi.pair.com ([209.68.5.199]:39639 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752400AbdESMZI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:25:08 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3EA78844AB;
        Fri, 19 May 2017 08:25:07 -0400 (EDT)
Received: from [10.181.8.102] (cpe-76-182-13-114.nc.res.rr.com [76.182.13.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D4532844A8;
        Fri, 19 May 2017 08:25:06 -0400 (EDT)
Subject: Re: [WIP/RFC 00/23] repository object
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com
References: <20170518232134.163059-1-bmwill@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <623e5473-9fb0-07e4-0ac1-adabdc652c74@jeffhostetler.com>
Date:   Fri, 19 May 2017 08:25:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/18/2017 7:21 PM, Brandon Williams wrote:
> When I first started working on the git project I found it very difficult to
> understand parts of the code base because of the inherently global nature of
> our code.  It also made working on submodules very difficult.  Since we can
> only open up a single repository per process, you need to launch a child
> process in order to process a submodule.  But you also need to be able to
> communicate other stateful information to the children processes so that the
> submodules know how best to format their output or match against a
> pathspec...it ends up feeling like layering on hack after hack.  What I would
> really like to do, is to have the ability to have a repository object so that I
> can open a submodule in-process.
> 
> Before this becomes a reality for all commands, much of the library code would
> need to be refactored in order to work purely on handles instead of global
> state.  As it turned out, ls-files is a pretty simple command and doesn't have
> *too* many dependencies.  The biggest thing that needed to be changed was
> piping through an index into a couple library routines so that they don't
> inherently rely on 'the_index'.  A few of these changes I've sent out and can
> be found at 'origin/bw/pathspec-sans-the-index' and
> 'origin/bw/dir-c-stops-relying-on-the-index' which this series is based on.
> 
> Patches 1-16 are refactorings to prepare either library code or ls-files itself
> to be ready to handle passing around an index struct.  Patches 17-22 introduce
> a repository struct and change a couple of things about how submodule caches
> work (getting submodule information from .gitmodules).  And Patch 23 converts
> ls-files to use a repository struct.
> 
> The most interesting part of the series is from 17-23.  And 1-16 could be taken
> as is without the rest of the series.
> 
> This is still very much in a WIP state, though it does pass all tests.  What
> I'm hoping for here is to get a discussion started about the feasibility of a
> change like this and hopefully to get the ball rolling.  Is this a direction we
> want to move in?  Is it worth the pain?
> 
> Thanks for taking the time to look at this and entertain my insane ideas :)

Very nice and thanks for starting this.
Jeff

