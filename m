Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220881F453
	for <e@80x24.org>; Fri,  1 Feb 2019 11:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfBALNA (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 06:13:00 -0500
Received: from siwi.pair.com ([209.68.5.199]:24247 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfBALNA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 06:13:00 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 344353F4093;
        Fri,  1 Feb 2019 06:12:59 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A386C3F4090;
        Fri,  1 Feb 2019 06:12:58 -0500 (EST)
Subject: Re: [PATCH v4 03/14] trace2: collect platform-specific process
 information
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.108.v3.git.gitgitgadget@gmail.com>
 <pull.108.v4.git.gitgitgadget@gmail.com>
 <6167aba76ca43707bbba6de9f7c41a9fcb16063c.1548881779.git.gitgitgadget@gmail.com>
 <20190131231528.GC10587@szeder.dev>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a1bf3e53-3f79-32f4-f349-a3165c02f595@jeffhostetler.com>
Date:   Fri, 1 Feb 2019 06:12:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190131231528.GC10587@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/31/2019 6:15 PM, SZEDER Gábor wrote:
> On Wed, Jan 30, 2019 at 12:56:24PM -0800, Jeff Hostetler via GitGitGadget wrote:
>> Add optional platform-specific code to log information about
>> the current process.
>>
>> On Windows, this includes whether git.exe is running under a
>> debugger and information about the ancestors of the process.
>>
>> The purpose of this information is to help indicate if the
>> process was launched interactively or in the background by
>> an IDE, for example.
> 
>> diff --git a/trace2.h b/trace2.h
>> index a0e99d9c26..cb11a46366 100644
>> --- a/trace2.h
>> +++ b/trace2.h
>> @@ -363,4 +363,18 @@ __attribute__((format (printf, 1, 2)))
>>   void trace2_printf(const char *fmt, ...);
>>   #endif
>>   
>> +/*
>> + * Optional platform-specific code to dump information about the
>> + * current and any parent process(es).  This is intended to allow
>> + * post-processors to know who spawned this git instance and anything
>> + * else the platform may be able to tell us about the current process.
>> + */
>> +#if defined(GIT_WINDOWS_NATIVE)
>> +void trace2_collect_process_info(void);
>> +#else
>> +#define trace2_collect_process_info() \
>> +	do {                          \
>> +	} while (0)
>> +#endif
> 
> Please consider mentioning in the commit message that on other
> platforms this is a noop.  I was scrolling through the whole patch,
> skipping over the Windows-specific parts, to see how you did it on
> Linux, only to find the above do-nothing loop.  It was anticlimactic :)
> 
> Why is it a noop on other platforms?  I suspect that (since your main
> focus is supporting Windows devs using Git on Windows) it's along the
> lines of "I just didn't want to bother, and left it as future work for
> anyone interested", which a perfectly valid reason in my book.
> However, if you did look into it, and found some major difficulties or
> downright showstoppers, then that might be worth mentioning.
> (Portability?  I would expect that it would need a bunch of '#elif
> defined(...)')

Right, my primary focus was Windows at the time and I only added
the Windows version.  I'll document that.

Thanks
Jeff


