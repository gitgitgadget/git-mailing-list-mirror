Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A213C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 16:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjCXQWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 12:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjCXQWl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 12:22:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDDD21968
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 09:22:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso3160233wmo.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 09:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679674958;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6dO5VaTTWueBE56CPpl6mrhOPi+eVYcY+hAskbx2Wk=;
        b=YBOETrVafQ3Deu7iyL2aMKjq94hFjhLYZfaJKF0hVvGyx3ugaApuYMPOzuT9O4wFHW
         v1kHNNdO83VEv1NFEa3SD7P3QM6QiHaEK3g3q8yBzpqBxOErGaoMaO+Ip2QiQ42+7jXA
         T2F9qARv5UeAAdkBgs/5pjX7AaGHiWdickTb5zsRKVOG+UCTOuEfHB0AWXj3tMXO60Bx
         DUAan5JCttW+yeIpYGJW5ofSkQmPlSxZ5QyO184EwSaHvu+SWZBjq4OJXIzUCewu7dET
         u2HvrH78zCYUqSDizzTbZKCdjWSVgMJNPcXeas6wK3F53PgxAq8zvZ4EH+Kbv0SsD+8U
         9B8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679674958;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6dO5VaTTWueBE56CPpl6mrhOPi+eVYcY+hAskbx2Wk=;
        b=WpGkqrsGXegDNnSsrwMNRsqR4VuOFNZc+4Iip/mtaBWF0Tk9Om9Qax5nS/eeLdcX3J
         9VhIjaeK6hyNZYFZNgrEI3tWxJfbuT7HCkgFhrvd4K7tBy+4J3QQxz0617BxlWtlcUHK
         qiPmXPGSGFMknxcpdjydpv6cmINFV4rftsn0lO32iZos4YUDE63f2VjaHAb8MiMUx01p
         S+caegHUBkaIC0/SPonQlGzCCu7lxyxh/JRDDH+2qqqo3s3USyCNKxV5FWenTwY/mgzP
         eJ9mPoqKYpqCQiLxGfikQlT57OzMD4kOvNPmXTuQbBXxPNJvY2zK5f0yS56YRMN8xPKC
         QK0Q==
X-Gm-Message-State: AO0yUKUb9TtF2qbScjAAfYfHOyw1w5ZyFSHUje924KqvVj13QXL+ZnpK
        Jf3LReLjI2n+hUJ5RsoLTv8Xd6Y2rnM=
X-Google-Smtp-Source: AK7set9WicJMiXy97PCv+ey/DOMJ78FGb/laqNzgULLglsgfCrRqh7KIXy8M5MiUvmUdxL3IPWJVIg==
X-Received: by 2002:a05:600c:2189:b0:3ed:3d89:1b4b with SMTP id e9-20020a05600c218900b003ed3d891b4bmr3008078wme.8.1679674958028;
        Fri, 24 Mar 2023 09:22:38 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c2b8b00b003ef5b0a533dsm1604806wmc.47.2023.03.24.09.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 09:22:37 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <5e49f936-5281-6645-7bf7-78e658087c8a@dunelm.org.uk>
Date:   Fri, 24 Mar 2023 16:22:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: do not update "done" when rescheduling command
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <xmqq4jqfmi2k.fsf@gitster.g>
 <9e5093ab-2aa8-16e7-227a-f5c56983be9a@dunelm.org.uk>
 <xmqqfs9u409m.fsf@gitster.g>
In-Reply-To: <xmqqfs9u409m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 24/03/2023 15:49, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>>> Note that the rescheduled command will still be appended to the "done"
>>>> file again when it is successfully executed. Arguably it would be better
>>>> not to do that but fixing it would be more involved.
>>> And without quite understanding what "reschedule" refers to, it is
>>> unclear why it is even arguable---it is perfectly sensible that a
>>> command that is rescheduled (hence not yet done) would not be sent
>>> to 'done'.  If a command that was once rescheduled (hence it wasn't
>>> finished initially) gets finished now, shouldn't it be sent to
>>> 'done'?  It is unclear why is it better not to.
>>
>> The command is only successfully executed once but may end up in
>> 'done' multiple times. While that means we can see which commands
>> ended up being rescheduled I'm not sure it is very useful and think
>> really we're just cluttering the 'done' file with failed attempts.
> 
> Sorry, but you utterly confused me.

