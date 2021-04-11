Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9EBC433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 19:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579546108B
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 19:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhDKTdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 15:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbhDKTdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 15:33:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D339C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 12:33:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so892412pjb.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 12:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hFB0YkKFO+i0H7A90zNCuNQ2Pg/aKsmg9mH2sQ14uuY=;
        b=keukaYNsQbNDaeqUEKgMxVy9H1A0W7+XvLl+GYLQ41PobYJgbFzLqoCw2f4IDQtes6
         e7exvde/MPeTosmUaDdllBagkf6qRY+HDJSJ/EJiYJzGwTdrE9mIn1JkjBZzoyX66SkE
         PXAjVjBIwEHUnRhyQtnu+nnC9LaWFFeD9z0zb4AD9MVy/xZh9n22O7Kuehm8If7ja4Rn
         kfyg1Rx4pHIS+ID/EnqF5k8GM/VPHiYfZyzawz8NJ28ewDcO3Kry0JA6pbGkbJUB59lq
         TdxBCSC88+/wObliVdi3Vx+lNGUPepX4y8d2119scV1dcp/KheOqd1108ujaq4714jcG
         b80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hFB0YkKFO+i0H7A90zNCuNQ2Pg/aKsmg9mH2sQ14uuY=;
        b=kuLWYbS/RIaZgCz2enDcwsfDjP8YNIvGCLKCFPg3MIXT8r2sYLNWXCcfmNlrpdS3ot
         BrRxGPeOMv+wNxtjF4+BchmhSvwfOvOt/k+lmwOPq2g3A8pRb74hKTtFxk/Hd3Ak3JAe
         7Y2qGNj2L4tAZl4RM/7gSwEuZZPTnwxQixIwiOazvptpJJRK1ntI6Eo+aGaHTzE0pk/V
         wVT4PPKN87NWJtPPFdBfDPgrTBufz3Wt9FSYqD31OMW0thfKD7vn9oxsuNPBK8kn9nmH
         zMezXXnbOJt/aSpGhvFV87+UFgLi7IEA7qSTe50HxxpfstoH5+3fEIk6WDJVMv4cdSAj
         DRIQ==
X-Gm-Message-State: AOAM532TvXet8XBK+PB8xQ9xZlD3sycReYKMv4uXON2NyancyTkCgDYB
        Ah4ISkqHyqduzDYD4x804JY=
X-Google-Smtp-Source: ABdhPJxS9BLduqxEeRt//JXEywIT0Wyx8UgJRGJDsgHvc34BKGyN9ZZpmJFxiQsIxM/lM1ks4KdFGw==
X-Received: by 2002:a17:90a:7e8b:: with SMTP id j11mr25101911pjl.11.1618169579571;
        Sun, 11 Apr 2021 12:32:59 -0700 (PDT)
Received: from [192.168.208.38] ([49.205.83.224])
        by smtp.gmail.com with ESMTPSA id 14sm7700894pfl.1.2021.04.11.12.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Apr 2021 12:32:59 -0700 (PDT)
Subject: Re: [GSoC][Draft Proposal v2] Finish converting git submodule to
 builtin
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
References: <E6E88000-9C18-4035-9A14-8B406617351A@gmail.com>
 <F3446051-620F-4C7B-A306-5C36922A976C@gmail.com>
 <CAP8UFD2hhtpnz+WE2J9iLbzfRJ2k5EOtUMRW=QcH9xe1U6y69g@mail.gmail.com>
 <F6B9AC67-EB44-4FD9-A7A0-A6494BAE3BC7@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <f721d35c-72fe-fe18-edfc-8745966e41af@gmail.com>
Date:   Mon, 12 Apr 2021 01:02:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <F6B9AC67-EB44-4FD9-A7A0-A6494BAE3BC7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

On 11/04/21 3:10 pm, Atharva Raykar wrote:
> 

>> On 10-Apr-2021, at 18:29, Christian Couder <christian.couder@gmail.com> wrote:
>>
>> On Thu, Apr 8, 2021 at 12:19 PM Atharva Raykar <raykar.ath@gmail.com> wrote:
>>>
>>> Here's my updated draft. Changes since v1:
>>>
>>> - Elaborated more on example porting strategy, stating how the patches
>>>    could be broken up.
>>> - Made language at the end of section 6 less ambiguous.
>>> - Updated status of microproject.
>>> - s/git/Git in several places.
>>
>> Thanks for this summary of the changes since the previous version!
>>

