Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBF2C352A1
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 13:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiLCNKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Dec 2022 08:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiLCNKq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 08:10:46 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EC92AE1C
        for <git@vger.kernel.org>; Sat,  3 Dec 2022 05:10:44 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id a16so9788790edb.9
        for <git@vger.kernel.org>; Sat, 03 Dec 2022 05:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qKWsFft8Tnv6ZNM24S+zdiRlCYa2OuxuEnm904GLjeg=;
        b=SF9+5HMh//dYPymUYaS02xB6hjmzEsH5GZDLcQg3kcN/17hhE418hJBPJT3/e3NlFb
         dso2X9Uz+58aOBX454+huximtlvEaU6K5STAGxMJZ+veKwm5cdj6oyiJunfm2kSWnIv9
         GYaEOG++UURumpVg6b0ALr9dO39NIZGZJXnncyGs9vu0SyAc8q5EgutM9B9QZdOHHyI8
         37w2W8HyTnDU8AN1A68k5/1nSkv7S8cFTX6rhoQxD0/4KQUFG+aUOImY+i8bIAWevgxi
         OxeFqR/KGsPtumA5co5AUUxzdHvfJMol95uOV22O/x7j8kmFJXPegHajC1LWTdz6CzpJ
         lg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qKWsFft8Tnv6ZNM24S+zdiRlCYa2OuxuEnm904GLjeg=;
        b=coqnlOrMW405Q0RI+QZDDJaYEMV2J70VEM+BBafngTepCvcZ9FoMS+GDqD42U6XQFU
         XQmxEWOpsxhyR1UbvssWHFyUVafDg0Z/ilkWsHc6d1Fp0LxfQQwJWL+RsQI9oqXyud8P
         xBgTmpLVrYUos1y3PWpLImJ8LHn0pOu4/g6Ly2vVGAu1UW1jL50Ij7r6Y3+gqut9S1Dg
         NivisOxG8B7AvLuj0JPvE6hT0A7j9+Dcpun8YDHXZ8m2eK3zyPrbswRF7Oq2ryvw/VqN
         bzMxa7h6tfBXxOrG6DHiKbQxt6zh2AgCqGagC0kLIGE/1dAHWSfTFyxZslo7QQ1VdOKp
         9Ktw==
X-Gm-Message-State: ANoB5plX39v/W9HaswRVgOLKYbpUVmTDBtbLmBAAbkzHLfCb2vJ7+Qk0
        cm+UsVOHwathLTBlEGjBOBs=
X-Google-Smtp-Source: AA0mqf7B9jCdnfX3OL8FkqLMxJh2d8xs4qemlrsWmjHaMIUpyk8nElChXTX+Xgl99hEnaqDwwq+LeQ==
X-Received: by 2002:aa7:cb96:0:b0:461:bacd:c85d with SMTP id r22-20020aa7cb96000000b00461bacdc85dmr24635596edt.278.1670073042939;
        Sat, 03 Dec 2022 05:10:42 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906304700b0079800b8173asm4174204ejd.158.2022.12.03.05.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 05:10:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p1SHw-003FLU-0U;
        Sat, 03 Dec 2022 14:10:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/1] t3920: replace two cats with a tee
Date:   Sat, 03 Dec 2022 13:53:13 +0100
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
 <203cb627-2423-8a35-d280-9f9ffc66e072@web.de>
 <CAPig+cQack=pJ04fwEiq81x6+2AAG4ni0Gd4GQgr4FS=PERb_Q@mail.gmail.com>
 <4611a23a-e7e9-6039-5d54-c2f8cadc2f73@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <4611a23a-e7e9-6039-5d54-c2f8cadc2f73@web.de>
Message-ID: <221203.86lenoeipb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 03 2022, Ren=C3=A9 Scharfe wrote:

> Am 03.12.22 um 06:09 schrieb Eric Sunshine:
>> On Fri, Dec 2, 2022 at 11:51 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>> Use tee(1) to replace two calls of cat(1) for writing files with
>>> different line endings.  That's shorter and spawns less processes.
>>> [...]
>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>> ---
>>> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
>>> @@ -9,8 +9,7 @@ LIB_CRLF_BRANCHES=3D""
>>>  create_crlf_ref () {
>>> -       cat >.crlf-orig-$branch.txt &&
>>> -       cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.t=
xt &&
>>> +       tee .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.t=
xt &&
>>
>> This feels slightly magical and more difficult to reason about than
>> using simple redirection to eliminate the second `cat`. Wouldn't this
>> work just as well?
>>
>>     cat >.crlf-orig-$branch.txt &&
>>     append_cr <.crlf-orig-$branch.txt >.crlf-message-$branch.txt &&
>
> It would work, of course, but this is the exact use case for tee(1).  No
> repetition, no extra redirection symbols, just an nicely fitting piece
> of pipework.  Don't fear the tee! ;-)
>
> (I'm delighted to learn from https://en.wikipedia.org/wiki/Tee_(command)
> that PowerShell has a tee command as well.)

I don't really care, but I must say I agree with Eric here. Not having
surprising patterns in the test suite has a value of its own.

In this case I wonder if you want to optimize this whether we couldn't
do much better with "test_commit_bulk", maybe by teaching it a small set
of new tricks.

I.e. if I do:

	git fast-export --all

At the end of the setup test it seems we just end up with refs with
names that correspond to their contents, and with double newlines in
them or whatever. This is a lot of "grep", "sed", "tr" etc. just to end
up with that.

So maybe we can create them as a patch, possibly with some slight "sed"
munging on the input stream, just just teach it to accept a "ref prefix"
and "commit message contents". That could just be an argument that you
"$(printf "...")", so we don't even need a sub-process....

Also this:

     perl -wE 'say for 1..1024*100' | tee /tmp/x | perl -nE 'print "in: $_"=
; exit 1 if $_ =3D=3D 512'; tail -n 1 /tmp/x

Isn't deterministic. Now, in this case I doubt it matters, but it's nice
to have intermediate files in the test suite be determanistic, i.e. to
always have the full content be in the file at the top after the "top".

With a "tee" you need to worry about the "append_cr" function it's being
piped in stopping the stdin.

I don't think it matters in this case, but in general as a pattern: I do
fear the "tee" a bit :)
