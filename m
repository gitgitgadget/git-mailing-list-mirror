Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE118C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 09:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiHJJHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 05:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiHJJHm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 05:07:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1027E83D
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 02:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660122446;
        bh=8Qds9Nh3kzHu9kDypMUf5SZloFIsDx+MZ6LJCreKR/s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CvWOKJbzKDkt9MomlMJnUoxv3A9b3PMVcx6IuzmVxqWf78XM5sP86+vNEBKrh0RNO
         kGqNfQ/Ws+qH8T1TtfXya4sc9vgOw8ejs8WtWXoBnhzH2u6Ac/4PIlbP3/bzKDW3dt
         p06Ele61E0e6xj42K/pF9kSRpZJpfigNMv6f8ozI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.204.74] ([89.1.214.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MplXp-1ncQBX1ARJ-00q7oz; Wed, 10
 Aug 2022 11:07:26 +0200
Date:   Wed, 10 Aug 2022 11:07:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] mingw: handle writes to non-blocking pipe
In-Reply-To: <72d007c5-9429-1612-24d7-af5db906dd63@web.de>
Message-ID: <1739sr2q-71p7-q601-2022-ps56r12pos50@tzk.qr>
References: <YuikU//9OrdpKQcE@coredump.intra.peff.net> <YulFTSTbVaTwuQtt@coredump.intra.peff.net> <xmqq5yjahb8u.fsf@gitster.g> <YunxHOa2sJeEpJxd@coredump.intra.peff.net> <a9953278-b15f-fd76-17b0-e949c7937992@web.de> <YuquVEqEl6wxCLM7@coredump.intra.peff.net>
 <41477326-5493-4d3c-246d-8a28969fa73e@web.de> <Yu05GjncDaGRTgce@coredump.intra.peff.net> <6854c54c-12ff-f613-4cdc-18b3b1a55ef1@web.de> <b3310324-7969-f9fb-a2e0-46e881d37786@web.de> <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
 <72d007c5-9429-1612-24d7-af5db906dd63@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1543481212-1660122449=:206"
X-Provags-ID: V03:K1:A89qXj0neWyXRuRUoeyvfvie2AzGY4Se35swS3qiMq+y0HDskn8
 KqCl4LhXyfpaYH7gF0hUPMNBC74oUUpPLjQfEqjkXfhe63zELJpypQNFuqDllr5Vgs0zqqS
 uDnEkqbNykt+YDTsS420olHuZ8Xxk5r5VopNENvkeM50JEpQaAMX6Xa+3yy8xc1F06TP888
 bQUhi80P2/dtzi0gGsCFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aSOH9uTrCWs=:0dV1EYqep+skW5FGVo8xNd
 chZ20fXR5T8fHNoNLALRy45V0/ajD11iA9Xijkgay+fxuZsAGiV+kUL1Vqh/csE5qVSIfkO2L
 EH3DEOR8ibJ+CQ9SAlzjPm7vscdpTkwwhUZYa3n2bF0csukWb4hcMfzR/ThJEHTTujzrlXN9V
 lcJA0Kv4DGc/P8ipAv8G1+m9A4RCsh1wCF1ih3kG4nCBBQi17zK9e7CLK7S0slFp5bHYG3B5M
 RKQtgBIy8DHocpjY+uKnPPinyUSnB0klhlsVQt/OLR+sS9fvWK4HZJLe6PGc+dzstv7i6irny
 JL+KsZBBbamlIZrr1h6S8pAuVwp+i3QrE+wzOLoycHAW2aN/6dzjm3iPdjbvgFU21tMg5nQvJ
 Nn6TOd3PvrEWWtypPunkpjvv/7EwBu8mo5BbqWF8hht0tfTeXjNoVbNnsXNf57fLs1q+mzpwB
 6c0yTybA8QpLWNER1FlCDxmHIe98NbEK3Io64bSuaGXlxbmkg6iUKlanWkE2MDeje134MJePv
 bB+ZVH4qtzp2HsmdPB/bFXY4E1JONugfUbGlhqvweY9vHxSLnBNDQ6IDqmTwGu8QT+hm+kbff
 rUEahkpZaW7YOEwTwH8wkh99nsGnDc5h0aweZxAKzu8+GUZMibxiOGwz5gELj7VfCJDXMH0sw
 igRyy+siD8oxN+5uqvmS+Yc++8e5Sq5oj+NIGdc9xtGIZm+CRT36121sBaqP89grhzqRa3QVI
 F0Urlq7oFfnOHvKze1ELKXnostiufYM7PM4hM9CFs6PhlYfu3HhvDNnA+9d00JZkt10XbUMXw
 cRvCvipyndHYb9x3NTwqrTkKqIMvRD4aFLNmBiSUwgzRnli3mAaijlf0R8Gsem/yDoOHv2Qje
 8iB+L3Mz6VhYAaGKW5pCCs8ExbPi5dyUAQAczSVPIlj3BkWMOGr7QBzANk7R0phpJGHrZ6O+m
 gct/tWSICdy7UHvnD6PskK9g7twAYV88a7uf4H3adLStnhgk9RtLDUupTC58dMshuX1guHsxb
 +GfuRrYB3YGrYutNZKXvvX/iKRFTrHbsQhxxaS7iSiaIuX0/AdLKG2r4BPnc7aX8yHDHNCNBl
 T2uydEwi/lgohp7MVxsNLwlSWtl8e4S2NEy70+B4B4EoOHk/4cmK7RiHA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1543481212-1660122449=:206
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Wed, 10 Aug 2022, Ren=C3=A9 Scharfe wrote:

> write() on Windows reports ENOSPC when writing to a non-blocking pipe
> whose buffer is full and rejects writes bigger than the buffer outright.
> Change the error code to EAGAIN and try a buffer-sized partial write to
> comply with POSIX and the expections of our Git-internal callers.

Excellent analysis, thank you!

However, let's reword this to clarify that the error code is set to EAGAIN
only if the buffer-sized partial write fails.

>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  compat/mingw.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index b5502997e2..c6f244c0fe 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -689,6 +689,8 @@ int mingw_fflush(FILE *stream)
>  	return ret;
>  }
>
> +#define PIPE_BUFFER_SIZE (8192)

