Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA1A61FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 19:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755330AbcK3T6y (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 14:58:54 -0500
Received: from avasout05.plus.net ([84.93.230.250]:43461 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754189AbcK3T6w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 14:58:52 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout05 with smtp
        id EKxK1u0010srQBz01KxLpB; Wed, 30 Nov 2016 19:57:20 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Qskc5h6d c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=1j8903NqU7SsRyJGeQ4A:9
 a=dnGika4MEgltpWy6:21 a=hCmbWrCEsEZ489BE:21 a=QEXdDO2ut3YA:10
 a=Bn2pgwyD2vrAyMmN8A2t:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] difftool.c: mark a file-local symbol with static
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <4ddad7ea-5ac8-20b2-da9e-5843c486878a@ramsayjones.plus.com>
 <alpine.DEB.2.20.1611301204020.117539@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <29abc89b-9ca5-930f-8e90-ca446ac2b96a@ramsayjones.plus.com>
Date:   Wed, 30 Nov 2016 19:57:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1611301204020.117539@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30/11/16 11:07, Johannes Schindelin wrote:
> Hi Ramsay,
> 
> On Tue, 29 Nov 2016, Ramsay Jones wrote:
>> Also, due to a problem in my config.mak file on Linux (a commented
>> out line that had a line continuation '\', grrrrr!), gcc issued a
>> warning, thus:
>>
>>   builtin/difftool.c: In function ‘run_dir_diff’:
>>   builtin/difftool.c:568:13: warning: zero-length gnu_printf format string [-Wformat-zero-length]
>>        warning("");
>>                ^
>> I am not sure why -Wno-format-zero-length is set in DEVELOPER_CFLAGS,
>> but do you really need to space the output with an an 'empty'
>> "warning:" line? (Just curious).
> 
> That `warning("");` comes from a straight-forward port of this line (see
> https://github.com/git/git/blob/v2.11.0/git-difftool.perl#L425):
> 
> 	$errmsg .= "warning:\n";

Ah, OK, so it is being used to 'space out' the (possibly multiple)
'Both files modified' warning(s) followed by a 2-line warning
summary. Hmm, I am not sure the 'Working tree file has been left'
(after each pair of files) part of the message is adding much ...

> I could see two possible ways out:
> 
> - warning("%s", ""); (ugly!)
> 
> - do away with the "prefix every line with warning:" convention and simply
>   have a multi-line `warning(_("...\n...\n"), ...)`
> 
> What do you think?

I think, for now, it is probably best to do nothing. ;-)

Until you have replaced the 'legacy' difftool, it would be best
not to alter the output from the tool, so that the tests can be
used unaltered on both. This could be addressed (if necessary)
after you complete your series.

[I have fixed my config.mak file now, so I don't see the warning
anymore! Having -Wno-format-zero-length in DEVELOPER_CFLAGS, or
not, is a separate matter.]

ATB,
Ramsay Jones

