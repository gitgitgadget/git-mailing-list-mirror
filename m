Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6640C48BE8
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 11:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF8E61185
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 11:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbhFNL0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 07:26:19 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:34643 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbhFNLXu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 07:23:50 -0400
Received: by mail-ed1-f49.google.com with SMTP id cb9so46039036edb.1
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 04:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Wbp5KQ266lGfw33WbgrvDRVwykt6xDuv8Z5+blqq7ng=;
        b=QvsMWG67Dn3H4d5fdWM9UhxBSKbDVsM/TJXBXWefuE/Ep94W0F8P0PHc8BHFGgxWZx
         ZKPEHzVVj664h34EaTXmnFzwBIbbt5FZEnxMDlpupN6tOFiHBiiPy248ENPDkDynsHcD
         BUam81wwsybSXAMAROqEXR/fTD4RLmMXgIK6VUoYW7jQc7ibdDA+O499OBmilAhkv/S6
         ISbg1l1ksLWkL09E7w6NUX9qll9IKBziUIgDF5NNqubDRpbvJTI6Pn2/dqwXAhSBSGD3
         N6B/gCwTyt7JrZrm4+KDhQs7OLTq0MLl1r6K/nDWzpAuv11Od5n77MyHZI/o+pZ7vNgY
         v4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Wbp5KQ266lGfw33WbgrvDRVwykt6xDuv8Z5+blqq7ng=;
        b=Y9v4m9mY48M3/6AC1SraFA6C59t8Ilcm1NIgamMgOl+OvShQXzW2cE1MAYoAbzAc9G
         SohC1Vgifv1PS7WgPSB5nPLPYEcrAsPElzmHRDepbv1QStZ+7HT1TqKjks1K0A1JPTfi
         IbObFzvIjAeAtd2zzSfNL8/xEhIXTqiFGCI9RYKqPSBSG3slsHUnYtY/Xv4JNvxydERz
         LqtuTEWhRjiqJvflmDvUXOPfRxEAEcHbghIxb1HDLm0jbWW4iJxM1osVBOkR8vlEZn/L
         +3Iw2Ns16px/yOcoPoX2N4heoReSBTvI88jgR7Ph/9Gu9LrraFDhDMkE8Lckpf3xSrdV
         lxOg==
X-Gm-Message-State: AOAM530lcChEwtLkaQEUw5h7j10F2A48vYo5LbqzRFDCbrFAZec1qmJ2
        if1V1rgU/T41y79A4A5G57A=
X-Google-Smtp-Source: ABdhPJwmesPHuE5lm/Npi9Jf5WKQK16M4GJYvdSyiPBZC6I4FYxl1VlEAKl3PXyLzyYhYRvsa9RQfA==
X-Received: by 2002:a05:6402:344:: with SMTP id r4mr16140514edw.226.1623669646945;
        Mon, 14 Jun 2021 04:20:46 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g11sm8615361eds.24.2021.06.14.04.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 04:20:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
Date:   Mon, 14 Jun 2021 13:07:50 +0200
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
        <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
        <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
        <87k0n54qb6.fsf@evledraar.gmail.com>
        <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>
        <8735tt4fhx.fsf@evledraar.gmail.com> <xmqqczsxtf8g.fsf@gitster.g>
        <87wnr4394y.fsf@evledraar.gmail.com>
        <74183ce6-e17f-1b11-1ceb-7a8d873bc1c7@web.de>
        <87lf7k2bem.fsf@evledraar.gmail.com>
        <f5e181fc-af94-bccf-051f-a58a04fe1ffc@web.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <f5e181fc-af94-bccf-051f-a58a04fe1ffc@web.de>
Message-ID: <87zgvszo8i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 10 2021, Ren=C3=A9 Scharfe wrote:

> Am 09.06.21 um 00:12 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Tue, Jun 08 2021, Ren=C3=A9 Scharfe wrote:
>>
>>> I wonder (only in a semi-curious way, though) if we can detect
>>> off-by-one errors by adding an assertion to display_progress() that
>>> requires the first update to have the value 0, and in stop_progress()
>>> one that requires the previous display_progress() call to have a value
>>> equal to the total number of work items.  Not sure it'd be worth the
>>> hassle..
>>
>> That's intentional. We started eating 3 apples, got to one, but now our
>> house is on fire and we're eating no more apples today, even if we
>> planned to eat 3 when we sat down.
>>
>> The progress bar reflects this unexpected but recoverable state:
>>
>>     $ perl -wE 'for (0..1) { say "update"; say "progress $_" }' |
>>       ./helper/test-tool progress --total=3D3 Apples 2>&1 |
>>       cat -v | perl -pe 's/\^M\K/\n/g'
>>     Apples:   0% (0/3)^M
>>     Apples:  33% (1/3)^M
>>     Apples:  33% (1/3), done.
>>
>> We're at 1/3, but we're done. No more apples.
>>
>> This isn't just some hypothetical, e.g. consider neeing to unlink() or
>> remove files/directories one at a time in a directory and getting the
>> estimated number from st_nlink (yeah yeah, unportable, but it was the
>> first thing I thought of).
>>
>> We might think we're processing 10 entries, but another other processes
>> might make our progress bar end at more or less than the 100% we
>> expected. That's OK, not something we should invoke BUG() about.
>
> It doesn't have to be a BUG; a warning would suffice.  And I hope not
> finishing the expected number of items due to a catastrophic event is
> rare enough that an additional warning wouldn't cause too much pain.

It's not a catastrophic event, just a run of the mill race condition
we'll expect if we're dealing with the real world.

E.g. you asked to unlink 1000 files, we do so, we find 10 are unlinked
already, or the command is asked to recursively unlink all files in a
directory tree, and new ones have showed up.

In those cases we should just just shrug and move on, no need for a
warning. We just don't always have perfect information about future
state at the start of the loop.

> Loops that *regularly* end early are not a good fit for progress
> percentages, I think.

Arguably yes, but in these fuzzy cases not providing a "total" means
showing no progress at all, just a counter. Perhaps we should have some
other "provide total, and it may be fuzzy" flag. Not providing it might
run into your proposed BUG(), my point was that the current API
providing this flexibility is intentional.

>> Similarly, the n=3D0 being distinguishable from the first
>> display_progress() is actually useful in practice. It's something I've
>> seen git.git emit (not recently, I patched the relevant code to emit
>> more granular progress).
>>
>> It's useful to know that we're stalling on the setup code before the
>> for-loop, not on the first item.
>
> Hmm, preparations that take a noticeable time might deserve their own
> progress line.

Sure, and I've split some of those up in the past, but this seems like
ducking/not addressing the point that the API use we disagree on has
your preferred use conflating these conditions, but mine does not...

> Anyway, if no guard rails can be built then we have to rely on our math
> skills alone.  Off-by-one errors may look silly, but are no joke -- they
> are surprisingly easy to make.

...which, regardless of whether one views a progress of "1/5 items" has
"finished 1/5" or "working on 1/5", which I think *in general* is an
arbitrary choice, I think the progress.c API we have in git.git clearly
fits the usage I'm describing better.
