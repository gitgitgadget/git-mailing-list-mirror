Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1A3C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 10:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjBIKJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 05:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBIKJv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 05:09:51 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5075A564BD
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 02:09:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id q19so1695573edd.2
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 02:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f58u00KYp9lFYjHQSzvdWzWLqujed42XTqI6rj5dGLo=;
        b=JwPFdtPhy9PaAl0125kTgvEvUlM3UzayxEbQ3ONrv/ILPfV8Lk2tVOfRlptrGpY9Mn
         tv+eXn7Yo6qCpZxEMqWU0MA8ME1aE1GldAXLfrQTDFPfXc2xUXgFKaB/rzE90PT5Pwgw
         jFf/pFRsTCTxNwUN9ubyChOG1FauHO2H0s08Ahl5nP0A3k3cqk4ySyo7OTKFmiq/nbz+
         xppgZCXsHukmKtrqrcqvRjheq9xYNBExW/2kQ+mY6imhcmt7AsfZHxVN2m5VESMR7q3A
         GpJxNyxrxkCWXtX0n7iRMn4w3888+FqQXIVtsXJolfa8lt8gVxMIIG2409BoAbHlwtAA
         gP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f58u00KYp9lFYjHQSzvdWzWLqujed42XTqI6rj5dGLo=;
        b=NEO8InnG/7rOFmA0/ayjsT/5+mN+tcoRBPx2V866wMqfHV3sxCMWOt+6bKXqttAqKf
         bhcoprSggB3kgL45lLMK034xkq6yM2rX5FCCgvob8ihBVbyiVYjlZK5LlXujSPmISC2C
         F6cPkuA9SMgo2oqH7b/oxCya1HhKqX47fqRmPncJ8XoUgk4VkJd3yVymFxz5pKVkI84y
         AnbcSJ6ICa4f8l3Z33HDlEYWldO3O/7s1pQZnuxGMd9DA1l2UeF9GycH59Y7mHYY/Plu
         UOjTycZ3KyOOPg5+7p8/lqyUoiKRoBZGJqsbdDtbnUpxfLJDbG6yy604vMtPiC0Xv/us
         6U5A==
X-Gm-Message-State: AO0yUKWD4+aV/faepxanMO2Zw9JRqmNzwj5c4Rxy3UCkgFLl6YX5vjQY
        3aMYnapwExcp2CACNxMu+b5UZFcZuKrMhYsl
X-Google-Smtp-Source: AK7set8M4Zptc5/fMVsTRWPUulmnOHIu3aDU+vfG8sfSh1pDPe5k/4QY4SVpcnlBbJdt032iUvr+JQ==
X-Received: by 2002:a50:d08c:0:b0:4ab:15d4:4e0d with SMTP id v12-20020a50d08c000000b004ab15d44e0dmr6415050edd.31.1675937387296;
        Thu, 09 Feb 2023 02:09:47 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id n13-20020a50cc4d000000b004a0afea4c9csm522404edi.18.2023.02.09.02.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 02:09:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pQ3sA-001h0g-0h;
        Thu, 09 Feb 2023 11:09:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Date:   Thu, 09 Feb 2023 10:41:33 +0100
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
        <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
        <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
        <CABPp-BGdKjnChEp4zeCcz24wiEJVJb9Tp40MTWn1m0LRZu+M+Q@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CABPp-BGdKjnChEp4zeCcz24wiEJVJb9Tp40MTWn1m0LRZu+M+Q@mail.gmail.com>
Message-ID: <230209.86lel7xi8l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 08 2023, Elijah Newren wrote:

