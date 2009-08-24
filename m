Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 6747 invoked by uid 107); 24 Aug 2009 07:55:43 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 24 Aug 2009 03:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbZHXHzY (ORCPT <rfc822;peff@peff.net>);
	Mon, 24 Aug 2009 03:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbZHXHzY
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 03:55:24 -0400
Received: from smtp02.microchip.com ([198.175.253.48]:37051 "EHLO
	smtp02.microchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbZHXHzY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 03:55:24 -0400
Received: from CHN-CL-MAIL01.mchp-main.com ([10.10.76.21]) by smtp02.microchip.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Aug 2009 00:55:26 -0700
Received: from [10.41.200.168] ([10.41.200.168]) by CHN-CL-MAIL01.mchp-main.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Aug 2009 00:55:24 -0700
Message-ID: <4A92476A.4060205@microchip.com>
Date:	Mon, 24 Aug 2009 13:25:22 +0530
From:	Sanjiv Gupta <sanjiv.gupta@microchip.com>
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
MIME-Version: 1.0
To:	Kai Blin <kai@samba.org>
CC:	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
Subject: Re: Pulling one commit at a time.
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com> <20090824060710.6117@nanako3.lavabit.com> <4A92318F.6050105@microchip.com> <200908240946.52813.kai@samba.org>
In-Reply-To: <200908240946.52813.kai@samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Aug 2009 07:55:25.0160 (UTC) FILETIME=[3D0C7E80:01CA2490]
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kai Blin wrote:
> On Monday 24 August 2009 08:22:07 Sanjiv Gupta wrote:
>
>   
>>> In general the public history isn't necessarily a single straight line
>>> like this picture and it doesn't make sense to merge one at a time for
>>> all the commits on the public branch, but if that is what you really want
>>> to do, you can do so.
>>>       
>> Excellent description. Thanks for that. I want to merge commits one by
>> one because I want to run a regression suite on each commit and
>> therefore know if any one is causing failures.
>>     
>
> What I do for a case like this is using rebase. I'm not sure if I get the 
> explanation right enough to please all the git gurus on the list, but I'll 
> try. What this basically does is to back out all the commits you did on your 
> branch to the point you diverged from the branch you're rebasing on now.
>
> So assuming you had a structure like this:
>
>            your 'master' HEAD
>              |
>      A---B---C
>     /
> ---X---U---V---W---Y
>                    |
>                 public 'master' HEAD
>
> git would back out commits A-C, so your local branch HEAD would be at X. Then, 
> if forwards your branch to the branch you're rebasing on, so your local 
> branch HEAD is at Y now, like the public branch HEAD.
>
> After that, git applies all of your patches back to your local branch, 
> producing a tree that looks like this:
>
>                            your 'master' HEAD
>                              |
>                      A---B---C
>                     /
> ---X---U---V---W---Y
>                    |
>               public 'master' head
>
> Personally I prefer that solution as it keeps the history linear. Of course 
> this means that all of your commits change sha1s, and you should not do this 
> on public branches with tags. But if you're still developing, it's much 
> easier to wrap your head around a history like this. It's also nice to 
> present feature branches to other people, as all of your commits are in one 
> block, without lots of annoying merge commits between them.
>
> rebase also handles more complicated cases of merging, but from the way I 
> understood your issue, this should already help.
>
> Cheers,
> Kai
>   
Thanks Kai.
What I would like is to "test *every* commit" available in the public 
master. There would be no local changes or commits that aren't pushed in 
the private copy.
So I just want to clone one copy from the public master and then just 
keep pulling commits from the public master one by one and run 
regressions on each one.

It's a damn simple thing in SVN world.
$ svn info will give you the current version you are at, assume it is 
"cur_rev"
$ svn update -r `expr $cur_rev + 1`
$ build
$ test

Thanks,
- Sanjiv

