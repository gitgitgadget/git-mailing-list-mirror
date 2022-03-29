Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9FBC433FE
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 16:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbiC2Qxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbiC2Qxd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 12:53:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B921CD6E
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 09:51:47 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bq24so15381360lfb.5
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 09:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=is8cpM7FQ2fmHUo0LochN4i6tNgwouMFMPU+6hhZvik=;
        b=HvBnTeNQezaTHnU3ccGkHDokZDnSg7+wh/jgYZCW7M8h+v+LpuhsCHaJyMqmsbJHuU
         +4Eoe0kbAbjaSNtw45TfSp6lx8+YZ6XCjm0h6BgE+xrEBFhYkhkeLrGArAoTL9V7KZhj
         T8br+nSAJaKQzKvWchYCQTGBUkwpHoFJHlklM15OHDMl+v0iV1OTyla4acvHbhe4NXf2
         E8VLlL0KhLv5Y2G8hYC7wNQzLQIQOoiRKIkBl0d7gj61ZVubUWb2dh3OL4lHOeZrBq3i
         gGfjgLqrFyQRr9LOzjiB8bI4t95GPVftdJG+OHDRGrql4Fyzrz8IuWyQG2v9VKCSgzlu
         QTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=is8cpM7FQ2fmHUo0LochN4i6tNgwouMFMPU+6hhZvik=;
        b=KfViRAXFMhwBwjoak6ZbPBzZsOpA20cKfnbqCzyszllNXB01c9DYLm4/pVrH5sD1xt
         tURIh45djB3nvPFhdO7d/+V+m2TM5OVw1m1d5YJ00pOBCDuy51kBDDMpkbXzLNTvElug
         uGiEfity6wIQ64H+9oYlXybS3kOzA8E6vXkTxCAicSxFlteviST/8GOA3luzMVeMbaWp
         uyoc4T5KRE/d/jkdv0xKaMtaOdsikVCYFwl/XtP2ZsUoPGxgSlWNu1mhaLP2+Z6KKoIv
         F4JU3jKgg1CBseMsyUnfduylMVuJkBImBhclwRZT/RlVdtKos5Sl3QqKy7si3HEFJrjR
         l9oA==
X-Gm-Message-State: AOAM530kHUn/ItEQmVwLi12kqFeJ9wA99NqbJLNttaWN2VMx5jw2NJPU
        okHwGXPnSMhPo549h1OT21Onm03GQKfxaVeLkKo=
X-Google-Smtp-Source: ABdhPJwLFTDQDTBg/87+tgGiVEvnhnqkAkBvnyXeuhL+ghQZ9qbFf8owa1Ub9CQGGu9rtevVfPl2IDAtNprPe+g5hd8=
X-Received: by 2002:a05:6512:3f09:b0:43a:4463:56f9 with SMTP id
 y9-20020a0565123f0900b0043a446356f9mr3495919lfa.533.1648572705701; Tue, 29
 Mar 2022 09:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
 <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com> <220329.868rst2cei.gmgdl@evledraar.gmail.com>
In-Reply-To: <220329.868rst2cei.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 29 Mar 2022 09:51:33 -0700
Message-ID: <CANQDOdcK=2WakB0o2PyGGOHgMMLzYrAeW8tTnpQgG5H0Y5UB-g@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] core.fsyncmethod: add 'batch' mode for faster
 fsyncing of multiple objects
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 29, 2022 at 5:04 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Mar 29 2022, Neeraj K. Singh via GitGitGadget wrote:
>
> > V4 changes:
> >
> >  * Make ODB transactions nestable.
> >  * Add an ODB transaction around writing out the cached tree.
> >  * Change update-index to use a more straightforward way of managing OD=
B
> >    transactions.
> >  * Fix missing 'local's in lib-unique-files
> >  * Add a per-iteration setup mechanism to test_perf.
> >  * Fix camelCasing in warning message.
>
> Despite my
> https://lore.kernel.org/git/220329.86czi52ekn.gmgdl@evledraar.gmail.com/
> I eventually gave up on trying to extract meaningful numbers from
> t/perf, I can never quite find out if they're because of its
> shellscripts shenanigans or actual code.
>
> (And also; I realize I didn't follow-up on
> https://lore.kernel.org/git/CANQDOdcFN5GgOPZ3hqCsjHDTiRfRpqoAKxjF1n9D6S8o=
D9--_A@mail.gmail.com/,
> sorry):
>

