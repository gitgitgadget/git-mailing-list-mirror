Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7C1C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 03:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C1D6109E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 03:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhHMDgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 23:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhHMDgI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 23:36:08 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1095C061756
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 20:35:42 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a12so7226287qtb.2
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 20:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/YE3yI3IJFWOC0VvpKWJ2tDg58+Z/cdFrsA2/d+wm2s=;
        b=FJVc3bfHpJD6CFJ+9k5ZE2SofchvS/cLXf3DG+27qYU01CTPzMEPwhlb9ydgRnZ3NX
         GZUhdyv8ShK/Xx9g45Q9m/iL3nl6V+Q2JolzDF9BVOlidSeR76/v+0+3kfPPgcmQTvrJ
         XTu7WpCW8MSwmhzbRKj1JtPe0+y3Q61RIs6sFDQl7sfVM9qa/xK5pTfDtbk+ZMsKjhHV
         Oedd8OPRYFHnFOeM7KXTuHOEhx2U//EkfvL+mAi9SRdezW4lM2j/+NaklNOAbKWfPQpL
         ODBY1C0YEAVD3JfazonF1P9hWGfOAMC9Oq1+sSDQMt85rDFbgewd4bllUU/x+QYEXlOf
         tPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/YE3yI3IJFWOC0VvpKWJ2tDg58+Z/cdFrsA2/d+wm2s=;
        b=XByY+LEPcN3NfsI0btvgjoC5dQEbzCZYhGV9N9nX5tHklMFLUilAT7YCNNeoj8SuaT
         eLTxGi8AVlWVyYRrErAHi/nAcFHo6VceTKUkl+JZGGhHRFCzjdT6XAEEBqzD/+G0qf3W
         GG2rzng9X/qySt+zRNL0LGk0p2FGpRd80bp5ZDs/DQ32qhdSJ+/C2ScGkwHBNMvTMlor
         PMkqo9h9eU+jfGNWXu9tgjq2dT8BM/ZXAWhZnrxkNQeiBssTurQJYi/JvViv8f9qlJk6
         JQqSKu2c6aXDC6WzFSePy2OQTrCaRRriYaktQjHpJQxAsh2dDSsNuvJvMl/X+FsvXhle
         qYXg==
X-Gm-Message-State: AOAM530L3KDkxy2cOkQvbGe/sh4za3ApxJsFaduXEGic4iOiF2oRDvBz
        damDYy+ihPqr7IodqrldxO0=
X-Google-Smtp-Source: ABdhPJwowl9Pa+C33V/jLQb+SzqurtBenWSCUPDKcLGzf4gnItrzcvrpcKmRQ6lPuFDKb5F6viGWfg==
X-Received: by 2002:ac8:5bca:: with SMTP id b10mr152774qtb.278.1628825741866;
        Thu, 12 Aug 2021 20:35:41 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id e15sm179280qte.95.2021.08.12.20.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 20:35:41 -0700 (PDT)
Subject: Re: [PATCH v5] clone: set submodule.recurse=true if user enables
 feature.experimental flag
To:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Mahi Kolla <mahikolla@google.com>
References: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
 <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
 <xmqqeeaz70ph.fsf@gitster.g> <YRW0pGXXWnY7C470@google.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <c74a9d75-cd89-d020-dcb3-76509bc95284@gmail.com>
Date:   Thu, 12 Aug 2021 23:35:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YRW0pGXXWnY7C470@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

Le 2021-08-12 à 19:54, Emily Shaffer a écrit :
> On Wed, Aug 11, 2021 at 09:20:58PM -0700, Junio C Hamano wrote:
>>
>> "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Mahi Kolla <mahikolla@google.com>
>>>
>>> Currently, when running 'git clone --recurse-submodules', developers do not expect other commands such as 'pull' or 'checkout' to run recursively into active submodules. However, setting 'submodule.recurse' to true at this step could make for a simpler workflow by eliminating the '--recurse-submodules' option in subsequent commands. To collect more data on developers' preference in regards to making 'submodule.recurse=true' a default config value in the future, deploy this feature under the opt in feature.experimental flag.
>>
>> Please wrap overlong lines in your proposed log message to say 70 or
>> so columns.
>>
>>>
>>> Since V1: Made this an opt in feature under the experimental flag. Updated tests to reflect this design change. Also updated commit message.
>>
>> This does not belong to the commit log message proper.  Noting the
>> difference between the version being submitted and the pervious one
>> this way is a way to help reviewers and is very much appreciated,
>> but please do so below the three-dash line below your sign-off.

