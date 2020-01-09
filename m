Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999E7C282DD
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 21:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A3F2073A
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 21:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyeBTnZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgAIVOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:14:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33809 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgAIVOU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 16:14:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id w5so2925351wmi.1
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 13:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=07qxuDb3cwC+VzAEedBG/G0ofjUpP9H6hB8Mz9C6kCA=;
        b=lyeBTnZ1DBNdvOhrEz4rcwFjHWrDYk9v8CmdMLoEU5EsJIxf2nD65ZfEEwM6VJlcfl
         d2Kgymtv6ljsgVbKdbRfSURs9GhfRIR6HiYUryc756ymGL/s3zaj01xLuQ58tLxuRZDI
         rRyz5OH6b37fe5iIUY5H6MTOk51rEjqrYllVSFdLwFLL78bpep3Hxp8tlnetKsleRc/J
         Q5rTdpThpn4cvAiu45CdR2Iv4YFUdrL2vmVnj4wIy2NqTYdyh639v2AkIZzitOKvPEXU
         9coh/55ZFdcuYKJ7YlSwkkByrA43w0V2muXtcVu+IYg9scaXCl0TMY7+WEXsjO0Ye8+l
         qmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=07qxuDb3cwC+VzAEedBG/G0ofjUpP9H6hB8Mz9C6kCA=;
        b=KKfLFatMl84838TxtdTZVfd3Hc6SHLnmun90r/iGJvTwfpVGaUNPi1k68ui6EQgqpW
         LDk+gOUgiaEEPWJGGKEMfJ/WJ9MF9uEpOFSGObvnWurfmNHQa6YFT2iixP+H0A3MYYxa
         /OrzSkxCWlem29mlS5wdbP+x28XTQcvo6faOt6qiBUlRSvQRor6lFj/RMtMr1qjnXEZ7
         oovOf28sNCQQKkieWyOgS57ZRauz8pDeQES7M2iqBpQYqQw3pdp5BtwwjopCe1karc4c
         Y/zpmriHs6ubaY+PE8PIIotOS+jbRh78bSAd0dRLuKJbqDvPFmpafbYDDMdb495MUcp2
         uDZg==
X-Gm-Message-State: APjAAAUG58obJRCi9RSfC9xTysLo4VeAvb/5uowdFpm377bT2zYuq3Fe
        e7JL13flgOyMBFQFRwznu4Y=
