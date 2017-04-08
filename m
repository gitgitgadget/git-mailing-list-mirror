Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E104D20970
	for <e@80x24.org>; Sat,  8 Apr 2017 20:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbdDHUcq (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 16:32:46 -0400
Received: from 5.itsy.de ([188.40.84.14]:44797 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751505AbdDHUcp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 16:32:45 -0400
Received: from [192.168.0.13] (84-72-0-73.dclient.hispeed.ch [84.72.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id 9D70464D08
        for <git@vger.kernel.org>; Sat,  8 Apr 2017 22:32:42 +0200 (CEST)
Subject: Re: [PATCH] submodule: prevent backslash expantion in submodule names
References: <CAGZ79ka7PEWy2iA8V9s11n2kyD=vHyS2y1K3SJzDq-5HsY7how@mail.gmail.com>
 <20170407172306.172673-1-bmwill@google.com>
 <20170408105901.2osi2zadboqxhf34@sigill.intra.peff.net>
From:   Joachim Durchholz <jo@durchholz.org>
To:     git@vger.kernel.org
Message-ID: <d8ef00f6-4ec0-dfcb-dc49-71f27538eb2f@durchholz.org>
Date:   Sat, 8 Apr 2017 22:32:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170408105901.2osi2zadboqxhf34@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.04.2017 um 12:59 schrieb Jeff King:
> The reason I mentioned escaping earlier is I wondered what would happen
> when the submodule starts with a double-quote, or has a newline in the
> name.

I have tested newlines within the name, these work fine.

I also tested double and single quotes within the name, but not at 
beginning or end.

> So I think your patch is fine there. But it does raise a few concerns.
> It looks like git-submodule does not cope well with exotic filenames:
>
>   $ git submodule add /some/repo "$(printf 'sub with\nnewline')"
>   Cloning into '/home/peff/tmp/sub with
>   newline'...
>   done.
>   error: invalid key (newline): submodule.sub with
>   newline.url
>   error: invalid key (newline): submodule.sub with
>   newline.path
>   Failed to register submodule 'sub with
>   newline'

Strange. I'm running essentially the same kind of request, and things 
work fine.
Might be due to me using Python3 instead of bash, or maybe due to 
different versions of git.

If anybody is interested, I can publish my test code on github, it was 
scheduled to land there anyway.

> I'm not too worried about that.  It's a nonsense request, and our config
> format has no syntactic mechanism to represent that key.

Oh. I've been thinking that the quoted format is exactly for that kind 
of stuff.
Though it might be prone to eol conversion if a submodule name contains 
crlf sequences.

Also, funny behavour. Experience has taught me that funny behaviour, if 
it isn't exploitable today, may combine with some new funny behaviour in 
a future version of the same software. So I'm worried even with that.

This is starting to look like a can of worms to me... one way to "close 
the lid" would be if git
* defined what's a valid submodule name,
* rejected invalid submodule names, and
* documented validity rules in the git-submodule docs.
YMMV, just my 2 cents :-)

Regards,
Jo
