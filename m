Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248DFC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 14:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiKKOv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 09:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiKKOvy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 09:51:54 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E255326106
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 06:51:52 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v17so7925404edc.8
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 06:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Amo2EGvKmF7VpVWt197dSG5mywtL2uWEwq8M/4nEhgA=;
        b=kaBYnfiJ+A4rKV5A0fjeoPoFbcQzVrq71y7pw3Pu0o+mETi2pw+xCusXSV4bUprDOT
         XqltlgLao4sDW85TGcRLkvB6661Gq+t1VhC5RcSEjnbUTctfA8oz7Kst+CYHPhp9CzZJ
         1sMerfg8wAG4M94TzZd8Uw84Hc9AO5+UyW6lBAC19ODlDeaLVlI/0xg3TCcSBFML7C2Z
         wxjWNk7mgQTAgG/063DlU+d93yrvg4fOu2mtRo/k4abgJn+VX5nDIVoFCJwPX5ZVE2Iy
         Lr3Jv9UEtPes9LkK3MieBCIX0G7Dt7dY5+LUP1M429ngzuLFX3a69C10WgpK4bZ+2WXR
         zRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Amo2EGvKmF7VpVWt197dSG5mywtL2uWEwq8M/4nEhgA=;
        b=yOdmpfa1Tk82Ed+vt4BO+S2R3gj6OSYbTRq4VFfYNxA+nBPIvD4auCf2BJ3Zaj20IU
         MQqh5tmvklaSYymUHEoNspaSggvwpFrf7cHp/XUdiCUjVIebjeRzPaN6Xa9p4E4Rs8fV
         m+xyuF9pVTEhOUwN+JwN25adcK1vWU/wRvImR+ATPYeli14/FbKuDZbFy/pRP0IODQgP
         YCJTSRAjlWMJx/0NtbmTtuT4IzOdTiPaVEF0tOckT6nm/jjXnWnB4ZwiUOGRvuJYqxiw
         rO2qmQsiuzV7uEEhIeg1EX9QCwTuurRZTA4bGtPggcSLG6QoqyZ7F8XyHCardlS8CUMQ
         gFBA==
X-Gm-Message-State: ANoB5plKGMdNBS1zVOGmqV3gNBmJFeP4G/FJRgT9K5cRD/Z5hQcVLljv
        F3QOzi6oEyFCeJJZmi2yLhMH8a6dgDbbMA==
X-Google-Smtp-Source: AA0mqf6z/JpgxC6lBx7fi0TT+nydnu6iwac6gsSy3TLxIC3CSltrOLMQL5geQkkx4piJ6fcc3wm/0Q==
X-Received: by 2002:a05:6402:1642:b0:461:aa10:cb0c with SMTP id s2-20020a056402164200b00461aa10cb0cmr1742582edx.383.1668178311377;
        Fri, 11 Nov 2022 06:51:51 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id i9-20020aa7c709000000b004588ef795easm1175422edq.34.2022.11.11.06.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:51:50 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1otVNm-001wL0-10;
        Fri, 11 Nov 2022 15:51:50 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: js/bisect-in-c (was: What's cooking in git.git (Oct 2022, #09;
 Mon, 31))
Date:   Fri, 11 Nov 2022 15:11:56 +0100
References: <Y19dnb2M+yObnftj@nand.local>
 <221102.86cza52rt0.gmgdl@evledraar.gmail.com>
 <Y2KoKO5Sj71Nfa61@nand.local>
 <8r1s24sp-8p26-sr61-3pp0-8o7r6pr72641@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <8r1s24sp-8p26-sr61-3pp0-8o7r6pr72641@tzk.qr>
Message-ID: <221111.86a64xo86x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 10 2022, Johannes Schindelin wrote:

> Hi Taylor,
>
> On Wed, 2 Nov 2022, Taylor Blau wrote:
>
>> On Wed, Nov 02, 2022 at 06:22:17PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>> >
>> > On Mon, Oct 31 2022, Taylor Blau wrote:
>> >
>> > > What's cooking in git.git (Oct 2022, #09; Mon, 31)
>> > > --------------------------------------------------
>> > >
>> > > * js/bisect-in-c (2022-08-30) 17 commits
>> > >  . bisect: no longer try to clean up left-over `.git/head-name` files
>> > >  . bisect: remove Cogito-related code
>> > >  . Turn `git bisect` into a full built-in
>> > >  . bisect: move even the command-line parsing to `bisect--helper`
>> > >  . bisect--helper: make `state` optional
>> > >  . bisect--helper: calling `bisect_state()` without an argument is a=
 bug
