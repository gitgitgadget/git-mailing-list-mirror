Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E676BC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 23:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiADXUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 18:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbiADXUa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 18:20:30 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604ABC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 15:20:30 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id q14so35733791qtx.10
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 15:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x4nXwV84trXCCrKHN7ftk7iIgi8CXGZl/VH2hWmkFrs=;
        b=PZnMDi1G8gH1Gcz0mLWHetfuB5YPA6ClfsHJ9Lgr3qgMW/2mAM5n7IgLu66pwYbQSq
         sYVMaId2qk6xerRrHFR+71VWVoM9DHlm0udD5/HHqgAMQzkBOzJcQQLYmL2BMeVZ5RIR
         Hy53xjcL69rQA8Sy9Z+8NydKo7BC+0KYU8uRglGqEQAlYJScirwY7RFu38IAl5XSwSma
         wNEXlvLlBq/FucERkhr/aTkYJ//WD4hAyK4z6bFOX5LsBfSSAGVjkHpbVnA15PeW6Eyi
         nt2/VS/HCkwVzC2GkazmKtTjfDnSXR956kEHEafaC42BHnG9QKze6TrlVynKzK0GyfKB
         ZIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x4nXwV84trXCCrKHN7ftk7iIgi8CXGZl/VH2hWmkFrs=;
        b=iqLmL50PpKLAXfxNT+2wHM9w5M8SDdunGi3zrarZbP33ybBFx5eIWTaEO9g4EyCc9f
         i6yKrjdu79lm5Yo+p6c2Wi60SB4M2MLGin/Z99rNuc/g3cRXI5ucPOwxsLDCF74+tfWu
         PQzhw+jM4P7m/ah6C08PkTed7Plnav5Cc5R7ERjR7itltzn+1dUqT5/MykKNzxMFmcBJ
         JFFdXB35qQH5Djbi6r57coBBlMr1VK1EBF6Us3rDDV9BzFrZ9GoTVo5OVob7rAs2U9+a
         uoAK/qiIr4E6rsdUO4bFn5vRhK9zIxvDrNjr9dFM6uRmf802gUoImZl4KZQDk+yYpb2J
         kPlg==
X-Gm-Message-State: AOAM533Nb06vXkCqhCiRJgZ8YXpXGymU7j6IVC/q/GWTntI8uOE645VJ
        ari6sDgfu9vDaI1Zf+ROK8TeOkqYGTI=
X-Google-Smtp-Source: ABdhPJwIRPxMd4oDfA8JL00L2Sd0+H9+cWJV/INbf7SmhV+5+KhzxDcs7Sqr3IaOOokbsUgDExfx4Q==
X-Received: by 2002:ac8:57ce:: with SMTP id w14mr47153418qta.252.1641338429212;
        Tue, 04 Jan 2022 15:20:29 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id n19sm34191793qta.78.2022.01.04.15.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 15:20:28 -0800 (PST)
Subject: Re: [BUG] git pull --rebase ignores rebase.autostash config when
 fast-forwarding
To:     John Cai <johncai86@gmail.com>
Cc:     git@vger.kernel.org
References: <9749fa2c-b08d-c08b-ce43-041d13852d02@web.de>
 <1240d0cd-230d-8a80-2250-37336b834834@iee.email>
 <cb8d6e8a-aaca-c2eb-6cc8-5c4ad33adfdb@gmail.com>
 <507d156f-9135-229e-423d-a8ab68bfa9b7@gmail.com>
 <BB019E6A-90ED-4D5A-A756-FA8700897DE7@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <3d56ab46-bb65-59d0-8b4d-c0e5807814be@gmail.com>
Date:   Tue, 4 Jan 2022 18:20:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <BB019E6A-90ED-4D5A-A756-FA8700897DE7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John,

