Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3350C388F9
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E132222C
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbvXubta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786307AbgJZQog (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:44:36 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:37076 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780057AbgJZQm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 12:42:59 -0400
Received: by mail-wm1-f50.google.com with SMTP id c16so13178328wmd.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 09:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=osHT0fhs3mVNrpFlhp6IrS28bT0kYALeERR+E5EKj0s=;
        b=dbvXubtaucVUQQ1ibSpImkC4FqlmARC+fGecXQzvtAKUha9j27zyO8FKf1Ew2PDzOl
         H6Hsll44rA3uF6VK6Hh7xyng6LcWwE1rizsnMq3yTDmWg3ZPiWnEfK7aD5TcWeUs4gbI
         YoVIsXv5X/ppRVw5gdXLdvLLcOXV1d3zQhEAZ5+JSqPiX6ILWAtR2bMAAn5df+u4nMzQ
         7/rFsb1BzJEcespVEigUw3edpUxzjr/8oUs4bhvCrG8TwO9AxxVkxExv7wv/iB6IZr+r
         1i8XKKfVvOhotovqamXTFIeti2f3fk2alS+Vy+b5dfFEzPX6FDhX6l+lct9Br6i6FVIv
         nczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=osHT0fhs3mVNrpFlhp6IrS28bT0kYALeERR+E5EKj0s=;
        b=lVteUT9XeFugoM0sI/+omPHyxbkm3jP5sXpvorslLH4zb8OPSW6XoAlepo/xg8/4tb
         hXxAl5k4Y+7NyyDhmdBpp0oOuouL3SEUwgefyN3a7iLFn844T6Q/CG5gM3p95wPc9qkC
         AxAsrUQ73wQcsFPuA8Y4KbS4NlYjFn2zMDqqNGHeJM88aabpdj1zxaNH15MDp5Ni0FvZ
         X0doVqEMPN1BrM8WyoQkiK+OlZQNG67CilltvLlj34pQ2BRVy8MuYotp+L9biQQUhmbW
         jM/x4n5IhpP8WAaq9gAaJnu+VG7LWiiaFWz9piaxPhdvbijP/eu5QAhkl9hnQmNlKWmE
         qtlg==
X-Gm-Message-State: AOAM530ZDobc4g7E2cJwWwNLmcVE++wJJGdkxCVmUtMAnu8t3DXasf5o
        PyNVIxTO/RUo3yIMYjaHtmeBsr23utc=
X-Google-Smtp-Source: ABdhPJzQ5FUxT9iPJYySj0eSJTlWYjlxPTbBaGQoF8EVfqBVBE/OBdUcRp88U8NJ3Ok3jBB4yVeeFQ==
X-Received: by 2002:a1c:9a4b:: with SMTP id c72mr16542966wme.157.1603730575696;
        Mon, 26 Oct 2020 09:42:55 -0700 (PDT)
Received: from [192.168.1.240] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.gmail.com with ESMTPSA id e11sm23425428wrj.75.2020.10.26.09.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 09:42:55 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: ORIG_HEAD after rebase is confusing
To:     "herr.kaste" <herr.kaste@gmail.com>
Cc:     git@vger.kernel.org
References: <CAFzd1+62PmHBoVpMw-y4TC=bmc8N0wDpF2jQa7XGz2e+7Dos6A@mail.gmail.com>
 <8bb82be6-dc51-6602-47b5-c849a87ae55e@gmail.com>
 <CAFzd1+7PDg2PZgKw7U0kdepdYuoML9wSN4kofmB_-8NHrbbrHg@mail.gmail.com>
 <CAFzd1+6hLxHk4FDh0d3AFtRLTbGfuQCsXTNCDfjrzBedPuZ-Gg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9c763498-ddb9-5fbf-89d8-61dbcf16cb67@gmail.com>
Date:   Mon, 26 Oct 2020 16:42:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFzd1+6hLxHk4FDh0d3AFtRLTbGfuQCsXTNCDfjrzBedPuZ-Gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Capsar

On 26/10/2020 11:45, herr.kaste wrote:
> Sorry, Phillip not Philipp.
 >
> There is a bug here I think.  The following works as expected, t.i.

Yes there is a bug - we are overwriting a statically allocated buffer 
holding the abbreviated OID, thanks for the reproduction recipe. I've 
got a fix locally, I'll clean it up and post it in the next couple of days.

Best Wishes

Phillip

> `ORIG_HEAD == feature@{1}`.
> 
>      git init
>      git commit --allow-empty -m "Init"
>      git co -b feature
>      git commit --allow-empty -m "A"
>      git commit --allow-empty -m "B"
>      git commit --allow-empty -m "C"
>      git commit --allow-empty -m "D"
>      git commit --allow-empty -m "E"
>      git commit --allow-empty -m "F"
>      git co master
>      git commit --allow-empty -m "X"
>      git co feature
>      git rebase master
>      git rev-parse ORIG_HEAD
>      git rev-parse feature@{1}
> 
> But if you omit commit `F` or both `F` and `E` it doesn't.
> 
> Regards,
> Caspar Duregger
> 
> 
> Am Mo., 26. Okt. 2020 um 12:29 Uhr schrieb herr.kaste <herr.kaste@gmail.com>:
>>
>> Hi Philipp,
>>
>> for whatever reason that doesn't work.  I know the `feature@{1}` trick
>> but hoped just `ORIG_HEAD` would work.  Or maybe it used to work, it's not
>> an everyday command.
>>
>> Following is my test case:
>>
>>      $ git init; git commit --allow-empty -m "Init"
>>      [master (root-commit) 5db5264] Init
>>
>>      c-flo@KLOG MINGW64 /d/rebtest (master)
>>      $ git co -b feature
>>      Switched to a new branch 'feature'
>>
>>      c-flo@KLOG MINGW64 /d/rebtest (feature)
>>      $ git commit --allow-empty -m "A"
>>      [feature 5c7dfb4] A
>>
>>      c-flo@KLOG MINGW64 /d/rebtest (feature)
>>      $ git commit --allow-empty -m "B"
>>      [feature a61bd4c] B
>>
>>      c-flo@KLOG MINGW64 /d/rebtest (feature)
>>      $ git commit --allow-empty -m "C"
>>      [feature 26e6417] C
>>
>>      c-flo@KLOG MINGW64 /d/rebtest (feature)
>>      $ git commit --allow-empty -m "D"
>>      [feature 735e4fb] D
>>
>>      c-flo@KLOG MINGW64 /d/rebtest (feature)
>>      $ git co master
>>      Switched to branch 'master'
>>
>>      c-flo@KLOG MINGW64 /d/rebtest (master)
>>      $ git commit --allow-empty -m "X"
>>      [master 3eb6a3f] X
>>
>>      c-flo@KLOG MINGW64 /d/rebtest (master)
>>      $ git co feature
>>      Switched to branch 'feature'
>>
>>      c-flo@KLOG MINGW64 /d/rebtest (feature)
>>      $ git rev-parse ORIG_HEAD
>>      fatal: ambiguous argument 'ORIG_HEAD': unknown revision or path
>> not in the working tree.
>>      Use '--' to separate paths from revisions, like this:
>>      'git <command> [<revision>...] -- [<file>...]'
>>      ORIG_HEAD
>>
>> Intentional, up to this point I did nothing that sets `ORIG_HEAD`.
>>
>>      c-flo@KLOG MINGW64 /d/rebtest (feature)
>>      $ git rebase master
>>      Successfully rebased and updated refs/heads/feature.
>>
>>      c-flo@KLOG MINGW64 /d/rebtest (feature)
>>      $ git rev-parse ORIG_HEAD
>>      a61bd4c550396ac086879aea829375d839a1667b
>>
>>      c-flo@KLOG MINGW64 /d/rebtest (feature)
>>      $ git rev-parse feature@{1}
>>      735e4fbd14b9ef8b3f2156f1ed90dbde3742d65d
>>
>> So here again, `ORIG_HEAD` points to the original B.  And `feature@{1}`
>> correctly points to the original D.  I obviously did no `rebase --skip`
>> here.  Is there an internal `git --reset` somewhere here I'm missing?
>>
>> Anyhow, you said it should work unless there is an `git --reset` or
>> `--skip` **while** rebasing.  So I guess the relatively declarative
>> usage of `ORIG_HEAD` I'm after, for example `reset ORIG_HEAD`, is error-prone
>> for example if I use `-i --rebase-merges`.
>>
>> That is, I actually wonder if you set `ORIG_HEAD` more at the start of the
>> rebasing work, or basically in the cleanup function of the rebase, e.g. when you
>> delete the `orig-head` file.  It looks like the former, and I assumed
>> the latter.
>>
>>
>> Regards,
>> Caspar Duregger
>>
>> Am Mo., 26. Okt. 2020 um 11:43 Uhr schrieb Phillip Wood
>> <phillip.wood123@gmail.com>:
>>>
>>> Hi Caspar
>>>
>>> On 22/10/2020 21:31, herr.kaste wrote:
>>>> Reading the git rebase manual and some answer on stackoverflow I assumed
>>>> `ORIG_HEAD` will point to the original HEAD, the tip of the branch *before*
>>>> I started rebasing.  But it doesn't seem so.
>>>>
>>>> For example, I have this:
>>>>
>>>>
>>>>     $ git log --graph --all --oneline
>>>>     * 9830f9f (master) X
>>>>     | * fb7b6a6 (HEAD -> feature) D
>>>>     | * 46b7a7a C
>>>>     | * da5e4c7 B
>>>>     | * 5c135da A
>>>>     |/
>>>>     * 6848823 Init
>>>>
>>>>     $ git rebase master
>>>>     Successfully rebased and updated refs/heads/feature.
>>>>
>>>>     $ git rev-parse ORIG_HEAD
>>>>     da5e4c7e9eb3b10c1efa08c534b9c9e4b92d9fd7
>>>>
>>>>     $ git reflog
>>>>     a647bd7 (HEAD -> feature) HEAD@{0}: rebase (finish): returning to
>>>> refs/heads/feature
>>>>     a647bd7 (HEAD -> feature) HEAD@{1}: rebase (pick): D
>>>>     2f458e8 HEAD@{2}: rebase (pick): C
>>>>     0aa2160 HEAD@{3}: rebase (pick): B
>>>>     b957fc7 HEAD@{4}: rebase (pick): A
>>>>     9830f9f (master) HEAD@{5}: rebase (start): checkout master
>>>>     fb7b6a6 HEAD@{6}: checkout: moving from master to feature
>>>>     9830f9f (master) HEAD@{7}: commit: X
>>>>     6848823 HEAD@{8}: checkout: moving from feature to master
>>>>     fb7b6a6 HEAD@{9}: commit: D
>>>>     46b7a7a HEAD@{10}: commit: C
>>>>     da5e4c7 HEAD@{11}: commit: B
>>>>     5c135da HEAD@{12}: commit: A
>>>>     6848823 HEAD@{13}: checkout: moving from master to feature
>>>>     6848823 HEAD@{14}: commit (initial): Init
>>>>
>>>> So `ORIG_HEAD` here points to the original B commit.  (I expected the D.)
>>>
>>> It should be D, unless you ran `git reset` or `git rebase --skip` while
>>> you were rebasing as they also update ORIG_HEAD
>>>
>>>> Honestly, this doesn't make much sense to me in that I don't know *why* it
>>>> even chooses B which is a middle commit in the chain.  (And from reading the
>>>> source `sequencer.c` I can't deduce it either.)
>>>>
>>>>     $ git --version
>>>>     git version 2.29.0.windows.1
>>>>
>>>> What I actually wanted to do was `git reset --hard ORIG_HEAD` fwiw.  And for
>>>> example `git diff HEAD..ORIG_HEAD` to check for unwanted changes after a merge
>>>> conflict.
>>>
>>> After you rebase you can user feature@{1} to get the head of feature
>>> before rebasing (until you make another commit on feature)
>>>
>>> Best Wishes
>>>
>>> Phillip
>>>
>>>> Regards,
>>>> Caspar Duregger
>>>>
>>>
