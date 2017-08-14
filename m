Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73D911F667
	for <e@80x24.org>; Mon, 14 Aug 2017 04:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750946AbdHNEr7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 00:47:59 -0400
Received: from ikke.info ([178.21.113.177]:35468 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750836AbdHNEr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 00:47:58 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id B8E74440085; Mon, 14 Aug 2017 06:47:56 +0200 (CEST)
Date:   Mon, 14 Aug 2017 06:47:56 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Sam Partington <sam@whiteoctober.co.uk>
Cc:     git@vger.kernel.org
Subject: Re: Bug when stashing previously-ignored file plus associated
 .gitignore change
Message-ID: <20170814044756.GA8587@alpha.vpn.ikke.info>
References: <CAPuLQgNq_7Kdeio-59cbDjZ5mWC1VRd_1_KK33Gbka9KJ13vfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPuLQgNq_7Kdeio-59cbDjZ5mWC1VRd_1_KK33Gbka9KJ13vfQ@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 04:55:38PM +0100, Sam Partington wrote:
> Hi there,
> 
> I'm running git 2.7.4 on Ubuntu 16.04.  I've found a couple of
> problems when "un-ignoring" files in tandem with git stash.
> 
> Here's how to reproduce:
> 
> Say you have a project using git, with a .gitignore file which
> contains the following line:
> 
> bin/*
> 
> You can then see the problems by doing this:
> 
> $ touch bin/mynewfile # this file will be ignored at this point > 
> and then updating .gitignore to look like this (adding that second line):
> 
> bin/*
> !bin/mynewfile
> 
> So far, so good; the new file is no longer ignored.
> 
> But now, try stashing the changes and including untracked files in the stash:
> 
> $ git stash save -u
> 
> Here's the first problem, bin/mynewfile is still there:
> 
> $ ls bin/mynewfile
> bin/mynewfile
> 
> But you'd expect it to not be there and be in the stash, I think.
> This is what would normally happen with the untracked-files option for
> git stash.
> 
> This leads to the second problem - you can't now pop the stash:
> 
> $ git stash pop
> bin/mynewfile already exists, no checkout
> Could not restore untracked files from stash
> 
> If you want to apply the stash, you have to remove the file:
> 
> $ rm bin/mynewfile
> $ git stash pop # this works, and re-creates bin/mynewfile
> 
> This is quite an unusual edge case, but I have hit it two or three
> times now and so thought it worth reporting, but I'll understand if
> it's deemed not worth fixing!
> 
> Do let me know if you need any more information from me here.
> 
> Thanks
> Sam
> 
> PS Sorry for the lack of formatting - I'm sending this as plain text
> as my original HTML emails was rejected as possible spam by your
> mailserver.
> 
> Sam Partington
> Senior Developer
> 

Hello Sam,

Is it the case that you did not commit the addition of '!bin/mynewfile'
yet? I suspect that by running git stash save -u, you also are stashing
this addition to the .gitigore file. Can you confirm this?

Kevin
