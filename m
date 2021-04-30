Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1694DC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6721613BD
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhD3OcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 10:32:24 -0400
Received: from siwi.pair.com ([209.68.5.199]:15444 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232776AbhD3OcX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 10:32:23 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 19D6E3F4135;
        Fri, 30 Apr 2021 10:31:35 -0400 (EDT)
Received: from MININT-RVM6V2G.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E33493F4129;
        Fri, 30 Apr 2021 10:31:34 -0400 (EDT)
Subject: Re: [PATCH 05/23] fsmonitor--daemon: add a built-in fsmonitor daemon
To:     Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <95d511d83b1211f24aeb17edbd4918750f406ece.1617291666.git.gitgitgadget@gmail.com>
 <522e10e6-f18d-9c28-7102-f5a855d4be50@gmail.com>
 <1c45542a-5d80-6e51-26fe-94066987a566@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9e4f67f0-9a94-b93c-2f21-76555199a38e@jeffhostetler.com>
Date:   Fri, 30 Apr 2021 10:31:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1c45542a-5d80-6e51-26fe-94066987a566@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/21 11:45 AM, Derrick Stolee wrote:
> On 4/26/21 11:08 AM, Derrick Stolee wrote:
>> On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
>>
>> I think these compile-time macros should be replaced with a
>> method call, as I've said before. It should be simple to say
>>
>> 	if (!fsmonitor_ipc__is_supported())
>> 		die(_("fsmonitor--daemon is not supported on this platform"));
>>
>> and call it a day. This can be done before parsing arguments.
>>
>>> +int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
>>> +{
>>> +	enum daemon_mode {
>>> +		UNDEFINED_MODE,
>>> +	} mode = UNDEFINED_MODE;
>>> +
>>> +	struct option options[] = {
>>> +		OPT_END()
>>> +	};
>>
>> I can see where you are going here, to use the parse-opts API
>> to get your "--<verb>" arguments to populate an 'enum'. However,
>> it seems like you will run into the problem where a user enters
>> multiple such arguments and you lose the information as the
>> parser overwrites 'mode' here.
> 
> I see that you use OPT_CMDMODE in your implementation, which
> makes this concern invalid.
> 
>> Better to use a positional argument and drop the "--" prefix,
>> in my opinion.
> 
> This is my personal taste, but the technical reason to do this
> doesn't exist.

Either method is fine/equivalent and I'm open to doing it either
way.  (In fact, I did the t/helper/test-simple-ipc the other way
and didn't even think about it.)

Does the mailing list have a preference for one form over the other?
That is:

     git fsmonitor--daemon --start [<options>]
vs
     git fsmonitor--daemon start [<options>]

Jeff

