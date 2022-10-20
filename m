Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89B7C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 14:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJTOkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 10:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJTOke (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 10:40:34 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D721614C502
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 07:40:31 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 60203CA123B;
        Thu, 20 Oct 2022 10:40:31 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 26F9CCC8319;
        Thu, 20 Oct 2022 10:40:31 -0400 (EDT)
Subject: Re: [PATCH v2 4/7] trace2: rename the thread_name argument to
 trace2_thread_start
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
 <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
 <637b422b8606b3b6d954e6a1959aae450507cdfa.1665600750.git.gitgitgadget@gmail.com>
 <221012.86edvcn3yc.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <27526718-7961-dc2c-946e-98757b3b36c8@jeffhostetler.com>
Date:   Thu, 20 Oct 2022 10:40:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <221012.86edvcn3yc.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/12/22 5:06 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Oct 12 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Rename the `thread_name` argument in `tr2tls_create_self()` and
>> `trace2_thread_start()` to be `thread_base_name` to make it clearer
>> that the passed argument is a component used in the construction of
>> the actual `struct tr2tls_thread_ctx.thread_name` variable.
>>
>> The base name will be used along with the thread id to create a
>> unique thread name.
> 
> Makes sense.
> 
>> This commit does not change how the `thread_name` field is
>> allocated or stored within the `tr2tls_thread_ctx` structure.
> 
> What this commit does change though, which isn't mentioned here, is...
> 
>> diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
>> index 1297509fd23..7d1f03a2ea6 100644
>> --- a/trace2/tr2_tls.h
>> +++ b/trace2/tr2_tls.h
>> @@ -25,17 +25,20 @@ struct tr2tls_thread_ctx {
>>   /*
>>    * Create thread-local storage for the current thread.
>>    *
>> - * We assume the first thread is "main".  Other threads are given
>> - * non-zero thread-ids to help distinguish messages from concurrent
>> - * threads.
>> - *
>> - * Truncate the thread name if necessary to help with column alignment
>> - * in printf-style messages.
>> + * The first thread in the process will have:
>> + *     { .thread_id=0, .thread_name="main" }
>> + * Subsequent threads are given a non-zero thread_id and a thread_name
>> + * constructed from the id and a thread base name (which is usually just
>> + * the name of the thread-proc function).  For example:
>> + *     { .thread_id=10, .thread_name="th10fsm-listen" }
>> + * This helps to identify and distinguish messages from concurrent threads.
>> + * The ctx.thread_name field is truncated if necessary to help with column
>> + * alignment in printf-style messages.
> 
> ...this documentation, which I'd argue should be a separate change, as
> nothing's changed about the state of the world with this rename of the
> field, this was all true before this rename.
> 

good point.  i'll split it and resend.
thanks
Jeff
