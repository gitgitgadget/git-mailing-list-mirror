Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C76901F453
	for <e@80x24.org>; Thu, 31 Jan 2019 19:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfAaTpa (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 14:45:30 -0500
Received: from siwi.pair.com ([209.68.5.199]:27487 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbfAaTpa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 14:45:30 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 271EF3F4022;
        Thu, 31 Jan 2019 14:45:29 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F292E3F4015;
        Thu, 31 Jan 2019 14:45:28 -0500 (EST)
Subject: Re: [PATCH v3 00/14] Trace2 tracing facility
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com
References: <pull.108.v2.git.gitgitgadget@gmail.com>
 <pull.108.v3.git.gitgitgadget@gmail.com> <20190131143811.GB10587@szeder.dev>
 <9b603fd7-d8f0-1ce7-7c7c-8b17484d7d0a@jeffhostetler.com>
 <xmqqbm3w3bjz.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0764948c-f3ac-3bd1-fd82-2bd3f59b463d@jeffhostetler.com>
Date:   Thu, 31 Jan 2019 14:45:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <xmqqbm3w3bjz.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/31/2019 1:51 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>>>>        -+	for_each_builtin(j, tgt_j) {
>>>>        ++	for_each_builtin(j, tgt_j)
>>>>        ++	{
>>>>         +		tgt_j->pfn_term();
>>>>         +	}
>>>
>>> Our CodingGuidelines prefer the opening brace on the same line after
>>> the if/for/while/struct/etc. statement, and even omitting the braces
>>> if the if arm or loop body consists of a single statement.  So
>>> unfortunately a considerable part of this range diff goes in the wrong
>>> direction.
>>
>> I know they do and I had them on the same line originally.
>>
>> Clang-format was complaining about every use of the for_each_builtin
>> macro, so I changed them to be on the next line to quiet it.
> 
> Well, clang-format is wrong then ;-)

Ok.  I had never even heard of clang-format until Josh suggested
that it flagged several commits in my series.  The last thing I wanted
to do was to start hacking up its config file (in the dark) assuming
that is even an option.

I can undo my formatting changes if we want to update the settings.
I'll give that a try if there are no objections.

> 
>> I hesitate to remove braces around a statement adjacent to a
>> for_each macro trick for the usual safety reasons.
> 
> Sorry, but what's "usual safety reasons"?  Isn't a macro that
> requires {} in order to work correctly simply broken?
> 
> I see (from a previous iteration---sorry, but I haven't caught up)
> 
> #define for_each_builtin(j, tgt_j)                      \
>          for (j = 0, tgt_j = tr2_tgt_builtins[j];        \
>               tgt_j;                                     \
>               j++, tgt_j = tr2_tgt_builtins[j])
>                                    
> 
> and I do not think
> 
> 	for (j = 0, tgt_j = ...; tgt_j; j++, tgt_j = ...)
> 		statement;
> 
> is unsafe (iow, your macro is not broken).
> 
> Puzzled.
> 

Right, I don't think my macro is broken either.  It is more
my personal paranoia about preventing accidents (like wrapping
macro parameters in parens when using them in the macro body).

I can remove them if we want.

Jeff
