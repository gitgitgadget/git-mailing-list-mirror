Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57017C4332F
	for <git@archiver.kernel.org>; Sat, 24 Dec 2022 07:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiLXHvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Dec 2022 02:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXHvG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2022 02:51:06 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B2D1016
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 23:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1671868258; bh=llGD/PcsNhsi34h63W38iBfx90vx5syVF/0ROfe6oK8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=I/ReOKo6KRzLUt4PG+NKnlR7xaBD1YJ5LU/OOiyIbR0Na3xfcRWcPnrzXhn7Y7lMq
         7gwKwJSOln2ceuTgZovcm85slhCHcqW8JtSQUYQXkS7l93w1o8auTzR3WoSMfdM6sA
         Gee+NEjPTTO5rjy+ormU0Bw1EUb+OBW1+sJ//SBa94K/rCrHlacEX8EtiZ166lXRog
         NT7SYE3NIdIdluf4OFKcTfuzGn1r3wD8/XmN+U3RDKo1mYVIUBMSx89L9ByoMtw53I
         qkD0tGHSxO061SBbi2wR1rQOj+ZkT0RRSHzKSgMHqJ3mjFO+gKrM61ic+kRFx/XjrL
         EXQ9aNYskVEtg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCogs-1p09bN3QzA-009JGX; Sat, 24
 Dec 2022 08:50:57 +0100
Message-ID: <36ac4180-9d8a-1453-c01e-9870481bbe9a@web.de>
Date:   Sat, 24 Dec 2022 08:50:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v11 2/2] win32: close handles of threads that have been
 joined
To:     Seija Kijin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Seija Kijin <doremylover123@gmail.com>
References: <pull.1406.v10.git.git.1671822955.gitgitgadget@gmail.com>
 <pull.1406.v11.git.git.1671823177.gitgitgadget@gmail.com>
 <c5d2ddad166165d1ac8975ce6d06c16eb3b6b6cb.1671823177.git.gitgitgadget@gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <c5d2ddad166165d1ac8975ce6d06c16eb3b6b6cb.1671823177.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hrTnuDMeuWOBxvTGoITxLfbpFkhtx8Ou1Fl/+PM9voQRD9OM7G+
 tJL3MlJ54vj821ylDCtsAG08Xz6/JhrERBHDCaLdXlS8jDOMsxIb4hq1OZLnRcBgJ6Gw8jk
 4IjYi8z1ifzJIScinoZMcpCc0POexnFKl6EYVeDXwQFwzX3KJpz32WV6WYfZdLmcRDx2NHk
 9VGvjXOjYIch4l7lDeZ2A==
UI-OutboundReport: notjunk:1;M01:P0:TeVIWJQG/gA=;clVKPwN2krj/SlmCvEJrbi65FQg
 /G4I+84GwbsD+bTbcIOFDDN6SDWFIVyFxaiGWnhnKi/1a+ib16KZzfO/az3eLS3Gn9CGHa1HD
 IiKgQz3tm6CobGSXw5STeLNKQ8daRzg14LYM3HfXdDn2NozhMDvQMcIFNG0WeWuhSRaKciAtQ
 HPgypzPMzxwLjrmtdpBiJUayAztP6gMxTmTYw5wyLqNe9A74fw6Zt9Q6VlUK3GiswZ77QEJdO
 huVSeJP/UkGym8/f+c1fQqcSWgvca+w9Ys21Pejl/VplitPFm0EV6iaqckfJE0dua0Nm6KFP+
 HNHyOD+hasC2FIe4ho8gaJN926vhhnZQ1bFe90RkWUNJo+KC7i0X5P99j6plOc9PAztVfClSy
 nB7muameDgvzqrJndLwhga9AkEf/QNpkkirs82NQwMZ8TCz5Qu0Xo9PY+6KzKa4UORX/vmzNo
 pJJkYKRgmnGePugpeV3aLhmHDnU+Z/OrGaamBQe6GYBa9fxP6kT15WGNoYBJTQjtktUenmu3J
 u2fltCO4sNXZLP+gDqBbpFZXHutAK5mDxovwVUcndZECg/HvnM0FB59XYeCZOmm8oXoGGQyGd
 8KXCYGl/8l1BPFQnHgtTRr6sutf87K+jYYTGLF/NRC7e5VGJGaan3++Etkntsb+n5z7GyvbFg
 awLNiYOIa8k1AKuArhLZW/dORkJePvuLNCMofzAva6VeQmfDYleJ7HlwvR/b1oNd6l4JwBWJc
 i6HmQEmqNORspCpLbRiZ8+/C6lYEMaDmNL8foP+EEno7jXZzpSCMFYV4ajRNKqQH4QxE3+MYG
 xdtJyHxj6yRgjAOcstCIESQkaSnBGv/uEJeFr960uicT1jMk9Y4QVymQ1nxT7IfHFFKOMeAUU
 PHu2X6J9puxsM1ppF4sJuUb5XmjdmBy9v5ubZ60FhQmSoeVtwJQSuRVWytFJVMEWmoSw0X4sl
 M7pOWg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.12.22 um 20:19 schrieb Seija Kijin via GitGitGadget:
> From: Seija Kijin <doremylover123@gmail.com>
>
> After the thread terminates, the handle to the
> original thread should be closed.
>
> This change makes win32_pthread_join POSIX compliant.
>
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---
>  compat/win32/pthread.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
> index 65e15a560d5..f63f65c9dfe 100644
> --- a/compat/win32/pthread.c
> +++ b/compat/win32/pthread.c
> @@ -41,11 +41,15 @@ int win32_pthread_join(pthread_t *thread, void **val=
ue_ptr)
>  	case WAIT_OBJECT_0:
>  		if (value_ptr)
>  			*value_ptr =3D thread->arg;
> +		CloseHandle(thread->handle);
>  		return 0;
>  	case WAIT_ABANDONED:
> +		CloseHandle(thread->handle);
>  		return EINVAL;
>  	default:
> -		return err_win_to_posix(GetLastError());
> +		/* the wait failed, so do not detach */
> +		errno =3D err_win_to_posix(GetLastError());
> +		return errno;

Why do we need to set errno?  That's the only difference to v10, but I
didn't find an explanation.  POSIX only mentions the return value:
https://pubs.opengroup.org/onlinepubs/9699919799/functions/pthread_join.ht=
ml

>  	}
>  }
>

