Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE407C432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AE520835
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dPo7B40X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfK0Tjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:39:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:55469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbfK0Tjp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574883583;
        bh=E3Lk8ycRwADRbv2ujbd4cSI6JtrMW7grnTtk1pObAyU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dPo7B40XJXWXx6yTzMnVELLZAxW3mDBRHsaP2hch+xtH0CMWJklY9QostYi95HYT7
         0RoKKIP5KDeeKIxfMWbwt3LMLjvKb6+jTDJSn1WnDwtmXj0NzLhLAEeD0KeJh3t/x7
         2m54B6vhSW4/PpotMyPY0+2JMbxBa+cMuXjPfHRU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9UE-1hhx0N0bbw-00s393; Wed, 27
 Nov 2019 20:39:43 +0100
Date:   Wed, 27 Nov 2019 20:39:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/5] mingw: use {gm,local}time_s as backend for
 {gm,local}time_r
In-Reply-To: <2c39f9a04f98fc3d365c80ce57e8edce305846fb.1574867409.git.congdanhqx@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911272038430.31080@tvgsbejvaqbjf.bet>
References: <cover.1574867409.git.congdanhqx@gmail.com> <2c39f9a04f98fc3d365c80ce57e8edce305846fb.1574867409.git.congdanhqx@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GP2NlBmjDNwd85RzQmfX0Ye4hMoPAnab1MZBUPhSZNmcNZ87/Wz
 7QDsP0rgYYyb59xstyyML/kQZJDMM69lXY/W3mc+Ya8DVGXHBrCsqqY678ZvtBskel3urdo
 CWvp/VKuFtfpi0Nstjdiff/snwST8CFn7lrdKBpFHM/q+mPZ7kq+tq2HLEPJlKeo6UYTJCW
 CP9XW/ypgV4s7AtEZgozA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BNIbbpHFt1U=:Q+/+vGkmGedln+VUJ/rLHr
 NriUOguMClGJwXTfnZgN2rWRO+8Yu6gWuxXNAkdMK1lS7XYFd7HVqEIxiMH83Pj9aCkrGBZ4P
 7HBp/IryefCsZh5OWoWB848OGGXiy75MDFHaiBTD3cbeJLeYwWMJT/uQzrpVOHnlOMQ5E0uIg
 dXxuyU80VOGmxgd3IDZfXs9CB4ZaOfsTKdY5qwbUx4c4uSIDLabGx6HHLPAmjx11nUYdXyppt
 QAfF09Elk0ZsPcBq3bWw0fOZGtJDD5tnedFMKs3znKf+itLCYwaLIssZjkXgsnWIKe2gOrDg5
 SMHyKgwaQsgcwV6AhlYFFE/34ZJL+g8NfS/HwSQpwOVUBZdUPF7mqOaJ2dvQMzbD0JOEQD78L
 CEnL7rgJSdJqQ6mjoWByZ4VyPd6XCq5gcTlQRTaEjIzz7+gFrCkFCkBKrIPU87mwQOBEznLDG
 kmSfpd7T7wCDZ0OvUKDlTmYj3abD55quRNeuuGAaOZA0cf53xoO4y1IDbIsy1SgaAvh7yaIp7
 FRxvwRAmpFBOtUhFWPvRw0T3n036yI4dY1c5ydsgfORxu/Pl55U62NX7ZKu4cKYuS5NqWSYGi
 Cf6qDh8QiEXbUUCW1SSwMACLloB7Z5ywzwUsx4UAi5Tm/oUm/nVsrqeYhdD4RDNzpxsZSTHnp
 H22HqlxpV9rPV9mlN4qdJN2dwXx6KGuo7HJtOoBdLFZPavSbenqbIi3weyDmWEipOE9kX0RP5
 fctiI6TcsL17axLm3lwlRvEXpv6/NXk0KIYkZY4ePfIYHHQOK0LZo/yP+l7J3bWGUDeKJaILi
 4meZWIGge3+DMV/AKP2PJTPgyLcVnqKQNeW5F1XaVdfx0xW2CrYYG2dxeGMq/FrDGH/7QyShj
 5BzuIScI1UzhkQsycCAiMR8DkdwtZ9YvQneq/7J4zqhcgXQfYl5E6ja/8x6sN1GrGUrGUItgr
 +dqIisnIupJdY80AddZIwZiA8+cM4psk4qpUWb+npyYEU/HvSiYo+n+ouzcujZssp2eQWvJ7M
 wg03hfiKW01Kw5N4sWt0uAXhgvpBGmZKwhcAV7881PifF60N7k/X5jwfS6UotuUPzy2+GNekO
 Ufc9Ei1BwB6nCPXGt7qoy4tQif9VsrJfjy9bofRhuS4KARVAhHd9Sd1K4tJrlp2QvlmJVayEd
 xJlFblybW7fnZ7JUhzbMDK/v6iDzF6Pc6NRckWUgGoq1BL5I4aYyNGV7PhyvGVDsAaVGukajs
 GUZLCxbBkx6m6No77A3DIqgU1AinpfrqujSdKW271k+6LK5Yacb5kG7Y6RFw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh,

On Wed, 27 Nov 2019, Doan Tran Cong Danh wrote:

> diff --git a/compat/mingw.c b/compat/mingw.c
> index fe609239dd..7b21f4eee5 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1,6 +1,7 @@
>  #include "../git-compat-util.h"
>  #include "win32.h"
>  #include <conio.h>
> +#include <errno.h>

I actually overlooked this. Please drop this hunk, it should not be needed
(and might break things in the MSVC build).

Thanks,
Dscho

>  #include <wchar.h>
>  #include "../strbuf.h"
>  #include "../run-command.h"
> @@ -986,16 +987,16 @@ int pipe(int filedes[2])
>
>  struct tm *gmtime_r(const time_t *timep, struct tm *result)
>  {
> -	/* gmtime() in MSVCRT.DLL is thread-safe, but not reentrant */
> -	memcpy(result, gmtime(timep), sizeof(struct tm));
> -	return result;
> +	if (gmtime_s(result, timep) =3D=3D 0)
> +		return result;
> +	return NULL;
>  }
>
>  struct tm *localtime_r(const time_t *timep, struct tm *result)
>  {
> -	/* localtime() in MSVCRT.DLL is thread-safe, but not reentrant */
> -	memcpy(result, localtime(timep), sizeof(struct tm));
> -	return result;
> +	if (localtime_s(result, timep) =3D=3D 0)
> +		return result;
> +	return NULL;
>  }
>
>  char *mingw_getcwd(char *pointer, int len)
> --
> 2.24.0.158.gd77a74f4dd.dirty
>
>