Le 2022-01-04 à 13:49, John Cai a écrit :
> 
>> On Jan 4, 2022, at 1:29 PM, Philippe Blain <levraiphilippeblain@gmail.com <mailto:levraiphilippeblain@gmail.com>> wrote:
>>
>> Hi again,
>>
>> Le 2022-01-04 à 13:03, Philippe Blain a écrit :
>>> Hi Tilman,
>>> Le 2022-01-04 à 07:59, Philip Oakley a écrit :
>>>> On 03/01/2022 18:08, Tilman Vogel wrote:
>>>>> Hi git-people,
>>>>>
>>>>> I ran into strange behavior when having rebase.autostash enabled and
>>>>> doing a git pull --rebase:
>>>>>
>>>>>> git config rebase.autostash true
>>>>>> git pull --rebase
>>>>> Updating cd9ff8a..f3c9840
>>>>> error: Your local changes to the following files would be overwritten by
>>>>> merge:
>>>>>          content
>>>>> Please commit your changes or stash them before you merge.
>>>>> Aborting
>>>>>
>>>>> Confusingly, this fixes the issue:
>>>>>
>>>>>> git config merge.autostash true
>>>>>> git pull --rebase
>>>>> Updating cd9ff8a..f3c9840
>>>>> Created autostash: c615fda
>>>>> Fast-forward
>>>>>   content | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>> Applied autostash.
>>>>>
>>>>> Leaving me wonder why merge config options fix rebase behavior.
>>>>>
>>>>> So, in order to make it easier to check the problem, I added some
>>>>> test-cases to the git test-suite. Please see the attached patch.
>>> Thanks, this really makes it easier to bisect the issue.
>>>>>
>>>>> Or here:
>>>>> https://github.com/tvogel/git/commit/bc941f9357518a34cfa11788dfb8e7fa7f711705 <https://github.com/tvogel/git/commit/bc941f9357518a34cfa11788dfb8e7fa7f711705>
>>>>>
>>>>> I did not try to find the root-cause as I am not experienced with the
>>>>> code-base but if there are questions, let me know.
>>>>
>>>> Which version are you running?
>>>>
>>> That's a good info to include indeed. I'm guessing you are using v2.34.1 as that's the version
>>> indicated at the bottom of your attached patch. I can replicate the behaviour on my side on 2.34.1.
>>> I did not bisect manually but I'm pretty sure it's a regression caused by 340062243a (pull: cleanup autostash
>>> check, 2021-06-17) (author CC'ed). I checked that the parent of that commit passes all 4 of your added tests, provided
>>> this is squashed in:
>>> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
>>> index 4046a74cad..5ad19b1028 100755
>>> --- a/t/t5521-pull-options.sh
>>> +++ b/t/t5521-pull-options.sh
>>> @@ -260,7 +260,6 @@ test_expect_success 'git pull --rebase --autostash succeeds on ff' '
>>>      test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
>>>      echo "dirty" >>dst/file &&
>>>      git -C dst pull --rebase --autostash >actual 2>&1 &&
>>> -    grep -q "Fast-forward" actual &&
>>>      grep -q "Applied autostash." actual
>>>  '
>>> @@ -273,7 +272,6 @@ test_expect_success 'git pull --rebase with rebase.autostash succeeds on ff' '
>>>      echo "dirty" >>dst/file &&
>>>      test_config -C dst rebase.autostash true &&
>>>      git -C dst pull --rebase  >actual 2>&1 &&
>>> -    grep -q "Fast-forward" actual &&
>>>      grep -q "Applied autostash." actual
>>>  '
>>> After that commit, in case of fast-forward, 'git pull --rebase --autostash' delegates the fast-forward
>>> operation to 'git merge' under the hood, which was not the case before. The '--autostash' flag seems
>>> to be forwarded correctly to that 'git merge' invocation, but the config 'rebase.autostash' seems to not
>>> be passed along.
>>> I did not yet look into why in the code itself
>>
>> After looking at it a bit, this seems to fix the bug:
>>
>> diff --git a/builtin/pull.c b/builtin/pull.c
>> index 1cfaf9f343..0b206bf1d5 100644
>> --- a/builtin/pull.c
>> +++ b/builtin/pull.c
>> @@ -87,6 +87,7 @@ static char *opt_verify_signatures;
>> static char *opt_verify;
>> static int opt_autostash = -1;
>> static int config_autostash;
>> +static int autostash = -1;
>> static int check_trust_level = 1;
>> static struct strvec opt_strategies = STRVEC_INIT;
>> static struct strvec opt_strategy_opts = STRVEC_INIT;
>> @@ -687,9 +688,9 @@ static int run_merge(void)
>> strvec_pushv(&args, opt_strategy_opts.v);
>> if (opt_gpg_sign)
>> strvec_push(&args, opt_gpg_sign);
>> -if (opt_autostash == 0)
>> +if (autostash == 0)
>> strvec_push(&args, "--no-autostash");
>> -else if (opt_autostash == 1)
>> +else if (autostash == 1)
>> strvec_push(&args, "--autostash");
>> if (opt_allow_unrelated_histories > 0)
>> strvec_push(&args, "--allow-unrelated-histories");
>> @@ -1036,7 +1037,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>> oidclr(&orig_head);
>> if (opt_rebase) {
>> -int autostash = config_autostash;
>> +autostash = config_autostash;
>> if (opt_autostash != -1)
>> autostash = opt_autostash;

It seems your email client is messing up whitespace (I'm guessing you might be
using the Gmail web UI, it's known to have this problem), you should try to
find a email client that does not have this behaviour :)

>>
>>
>> If nobody beats me to it (if that's the case, be my guest !), I'll try to submit a proper patch later
>> today or this week.
> 
> (Resending due to my previous message containing HTML and being rejected by the mail server)

It seems this here email did not either reach the mailing list archive.

> 
> Hi Philippe,
> 
> Looks like we were working on this in parallel :) I have a PR I was about to submit as a patch through GGG: github.com/git/git/pull/1179 <http://github.com/git/git/pull/1179>
> 
> My fix is very similar to yours. I can add you ad a co-author if you’d like?
> 

Thanks for asking. I saw you sent your patch at [1] with a "Co-authored-by" trailer.
I would have prefered that you wait for my approbation before adding that "Co-authored-by",
since the code you are adding is different than what I posted above.

I'll comment some more on your patch there.

Cheers,

Philippe.

[1] https://lore.kernel.org/git/20220104214522.10692-1-johncai86@gmail.com/T/#t
