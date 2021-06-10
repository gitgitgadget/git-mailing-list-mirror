Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3348CC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 080526128A
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhFJOxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 10:53:55 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:54002 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhFJOxz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 10:53:55 -0400
Received: by mail-wm1-f44.google.com with SMTP id b205so1642275wmb.3
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B4jX3gdc6vqMiLMLhanKBqjaWdH/fkQg63DfMpwBgiU=;
        b=QjDbMidMQMEcnN+umLpTMZoUMvc7SCbpvAYCiXx6CLEEvdq1gPJIEc/WQ3vJCSlV23
         A/zevA0x2o6GSy7fZmDRSWYs993Ng7UNaqc78b5fHO5lwhccVIsr0bp/LEP90gLC7URd
         Dz8lqm/T9dv153znj3wW7CF5zSFXFFtlFjIx8WsJXyBNbZv4HalRg6+FSBFJbxKWE2RF
         QGWgc9FTXpbVighzPLX33hotxESs9NXPi5uuLjX5s5Wgj2ReDixLgTqu/nQD9A8fO7QL
         4IV1VAqEsiLPRZJJLJtD5QsnjNBSUxCY1RAf21ehcXnkmnlxbdoYg5i0xPzXsHJulYnj
         6Ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B4jX3gdc6vqMiLMLhanKBqjaWdH/fkQg63DfMpwBgiU=;
        b=KRDyE5fkDxggHScMdzRmNHCaZtS9KHpEIt1MVC4DNtTkDyRjkEDXKrqusFeQwlvjGC
         BU3CuoPJb/7AWou8leAI4WvDGEcT3UzLDsVSwMjXs2/79gO5yZ5t+8VQkxEdnXJ4njOj
         P1hYMsUB47e085/iIxIBTJZ1cEsemMZogI7StMBV1qgZ6vOCRdNQ+Se1svZboOPbA3cq
         Ufj2kkXOzoWD5Yw6SsOBLeqvfWDF7ORHMo2NVczHwrpfGxmkwcjiZ7MU5mYm0XGLZDRR
         KO5EG+HAHSU+ZsnMHVgk0Y7ARxyqKVklzJXIsct/hZ6YgH6p6S56558HL7Yw2CeWzBfs
         TSqg==
X-Gm-Message-State: AOAM530Pi+sVC4mOy9fDw4KC6+LV5meMXZ/c2BvVeASOpxGN3L1Nhc4T
        /U8uWGlAhEm5kqQ5vA8LBSk=
X-Google-Smtp-Source: ABdhPJwfjHqCdapD/XCmO/mszyQoerwTCnwC2rqW+jCCssOmEWUMExCzsRUXjf0Y9Fx/QSg5TJwl8Q==
X-Received: by 2002:a05:600c:b50:: with SMTP id k16mr5427485wmr.137.1623336644449;
        Thu, 10 Jun 2021 07:50:44 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id i9sm4889086wrn.54.2021.06.10.07.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 07:50:44 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/7] checkout: fix merge.conflictstyle handling
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-5-felipe.contreras@gmail.com>
 <b4b9264d-1c17-1a62-f0ec-2791ab20adeb@gmail.com>
 <60c21d9ce8848_b25b120884@natae.notmuch>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <49da6d73-c49f-d75e-0eb2-b12bd529fcfa@gmail.com>
Date:   Thu, 10 Jun 2021 15:50:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60c21d9ce8848_b25b120884@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06/2021 15:11, Felipe Contreras wrote:
> Phillip Wood wrote:
>> On 09/06/2021 20:28, Felipe Contreras wrote:
>>> Currently both merge.conflictStyle and `git commit --merge
>>> --conflict=diff3` don't work together, since the former wrongly
>>> overrides the later.
>>>
>>> The way merge configurations are handled is not correct.
>>> It should be possible to do git_config(merge_recursive_config, ...) just
>>> like we can with git_diff_basic_config and others.
>>
>> It would be helpful to explain what the problem with
>> merge_recursive_config() actually is rather than just saying "it should
>> be possible ..."
> 
> The problem is that you can't do this:
> 
>    git_config(merge_recursive_config, NULL);
> 
> As it was explained.

You do not explain why you cannot do that

> That is the problem. I don't know how that's not clear.
> 
>>> Therefore builtins like `git merge` can't call this function at the
>>> right time.
>>   >
>>> We shuffle the functions a little bit so at least merge_recursive_config
>>> doesn't call git_xmerge_config directly and thus override previous
>>> configurations.
>>
>> Rather than papering of the problem, how difficult would it be to add a
>> field to ll_merge_options and pass the conflict style with that rather
>> than fiddling with the order that we set a global variable.
> 
> Probably not that difficult, but then we also need a parser that
> converts from "diff3" to whatever values we decide in that new field. We
> would need a new parse_config_conflict_style() function.
> And that function will be only used by `git checkout` and nothing else.
> So I don't think there's much value in it.

It would allow us to add a --conflict option to all the mergey commands 
in the future and would be much easier to reason about than the approach 
of juggling where we call git_xmerge_config(). This patch requires us to 
audit all the code paths that end up in merge_recursive_config() to make 
sure they now call git_xmerge_config() themselves. You don't seem to 
have done that as you don't know if am/apply are affected or not.


Best Wishes

Phillip

> That problem whoever, is orthogonal to this series.
> 
>> Does this change affect 'am/apply -3'? - Do they still read the config
>> setting properly?
> 
> Good question. I'll have to add more tests to make sure that works
> properly.
> 
> Cheers.
> 
