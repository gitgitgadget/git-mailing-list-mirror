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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BB9C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 09:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FAC860F9D
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 09:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhG1Jqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 05:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbhG1Jqo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 05:46:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F28C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 02:46:42 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso3411545wms.1
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=apMJcPfzNr/D1K3pSNdcHjOKRvpOJ2bJdJaYRsHmSsI=;
        b=K1xqmZs5nmWPJrXxSp/rElXb5PDCV4Rpo76JI19/NqkkyjkkfaG22qe6VqKoqpSQ9M
         Cx6To6fRsSrDT7wsIzbDLJAW6ycMpXGgvLVdaXw50rczMl8okbUZSx5dpP85soWODb82
         zrvCKB/ukMsrOwxcvs3HFHqaV+Y3aoU9BtEsuou3XCqoJHB/c6CWZFugMZNeuQXi2SXP
         EBt++omCYHwoQMBUF+hBHAMSJhin0lRvYBejsFL/64QbR9Di+DW9wP8jNElV0l93wr5i
         TlWaV3CtRHPpJc80j5AsOjpp+fZfHY4QjLXwacetmXA121CNssdVmEZVbZPdGVOa/b6E
         DnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=apMJcPfzNr/D1K3pSNdcHjOKRvpOJ2bJdJaYRsHmSsI=;
        b=cQbV2H+SoUIwaQd2unYBG6Vxwn6N8iUOGeDOoPIu+fs7HevrxxRWVpbLN94+p8kGCd
         FvU/P/6nD1mJyE3NRqtJNShHrUm6slh6Y2HfEAr6EMmy4LlUI0d1btit9PMP6RerNgtl
         i/R/EImpLf00LCx3SB6yd2WkeLzW+2zlFj4JytHLuK/34HGmtueLFrnSNeOrYFIKsbKt
         StsI3zzE15VdfAb7TXy1nLkGnPDYam7W+BsqaNxMSAJ+W07ObhBEVX0iWPAaNYCL/ACO
         zQH08thcsf3vAaSivItTLvd7aleeKngCSOimz5jnWAAb1GivmDu3nrl48Ob7eBqyfZC9
         tnyQ==
X-Gm-Message-State: AOAM531GGMjl9BkoO2KW8WC6376tqEdqQ4KPSurqo/AK19YXwgGKR97X
        BM4230XX5YQ2d0Q5BjlFZcc=
X-Google-Smtp-Source: ABdhPJxhuZkd3gPB/yT8dnY8HgtvBYEJT/bb4Gow4f3xikT91oS9yKhwm7igzLpddB/AaLZCGpJLQg==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr18895927wmi.82.1627465601177;
        Wed, 28 Jul 2021 02:46:41 -0700 (PDT)
Received: from [192.168.1.14] (host-2-98-21-22.as13285.net. [2.98.21.22])
        by smtp.gmail.com with ESMTPSA id 140sm5972580wmb.43.2021.07.28.02.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 02:46:40 -0700 (PDT)
Subject: Re: [PATCH v2] [GSOC] cherry-pick: fix bug when used with
 GIT_CHERRY_PICK_HELP
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
 <pull.1001.v2.git.1627135281887.gitgitgadget@gmail.com>
 <a8b260be-dae5-e717-d4cb-3ee123f93620@gmail.com>
 <CAOLTT8T9Fu4-r5-2PhNmopW751TBN1LRrwBU70HuKZ48JD1X5Q@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8893cce8-61a7-3469-0c2e-8f6fe9f1b295@gmail.com>
Date:   Wed, 28 Jul 2021 10:46:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAOLTT8T9Fu4-r5-2PhNmopW751TBN1LRrwBU70HuKZ48JD1X5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing

On 28/07/2021 08:39, ZheNing Hu wrote:
> Phillip Wood <phillip.wood123@gmail.com> 于2021年7月28日周三 上午3:43写道：
>>
>>> diff --git a/builtin/revert.c b/builtin/revert.c
>>> index 237f2f18d4c..ec0abe7db73 100644
>>> --- a/builtin/revert.c
>>> +++ b/builtin/revert.c
>>> @@ -245,6 +245,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>>>
>>>        opts.action = REPLAY_PICK;
>>>        sequencer_init_config(&opts);
>>> +     unsetenv("GIT_CHERRY_PICK_HELP");
>>
>> This will break git-rebase--preserve-merges.sh which uses
>> GIT_CHERRY_PICK_HELP to set the help and ensure CHERRY_PICK_HEAD is
>> removed when picking commits. I'm a bit confused as to what the problem
> 
> Yeah, I thought it would call some rebase-related code before, I
> didn’t expect it to
> call cherry-pick. On the other hand, I passed all tests, so I ignore
> it, there should be
> a test for it.
> 
>> is - how is 'git cherry-pick' being run with GIT_CHERRY_PICK_HELP set in
>> the environment outside of a rebase (your explanation in [1] does not
>> mention how GIT_CHERRY_PICK_HELP is set)? As far as I can see 'git
>> rebase -i' does not set it so the only case I can think of is
>> cherry-picking from an exec command  while running 'git rebase -p'
>>
> 
> Ah, because I want to find a way to suppress its advice messages about
> "git commit",
> and I don’t think anyone else is using this "feature".

I'd welcome a patch to improve the advice. I suspect the current advice 
predates the introduction of the '--continue' flag for cherry-pick. I 
think that would be a better route forward as it would benefit all 
users. Setting GIT_CHERRY_PICK_HELP is undocumented and has always 
removed CHERRY_PICK_HEAD since CHERRY_PICK_HEAD was introduced in commit
7e5c0cbf (Introduce CHERRY_PICK_HEAD, 2011-02-19).

Best Wishes

Phillip


>> Best Wishes
>>
>> Phillip
>>
>> [1]
>> https://lore.kernel.org/git/CAOLTT8Ty47fyY7T3d68CYPKh9k+HAHsnCLJ=F0KaLm+0gp3+EQ@mail.gmail.com/
>>
> 
> Thanks.
> --
> ZheNing Hu
> 
