Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2115B20954
	for <e@80x24.org>; Thu,  7 Dec 2017 15:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbdLGPnF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 10:43:05 -0500
Received: from siwi.pair.com ([209.68.5.199]:64764 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753825AbdLGPnD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 10:43:03 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1C985844E7;
        Thu,  7 Dec 2017 10:43:03 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CFF32844E6;
        Thu,  7 Dec 2017 10:43:02 -0500 (EST)
Subject: Re: partial_clone_get_default_filter_spec has no callers
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <ec83f2d9-0d87-9d6b-4860-f4cd7c19984e@ramsayjones.plus.com>
 <89d06941-9bee-9334-d737-11ef7801cba2@jeffhostetler.com>
 <44d0c556-d5ba-186f-7493-f9900eccb442@ramsayjones.plus.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7a7400a1-0743-152a-fa3b-740c3b2b8e04@jeffhostetler.com>
Date:   Thu, 7 Dec 2017 10:43:02 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <44d0c556-d5ba-186f-7493-f9900eccb442@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/6/2017 8:59 PM, Ramsay Jones wrote:
> 
> 
> On 06/12/17 21:07, Jeff Hostetler wrote:
>>
>>
>> On 12/6/2017 12:39 PM, Ramsay Jones wrote:
>>> Hi Jeff,
>>>
>>> commit f1862e8153 ("partial-clone: define partial clone settings
>>> in config", 2017-12-05), which is part of your 'jh/partial-clone'
>>> branch, introduces the partial_clone_get_default_filter_spec()
>>> function without any callers. Could you please confirm that this
>>> is intentional and that, presumably, a future series will include
>>> a call to this function.
>>
>> I'll double check.  Thanks.
>>
>> BTW is there another tool that you're using to find these?
>> I know I ran make DEVELOPER=1 and make sparse on everything
>> and didn't see that come up.
> 
> In addition to sparse (which finds some of these), I also run a perl
> script over the object files after a given build. (The script was
> posted to the list by Junio, many moons ago, and I have made several
> changes to my local copy).
> 
> I am attaching a copy of the script (static-check.pl). Note that the
> 'stop list' in the script (%def_ok) is _way_ out of date. However, the
> way I use the script, that does not matter; I run the script over the
> master->next->pu branches and (ignoring the master branch) diff the
> result files from branch to branch. For example, tonight I have:
> 
>    $ wc -l sc nsc psc
>      74 sc
>      73 nsc
>      75 psc
>     222 total
>    $
>    $ diff sc nsc
>    44d43
>    < oidmap.o	- oidmap_remove
>    $
>    $ diff nsc psc
>    43a44
>    > list-objects-filter-options.o	- partial_clone_get_default_filter_spec
>    58a60
>    > sequencer.o	- sign_off_header
>    $
> 
> You also have to be careful with leaving stale object files
> laying around from previous builds ('make clean' sometimes
> doesn't). Actually, it may be simpler to read a previous mailing
> list thread on exactly this subject [1].
> 
[...]
> 
> ATB,
> Ramsay Jones
> 
> [1] https://public-inbox.org/git/%3Cb21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com%3E/
> 

thanks!  maybe you could post something (in contrib/ perhaps)
that would run your script on a pair of commits like t/perf/run.sh.
just a thought.

Jeff