Mahi, since you're using Gitgitgadget, you would put this "since v1"
content in the PR description, and Gitgitgadget will append it under
the three-dash line when you /submit :) (Do keep the CC's automatically
added by GGG so that your next version is CC'ed to those that participated
in earlier rounds).

>>
>>> Signed-off-by: Mahi Kolla <mahikolla@google.com>
>>> ---
>>>      clone: set submodule.recurse=true if feature.experimental flag enabled
>>
>> The proposed approach misuses feature.experimental flag, which was
>> designed to turn on many new features at once.  The features covered
>> by the flag share one common trait: they all have gained consensus
>> that in the longer term we would hopefully be able to make it on by
>> default, and give early adopters an easy way to turn them all on.
>>
>> I do not think setting submodule.recurse=true upon "clone --recurse"
>> falls into that category just yet.  If we were to make this opt-in,
>> we'd want a separate flag, so that those early adopters who are
>> dogfooding other features that have consensus that they are
>> hopefully the way of the future won't have to be forced into this
>> separate feature.
> 
> I'd like to open discussions to get said consensus :)
> 
> It seems surprising to me that a user would want to clone with all the
> submodules fetched *without* intending to then use
> superproject-plus-submodules together recursively. I would like to hear
> more about the use case you have in mind, Junio.
> 
> One scenario that did come to mind when I discussed this with Mahi is
> that a user may provide a pathspec to --recurse-submodules (that is,
> "yes, this repo has submodules a/ and b/, but I only care about the
> contents of submodule a/") - and in that case, --recurse-submodules
> seems to do the right thing with or without Mahi's change.

I'm not sure what you mean by "the right thing" here. '--recurse-submodules=a'
would set 'submodule.active' to 'a', which means "when command are asked to recurse into
submodules, I only care about submodules a", but it does not do anything to
'submodule.recurse=true', which means "I do not ever want to type '--recurse-submodules',
always use this behaviour for all commands that have that flag, except clone and ls-files.
Unless I'm missing something :)

> 
> It seemed to me that trying out this change on feature.experimental flag
> was the right approach, because users with that flag have already
> volunteered to be testers for upcoming behavior changes; this seems like
> one such that is likely to be welcome. By contrast, turning the behavior
> on with a separate config variable reduces the pool of testers
> essentially to "users who know about this change" - or, to be more
> reductive, "a handful of users at Google who we Google Git contributors
> already know want this change". I recommended to Mahi that we stick this
> feature under 'feature.experimental' because I really wanted to hear
> from more users than just Googlers.

I agree that we would not want yet another config variable that users would
have to set. If people know about submodule.recurse and want to always use this
behaviour, they already have it in their ~/.gitconfig, so they do not need a new
variable. If they do not know about submodule.recurse, then they probably won't learn
about this new variable either ;) That's why I suggested to Mahi that in any case it would
be a good thing that 'git clone --recurse-submodules' would at least inform users, using
an advice, that they might want to set submodule.recurse.

Regarding feature.experimental, I do not have a strong opinion. I don't think
the population of Git users that have this flag set is representative of the total
population of Git users, unfortunately. But I agree it's better than nothing.

> 
>>
>> Perhaps a separate (and new) configuration variable (in ~/.gitconfig
>> perhaps) can be used as that opt-in flag (I wonder if the existing
>> submodule.recurse variable can be that opt-in flag, though).
>>
> 
> Do you mean something like "git config --global submodule.recurse
> TryTheNewThingPlease"? I guess it could work - repos that use a pathspec
> in that slot would still have the pathspec configured locally, 

Here I think you are confusing submodule.active (which takes a pathspec)
and submodule.recurse (which takes a boolean).

Cheers,

Philippe.
