Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387B9C433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 12:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137C02065E
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 12:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulSCiwxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGXMvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGXMvg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 08:51:36 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836C8C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 05:51:36 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e12so6751474qtr.9
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fr4nzXZOlO5LcEL/pQYqJbYkP2Slm3z2LyfudtruL7w=;
        b=ulSCiwxtioGZYgvnQ9l7j6x8YhHxZ+ycJZR0U6KGyguW9+eCYJIS0DDsdTrWa1V7xP
         d5jvBKLAmOQbNlYH9oBM4vkjsCTS41nu3p8ginkJS0siSsq9RgNMHL84N8Q0Atv3ueKo
         7yzko8HnEMdX9br+efYNnb9UIAmSerVViKO1C14pzLh58NyAazfQHbaDw0ga7E9hk6Kp
         c/LJl+gwTUcAWDeKqJFvYOZ7z+t1iXauJ/VO2gWIQKPfo28BLk+NkwJTY8KyIrAPNss/
         RGQefzhFINRLPG3FUmOlK3BTfoiOkcPMgv7HAUBnVB0CjQagBdhuMW23yS9yBOBopNJz
         bbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fr4nzXZOlO5LcEL/pQYqJbYkP2Slm3z2LyfudtruL7w=;
        b=mbjf+T7x7CK0PcT7MKr/c0jZCR9XfAc62CR51YoYjTancXPnvqosH/uTNQBeV3mqO+
         Z7G+wB4y/n9YCFT9ZH2Vx8Si8oLs+Qy88ey6qFgogjxBAM7IN35HGhqGGcX28s96d+Rf
         7XCmR59kXv/4TpNVhBeGlDObADILzxlBqHyEyQ11vrdRwPvHdPfTSQ7XcW5Mo9mHj2ma
         VCGyOhaykv0I1ZuGcCBhnXMXmZmMramajdvdL1xkjFjctvBtN5VT1drk6+iYh762lp07
         Thk+vRlZHV6BIOhFyhHMO3KRClndgotICr14+znLn6iwWAuKg+/aCrPycr24G0OeB/Iw
         EiGQ==
X-Gm-Message-State: AOAM531dGAbfIV7RFdAvKlPGWpHOVfhJTWyxMhBCw5r0Sxic8l4/0TjA
        +glyXAsz1cUMNriWuKtOAsQ=
X-Google-Smtp-Source: ABdhPJxV3Rs81I2GXDAXW7oYKWPpLMCCzObF/S8qO7VJQEpVxChgg8znyxze+wbrIsUuocrthVJ+Pw==
X-Received: by 2002:ac8:744a:: with SMTP id h10mr9498882qtr.241.1595595095504;
        Fri, 24 Jul 2020 05:51:35 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:44af:70e9:4b5b:8d7f? ([2600:1700:e72:80a0:44af:70e9:4b5b:8d7f])
        by smtp.gmail.com with ESMTPSA id r7sm1029482qtm.66.2020.07.24.05.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 05:51:34 -0700 (PDT)
Subject: Re: [PATCH v2 04/18] maintenance: initialize task array
From:   Derrick Stolee <stolee@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <8e260bccf1a0b6cd799a6bc78798b31ebed8ad7e.1595527000.git.gitgitgadget@gmail.com>
 <xmqqr1t2qa1n.fsf@gitster.c.googlers.com>
 <1501583a-0fb0-ad88-bd2f-4f64c3c66980@gmail.com>
Message-ID: <67e49b30-9a7f-8c18-3a06-96c516027c7a@gmail.com>
Date:   Fri, 24 Jul 2020 08:51:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <1501583a-0fb0-ad88-bd2f-4f64c3c66980@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/24/2020 8:23 AM, Derrick Stolee wrote:
> On 7/23/2020 3:57 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> +static void initialize_tasks(void)
>>> +{
>>> +	int i;
>>> +	num_tasks = 0;
>>> +
>>> +	for (i = 0; i < MAX_NUM_TASKS; i++)
>>> +		tasks[i] = xcalloc(1, sizeof(struct maintenance_task));
>>> +
>>> +	tasks[num_tasks]->name = "gc";
>>> +	tasks[num_tasks]->fn = maintenance_task_gc;
>>> +	tasks[num_tasks]->enabled = 1;
>>> +	num_tasks++;
>>
>> Are we going to have 47 different tasks initialized by code like
>> this in the future?  I would have expected that you'd have a table
>> of tasks that serves as the blueprint copy and copy it to the table
>> to be used if there is some need to mutate the table-to-be-used.
> 
> Making it a table will likely make it easier to read. I hadn't
> thought of it.
> 
> At the start, I thought that the diff would look awful as we add
> members to the struct. However, the members that are not specified
> are set to zero, so I should be able to craft this into something
> not too terrible.

OK, my attempt has led to this final table:

	const struct maintenance_task default_tasks[] = {
		{
			"prefetch",
			maintenance_task_prefetch,
		},
		{
			"loose-objects",
			maintenance_task_loose_objects,
			loose_object_auto_condition,
		},
		{
			"incremental-repack",
			maintenance_task_incremental_repack,
			incremental_repack_auto_condition,
		},
		{
			"gc",
			maintenance_task_gc,
			need_to_gc,
			1,
		},
		{
			"commit-graph",
			maintenance_task_commit_graph,
			should_write_commit_graph,
		}
	};
	num_tasks = sizeof(default_tasks) / sizeof(struct maintenance_task);

This is followed by allocating and copying the data to the
'tasks' array, allowing it to be sorted and modified according
to command-line arguments and config.

Is this what you intended?

Thanks,
-Stolee
