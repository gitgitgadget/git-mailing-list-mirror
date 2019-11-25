Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0121BC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 16:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DF72068E
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 16:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju4CsuNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfKYQmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:42:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42181 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfKYQmL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 11:42:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so18952549wrf.9
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 08:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mogzNAQD2mmoOoW/VgfZfb7gARdm565YWxHYS6nRyAE=;
        b=ju4CsuNKyAVmfhpownr9MFtUerDglgdOwOEJX9LebXo/oZTB8qilNnWQyTTx3HVpys
         R54Aj65C8qgGGk3v84PWECFC9AjJxIz3J5n7NvGfb21AngWZEFUZXaCTV7FUIy0KcO9F
         /cA6psd1MVACwELDPaJ66cpLXcKmz+iBQ2Ud7ocpmpcnqmxN/xFK4FM4Z6fihxPC8id4
         NG2Q2S6NIDm7yi6rkEsgK7eVeaPrtJbRhpUBARlLPdMd31W/G0YLjGmf/+QhgEAnEUk0
         wUAEKHXU5oIA92n8HWgWrEi3xG6/Ufglzk3akurDjS9nnNITnJWPiNsTOwPJcdv8uJ8t
         WEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mogzNAQD2mmoOoW/VgfZfb7gARdm565YWxHYS6nRyAE=;
        b=QPYYH7mL1D1mdqPEnB8gKU7U+3zly5BIyFVY6z3tGWLOBp6mH5c3v3Kyl4ABIOQ6wa
         AOe+BL4O8veeIMf/3IbpoEjo8joU5A+TYaolFjcHPidbAHudcaofB7Xfmq2jiFkJneRG
         A+pOXpGBQh1xiUKbGCsn81CmSBsCfdf2OSaSbFwKfB/n7jTZfA7TqkeizBuyZ3IQ4L0T
         rGdHrFhWGht6I45zmEW1eAieKxaqGeKp+7DODUsZ68+dVhv4iOVAZ/l5OBoNQmD5uVoc
         gwJCUHmsBQOeap0MBQk+l9pfQeRDXj/eZG2RO/tgdEbR17zXzivM3QY+O/6EAGG5gL28
         fmiA==
X-Gm-Message-State: APjAAAUrx5wAUb+STeO5jhjZjYMbHCvQT5QSaVfm8ZeY9uNnZ2JZL0Es
        6M/ay7jw3kPCDHzD4ohQ/f/ZvfB/
X-Google-Smtp-Source: APXvYqyv0VUX3L4fnoapIM2fKYKnkGYOKFYLJFtm0VQS1wdLTG6oQE5vDCxe0xKxI2TV/YsnKYIQWg==
X-Received: by 2002:adf:a119:: with SMTP id o25mr34620072wro.74.1574700128766;
        Mon, 25 Nov 2019 08:42:08 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-28-211.as13285.net. [92.22.28.211])
        by smtp.gmail.com with ESMTPSA id a6sm439079wmb.1.2019.11.25.08.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 08:42:08 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] sequencer: fix empty commit check when amending
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
 <pull.467.v2.git.1574451783.gitgitgadget@gmail.com>
 <037f2b2975e06847443aef46939e3c712053dedf.1574451783.git.gitgitgadget@gmail.com>
 <xmqq5zjb2vsx.fsf@gitster-ct.c.googlers.com>
 <340859a7-5cc4-f641-818d-fcedbf29a2a6@gmail.com>
 <94573071-556b-caae-b159-40c168a08f44@gmail.com>
 <xmqqr21wy80o.fsf@gitster-ct.c.googlers.com>
 <43bdadd2-9ea9-4e50-1f47-ec18e0db4794@gmail.com>
 <nycvar.QRO.7.76.6.1911251652510.31080@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <cb0748e9-5eb1-3ed5-a4bd-94eb540076bc@gmail.com>
Date:   Mon, 25 Nov 2019 16:42:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1911251652510.31080@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 25/11/2019 15:53, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Mon, 25 Nov 2019, Phillip Wood wrote:
> 
>> On 25/11/2019 03:00, Junio C Hamano wrote:
>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>
>>>> We do actually check that there is a valid HEAD before we try to fixup
>>>> a commit. Though perhaps we should still change this patch as HEAD may
>>>> be changed by another process between that check and re-reading it
>>>> here. If you try to fixup a commit without a valid HEAD you get
>>>>
>>>> error: need a HEAD to fixup
>>>> hint: Could not execute the todo command
>>>> hint:
>>>> hint:     fixup faef1a5a7637ff91b3611aabd1b96541da5f5536 P
>>>> hint:
>>>> hint: It has been rescheduled; To edit the command before continuing,
>>>> hint: please
>>>> hint: edit the todo list first:
>>>> hint:
>>>> hint:     git rebase --edit-todo
>>>> hint:     git rebase --continue
>>>> error: could not copy '.git/rebase-merge/message-squash' to
>>>> '.git/rebase-merge/message'
>>>>
>>>> The last error message is unfortunate but we do exit in an orderly
>>>> manner rather than segfaulting.
>>>
>>> Thanks for thinking about the issue further.
>>>
>>>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>>>> index d2f1d5bd23..4f55f0cd1c 100755
>>>> --- a/t/t3404-rebase-interactive.sh
>>>> +++ b/t/t3404-rebase-interactive.sh
>>>> @@ -67,6 +67,21 @@ test_expect_success 'setup' '
>>>>    SHELL=
>>>>    export SHELL
>>>>
>>>> +test_expect_success 'fixup on orphan branch errors out' '
>>>> +
>>>> +       test_when_finished "git switch master" &&
>>>> +       write_script switch-branch.sh <<-\EOF &&
>>>> +       git symbolic-ref HEAD refs/heads/does-not-exist &&
>>>> +       git rm -rf .
>>>
>>> That "git rm -rf ." scares me, though.
>>
>> I know I'm not too keen on it my self but we need to empty the worktree and
>> index if we're going to switch to an unborn branch
> 
> How about `git worktree --orphan does-not-exist unborn`?

I'm trying to create the unborn branch in the current worktree as that 
is where the rebase is happening

Best Wishes

Phillip

> 
> Ciao,
> Dscho
> 