This constant hails all the way back from 897bb8cb2c2 (Windows: A pipe()
replacement whose ends are not inherited to children., 2007-12-07), in
case anyone wondered like I did where that number came from (and why it is
so low).

It is outside the purview of this patch to change that constant, therefore
I am fine with leaving this as-is.

> +
>  #undef write
>  ssize_t mingw_write(int fd, const void *buf, size_t len)
>  {
> @@ -702,6 +704,21 @@ ssize_t mingw_write(int fd, const void *buf, size_t=
 len)
>  		else
>  			errno =3D EINVAL;
>  	}
> +	if (result < 0 && errno =3D=3D ENOSPC) {

It might make the code clearer to turn this into an `else if`.

> +		/* check if fd is a non-blocking pipe */
> +		HANDLE h =3D (HANDLE) _get_osfhandle(fd);
> +		DWORD s;
> +		if (GetFileType(h) =3D=3D FILE_TYPE_PIPE &&
> +		    GetNamedPipeHandleState(h, &s, NULL, NULL, NULL, NULL, 0) &&
> +		    (s & PIPE_NOWAIT)) {
> +			DWORD obuflen;
> +			if (!GetNamedPipeInfo(h, NULL, &obuflen, NULL, NULL))
> +				obuflen =3D PIPE_BUFFER_SIZE;
> +			if (len > obuflen)
> +				return mingw_write(fd, buf, obuflen);

It is probably easier to reason about to recurse instead of using a `goto`
here.

Thank you for this patch!
Dscho

> +			errno =3D EAGAIN;
> +		}
> +	}
>
>  	return result;
>  }
> @@ -1079,7 +1096,7 @@ int pipe(int filedes[2])
>  	HANDLE h[2];
>
>  	/* this creates non-inheritable handles */
> -	if (!CreatePipe(&h[0], &h[1], NULL, 8192)) {
> +	if (!CreatePipe(&h[0], &h[1], NULL, PIPE_BUFFER_SIZE)) {
>  		errno =3D err_win_to_posix(GetLastError());
>  		return -1;
>  	}
> --
> 2.37.1.windows.1
>

--8323328-1543481212-1660122449=:206--
