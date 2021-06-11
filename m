Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9DAC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 09:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99BA7613D0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 09:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhFKJV7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 05:21:59 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:40614 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhFKJVz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 05:21:55 -0400
Received: by mail-wr1-f49.google.com with SMTP id y7so5256795wrh.7
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ROjavx8nmShQfLsIdP3ndnA5YLoiM9/AfPc4v89ytDY=;
        b=bczlzPleRgNc36Cp6/E+4jJNL3jjbaUJUtX+X8N2OcSFwogMRUt4Xk+2XQV6l2bsmE
         T9Bp161moZxW6dn5u2Go5kabR/TRbOFofqVHTVx+/6kuQtFh/6Yfb7ACZfI60yrdh3mH
         d7S58AYfibkoXMqiVHptg1Jr7IOzfJcG2oSPMS9vEO7Eenu75UoP6Nn0+xP+JThkxqGp
         1R/WDGxLAGgZmpECXSTQkSKEzx5FuBno6W6ljaM5zSmbCVy898gBLEqi/V+p1b+E297m
         a6ZuMJPwCLZ0uhBa/uTaKEDIAK+Y9KpJgEO1B4hRrOhc2aN1fulv0OaUwn8eXJ5IB57n
         bB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ROjavx8nmShQfLsIdP3ndnA5YLoiM9/AfPc4v89ytDY=;
        b=gdwEMnBxw/PDB9a4UonaHOVmrQQNEzd+ZIu11tfNi3d+NNg4D79VW48a80YKL43HLw
         Dy2pyennfZIleKLIuVCB/GVOmyDT1VnT3r9TLsuPIRLTVRtvKxJOLMw6/8Dr78uLN3NF
         wOguunosPpkagPqAlfYtGo0Jd+D+oSKq0f6vFVXfuqxJU02QbKrFNd0dJ94UHBsFVqU0
         9bEe/yHf4or93WUQ/WL6v8P24ldQm/qpdNhu5nFQ5PEtShuW98BjNzG4lBucxHjxbWr9
         RQA5/SKQ9hEX0qA333dt9dEgqj3u37oyZ6oWLTBynIm2OMSL9xI8hXNK+hIrv8BVaVVy
         iouA==
X-Gm-Message-State: AOAM530KnvzbWNyuTX8uX6cRgeTmfHMNxucojjJ4l520bXBvYxXsdZx4
        TipRQrwSjnr3qb8RJ2uAARo=
X-Google-Smtp-Source: ABdhPJwVFLyV2n5dpt4rHZggYzgP9pThr2FFxHNCMzrvX+nqkHl0YHKe2AM2i12bI3hmruADAdkIDQ==
X-Received: by 2002:adf:fc0e:: with SMTP id i14mr2888052wrr.71.1623403123325;
        Fri, 11 Jun 2021 02:18:43 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id v8sm6894556wrc.29.2021.06.11.02.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 02:18:42 -0700 (PDT)
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
 <49da6d73-c49f-d75e-0eb2-b12bd529fcfa@gmail.com>
 <60c23e8b7f672_b25b1208d2@natae.notmuch>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5164b67c-d701-077f-7743-aea4ae13779d@gmail.com>
Date:   Fri, 11 Jun 2021 10:18:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60c23e8b7f672_b25b1208d2@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06/2021 17:32, Felipe Contreras wrote:
> Phillip Wood wrote:
>> On 10/06/2021 15:11, Felipe Contreras wrote:
>>> Phillip Wood wrote:
>>>> On 09/06/2021 20:28, Felipe Contreras wrote:
>>>>> Currently both merge.conflictStyle and `git commit --merge
>>>>> --conflict=diff3` don't work together, since the former wrongly
>>>>> overrides the later.
>>>>>
>>>>> The way merge configurations are handled is not correct.
>>>>> It should be possible to do git_config(merge_recursive_config, ...) just
>>>>> like we can with git_diff_basic_config and others.
>>>>
>>>> It would be helpful to explain what the problem with
>>>> merge_recursive_config() actually is rather than just saying "it should
>>>> be possible ..."
>>>
>>> The problem is that you can't do this:
>>>
>>>     git_config(merge_recursive_config, NULL);
>>>
>>> As it was explained.
>>
>> You do not explain why you cannot do that
> 
>    % git grep merge_recursive_config
>    static void merge_recursive_config(struct merge_options *opt)
> 
> For starters it's a static function.
> 
> Second, clearly the type of functions git_config() receives are not
> `void (*)(struct merge_options *)`.
> 
> I mean, I do see value in explaning as much detail as needed in the
> commit message, but it shouldn't be a lesson on git's codebase:
> git_config() is a standard thing, and it's even mentioned in the user
> manual.

I'm not asking for a lesson on git's config system, I'm asking you to 
add a sentence to the commit message to explain what the problem is 
rather than just saying "you should be able to do this but you can't".

> https://git-scm.com/docs/user-manual#birdview-on-the-source-code
> 
>>> That is the problem. I don't know how that's not clear.
>>>
>>>>> Therefore builtins like `git merge` can't call this function at the
>>>>> right time.
>>>>    >
>>>>> We shuffle the functions a little bit so at least merge_recursive_config
>>>>> doesn't call git_xmerge_config directly and thus override previous
>>>>> configurations.
>>>>
>>>> Rather than papering of the problem, how difficult would it be to add a
>>>> field to ll_merge_options and pass the conflict style with that rather
>>>> than fiddling with the order that we set a global variable.
>>>
>>> Probably not that difficult, but then we also need a parser that
>>> converts from "diff3" to whatever values we decide in that new field. We
>>> would need a new parse_config_conflict_style() function.
>>> And that function will be only used by `git checkout` and nothing else.
>>> So I don't think there's much value in it.
>>
>> It would allow us to add a --conflict option to all the mergey commands
>> in the future and would be much easier to reason about than the approach
>> of juggling where we call git_xmerge_config().
> 
> Feel free to write a patch for that.
> 
>> This patch requires us to audit all the code paths that end up in
>> merge_recursive_config() to make sure they now call
>> git_xmerge_config() themselves. You don't seem to have done that as
>> you don't know if am/apply are affected or not.
> 
> That is a separate issue, that I already mentioned...

I know you are going to add some tests but the point is that when making 
a change like this you need to actively audit all the callers of 
init_merge_options() and ensure that they are now calling 
git_config(git_xmerge_config) and base you tests on what you find while 
doing that. Have you run 'grep init_merge_options()' to see where it is 
being called?

Best Wishes

Phillip

>>> That problem whoever, is orthogonal to this series.
>>>
>>>> Does this change affect 'am/apply -3'? - Do they still read the config
>>>> setting properly?
>>>
>>> Good question. I'll have to add more tests to make sure that works
>>> properly.
> 
> here.
> 
