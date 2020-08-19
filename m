Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7F5C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3EBC20882
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3zSTpMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHSPJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgHSPJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 11:09:16 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5801C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:09:15 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g26so21898516qka.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VTLdDJn2GW1pIRnmhiX9ozLAwUyGILnwv0jaaTePDKo=;
        b=i3zSTpMDV0iUjURQOxSTNZV6XwlyU0t+PeSadG1jzqiVgzSZ/zBFjBI71C/ZQE3/f1
         oOrIGKv8VV0z/+J0g/vAsm3bs3OOKd+xJCTtCtMK/OgVC2ovR3yyG74S9KepR3eBEdZ2
         zE3e2cZWj74X7F0TKwaoUj0XODCcwTEWuH+KVT8PUrA05ibdIsaUmnHEh+mmtrbyKin+
         K/hUk3536YlDfBOKWqyPIBRZIqoJgInSBYShHCgB8T+wJ4GYKL71voLTvFitY8Ec6qZ/
         BT813q47MHNg30OFqT9VNNOvEp6P4EtFeqBJXuo6w5/ayV58dbNEN1Wz79VqtTsC+M1n
         bAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VTLdDJn2GW1pIRnmhiX9ozLAwUyGILnwv0jaaTePDKo=;
        b=Ch5+D7YChJUUTDW7CvhTHzvjLVRp34/TZqky9cRlqIg/vcgnvshvAixXJWbNoRkqve
         6WDBll69kOebJvPmxzloVdilom9VXL0BWh83KOIjK7IJmzSUS9eEXM79RoFVmI3TptK6
         afU37OMVDpC2ylrmB5ZiejqMbNobgDfb9Va1kt3De3hm+KbJC8uulxp/bmAERLgl7566
         3MyF+08c85GB11vUia7wcP88906dXO6VML7Y0VtsM6v/WOr+yYS/GAdIH7bkE4iYTLcN
         erveyHSgiH8KfbzWrS2uR/drkuGNqznyL3Pw73Rzclldchu0TfYWgGbGhCRXh77qS6oQ
         19tw==
X-Gm-Message-State: AOAM5318nJD+JxeHK+DNQNG/GA6AfF5+VQIQ9mw7q1FdWvzv/b/CSXU2
        jNi4yJlnL/XmVTin0gzdBWk=
X-Google-Smtp-Source: ABdhPJy07Aqo11M+H9bnw68cEgEQ2bjglqs6LWVgVZ613rurrU2Wh2nCWFHinYn82Co3eU/z+mkuSw==
X-Received: by 2002:a37:9d0d:: with SMTP id g13mr22131799qke.165.1597849754894;
        Wed, 19 Aug 2020 08:09:14 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:641b:4ef3:c176:5ed3? ([2600:1700:e72:80a0:641b:4ef3:c176:5ed3])
        by smtp.gmail.com with ESMTPSA id c22sm22560576qke.2.2020.08.19.08.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 08:09:14 -0700 (PDT)
Subject: Re: [PATCH v2 06/11] maintenance: add --task option
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, derrickstolee@github.com, dstolee@microsoft.com
References: <85268bd53ef7f4e7b3d97a8ae091290e8e74441d.1597760589.git.gitgitgadget@gmail.com>
 <20200819000015.2838345-1-jonathantanmy@google.com>
 <xmqq364jwjxg.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3a5328c0-15f0-a427-1f21-2c8e3ef8277a@gmail.com>
Date:   Wed, 19 Aug 2020 11:09:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <xmqq364jwjxg.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2020 8:36 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>>> @@ -66,6 +68,10 @@ OPTIONS
>>>  --quiet::
>>>  	Do not report progress or other information over `stderr`.
>>>  
>>> +--task=<task>::
>>> +	If this option is specified one or more times, then only run the
>>> +	specified tasks in the specified order.
>>
>> We should list the accepted tasks somewhere but maybe this can wait
>> until after part 2.

It's hard to see from the patch-context, but there is a section titled
"TASKS" that lists the 'gc' and 'commit-graph' tasks from the earlier
patches. Would a reference to that section be helpful?

	See the TASKS section for the list of available tasks.

>>> @@ -791,7 +791,9 @@ typedef int maintenance_task_fn(struct maintenance_opts *opts);
>>>  struct maintenance_task {
>>>  	const char *name;
>>>  	maintenance_task_fn *fn;
>>> -	unsigned enabled:1;
>>> +	unsigned enabled:1,
>>> +		 selected:1;
>>> +	int selected_order;
>>>  };
>>
>> "selected" and "selected_order" are redundant in some cases - I think
>> this would be better if selected_order is negative if this task is not
>> selected, and non-negative otherwise.
> 
> It is good to get rid of redundancies.
> 
>> Apart from that, maybe this should be documented. It is unusual (to me)
>> that a selection can override something being enabled, but that is the
>> case here.
> 
> I had the same reaction as "(to me)" above during an earlier review
> round, IIRC.  This definitely deserves documentation.

Will do. Thanks.

-Stolee
 