X-Google-Smtp-Source: APXvYqyKshTGK7RtvSIFcTESKYgk71rAkIbaIdKwaG36HMY3Lj+jkWvd/xI20UPSNHLBRxgtmeIPlQ==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr6817384wmj.117.1578604456782;
        Thu, 09 Jan 2020 13:14:16 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-178-91.w86-199.abo.wanadoo.fr. [86.199.165.91])
        by smtp.gmail.com with ESMTPSA id k11sm4083128wmc.20.2020.01.09.13.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 13:14:16 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
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
Openpgp: preference=signencrypt
Message-ID: <0bf602bb-eff0-12f1-fa6c-c670a12f2cee@gmail.com>
Date:   Thu, 9 Jan 2020 22:13:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <64aa4049-ee35-df4c-1e6c-80707f4f9070@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 09/12/2019 à 17:00, Phillip Wood a écrit :
>>> diff --git a/rebase-interactive.c b/rebase-interactive.c
>>> index ad5dd49c31..80b6a2e7a6 100644
>>> --- a/rebase-interactive.c
>>> +++ b/rebase-interactive.c
>>> @@ -97,7 +97,8 @@ int edit_todo_list(struct repository *r, struct
>>> todo_list *todo_list,
>>>              struct todo_list *new_todo, const char *shortrevisions,
>>>              const char *shortonto, unsigned flags)
>>>   {
>>> -    const char *todo_file = rebase_path_todo();
>>> +    const char *todo_file = rebase_path_todo(),
>>> +        *todo_backup = rebase_path_todo_backup();
>>>       /* If the user is editing the todo list, we first try to parse
>>> @@ -110,9 +111,9 @@ int edit_todo_list(struct repository *r, struct
>>> todo_list *todo_list,
>>>                       -1, flags | TODO_LIST_SHORTEN_IDS |
>>> TODO_LIST_APPEND_TODO_HELP))
>>>           return error_errno(_("could not write '%s'"), todo_file);
>>>   -    if (initial && copy_file(rebase_path_todo_backup(), todo_file,
>>> 0666))
>>> -        return error(_("could not copy '%s' to '%s'."), todo_file,
>>> -                 rebase_path_todo_backup());
>>> +    unlink(todo_backup);
>>> +    if (copy_file(todo_backup, todo_file, 0666))
>>> +        return error(_("could not copy '%s' to '%s'."), todo_file,
>>> todo_backup);
>>
>> We used to copy ONLY when initial is set and we left old todo_backup
>> intact when !initial.  That is no longer true after this change, but
>> it is intended---we create an exact copy of what we would hand out
>> to the end-user, so that we can compare it with the edited result
>> to figure out what got changed.
> 
> I think it would be better to only create a new copy if the last edit
> was successful. As it stands if I edit the todo list and accidentally
> delete some lines and then edit the todo list again to try and fix it
> the second edit will succeed whether or not I reinserted the deleted lines.
> 
> We could add this to the tests to check that a subsequent edit that does
> not fix the problem fails
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 969e12d281..8544d8ab2c 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> 
> @@ -1416,6 +1416,7 @@ test_expect_success 'rebase --edit-todo respects
> rebase.missingCommitsCheck = er
>                 test_i18ncmp expect actual &&
>                 test_must_fail git rebase --continue 2>actual &&
>                 test_i18ncmp expect actual &&
> +               test_must_fail git rebase --edit-todo &&
>                 cp orig .git/rebase-merge/git-rebase-todo &&
>                 test_must_fail env FAKE_LINES="1 2 3 4" \
>                         git rebase --edit-todo 2>actual &&
> 
> 

In which case, if the check did not pass at the previous edit, the new
todo list should be compared to the backup.  As sequencer_continue()
already does this, extract this to its own function in
rebase-interactive.c.  To keep track of this, a file is created on the
disk (as you suggested in your other email.)  At the next edit, if this
file exists and no errors were found, it is deleted.  The backup is only
created if there is no errors in `todo_list' and in `new_todo'.

This would guarantee that there is no errors in the backup, and that the
edited list is always compared to a list exempt of errors.

This approach also has the benefit to detect if a commit part of a
badcmd was dropped.

After some tweaks (ie. `expect' now lists 2 commits instead of one),
this passes the test with the change you suggested, and the one you sent
in your other email.


>>
>> We unlink(2) unconditionally because the only effect we want to see
>> here is that todo_backup does not exist before we call copy_file()
>> that wants to do O_CREAT|O_EXCL.  I wonder if we want to avoid
>> unlink() when initial, and also if we want to do unlink_or_warn()
>> when !initial (read: this is just "wondering" without thinking long
>> enough to suggest that doing so would be better)
>>
>>> diff --git a/t/t3404-rebase-interactive.sh
>>> b/t/t3404-rebase-interactive.sh
>>> index 29a35840ed..9051c1e11d 100755
>>> --- a/t/t3404-rebase-interactive.sh
>>> +++ b/t/t3404-rebase-interactive.sh
>>> @@ -1343,6 +1343,89 @@ test_expect_success 'rebase -i respects
>>> rebase.missingCommitsCheck = error' '
>>>       test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>>>   '
>>>   +test_expect_success 'rebase --edit-todo respects
>>> rebase.missingCommitsCheck = ignore' '
>>> +    test_config rebase.missingCommitsCheck ignore &&
>>> +    rebase_setup_and_clean missing-commit &&
>>> +    set_fake_editor &&
>>> +    FAKE_LINES="break 1 2 3 4 5" git rebase -i --root &&
>>> +    FAKE_LINES="1 2 3 4" git rebase --edit-todo 2>actual &&
>>
>> OK, so we lost "pick 5" but with missing-check disabled, that should
>> not trigger any annoying warning or error.
>>
>>> +    git rebase --continue 2>actual &&
> 
> This clobbers actual which hasn't been used yet
> 

Good catch.

>>> +    test D = $(git cat-file commit HEAD | sed -ne \$p) &&
>>
>>> +    test_i18ngrep \
>>> +        "Successfully rebased and updated refs/heads/missing-commit" \
>>> +        actual
>>> +'
>>> +
>>> +test_expect_success 'rebase --edit-todo respects
>>> rebase.missingCommitsCheck = warn' '
>>> +    cat >expect <<-EOF &&
>>> +    error: invalid line 1: badcmd $(git rev-list --pretty=oneline
>>> --abbrev-commit -1 master~4)
>>> +    Warning: some commits may have been dropped accidentally.
>>> +    Dropped commits (newer to older):
>>> +     - $(git rev-list --pretty=oneline --abbrev-commit -1 master)
>>> +    To avoid this message, use "drop" to explicitly remove a commit.
>>> +    EOF
>>> +    tail -n4 expect >expect.2 &&
>>> +    test_config rebase.missingCommitsCheck warn &&
>>> +    rebase_setup_and_clean missing-commit &&
>>> +    set_fake_editor &&
>>> +    test_must_fail env FAKE_LINES="bad 1 2 3 4 5" \
>>> +        git rebase -i --root &&
>>> +    cp .git/rebase-merge/git-rebase-todo.backup orig &&
>>> +    FAKE_LINES="2 3 4" git rebase --edit-todo 2>actual.2 &&
>>> +    head -n5 actual.2 >actual &&
>>> +    test_i18ncmp expect actual &&
>>
>> OK, so we lost "pick 1" while discarding "bad", and we should notice
>> the lossage?  I see "head -n5" there, which means we are still
>> getting "invalid line 1: badcmd", even though FAKE_LINES now got rid
>> of "bad"?  Puzzled...
> 
> Is the bad there to stop the rebase so we can edit the todo list? If so
> it would be better to use 'break' instead.
> 

No, it was here to show that we can detect dropped commits, even if the
todo list has an error.

> Best Wishes
> 
> Phillip

Cheers,
Alban

