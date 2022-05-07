Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5B6C433F5
	for <git@archiver.kernel.org>; Sat,  7 May 2022 15:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiEGP0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 11:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiEGP0c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 11:26:32 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019A110FD6
        for <git@vger.kernel.org>; Sat,  7 May 2022 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1651936954;
        bh=UHuR5cZSzKEtkjhHFhsziBZM0cw0MA14Be7KN3Qu7a4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WXLCdv/EYAhkOTZmtnPilbTo4SCez8ybN7W0jIlzKyHVXmlxRbZtzSQv1j55TuOYb
         EjpnXz9lpAyoqQtHwaBXNpr8mw2HYHwpeELuZMnwRPCeEGjJNlOPwDKRnr7m11RW1u
         rwktyjQaJqsq+R4ZYcfdtG5raoCVhr+nJUhsKgJg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MODmV-1nTufD2qlt-00OZ0u; Sat, 07
 May 2022 17:22:34 +0200
Message-ID: <0b79c442-9b2f-6de7-2424-9f13e9ef9878@web.de>
Date:   Sat, 7 May 2022 17:22:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH] Prevent git from rehashing 4GBi files
Content-Language: en-US
To:     Philip Oakley <philipoakley@iee.email>,
        Jason Hatton <jhatton@globalfinishing.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <CY4PR16MB1655F83010A128D4ED67C7EDAFC49@CY4PR16MB1655.namprd16.prod.outlook.com>
 <1DFD3E42-3EF3-4420-8E01-748EF3DBE7A1@iee.email>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <1DFD3E42-3EF3-4420-8E01-748EF3DBE7A1@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uDQMHz0s5Twi1JcUM9X3T2q7Jn3sEzqNxl+diXp8tkpDZmO6mCi
 Qo2DK2OWU5rw4tQlXPw3ToRqHnl7oH3onATFmJ1+L148R7uzXjceKPxLeXjkCXonTsX721w
 Y4rTqn7okudTqLyjfbpaTm1rSadc8qV9yRriytDOqoKHj+/nWWy7hIHsNMPU77dfGZSrA3p
 r+bIx/GGVZj5s8gXbjCSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TL+iYESIo2k=:yoX3FF9LreiY8giic36/3D
 CjAz8CQMmN/oHBo4tO+9bxPBRMaQKydG6cj++btENm4TqbHDbqrRCfC8pkW2TKz9pEaE2IWTa
 y6Mvimcah97vzN3IGOTTeS7GwkoKsXqFk7HtjPpNggzZDplQzI4eMSsudCWK3eJKSQqed1/um
 wtiNeozRYEOeWfCvKXcSQAUQ5lsDseEC8EciypyRq4yHdbadjPckZxCRdGH159tQc1DR0eVBO
 oS2z0zimMGNjExItSm5M++5DHkGYU4OOVskqa43T4FhIBqIE3xVy/cVh9qwaqOxQ5BtvxeKoI
 GPeRsICNG9LnZ7ySDUG4vjGS27HPdHDY1wmXZjbqmYLaflqVzuDyy4nzRM4Q/JhYCwx4mA7Vy
 N/gcgECA9S2Ug+Y7Z7cB9vBq5wykyLKatj6DxS3Hllbk5ernGtd8njPYGoKlA/MYSYmQ2WGBu
 B2+ZPsrgfhi+meziRRl3Bqd6M0wwmKSFKeAf8q7uXrzNYFy5E4arXSYZR25Ap5/SVomJiMjxh
 uBuy5lAsmbO6vTyUfDmM8DH96+iN25Hoa823gpylyScNisPccPuJ2LyAbp5HAadRl16Q0Ts/p
 gWbpKyIcwn9R86hfgVGO4l2FPz1UECUmXRHyUskBQQfO2IKDwSQqBy/2pwanNudsqM/wuwkv+
 Iu7b0nhnxcWvUdm6riKmIErWZiyRGxO2gKqswNDQBAdvzvjKmSQ7QFiFaFPRACf+u5mlMQwfe
 pTwfPameT8rBKUubdtygtUm7Wjnww1nOYpK0CPF5qarhaWBTZ4s/2zbGjqlxys6VFfzmrq1nF
 8EwR6JzTbrjABxC4+jGjAKLeOsfp+1NKsPeke0XyPnZOEJ2BeUuBHaQj6RcmP6dlCwpFiO9hI
 lwIzaKXvqGSqqrSI5yChor9jBHkQ6J/xR4J8ZvKCVcM4GULZ0weW1haWnBzGK6WZ8lz6d0JPC
 smSMcH3WksQercn1OtfnW5jvWiMVpWQQwIDBIzV/rEydZ2X4K8B9IrrMiCJxM3QF0zebxLMOW
 k0zq8AAmup8FLAp94Gd9rSZjI4FepyWWG7IIriAtBxlRi9lDVEUPi/ly1jQ5/SDjBA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.05.22 um 14:33 schrieb Philip Oakley:
