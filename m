Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A1BC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 22:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9BFF6108F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 22:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhHRWqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 18:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhHRWqV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 18:46:21 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B9AC061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 15:45:46 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id n11so5025389qkk.1
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GChFKv293xcFr4LLsbT+ASNwhMl7Rlzn02KhIje/lIw=;
        b=GRc+dc8E2DZO9hvYUbjSf/d9H8b8whEUvLtqeOqD6as4umqJzcrLRoAafeScmwPeA+
         zb5IlSpJ5QTdxnw5Jf+okKzNZJpP4Ez62d/wzgj2rcKpvuN75iHca/KZsP0TZfM8GLnm
         5KP3AbEwsp8dMykYA8IBqCXjf01IO+4Un0EOEnnqDoCUCuOOYjT4GZ/vi3S/kpdOWNIU
         7p5KAOqfMlQEZJb2sKox98yMwxduza5RSqehurMcuSxNDC1ty/58dV0AkSU3XG+5BEhk
         IDYJf1VRCuOyZOBkLcPms/ILPlOC5JblmTdVLay3/fg9GQvjzbcAI/iamiVd2tBUSdZd
         nciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GChFKv293xcFr4LLsbT+ASNwhMl7Rlzn02KhIje/lIw=;
        b=e19B1ZE6RPdUgnFjKbkIMH0dU5wFStB/zbh2bQwbn/mTbwzSts6RTM+LkNo+jCpcFs
         IGL6Yyqrk6yBMlTrcUiCiKS2BvZoV0fxFgA9sRowTpTp2H4Nf7D0DUdPd1j0iLvsOg1/
         V/wSMjxbc1nWV4s+msrpaV7pC+qFBybLGe3ZiIQjjnx6yY4D4J5+edkc3+/pSz4QScJI
         9RpOD9tr0+w+eD2PVw35B6kPzqBvRoMGyid0GwU+WTQ7U7Z6pqCSLVXMDdh1SkQOAomA
         IQ42mF2iuM93U/b928hc7IK6/grZnRf++4tZCHKVzQtAYihkLV4W9sxlNq8nbDnkkUT0
         bj1g==
X-Gm-Message-State: AOAM530XgirQYOhXn3UPS/0LnVeQapGoASRF11eEaBZCXMwATxKozXeI
        wJBNqQqf0GJLjinOMOM/WI8=
X-Google-Smtp-Source: ABdhPJxXO8ONbR/Zw+C0rNLB99sITKk/6MYhr1QKWLc4CKCH+25fWZQ6CFDZOFUzGsuuEUu2cfabpw==
X-Received: by 2002:a37:a905:: with SMTP id s5mr628748qke.63.1629326745169;
        Wed, 18 Aug 2021 15:45:45 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id g1sm617350qti.56.2021.08.18.15.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 15:45:44 -0700 (PDT)
Subject: Re: [PATCH v2] sequencer: advise if skipping cherry-picked commit
To:     phillip.wood@dunelm.org.uk, Josh Steadmon <steadmon@google.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
 <496da0b17476011b4ef4dde31593afc7572246eb.1628623058.git.steadmon@google.com>
 <c185a396-c498-b2ef-1c86-cec7d5751f3d@gmail.com>
 <e363df27-a99e-1a43-f493-ed90de7b6363@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <cc044079-c40d-ab79-8afa-8a1dfa66f279@gmail.com>
Date:   Wed, 18 Aug 2021 18:45:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e363df27-a99e-1a43-f493-ed90de7b6363@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 2021-08-18 à 06:02, Phillip Wood a écrit :
> On 12/08/2021 18:45, Philippe Blain wrote:
>> Hi Josh,
>> [...]
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 7f07cd00f3..1235f61c9d 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -5099,6 +5099,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>>>       int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
>>>       int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
>>>       int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
>>> +    int skipped_commit = 0;
>>>       struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
>>>       struct strbuf label = STRBUF_INIT;
>>>       struct commit_list *commits = NULL, **tail = &commits, *iter;
>>> @@ -5149,8 +5150,13 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>>>           oidset_insert(&interesting, &commit->object.oid);
>>>           is_empty = is_original_commit_empty(commit);
>>> -        if (!is_empty && (commit->object.flags & PATCHSAME))
>>> +        if (!is_empty && (commit->object.flags & PATCHSAME)) {
>>> +            advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
>>> +                    _("skipped previously applied commit %s"),
>>> +                    short_commit_name(commit));
>>> +            skipped_commit = 1;
>>>               continue;
>>> +        }
>>>           if (is_empty && !keep_empty)
>>>               continue;
>>
>> For interactive rebase, an alternate implementation, that I suggested in [1] last summer, would be to keep
>> the cherry-picks in the todo list, but mark them as 'drop' and add a comment at the
>> end of their line, like '# already applied' or something like this, similar
>> to how empty commits have '# empty' appended. I think that for interactive rebase, I
>> would prefer this, since it is easier for the user to notice it and change the 'drop'
>> to 'pick' right away if they realise they do not want to drop those commits (easier
>> than seeing the warning, realising they did not want to drop them, aborting the rebase
>> and redoing it with '--reapply-cherry-picks').
> 
> That would be nice, but we could always add it in the future if Josh does not want to implement it now. At the moment the function that creates the todo list does not know if it is going to be edited, I'm not sure how easy it would be to pass that information down.

Well, I'm not sure we need to ? If we change the 'pick' to 'drop', instead of
not writing these lines to the todo list, the cherry-picked commits will get dropped
either way, no? Unless I'm missing something - I think you are way more well-versed in
the sequencer code than me :)

>>
>> Like Junio remarked, it is a little unfortunate that some logic is duplicated between
>> 'sequencer_make_script' and 'make_script_with_merges', such that your patch has to do
>> the same thing at two different code locations. Maybe a preparatory cleanup could add
>> a new function that takes care of the duplicated logic and call if from both ? I'm
>> just thinking out loud here, I did not analyze in details if this would be easy/feasible...
> 
> I think feasible but not easy (or required for this change), it would also complicate the code in a different way as I think we'd have to add some conditionals for whether we are recreating merges or not.

Yes, I agree it's not required for this change.

Cheers,

Philippe.
