Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E5EC43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 20:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbiFNUFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 16:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiFNUFf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 16:05:35 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1224830C
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655237111;
        bh=3YPs6TEgG5txOtg2bsOrrhaurdQgfUu7qSHHnawmdsE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cqm2wU0bgRv8UQ8//rqZYhrBMA2N26qC1gzf4PvYmsu8tB0q/MDL44FSvmZZ2FnCE
         LK3EiXblW6orA4wg3vwCH5nzbpqhaXm8thMBtk6im+UHqFmv2vPSipX9uL2hYa+yOr
         K0DJxesNmeU6GoBEx50SXtexYE+erDEqfq8OAlIE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidDR-1nYDU93xup-00fgcq; Tue, 14
 Jun 2022 22:05:11 +0200
Message-ID: <0aa5c101-06bf-325c-efbc-6b4ef38616c5@web.de>
Date:   Tue, 14 Jun 2022 22:05:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/5] Avoid spawning gzip in git archive
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
 <nycvar.QRO.7.76.6.2206141043150.353@tvgsbejvaqbjf.bet>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <nycvar.QRO.7.76.6.2206141043150.353@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4c/vyruJcd0ZGHQn+WiLXpprEja44E0Re+HpslZaIsdQq9StR93
 FacFESsP1gZ8F61QF9e8plYuNtmvsG+9uge7CtpIe4CXvZnafy+fdbbbncRtALMr4NAXjGU
 uJiYoT1Dbptaf2kgwQoNu7J+7w0wRgmFFoBueL1rb/sE++SeMlpH16Ov1QWysgEcOqDIRkN
 rx6OnNyhvkiNnJ+8vL0Zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hMG9u6eYYGo=:caB4ORlyhT9CKUxlDtF3QV
 1yFKmHVAOJ5S7WIAteGFwpg+r4DIulA1xl7+Q0+AG5p/vlBtgVuWAKtxAW3FLd6YfnPlhorZc
 xwdef/d5zUUU62TLkG+Afxdbh+6rPkI7ud3GBEGqiY7NpUUL0XJofLs+gsOQVFzRORv7BM5Rw
 7gC6XDNbj/OYbhsKNwtcAkMdRjgUyAEQCnvTDRx3I7kp63BWr9qZ7cWoVKEzb+RxsyHUFO+Fy
 fVgNVlPlLK3XNAo/9BzQzg78Ct+eVO/o+wAC5mfc/YhcYFjvb93GDtsyNzJdAzWyssbASxOBI
 2qATgTpfbqyO8PFk1bi8yl+WDDFlpvoBMNBO+lEZ6zZoo84JKcoaIun/pEc6A6bcO46nTuHMB
 mP31iGKagHsr8P9WbjysoIrVN7IRBykARJKnx1HGMK9mA32yuEgD8KREA9oK14TkjPjmuEfB8
 maEQM17gQYDjBank/a+fwSnNgNbDuc2yAFGrZOYp9CNhtB6mE+vrWUTUM/6NrLfYff3BXahLh
 IWhXQzS1HgnpCbYYtRRu/kalFcksgg3tGb1T0dNzDYtAq1e+lSSsyCj0kJ/H/SymRHSBA+wQ5
 hWMVMZOHVg1E5f21sZXfZVOM/a3si/eggKYpq7SMfbn6p63VX0Vvq+AxZVqw+GkIKhwN+YlOE
 ZLohNKZlx+SR+Yn3L92KkcDtateW2SkHpqQqBogGvle/Drswoh0mCn0Q8o1yydwAbZD+hqfQu
 bE2uBsI1L3UzRXlMphIHUGZnecRSO+ivN32JFfjAlYPfSvwrrL08LcApL3KxfhGWnNv5f7KV8
 5KQCUuw5Lz1vpDYEqd9BMgy9qXXQqvszh73Z9VKygbM/n8m1fBc1Aydf6MH+2LkhXEzBZidao
 hBfdjfzUVjW/cpaANgoXms26D7zP5wHee5ftHpmURXA0eOPW4wSZJnRLfzTaSXyREvJ+sqNE4
 mPWLwcEjzstKlqwL7JaDIKKQ0ZdhN4aDhVd7oJhdUvJftSBm1Vw55kntzvyPJPYDEL7u6qCYy
 SP3LbLN5S3AVExwcPVQeSN6g0XhMPME12pvWUcv9lwQE/UeL0IwZ3+e5JssabYYZIOFPaSPb+
 6NV9oMHcOvivaeNQGGQb8FKiMqwTp3HWHt6
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.06.22 um 13:28 schrieb Johannes Schindelin:
>
> By the way, the main reason why I did not work more is that in
> http://madler.net/pipermail/zlib-devel_madler.net/2019-December/003308.h=
tml,
> Mark Adler (the zlib maintainer) announced that...
>
>> [...] There are many well-tested performance improvements in zlib
>> waiting in the wings that will be incorporated over the next several
>> months. [...]
>
> This was in December 2019. And now it's June 2022 and I kind of wonder
> whether those promised improvements will still come.
>
> In the meantime, however, a viable alternative seems to have cropped up:
> https://github.com/zlib-ng/zlib-ng. Essentially, it looks as if it is wh=
at
> zlib should have become after above-quoted announcement.
>
> In particular the CPU intrinsics support (think MMX, SSE2/3, etc) seem t=
o
> be very interesting and I would not be completely surprised if building
> Git with your patches and linking against zlib-ng would paint a very
> favorable picture not only in terms of CPU time but also in terms of
> wallclock time. Sadly, I have not been able to set aside time to look in=
to
> that angle, but maybe I can peak your interest?
I was unable to preload zlib-ng using DYLD_INSERT_LIBRARIES on macOS
12.4 so far.  The included demo proggy looks impressive, though:

$ hyperfine -w3 -L gzip gzip,../zlib-ng/minigzip "git -C ../linux archive =
=2D-format=3Dtar HEAD | {gzip} -c"
Benchmark #1: git -C ../linux archive --format=3Dtar HEAD | gzip -c
  Time (mean =C2=B1 =CF=83):     20.424 s =C2=B1  0.006 s    [User: 23.964=
 s, System: 0.432 s]
  Range (min =E2=80=A6 max):   20.414 s =E2=80=A6 20.434 s    10 runs

Benchmark #2: git -C ../linux archive --format=3Dtar HEAD | ../zlib-ng/min=
igzip -c
  Time (mean =C2=B1 =CF=83):     12.158 s =C2=B1  0.006 s    [User: 13.908=
 s, System: 0.376 s]
  Range (min =E2=80=A6 max):   12.145 s =E2=80=A6 12.166 s    10 runs

Summary
  'git -C ../linux archive --format=3Dtar HEAD | ../zlib-ng/minigzip -c' r=
an
    1.68 =C2=B1 0.00 times faster than 'git -C ../linux archive --format=
=3Dtar HEAD | gzip -c'
