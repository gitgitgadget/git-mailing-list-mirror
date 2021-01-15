Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD36C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FAF23AC6
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbhAOCz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 21:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbhAOCz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 21:55:27 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D22C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 18:54:47 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id l200so8174982oig.9
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 18:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y/811c5ZiSLhqkGzGc3R4PxHocyUny5d4c25c2KXNw8=;
        b=UHb2RxNxtOd6MT5LiIx/1MAQkAQEXGN1+RKVe0yeLz57oi0MjhSaVJJM4Vzsn0ENl9
         +ukoo046rGM11ZjhiI9dCajuQq/YWdL+v59p1GNTlJZXs9qHl0DaEJ8SeXoiSAA7zVar
         qyQsbXnIGA9Ufj5DJEsbLUEZd7aI8I7ug7LL95cBDn1TY92XA4muAmD5obMvnhAZOn4S
         j+mNtmq2DzkUuriLXIapwC5OMdmOqQNFQ/ofuxZPFePGSVv5wB3id5swxSE9tLUANR3u
         Do39yhrM03uC9OSsRCJHjJiHeTrKf11lRIRu34wQajNysHEp8B5o0SfRiJGnk6OdU4NZ
         Y+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y/811c5ZiSLhqkGzGc3R4PxHocyUny5d4c25c2KXNw8=;
        b=WymLTUeph/4oYX+spQi8BuK6KgBgBwfz65oYNmQ/gv0CyLJWaM0jrEQnjkCmKCRrVp
         k7Dyc2N2xvwtVdvx1oMhVXmHMo0DPcRGF3PFygKDWzYP80IeBvudBaHaQZWzCj1teQup
         bIZArCpLUA4KDBfYhvcA6hmlxgO4xKivwe911lyWcz+1Zev8RrGVAJEVYvgrG1B8OW+v
         NRgVjS3E5/KDbvzlzd5ewVUURZPgDF4Kj5f0z3X2pSQqIL/VvEhjtu+RWxIszAxKgjdz
         Zp563TLs1amlFJ4iIDtFUzony7hAoqqll/oClOG5FKYNpOIUMWUqAg2s81MSl1j3ueGK
         IwRg==
X-Gm-Message-State: AOAM530aT2/zhsGrfWkt81mQ4Sf3xW+OB9pTRnVb7o0YsfO4/5O+4j/2
        uY0PA/Krdhz8SflX1X7J/GSqI8w6EYM=
X-Google-Smtp-Source: ABdhPJztma0jobgTnuqx+F9DIhiW9q294rpCFkLqsayBrAIeXIvGEYSI1QI/Z0qH+bhPmNlfiUmvrA==
X-Received: by 2002:a05:6808:49a:: with SMTP id z26mr4328701oid.137.1610679286084;
        Thu, 14 Jan 2021 18:54:46 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:81b0:4431:6d9:fc9e? ([2600:1700:e72:80a0:81b0:4431:6d9:fc9e])
        by smtp.gmail.com with UTF8SMTPSA id s66sm1501634ooa.37.2021.01.14.18.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 18:54:45 -0800 (PST)
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
From:   Derrick Stolee <stolee@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
 <YADOf41CcaRuToD7@google.com>
 <15237c6c-98eb-0d1f-e6d5-2dda91c0ce09@gmail.com>
Message-ID: <47b76019-6e58-3f79-e927-c5c6b6e28075@gmail.com>
Date:   Thu, 14 Jan 2021 21:54:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <15237c6c-98eb-0d1f-e6d5-2dda91c0ce09@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/14/2021 9:36 PM, Derrick Stolee wrote:
> On 1/14/2021 6:06 PM, Emily Shaffer wrote:
>> On Fri, Jan 08, 2021 at 11:22:23AM -0800, Junio C Hamano wrote:
>>> * ds/maintenance-part-4 (2021-01-05) 4 commits
>>>   (merged to 'next' on 2021-01-08 at 1f98c859ea)
>>>  + maintenance: use Windows scheduled tasks
>>>  + maintenance: use launchctl on macOS
>>>  + maintenance: include 'cron' details in docs
>>>  + maintenance: extract platform-specific scheduling
>>>
>>>  Follow-up on the "maintenance part-3" which introduced scheduled
>>>  maintenance tasks to support platforms whose native scheduling
>>>  methods are not 'cron'.
>>>
>>>  Will merge to 'master'.
>>
>> This series again has troubles running inside a directory with regex
>> metachars in the path. Courtesy of Jonathan Nieder, I think this fix
>> matches the intent a little better; but if we don't like this, the same
>> lines could be diffed just to add --fixed-value instead.
...
>>
>> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
>> index 2e0c8a4c31..0edad63227 100755
>> --- a/t/t7900-maintenance.sh
>> +++ b/t/t7900-maintenance.sh
>> @@ -487,7 +487,9 @@ test_expect_success 'start and stop macOS maintenance' '
>>  	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start &&
>>  
>>  	# start registers the repo
>> -	git config --get --global maintenance.repo "$(pwd)" &&
>> +	pwd >expect &&
>> +	git config --get --global maintenance.repo >actual &&
>> +	test_cmp expect actual &&
> 
> Sorry again, but this (and others) would probably be better as
> 
> +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&

Alternatively, the additional cases of "git config --get --global" in
ds/maintenance-part-4 could actually be simply _removed_ because we
are running all tests on all platforms. We already verify this behavior
in the cron tests, such as 'start from empty cron table'.

Thanks,
-Stolee
