Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEE7C433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 21:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242335AbhKZVsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 16:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhKZVqa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 16:46:30 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B59C06173E
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 13:43:16 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r11so43911009edd.9
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 13:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=uti+m4zlmp62NnL3gPA7EkWOGYn1lvInm7eNrKXlDT8=;
        b=fYZD2tsyU6l5g0XW1ujQcXJsZQQdwp7vvTOnlW01bOIQ+fYP+1/YdYiuondZOWAsn4
         yYRQL5qx90u8RMHHg2HVnCM13A8iytntKG5N0Ty61ol+WjHzPgMNNkeCfXoWdA6rDoww
         u4Gzpj/ZSnNd0790nNA1kCN48FQWOZEH3TiHpVJOY39wCncM1SUeTeVw0Rq4EHuQtQri
         x8jPJen9KAgIsAvPXzs7FBs0KYmCf/axxwIoR879uZNct1dK0zs6T6j7aQuy926MIhKV
         2UC+rq2OubHKrJjhut5rS1EOjHd51Hio1eZ9NzX4UufeDrLUaox9NwjAoofv0FT50nph
         F7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=uti+m4zlmp62NnL3gPA7EkWOGYn1lvInm7eNrKXlDT8=;
        b=ykwx3QnOmsbIOEi+XVCiT8vt693AwBu+XharZXaP3g1HD9rXvQDgTr6PuAXmPTTJCc
         3o7lQkAaPYeffDplQUfYDrcYVbOZE0EzEEEZrUoQPg4Y2XChCPktoZShuAz+ApwuS7zr
         9+DErzJ+TkKEpJd9WCsOeP7cCoZFUyD2diRPVJoWDFL0G8kj5aslQdZloHEW6pd0q9h0
         rtHNqJXDq66F4HjZkh3cx+wZGnNOOYa7WCoyY7nkTroW7vBWUI8HigCNarUfBP6f1W07
         awPvMOPaaEbzu0MYobB/qZsAobWdsHOAtORHOvg1sA8+NxGLkiz44AIRKSNHGLIrQIVy
         sY5g==
X-Gm-Message-State: AOAM532qBHaCU+QzXiCrVYdyS+djsfiw/xniI46YHIahDNK7xtFrCyHO
        lt/57jAkIXgRh/T58EtS0deymE1lNL4TxQ==
X-Google-Smtp-Source: ABdhPJwiT373M2DSJ6Rs2F7V8FvEH1ZDE/wWHf0b+w7Ncn6uFMp6khkewN2Yf62ivXIaZPTRjnooqw==
X-Received: by 2002:a50:d710:: with SMTP id t16mr50751952edi.50.1637962994827;
        Fri, 26 Nov 2021 13:43:14 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l16sm4878567edb.59.2021.11.26.13.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 13:43:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mqizx-000Twl-ST;
        Fri, 26 Nov 2021 22:43:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Glen Choo <chooglen@google.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: The overhead of bin-wrappers/ (was: [PATCH 8/8] dir: avoid removing
 the current working directory)
Date:   Fri, 26 Nov 2021 22:40:00 +0100
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
        <20211123003958.3978-1-chooglen@google.com>
        <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
        <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
        <211124.86ee76e4fl.gmgdl@evledraar.gmail.com>
        <CABPp-BGZPheDqWD1pXbePOYe2BcT1-TqX-zGVqnNLGtFuXab1g@mail.gmail.com>
        <211124.86wnkxdbza.gmgdl@evledraar.gmail.com>
        <211124.86sfvld4cl.gmgdl@evledraar.gmail.com>
        <CABPp-BH_NfkzX5XkhPPpX1_bsR9kWGsBBdcUwikDWsA8jc6KJA@mail.gmail.com>
        <211125.86y25ciisr.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <211125.86y25ciisr.gmgdl@evledraar.gmail.com>
