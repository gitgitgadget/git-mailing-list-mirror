Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D314C282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 21:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459C62082E
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 21:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLCQJWSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgAJVbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:31:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51011 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAJVbU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 16:31:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so3513061wmb.0
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 13:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0x31xRhi/+Y776TuoazC3kD9xR7VyYdYd3Q/N6VCipo=;
        b=vLCQJWSJ93hK6UbQ4F+VERPjN0/gXU6ssejT+/c6DSKDKRaNwU+ojWxpfFd2w9A9wT
         EEkCO1tqwOjinxiWQxS9J0mLYgwJIRoe799LJE2O41aKLacXtki7+PhB8x75CleWGpau
         vM8b7k3UcqaF2evDcvpYFa23mmWxYFbTaiY0N9mwLbye0qJYCi3IpLNdsphRsU9OyzLD
         bWfZ19zKOwPiu6CGjO17hHlNLRv/NkfqaxuP/0/rOb9LyCuP9C+lZsnSXSOpFDfzslEF
         QjfssvdgwDS75oTyT7dBr18JOmvvBSxQBZW0VDGoz0GZGK7PB/E4g3yM6/Ai1ExXNNyK
         KNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0x31xRhi/+Y776TuoazC3kD9xR7VyYdYd3Q/N6VCipo=;
        b=X9YShBZxNFJlqn5Rguqh8cLk2mUgbv7P6kgomVQRDtta5uWBNFkdyd2tVId7M1FKRR
         sfEDSjfBQmc+GTlZt/38JslgQ/pz2JwAJMoE0oEqEiqEPqHtW0a0QM/TXZJ4bf1zwO7u
         SkFTEi6IN9hyDHITvplawKjxV2kxOEy+E80a9bcQYvkFSs+e6WykGOhhhGdR2vUCHxO6
         VJbg/uZAHt1DtTJHPbPoaVr0JQx6hgjSOJi+Qpm2vLQIkOv3ZjNZBIjtuNCZX8tPCorA
         +aWcVEtEr4tzMGcGTQlV+/T1maxfs6btMvW+25uZ6oJalfX5lR6qoVop0s5cCNor10uM
         N0wg==
X-Gm-Message-State: APjAAAWxfVa6IiFKPVd2Ye5N9oRtci15S2pQhw+QEpR7b/xLjoIPhIo9
        gaQboFrF+0Nf5FqugIJtcmQ=
X-Google-Smtp-Source: APXvYqxR77ggevoNN+bho7HYGjMPeKAUEuWdFXkpN5rL1VM/TXA4Cwe23e/TWZgBqacKl1dTUGuO+A==
X-Received: by 2002:a05:600c:2150:: with SMTP id v16mr5843301wml.156.1578691878611;
        Fri, 10 Jan 2020 13:31:18 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-29-116.w86-222.abo.wanadoo.fr. [86.222.28.116])
        by smtp.gmail.com with ESMTPSA id t8sm3708870wrp.69.2020.01.10.13.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 13:31:17 -0800 (PST)