>> > >  . bisect: avoid double-quoting when printing the failed command
>> > >  . bisect run: fix the error message
>> > >  . bisect: verify that a bogus option won't try to start a bisection
>> > >  . bisect--helper: migrate to OPT_SUBCOMMAND()
>> > >  . bisect--helper: make the order consistently `argc, argv`
>> > >  . bisect--helper: make `terms` an explicit singleton
>> > >  . bisect--helper: simplify exit code computation
>> > >  . bisect--helper: really retire `--bisect-autostart`
>> > >  . bisect--helper: really retire --bisect-next-check
>> > >  . bisect--helper: retire the --no-log option
>> > >  . Merge branch 'sg/parse-options-subcommand' into js/bisect-in-c
>> > >
>> > >  Final bits of "git bisect.sh" have been rewritten in C.
>> > >
>> > >  Needs review.
>> > >  cf. <xmqqv8pr8903.fsf@gitster.g>
>> > >  source: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
>> >
>> > I see this has been ejected out of "seen", presumably due to the
>> > outstanding conflicts.
>>
>> If I recall correctly, I ejected this one due to its age and lack of
>> attention. If you want to reroll it or if Johannes wants to take a look,
>> I'd be appreciative.

[Replying here instead of <s024qpqn-0roo-3rr2-nr4p-74p9296r6p02@tzk.qr>,
but take this as a reply to that as well]

> My last information was that I sent an iteration that was designed to
> address all outstanding concerns, including a rather major haul to put
> this on top of the new `OPT_SUBCOMMAND` feature that wasn't even dreamed
> of when I sent v1 of `bisect-in-c`, and then I only saw "Needs review."
> for several weeks and nobody objecting but also in particular =C3=86var (=
who
> raised concerns against this patch series several times over the last 10
> months) not chiming in with a "go ahead".

I think that "go ahead" from me was pretty unambiguous in [1], i.e. I said:

	"I think as it stands that it's a net improvement on "master". I
	would not mind it advanced in its current state. We can fix any
	outstanding issues with it later, particularly due to what seem
	like time constraints on your end[...]"

> So basically, I thought this was finally done and the next thing I hear is
> that it is ejected. [...]

What you're eliding here is that on the 4th Luk=C3=A1=C5=A1 Doktor reported=
 a
regression in "git bisect" that pre-dated your cooking topic[2].

You didn't participate in that discussion, except now to say that you
weren't motivated to review parts of the proposed fixes for that
regression it[3].

Which is relevant because in your topic you spend a lot of time
converting various code for the supposed needs of a migration to
OPT_SUBCOMMAND()[4]. Just the diffstat for that was:

 1 file changed, 128 insertions(+), 134 deletions(-)

Which didn't get all the way to the full OPT_SUBCOMMAND(). That still
needed [5] and [6], which are, respectively:

 1 file changed, 14 insertions(+), 15 deletions(-)
 2 files changed, 288 insertions(+), 194 deletions(-)

Whereas =C4=90o=C3=A0n's "dd/bisect-helper-subcommand", which is now in "ne=
xt",
and which was aiming for the shortest route to fixing that regression,
and which also gave us OPT_SUBCOMMAND() is:

 3 files changed, 142 insertions(+), 120 deletions(-)

This is all around 2 months after Junio's feedback on your latest
iteration was also questioning the need for that rewrite to get to the
goal of OPT_SUBCOMMAND()[7].

> That's quite a frustrating experience, I must admit.
> At least I am not a new contributor who would be very much deterred from
> contributing any further by such an experience.

It's been frustrating for me too, particularly the as this isn't the
first time that I feel like you're outright misrepresenting something
I've said or done.

But I really don't think any of this translates to some general
unfriendliness on the list that new contributors would run into.

To take just the above example: New contributors aren't sending hundreds
of lines of patches to get to a stated goal of "X" by doing "A", and
then ignoring or dismissing reviews when it's pointed out to them that
they can get to "X" in a much easier manner by doing "B" instead.

Your original topic is a daunting:

 7 files changed, 406 insertions(+), 388 deletions(-)

Which, as noted above the replacement of =C4=90o=C3=A0n's
"dd/bisect-helper-subcommand" is:

 3 files changed, 142 insertions(+), 120 deletions(-)

And his "dd/git-bisect-builtin" in seen is:

 5 files changed, 77 insertions(+), 58 deletions(-)

Does that get us all the same thing sas js/bisect-in-c? No. But it does
get us to the primary goal whith fewer changes, which I think is the
main reason why your series has had such a hard time advancing.

1. https://lore.kernel.org/git/220819.86sfls6zhh.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/1cb1c033-0525-7e62-8c09-81019bf26060@redhat.=
com/
3. https://lore.kernel.org/git/2477861r-9363-75sn-q415-o19206q70p90@tzk.qr/
4. https://lore.kernel.org/git/92b3b116ef8f879192d9deb94d68b73e29d5dcd6.166=
1885419.git.gitgitgadget@gmail.com/
5. https://lore.kernel.org/git/c9dc0281e38bf9bc0bce72de172b5dbadbcbb1f5.166=
1885419.git.gitgitgadget@gmail.com/
6. https://lore.kernel.org/git/e97e187bbec93b47f35e3dd42b4831f1c1d8658d.166=
1885419.git.gitgitgadget@gmail.com/
7. https://lore.kernel.org/git/xmqqmtblighr.fsf@gitster.g/
