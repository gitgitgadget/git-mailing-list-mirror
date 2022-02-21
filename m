Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D3FC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 10:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352410AbiBUKDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 05:03:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353394AbiBUJ5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 04:57:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329204754F
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 01:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645435525;
        bh=pT6aHtnVS2P76TKkP+5OVJfBsEQpkA6GgQ3tpyOxcs4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ng7AV+cuoYDKqkXWOgxuHSq7LGcQNZ327DxxUdRPbWWCtlyYL40tA3zNibVF9m13u
         gRw9TcivZw+e8nF04+YswhBeKvf1MfkB4ftyHZi8VeDDf9SSgZcVxHU0feHbR/x4aD
         +HLs8sbJAC3pS47MzDWlrioV+hEOVj/FupRmOOAY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvrB-1nu1Bx3pC1-00hJuD; Mon, 21
 Feb 2022 10:25:25 +0100
Date:   Mon, 21 Feb 2022 10:25:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v5 04/12] merge-tree: implement real merges
In-Reply-To: <9b65e743-729f-6449-b7ef-c8c9fb130221@web.de>
Message-ID: <nycvar.QRO.7.76.6.2202211019490.26495@tvgsbejvaqbjf.bet>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com> <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com> <7994775a9341b256d1ea7dfc417bb577d9a3195f.1645340082.git.gitgitgadget@gmail.com> <9b65e743-729f-6449-b7ef-c8c9fb130221@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1497184964-1645435524=:26495"
X-Provags-ID: V03:K1:8RrnuM2YdDDB9uLXUa/9RJCWZXz8Zn5f9rQuGI2HZIKFdeRT/5T
 aUWC2rBVm1qCd927jJH3h5YheTmvJ4srD1aA4V4umuRC+CWM3hPYnjLEDLRMYM+LSO/CIEO
 wbsnXtDIoHSyegRhPnNrL4Pk0uz7Ggc6e5XZBH9zWqc7YBy2bSJdkVfgLCWEaw5gChxeoR1
 DURpC6KK5qXmj41iq2SUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HTvWkw9eSp0=:8CuaxPMI5CnJB9Bw7d9LvS
 Z02CmZ9WPTJdjdfBImehgS/amtBcUI+Pxowt9e6CUtL1hL4wmFOS2VJRlEve8I/LoXVhk6zHY
 mO+kWCj6OwYMsL6PNuornnGaFKaW3doQA8jlTKN59l0rqa9BW0NR42ghPSS2ho8uUbjmnoUOG
 45hPxQSZxhbLNtlm12THTYCyGK1WNr4cuydEMyyr/bSoWWNqQ3s8LTHUoUH1hk2scZNHEhTT0
 7CSbRWqQk62t86mb9dgrfYQedEdB9tA8ev/TIP9F+J0VBXuoDYSDwa8I8MuLSFVBKWGDNGE6a
 Heu7wIj6NXy+jAlfdPuWqYr27GR6/xFuxW8uCnoaaGC0lMxwp5uSdcv4SrTbIMt4/k07sd7CB
 Uk3iSqkg6zWLqO+SPR++n0bQ1IUwu3Q1grt1Vp1aXHH9mJPgnNGP//hiN/YE+G5KAg9OGpwtv
 izkKecc/FeVQNqHzM5wQS1oBPtlpCIVg4dE+zwsTRrTaDni/7885bkf8MF+b7JRk8pfM99cne
 3MbM5xCmbMQnw+/hS9ZIOQpe0bX4ZSyFp/0bAr4rN0EbHqqhxZ6BBHhZktiQtpFYFE/1NFNb1
 kB6VHwFgv3SuNvUuPzZR/a8S/h64mo8Jveed88NZrigd7iLypoEWuhrtbin5bsBqouquJannQ
 slVCgmBadWK7mJK2xAd1JqU/6/Oh1Hg2b8LKB5s+meuLqzNEYYla7Fst0OgobLPJoh+nlOotL
 gXqnCykB8Vd6yos7dqrcntzvaXZ7jI/xCayyzCqIuI0KrPhoSyMIq41EtwOpxFPqUzSCVXpax
 v/5UHjiAxnKgq1uxOWzAfSG0yKe2sgG3cImIRnq2pMzJ2pZNMIwLt5NuYS82PVbj6lXA0nLrl
 hZ68Ygomt+STGdbCXuCDvAXHp4M2g0Ujkp7HjwBaCFGOtgdQ4EGLBFqGvxu8d4gTi2VPlwNF3
 nfZZv/3BW1ziEvY3otm9xf5+P1xSD+euFpmxidr80qzNySS42oSxu7I3ODk+kaDXX+1bNh/qH
 K4idS7LYprPqv2H32A9ZDg4PEvlkVEFP6G9h7ulU6cA6/28MGyJ35VQPx6X0YSc3ppMrDL2fQ
 3o6T9P9BGyj0f4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1497184964-1645435524=:26495
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 20 Feb 2022, Ren=C3=A9 Scharfe wrote:

> Am 20.02.22 um 07:54 schrieb Elijah Newren via GitGitGadget:
>
> > +	/*
> > +	 * Get the merge bases, in reverse order; see comment above
> > +	 * merge_incore_recursive in merge-ort.h
> > +	 */
> > +	common =3D get_merge_bases(parent1, parent2);
> > +	if (!common)
> > +		die(_("refusing to merge unrelated histories"));
> > +	for (j =3D common; j; j =3D j->next)
> > +		commit_list_insert(j->item, &merge_bases);
>
> This loop creates a reversed copy of "common".  You could use
> reverse_commit_list() instead to do it in-place and avoid the
> allocations.  Only the copy, "merge_bases", is used below.

Curious. When I read this first, I immediately assumed this was
copy-pasted from `merge-recursive.c`, but it wasn't
(https://github.com/git/git/blob/v2.35.1/merge-recursive.c#L3591-L3592):

		merge_bases =3D get_merge_bases(h1, h2);
		merge_bases =3D reverse_commit_list(merge_bases);

I tried to figure out where the manual reversal might have been
copy-pasted from, but came up empty-handed. The comment in
https://github.com/git/git/blob/v2.35.1/merge-ort.h#L40-L48 did not shed
any light on it (but took me down memory lane, all the way to 2006!).

Ciao,
Dscho

--8323328-1497184964-1645435524=:26495--
