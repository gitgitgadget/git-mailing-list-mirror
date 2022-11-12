Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F27EC433FE
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 10:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbiKLKmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 05:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiKLKma (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 05:42:30 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A345712777
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 02:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668249730; bh=WUucMRErQ2SNYFAlRBbJYdKND70Md08p2zZbfHf8Vgg=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
        b=ix4KYpVMgS0fOWpK5UiMn3PYI8gWAmUhixgJKUxddNZO+9kqd7/wtc2oo4HBn33lE
         xUMvhuO1wtMSDnjHIq/ylG/P3qD2j9vIzqm+plYzhuJMQATOxc4fzSenNSg2aJ4znF
         KIEGqHTAdi3IMY0n3TP/bCCfxgUkqBNb4Erv4S4Wp0vi2Rhw1ALGMW5rOcHm0BBe6m
         nzBY6Bk0DitC+px3Kuhm9WY3H/No0tYJlYcQE+d8V7OMn0Fy3hdmvsBJtsq6ABsQk2
         YonYNza01YNVK562BhISiZV64JigZGkKRgsxbldMgIpMutN5GeyFTsfZllpk4ik9pM
         QrpFSC9LFZMtQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.27.139]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPrY-1p7cWS2sT0-00v2BG; Sat, 12
 Nov 2022 11:42:10 +0100
Message-ID: <36337a3f-6443-f272-09f0-7ddb3c20d7a4@web.de>
Date:   Sat, 12 Nov 2022 11:42:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 09/13] parse-options API: don't restrict OPT_SUBCOMMAND()
 to one *_fn type
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
 <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
 <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de>
 <221105.861qqhxz0o.gmgdl@evledraar.gmail.com>
 <25776063-a672-fc65-bed3-1bc8536ab8b3@web.de>
 <221105.86o7tlvxh0.gmgdl@evledraar.gmail.com>
 <46ee3f92-943f-10d5-7ec5-c68f1ced87ce@web.de>
 <221106.86k048w2f4.gmgdl@evledraar.gmail.com>
Content-Language: en-US
In-Reply-To: <221106.86k048w2f4.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/+E+cCkHlmDTRMIcYqb63MbBv5hL6yPerCRzKefPYN4BPJkqPrO
 dJXehMl/jQCVey66yQUa7crMw9b6awgubbsRD3yKsg7kC75lPFyQ8+t/gHfErAJQ51Vp5Ps
 Vu7rO8AF+Is+oy29JXrwz0cojEe9iYyafK8bsCJkIZM64P1V5gRd/TFOpUuKdphlY1Dnw9m
 Ur4y7saIT2pN+lb2X64mw==
UI-OutboundReport: notjunk:1;M01:P0:1gQwEA50LZs=;FpF68vVWiEBdnBgrbO29fr8QgJx
 C9pf5P/pioBPtbGcKH0BhQZuBkm/qSGSzwIg2TRjdhE9iueH0DUdhXM477K9gPsc76VNgb8P/
 afxdwhEJTm6HYGtUShaPXh66HWRlAtPIcF4wREdjo6FTk4maIWzJsZWe7MOrQuL5gX2k9tCo8
 4XpoGB5Mc4eS2N6NeYluej5ZLh0nHpTH3rruSbJMVh1K+MNAx2c2e5vFVsOBeOvw4JCRLd2nK
 M1o9UW8jcKboZu8nwPI8l7FYoKCHJJq6AaMWJzBpBn0Zzfv4LxakLiNqUfFB+gBwwav/Lt1UB
 Iy24CkVzo3K0rinH5uHtZVzNcQHemeCtPJb+5e3Jqo8aik5ju4GqQMPQuAaWGZJxtBB7a3XpV
 XLZmscaN7x9tzAP2sG8731VXB9+TvRtDAedgr1qHDQdffug+ErHMrmBzTRM2zHq6TC7LYs3uq
 eEZE+1VbAwZ/GZ6ffKIPEGJxpIOlJSGs4bO33cTNhVV6LQT0LuJwV3aXu4R7u6gJ6hmP2mfjM
 ruTJWlgCyWlTSKfxopabKtfIOpLKw8qzc2BoaDqoyogxXSEaP9X5imYkRaoD57GSnM21GQxkv
 IibqgbObwee6QvddlUmWEvdsXK64e4c7c1aiwKGxsou6dzZNNUgtsPhWuso/7nbm9OvPFuiff
 rHL6xDC2ReLHTWSc90Tn3iqXgWS2uy31VyxQbeKxPtNnrkhvhSdkfrdJunfZQ9i+vS4H+duQ4
 cd+b9/maBgQnU/c92bu+2+eUHTwYITUtrY9Oz+ziNtiYUgPrHedI+O+0Jzgk7opZQNQv6i2am
 xBZRmTL6FDVNdL7qrVz+c6nDtSeA+XfBIFYUT5ibM9m57xGGCa5K2NU4HcXivc9pbNYNjquC6
 GIEdHT1LbSLvkc9D788Wkkaff4GkN7ks0mSWyGb81TqEpH0xI9BW/GTHQifeyRofO6qd8BssC
 T2jNonS3wKjZXYeB+aMZmvJK7y8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.11.22 um 14:28 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> No, I think that:
>
> 1) J.5.7 does that on its own for C99

An extension is not part of the standard, by definition.  Section J is
informative, not normative.  J.5.7 just says that there are systems out
there which allow casts from function pointers to object pointers and/or
back, which is not portable.

> 2) POSIX has orthagonally mandated this, seperate from C99.

It only requires dlsym(3) to work.  That's a narrow case.  A conforming
implementation could have function pointers wider than object pointers,
making conversions in the other direction lossy.  Or have function
pointers narrower than object pointers and let dlopen(3) place symbols
only in the range addressable by those.

> In practice I think it's always worked for dlsym(), but there's
> interesting changes in wording between v6 and v7 of POSIX:
>
>    - https://pubs.opengroup.org/onlinepubs/009695399/functions/dlsym.htm=
l
>    - https://pubs.opengroup.org/onlinepubs/9699919799/functions/dlsym.ht=
ml
>
> v6 claims that conforming C compilers are required to produce a warning
> if this isn't supported (I haven't found the part of the standard
> they're referencing), and notes that the behavior may be deprecated in
> the future.
>
> Whereas v7 says that POSIX "requires this conversion to work correctly
> on conforming implementations".

=46rom the second link: "The dlsym() function is moved from the XSI option
to the Base."  So dynamic libraries are no longer optional on POSIX
systems.  That means you can use dlsym(3) on any compliant system.  You
can also safely store its return value in an intptr_t IIUC.  But that
doesn't generalize to all function pointers.

> I think it's useful in itself to see what subset or superset of C we
> actually need to concern ourselves with.
>
> E.g. we have plenty of code that assumes ASCII, instead of catering to
> EBCDIC, and assuming NULL is (void *)0, not (void *)123456 or whatever.

NULL is defined as "0" or "(void *)0" by C99 6.3.2.3 Pointers paragraph
3 and 7.17 Common definitions <stddef.h> paragraph 3.

> Yes, in this case the alternative is trivial, but perhaps we'd find a
> use-case in the future.
>
> All I'm saying is let's leave the current one in place, as there's no
> indication that it's not supported by our targets.

Leaving undefined behavior in the code in the hope that we may come up
with a compelling use case for it later is a bad idea.  I really hope
we never find one.

Ren=C3=A9
