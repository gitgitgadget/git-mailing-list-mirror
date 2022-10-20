Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50369C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJTUwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJTUwy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:52:54 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B90196351
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:52:53 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7973CCA123B;
        Thu, 20 Oct 2022 16:52:52 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2326BCC833B;
        Thu, 20 Oct 2022 16:52:52 -0400 (EDT)
Subject: Re: [PATCH v3 7/8] trace2: add stopwatch timers
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
 <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
 <8e701109976777ad8fae1e0cd3908bb11a1fcf93.1666290489.git.gitgitgadget@gmail.com>
 <xmqq7d0us0o2.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b7860e10-b174-2fb2-53eb-568686a961c4@jeffhostetler.com>
Date:   Thu, 20 Oct 2022 16:52:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq7d0us0o2.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/20/22 4:25 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +#define NS_PER_SEC_D ((double)1000*1000*1000)
>> ...
>> +	double t_total = ((double)timer->total_ns) / NS_PER_SEC_D;
>> +	double t_min = ((double)timer->min_ns) / NS_PER_SEC_D;
>> +	double t_max = ((double)timer->max_ns) / NS_PER_SEC_D;
> 
> Hmph, it certainly is an improvement compared to the previous round,
> but was there a reason why we did not want a more concise
> 
> 	#define NS_TO_SECONDS(ns) ((double)(ns) / (1000*1000*1000.))
> 
> 	double t_total = NS_TO_SECONDS(timer->total_ns);
> 	double t_min = NS_TO_SECONDS(timer->min_ns);
> 	double t_max = NS_TO_SECONDS(timer->max_ns);
> 
> that does not need to repeat (double) all over?
> 
> Not worth a reroll by itself.  Just wanted to know the reasoning
> behind it, as I suspect I am missing the reason why it is good to
> explicitly casting with (double) in some places; the above does not
> look like one, though.
> 
> Thanks.
>

um, it never occurred to me to make it a macro with an arg.
i just did a search/replace on the inline constant.

you're right though. your version is much shorter.

i'll reroll tomorrow with the typo that AEvar found.

Thanks
Jeff


