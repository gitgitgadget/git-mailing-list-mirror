Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C77C1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeBHQUF (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:20:05 -0500
Received: from ikke.info ([178.21.113.177]:58748 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752253AbeBHQUB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:01 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id BC437440084; Thu,  8 Feb 2018 17:19:59 +0100 (CET)
Date:   Thu, 8 Feb 2018 17:19:59 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Todd Zullinger <tmz@pobox.com>, Jason Racey <jason@eluvio.com>,
        git <git@vger.kernel.org>, Paul Smith <paul@mad-scientist.net>
Subject: Re: "git branch" issue in 2.16.1
Message-ID: <20180208161959.GA4042@alpha.vpn.ikke.info>
References: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com>
 <20180206195754.GE1427@zaya.teonanacatl.net>
 <CAGZ79kaxf3qUyOe6R-LCgyLtwzrwhB=y767tk2qPbC_KR473ig@mail.gmail.com>
 <5A7788B0-6250-4D1F-A86D-E3155C03EF0C@gmail.com>
 <20180207200859.GA9141@sigill.intra.peff.net>
 <F7E12F8B-6C55-4348-860A-B91942922A73@gmail.com>
 <20180208085015.GA24571@sigill.intra.peff.net>
 <CBF51BD2-0B54-43E3-BB48-884C7DB94237@gmail.com>
 <44FE6343-9236-4F50-A0C1-A70A887A8BC5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44FE6343-9236-4F50-A0C1-A70A887A8BC5@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 08, 2018 at 12:27:07PM +0100, Lars Schneider wrote:
> 
> > On 08 Feb 2018, at 12:13, Lars Schneider <larsxschneider@gmail.com> wrote:
> > 
> > 
> >> On 08 Feb 2018, at 09:50, Jeff King <peff@peff.net> wrote:
> >> 
> >> On Wed, Feb 07, 2018 at 11:20:08PM +0100, Lars Schneider wrote:
> >> 
> >>>> 1. You have $LESS in your environment (without "F") on one platform
> >>>>   but not the other.
> >>> 
> >>> I think that's it. On my system LESS is defined to "-R".
> >>> 
> >>> This opens the pager:
> >>> 
> >>> 	$ echo "TEST" | less
> >>> 
> >>> This does not open the pager:
> >>> 
> >>> 	$ echo "TEST" | less -FRX
> >>> 
> >>> That means "F" works on macOS but Git doesn't set it because LESS is
> >>> already in my environment.
> >>> 
> >>> Question is, why is LESS set that way on my system? I can't find
> >>> it in .bashrc .bash_profile .zshrc and friends.
> >> 
> >> There's also /etc/bash.bashrc, /etc/profile, etc. I don't know what's
> >> normal in the mac world. You can try running:
> >> 
> >> bash -ix 2>&1 </dev/null | grep LESS
> >> 
> >> to see what your startup code is doing. I don't know of a good way to
> >> correlate that with the source files, though. Or even to ask bash which
> >> startup files it's looking in.
> > 
> > Unfortunately, this command doesn't work for me.
> > 
> > I ask around and most of my coworkers have LESS="-R".
> > Only the coworker that doesn't really use his Mac and has
> > no customizations does not have $LESS defined.
> > 
> > Therefore, I think it is likely some third party component
> > that sets $LESS.
> > 
> > @Jason:
> > Do you have homebrew, iTerm2, and/or oh-my-zsh installed?
> 
> Ha. I found it it! It is indeed oh-my-zsh:
> https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/misc.zsh#L23
> 
> Let's see if oh-my-zsh is willing to change that...
> 
> - Lars

I've just added unset LESS in my .zshrc, but for most users it would be
better if they don't set it at all.