Perhaps I should have not have added that last paragraph to the commit 
message.

>  I thought the point of this
> change was to avoid such a failed attempt to be recorded in "done",

No. This change fixes a bug where when we add the failed command back 
into "git-rebase-todo" we accidentally add the previous command to the 
"done" file. If "pick A" succeeds and "pick B" fails because it would 
overwrite an untracked file then currently when the rebase stops after 
the failed "done" will contain

	pick A
	pick B
	pick A

When it should contain

	pick A
	pick B

i.e. the last line should be the last command we tried to execute.

> and if that is the case, we (1) do not record any failing attempts,

unfortunately "done" is updated just before we try and execute the 
command so all the failing attempts are recorded. I'm not trying to 
change that in this patch, I mentioned it in the commit message as a 
suggestion for a future improvement.

> (2) record the successful execution, and (3) will not re-attempt
> once it is successful.  And if all of these three hold, we wont
> clutter 'done' with failed attempts at all, no?

Yes, unfortunately that's not how it works at the moment.

>>>> @@ -4648,7 +4649,7 @@ static int pick_commits(struct repository *r,
>>>>    		const char *arg = todo_item_get_arg(todo_list, item);
>>>>    		int check_todo = 0;
>>>>    -		if (save_todo(todo_list, opts))
>>>> +		if (save_todo(todo_list, opts, 0))
>>>>    			return -1;
>>> I wonder why we pass a hardcoded 0 here---shouldn't the value match
>>> the local variable 'reschedule'? here?
>>> The same question for the other two callers, but I admit that when
>>> the second one is called, the local variable "reschedule" is not
>>> set...
>>
>> The rescheduling code is a bit of a mess as rescheduling commands that
>> pick a commit does not use the "reschedule" variable and is handled
>> separately to other commands like "reset", "merge" and "exec" which do
>> use the "reschedule" varibale. I did try and add a preparatory step to
>> fix that but failed to find a good way of doing so.
> 
> I see.  It may be a sign, taken together with the fact that I found
> that it was very hard---even after reading the patch twice---to
> understand the verb "reschedule" in the proposed commit log to
> explain the change, that the concept of "reschedule" in this
> codepath may not be clearly capturing what it is attempting to do in
> the first place.

I'll try and come up with some better wording (if you have any 
suggestions please let me know). What's happening is that just before we 
try and execute a command it it removed from "git-rebase-todo" and added 
to "done". If the command then fails because it would overwrite an 
untracked file we need to add it back into "git-rebase-todo" before 
handing control to the user to remove the offending files. When the user 
runs "git rebase --continue" we'll try and execute the command again. It 
is the adding the command back into "git-rebase-todo" so that it is 
executed by "git rebase --continue" that "reschedule" was intended to 
capture.

The basic problem is that rebase updates "git-rebase-todo" and "done" 
before it has successfully executed the command (cherry-pick and revert 
only remove a command from their todo list after it is executed 
successfully). I fear it may be too late to change that now though.

>> The reason I went
>> with hardcoded parameters is that for each call the purpose is fixed
>> and as you noticed the "reschedule" variable is only used for
>> rescheduling "reset", "merge" and "exec". I could expand the commit
>> message or do you think a couple of code comments be more helpful?
> 
> Yeah, at least it sounds like the code deserves a "NEEDSWORK: this
> is messy in such and such way and we need to clean it up to make it
> understandable" comment somehow.

I'll have another think about how we could clean it up, if that fails 
I'll add a code comment. I'll be offline next week so I'll re-roll after 
that.

Best Wishes

Phillip
> Thanks.