> On Mon, Feb 6, 2023 at 9:24 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> On Sun, Feb 05 2023, John Cai via GitGitGadget wrote:
>>
>> > From: John Cai <johncai86@gmail.com>
>> > [...]
>> > +
>> > +             if (!o->xdl_opts_command_line) {
>> > +                     static struct attr_check *check;
>> > +                     const char *one_diff_algo;
>> > +                     const char *two_diff_algo;
>> > +
>> > +                     check =3D attr_check_alloc();
>> > +                     attr_check_append(check, git_attr("diff-algorith=
m"));
>> > +
>> > +                     git_check_attr(the_repository->index, NULL, one-=
>path, check);
>> > +                     one_diff_algo =3D check->items[0].value;
>> > +                     git_check_attr(the_repository->index, NULL, two-=
>path, check);
>> > +                     two_diff_algo =3D check->items[0].value;
>> > +
>> > +                     if (!ATTR_UNSET(one_diff_algo) && !ATTR_UNSET(tw=
o_diff_algo) &&
>> > +                             !strcmp(one_diff_algo, two_diff_algo))
>> > +                             set_diff_algorithm(o, one_diff_algo);
>> > +
>> > +                     attr_check_free(check);
>>
>> This is a bit nitpicky, but I for one would find this much easier to
>> read with some shorter variables, here just with "a" rather than
>> "one_diff_algo", "b" instead of "two_diff_algo", and splitting
>> "the_repository->index" into "istate" (untested):
>>
>>         +               if (!o->xdl_opts_command_line) {
>>         +                       static struct attr_check *check;
>>         +                       const char *a;
>>         +                       const char *b;
>>         +                       struct index_state *istate =3D the_repos=
itory->index;
>>         +
>>         +                       check =3D attr_check_alloc();
>>         +                       attr_check_append(check, git_attr("diff-=
algorithm"));
>>         +
>>         +                       git_check_attr(istate, NULL, one->path, =
check);
>>         +                       a =3D check->items[0].value;
>>         +                       git_check_attr(istate, NULL, two->path, =
check);
>>         +                       b =3D check->items[0].value;
>>         +
>>         +                       if (!ATTR_UNSET(a) && !ATTR_UNSET(b) && =
!strcmp(a, b))
>>         +                               set_diff_algorithm(o, a);
>>         +
>>         +                       attr_check_free(check);
>>         +               }
>>
>> That also nicely keeps the line length shorter.
>>
>> > @@ -333,6 +333,8 @@ struct diff_options {
>> >       int prefix_length;
>> >       const char *stat_sep;
>> >       int xdl_opts;
>> > +     /* If xdl_opts has been set via the command line. */
>> > +     int xdl_opts_command_line;
>> >
>> >       /* see Documentation/diff-options.txt */
>> >       char **anchors;
>> > diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
>> > index 8d1e408bb58..630c98ea65a 100644
>> > --- a/t/lib-diff-alternative.sh
>> > +++ b/t/lib-diff-alternative.sh
>> > @@ -107,8 +107,27 @@ EOF
>> >
>> >       STRATEGY=3D$1
>> >
>> > +     test_expect_success "$STRATEGY diff from attributes" '
>> > +             echo "file* diff-algorithm=3D$STRATEGY" >.gitattributes =
&&
>> > +             test_must_fail git diff --no-index file1 file2 > output =
&&
>> > +             test_cmp expect output
>> > +     '
>> > +
>> >       test_expect_success "$STRATEGY diff" '
>> > -             test_must_fail git diff --no-index "--$STRATEGY" file1 f=
ile2 > output &&
>> > +             test_must_fail git diff --no-index "--diff-algorithm=3D$=
STRATEGY" file1 file2 > output &&
>>
>> Nit: The usual style is ">output", not "> output".
>>
>> > +             test_cmp expect output
>> > +     '
>> > +
>> > +     test_expect_success "$STRATEGY diff command line precedence befo=
re attributes" '
>> > +             echo "file* diff-algorithm=3Dmeyers" >.gitattributes &&
>> > +             test_must_fail git diff --no-index "--diff-algorithm=3D$=
STRATEGY" file1 file2 > output &&
>> > +             test_cmp expect output
>> > +     '
>> > +
>> > +     test_expect_success "$STRATEGY diff attributes precedence before=
 config" '
>> > +             git config diff.algorithm default &&
>> > +             echo "file* diff-algorithm=3D$STRATEGY" >.gitattributes =
&&
>> > +             test_must_fail git diff --no-index "--diff-algorithm=3D$=
STRATEGY" file1 file2 > output &&
>> >               test_cmp expect output
>> >       '
>> >
>> > @@ -166,5 +185,11 @@ EOF
>> >               test_must_fail git diff --no-index "--$STRATEGY" uniq1 u=
niq2 > output &&
>> >               test_cmp expect output
>> >       '
>> > +
>> > +     test_expect_success "$STRATEGY diff from attributes" '
>> > +             echo "file* diff-algorithm=3D$STRATEGY" >.gitattributes =
&&
>> > +             test_must_fail git diff --no-index uniq1 uniq2 > output =
&&
>> > +             test_cmp expect output
>> > +     '
>> >  }
>>
>> For some non-nitpicking, I do worry about exposing this as a DoS vector,
>> e.g. here's a diff between two distant points in git.git with the
>> various algorithms:
>>
>>         $ hyperfine -r 1 -L a patience,minimal,histogram,myers 'git diff=
 --diff-algorithm=3D{a} v2.0.0 v2.28.0'
>>         Benchmark 1: git diff --diff-algorithm=3Dpatience v2.0.0 v2.28.0
>>           Time (abs =E2=89=A1):        42.121 s               [User: 41.=
879 s, System: 0.144 s]
>>
>>         Benchmark 2: git diff --diff-algorithm=3Dminimal v2.0.0 v2.28.0
>>           Time (abs =E2=89=A1):        35.634 s               [User: 35.=
473 s, System: 0.160 s]
>>
>>         Benchmark 3: git diff --diff-algorithm=3Dhistogram v2.0.0 v2.28.0
>>           Time (abs =E2=89=A1):        46.912 s               [User: 46.=
657 s, System: 0.228 s]
>>
>>         Benchmark 4: git diff --diff-algorithm=3Dmyers v2.0.0 v2.28.0
>>           Time (abs =E2=89=A1):        33.233 s               [User: 33.=
072 s, System: 0.160 s]
>>
>>         Summary
>>           'git diff --diff-algorithm=3Dmyers v2.0.0 v2.28.0' ran
>>             1.07 times faster than 'git diff --diff-algorithm=3Dminimal =
v2.0.0 v2.28.0'
>>             1.27 times faster than 'git diff --diff-algorithm=3Dpatience=
 v2.0.0 v2.28.0'
>>             1.41 times faster than 'git diff --diff-algorithm=3Dhistogra=
m v2.0.0 v2.28.0'

[snip around]

> If you run with more than 1 run, are your numbers even repeatable?

Yes, but tl;dr it's diff.colorMoved=3Dtrue, sorry, see below.

> I'm really surprised by these numbers; they aren't remotely close to
> what I compute.  Am I correct in understanding you ran these in
> git.git?  Was your computer overloaded?  Was your git.git in some
> serious need of repacking?  Was it on a network filesystem?=20=20

Just on the box I regularly hack on, which isn't too overloaded, but I
re-did these a bit more seriously.

This is/was on a Hetzner EX41S
(https://docs.hetzner.com/robot/dedicated-server/general-information/root-s=
erver-hardware/),
but I tried it again now in /dev/shm/git.git with a fresh repo from:

	git clone --bare git@github.com:git/git.git

And (I didn't prune out the notice here where it says it's fuzzy (not
earlier either)).

There's some Java thing eating ~50% of 1/8 CPU cores, but otherwise the
box is pretty idle, and this is current "master" with "make CFLAGS=3D-O3":
=09
	$ hyperfine -w 2 -r 10 -L a patience,minimal,histogram,myers './git -C /de=
v/shm/git.git diff --diff-algorithm=3D{a} v2.0.0 v2.28.0'
	Benchmark 1: ./git -C /dev/shm/git.git diff --diff-algorithm=3Dpatience v2=
.0.0 v2.28.0
	  Time (mean =C2=B1 =CF=83):     41.131 s =C2=B1  0.550 s    [User: 40.990=
 s, System: 0.104 s]
	  Range (min =E2=80=A6 max):   40.323 s =E2=80=A6 42.172 s    10 runs
=09
	Benchmark 2: ./git -C /dev/shm/git.git diff --diff-algorithm=3Dminimal v2.=
0.0 v2.28.0
	  Time (mean =C2=B1 =CF=83):     34.821 s =C2=B1  0.307 s    [User: 34.707=
 s, System: 0.100 s]
	  Range (min =E2=80=A6 max):   34.512 s =E2=80=A6 35.523 s    10 runs
=09
	Benchmark 3: ./git -C /dev/shm/git.git diff --diff-algorithm=3Dhistogram v=
2.0.0 v2.28.0
	  Time (mean =C2=B1 =CF=83):     45.443 s =C2=B1  0.274 s    [User: 45.328=
 s, System: 0.107 s]
	  Range (min =E2=80=A6 max):   44.932 s =E2=80=A6 45.810 s    10 runs
=09
	Benchmark 4: ./git -C /dev/shm/git.git diff --diff-algorithm=3Dmyers v2.0.=
0 v2.28.0
	  Time (mean =C2=B1 =CF=83):     33.016 s =C2=B1  0.505 s    [User: 32.893=
 s, System: 0.094 s]
	  Range (min =E2=80=A6 max):   32.376 s =E2=80=A6 33.999 s    10 runs
=09
	Summary
	  './git -C /dev/shm/git.git diff --diff-algorithm=3Dmyers v2.0.0 v2.28.0'=
 ran
	    1.05 =C2=B1 0.02 times faster than './git -C /dev/shm/git.git diff --d=
iff-algorithm=3Dminimal v2.0.0 v2.28.0'
	    1.25 =C2=B1 0.03 times faster than './git -C /dev/shm/git.git diff --d=
iff-algorithm=3Dpatience v2.0.0 v2.28.0'
	    1.38 =C2=B1 0.02 times faster than './git -C /dev/shm/git.git diff --d=
iff-algorithm=3Dhistogram v2.0.0 v2.28.0'

So that's pretty much the same as my earlier results, but between the
fresh repo, ram disk, warmup & 10 measuremnets for each these should be
more accurate.

> Using git compiled from current main, I see:
>
> $ hyperfine -L a patience,minimal,histogram,myers './git diff
> --diff-algorithm=3D{a} v2.0.0 v2.28.0'
> Benchmark 1: ./git diff --diff-algorithm=3Dpatience v2.0.0 v2.28.0
>   Time (mean =C2=B1 =CF=83):      1.142 s =C2=B1  0.033 s    [User: 1.022=
 s, System: 0.114 s]
>   Range (min =E2=80=A6 max):    1.117 s =E2=80=A6  1.212 s    10 runs
>
> Benchmark 2: ./git diff --diff-algorithm=3Dminimal v2.0.0 v2.28.0
>   Time (mean =C2=B1 =CF=83):      1.959 s =C2=B1  0.011 s    [User: 1.830=
 s, System: 0.120 s]
>   Range (min =E2=80=A6 max):    1.947 s =E2=80=A6  1.976 s    10 runs
>
> Benchmark 3: ./git diff --diff-algorithm=3Dhistogram v2.0.0 v2.28.0
>   Time (mean =C2=B1 =CF=83):      1.187 s =C2=B1  0.007 s    [User: 1.065=
 s, System: 0.115 s]
>   Range (min =E2=80=A6 max):    1.175 s =E2=80=A6  1.200 s    10 runs
>
> Benchmark 4: ./git diff --diff-algorithm=3Dmyers v2.0.0 v2.28.0
>   Time (mean =C2=B1 =CF=83):      1.194 s =C2=B1  0.007 s    [User: 1.068=
 s, System: 0.120 s]
>   Range (min =E2=80=A6 max):    1.184 s =E2=80=A6  1.206 s    10 runs
>
> Summary
>   './git diff --diff-algorithm=3Dpatience v2.0.0 v2.28.0' ran
>     1.04 =C2=B1 0.03 times faster than './git diff
> --diff-algorithm=3Dhistogram v2.0.0 v2.28.0'
>     1.05 =C2=B1 0.03 times faster than './git diff --diff-algorithm=3Dmye=
rs
> v2.0.0 v2.28.0'
>     1.71 =C2=B1 0.05 times faster than './git diff --diff-algorithm=3Dmin=
imal
> v2.0.0 v2.28.0'

But without diff.colorMoved=3Dtrue I see basically your results:
=09
	$ hyperfine -w 2 -r 10 -L a patience,minimal,histogram,myers './git -c dif=
f.colorMoved=3Dfalse -C /dev/shm/git.git diff --diff-algorithm=3D{a} v2.0.0=
 v2.28.0'
	Benchmark 1: ./git -c diff.colorMoved=3Dfalse -C /dev/shm/git.git diff --d=
iff-algorithm=3Dpatience v2.0.0 v2.28.0
	  Time (mean =C2=B1 =CF=83):     760.9 ms =C2=B1  45.2 ms    [User: 698.6 =
ms, System: 62.1 ms]
	  Range (min =E2=80=A6 max):   719.0 ms =E2=80=A6 862.2 ms    10 runs
=09=20
	Benchmark 2: ./git -c diff.colorMoved=3Dfalse -C /dev/shm/git.git diff --d=
iff-algorithm=3Dminimal v2.0.0 v2.28.0
	  Time (mean =C2=B1 =CF=83):      1.347 s =C2=B1  0.041 s    [User: 1.281 =
s, System: 0.065 s]
	  Range (min =E2=80=A6 max):    1.305 s =E2=80=A6  1.417 s    10 runs
=09=20
	Benchmark 3: ./git -c diff.colorMoved=3Dfalse -C /dev/shm/git.git diff --d=
iff-algorithm=3Dhistogram v2.0.0 v2.28.0
	  Time (mean =C2=B1 =CF=83):     826.3 ms =C2=B1  51.1 ms    [User: 767.5 =
ms, System: 58.6 ms]
	  Range (min =E2=80=A6 max):   773.7 ms =E2=80=A6 929.8 ms    10 runs
=09=20
	Benchmark 4: ./git -c diff.colorMoved=3Dfalse -C /dev/shm/git.git diff --d=
iff-algorithm=3Dmyers v2.0.0 v2.28.0
	  Time (mean =C2=B1 =CF=83):     801.1 ms =C2=B1  39.4 ms    [User: 736.0 =
ms, System: 64.9 ms]
	  Range (min =E2=80=A6 max):   771.6 ms =E2=80=A6 904.2 ms    10 runs
=09=20
	Summary
	  './git -c diff.colorMoved=3Dfalse -C /dev/shm/git.git diff --diff-algori=
thm=3Dpatience v2.0.0 v2.28.0' ran
	    1.05 =C2=B1 0.08 times faster than './git -c diff.colorMoved=3Dfalse -=
C /dev/shm/git.git diff --diff-algorithm=3Dmyers v2.0.0 v2.28.0'
	    1.09 =C2=B1 0.09 times faster than './git -c diff.colorMoved=3Dfalse -=
C /dev/shm/git.git diff --diff-algorithm=3Dhistogram v2.0.0 v2.28.0'
	    1.77 =C2=B1 0.12 times faster than './git -c diff.colorMoved=3Dfalse -=
C /dev/shm/git.git diff --diff-algorithm=3Dminimal v2.0.0 v2.28.0'

So they're all within the fuzz-factor, except "minimal".

> And this is on a kind-of low-end refurbished laptop from a few years
> ago (although the repo was recently gc'ed).
>
> I'm biased towards histogram (and making it the default rather than
> making it configurable per file), but that's probably obvious given
> that I made ort use it unconditionally.  And when I made ort use it,
> it was actually a minor performance penalty (~1% IIRC)[*], but I
> thought it was worth it since (a) histogram diffs are more
> understandable to users in general, (b) the histogram diff data
> structures provide an idea for possibly solving some ugly corner cases
> that I don't see a way to solve with the other diffs.

To bring this all home the thing I was going for upthread was to raise
"is this a concern?" I was inclined to think "no", but didn't
know. Since someone who knows way more about the diffs than I probably
ever will (i.e. you :) isn't waiving their hands in panic here I think
we can just consider this checkbox ticked.

I.e. I've seen cases (and this is from vague recollection, I've got no
examples in front of me) where one diff algorithm is worse than others
on performance.

But if your intent is to DoS a service provider you can also just commit
some very long files or whatever, so whether the user can change the
diff algorithm is probably not that interesting, as long as the
performance is within some reasonable bound.