Message-ID: <211126.868rxaioem.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 25 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Nov 24 2021, Elijah Newren wrote:
>
>> On Wed, Nov 24, 2021 at 6:18 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
> [...]
>>> I really wish we didn't have the bin-wrappers...
>>
>> I'm curious: is this issue the only reason, or am I reading between
>> the lines correctly that you have additional reasons for that?
>
> I think it sucks in general :)
>
> This is a much bigger change than what's needed for this topic or the
> proposed setup.c change I've got, but what we should be doing in general
> with bin-wrapper is to not have them at all under RUNTIME_PREFIX=3DY
> (which we can make the default), and simply have a built/ directory or
> something, the structure of that directory will then 1=3D1 map to all the
> relative paths you'd get if you did a "make install".
>
> Currently in a built checkout you can do:
>
>     ./git version
>
> But not:
>
>     # need to add --exec-path=3D$PWD
>     ./git clone <http url>
>
> Or:
>
>     ./git send-email ...
>
> Which all comes down to sillyness in how we try to discover these paths,
> the *.mo files etc., there's also Perl-specific caveats in there.
>
> We'd still need something like a shellscript wrapper for the case of
> GIT_DEBUGGER, but we could just move that to being a compile-time flag,
> i.e. we'd swap out the "git" binary for a shellscript that chain-loaded
> to the "real" binary.
>
> It probably matters a bit for e.g. test suite performance, currently we
> spawn an extra shell for every single "git" invocation, but I mostly
> care about it for correctness, e.g. in this case of $PWD munging, and
> being able to have running a built binary from a checkout Just Work
> without the wrapper.

It also adds quite a bit of overhead to the tests, more than I vaguely
recalled. It differs by test, but here's one that invokes "git" a
lot". Trying with GIT_TEST_INSTALLED is a handy way to avoid the
bin-wrappers:
=20=20=20=20
    $ hyperfine -L e ,GIT_TEST_INSTALLED=3D/home/avar/g/git/installed/bin '=
{e} ./t3070-wildmatch.sh --root=3D/dev/shm/git'
    Benchmark 1:  ./t3070-wildmatch.sh --root=3D/dev/shm/git
      Time (mean =C2=B1 =CF=83):      4.385 s =C2=B1  0.028 s    [User: 3.7=
30 s, System: 0.824 s]
      Range (min =E2=80=A6 max):    4.340 s =E2=80=A6  4.430 s    10 runs
=20=20=20=20=20
    Benchmark 2: GIT_TEST_INSTALLED=3D/home/avar/g/git/installed/bin ./t307=
0-wildmatch.sh --root=3D/dev/shm/git
      Time (mean =C2=B1 =CF=83):      3.737 s =C2=B1  0.036 s    [User: 3.2=
40 s, System: 0.656 s]
      Range (min =E2=80=A6 max):    3.686 s =E2=80=A6  3.796 s    10 runs
=20=20=20=20=20
    Summary
      'GIT_TEST_INSTALLED=3D/home/avar/g/git/installed/bin ./t3070-wildmatc=
h.sh --root=3D/dev/shm/git' ran
        1.17 =C2=B1 0.01 times faster than ' ./t3070-wildmatch.sh --root=3D=
/dev/shm/git'

So a ~15-20% speedup, a more common case of a ~10% speedup:
=20=20=20=20
    $ hyperfine -L e ,GIT_TEST_INSTALLED=3D/home/avar/g/git/installed/bin '=
{e} ./t0001-init.sh --root=3D/dev/shm/git'
    Benchmark 1:  ./t0001-init.sh --root=3D/dev/shm/git
      Time (mean =C2=B1 =CF=83):     522.8 ms =C2=B1  22.8 ms    [User: 438=
.9 ms, System: 130.2 ms]
      Range (min =E2=80=A6 max):   502.8 ms =E2=80=A6 581.3 ms    10 runs
=20=20=20=20=20
    Benchmark 2: GIT_TEST_INSTALLED=3D/home/avar/g/git/installed/bin ./t000=
1-init.sh --root=3D/dev/shm/git
      Time (mean =C2=B1 =CF=83):     473.4 ms =C2=B1  12.6 ms    [User: 406=
.7 ms, System: 117.5 ms]
      Range (min =E2=80=A6 max):   461.0 ms =E2=80=A6 502.1 ms    10 runs
=20=20=20=20=20
    Summary
      'GIT_TEST_INSTALLED=3D/home/avar/g/git/installed/bin ./t0001-init.sh =
--root=3D/dev/shm/git' ran
        1.10 =C2=B1 0.06 times faster than ' ./t0001-init.sh --root=3D/dev/=
shm/git'

And that's on a box where process spawning is really fast, and against a
ramdisk.
