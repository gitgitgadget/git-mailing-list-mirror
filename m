Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0DDC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 19:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7969560FD7
	for <git@archiver.kernel.org>; Wed,  5 May 2021 19:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhEETtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 15:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhEETtO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 15:49:14 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F745C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 12:48:17 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id v6so4030940ljj.5
        for <git@vger.kernel.org>; Wed, 05 May 2021 12:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7bpvQqhRPlUK4DQw5tpf4WhhlJ4i2AY0YEo3/wGYpRI=;
        b=rnXoApyOzh9yG2vKxN4IIa6bKHOapn/rteLS5nudyWxNNfODdSItw899y7wdyACKzZ
         7HPpM2jrfAxgPLuA97/rlEjzLy9434IFAKQWWLcMoTnw1dbUQ0lbwOVLHWnjCpd9trKX
         zgKKVhP0kpu4crri9vv8vdVEuGOBGpxcK9jV9PmcWnHi5dt2itp7r/h+oKT2pKVwn5IB
         UaGP5ZLuCIzv96tAwgr08/9FANs1eLGm30nM+EOiMxQK+G0f7jEu/oYojTxUdQF+95Zt
         /VXlCRAf7RDFw71SVZacR5/ch0lfII5xRJilTwTKkbaZ2nyOCDOuNFNHoTEl6NFZaEMx
         mEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=7bpvQqhRPlUK4DQw5tpf4WhhlJ4i2AY0YEo3/wGYpRI=;
        b=DHJeqlz99jXEnule3KrsDz8ZaypHfXKM0KmKvnxByv/rgB0/ZSyvBG9cTndq3WZxtV
         D1alcjyKoSISVYtEnqGZiQE6qquITAH++IPgyOgw3gsfi8nV39DPKlmIn3+j4QR6fowt
         kb51kNAqoWdqNwDeudaGsX6GNfyzDUjgTbk8joEjVzsuWxsCdVbARCgw4NigpM/Q4VkJ
         //Z2rXUHS6r01L146BqdxPA1jGPdduflN4Z698eAFxUxgUu53LncLVQBV/QKNUNRSA/j
         PHRZ8gWVstG7BtbZU/mu8EcKWncKCTreq/0qOC3lgElHSkQRugmoaRknxzWpMrqttWUW
         cNdQ==
X-Gm-Message-State: AOAM530uA8Qt+mT/rjILjC7GCtBHNjEbhAhX9UVU8MAPxFLmeqr81rAL
        JXDjQgnQMjYw/kihNAFb4EV+zkZEbXs=
X-Google-Smtp-Source: ABdhPJxI3p/N4J8IABzd85d2E+1N0PoViGzXF4xhnPvTl7+tgR50GWfO6JVVOWGA/7kMOf6Cu84YZQ==
X-Received: by 2002:a2e:a795:: with SMTP id c21mr356131ljf.353.1620244095399;
        Wed, 05 May 2021 12:48:15 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c11sm58550ljr.70.2021.05.05.12.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 12:48:14 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?G=C3=A1bor?= Farkas <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git switch/restore, still experimental?
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
        <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
        <877dkdwgfe.fsf@evledraar.gmail.com>
Date:   Wed, 05 May 2021 22:48:14 +0300
In-Reply-To: <877dkdwgfe.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 05 May 2021 13:09:47 +0200")
Message-ID: <87sg3155dt.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Tue, May 04 2021, Elijah Newren wrote:
>
>> On Tue, May 4, 2021 at 3:36 AM Gábor Farkas <gabor.farkas@gmail.com> wrote:
>>>
>>> hi,
>>>
>>> the "git switch" and "git restore" commands were released two years
>>> ago, but the manpage still says "THIS COMMAND IS EXPERIMENTAL. THE
>>> BEHAVIOR MAY CHANGE.".
>>>
>>> i'd love to use them, but this warning gives me pause, perhaps i
>>> should wait until it stops being experimental, i worry that it might
>>> change in behavior unexpectedly and cause problems for me.
>>>
>>> considering that they were released two years ago, could the
>>> experimental-warning be removed now?
>>>
>>> thanks,
>>> gabor
>>
>> This probably makes sense.  The author of switch and restore isn't
>> involved in the git project anymore.  He decided to work on other
>> things, which was and is a big loss for us.  I think others (myself
>> included) didn't know all the things that might have been in Duy's
>> head that he wanted to verify were working well before marking this as
>> good, but these two commands have generally been very well received
>> and it has been a few years.  Personally, I'm not aware of anything
>> that we'd need or want to change with these commands.
>
> I am.
>

[...]

> And:
>
>    # Moves a branch (or -M for --force)
>    git branch -m old new
>
> That last one we can't have either because "switch" squats on "-m" for
> "--merge", which I daresay is a much more obscure use-case not deserving
> of a short option than "rename and switch to".

Isn't --merge a different (and inferior) way to achieve what we already
have elsewhere with --autostash? Does it make sense to get rid of --merge
here in favor of --autostash?

Thanks,
-- Sergey Organov
