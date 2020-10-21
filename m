Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96446C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 11:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2187D2177B
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 11:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fbh9qoG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441991AbgJUL2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 07:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439487AbgJUL2m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 07:28:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DACC0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 04:28:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y12so2655753wrp.6
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 04:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z1v3MMQZ7l4j8cIp0ZCMbg+U35ON8tGSAhsDx+pluTY=;
        b=Fbh9qoG4ZE78GRlEFPqBj4xOXCD7UunSdHb+uQrHKrwGSrQVSvW0pLMFqj8VtcNqOp
         PCuGeace7w11u4xTHEYKfeLYPsAKziUiQE2dj39M1Lpbm3h0Y6V5wZhcHqkF79YwLRcq
         q3U3PVjXyXTeBjQcwEt9PA1HrjCppH72iLMutXnhj77WRJbbAkXhK3FHP2Vuay91hVVk
         u/iQycGUtqkq9SqztsRp9vPQ9vid2vKbpiL+Gwxn/OgwTox4KHwLcmdH04KN1C9n3XXB
         dha8TmCHjIH8d/CZ4vWrPjX5Iyr2dr/0pUYofHkqJA/2tdiWaUlWSHbcivoM4diozkvj
         27JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Z1v3MMQZ7l4j8cIp0ZCMbg+U35ON8tGSAhsDx+pluTY=;
        b=SBofYN5qsTB6swiQ7etj0zUcEaAUTrEzB3//sSyEIQ+X5SdrofxxXh1ZxlxsCDm6yi
         G2/jKy63yLq1AVVjDzrTEuqZuCtCgBrvd3FpxLcGRrrQ8xEesScQjB54o1PNLmee0RQW
         Kcdwd9TYzoOr0BHMeJyj+OuX/SSdtXjAzEQsNu9vt3yZztxp4MMy1T8YZJtlGoZ9T1db
         VcbmQNHo6QTSto9kwxgN9+g1x1WdQRFIAMr6MUqU2dFNKW00C5xI8TjVracU57PZ/aAM
         iLP2qG2b72QPJgPwKMcDvdvPx3/gWAN/YaSuCSU3fQWSgY1PsW7CvlaCGBDtHLeeXi3Z
         wRfQ==
X-Gm-Message-State: AOAM5320KxORxok7OtS/ujD/P7CmV4Uvi+ctcGPzAE6hl7WiewUqXhaq
        menLMtj53HdixG8QQpbq8LDHPteSoqo=
X-Google-Smtp-Source: ABdhPJw9arEG++tK51fjUbSHBdTA+0KmmOXzAdpcnV9VM9M3WtpFskqGlBrXdfiKluK4q3KC/923BA==
X-Received: by 2002:adf:f247:: with SMTP id b7mr4508505wrp.56.1603279718968;
        Wed, 21 Oct 2020 04:28:38 -0700 (PDT)
Received: from [192.168.1.240] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.gmail.com with ESMTPSA id 133sm7145501wmb.2.2020.10.21.04.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 04:28:38 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [OUTREACHY][PATCH] diff: do not show submodule with untracked
 files as "-dirty"
To:     Sangeeta NB <sangunb09@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
 <7af89857-5495-d008-3d8f-09b5fed32775@gmail.com>
 <CAHjREB7Xhga3da9vGyXxJo6MCi9P9CyezzO66Xh2X2+rDFkQjw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d9376318-b8dd-3e30-8aa9-255eefe727c4@gmail.com>
Date:   Wed, 21 Oct 2020 12:28:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHjREB7Xhga3da9vGyXxJo6MCi9P9CyezzO66Xh2X2+rDFkQjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sangeeta

On 20/10/2020 19:10, Sangeeta NB wrote:
> Hey Phillip,
> 
>> I think we require your full name on the From line to match the
>> Signed-off-by line below (c.f.
>> https://lore.kernel.org/git/xmqqpn5dd5dv.fsf@gitster.c.googlers.com)
> 
>> That is a good summary of the issue that this change addresses, we
>> normally wrap lines at 72 characters though.
> 
> This was sent by gitgitgadget so I am unable to find how I can
> customize it. Can you help me with this? Or else I have set the Travis
> so should I send another patch using send-email?

When you create the commit message you need to get your editor to wrap 
the lines with line breaks, how you do this depends on your editor - for 
emacs you can use fill-paragraph, in vim 'gq' you should be able to 
google it for your editor.

It would be a good idea to add [Outreachy] to the beginning of the 
commit subject line as well so people can easily find outreachy related 
patches on the list (anything inside [] is removed by `git am` when the 
patch is applied)

>> This unconditionally overrides diff.ignoreSubmodules, grepping seems to
>> show that we don't have any tests that test a config value of "none".
>> There are a few that check "dirty" which we should look at to consider
>> if they still add value now we've changed the default.
> 
> Yes, sorry, noticed it now. I have now added a flag in diff_flags.
> Also, do I have to add tests that check whether diff.ignoreSubmodules
> is not being overwritten?

I think adding a test that checks diff.ignoreSubmodules=none is 
respected would be a good idea

> 
>>        if (diff_no_prefix) {
>>                options->a_prefix = options->b_prefix = "";
>> diff --git a/submodule.c b/submodule.c
>> index b3bb59f066..762298c010 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1678,6 +1678,8 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>>        strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
>>        if (ignore_untracked)
>>                strvec_push(&cp.args, "-uno");
>> +     else
>> +        strvec_push (&cp.args, "--ignore-submodules=none");
>>
>> We need to do this as a consequence of changing the default for
>> '--ignore-submodules`, we should think what the consequences are for
>> other users of `git status` and whether we need to do something similar
>> there if diff.ignoreSubmodules is not set.
>>
> 
> Oh okay. I understood what you said. But I couldn't figure out how to
> do that.

I'm not sure if we need to do this or not, I was hoping to get some 
input from the list

> As all the tests of status were passing so I don't think
> there might be any issue with this.

Possibly, though I think it is more likely that we're not testing 
anything that gets broken by this change.


Best Wishes

Phillip

>> I think we want to keep testing that we get the correct output when
>> --ignore-submodules=none as well as maybe adding a couple of new tests
>> that check the default in this file, rather than changing the expected
>> output.
>>
> 
> Thanks, I have added more tests.
> 
> Thanks and Regards,
> Sangeeta
> 
