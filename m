Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DEBC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 12:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87908610A2
	for <git@archiver.kernel.org>; Thu, 27 May 2021 12:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbhE0MvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 08:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbhE0MvI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 08:51:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF2AC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 05:49:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ss26so7599275ejb.5
        for <git@vger.kernel.org>; Thu, 27 May 2021 05:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=sD2nFEdGY0iVMXzIcGRDqTWaJefDxGvhwm1xZQ+qLDY=;
        b=C/BS8CfPY8biQqEnZiA+NomnjCk90OE3muGwd2svde8LgKsYKAiZkgVieN+sHiUVVc
         1TPWc82RZrcYLJq3dtjPhdmU0fDYHnoVm1P36DdIT9I82lN0D+P0PkJXgjFvp8k7MMNn
         lkFVULNny+WXyAK23Na/S3/R8g8O/Cdbcg47vf2d/rbDBQ7TiGBpu9z3TXMYoupfS8BY
         /jvNIaTLts40a9HUNIlgLkk75ylFaE0vCxNtOunMkGrezB4OYUDHSBQAQrWs57xWHeNo
         gjCUQtuKg/RXUOdxxZyDr5xl/cyeZtR5kuf7DcFDMY5WI7pPL4dHqdVd1Xyp7C0pfAyk
         xTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=sD2nFEdGY0iVMXzIcGRDqTWaJefDxGvhwm1xZQ+qLDY=;
        b=ku0GAXGRE7f/kxiZ4IrZBlter0BONArVYEgo8YOnH520CgrmamQB+ESC8oDgObiQrV
         cwltjJcKCfYuDD1bHoEeNAWSnyXCT+a16WtuvqvgLCLAJQC8mXyL0wtZebd0MNT8S4tv
         dksJBg9oDmalVFAZbbkljTa1hXGseMZ6X5SE+2SHDwdbFQeslxykwlia0wO4Bqn8YZZs
         DS+vCvl2Sa7wXRG7T5We/LuaCKONWSxCr1+qo+kDDyRRLtOmNk8zVW4etB3XaAtit/GS
         ng0yC2aRslsZlyv09gwLhD79CnPo4sP1/UWRltb2jbVfTeAwOItT3NccAeHcZrTWynNe
         xkVA==
X-Gm-Message-State: AOAM532lFg4AP6jXejTHLhGS1uIiX6Bcgv12bRz59++EjrdA8prt3cGM
        Ohhon6wVvpCMX7OOVkpf1/xKoHI5RMzSQw==
