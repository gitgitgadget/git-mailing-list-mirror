Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35FCC433DB
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 18:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CB961944
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 18:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCTSMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 14:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhCTSMa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 14:12:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67F1C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 11:12:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id jy13so14738564ejc.2
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lVyaok5laMllYFD9bKJ2ZNhPevEDvsD2BO3zEaUevNM=;
        b=ZMl1HGtlCQ6OyHLgKSMExMSO2BJckYTem1lX/x/MfurzOlUtHpHajNM4qVpDkp8U7B
         +FC/7iXo2shHjq3abwjrlNGQFFkHLt02AElqzHXo7OmztXpoTpNrUyPD4Z0bP0jOBYDF
         mj030mbvIRyI3Qp3lmceaLNZKqgubgjE/fLeM7Zi0/rQ6jL7wJ+9oYE0IwMVfPStHD1y
         kmX+GTAKt4G8GUgMXT/Ls60Et4hRX1rjMp/qbZ+3w9KJFIunI2NdoufSTlKGaKntIDSn
         Ra3EBV3aCU/gsQ1lHXafTBt3Z/Clsx3PQ0jj7oJbRAfWDqNqpurn+EIg4IAFlLJpPRt6
         xHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=lVyaok5laMllYFD9bKJ2ZNhPevEDvsD2BO3zEaUevNM=;
        b=QrD0N74Jqi3KUlzwmthTyzGZpFZqsE75fraxXbvIZP4MIo2czBzzycim4GF8/86t1G
         pjs+bDvTWePj9VR8n8INlATHgi01HnTP8VFboXrjo8WXZuSjpIFzD7rt9spaG4ilxcpc
         4/eSl1fgA7LU+MSyHPvl3bxPAG3rrGslg64ZqeSEb5wwENJhIV3gBSITmS9as/zFm78y
         0CgRhX38+pzsAs5lAUEdiPze3jcrnwuoL1ToUSjmtCkacLpkOCND1377uE/E6EI5O4yo
         lRAgNmtfEiGr/oxMkYgfgBEZi1bcj5CbjYcCDye08xPHI1B8UCCGJ9/fwa2QJx+Q+jVl
         t6sg==
X-Gm-Message-State: AOAM532NJrQdSIJZ2qpNTLf8Qt87qirX/cgiEbiGpwmAjhIRdqtSVUfv
        16J627LRebsTI9azLIDeKEs=
X-Google-Smtp-Source: ABdhPJxXk6AmuVbhYIq4yQ+kHqx6yyARh0q8+ZfbCVJlRyGq/oUpf78fMxGpOwa5oZJOjYyYnB+AiA==
X-Received: by 2002:a17:907:7683:: with SMTP id jv3mr10741660ejc.450.1616263925193;
        Sat, 20 Mar 2021 11:12:05 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g12sm1221298eje.120.2021.03.20.11.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 11:12:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 16/21] mingw: try to work around issues with the test
 cleanup
References: <pull.31.v5.git.gitgitgadget@gmail.com>
 <pull.31.v6.git.gitgitgadget@gmail.com>
 <991b41afa4a83a73f59a72504d269d64d12ecf8f.1548771561.git.gitgitgadget@gmail.com>
 <87zgzbgp1i.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2103191515430.57@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <nycvar.QRO.7.76.6.2103191515430.57@tvgsbejvaqbjf.bet>
Date:   Sat, 20 Mar 2021 19:12:03 +0100
Message-ID: <87a6qxzocs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 19 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> thanks for digging out this old thread, I really could have done never
> thinking about it again!

I didn't think I'd dug up something so traumatic :)

> On Wed, 10 Mar 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>
>> On Tue, Jan 29 2019, Johannes Schindelin via GitGitGadget wrote:
>>
>> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> >
>> > It seems that every once in a while in the Git for Windows SDK, there
>> > are some transient file locking issues preventing the test clean up to
>> > delete the trash directory. Let's be gentle and try again five seconds
>> > later, and only error out if it still fails the second time.
>> >
>> > This change helps Windows, and does not hurt any other platform
>> > (normally, it is highly unlikely that said deletion fails, and if it
>> > does, normally it will fail again even 5 seconds later).
>> >
>> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > ---
>> >  t/test-lib.sh | 6 +++++-
>> >  1 file changed, 5 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/t/test-lib.sh b/t/test-lib.sh
>> > index f31a1c8f79..9c0ca5effb 100644
>> > --- a/t/test-lib.sh
>> > +++ b/t/test-lib.sh
>> > @@ -1104,7 +1104,11 @@ test_done () {
>> >  			error "Tests passed but trash directory already removed before tes=
t cleanup; aborting"
>> >
>> >  			cd "$TRASH_DIRECTORY/.." &&
>> > -			rm -fr "$TRASH_DIRECTORY" ||
>> > +			rm -fr "$TRASH_DIRECTORY" || {
>> > +				# try again in a bit
>> > +				sleep 5;
>> > +				rm -fr "$TRASH_DIRECTORY"
>> > +			} ||
>> >  			error "Tests passed but test cleanup failed; aborting"
>> >  		fi
>> >  		test_at_end_hook_
>>
>> I saw this sleep while reading some test-lib.sh code, doesn't this break
>> df4c0d1a79 (test-lib: abort when can't remove trash directory,
>> 2017-04-20) for non-Windows platforms?
>
> It does not really break it, it just delays the inevitable failure.
>
>> Your CL for v3 suggests this was only encountered in Azure VMs:
>> https://lore.kernel.org/git/pull.31.v3.git.gitgitgadget@gmail.com/
>
> If by "CL" you refer to the cover letter, then I might have made it sound
> as if it was only encountered in the Azure Pipelines agents. I vaguely

Yes, the cover letter.

> seem to remember seeing something like this quite often on my personal
> machine, too, though. Most likely Microsoft Defender going a little wild.
>
>> Aside from this obscure issue, wouldn't it make more sense to have some
>> optional "I'm under CI" flag to skip the teardown one test at a time as
>> we're probably about to shut off the transitory VM soon?
>
> No, I'm not under CI, and I did encounter these issues. And they abruptly
> stopped with the patch you apparently still want to discuss ;-)
>
>> I skip some tests, but the test suite creates ~950MB of trash for
>> me. Maybe cheaper for some to just keep that around and have it all
>> removed at the end.
>
> I don't understand this statement. Or was there a question in it that
> you'd like me to answer?

If the fix was purely for Azure's CI setup I was suggesting that a
better solution might be to keep the trash around until the end. But
that's not the only setup as you note here, so let's discard that
suggestion.

In any case, your patch clearly undoes whatever canary for gc issues
df4c0d1a792 was trying to put into the test-lib, but didn't say so in
its commit message.

So I figured it was something that was missed at the time, and that I
should send a quick E-Mail to both authors to see if anyone cared, maybe
nobody does.

It's just something I ran into while reviewing test-lib.sh for some
unrelated changes I was making...
