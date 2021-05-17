Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6CEC43461
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5033061244
	for <git@archiver.kernel.org>; Mon, 17 May 2021 12:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbhEQMek (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 08:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbhEQMej (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 08:34:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC138C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:33:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id v8so3554083lft.8
        for <git@vger.kernel.org>; Mon, 17 May 2021 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bol2Wv9vzOLU0EQ9pJyEim3EAHl/BdrC+BH+1rktFZw=;
        b=auuzmP+3VuadHjANtdMHsT3gOgCQJBIyjqfYac62Vu8rTO1KLQnuYPUjWs6r/OsZX1
         8l+64XXPr6Lr43J/LWVhSE0lU41HTVrw5WZWCiPnwfrnWJ8yPiQdXyfJ1JKaRMPk1SSS
         YAlSHrrcQMLugwzDWXcypc8dzFGlD5oSZfIzdGK1OPYEV7KGeBNRh9AHJbqZTPF21+tg
         2q5GtRJS/12C8QEUiFZ/zrZ3zwcvULA3lNlObd9+R363TzMkMtUGtuQvqjZyZvIz8pKF
         EBQ/O7PCg0pnv8311kHZlOdocqfin88fdHavhTzHQfHC0hAcJNxHDb/SNJnLvrv8uPPC
         ykYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=bol2Wv9vzOLU0EQ9pJyEim3EAHl/BdrC+BH+1rktFZw=;
        b=GRVNMsYuhqK+BxJLWo7Kw7Av0z2Gac2Uj2YOYY7oU//xvPWfym2TdyTj93qHcXLmp2
         oAXUwhkHJxPkFF5SbhZoCxcactzZ/K629qdmOBrDjhEqNfHW7Ogtymz9bT+7027Yl3JE
         8Egya6zTU/a5PzHUkca+mvkgtcligHSE7ttex6Rqb775oPKkpoE8YF5gQ79p6UrWpfxE
         oIKzhER0i1HIEBTe0LoNqb5jQQ5+YUtf7vcsLZjOjR/fc53UnUb/CuRrnbGhIwDHaZtu
         IAEAmP4UdvdXwmXiOYkOXPOWw2ApqR4A4k+/ntUjA6k3SfmtMbjvWRxavylsLVh/x2Yc
         rcLg==
X-Gm-Message-State: AOAM5332XSa4/sDiZukvy/fwPPc8vgi/FBuOQBnFoaE39B7GaBmHjnwx
        kG/cmylEGcpo+XIw0BAvGYnmjIffsnY=
X-Google-Smtp-Source: ABdhPJyo+VIm/w/5gYta0UaT4J5LhfcwzH0A8tadGsi5lpkZGVJqAlVrygEviwlWqkv1keIZlFxB5g==
X-Received: by 2002:ac2:5f97:: with SMTP id r23mr6150433lfe.337.1621254800128;
        Mon, 17 May 2021 05:33:20 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h6sm126615lfd.193.2021.05.17.05.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 05:33:19 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Rebase options via git pull
References: <87r1iakbyn.fsf@osv.gnss.ru>
        <CAMMLpeQ8_isyDtP34p+_tEK3JAasfro7dJbVrTVPZ7C4q0kT6w@mail.gmail.com>
        <YJ3LJ++lsAuSkCUJ@danh.dev> <875yzlu8gt.fsf@osv.gnss.ru>
        <87zgwtr7i4.fsf@evledraar.gmail.com>
Date:   Mon, 17 May 2021 15:33:18 +0300
In-Reply-To: <87zgwtr7i4.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 17 May 2021 12:11:39 +0200")
Message-ID: <87k0nxv8tt.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, May 14 2021, Sergey Organov wrote:
>
>> Đoàn Trần Công Danh <congdanhqx@gmail.com> writes:
>>
>>> On 2021-05-13 18:49:03-0600, Alex Henrie <alexhenrie24@gmail.com> wrote:
>>>> On Thu, May 13, 2021 at 7:23 AM Sergey Organov <sorganov@gmail.com> wrote:
>>>> >
>>>> > Hello,
>>>> >
>>>> > Is there a way to specify additional options for "git rebase" when it's
>>>> > invoked via:
>>>> >
>>>> >   git pull --rebase
>>>> >
>>>> > ? What if rebase is used implicitly due to "pull.rebase" being set
>>>> > accordingly?
>>>> >
>>>> > In particular, I'd like to be able to:
>>>> >
>>>> >   git pull --rebase --no-fork-point
>>>> >
>>>> > but it doesn't work.
>>>> 
>>>> It would be cumbersome, but you could run `git config rebase.forkPoint
>>>> false` before pulling and `git config rebase.forkPoint true` after.
>>>
>>> Or, for this *specific* case:
>>>
>>> 	git -c rebase.forkpoint=false pull --rebase
>>
>> That's nice, thanks! Doesn't solve entire issue, but definitely better
>> than nothing.
>>
>> Probably add generic cmd.<cmd>.opts config support, so that I can say:
>>
>>   git -c cmd.rebase.opts="--no-fork-point --empty=keep" pull --rebase
>>
>> Thoughts?
>
> It's been discussed before (but I did not dig up the discussions,
> sorry). It's been considered a bad idea, because our commands are a
> mixture of plumbing/porcelain commands and switches, so we want to be
> able to reliably invoke say ls-tree with some switches internally,
> without config tripping us up.
>
> Of course we could make this sort of thing work by selectively ignoring
> the config, but such a thing would be equal in complexity to the effort
> of assering that it's safe to introduce new rebase.* config in the
> codebase for every switch it has now, but with a less friendly interface
> both for git itself and users.

I don't see much complexity here. We'd then just need to effectively
invoke ls-tree internally like this:

   git -c 'cmd.ls-tree.opts=' ls-tree

Not a big deal.

>
> I.e. instead of rebase.noForkPoint=<bool> we'd need to to getopt parsing
> on some cmd.rebase.opts string.

As this is meant to be generic, then yes, every command will first parse
corresponding config option, then command-line options, rebase not being
any different.

>
> I don't see why in this case what I suggested elsewhere in the thread
> wouldn't be viable, i.e. you specify --rebase or --merge to "pull", and
> that affects how we interpret the rest of the options. I haven't tried
> it though, so there may be hidden gotchas there I haven't thought of.

This is the best solution for "git pull" indeed, but the above is a
generic feature that could provide solution in cases like this, where
immediate specific solution is not (yet) available.

Thanks,
-- Sergey Organov
