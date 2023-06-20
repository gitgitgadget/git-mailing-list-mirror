Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF49EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 21:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjFTVmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 17:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFTVmy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 17:42:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B2810DA
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 14:42:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-970028cfb6cso810985966b.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687297371; x=1689889371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0KD4G087L7Q3LfoHwGvWP9hwEB1J75v5654UtA8Q5A=;
        b=Iv4MmI7hIifBiTJXbT5ilFsteLXQpdTQu3w3unEyOSxbM1GIkFjNmNGyMSRfGa0rGm
         PM3C0AebaqRmx0fLx1OJdpIbr7FEqbE0asKEN3z14MmSZsRkLo3K6Tj13T27jew8+VgI
         HmtC+jjIQvemGiKaj4SJAsM6R2B77z91NZuebHjTWcrWBs2zANRG6rQcqeSRW9d0aqiZ
         8qKVvm2pEDHp0ssqKHqWDr8vzHlazMqD0rcpqoEGgrWYgIECQEe+db5YkY6d8xCfbKUc
         pra+mrBpuBQUGFR+Qj9YPQMuzLYXV7v4gn39vVvIBB4HQWBX9hkblWykVXKL6dMHyh6t
         zpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687297371; x=1689889371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0KD4G087L7Q3LfoHwGvWP9hwEB1J75v5654UtA8Q5A=;
        b=UGAr388aDEtY5a3UtelcKZeLkDTtCuIkpWTMjqWZsrgxsJBrYXLyXAL4CRgaCQfSJK
         RdANqO6dYH594MxTX6LIqbBsRVbjOcuL7C5rct8UayJTqphFS5woMIpIByFFBTyEOA17
         IPANmAOS9nKkygE7VD5ZBEF4iTl0+5EGo9t4hsMeAIG9mFxMSjRtgnpupUJjlU56oCb8
         0E5+PKWOOKwjgRV78v/vjWmllVsHFxnSpK1/eObuNDCJpaFZ/gkW6lU8KWaV5qTcILTj
         4zZ9MAmjbDmlDJqW5i2QdE+oLd9JJ6+QFEDDb6N82iymPYhgGkyEnCC2EVZ1EaS59Oyy
         12wg==
X-Gm-Message-State: AC+VfDySmcvtW1TfOaFJT8ycruOCSIBKh0s6doH9c5h0mmrGYivxues7
        /kC1jGs8rtJq+rwG9lx24w0=
X-Google-Smtp-Source: ACHHUZ4mhvx3B/CVSGWhFV1/zSgFeq0BzeeR4kfeFverX8Mvw0k5XNyqE2qG51I9ik0VCXz6CLxmsA==
X-Received: by 2002:a17:907:728b:b0:988:e0cd:99c4 with SMTP id dt11-20020a170907728b00b00988e0cd99c4mr4601964ejc.31.1687297370856;
        Tue, 20 Jun 2023 14:42:50 -0700 (PDT)
Received: from ?IPV6:2a00:a041:189c:9700:159b:4c7a:469:54ec? ([2a00:a041:189c:9700:159b:4c7a:469:54ec])
        by smtp.gmail.com with ESMTPSA id c24-20020a170906341800b0094f07545d40sm1975169ejb.220.2023.06.20.14.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 14:42:50 -0700 (PDT)
Message-ID: <9e1e38af-9bc5-2ec7-f3ad-d3325969b484@gmail.com>
Date:   Wed, 21 Jun 2023 00:42:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3] Introduced force flag to the git stash clear
 subcommand.
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
References: <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
 <pull.1232.v3.git.1687219414844.gitgitgadget@gmail.com>
 <xmqqy1keodjj.fsf@gitster.g> <1540e884-08c7-922e-1fd9-65616268c1c9@gmail.com>
 <CAPig+cTXUKTWYhLpu-zRf4DFhHq_BnLZFznEc3pk-qiqcS0_CA@mail.gmail.com>
From:   Nadav Goldstein <nadav.goldstein96@gmail.com>
In-Reply-To: <CAPig+cTXUKTWYhLpu-zRf4DFhHq_BnLZFznEc3pk-qiqcS0_CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see both of your points, and I agree adding the flag will only make 
users type the flag without thinking.


But I still don't understand why do we need git clean without any flags.


The only users that will run git clean are new users that don't know you 
need to run it with -f or experienced users that set clean.requireforce 
= false.


Moreover, we can also assume that every user that have 
clean.requireforce = true (the default), and ran git clean, did so by 
mistake/intended to clean, So why don't we offer him interactive way to 
understand the consequences and confirm his action? (and explain about 
clean.requireforce like we currently do).
By doing it this way, the change will not effect experienced users 
because they either run git clean -f when they need to clean or they set 
clean.requireforce = false, and then the change will not apply to them.


This argument is also for stash clear.


Thanks.

On 21/06/2023 0:01, Eric Sunshine wrote:
> On Tue, Jun 20, 2023 at 4:05 PM Nadav Goldstein
> <nadav.goldstein96@gmail.com> wrote:
>>> I am not sure how much value users would get by requiring "--force",
>>> though.  I know this was (partly) modeled after "git clean", but
>>> over there, when the required "--force" is not given, the user would
>>> give "--dry-run" (or "-n"), and the user will see what would be
>>> removed if the user gave "--force".  If missing "--force" made "git
>>> stash clear" show the stash entries that would be lost, then after
>>> seeing an error message, it would be easier for the user to decide
>>> if their next move should be to re-run the command with "--force",
>>> or there are some precious entries and the user is not ready to do
>>> "stash clear".
>>>
>>> But just refusing to run without giving any other information will
>>> just train the user to give "git stash clear --force" without
>>> thinking, because getting "because you did not give the required
>>> --force option, I am not doing anything" is only annoying without
>>> giving any useful information.
>> I see, but isn't the same argument apply for git clean? if not adding
>> the force flag, the same message as I wrote appear in git clean (I
>> copied it from there), and it will exit without any other information,
>> hence given your argument, running git clean is also not very useful.
> For what it's worth, I had the same reaction as Junio upon reading
> this patch; specifically, that it will train users to type "git stash
> clear --force" mechanically without thinking, thus won't be much of a
> safeguard.
>
>> I suggested in the beginning of this thread to ask the user if he is
>> sure he want to proceed (default to no), and only if he wrote y/yes
>> proceed with the action (and force will just do it, or requireforce=false).
>>
>> The reason I suggested it is because when running git stash clear, it
>> will remain in the user recent commands, and when the user will navigate
>> through the commands history in the terminal, he might accidentally fire
>> git stash clear, and this confirmation will be another safeguard against
>> this mistake.
>>
>> Maybe it will be useful for git clean as well for the same reasons.
>> Also when the user types git clean, I argue he wanted to clean or he did
>> it by mistake, and In both scenarios I don't see why making git clean
>> just fail will be useful.
> "git clean" is in a rather different (and more severe) boat since file
> deletion is irrevocable, whereas a stash thrown away by "git stash
> clear" (or "git stash drop") can be recovered (at least until it gets
> garbage-collected). So, rather than adding a --force option or an
> interactive "yes/no" prompt, perhaps a better approach would be to
> have "git stash clear" (and "git stash drop") print out advice
> explaining to the user how to recover the dropped stash(es), much like
> "git switch" or "git checkout" prints advice explaining how to recover
> commits left dangling on a detached head.
>
>
