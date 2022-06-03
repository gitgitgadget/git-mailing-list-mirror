Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425D1C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 21:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347075AbiFCVIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiFCVIF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 17:08:05 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034C9248EB
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654290473;
        bh=KnaKMAArENJkDZJoW9tMSYLbN1wekcoKi9gnK24tKyc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SwuHETeEdVmUaDzVccTh2lxFV73VyTqBjBprQNCT0Esau+2xlkh1SQSanCM6TlvYc
         IC470Wsp4OXsBQNBjZkpsr8/6Nup31CRQCqOVaBzwLqNHNenuwkpIYELG19v0lGxxV
         f7gJ8X38+9vp8I4W+th97z2rJ1SkbfGX35JPeI8U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk0W-1oKlwR0JL8-00TZoV; Fri, 03
 Jun 2022 23:07:53 +0200
Message-ID: <0c296c0e-bbd4-57a6-1cab-3b98c3bc8927@web.de>
Date:   Fri, 3 Jun 2022 23:07:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 01/15] remote.c: don't dereference NULL in freeing
 loop
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-01.15-b3a678d934a-20220603T183608Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <RFC-patch-01.15-b3a678d934a-20220603T183608Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E1kPLpz+kfpLZC5cJ2WBG2CprUOh7gv4FVzkOGo4Ha8TQVZDqwO
 5ft20o6cq4Ug2vfATEDYxkN0hbTTpiH4Wz0RgYQ4l0iVg4LvFqoz6sXcGGmoVGG9k/Tfbop
 BCBdncie01fm5X4FhdjUfFU0X5gaW8y2YmEiKZM9OVIkB7w5O67eh/cqj6l8qBLqZ6bcEAV
 HiPjYOkOdoiY1xu7votwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7+tVukOuGS4=:QkreoC+/iABAcx3Wgwi6Ng
 D7hI9ylpnpTfhXUIqM09At12g0XLFKrPE6o3jOaP9P51G2+EuhegZJfyIkig6KxxSa2hEEUo8
 kGhH4TckQhCq61TduiRJGixbGFvmQTCZue4ZpGx87IUI+VeTBK5+mAoLWUCppfV0g+VdHZ22T
 nTslhxnEPctTkMyjfsbc/6Ths7FxKxPflhx4ST3QUWwfFnE65yYNXN0LLW3uYjZoAw0Lu4sQV
 XpstddoVZ3CzE8X/tgR6PakT++R5zg8IZfGLprw3IULIPhL6Kc2fnnd0sgfB2m24Ye7NdaWKQ
 KT5WQAEgneCdaPst/0509XXQGwQVFr1UY5rAd/5vLUdxSCj/TKpkY9CH1GA/10M2jF/xZqkiU
 T99bE4TA6YBY1IvywPi9JhGrVVLjG3iUAmhXnzDGTixPRBCWZfXHyInryZVlWoy/b6BLZf8TI
 bbpxXiDGZt22NejoT+1uGcoWGZ9J0R22cVg765CkSPdiz/q6WKar8u0UjnmH8wrjLuqj+QXaL
 IiBtdXaUTBjE8oanaKXcqlI8hFcjZaSe+TQFc6wlGNx81AzvJlcHzNf0WwXNTB6qqclnpEHKc
 oP9Xqt7WZPQ0Sw+fsFDLDkjyU7DWUVDdiJ8GmUBvw/QTZ4BnvIGbuw0NGwSIY2bdxqx0b5p4Q
 sBsiTdakvCbrEfAfu/oja7m+QOwebwDb151CyeSaRJa6xsiiRM7yrOf6jAhc6Rn0ZEXwHNekJ
 nOjXR534zcdR1yccJuMccg78/yJ4FimAisSTpp2smEvcnpdQkJpyBxgR2XCC2Pa67h2tNynL1
 xYMHqm3hUef1lsBwwIWnTk+pkgBmbuv1nrBzZ+A9j1vwc/vMRA5qUAYrPbF2Zg01qPkmiNcsV
 WFzcOgJFl94I9bH0+nK3DGujhcnM5ifloxlkwtUK4gW4L02RhKxgbXjvZ3ByHQcEruZf9+nKj
 GOfAXxGFxeBU155uI2J0zBhnjDM4ttVfoiXLr0sBtZesVe62HsyB0gnUzmo+6Csp5sVg55592
 2Lt++sIIxmC3/+d5EAQ3s6h4UTA3//6iXVvDhP4VJfcEYGblgeMlHHJs7G5UjjJyuHciDfQFF
 EEJ7qapw0qdtz0Vx8RDNgokPJHieNGadCNN
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.22 um 20:37 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Fix a bug in fd3cb0501e1 (remote: move static variables into
> per-repository struct, 2021-11-17) where we'd free(remote->pushurl[i])
> after having NULL'd out remote->pushurl. itself.
>
> While we're at it let's get rid of the redundant braces per the
> CodingGuidelines, which also serves to show in the diff context that
> we were doing a FREE_AND_NULL(remote->pushurl) afterwards too, let's
> keep that one.

The extended context is helping, but the brace removal makes this change
harder to read.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  remote.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 930fdc9c2f6..61240562df1 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -144,14 +144,10 @@ static void remote_clear(struct remote *remote)
>  	free((char *)remote->name);
>  	free((char *)remote->foreign_vcs);
>
> -	for (i =3D 0; i < remote->url_nr; i++) {
> +	for (i =3D 0; i < remote->url_nr; i++)
>  		free((char *)remote->url[i]);
> -	}
> -	FREE_AND_NULL(remote->pushurl);

So you remove the redundant release of the pushurl array, but the url
array, which should be freed here after its elements are released, still
leaks.  The duplicate FREE_AND_NULL perhaps resulted from a copy&paste
error.

> -
> -	for (i =3D 0; i < remote->pushurl_nr; i++) {
> +	for (i =3D 0; i < remote->pushurl_nr; i++)
>  		free((char *)remote->pushurl[i]);
> -	}
>  	FREE_AND_NULL(remote->pushurl);

Why set pushurl to NULL after release?  This results in an invalid state
unless pushurl_nr und pushurl_alloc are reset to zero.  Same goes for
the url array above -- either a simple free(3) call suffices or url_nr
and url_alloc need to be cleared as well.

>  	free((char *)remote->receivepack);
>  	free((char *)remote->uploadpack);