X-Google-Smtp-Source: ABdhPJysYp/f+/qGni5WAWf6+ht+FzB3BV/SgcJgOKf/NHWxqJAf38d5SI3liScNZV2IK0I+SO7Oog==
X-Received: by 2002:a17:906:744:: with SMTP id z4mr3664839ejb.347.1622119772536;
        Thu, 27 May 2021 05:49:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p7sm1065298edw.43.2021.05.27.05.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 05:49:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Runaway sed memory use in test on older sed+glibc (was "Re:
 [PATCH v6 1/3] test: add helper functions for git-bundle")
Date:   Thu, 27 May 2021 14:19:04 +0200
References: <87bl8xmipo.fsf@evledraar.gmail.com>
 <20210527115226.42539-1-zhiyou.jx@alibaba-inc.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210527115226.42539-1-zhiyou.jx@alibaba-inc.com>
Message-ID: <87tumol4tg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 27 2021, Jiang Xin wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=
=E5=B9=B45=E6=9C=8827=E6=97=A5=E5=91=A8=E5=9B=9B
> =E4=B8=8A=E5=8D=882:51=E5=86=99=E9=81=93=EF=BC=9A
>>
>>
>> On Mon, Jan 11 2021, Jiang Xin wrote:
>>
>> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>> >
>> > Move git-bundle related functions from t5510 to a library, and this
>> > lib
>> > will be shared with a new testcase t6020 which finds a known
>> > breakage of
>> > "git-bundle".
>> > [...]
>> > +
>> > +# Format the output of git commands to make a user-friendly and
>> > stable
>> > +# text. =C2=A0We can easily prepare the expect text without having to
>> > worry
>> > +# about future changes of the commit ID and spaces of the output.
>> > +make_user_friendly_and_stable_output () {
>> > + =C2=A0 =C2=A0 sed \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${A%${A#???????}}[0-=
9a-f]*/<COMMIT-A>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${B%${B#???????}}[0-=
9a-f]*/<COMMIT-B>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${C%${C#???????}}[0-=
9a-f]*/<COMMIT-C>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${D%${D#???????}}[0-=
9a-f]*/<COMMIT-D>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${E%${E#???????}}[0-=
9a-f]*/<COMMIT-E>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${F%${F#???????}}[0-=
9a-f]*/<COMMIT-F>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${G%${G#???????}}[0-=
9a-f]*/<COMMIT-G>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${H%${H#???????}}[0-=
9a-f]*/<COMMIT-H>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${I%${I#???????}}[0-=
9a-f]*/<COMMIT-I>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${J%${J#???????}}[0-=
9a-f]*/<COMMIT-J>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${K%${K#???????}}[0-=
9a-f]*/<COMMIT-K>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${L%${L#???????}}[0-=
9a-f]*/<COMMIT-L>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${M%${M#???????}}[0-=
9a-f]*/<COMMIT-M>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${N%${N#???????}}[0-=
9a-f]*/<COMMIT-N>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${O%${O#???????}}[0-=
9a-f]*/<COMMIT-O>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${P%${P#???????}}[0-=
9a-f]*/<COMMIT-P>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${TAG1%${TAG1#??????=
?}}[0-9a-f]*/<TAG-1>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${TAG2%${TAG2#??????=
?}}[0-9a-f]*/<TAG-2>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${TAG3%${TAG3#??????=
?}}[0-9a-f]*/<TAG-3>/g" \
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/ *\$//"
>> > +}
>>
>> On one of the gcc farm boxes, a i386 box (gcc45) this fails because
>> sed
>> gets killed after >500MB of memory use (I was just eyeballing it in
>> htop) on the "reate bundle from special rev: main^!" test. This with
>> GNU
>> sed 4.2.2.
>>
>> I suspect this regex pattern creates some runaway behavior in sed
>> that's
>> since been fixed (or maybe it's the glibc regex engine?). The glibc is
>> 2.19-18+deb8u10:
>>
>> =C2=A0 =C2=A0 + git bundle list-heads special-rev.bdl
>> =C2=A0 =C2=A0 + make_user_friendly_and_stable_output
>> =C2=A0 =C2=A0 + sed -e s/[0-9a-f]*/<COMMIT-A>/g -e s/[0-9a-f]*/<COMMIT-B=
>/g -e
>> s/[0-9a-f]*/<COMMIT-C>/g -e s/[0-9a-f]*/<COMMIT-D>/g -e
>> s/[0-9a-f]*/<COMMIT-E>/g -e s/[0-9a-f]*/<COMMIT-F>/g -e
>> s/[0-9a-f]*/<COMMIT-G>/g -e s/[0-9a-f]*/<COMMIT-H>/g -e
>> s/[0-9a-f]*/<COMMIT-I>/g -e s/[0-9a-f]*/<COMMIT-J>/g -e
>> s/[0-9a-f]*/<COMMIT-K>/g -e s/[0-9a-f]*/<COMMIT-L>/g -e
>> s/[0-9a-f]*/<COMMIT-M>/g -e s/[0-9a-f]*/<COMMIT-N>/g -e
>> s/[0-9a-f]*/<COMMIT-O>/g -e s/[0-9a-f]*/<COMMIT-P>/g -e
>> s/[0-9a-f]*/<TAG-1>/g -e s/[0-9a-f]*/<TAG-2>/g -e
>> s/[0-9a-f]*/<TAG-3>/g -e s/ *$//
>> =C2=A0 =C2=A0 sed: couldn't re-allocate memory
>
> I wrote a program on macOS to check memory footprint for sed and perl.
> See:
>
> =C2=A0 =C2=A0 https://github.com/jiangxin/compare-sed-perl

Interesting use of Go for as a /usr/bin/time -v replacement :)

After changing your int64 to int32 and digging up how to cross-compile
Go I get similar results, it's because your test has actual short SHA-1s
in the "-e 's///g'"'s, but notice how in the trace I have it's
e.g. "s/[0-9a-f]*/<COMMIT-A>/g".

That's the problem, so that Go command won't reproduce it. Anyway,
changing the test to emit to "input" first and running this shows it:
=20=20=20=20
    avar@gcc45:/run/user/1632/git/t/trash directory.t6020-bundle-misc$ /usr=
/bin/time -v sed -e 's/[0-9a-f]*/<COMMIT-A>/g' -e 's/[0-9a-f]*/<COMMIT-B>/g=
' -e 's/[0-9a-f]*/<COMMIT-C>/g' -e 's/[0-9a-f]*/<COMMIT-D>/g' -e 's/[0-9a-f=
]*/<COMMIT-E>/g' -e 's/[0-9a-f]*/<COMMIT-F>/g' -e 's/[0-9a-f]*/<COMMIT-G>/g=
' -e 's/[0-9a-f]*/<COMMIT-H>/g' -e 's/[0-9a-f]*/<COMMIT-I>/g' -e 's/[0-9a-f=
]*/<COMMIT-J>/g' -e 's/[0-9a-f]*/<COMMIT-K>/g' -e 's/[0-9a-f]*/<COMMIT-L>/g=
' -e 's/[0-9a-f]*/<COMMIT-M>/g' -e 's/[0-9a-f]*/<COMMIT-N>/g' -e 's/[0-9a-f=
]*/<COMMIT-O>/g' -e 's/[0-9a-f]*/<COMMIT-P>/g' -e 's/[0-9a-f]*/<TAG-1>/g' -=
e 's/[0-9a-f]*/<TAG-2>/g' -e 's/[0-9a-f]*/<TAG-3>/g' -e 's/ *$//' <input
    sed: couldn't re-allocate memory
    Command exited with non-zero status 4
            Command being timed: "sed -e s/[0-9a-f]*/<COMMIT-A>/g -e s/[0-9=
a-f]*/<COMMIT-B>/g -e s/[0-9a-f]*/<COMMIT-C>/g -e s/[0-9a-f]*/<COMMIT-D>/g =
-e s/[0-9a-f]*/<COMMIT-E>/g -e s/[0-9a-f]*/<COMMIT-F>/g -e s/[0-9a-f]*/<COM=
MIT-G>/g -e s/[0-9a-f]*/<COMMIT-H>/g -e s/[0-9a-f]*/<COMMIT-I>/g -e s/[0-9a=
-f]*/<COMMIT-J>/g -e s/[0-9a-f]*/<COMMIT-K>/g -e s/[0-9a-f]*/<COMMIT-L>/g -=
e s/[0-9a-f]*/<COMMIT-M>/g -e s/[0-9a-f]*/<COMMIT-N>/g -e s/[0-9a-f]*/<COMM=
IT-O>/g -e s/[0-9a-f]*/<COMMIT-P>/g -e s/[0-9a-f]*/<TAG-1>/g -e s/[0-9a-f]*=
/<TAG-2>/g -e s/[0-9a-f]*/<TAG-3>/g -e s/ *$//"
            User time (seconds): 130.00
            System time (seconds): 2.42
            Percent of CPU this job got: 100%
            Elapsed (wall clock) time (h:mm:ss or m:ss): 2:12.41
            Average shared text size (kbytes): 0
            Average unshared data size (kbytes): 0
            Average stack size (kbytes): 0
            Average total size (kbytes): 0
            Maximum resident set size (kbytes): 1030968
            Average resident set size (kbytes): 0
            Major (requiring I/O) page faults: 0
            Minor (reclaiming a frame) page faults: 257333
            Voluntary context switches: 1
            Involuntary context switches: 12578
            Swaps: 0
            File system inputs: 0
            File system outputs: 0
            Socket messages sent: 0
            Socket messages received: 0
            Signals delivered: 0
            Page size (bytes): 4096
            Exit status: 4

But no, the issue as it turns out is not Perl v.s. Sed, it's that
there's some bug in the shellscript / tooling version (happens with both
dash 0.5.7-4 and bash 4.3-11+deb8u2 on that box) where those expansions
like ${A%${A#??????0?}} resolve to nothing.

So if we make that:

        cat >input &&
        cat input >&2 &&
        sed -e "s/${A%${A#??????0?}}[0-9a-f]*/<COMMIT-A>/g" <input >input.t=
mp && mv input.tmp input &&
        cat input >&2 &&
        sed -e "s/${B%${B#???????}}[0-9a-f]*/<COMMIT-B>/g" <input >input.tm=
p && mv input.tmp input &&
        cat input >&2 &&

We get things like:
=20=20=20=20
    + sed -e s/[0-9a-f]*/<COMMIT-A>/g
    + mv input.tmp input
    + cat input
    <COMMIT-A> <COMMIT-A>r<COMMIT-A>s<COMMIT-A>/<COMMIT-A>h<COMMIT-A>s<COMM=
IT-A>/<COMMIT-A>m<COMMIT-A>i<COMMIT-A>n<COMMIT-A>
    + sed -e s/[0-9a-f]*/<COMMIT-B>/g
    + mv input.tmp input
    + cat input
    <COMMIT-B><<COMMIT-B>C<COMMIT-B>O<COMMIT-B>M<COMMIT-B>M<COMMIT-B>I<COMM=
IT-B>T<COMMIT-B>-<COMMIT-B>A<COMMIT-B>><COMMIT-B> <COMMIT-B><<COMMIT-B>C<CO=
MMIT-B>O<COMMIT-B>M<COMMIT-B>M<COMMIT-B>I<COMMIT-B>T<COMMIT-B>-<COMMIT-B>A<=
COMMIT-B>><COMMIT-B>r<COMMIT-B><<COMMIT-B>C<COMMIT-B>O<COMMIT-B>M<COMMIT-B>=
M<COMMIT-B>I<COMMIT-B>T<COMMIT-B>-<COMMIT-B>A<COMMIT-B>><COMMIT-B>s<COMMIT-=
B><<COMMIT-B>C<COMMIT-B>O<COMMIT-B>M<COMMIT-B>M<COMMIT-B>I<COMMIT-B>T<COMMI=
T-B>-<COMMIT-B>A<COMMIT-B>><COMMIT-B>/<COMMIT-B><<COMMIT-B>C<COMMIT-B>O<COM=
MIT-B>M<COMMIT-B>M<COMMIT-B>I<COMMIT-B>T<COMMIT-B>-<COMMIT-B>A<COMMIT-B>><C=
OMMIT-B>h<COMMIT-B><<COMMIT-B>C<COMMIT-B>O<COMMIT-B>M<COMMIT-B>M<COMMIT-B>I=
<COMMIT-B>T<COMMIT-B>-<COMMIT-B>A<COMMIT-B>><COMMIT-B>s<COMMIT-B><<COMMIT-B=
>C<COMMIT-B>O<COMMIT-B>M<COMMIT-B>M<COMMIT-B>I<COMMIT-B>T<COMMIT-B>-<COMMIT=
-B>A<COMMIT-B>><COMMIT-B>/<COMMIT-B><<COMMIT-B>C<COMMIT-B>O<COMMIT-B>M<COMM=
IT-B>M<COMMIT-B>I<COMMIT-B>T<COMMIT-B>-<COMMIT-B>A<COMMIT-B>><COMMIT-B>m<CO=
MMIT-B><<COMMIT-B>C<COMMIT-B>O<COMMIT-B>M<COMMIT-B>M<COMMIT-B>I<COMMIT-B>T<=
COMMIT-B>-<COMMIT-B>A<COMMIT-B>><COMMIT-B>i<COMMIT-B><<COMMIT-B>C<COMMIT-B>=
O<COMMIT-B>M<COMMIT-B>M<COMMIT-B>I<COMMIT-B>T<COMMIT-B>-<COMMIT-B>A<COMMIT-=
B>><COMMIT-B>n<COMMIT-B><<COMMIT-B>C<COMMIT-B>O<COMMIT-B>M<COMMIT-B>M<COMMI=
T-B>I<COMMIT-B>T<COMMIT-B>-<COMMIT-B>A<COMMIT-B>><COMMIT-B>
    [...]

etc. I.e. it's the sed expression itself that's the issue. I.e. you
should be able to reproduce this locally with something like:

    echo 0 | sed -e 's/[0-9]*/<BEGIN>0<END>/g' -e 's/[0-9]*/<BEGIN>0<END>/g=
' -e 's/[0-9]*/<BEGIN>0<END>/g' -e 's/[0-9]*/<BEGIN>0<END>/g' -e 's/[0-9]*/=
<BEGIN>0<END>/g' -e 's/[0-9]*/<BEGIN>0<END>/g' -e 's/[0-9]*/<BEGIN>0<END>/g=
' -e 's/[0-9]*/<BEGIN>0<END>/g'

If not just copy the -e a few more times.

Anyway, looking at this whole test file with fresh eyes this pattern
seems very strange. You duplicated most of test_commit with this
test_commit_setvar. It's a bit more verbosity but why not just use:

    test_commit ...
    A=3D$(git rev-parse HEAD)

Or teach test_commit a --rev-parse option or something and:

    A=3D$(test_commit ...)

This make_user_friendly_and_stable_output then actually loses
information, e.g. sometimes the bundle output you're testing emits
trailing spaces, but the normalization function overzelously trims that.

I think this whole thing would be much simpler with the above and then
something like:
=20=20=20=20
    @@ -146,7 +126,8 @@ test_expect_success 'setup' '
=20=20=20=20=20
            # branch main: merge commit I & J
            git checkout main &&
    -       test_commit_setvar --merge I topic/1 "Merge commit I" &&
    +       git merge --no-edit --no-ff -m"Merge commit I" topic/1 &&
    +       I=3D$(git rev-parse HEAD) &&
            test_commit_setvar --merge J refs/pull/2/head "Merge commit J" =
&&
=20=20=20=20=20
            # branch main: commit K
    @@ -172,18 +153,18 @@ test_expect_success 'create bundle from special r=
ev: main^!' '
=20=20=20=20=20
            git bundle list-heads special-rev.bdl |
                    make_user_friendly_and_stable_output >actual &&
    -       cat >expect <<-\EOF &&
    -       <COMMIT-P> refs/heads/main
    +       cat >expect <<-EOF &&
    +       $P refs/heads/main
            EOF
            test_cmp expect actual &&

Or just add a --merge option to test_commit itself.
