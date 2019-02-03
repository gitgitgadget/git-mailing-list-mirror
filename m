Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C09BA1F453
	for <e@80x24.org>; Sun,  3 Feb 2019 01:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfBCBtl (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 20:49:41 -0500
Received: from avasout05.plus.net ([84.93.230.250]:55503 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfBCBtl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 20:49:41 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id q6uhgfk7cyTttq6uigDpz0; Sun, 03 Feb 2019 01:49:40 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=XuzUx2N9 c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=K7UA96uo3j0iLErB5cgA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 0/1] Using sparse in a CI job
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <78f85f0b-176f-0b54-2ec8-4c13fd386733@ramsayjones.plus.com>
 <20190202004145.GE10587@szeder.dev>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <719468c8-3c62-96d6-57de-b0629fab0be3@ramsayjones.plus.com>
Date:   Sun, 3 Feb 2019 01:49:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190202004145.GE10587@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfD95zXaEsjwLfgiGKXxLlb5+jjuUDz3vL8FlZa4cPyTpSOeh/M2Wovw2M/QNb2EG94BTvUEq4TmAVHFbf5bNR5ZAQdoGam+92GrTjrZSSx49EyuVVSbm
 mm/VUGJiK60Wtyc0cUfnUWoNq2UOSLRMStRvrWxWDruy2E3i6KZIRzrb6zavyCi7Wv3L/CaHc2M9bQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/02/2019 00:41, SZEDER Gábor wrote:
> On Fri, Feb 01, 2019 at 09:01:20PM +0000, Ramsay Jones wrote:
[snip]

 
>> At the moment, on Linux, the sp-out file is free from any sparse errors
>> or warnings. So are next and pu:
>>
>>   $ grep error sp-out
>>   $ grep warning sp-out
> 
> On 'master' I get:
> 
>   $ grep error sp-out 
>   $ grep warning sp-out 
>   connect.c:652:40: warning: incorrect type in argument 2 (invalid types)
>   pack-revindex.c:65:23: warning: memset with byte count of 262144
>   unix-socket.c:83:26: warning: incorrect type in argument 2 (invalid types)
>   unix-socket.c:108:23: warning: incorrect type in argument 2 (invalid types)
>   daemon.c:1041:36: warning: incorrect type in argument 2 (invalid types)
>   daemon.c:1184:67: warning: incorrect type in argument 2 (invalid types)
>   imap-send.c:1022:42: warning: incorrect type in argument 2 (invalid types)
>   credential-cache--daemon.c:180:37: warning: incorrect type in argument 2 (invalid types)
>   $ sparse --version
>   v0.5.0

Yeah, that version of sparse is a bit too old.

If memory serves (it may not), all of the 'argument 2 (invalid types)'
errors are caused by the glibc headers using a 'transparent union' to
define the 'struct sockaddr' type. sparse could not handle that until
commit 7698bae699 (aka. v0.5.0-5-g7698bae). The only remaining warning
was addressed by commit bcfe020ed9 (aka. v0.5.1-rc1-22-gbcfe020) in
sparse and commit 54360a1956 in git.

So, it seems you need at least v0.5.2 of sparse on your Linux system
(which can't be too recent, or you would need v0.6.0).

ATB,
Ramsay Jones

