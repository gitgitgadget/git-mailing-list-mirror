Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E5DC433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 13:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhLNNLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 08:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbhLNNLv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 08:11:51 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91052C061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 05:11:51 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z7so1686685edc.11
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 05:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lmxDHvGP7UBxtw7H/u6njLfqak2Lc04Qvs73lYHXKAM=;
        b=nZfdbJ4IO5RenRyykI4d7lKXMMKi6YXsoLcuVxFc3idnztYz+0BFqapwHCuc2F6CwQ
         mRrLveT9ons2gon52INrxYFhtABYmpmQX1VrKpC7Hi/ayn8u7wB77deohcSeFy3b6u2Z
         BqyuWNSdFshpaD+qLAWFfm1bXFXMfybO3dI/6upobr4oY+nekjyvQG5NhKG/vHatmWLb
         3TEjprwUGZODpCTkTPjRqi/4gnsRV2oGb7enNKm7tYmq9tXgmf6ECFqfLKgITOuofi99
         8MeSHIAQ62OV6Cs598d4+SBv3Ocics7hXykFPXstg1JdCXEvamUaVcydtc2g4TykFskr
         ZkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lmxDHvGP7UBxtw7H/u6njLfqak2Lc04Qvs73lYHXKAM=;
        b=DzsuICeXDQg0iAS8+P57Ub/orzPdo5opRjRHYN1PwI3oMwekPKl+2FMGCitZ1SSyo5
         WpO/z65j6UvUWuFw3ErvMpFkLtgRQkpYr+R8QhwJ5FwZBmRqr5hpjk4dX65yv5uL+H/c
         Ug+Wbk/PxFyJdIwUdOJAXiWB/vsAn8wtGZxQ1To6L9SEziWy77bbxEwsSgYLvapVFDln
         +PEXb7smtodEkKnawI1NAbHkT+RswVZ6XbvwKJNH/Fgjebt3ky2C1lXUsIIMiDjTuQA7
         5ed/3zcPvmaqVBR1KI4rqD/XFscFuPWSRo4owJ3ROiiLYzscpvq8N6L8PvOd8bby7KWN
         VIEA==
X-Gm-Message-State: AOAM5302l7b85zPWBHECueJJuzD6m8UHlJd+u5yD3MklmtOEVoZAwXP0
        f8RkML4xy0TZqRXCg8jOqNdIgbVPU5WB+TMZ
X-Google-Smtp-Source: ABdhPJx5bbExGBaVlOENIyh24+MLrnsaJjZJK7oibJSGp7D3j4UUz8OYYClVMbnMoz/y2IhgO2zpRw==
X-Received: by 2002:a05:6402:2693:: with SMTP id w19mr7740214edd.266.1639487509420;
        Tue, 14 Dec 2021 05:11:49 -0800 (PST)
Received: from [10.45.34.115] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id 26sm1381975ejk.138.2021.12.14.05.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 05:11:49 -0800 (PST)
Message-ID: <8f1c66f7-f0d8-bd95-dbc1-f0f3e25b3dff@unity3d.com>
Date:   Tue, 14 Dec 2021 14:11:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2] fast-export: fix surprising behavior with
 --first-parent
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <pull.1084.git.1637666927224.gitgitgadget@gmail.com>
 <pull.1084.v2.git.1639037637231.gitgitgadget@gmail.com>
 <CABPp-BGdCizEGcwPS+0VB_vvYLpGCWKLqx-nbZtJ16QkVxzbGQ@mail.gmail.com>
 <b87ec8f9-dd0d-c7b8-1c2a-edfd3d015930@unity3d.com>
 <CABPp-BHwk25XK7qT4C8KELWXObc_W2DCXusPfLSMUuUKmeCUxw@mail.gmail.com>
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <CABPp-BHwk25XK7qT4C8KELWXObc_W2DCXusPfLSMUuUKmeCUxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/12/2021 01.31, Elijah Newren wrote:
> On Mon, Dec 13, 2021 at 7:09 AM William Sprent <williams@unity3d.com> wrote:
>>
>>> However, given that it's unsafe to set revs.reverse=1 earlier, now
>>> that I think about it, isn't it also unsafe to set revs.topo_order
>>> where it is?  Someone could override it by passing --date-order to
>>> fast-export.  (It's okay if you want to leave fixing that to someone
>>> else, just thought I'd mention it while reviewing.)
>>>
>>
>> I couldn't tell you for sure if the topo_order placement is safe. I at
>> least don't see any place where topo_order itself can be toggled off in
>> revision.c.  I'm sure there exists at least one rev-list argument which
>> will cause unexpected behaviour, though.
>>
>> I agree that it would be nice to have the traversal order options be
>> assigned in the same place. I guess we have three options:
>>
>>
>>      1. Put the reverse assignment to the top (together with topo_order),
>> allowing the user to disable it with --reverse, which will cause odd
>> behaviour.
> 
> I'd call it broken rather than merely odd; more on this below.
> 
>>      2. Put the reverse assignment to the top and throw an error if the
>> user passes the --reverse option.
> 
> Might be a reasonable longer term solution if someone wants to dive
> into all the non-sensical options and mark them as such.  But I agree
> that it's slightly odd only picking one specific one when we know
> there's likely a pile of them here.
> 
>>      3. Keep the reverse assignment at the bottom, silently ignoring any
>> --reverse option.
> 
> "silently ignored" or "dismissed with prejudice"?  :-)
> 

