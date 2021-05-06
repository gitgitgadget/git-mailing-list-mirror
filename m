Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A970C43460
	for <git@archiver.kernel.org>; Thu,  6 May 2021 14:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F6861176
	for <git@archiver.kernel.org>; Thu,  6 May 2021 14:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhEFOam (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 10:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbhEFOam (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 10:30:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F1BC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 07:29:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z9so8049703lfu.8
        for <git@vger.kernel.org>; Thu, 06 May 2021 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=p+FRE4hnOKacTK6W/+YrNpWQeZmf+gE9l1IOESsbgCc=;
        b=U5zb18qrZiC6/lVqZrBCD7cFiuuccOYTKR5viGYuVCdQge8+6RJIaaj37J5gGED22U
         6XqOyxMSMy4sGDCRqXrSVlMhHepCZFQhW4ZBb2NMStR+ROj9CQS2wEJDd4jvuwjlrCpO
         7T8Zcq8fvspYU3ooDBFeRD34bWZtBwFzNmLc5BBdSfxzt3ey4Dj2MX3FbsNIA/yl3P4h
         fPNb3WtddgJO15mq/c2/Lhp3+XyYWVZkjh5ddEUnF5MYbtbZb2U+iv1q+A7BBrA4u0bu
         ofwvoszN4JUdMpnxxna5/DaFvJdNB+lrov0EuCfe3WZl42XxpEjA6ErvEbJLavlGYZOr
         dSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=p+FRE4hnOKacTK6W/+YrNpWQeZmf+gE9l1IOESsbgCc=;
        b=VYcDAOn8Ta+cuSsSF4YH3lHCa4q5wtrFKSXloBAjwjG2YOuGf4wpXJy7xJ6Asw2wSI
         n3cnNHCC6kAQJCN9OAkxiJnxRT5QGUyee7/2iGxa3iSjcMULGdIWUkulpO+5VNP/qKnJ
         sB5iSXq4FMo7XSDgp6/e7hJMrViu7qtMDh4B1s3c81FqZknioKphZm9u65CLDntYy3rY
         06vfZwS1veTZXRA2zBUPB8CQVo1ZnUdhPUZlolf3ITTzPiAV6Bcjtnlt1UsKzFgFJHR2
         dTsikSmDm3Pjg3Hia9XyGbEwZcXgDXbUQ3N6+t/YnKDslvY65sxUtMB/aOmj1vFIbaSD
         17GA==
X-Gm-Message-State: AOAM533UjDDVa9PkgOgTRJvAoUmOaRczuBUcfKsZ9pIcx0fkpRwFpgzR
        F99A5wXQBa1a6FGskDR14zp/uFU24NI=
X-Google-Smtp-Source: ABdhPJxrl4pufE52fn+MInTBP+jt3awHh0CjYuwySIS4rOsfMrHWuU9SvcYTq2drL3B7Bk0R2ffk3A==
X-Received: by 2002:a19:50d:: with SMTP id 13mr2994144lff.443.1620311381079;
        Thu, 06 May 2021 07:29:41 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b27sm709746lfo.28.2021.05.06.07.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 07:29:40 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?G=C3=A1bor?= Farkas <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git switch/restore, still experimental?
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
        <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
        <877dkdwgfe.fsf@evledraar.gmail.com> <87sg3155dt.fsf@osv.gnss.ru>
        <87mtt8uqec.fsf@evledraar.gmail.com>
Date:   Thu, 06 May 2021 17:29:39 +0300
In-Reply-To: <87mtt8uqec.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 06 May 2021 12:05:23 +0200")
Message-ID: <87o8doue98.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, May 05 2021, Sergey Organov wrote:
>
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>>> On Tue, May 04 2021, Elijah Newren wrote:
>>>
>>>> On Tue, May 4, 2021 at 3:36 AM Gábor Farkas <gabor.farkas@gmail.com> wrote:
>>>>>
>>>>> hi,
>>>>>
>>>>> the "git switch" and "git restore" commands were released two years
>>>>> ago, but the manpage still says "THIS COMMAND IS EXPERIMENTAL. THE
>>>>> BEHAVIOR MAY CHANGE.".
>>>>>
>>>>> i'd love to use them, but this warning gives me pause, perhaps i
>>>>> should wait until it stops being experimental, i worry that it might
>>>>> change in behavior unexpectedly and cause problems for me.
>>>>>
>>>>> considering that they were released two years ago, could the
>>>>> experimental-warning be removed now?
>>>>>
>>>>> thanks,
>>>>> gabor
>>>>
>>>> This probably makes sense.  The author of switch and restore isn't
>>>> involved in the git project anymore.  He decided to work on other
>>>> things, which was and is a big loss for us.  I think others (myself
>>>> included) didn't know all the things that might have been in Duy's
>>>> head that he wanted to verify were working well before marking this as
>>>> good, but these two commands have generally been very well received
>>>> and it has been a few years.  Personally, I'm not aware of anything
>>>> that we'd need or want to change with these commands.
>>>
>>> I am.
>>>
>>
>> [...]
>>
>>> And:
>>>
>>>    # Moves a branch (or -M for --force)
>>>    git branch -m old new
>>>
>>> That last one we can't have either because "switch" squats on "-m" for
>>> "--merge", which I daresay is a much more obscure use-case not deserving
>>> of a short option than "rename and switch to".
>>
>> Isn't --merge a different (and inferior) way to achieve what we already
>> have elsewhere with --autostash? Does it make sense to get rid of --merge
>> here in favor of --autostash?
>
> Probably, I haven't used the --merge option ever I think. Switching with
> dirty worktrees isn't really how I work.
>
> But to the extent that I've ever tried / run into errors with that I'd
> think that an option like --merge or --autostash is mostly a result of
> us being overzealous about "is_dirty() && die()" checks. E.g. rebase (at
> least a while ago, still) would refuse to rebase with a dirty tree, even
> though the path in question had nothing to do with paths that would be
> touched by the rebase.

Unfortunately, this will never solve the problem entirely. Global
autostash mode probably will, more chances if stash will save/restore
exact state of everything when applied to the original base.

>
> I suspect that much of the need for these sorts of options would go away
> with those checks being smarter, but it's separate from the "should we
> squat on -m" discussion...

It is not entirely separate. If --merge goes away, there will be no
"squat on -m" anymore.

Personally, I'd just turn on global autostash mode if it were available,
and forget about both --merge and --autostash, for the better.

Thanks,
-- Sergey Organov
