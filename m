Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0F0C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 16:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B9A20656
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 16:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdqfuP5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391216AbgDNQA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732397AbgDNQAZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 12:00:25 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9D5C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 09:00:25 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id d7so5779474oif.9
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 09:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m2fVW3Ls2zzHcqM99ZOVzpLRJp6PXPoU2NBTYsd/eLQ=;
        b=sdqfuP5NEQfve9VEBwkFtfpga/PrER57/fl8jfm16R56qaRf9BY2tBpcJl2gUsqFkm
         oaaFhddckLGR41aNH199A6BPyURgSNq8a9mVk7DRMynlNCXljByruiCYl1ZUabQDvXxW
         ++Jl8D+6jyXoCIYaNVdCISEo0P9kSKfgZktZanz7EvpALXScZwMkAp3ObUuohKipRtfA
         RwYbqzDD500rEFW7grJ2mnhg7PcrbzQIwoRq37b00/krpelgqN7Soo7Xf/RH6gHM11bc
         ywNEqR6IfyS7zgb+yUK2h+VDBEU2yYzdmoNqtt6MMlUrxFqD3kXbJaupHEXjuKFMF/28
         jQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m2fVW3Ls2zzHcqM99ZOVzpLRJp6PXPoU2NBTYsd/eLQ=;
        b=hzMJBcqsFKatyAV7bK0QugiytPCAdczssZ68AGtHvgAeMEpbIiDOo8I6u4aDoSqQp4
         JuS74Moc2DpuFRlorHXUUw//3TprCwI98pyuCWmAzWx4ca4wVoqcRxCKhYzK76z0pyHr
         tu1OtYxYyYqKRgmX2pq3fikaHnyh+LlwgqSZMcxVztyI4cUtA2bb2zdphvHFJLT8jkKw
         C8C1khV4JAkN39+QLFxxEdfgKb3CjnohOMIv6mq3bmrVdHuRzIbUVvye+3mKw9182WRG
         bXZ7L5RPbe7vLNmeHPmfSbknhdp2XFGSue5XlhnEZm+Povux6anaCbhncjkJBIQZEnXa
         EuQw==
X-Gm-Message-State: AGi0PuZYWGSNLi9vfez8yNXCrGgMHFnfZKch1nUgvbFPRA9atj9GVeI3
        bTvlX2usLjlTjXSb0VBbNao=
X-Google-Smtp-Source: APiQypKBMTtvjSLGs04t6zVz8kleU4qxYnISNIAliLrG17gzLz7CjEK7N0FQV71g09OyYa+TSZOwDA==
X-Received: by 2002:aca:dc56:: with SMTP id t83mr1397342oig.48.1586880024583;
        Tue, 14 Apr 2020 09:00:24 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u199sm5714579oif.25.2020.04.14.09.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 09:00:24 -0700 (PDT)
Subject: Re: [PATCH] log: add log.excludeDecoration config option
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sluongng@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
 <20200413154945.GA59601@syl.local>
 <0b9e3156-1101-0f19-91eb-36af541519aa@gmail.com>
 <20200414154513.GB93424@syl.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <31e24f9f-44b0-d0f7-3d81-12365edf7a40@gmail.com>
Date:   Tue, 14 Apr 2020 12:00:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <20200414154513.GB93424@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/2020 11:45 AM, Taylor Blau wrote:
> On Tue, Apr 14, 2020 at 11:10:33AM -0400, Derrick Stolee wrote:
>>>>  log.follow::
>>>>  	If `true`, `git log` will act as if the `--follow` option was used when
>>>>  	a single <path> is given.  This has the same limitations as `--follow`,
>>>> diff --git a/builtin/log.c b/builtin/log.c
>>>> index 83a4a6188e2..d7d1d5b7143 100644
>>>> --- a/builtin/log.c
>>>> +++ b/builtin/log.c
>>>> @@ -236,7 +236,21 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>>>>  	}
>>>>
>>>>  	if (decoration_style) {
>>>> +		const struct string_list *config_exclude =
>>>> +			repo_config_get_value_multi(the_repository,
>>>> +						    "log.excludeDecoration");
>>>> +
>>>> +		if (config_exclude) {
>>>> +			struct string_list_item *item;
>>>> +			for (item = config_exclude->items;
>>>> +			     item && item < config_exclude->items + config_exclude->nr;
>>>> +			     item++)
>>>
>>> Any reason not to use the 'for_each_string_list_item' macro in
>>> 'string-list.h' for this?
>>
>> The reason is I forgot about it.
> 
> Heh, in fairness I forgot about it, too :). I thought that this code
> looked familiar, but it was only luck that I had 'string-list.h' open at
> the time I was reading this.
> 
> I don't think that it really matters much each way, but if you're
> already re-rolling...

This is probably worth a re-roll on its own. I'll give the patch
some extra time to simmer before pushing a v2, though.

-Stolee