Heh. :) It would definitely an "interesting" option to be able to 
reverse the commit graph, if it worked..

>> I don't think any of the three options are particularly good. The first
>> one for obvious reasons. The second seems inconsistent to me as we would
>> only error on --reverse but not any of the other "nonsensical" rev-list
>> args. However, silently ignoring certain arguments does also not make
>> for a good user experience.
>>
>> I think that it might be a good idea to move up the 'reverse' assignment
>> and then add a paragraph to the man page for git-fast-export explaining
>> that some arguments, in particular the ones that change the ordering of
>> commits and the ones that change how commits are displayed (such as
>> --graph), may have no or unexpected effects.
> 
> I'd rather choose option #3, like builtin/add.c does with max_count.
> In part this is because...
> 
>> I've tried writing a snippet in git-fast-export.txt, which I could include
>> in the next version, if you think it seems like a reasonable approach:
>>
>> diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
>> index 1978dbdc6a..34875ef01d 100644
>> --- a/Documentation/git-fast-export.txt
>> +++ b/Documentation/git-fast-export.txt
>> @@ -157,16 +157,21 @@ by keeping the marks the same across runs.
>>   [<git-rev-list-args>...]::
>>          A list of arguments, acceptable to 'git rev-parse' and
>>          'git rev-list', that specifies the specific objects and references
>>          to export.  For example, `master~10..master` causes the
>>          current master reference to be exported along with all objects
>>          added since its 10th ancestor commit and (unless the
>>          --reference-excluded-parents option is specified) all files
>>          common to master{tilde}9 and master{tilde}10.
>> ++
>> +Arguments to `git rev-list` which change the _order_ in which commits are
>> +traversed, such as '--reverse', as well as arguments which control how commits
>> +are displayed, such as '--graph', may either have no effect or have an
>> +unexpected effect on which commits are exported.
> 
> After your patch, --reverse won't have an unexpected effect on _which_
> commits are exported, it would instead have an unexpected effect on
> _how_ commits are exported (turning _every_ commit into a root
> commit).  I'd rather just go with your option #3.
> 

Alright. I guess another solution would have been to move topo_order 
down, but that seems unsafe as well. According to your commit, 
668f3aa776 (fast-export: Set revs.topo_order before calling 
setup_revisions, 2009-06-25).

I'll leave the revs.reverse assignment where it is for now.

>>>> +
>>>> +               git fast-export main -- --first-parent >first-parent-export &&
>>>> +               git fast-export main -- --first-parent --reverse >first-parent-reverse-export &&
>>>> +
>>>> +               git init import &&
>>>> +               git -C import fast-import <first-parent-export &&
>>>> +
>>>> +               git -C import rev-list --format="%ad%B" --topo-order --all --no-commit-header >actual &&
>>>
>>> Same simplifications as above here:
>>>      git -C import log --format="%ad %s" --topo-order --all >actual &&
>>>
>>> However, is there a reason you're using "--all" instead of "main"?
>>> Although main is the only branch, which makes either output the same
>>> thing, it'd be easier for folks reading to catch the equivalence if it
>>> was clear you were now listing information about the same branch.
>>>
>>
>> I guess the intent is to be completely sure that only four commits were
>> exported, and no other refs made it into the new repository. I don't feel
>> too strongly about it, but I think it is a slightly stronger test than
>> leaving out the '--all'.
> 
> Fair enough, '--all' works for me with that explanation.
> 

Ok. In summary I'll use the commit message you wrote and apply the rest 
of your feedback for the test for the next version.
