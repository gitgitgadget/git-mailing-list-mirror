Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072B71FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 11:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbcLELW0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 06:22:26 -0500
Received: from avasout06.plus.net ([212.159.14.18]:58928 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbcLELWY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 06:22:24 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout06 with smtp
        id GBME1u0060srQBz01BMFky; Mon, 05 Dec 2016 11:21:16 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Xom4AhN9 c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=LTjC4lJ740txakntddMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [RFC PATCH] GIT-VERSION-GEN: set --abbrev=9 to match auto-scaling
To:     Jeff King <peff@peff.net>
References: <22e9dfa0-47fb-d6fd-caf4-c2d87f63f707@ramsayjones.plus.com>
 <20161205053258.jtnqq64gp5n7vtni@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ab1e7ce9-1022-0c72-2f72-63e3b9182bc9@ramsayjones.plus.com>
Date:   Mon, 5 Dec 2016 11:21:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161205053258.jtnqq64gp5n7vtni@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/12/16 05:32, Jeff King wrote:
> On Sun, Dec 04, 2016 at 08:45:59PM +0000, Ramsay Jones wrote:
>> I recently noticed that:
>>
>>     $ make >pout 2>&1
>>     $ ./git version
>>     git version 2.11.0.286.g109e8a9
>>     $ git describe
>>     v2.11.0-286-g109e8a99d
>>     $
>>
>> ... for non-release builds, the commit part of the version
>> string was still using an --abbrev=7.
> 
> It seems like this kind of discussion ought to go in the commit message.
> :)
> 
> That said, I think the right patch may be to just drop --abbrev
> entirely.

Heh, that was the first version of the patch. However, I got to thinking
about why --abbrev=7 was there in the first place; the only reason I
could think of was to defeat local configuration to get a measure of
reproducibility.

Unfortunately, you can't get the 'auto' behaviour from --abbrev
(on the pu branch):

    $ ./git describe --abbrev=-1
    v2.11.0-286-g109e8
    $ ./git describe --abbrev=0
    v2.11.0
    $ ./git describe
    v2.11.0-286-g109e8a99d
    $

I did think about using '-c core.abbrev=auto', but that would
depend on Junio's patch (nothing wrong with that, of course):

    $ git version
    git version 2.11.0
    $ git -c core.abbrev=auto describe
    fatal: bad numeric config value 'auto' for 'core.abbrev': invalid unit
    $ ./git -c core.abbrev=auto describe
    v2.11.0-286-g109e8a99d
    $ 

What do you think?

ATB,
Ramsay Jones

