Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDCCC4332F
	for <git@archiver.kernel.org>; Sun,  4 Dec 2022 09:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiLDJlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Dec 2022 04:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiLDJlh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2022 04:41:37 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B72186CD
        for <git@vger.kernel.org>; Sun,  4 Dec 2022 01:41:24 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id b2so21227199eja.7
        for <git@vger.kernel.org>; Sun, 04 Dec 2022 01:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wjgns/F4z1HXzIFYtl4jg8r/uEbiejtDf1kukMKJ1RY=;
        b=NcRSowUKeJS7CHV0yvlJy4bYkEdWtigbrCm25SEcaUlBbyWggMOK/frSL6OfeAlthl
         JW4w1jBcl5PFwTbTchV8f3y175c+R0HMyJLQfFTp0iN3rn/xxGEHQCMItOLT3395OZx5
         R+Toys7d9SuNfhDqv0n7WvkzK4h0Zx8f/v7hzkLQbyzmdS5vI25FS4bBCEayp+QaPb7l
         wKLIpTM/QASMtGERW/gHVwq1T/BDOF5w8j000014hUK+vhqsngdJ3hoTNNET2gNE2Akn
         8FMef4+DsO/hKDTR5a10/yp0cTkUnvzoljTSwE/7XtOIg/KJepvAp2C3SZqc4CXullqa
         0TUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wjgns/F4z1HXzIFYtl4jg8r/uEbiejtDf1kukMKJ1RY=;
        b=KdZl4EcJXWcGXZ4UjUUJMmGFXgPsMwTMNdPJhgouQTT6g7Vza1mkTk2nKtfSRtfjHt
         KVA5u2x7cB7MfWc8r3kGR587HBa2Mlp9KZytVQMlLPNegU3bmRC6BG02RRO+cTaYAVmZ
         SGRxsbtWglXJMwBm2IvoYwwckInHohVclJG4w4o0UERkfgoVhJ6oTQZwo0XUL4PeH8Q3
         XFzJL19txoFqSZZP2lfqoRfOrP1X3iV7kWliWVcc6Zu9DXRkaTJK5pLjeOf41pW0vwGm
         WVPSRNxaMmyUM2pHRD1bU/z+aliwQN1utPqPX8uHDxwhmQ2pn2uz6UXYbTc2sntO6W/T
         R6/A==
X-Gm-Message-State: ANoB5pmMpcFy9OhyZA5SR8zFB1bvugELODH2TZWwSh+bIiUJ81Ucq9pl
        NuT9O02eeei5DgijjAKdwgQ=
X-Google-Smtp-Source: AA0mqf6vAv/bATwUCC88E7CMswB5DbD/LMFd6MOqfN/xAuDnyUVWiLxPdgcuOTEwJC6aUD1kJ8obmw==
X-Received: by 2002:a17:906:1d14:b0:7ad:79c0:46f4 with SMTP id n20-20020a1709061d1400b007ad79c046f4mr65632264ejh.363.1670146882514;
        Sun, 04 Dec 2022 01:41:22 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906310500b0073d81b0882asm4970797ejx.7.2022.12.04.01.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 01:41:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p1lUv-003H4C-1D;
        Sun, 04 Dec 2022 10:41:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/1] t3920: replace two cats with a tee
Date:   Sun, 04 Dec 2022 10:34:39 +0100
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
 <203cb627-2423-8a35-d280-9f9ffc66e072@web.de>
 <CAPig+cQack=pJ04fwEiq81x6+2AAG4ni0Gd4GQgr4FS=PERb_Q@mail.gmail.com>
 <4611a23a-e7e9-6039-5d54-c2f8cadc2f73@web.de>
 <221203.86lenoeipb.gmgdl@evledraar.gmail.com>
 <491ad25c-1cf3-98dd-f7aa-e8d1f24c8cd0@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <491ad25c-1cf3-98dd-f7aa-e8d1f24c8cd0@web.de>
Message-ID: <221204.86cz8zecam.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 03 2022, Ren=C3=A9 Scharfe wrote:

> Am 03.12.22 um 13:53 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Sat, Dec 03 2022, Ren=C3=A9 Scharfe wrote:
>>
>>> Am 03.12.22 um 06:09 schrieb Eric Sunshine:
>>>> On Fri, Dec 2, 2022 at 11:51 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>>>> Use tee(1) to replace two calls of cat(1) for writing files with
>>>>> different line endings.  That's shorter and spawns less processes.
>>>>> [...]
>>>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>>>> ---
>>>>> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
>>>>> @@ -9,8 +9,7 @@ LIB_CRLF_BRANCHES=3D""
>>>>>  create_crlf_ref () {
>>>>> -       cat >.crlf-orig-$branch.txt &&
>>>>> -       cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch=
.txt &&
>>>>> +       tee .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch=
.txt &&
>>>>
>>>> This feels slightly magical and more difficult to reason about than
>>>> using simple redirection to eliminate the second `cat`. Wouldn't this
>>>> work just as well?
>>>>
>>>>     cat >.crlf-orig-$branch.txt &&
>>>>     append_cr <.crlf-orig-$branch.txt >.crlf-message-$branch.txt &&
>>>
>>> It would work, of course, but this is the exact use case for tee(1).  No
>>> repetition, no extra redirection symbols, just an nicely fitting piece
>>> of pipework.  Don't fear the tee! ;-)
>>>
>>> (I'm delighted to learn from https://en.wikipedia.org/wiki/Tee_(command)
>>> that PowerShell has a tee command as well.)
>>
>> I don't really care, but I must say I agree with Eric here. Not having
>> surprising patterns in the test suite has a value of its own.
>
> That's a good general guideline, but I wouldn't have expected a pipe
> with three holes to startle anyone. *shrug*

It's more that you're used to seeing one thing, the "cat >in" at the
start of a function is a common pattern.

Then it takes some time to stop and grok an a new pattern. If I was
hacking on a function like that I'd probably stop to try to understand
"why", even though I understood the "what".

I'd then find it was to try to optimize things on Windows a bit... :)

I'm not saying it's not worth it in this case, just pointing out that
boring "standard" patterns have a value of their own in us collectively
understanding them, which has a value of its own. Whether optimizing a
test case outweighs that is another matter (sometimes it would).

>> In this case I wonder if you want to optimize this whether we couldn't
>> do much better with "test_commit_bulk", maybe by teaching it a small set
>> of new tricks.
>>
>> I.e. if I do:
>>
>> 	git fast-export --all
>>
>> At the end of the setup test it seems we just end up with refs with
>> names that correspond to their contents, and with double newlines in
>> them or whatever. This is a lot of "grep", "sed", "tr" etc. just to end
>> up with that.
>>
>> So maybe we can create them as a patch, possibly with some slight "sed"
>> munging on the input stream, just just teach it to accept a "ref prefix"
>> and "commit message contents". That could just be an argument that you
>> "$(printf "...")", so we don't even need a sub-process....
>
> The files are used later for verification, so their contents can't just
> be passed on via parameters.
>
> Had a similar idea and spent too much time on creating the four files in
> a single awk invocation.  The code was too verbose and yet hard to read
> for my taste.

Hah, I didn't try. Just a suggestion in case it made sense :)

>> Also this:
>>
>>      perl -wE 'say for 1..1024*100' | tee /tmp/x | perl -nE 'print "in: =
$_"; exit 1 if $_ =3D=3D 512'; tail -n 1 /tmp/x
>>
>> Isn't deterministic. Now, in this case I doubt it matters, but it's nice
>> to have intermediate files in the test suite be determanistic, i.e. to
>> always have the full content be in the file at the top after the "top".
>
> Whoa, such a one-liner is a good argument for banishing Perl.
>
> So to rephrase it in a way that I can understand, you say that something
> like this:
>
> 	$ cd /tmp; seq 100000 | tee x | head -1 >/dev/null; wc -l x
>
> ... will probably report less than 100000 lines because the downpipe
> command ends the whole thing early.

Yes, the "perl" line was just a quick demo hack.

But the point is that the initial perl process on the LHS will be killed
with a SIGPIPE as the "perl" on the RHS stops and a SIGPIPE is
propagated up the chain.

I don't think it matters in this case, but just pointing out that it
*is* an edge case this sort of pattern introduces.

I've sometimes resorted to recursively diffing the trash directories of
two test runs to see if they're the same. E.g. I've caught cases where
the stderr of programs unexpectedly changes, but we had no test coverage
for it.

I think it's good to avoid patterns in general that make test runs
nondeterministic.

In this case it's only nondeterministic on failure, so it's probably
fine.
