Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846AE207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 22:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S978890AbdDXWn4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 18:43:56 -0400
Received: from avasout08.plus.net ([212.159.14.20]:53335 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S978888AbdDXWnz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 18:43:55 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id CNjr1v0031keHif01Njs6R; Mon, 24 Apr 2017 23:43:52 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=JPdLi4Cb c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=HnWYo9CF3BJTlypwlccA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [GSoC][RFC/PATCH v2] submodule: port subcommand foreach from
 shell to C
To:     Stefan Beller <sbeller@google.com>
References: <CAGZ79kYmRe+NURkgxRQM2QsGQEqtp+oGas5H0ryfztx8s2chwA@mail.gmail.com>
 <20170422195804.18477-1-pc44800@gmail.com>
 <CAGZ79kb1CR3qKOzByFC_wy7+Fh7cofFT1urhA06RuBK_3vGKmg@mail.gmail.com>
 <efe8e82d-a021-5fc4-492a-e6e0ab7d52d3@ramsayjones.plus.com>
 <CAGZ79kbU4LcRFHh5dM7i+L5DKpxKSrK-mZdYEeScrzVnYZsJmg@mail.gmail.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <c3b724d8-bb9b-b63b-0105-8c1e22b120be@ramsayjones.plus.com>
Date:   Mon, 24 Apr 2017 23:43:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbU4LcRFHh5dM7i+L5DKpxKSrK-mZdYEeScrzVnYZsJmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/04/17 23:17, Stefan Beller wrote:
> On Mon, Apr 24, 2017 at 3:11 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>>
>> On 24/04/17 21:03, Stefan Beller wrote:
>> [snip]
>>
>>> +
>>> + argv_array_pushf(&cp.env_array, "name=%s", sub->name);
>>> + argv_array_pushf(&cp.env_array, "path=%s", displaypath);
>>> + argv_array_pushf(&cp.env_array, "sm_path=%s", displaypath);
>>>
>>> You mention keeping 'sm_path' in the notes after the commit message. I would
>>> add that part to the commit message, to explain why we have multiple variables
>>> that have the same value. Maybe even a comment in the code:
>>>
>>>     /* Keep sm_path for historic reasons, see tests in 091a6eb0fee. */
>>>     .. sm_path ..
>>
>> Hmm, you need to be a bit careful with putting 'path' in the
>> environment (if you then export it to sub-processes) on windows
>> (cygwin, MinGW, GfW). See commit 64394e3ae9. I would have liked
>> to remove $path altogether from the 'submodule-foreach api' in
>> that commit, but users and their scripts were already using it
>> (so I couldn't just drop it, without some deprecation period).
>> So long as whatever was being 'eval'-ed in the script didn't
>> export $path, ...
>>
> 
> Oh, I misread the comment
> 
>      # we make $path available to scripts ...
>      path=$sm_path
> 
> as it was such a casual friendly thing to say in that context.
> So the *real* historic baggage is
>     argv_array_pushf(&cp.env_array, "path=%s", displaypath);
> whereas
>     argv_array_pushf(&cp.env_array, "sm_path=%s", displaypath);
> is considered the correct way to go.

I have to admit that I didn't actually read the code in this
patch. I just saw the subject line and the ass-backward comment
about $sm_path. ;-)

My intention was simply to warn: 'there be dragons'.

ATB,
Ramsay Jones