>
>
> On 7 May 2022 03:15:00 BST, Jason Hatton <jhatton@globalfinishing.com> w=
rote:
>
>         Philip Oakley <philipoakley@iee.email> writes:
>
>                 This may treat non-zero multiple of 4GiB as "not racy", =
but has
>                 anybody double checked the concern R=C3=A9ne brought up =
earlier that a
>                 4GiB file that was added and then got rewritten to 2GiB =
within the
>                 same second would suddenly start getting treated as not =
racy?
>
>             This is the pre-existing problem, that ~1in 2^31 size change=
s might not
>             get noticed for size change. The 0 byte / 4GiB change is an =
identical
>             issue, as is changing from 3 bytes to 4GiB+3 bytes, etc., so=
 that's no
>             worse than before (well maybe twice as 'unlikely').
>
>
>         OK, it added one more case to 2^32-1 existing cases, I guess.
>
>                 The patch (the firnal version of it anyway) needs to be =
accompanied
>                 by a handful of test additions to tickle corner cases li=
ke that.
>
>             They'd be protected by the EXPENSIVE prerequisite I would as=
sume.
>
>
>         Oh, absolutely. Thanks for spelling that out.
>
>
>     I have been testing out the patch a bit and have good and (mostly) b=
ad news.
>
>     What works using a munge value of 1.
>
>     $ git add
>     $ git status
>
>     Racy seems to work.
>
>     $ touch .git/index 4GiB # 4GiB is now racy
>     $ git status # Git will rehash the racy file
>     $ git status # Git cached the file. Second status is fast.
>
>     What doesn't work.
>
>     $ git checkout 4GiB
>     $ fatal: packed object is corrupt!
>
>     Using a munge value of 1<<31 causes even more problems. The file has=
h in the
>     index for 4GiB files (git ls-files -s --debug) are set to the zero f=
ile hash.
>
>     I looked up and down the code base and couldn't figure out how the m=
unged
>     value was leaking out of read-cache.c and breaking things. Most of t=
he code
>     I found tends to use stat and then convert that to a size_t, not usi=
ng the
>     munged unsigned int at all.
>
>     Maybe someone else will have better luck. This seems over my head :(
>
>     Thanks
>     --
>     Jason
>
>
> Is this on Git for Windows or a 64 bit Linux?
> There are still some issues on GfW for 2GiB+ files (long Vs long long in=
t).

Which would explain the zero file hash.  And make the platform unfit for
handling big files at all at this time.

FWIW, on MacOS I get this with the patch applied:

   $ git init --quiet /tmp/a
   $ cd /tmp/a
   $ : >size-0
   $ dd if=3D/dev/zero bs=3D1 oseek=3D4294967295 count=3D1 of=3Dsize-42949=
67296
   1+0 records in
   1+0 records out
   1 bytes transferred in 0.000365 secs (2740 bytes/sec)
   $ dd if=3D/dev/zero bs=3D1 oseek=3D4294967296 count=3D1 of=3Dsize-42949=
67297
   1+0 records in
   1+0 records out
   1 bytes transferred in 0.000293 secs (3413 bytes/sec)
   $ dd if=3D/dev/zero bs=3D1 oseek=3D6442450943 count=3D1 of=3Dsize-64424=
50944
   1+0 records in
   1+0 records out
   1 bytes transferred in 0.000266 secs (3759 bytes/sec)
   $ git add size-*
   $ git commit -m initial
   [master (root-commit) d9c2a0a] initial
    4 files changed, 0 insertions(+), 0 deletions(-)
    create mode 100644 size-0
    create mode 100644 size-4294967296
    create mode 100644 size-4294967297
    create mode 100644 size-6442450944

   $ time git checkout size-*
   Updated 0 paths from the index
   git checkout size-*  0.01s user 0.01s system 65% cpu 0.020 total

   $ git ls-files -s --debug | grep size
   100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	size-0
     size: 0	flags: 0
   100644 451971a31ea5a207a10b391df2d5949910133565 0	size-4294967296
     size: 2147483648	flags: 0
   100644 3eb7feb1413c757f0d8181deb28d1dab03d64846 0	size-4294967297
     size: 1	flags: 0
   100644 741285bddfa7863072c238f34e27144c2501832d 0	size-6442450944
     size: 2147483648	flags: 0

So checkout skips all of the files and their cached sizes have the
expected values.

Ren=C3=A9
