Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D41C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 17:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2F260F21
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 17:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245153AbhIQR2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 13:28:38 -0400
Received: from siwi.pair.com ([209.68.5.199]:28156 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240938AbhIQR2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 13:28:38 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6A1663F40D5;
        Fri, 17 Sep 2021 13:27:15 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1004:b109:12e8:cc1c:b3d3:708a:a5be])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 010763F4096;
        Fri, 17 Sep 2021 13:27:14 -0400 (EDT)
Subject: Re: [PATCH 4/7] simple-ipc/ipc-win32: add trace2 debugging
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <30b7bb247c3c8531119f99e293d84b1836297251.1631738177.git.gitgitgadget@gmail.com>
 <87bl4tm5s1.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c99ad8cb-3a95-3df3-3df4-240980e12ef1@jeffhostetler.com>
Date:   Fri, 17 Sep 2021 13:27:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87bl4tm5s1.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/16/21 1:40 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Sep 15 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> @@ -112,6 +115,11 @@ static enum ipc_active_state connect_to_server(
>>   				if (GetLastError() == ERROR_SEM_TIMEOUT)
>>   					return IPC_STATE__NOT_LISTENING;
>>   
>> +				gle = GetLastError();
>> +				trace2_data_intmax("ipc-debug", NULL,
>> +						   "connect/waitpipe/gle",
>> +						   (intmax_t)gle);
>> +
>>   				return IPC_STATE__OTHER_ERROR;
>>   			}
>>   
>... 
 >
> @@ -109,9 +109,12 @@ static enum ipc_active_state connect_to_server(
>   			t_start_ms = (DWORD)(getnanotime() / 1000000);
>   
>   			if (!WaitNamedPipeW(wpath, timeout_ms)) {
> -				if (GetLastError() == ERROR_SEM_TIMEOUT)
> +				gle = GetLastError();
> +				if (gle == ERROR_SEM_TIMEOUT)
>   					return IPC_STATE__NOT_LISTENING;
>   
> +				/* ...rest of your patch */
> +
>   				return IPC_STATE__OTHER_ERROR;
>   			}
>   
> 

Yeah, I was just trying to minimize the size of the diff
and at the time was considering those debug messages to be
temporary, but I kind of like having them so it makes sense
to clean up a bit as you've indicated.

Thanks
Jeff
