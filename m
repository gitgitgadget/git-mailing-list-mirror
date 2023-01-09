Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF3CC61DB3
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 18:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbjAISXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 13:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbjAISXG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 13:23:06 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDCC13FB2
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 10:22:12 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v14so8550514qtq.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 10:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:subject:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zq31iyksmvFfU0GQdsCDsE28SWt+7FUE7PT0pVwidtk=;
        b=eOdkxKC5WV7X4EE7EU7T0/CNXIuXOWR3xgEckNB3RC1rP72KiXab/i5by8Q2gA1wdW
         5aPBcNqPVwnNkBwKjUTAalhffR4fs0rgKaAoVf1JLEHEkYIVYDFgTfK9tQXGqxs+xLpf
         LmUOOx4+QGevDe0udFOWR60K3gbEeFbMG8sQgCQ16OF93Ye0/PWZk/s5r0/kGkjvHHZ6
         Z5lSSuQUd/1qSA5Fpw45cqCK6EsTnWNIKhFOPH3g3A2VvwNZOAiZ2I774N9cAPYAms9/
         e8FSZxepGxEo1plj7Wy1kQY6FDWy3TbA99pMC39JDCUzknojUt0/RwTdurccvfamrRLt
         lbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:subject:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zq31iyksmvFfU0GQdsCDsE28SWt+7FUE7PT0pVwidtk=;
        b=tFP5VkWK4TrOF4vx80hZ58LFgr/mKqLch/p5GyV667ARv85+y8kx1GCuaKJr4HRnQi
         bmFp7xTYIyHrKqnQ0FvRT6YU2JPYiV664tL5LST1lxGbITVHhPEIYtW+Souhb/1dee11
         X60/opxQfdOt5+1DLslv8AGvrFLnPtYQoXoXwEHQ1+GG96L4nuiChnENyubMR5HqDBnM
         4tqHF1S322GhOsWpd3GRJtJD4z2SCYepAnLcJ4yrMp8n3RRNEGEJiktbOnhPu2sdczOl
         C6hTcyO6kJDlU1DrgV6A/kFDPVj0SlseAlkRulXHS7OWyDyMg+F537U0N08lxOXhaXpl
         0+Fg==
X-Gm-Message-State: AFqh2kokx0QgZQYl91tfdPyan84oQyC1ZLSxXo+GghMhyfTQ90zO7iEM
        rO0Agsugm8QvsPZHnKc+y2U=
X-Google-Smtp-Source: AMrXdXurs1lNubOq/TQJfpk3i49yFvc569wWNlvN67wnMC2aJNDC5WtUmcLeh5nWhRqnu+h1W+g8ug==
X-Received: by 2002:ac8:7ca6:0:b0:3a8:30f8:bc13 with SMTP id z6-20020ac87ca6000000b003a830f8bc13mr88902207qtv.44.1673288531771;
        Mon, 09 Jan 2023 10:22:11 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id c8-20020ac80548000000b003972790deb9sm4870590qth.84.2023.01.09.10.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 10:22:11 -0800 (PST)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 5/5] git-rebase.txt: add a note about 'ORIG_HEAD' being
 overwritten
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
 <9ef427a9a2adfb6a47d13103f00a64df96725560.1673120359.git.gitgitgadget@gmail.com>
 <xmqq4jt122k2.fsf@gitster.g>
Message-ID: <85da5311-bef6-88d9-850d-888d874f6988@gmail.com>
Date:   Mon, 9 Jan 2023 13:22:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq4jt122k2.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2023-01-07 à 21:16, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> 'ORIG_HEAD' is written at the start of the rebase, but is not guaranteed
>> to still point to the original branch tip at the end of the rebase.
>>
>> Indeed, using other commands that write 'ORIG_HEAD' during the rebase,
>> like splitting a commit using 'git reset HEAD^', will lead to 'ORIG_HEAD'
>> being overwritten.
> 
> Is that a news?  If a user does "reset", the user is asking that
> HEAD is changed and the old state kept in ORIG_HEAD at the same
> time, so while it is not wrong per-se to say that user can clobber
> ORIG_HEAD after rebase sets it first, it is pretty much expected,
> no?

I forgot to add a link to the mailing list thread and just added a Reported-by
trailer here, but it was not expected by at least 2 users (including me) [1].

[1] https://lore.kernel.org/git/28ebf03b-e8bb-3769-556b-c9db17e43dbb@gmail.com/T/#m827179c5adcfb504d67f76d03c8e6942b55e5ed0

I think of 'git reset HEAD^' during a rebase, to split a existing commit,
as rebase-related operation (it could almost be a different instruction in the TODO
list), and so my expectation was that ORIG_HEAD at the end of the rebase would
not be changed by what I did during the rebase.

But I can see how it would be confusing for people that would expect ORIG_HEAD
to point to the pre-reset HEAD, and so I just thought I'd point that out in the 
doc to avoid potential future confusion.

> 
> What would be unexpected is if "rebase" overwrote ORIG_HEAD after
> user did all these other things while it gave control back and then
> it took control back, and it would be worth documenting.
> 
> Having said that, I do not mind documenting this.  I am not sure "is
> not guaranteed" is a good way to phrase what happens, though.

I use that phrasing because the 'gitrevisions' entry on 'ORIG_HEAD' says:


  `ORIG_HEAD` is created by commands that move your `HEAD` in a drastic
  way ([...]),
  to record the position of the `HEAD` before their operation, so that
  you can easily change the tip of the branch back to the state before you ran
  them.

so it might be read to mean that 'ORIG_HEAD' always points to the pre-operation
state. I'm open to other wording, though.

> 
>> +[NOTE]
>> +`ORIG_HEAD` is not guaranteed to still point to the previous branch tip
>> +at the end of the rebase if other commands that write that pseudo-ref
>> +(e.g. `git reset`) are used during the rebase. The previous branch tip,
>> +however, is accessible using the reflog of the current branch
>> +(i.e. `@{1}`, see linkgit:gitrevisions[7]).
> 
>     `ORIG_HEAD` is set to point at the tip of the previous branch
>     when `rebase` begins, but the user can run commands (e.g. "git
>     reset") that overwrites `ORIG_HEAD` while `rebase` gives control
>     to the user (e.g. while asking to resolve conflict).
> 
> It is excellent to mention reflog, which is very much an upward
> compatible replacement of ORIG_HEAD.
> 
> Thanks.
> 

Thanks, I'll consider that wording for v2.

Cheers,

Philippe.
