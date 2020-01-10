Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BDFC282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 17:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10982072E
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 17:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7UeIIaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgAJRNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:13:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45058 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgAJRNS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 12:13:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so2497553wrj.12
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 09:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1eF5JUTT9gzKOCYk/Q0kKywyYoaTGrVh3Otibt16lkw=;
        b=k7UeIIaGVXkjhsbYk+dRwebBcZSwc0eA/PDpr/za273IwTNTTOr2sa7OWFNMxi9lRl
         RfUHd3capdmHkMn5Nv8LKVoJtPCCUrnqLWpVZrYRus4N7aG565etd6E7aHkpduKhY6FN
         Dpz6xsLIUZKn1tiKUGUDkNL4/eKXaWMSyDA4NYdf0eXe92df+GUH23wu/pNLxCly6gmV
         EVXYx4sL1UbdbooJpLg5RuNSOiWAw1UU8/D0WPIkw1d6Q4LV/JkWbeqocdR+dSokg17L
         Z+Tq1nesNH5m0VzVn/AdInUIwnNlWB5tKcAv/VGAA2TcofRGSM4pfGn2r6R9HQKT6Yb4
         unUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1eF5JUTT9gzKOCYk/Q0kKywyYoaTGrVh3Otibt16lkw=;
        b=QGWbKCQQQjeU1mmzKZ/7yCQ+Ds9MMAq+XsGKAH9IHVWKNVqqn1p1LOTH8ubGkvW8jk
         VOzXorMHKHqi3eXNgwaoN2DYjdi1MmEKNICQoXIjpQCfmYOAv5rKHRo6m+y8LPBVLdhU
         NfHJNST695vK79QMyUN+59aXBz84n8EyRAuiI3CU8FplsIkXPr/cm5yxGuBRz79a1B9A
         zuSLqh1wqMkDqhmQBn4wQhTbWfUitQiElG74wlT9Lkm94cWUJNWs7NncIXhPALs+/S0M
         bN8ANcl5Kj/q4hZhmLj/vJ2eIlYMejGvaGV/AoPgX5WoKVBMbBkJ01wA54wc3pY4WrNf
         /3mw==
X-Gm-Message-State: APjAAAVT5EJU63QR2H7+/m42Vg1ZgWVqc6IyCX4DRLjIA6LhWf6QcWMc
        tpDeljfURfGvj/6806Mi7Bw=
