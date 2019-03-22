Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07FAC202BB
	for <e@80x24.org>; Fri, 22 Mar 2019 18:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfCVSJW (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 14:09:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47788 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfCVSJW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 14:09:22 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 41C0A20248;
        Fri, 22 Mar 2019 18:09:22 +0000 (UTC)
Date:   Fri, 22 Mar 2019 18:09:22 +0000
From:   Eric Wong <e@80x24.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Jeff King <peff@peff.net>, Wolfgang Denk <wd@denx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [BUG] Cloning with git HEAD fails for some repositories
Message-ID: <20190322180922.nghzdmvqz7wsxcb3@dcvr>
References: <7e4a2f1d-2b3a-eb83-d3f1-9ac63d68991b@gmx.de>
 <20190322005107.GL9937@linaro.org>
 <017964a9-bd75-5e36-0de7-57d4467d6a7e@gmx.de>
 <20190322071231.GA26114@sigill.intra.peff.net>
 <20190322082114.BC19924013C@gemini.denx.de>
 <20190322093132.GA17498@sigill.intra.peff.net>
 <20190322165034.GA23124@dcvr>
 <3d8e8de3-9ae6-94be-7739-cb8ea79b228e@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d8e8de3-9ae6-94be-7739-cb8ea79b228e@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> On 3/22/19 5:50 PM, Eric Wong wrote:
> > I couldn't reproduce an error after porting your patch to
> > master (commit 041f5ea1cf987a40 "The third batch"):
> > https://80x24.org/spew/20190322163449.25362-1-e@80x24.org/raw
> >
> > So you might've hit an ephemeral error (bad connection,
> > HTTP server restarting, etc).
> >
> > GIT_CURL_VERBOSE=1 git \
> > 	-c http.maxRequests=1 -c http.followRedirects=true clone \
> > 	http://git.denx.de/u-boot-efi.git
> >
> 
> I applied the patch to https://github.com/git/git origin/HEAD.
> 
> But unfortunately it does not solve the issue:
> 
> $ git --version
> git version 2.21.0.197.g3845f293e6
> $ git clone http://git.denx.de/u-boot-efi.git
> Cloning into 'u-boot-efi'...
> warning: alternate disabled by http.followRedirects:

It looks like you need to enable http.followRedirects
(see the command-line I used above)

> http://git.denx.de/u-boot.git/
> error: Unable to find a00d15757d7a513e410f15f2f910cb52333361a3 under
> http://git.denx.de/u-boot-efi.git
> Cannot obtain needed object a00d15757d7a513e410f15f2f910cb52333361a3
> error: fetch failed.
> 
> In Wireshark I see a lot of '404 Not found' codes.
