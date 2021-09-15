Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C7FC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 14:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A9760F13
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 14:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbhIOOnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 10:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbhIOOnE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 10:43:04 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ADFC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 07:41:45 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d11so2519631qtw.3
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kgxwoIUrUid/RiDiC7ZlLQWLzwcx+pk23GWi+3ATQAk=;
        b=MkpO8AWoVJ+gMkhf5ZbNcfEHAIpsLIRoWe6gftDpUEd/AqDSkgP60e3+o6QmPpz6iM
         mWND0cPMopCnK7ObjOwwQlWkLYbGw+NUa9u2byX+pRdCKliMDv89FofdedZqjrnSlvJZ
         Ct8lvsUPRX8pt4vFiRXASA1ZWloTrIxhZf9U33EwkLWnwwF+lyujDs+nANc490/0FSN9
         ojpCE1OFYtRYRpT5MX47ftESKCXsn24Ou9OPKV7cNZODoOfgRz5cF7d1QvxFRQL+1ZXK
         28lfwEBKxQvNh11n2/McYX+38okeVBz0WjniuFHmvivdDyVsJ2dgV+Tz6MoSq5BS511S
         pfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kgxwoIUrUid/RiDiC7ZlLQWLzwcx+pk23GWi+3ATQAk=;
        b=wBRH9O+ZPi7lubff6RwMvMUIp4dxC61SU2Xo3mDg+RgVzc1LZ8LIOnfsgQh9ZfjdMu
         oG49cvC7lxHEItv41kV28kpkoJSWx+UzewL9uqmiamfOIkqBcy7vQzSXbMxFHjapqr9K
         sk5V7yg0PWnOyK7BsvijaIrxbLMkLw9RBW5/Wa+aPWQ9sAVpA/ELYciYQDw4ykxi3eHu
         fkHK+Mv8HfQPXflmRFdOeiWzh23pbYXIskA2m3HUig7+G8NpfIvRekjOJ2NW5NDt5iuC
         SEVX8YIfRRbnBZMBDxXfVCei9GWy7aiimYKsVTXniKgq7jJMQx16/3pGXBDnS7OXzOLu
         uBlA==
X-Gm-Message-State: AOAM532X6cauRO3HbPy3/uVNW+/A8Bin+iVHLD1oFGtNkP8AQ4S5wnFE
        EkyGeF5nVnugYjiODTyx8xs=
X-Google-Smtp-Source: ABdhPJy7yvMW/Xn3ryMX+4EnBuoSx04gKLjw9Sx+uoJtVPUUPx17mO4l1sSfg6VZSL0SW2MvESTVaQ==
X-Received: by 2002:ac8:4e0c:: with SMTP id c12mr144626qtw.173.1631716904863;
        Wed, 15 Sep 2021 07:41:44 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8cdb:119:9f7e:3e24? ([2600:1700:e72:80a0:8cdb:119:9f7e:3e24])
        by smtp.gmail.com with ESMTPSA id e22sm95467qtm.10.2021.09.15.07.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 07:41:44 -0700 (PDT)
Subject: Re: [PATCH v2 04/14] dir: select directories correctly
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        matheus.bernardino@usp.br, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <723de4e42582afbe841ed96470fc02db44b24b5e.1631453010.git.gitgitgadget@gmail.com>
 <87h7ep5t5t.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3262acae-3ae1-7309-a1dd-b2e1472391a2@gmail.com>
Date:   Wed, 15 Sep 2021 10:41:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87h7ep5t5t.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/12/2021 6:21 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Sep 12 2021, Derrick Stolee via GitGitGadget wrote:
> 
>> +	/*
>> +	 * Use 'alloc' as an indicator that the string has not been
>> +	 * initialized, in case the parent is the root directory.
>> +	 */
>> +	if (!path_parent->alloc) {
> 
> This isn't wrong, but seems to be way too cozy with the internal
> implementation details of strbuf. For what it's worth I renamed it to
> "alloc2" and found that this would be only the 3rd bit of code out of
> strbuf.[ch] that cares about that member.

I can understand not wanting to poke into the internals.

>> +		char *slash;
>> +		strbuf_addstr(path_parent, pathname);
> 
> So is "pathname" ever the empty string? If not we could check the
> length?

We are given 'pathlen' as a parameter, so this should just use
strbuf_add() instead.

> Or probably better: ...
> 
>> @@ -1331,6 +1359,7 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
>>  {
>>  	struct path_pattern *res = NULL; /* undecided */
>>  	int i;
>> +	struct strbuf path_parent = STRBUF_INIT;
> 
> Just malloc + strbuf_init() this in the above function and have a
> "struct strbuf *" initialized to NULL here? Then we can use a much more
> idiomatic "is it NULL?" to check if it's initialized.
 
That makes sense. Can do.

Thanks,
-Stolee