Looks like we aren't actually hitting fsync in the numbers you
expressed there, if they're down in the 20ms range.  Or we simply
aren't adding enough files.  Or if that's against a ramdisk, the
ramdisk doesn't have enough cost to represent real disk hardware.

> But I came up with this (uses my thin
> https://gitlab.com/avar/git-hyperfine/ wrapper, and you should be able
> to apt get hyperfine):
>
>         #!/bin/sh
>         set -xe
>
>         if ! test -d /tmp/scalar.git
>         then
>                 git clone --bare https://github.com/Microsoft/scalar.git =
/tmp/scalar.git
>                 mv /tmp/scalar.git/objects/pack/*.pack /tmp/scalar.git/my=
.pack
>         fi
>         git hyperfine \
>                 --warmup 1 -r 3 \
>                 -L rev neeraj-v4,avar-RFC \
>                 -s 'make CFLAGS=3D-O3 && rm -rf repo && git init repo && =
cp -R t repo/ && git ls-files -- t >repo/.git/to-add.txt' \
>                 -p 'rm -rf repo/.git/objects/* repo/.git/index' \
>                 $@'./git -c core.fsync=3Dloose-object -c core.fsyncMethod=
=3Dbatch -C repo update-index --add --stdin <repo/.git/to-add.txt'
>
>         git hyperfine \
>                 --warmup 1 -r 3 \
>                 -L rev neeraj-v4,avar-RFC \
>                 -s 'make CFLAGS=3D-O3 && rm -rf repo && git init repo && =
cp -R t repo/' \
>                 -p 'rm -rf repo/.git/objects/* repo/.git/index' \
>                 $@'./git -c core.fsync=3Dloose-object -c core.fsyncMethod=
=3Dbatch -C repo add .'
>
>         git hyperfine \
>                 --warmup 1 -r 3 \
>                 -L rev neeraj-v4,avar-RFC \
>                 -s 'make CFLAGS=3D-O3' \
>                 -p 'git init --bare dest.git' \
>                 -c 'rm -rf dest.git' \
>                 $@'./git -C dest.git -c core.fsyncMethod=3Dbatch unpack-o=
bjects </tmp/scalar.git/my.pack'
>
> Those tags are your v4 here & the v2 of the RFC I sent at
> https://lore.kernel.org/git/RFC-cover-v2-0.7-00000000000-20220323T140753Z=
-avarab@gmail.com/
>
> Which shows my RFC v2 is ~20% faster with:
>
>     $ PFX=3D'strace' ~/g/git.meta/benchmark.sh "strace "
>
>     1.22 =C2=B1 0.02 times faster than 'strace ./git -c core.fsync=3Dloos=
e-object -c core.fsyncMethod=3Dbatch -C repo update-index --add --stdin <re=
po/.git/to-add.txt' in 'neeraj-v4'
>     1.22 =C2=B1 0.01 times faster than 'strace ./git -c core.fsync=3Dloos=
e-object -c core.fsyncMethod=3Dbatch -C repo add .' in 'neeraj-v4'
>     1.00 =C2=B1 0.01 times faster than 'strace ./git -C dest.git -c core.=
fsyncMethod=3Dbatch unpack-objects </tmp/scalar.git/my.pack' in 'neeraj-v4'
>
> But only for add/update-index, is the unpack-objects not using the
> tmp-objdir? (presumably yes).
>
> As noted before I've found "strace" to be a handy way to "simulate"
> slower FS ops on a ramdisk (I get about the same numbers sometimes on
> the actual non-SSD disk, but due to load on the system (that I'm not in
> full control of[1]) I can't get hyperfine to be happy with the
> non-fuzzyness:
>

At least in this case, I don't think 'strace' is representative of
what a real disk would behave like.  Unless you can somehow make
strace of sync_file_range cost less than strace of fsync.

>     1.06 =C2=B1 0.02 times faster than './git -c core.fsync=3Dloose-objec=
t -c core.fsyncMethod=3Dbatch -C repo update-index --add --stdin <repo/.git=
/to-add.txt' in 'neeraj-v4'
>     1.06 =C2=B1 0.03 times faster than './git -c core.fsync=3Dloose-objec=
t -c core.fsyncMethod=3Dbatch -C repo add .' in 'neeraj-v4'
>     1.01 =C2=B1 0.01 times faster than './git -C dest.git -c core.fsyncMe=
thod=3Dbatch unpack-objects </tmp/scalar.git/my.pack' in 'neeraj-v4'
>
> FWIW these are my actual non-fuzzy-with-strace numbers on the
> not-ramdisk, as you can see the intervals overlap, but for the first two
> the "min" time is never close to the RFC v2:
>
>         $ XDG_RUNTIME_DIR=3D/tmp/ghf ~/g/git.meta/benchmark.sh
>         + test -d /tmp/scalar.git
>         + git hyperfine --warmup 1 -r 3 -L rev neeraj-v4,avar-RFC -s make=
 CFLAGS=3D-O3 && rm -rf repo && git init repo && cp -R t repo/ && git ls-fi=
les -- t >repo/.git/to-add.txt -p rm -rf repo/.git/objects/* repo/.git/inde=
x ./git -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch -C repo up=
date-index --add --stdin <repo/.git/to-add.txt
>         Benchmark 1: ./git -c core.fsync=3Dloose-object -c core.fsyncMeth=
od=3Dbatch -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'ne=
eraj-v4
>           Time (mean =C2=B1 =CF=83):      1.043 s =C2=B1  0.143 s    [Use=
r: 0.184 s, System: 0.193 s]
>           Range (min =E2=80=A6 max):    0.943 s =E2=80=A6  1.207 s    3 r=
uns
>
>         Benchmark 2: ./git -c core.fsync=3Dloose-object -c core.fsyncMeth=
od=3Dbatch -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'av=
ar-RFC
>           Time (mean =C2=B1 =CF=83):     877.6 ms =C2=B1 183.4 ms    [Use=
r: 197.9 ms, System: 149.4 ms]
>           Range (min =E2=80=A6 max):   697.8 ms =E2=80=A6 1064.4 ms    3 =
runs
>
>         Summary
>           './git -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch=
 -C repo update-index --add --stdin <repo/.git/to-add.txt' in 'avar-RFC' ra=
n
>             1.19 =C2=B1 0.30 times faster than './git -c core.fsync=3Dloo=
se-object -c core.fsyncMethod=3Dbatch -C repo update-index --add --stdin <r=
epo/.git/to-add.txt' in 'neeraj-v4'
>         + git hyperfine --warmup 1 -r 3 -L rev neeraj-v4,avar-RFC -s make=
 CFLAGS=3D-O3 && rm -rf repo && git init repo && cp -R t repo/ -p rm -rf re=
po/.git/objects/* repo/.git/index ./git -c core.fsync=3Dloose-object -c cor=
e.fsyncMethod=3Dbatch -C repo add .
>         Benchmark 1: ./git -c core.fsync=3Dloose-object -c core.fsyncMeth=
od=3Dbatch -C repo add .' in 'neeraj-v4
>           Time (mean =C2=B1 =CF=83):      1.019 s =C2=B1  0.057 s    [Use=
r: 0.213 s, System: 0.194 s]
>           Range (min =E2=80=A6 max):    0.963 s =E2=80=A6  1.076 s    3 r=
uns
>
>         Benchmark 2: ./git -c core.fsync=3Dloose-object -c core.fsyncMeth=
od=3Dbatch -C repo add .' in 'avar-RFC
>           Time (mean =C2=B1 =CF=83):     918.6 ms =C2=B1  34.4 ms    [Use=
r: 207.8 ms, System: 164.1 ms]
>           Range (min =E2=80=A6 max):   880.6 ms =E2=80=A6 947.5 ms    3 r=
uns
>
>         Summary
>           './git -c core.fsync=3Dloose-object -c core.fsyncMethod=3Dbatch=
 -C repo add .' in 'avar-RFC' ran
>             1.11 =C2=B1 0.07 times faster than './git -c core.fsync=3Dloo=
se-object -c core.fsyncMethod=3Dbatch -C repo add .' in 'neeraj-v4'
>         + git hyperfine --warmup 1 -r 3 -L rev neeraj-v4,avar-RFC -s make=
 CFLAGS=3D-O3 -p git init --bare dest.git -c rm -rf dest.git ./git -C dest.=
git -c core.fsyncMethod=3Dbatch unpack-objects </tmp/scalar.git/my.pack
>         Benchmark 1: ./git -C dest.git -c core.fsyncMethod=3Dbatch unpack=
-objects </tmp/scalar.git/my.pack' in 'neeraj-v4
>           Time (mean =C2=B1 =CF=83):      1.362 s =C2=B1  0.285 s    [Use=
r: 1.021 s, System: 0.186 s]
>           Range (min =E2=80=A6 max):    1.192 s =E2=80=A6  1.691 s    3 r=
uns
>
>           Warning: Statistical outliers were detected. Consider re-runnin=
g this benchmark on a quiet PC without any interferences from other program=
s. It might help to use the '--warmup' or '--prepare' options.
>
>         Benchmark 2: ./git -C dest.git -c core.fsyncMethod=3Dbatch unpack=
-objects </tmp/scalar.git/my.pack' in 'avar-RFC
>          =E2=A0=8F Performing warmup runs         =E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91 =E2=A0=99 Performing warmup runs         =E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=
=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=
=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=E2=96=91=
=E2=96=91=E2=96=91=E2=96=91=E2=96=91  Time (mean =C2=B1 =CF=83):      1.188=
 s =C2=B1  0.009 s    [User: 1.025 s, System: 0.161 s]
>           Range (min =E2=80=A6 max):    1.180 s =E2=80=A6  1.199 s    3 r=
uns
>
>         Summary
>           './git -C dest.git -c core.fsyncMethod=3Dbatch unpack-objects <=
/tmp/scalar.git/my.pack' in 'avar-RFC' ran
>             1.15 =C2=B1 0.24 times faster than './git -C dest.git -c core=
.fsyncMethod=3Dbatch unpack-objects </tmp/scalar.git/my.pack' in 'neeraj-v4=
'
>
> 1. I do my git hacking on a bare metal box I rent with some friends, and
>    one of them is running one those persistent video game daemons
>    written in Java. So I think all my non-RAM I/O numbers are
>    continually fuzzed by what players are doing in Minecraft or whatever
>    that thing is...

Thanks for the numbers.  So if I'm understanding correctly, the
difference on a real disk between quarantine and non-quarantine is 20%
or so on your system?

I did my own experiment by adding a 'batch-no-quarantine' method. No
quarantine was slightly faster.
*  For 'git add' I found a very small difference (.29s vs 30s).
* For 'git stash' it was a bit bigger (.35s vs.55s).

This is with perf-lib, so we're just looking at min-times.  On the
other hand, classic fsync is 1.04s for 'git add' and 1.21s for 'git
stash', all with 500 tiny blobs.  FYI, this is measured on my laptop
running Ubuntu in WSL.

 I don't think it's worth having a knob for no-quarantine for this
small delta.  I believe a better use of time for a follow-on change
would be to implement an appendable pack format for newly-added
objects.

Thanks,
Neeraj
