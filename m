Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9191F461
	for <e@80x24.org>; Thu, 27 Jun 2019 18:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfF0Spq (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 14:45:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:58959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfF0Spq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 14:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561661132;
        bh=FGv74PX7eoz8LIQyfuRYmiYVH2oCM+ZzJUVYmMqU4rQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hil89cBBSSrg4hrpMWipI6fN93Q4RkJ1f6fg3AgTl1UwO0conRlNAgy9bZ99HEObU
         9SN0HCMbqhx3xrWIuwV012v7u0IX77myPPEzPf6Ud4vlIgowtQNhiOTEHSFnhVwNnB
         Q5jV4cc9yD5zHQf6Hx/qb47PawoI3dKbeKuiZTQo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbW0-1hmekX3xpG-00H47z; Thu, 27
 Jun 2019 20:45:32 +0200
Date:   Thu, 27 Jun 2019 20:45:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [RFC/PATCH 7/7] grep: use PCRE v2 for optimized fixed-string
 search
In-Reply-To: <nycvar.QRO.7.76.6.1906271129370.44@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1906272042350.44@tvgsbejvaqbjf.bet>
References: <87r27u8pie.fsf@evledraar.gmail.com> <20190626000329.32475-8-avarab@gmail.com> <nycvar.QRO.7.76.6.1906261610310.44@tvgsbejvaqbjf.bet> <xmqqo92kchjm.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1906271129370.44@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DhHfNMKOM4KHt5kC85gSQi0aazRsNsG7jtDCYfEbhaxUeQiUlOT
 MG7/H2SYggH899dxr5Km4q8xbVtIy9k5y7ToLMHBokKMgFm4Wux3p7gfvBBrkj62IuVvN+o
 ZZwR43AHVPLkXzWmvQy3bUPGGXms3FnECA/jo1Hqj0goBhiKGf6u6AuJeKPzcr60ByDMdcM
 LtLGaLKZSqipetqu409FQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JACoxaidexQ=:Ym26tCuOOBOVQjKOQqTbmO
 DhoxuSo05nkQnrpcPpQPIxYIb1xMvkgcw1m3l8chw4+S3lYN288ZCZo2S+iG805F76ujZwZgt
 7Zm3QFljSyDnCLvU2HkIoJw1Mz/Do/iNM2RNL32tT8aVCOdgNcyQQ2OixI5m1OT54PemLUwEn
 VywX3wcB0chVQHk7F2PR75skRIyowP4ELLL1u4iocOZ/q47IkXsyYNcMpW4KFLyTz6FyqtJjq
 QpbdJD/B++cYXvSwm1FZrQAW33QKoqmGD/NhxIyd7h83eR+02xLqgSwFj7IdmhnaNI5meeVzm
 /wFbR3EAr+9w6Sqv6ynVbr0HKP40CQWh4jlyUZzaoIXQvaOJXM53Z+TxwsUzVXgASbAa94NdI
 Er4dKgdvzjkgHrS0jSAmaXWkj7sn5qTU4GkswGaaDloQNc5nmcy9hCRHowhha1wNmyCnHJCfb
 o+wtnTn1zq52jgmbmO7oNTPClE5m7CjshYsgGpbesBMYR0xlrWEF57zrYDmNvn+KOd8ToMqMs
 sRbCrn0NbcUD7aPi26Ee7BapNBDW1tEHetNy/uGQffD1LI/dkYLqXjqiSd7n4bYECmrkuib8h
 oZ//ShjGYNYBhWrC3rLgqIA4IPWQHOu0g4wfBRdunW7o0liVmyYYLe5TTCoD3/A6c4m47ZKb0
 aPBDoJR4WGpnLocApcqE9yN/txnCJjVpZaBkt47Un5Tk9nULsbNEPH3Kjqg7BOs9vjwJDXf+w
 h0sCqwPbJM3b+OvRMk6IyhmyUbm+l3I12UAzNSdlfjW6t2sWzEWUtPyMef0tqeA9Du9Jphuuc
 zfGOxqLW8HxEVGEPmTToNQmBikRjpwN1JhDW9UGB9iy09wkDBousU8mLGtwU39xM6tCUwzNH0
 Q6QrumseEsPF+Nza2IMDhee0VR1iY6uqIysaP6/f+T1+mYyLTBp0/3gmM2g5BaBg9TQEf9Dg4
 HOcWsarsN45nmn2nVLI3qYmJVMGhwEmavzTS6RDS/CK20XjCpLGGUU/F07UekewSpEcL8KPy8
 xFhGpvZX89Bnl9Zmhsh93HksU6LB0VoMi4KO+AwOvgfm9GBAExQ0GMtiKIpYLTNrR96p5XEQC
 hhWqRdsvmENPQ720xmigOcPnWH/+451Bn0U
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 27 Jun 2019, Johannes Schindelin wrote:

> On Wed, 26 Jun 2019, Junio C Hamano wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > ...
> > > Ah hah!
> > >
> > > If we would not have plenty of exercise for the PCRE2 build options,=
 I
> > > would be worried. But AFAICT the CI build includes this all the time=
, so
> > > we're fine.
> >
> > Well, I'd feel safer if it were not "all the time", i.e. we know we
> > are testing both sides of the coin.
>
> AFAIR at least the Linux32 job is built without PCRE2 by default. I migh=
t
> be wrong on that, though...

Actually, it seems that _all_ of the Linux builds in our Azure Pipeline
compile without pcre2. It seems you have to pass `USE_LIBPCRE2=3D1` to
`make`, and we do not do that in `ci/run-build-and-tests.sh` nor in
`azure-pipelines.yml`. I do not even see that for the macOS builds.

So we got PCRE2 covered only in the Windows build, it seems.

Ciao,
Dscho