X-Google-Smtp-Source: APXvYqxpAC3e+I92grRV1R+pzcAs/A5B/D0eeWqBgx1YFDofln5dR/6MEeNYn7ID5V37tE/llBMN7w==
X-Received: by 2002:adf:f58a:: with SMTP id f10mr4757780wro.105.1578676395062;
        Fri, 10 Jan 2020 09:13:15 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-12-92.as13285.net. [92.22.12.92])
        by smtp.gmail.com with ESMTPSA id t125sm2960096wmf.17.2020.01.10.09.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 09:13:14 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] rebase-interactive: warn if commit is dropped with
 `rebase --edit-todo'
To:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20191104095449.9964-1-alban.gruin@gmail.com>
 <20191202234759.26201-1-alban.gruin@gmail.com>
 <20191202234759.26201-3-alban.gruin@gmail.com>
 <xmqqk17b5263.fsf@gitster-ct.c.googlers.com>
 <64aa4049-ee35-df4c-1e6c-80707f4f9070@gmail.com>
 <0bf602bb-eff0-12f1-fa6c-c670a12f2cee@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <79ad2e01-2fc3-cd52-7879-5a81370628ef@gmail.com>
Date:   Fri, 10 Jan 2020 17:13:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <0bf602bb-eff0-12f1-fa6c-c670a12f2cee@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 09/01/2020 21:13, Alban Gruin wrote:
> Hi Phillip,
> 
> Le 09/12/2019 à 17:00, Phillip Wood a écrit :
>>>> diff --git a/rebase-interactive.c b/rebase-interactive.c
>>>> index ad5dd49c31..80b6a2e7a6 100644
>>>> --- a/rebase-interactive.c
>>>> +++ b/rebase-interactive.c
>>>> @@ -97,7 +97,8 @@ int edit_todo_list(struct repository *r, struct
>>>> todo_list *todo_list,
>>>>               struct todo_list *new_todo, const char *shortrevisions,
>>>>               const char *shortonto, unsigned flags)
>>>>    {
>>>> -    const char *todo_file = rebase_path_todo();
>>>> +    const char *todo_file = rebase_path_todo(),
>>>> +        *todo_backup = rebase_path_todo_backup();
>>>>        /* If the user is editing the todo list, we first try to parse
>>>> @@ -110,9 +111,9 @@ int edit_todo_list(struct repository *r, struct
>>>> todo_list *todo_list,
>>>>                        -1, flags | TODO_LIST_SHORTEN_IDS |
>>>> TODO_LIST_APPEND_TODO_HELP))
>>>>            return error_errno(_("could not write '%s'"), todo_file);
>>>>    -    if (initial && copy_file(rebase_path_todo_backup(), todo_file,
>>>> 0666))
>>>> -        return error(_("could not copy '%s' to '%s'."), todo_file,
>>>> -                 rebase_path_todo_backup());
>>>> +    unlink(todo_backup);
>>>> +    if (copy_file(todo_backup, todo_file, 0666))
>>>> +        return error(_("could not copy '%s' to '%s'."), todo_file,
>>>> todo_backup);
>>>
>>> We used to copy ONLY when initial is set and we left old todo_backup
>>> intact when !initial.  That is no longer true after this change, but
>>> it is intended---we create an exact copy of what we would hand out
>>> to the end-user, so that we can compare it with the edited result
>>> to figure out what got changed.
>>
>> I think it would be better to only create a new copy if the last edit
>> was successful. As it stands if I edit the todo list and accidentally
>> delete some lines and then edit the todo list again to try and fix it
>> the second edit will succeed whether or not I reinserted the deleted lines.
>>
>> We could add this to the tests to check that a subsequent edit that does
>> not fix the problem fails
>>
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 969e12d281..8544d8ab2c 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>>
>> @@ -1416,6 +1416,7 @@ test_expect_success 'rebase --edit-todo respects
>> rebase.missingCommitsCheck = er
>>                  test_i18ncmp expect actual &&
>>                  test_must_fail git rebase --continue 2>actual &&
>>                  test_i18ncmp expect actual &&
>> +               test_must_fail git rebase --edit-todo &&
>>                  cp orig .git/rebase-merge/git-rebase-todo &&
>>                  test_must_fail env FAKE_LINES="1 2 3 4" \
>>                          git rebase --edit-todo 2>actual &&
>>
>>
> 
> In which case, if the check did not pass at the previous edit, the new
> todo list should be compared to the backup.  As sequencer_continue()
> already does this, extract this to its own function in
> rebase-interactive.c.  To keep track of this, a file is created on the
> disk (as you suggested in your other email.)  At the next edit, if this
> file exists and no errors were found, it is deleted.  The backup is only
> created if there is no errors in `todo_list' and in `new_todo'.
> 
> This would guarantee that there is no errors in the backup, and that the
> edited list is always compared to a list exempt of errors.
> 
> This approach also has the benefit to detect if a commit part of a
> badcmd was dropped.
> 
> After some tweaks (ie. `expect' now lists 2 commits instead of one),
> this passes the test with the change you suggested, and the one you sent
> in your other email.

That sounds good. I'm not sure how it passes the test in my other email 
though, if sequencer_continue() compares the todo list to the backup 
wont it still fail when continuing after conflicts as the backup is out 
of date?

Best Wishes

Phillip


>>>
>>> We unlink(2) unconditionally because the only effect we want to see
>>> here is that todo_backup does not exist before we call copy_file()
>>> that wants to do O_CREAT|O_EXCL.  I wonder if we want to avoid
>>> unlink() when initial, and also if we want to do unlink_or_warn()
>>> when !initial (read: this is just "wondering" without thinking long
>>> enough to suggest that doing so would be better)
>>>
>>>> diff --git a/t/t3404-rebase-interactive.sh
>>>> b/t/t3404-rebase-interactive.sh
>>>> index 29a35840ed..9051c1e11d 100755
>>>> --- a/t/t3404-rebase-interactive.sh
>>>> +++ b/t/t3404-rebase-interactive.sh
>>>> @@ -1343,6 +1343,89 @@ test_expect_success 'rebase -i respects
>>>> rebase.missingCommitsCheck = error' '
>>>>        test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>>>>    '
>>>>    +test_expect_success 'rebase --edit-todo respects
>>>> rebase.missingCommitsCheck = ignore' '
>>>> +    test_config rebase.missingCommitsCheck ignore &&
>>>> +    rebase_setup_and_clean missing-commit &&
>>>> +    set_fake_editor &&
>>>> +    FAKE_LINES="break 1 2 3 4 5" git rebase -i --root &&
>>>> +    FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual &&
>>>
>>> OK, so we lost "pick 5" but with missing-check disabled, that should
>>> not trigger any annoying warning or error.
>>>
>>>> +    git rebase --continue 2>actual &&
>>
>> This clobbers actual which hasn't been used yet
>>
> 
> Good catch.
> 
>>>> +    test D = $(git cat-file commit HEAD | sed -ne \$p) &&
>>>
>>>> +    test_i18ngrep \
>>>> +        "Successfully rebased and updated refs/heads/missing-commit" \
>>>> +        actual
>>>> +'
>>>> +
>>>> +test_expect_success 'rebase --edit-todo respects
>>>> rebase.missingCommitsCheck = warn' '
>>>> +    cat >expect <<-EOF &&
>>>> +    error: invalid line 1: badcmd $(git rev-list --pretty=oneline
>>>> --abbrev-commit -1 master~4)
>>>> +    Warning: some commits may have been dropped accidentally.
>>>> +    Dropped commits (newer to older):
>>>> +     - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
>>>> +    To avoid this message, use "drop" to explicitly remove a commit.
>>>> +    EOF
>>>> +    tail -n4 expect >expect.2 &&
>>>> +    test_config rebase.missingCommitsCheck warn &&
>>>> +    rebase_setup_and_clean missing-commit &&
>>>> +    set_fake_editor &&
>>>> +    test_must_fail env FAKE_LINES="bad 1 2 3 4 5" \
>>>> +        git rebase -i --root &&
>>>> +    cp .git/rebase-merge/git-rebase-todo.backup orig &&
>>>> +    FAKE_LINES="2 3 4" git rebase --edit-todo 2>actual.2 &&
>>>> +    head -n5 actual.2 >actual &&
>>>> +    test_i18ncmp expect actual &&
>>>
>>> OK, so we lost "pick 1" while discarding "bad", and we should notice
>>> the lossage?  I see "head -n5" there, which means we are still
>>> getting "invalid line 1: badcmd", even though FAKE_LINES now got rid
>>> of "bad"?  Puzzled...
>>
>> Is the bad there to stop the rebase so we can edit the todo list? If so
>> it would be better to use 'break' instead.
>>
> 
> No, it was here to show that we can detect dropped commits, even if the
> todo list has an error.
> 
>> Best Wishes
>>
>> Phillip
> 
> Cheers,
> Alban
> 