Yeah. Summaries are really helpful :)

[ ... ]

>>> This
>>>       would perform the work being done by the shell script past the flags
>>>       being parsed and make the necessary call to `update_clone()', which
>>>       returns information about the cloned modules.
>>
>> How does it return information?
>>
>>> For each cloned module,
>>>       it will find out the update mode through `module_update_mode()', and
>>>       run the appropriate operation according to that mode (like a rebase,
>>>       if that was the update mode).
>>>
>>>       One possible way this work can be broken up into multiple patches, is
>>>       by moving over the shell code into C in a bottom-up manner.
>>>       For example: The shell part which retrieves the latest revision in the
>>>       remote (if --remote is specified) can be wrapped into a command of
>>>       `submodule--helper.c'.
>>
>> Could you give an example of how the command would be named, what
>> arguments it would take and how it could be used?
>>
>>> Then we can move the part where we run the
>>>       update method (ie the `case' on line 611 onwards) into a C function.
>>
>> Do you mean the code that does something like:
>>
>>                        case "$update_module" in
>>                        checkout)
>>                                ...
>>                        rebase)
>>                                ...
>>                        merge)
>>                                ...
>>                        !*)
>>                                ...
>>                        *)
>>                                ...
>>                        esac
>>
>>                        if (sanitize_submodule_env; cd "$sm_path" &&
>> $command "$sha1")
>>                        then
>>                                say "$say_msg"
>>                        elif test -n "$must_die_on_failure"
>>                        then
>>                                die_with_status 2 "$die_msg"
>>                        else
>>                                err="${err};$die_msg"
>>                                continue
>>                        fi
>>
>> ?
>>
>> Could you also give an example of how the command would be named, what
>> arguments it would take and how it could be used?
> 
> I could add more detail about the exact arguments each converted part
> would take, but I feel a little hesitant because I will most likely
> change my mind on a lot of those kind of lower-level decisions as I
> understand the codebase better. The point I was trying to convey is
> that the high-level workflow I would follow while converting would look
> like this:
> 
> 1. Identify parts in git-submodule.sh that have cohesive functionality
> 2. Rewrite that functionality in C, which can be invoked from
>      `git submodule--helper <function name> <args>`
> 3. Remove the shell code and replace it with the above invocation
> 4. Once the shell code is reduced to only a bunch of calls to
>      submodule--helper, wrap all of that into one call that looks like
>      `git submodule--helper update <flags>` that encapsulates all the
>      functionality done by the other helper function calls.
> 
> (In other words: I will cluster the functionality in a bottom-up way.
> Maybe I should mention the above four points in my proposal?)
> 

That sounds like a good idea which wouldn't result in one huge patch and
thus avoids reviewer fatigue.

> The example I gave for how to handle the presence of the remote flag
> and the function that performs the module updation method (ie, the `case`
> on line 611) was just to illustrate the above workflow, rather than say
> that this is how I will exactly do it.
> 
> I also would like to know what level of granularity is ideal for the
> proposal. For now I have tried to keep it at "whatever I will surely
> follow through when I work on the project", which at the moment is the
> covered by the four points I mentioned above.
> 
> If I go too much into detail about the functions and arguments
> of every helper in my example, I will feel compelled to do the same for
> the `git submodule add` example. I also will have to reason more carefully
> because I do not want to end up in a situation where I do not actually
> stick to my proposal all that much, because I realise in my investigation
> phase that there is a different, much better way.
> 
> Do let me know what is preferred.
> 

It makes sense that you don't want to go into too much detail in your
proposal. I think Christian wasn't expecting it either. As far as I
understand, he was just trying to make your proposal clear to the person
who reads it. Just mentioning something like,

   This would perform the work being done by the shell script past the
   flags being parsed and make the necessary call to `update_clone()',
   which returns information about the cloned modules.

is not clear as it doesn't say how you're "thinking" the function would
return information. Mention this would be helpful for the reader to know
what your expectations are and if they need any correction. So, it is
better to mention such related information to make your proposal
complete. The high-level flow looks good to me.

Also, I believe Christian would correct me in case I got anything
wrong :)

-- 
Sivaraam
