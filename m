Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64ADC71155
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 20:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1022073C
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 20:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Y+0aywJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgK3URp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 15:17:45 -0500
Received: from mout.web.de ([212.227.15.3]:57251 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgK3URp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 15:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1606767348;
        bh=Xj/f6p3OR48W5yvbcdBPZWop2TfA/X9TQmHBYh5UNvs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Y+0aywJZrslhzaNNNW7KM08cz6rlvIqVk82kUNxLywf1yMi3uEDi2N/XB62o2WI4X
         oyrpwqy2uYTXXO7JdT+1O+d3mnl7wERFWbqHiRGIJchv7q1nzeP7niNMh8rLIj/IU+
         hMh3VqeQdsDo6WO4xGxfT43JMcauxINhJZyEDnLQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MODmf-1kYTpi3eqv-00OaFJ; Mon, 30
 Nov 2020 21:15:47 +0100
Subject: Re: [PATCH] fetch-pack: disregard invalid pack lockfiles
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <c54233ce-ff72-ca29-68c2-1416169b8e42@web.de>
 <X8VNszeQKJPfZ+Ht@nand.local>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <67cf2f10-43a4-1200-0c60-dada466eadb9@web.de>
Date:   Mon, 30 Nov 2020 21:15:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X8VNszeQKJPfZ+Ht@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ErKZWtFlM+bqPYiDadPOh1r7rGFggA/E2dWYlvw29VThSAER9Sz
 FLPZpfQG+8wYOucyuU5FrQbVOJFnzd9H2KbSw3r3SD/ttxtWng+kFJBhHyFxmfiXa9lFM7C
 RfJhO/8FkJ6kVynSIJ9momtv6GiNWW3JNcoAMk1AIka5W8NEZ2qd1i3WdzgIdzzKfusU36u
 skbA8e/bxjsHp9TtBFzXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kpf6x57yrHs=:EQAGGoDJPhp9hWEHmlUSI3
 J/+QqzlLm4TtBzMZL7QZpsl6Y3yaspDeQ8yLnUcM1yop0aYvgkvmSPMRLFC00L/Yj5OA8utkS
 A0WrbeO7BlybVmvzYiUah0KLaGTC/pZs9DxOYlZZzaAVq1pTlilypUD2kTvBlxus1mOnLZmxJ
 x6wYyRJXRimMBdIV9DW8t81phUONZzGnoS47odfswI/2aIrWXkZEt2eFoTLusF9ZxzcDbeIp9
 EkzkVgfgpCHi2azVKhHKPyB0IWDTNSQtEBF7wyaIdAHkiUxNOXW0mCOsaUrSj1YhwnrMkSNV7
 /AOo6Z3rVy9yF9wYqbnNvVh/VWVp0/bdlBARl77OfiRPWudPzhbtGY+NJUvn4WBRkOv3T0zut
 URy84OBRGUMn+7yfVDcmPVxfxwWm6UOxTQRe87tzpvsCna7jyBN8uhGuV5LP/KRRERbvWYlMq
 lfp4yOUiPuSD2I0IzGIvw3tGOPrADS+qVFtLD/G3KlApH65VBJX+JAj4B7624C19pKZvMOphJ
 HoDg7pXhQySmn86H0/ef1nR943ZmQlsyg/4HyCx3yQrRKnAreXa/A9MmOHTRZWj+EOw5I2C4n
 ymLZ+W9RJDbJQw7IEmt6AHMU+SpEl2J38DoOh3HfPbRXUZ/TgiZjv7Z3RuPGBf4K9n5UDgXiH
 X5PT4aoxcdIoY9elemV6m3TirVzfITnY9jjMOqmZqa0fjPeeuln4aGQBdfFYCYvSZ4HkznwCp
 nyBLfNAq9uIZUmzIYMo0U0pIvj/w0RYeoptLkev1BVjj57JMf3EU/7poTRatabrhHdsPas2zZ
 4FnXJf4X53YqYK7vOWCWr5sd0TiqiqIAA0c99eeKkJZUj2ernw8h/uRJcDV4ELIcxJwz4Pxm9
 NayZ8/oeYjW8U/QVPkCw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.11.20 um 20:53 schrieb Taylor Blau:
> On Mon, Nov 30, 2020 at 08:27:15PM +0100, Ren=C3=A9 Scharfe wrote:
>> index_pack_lockfile() can return NULL if it doesn't like the contents i=
t
>> reads from the file descriptor passed to it.  unlink(2) is declared to
>> not accept NULL pointers (at least with glibc).  Undefined Behavior
>> Sanitizer together with Address Sanitizer detects a case where a NULL
>> lockfile name is passed to unlink(2) by transport_unlock_pack() in t106=
0
>> (make SANITIZE=3Daddress,undefined; cd t; ./t1060-object-corruption.sh)=
.
>
> Which test in t1060? I tried to reproduce this myself, but couldn't seem
> to coax out a failure. (Initially I thought that my ccache wasn't
> letting me recompile with the SANITIZE options, but running 'ccache
> clear' and then trying again left the test still passing).

15 - fetch into corrupted repo with index-pack

   $ cat trash\ directory.t1060-object-corruption/bit-error-cp/stderr
   error: inflate: data stream error (invalid distance too far back)
   error: unable to unpack d95f3ad14dee633a758d2e331151e950dd13e4ed header
   fatal: cannot read existing object info d95f3ad14dee633a758d2e331151e95=
0dd13e4ed
   fatal: index-pack failed
   wrapper.c:568:52: runtime error: null pointer passed as argument 1, whi=
ch is declared to never be null
   /usr/include/unistd.h:825:48: note: nonnull attribute specified here
   SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior wrapper.c:568:5=
2 in
   Aborted

Compiled with:
   Debian clang version 11.0.0-5+b1
   Target: x86_64-pc-linux-gnu
   Thread model: posix
   InstalledDir: /usr/bin

Ren=C3=A9