Subject: Re: [PATCH v3 2/2] rebase-interactive: warn if commit is dropped with
 `rebase --edit-todo'
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20191104095449.9964-1-alban.gruin@gmail.com>
 <20191202234759.26201-1-alban.gruin@gmail.com>
 <20191202234759.26201-3-alban.gruin@gmail.com>
 <xmqqk17b5263.fsf@gitster-ct.c.googlers.com>
 <64aa4049-ee35-df4c-1e6c-80707f4f9070@gmail.com>
 <0bf602bb-eff0-12f1-fa6c-c670a12f2cee@gmail.com>
 <79ad2e01-2fc3-cd52-7879-5a81370628ef@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <85e3d40a-9829-0f50-8d91-7e8e8fa319f1@gmail.com>
Date:   Fri, 10 Jan 2020 22:31:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <79ad2e01-2fc3-cd52-7879-5a81370628ef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 10/01/2020 à 18:13, Phillip Wood a écrit :
> Hi Alban
> 
> On 09/01/2020 21:13, Alban Gruin wrote:
>> Hi Phillip,
>>
>> Le 09/12/2019 à 17:00, Phillip Wood a écrit :
>>>>> diff --git a/rebase-interactive.c b/rebase-interactive.c
>>>>> index ad5dd49c31..80b6a2e7a6 100644
>>>>> --- a/rebase-interactive.c
>>>>> +++ b/rebase-interactive.c
>>>>> @@ -97,7 +97,8 @@ int edit_todo_list(struct repository *r, struct
>>>>> todo_list *todo_list,
>>>>>               struct todo_list *new_todo, const char *shortrevisions,
>>>>>               const char *shortonto, unsigned flags)
>>>>>    {
>>>>> -    const char *todo_file = rebase_path_todo();
>>>>> +    const char *todo_file = rebase_path_todo(),
>>>>> +        *todo_backup = rebase_path_todo_backup();
>>>>>        /* If the user is editing the todo list, we first try to parse
>>>>> @@ -110,9 +111,9 @@ int edit_todo_list(struct repository *r, struct
>>>>> todo_list *todo_list,
>>>>>                        -1, flags | TODO_LIST_SHORTEN_IDS |
>>>>> TODO_LIST_APPEND_TODO_HELP))
>>>>>            return error_errno(_("could not write '%s'"), todo_file);
>>>>>    -    if (initial && copy_file(rebase_path_todo_backup(), todo_file,
>>>>> 0666))
>>>>> -        return error(_("could not copy '%s' to '%s'."), todo_file,
>>>>> -                 rebase_path_todo_backup());
>>>>> +    unlink(todo_backup);
>>>>> +    if (copy_file(todo_backup, todo_file, 0666))
>>>>> +        return error(_("could not copy '%s' to '%s'."), todo_file,
>>>>> todo_backup);
>>>>
>>>> We used to copy ONLY when initial is set and we left old todo_backup
>>>> intact when !initial.  That is no longer true after this change, but
>>>> it is intended---we create an exact copy of what we would hand out
>>>> to the end-user, so that we can compare it with the edited result
>>>> to figure out what got changed.
>>>
>>> I think it would be better to only create a new copy if the last edit
>>> was successful. As it stands if I edit the todo list and accidentally
>>> delete some lines and then edit the todo list again to try and fix it
>>> the second edit will succeed whether or not I reinserted the deleted
>>> lines.
>>>
>>> We could add this to the tests to check that a subsequent edit that does
>>> not fix the problem fails
>>>
>>> diff --git a/t/t3404-rebase-interactive.sh
>>> b/t/t3404-rebase-interactive.sh
>>> index 969e12d281..8544d8ab2c 100755
>>> --- a/t/t3404-rebase-interactive.sh
>>> +++ b/t/t3404-rebase-interactive.sh
>>>
>>> @@ -1416,6 +1416,7 @@ test_expect_success 'rebase --edit-todo respects
>>> rebase.missingCommitsCheck = er
>>>                  test_i18ncmp expect actual &&
>>>                  test_must_fail git rebase --continue 2>actual &&
>>>                  test_i18ncmp expect actual &&
>>> +               test_must_fail git rebase --edit-todo &&
>>>                  cp orig .git/rebase-merge/git-rebase-todo &&
>>>                  test_must_fail env FAKE_LINES="1 2 3 4" \
>>>                          git rebase --edit-todo 2>actual &&
>>>
>>>
>>
>> In which case, if the check did not pass at the previous edit, the new
>> todo list should be compared to the backup.  As sequencer_continue()
>> already does this, extract this to its own function in
>> rebase-interactive.c.  To keep track of this, a file is created on the
>> disk (as you suggested in your other email.)  At the next edit, if this
>> file exists and no errors were found, it is deleted.  The backup is only
>> created if there is no errors in `todo_list' and in `new_todo'.
>>
>> This would guarantee that there is no errors in the backup, and that the
>> edited list is always compared to a list exempt of errors.
>>
>> This approach also has the benefit to detect if a commit part of a
>> badcmd was dropped.
>>
>> After some tweaks (ie. `expect' now lists 2 commits instead of one),
>> this passes the test with the change you suggested, and the one you sent
>> in your other email.
> 
> That sounds good. I'm not sure how it passes the test in my other email
> though, if sequencer_continue() compares the todo list to the backup
> wont it still fail when continuing after conflicts as the backup is out
> of date?
> 

I changed sequencer_continue() to check the todo list only if the file
indicating an error exists.

I still have to rewrite the commit message, then I’ll re-send this series.

Cheers,
Alban

> Best Wishes
> 
> Phillip
> 
