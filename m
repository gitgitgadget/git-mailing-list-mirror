Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC206202BB
	for <e@80x24.org>; Fri, 22 Mar 2019 16:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfCVQuf (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 12:50:35 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57790 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfCVQuf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 12:50:35 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id F3ED520248;
        Fri, 22 Mar 2019 16:50:34 +0000 (UTC)
Date:   Fri, 22 Mar 2019 16:50:34 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Wolfgang Denk <wd@denx.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [BUG] Cloning with git HEAD fails for some repositories
Message-ID: <20190322165034.GA23124@dcvr>
References: <7e4a2f1d-2b3a-eb83-d3f1-9ac63d68991b@gmx.de>
 <20190322005107.GL9937@linaro.org>
 <017964a9-bd75-5e36-0de7-57d4467d6a7e@gmx.de>
 <20190322071231.GA26114@sigill.intra.peff.net>
 <20190322082114.BC19924013C@gemini.denx.de>
 <20190322093132.GA17498@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322093132.GA17498@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Fri, Mar 22, 2019 at 09:21:14AM +0100, Wolfgang Denk wrote:
> 
> > Dear Jeff,
> > 
> > In message <20190322071231.GA26114@sigill.intra.peff.net> you wrote:
> > >
> > > However, so does the parent of 17966c0a63d. So I don't know if the
> > > u-boot-efi repo is just broken, or if there's some other different bug
> > > at play.
> > 
> > git fsck reports a number of dangling tags, but no other issues:
> 
> Weird. I had set http.maxrequests to "1" to give more readable output
> from GIT_CURL_VERBOSE, etc. It fails with that setting, but not with the
> default of 5. Which certainly seems like a bug, but one that has been
> there for a while (at least since v2.9.x, which I tested).

I couldn't reproduce an error after porting your patch to
master (commit 041f5ea1cf987a40 "The third batch"):
https://80x24.org/spew/20190322163449.25362-1-e@80x24.org/raw

So you might've hit an ephemeral error (bad connection,
HTTP server restarting, etc).

GIT_CURL_VERBOSE=1 git \
	-c http.maxRequests=1 -c http.followRedirects=true clone \
	http://git.denx.de/u-boot-efi.git
