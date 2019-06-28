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
	by dcvr.yhbt.net (Postfix) with ESMTP id 612F91F461
	for <e@80x24.org>; Fri, 28 Jun 2019 10:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfF1K4d (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 06:56:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:58727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfF1K4d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 06:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561719371;
        bh=IRia9uH29k0gTKxAAD/BGkIr2ksub9whmGKu8MgAIPU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PeZrMw9WnggnjGkiTxGJIktGE4op9eqp2yRcScs9h20Uys3gdReynKNBtkuBB5ypH
         RshXkPurqvAWWn4BmX9QvEafUPf+zp8XXhqZkR8dbvuaF5tENLTM1oSTpRGXB04qRm
         NYmak5n4Tonbmg0tP6iDtgGjmP5hhlWPIH3H61H8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzOw-1hv2YB2aei-00PNRg; Fri, 28
 Jun 2019 12:56:11 +0200
Date:   Fri, 28 Jun 2019 12:56:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [RFC/PATCH 7/7] grep: use PCRE v2 for optimized fixed-string
 search
In-Reply-To: <xmqqv9wqalv2.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906281254370.44@tvgsbejvaqbjf.bet>
References: <87r27u8pie.fsf@evledraar.gmail.com> <20190626000329.32475-8-avarab@gmail.com> <nycvar.QRO.7.76.6.1906261610310.44@tvgsbejvaqbjf.bet> <xmqqo92kchjm.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1906271129370.44@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1906272042350.44@tvgsbejvaqbjf.bet> <xmqqv9wqalv2.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cwHmqs0bE1aOS84lkzeSfUAUFp/VHOR8//EuWWJ4EtmqUVh68is
 e2gospNevpSMYz2CkPdIaxMIdTGGalrQ54OZ/yENhBJTXfo5slrjAfTuCs8XEvUrE0Eq4Ak
 pQq9cPXG1fgPeyNOcURnI3bf1U8ivP+1T0qZhAYQJXm1LZSOCafdhFcWPWOxjpaxzVG2zvL
 t9zYSOYuuh5pJfq+lANhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J7yQZdx6rn4=:oChUrXqJO2pO63ZKGRfnDb
 R2YM0Q4S/dubFTnnd56jvEemukpwHv/bTarTkZ8cElO6RQBFxM9VZpGvhsks0eOQzm5aAjiKh
 ln5sGm53iIuU7DxXdIZNFteuYJj+cHPV5HdUXh0XDfGQ5BVN+F9OWqsfBCYaDL0hwxgHPSnLY
 g1K6Ik7wLxevLwEF/EV07tSJCuXkSx6jdStN1Qkg/M712XVnivGSBImNJthMOD92jTYIuwo1F
 8ICtg60oxOe394eQtG5mTsIt3GRPT1IRZvjNgirHywkjDdhe7ZaP6bkRzbCUnqJjYbvPEDoOg
 K+WAsbn14OytpB/IvnTIP87voKpHnS9ykxvn/95f4wZxZisgkGTvu4ncd9HWcktzLA7kht30m
 JEYAASwk3KjqD3OIMXinCSKYGxOgmmfXjahOIoxmoSyD05CqxS/mKRKLwla/YMNyYeQAInk0p
 YZSnplDmVmYf7aEWTmpTHWP9CAyVUweQsY1RxOR8tmN9dEf0J+JOa0upeKeefx+ImZVD15QxV
 705EWVdJqSndEYvBVPSgxen/ABGfubeneCWtfhRo8u/BXm7U07DLQ3YlwTt6FJvwxBxpMViOi
 TYgGBihLz2pP/m+HCFD/iCClcssvuuNopttZncyUrB7TkA+XIWx6GNsL3yjyUp6ZY2XsLEAwd
 D3bHwec3R5v+mvfe9jMUuddWCwKTs0hDD8sML2pycw4OFvhHcWvtVHkoD0r6lsjgAoM0s8r7K
 XnWFQ7gVsgxxzHAmoj27u7W4pCBqyNjgkjNhaOVeADc8FC1ASvNbmAv9uLFq8PoWf3JLkRJTs
 IQKsTOmMRqoNZ/6ACeXjwZLpnXl9T5CmlK5xAjPUw2RyupdCWWqXKuGubOcKCATUI6xQjQzTJ
 S2U+GmTxwAi4AYnYeW4UtdUar8WiHfLp49NRcIiqyz+UvCyoybSaYbBUew0DDdF9/Sh4QsJpr
 MqMUJFDfYlDWNo596+WKBzB1PR3oGO2D7XRUG7JL6k6zSMAJXUhEW22IoY4qxkldy0JlONqDl
 oG2VBQh8EKoozZqdq80fkhxEfOdv8l79iecafiLt4JzvxiGtWTzd8eVlpfUV4i5uZs9HIDLCR
 fujqKhEyjA/+5ny+fc31eKQdrc3Q8YvjFUk
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 27 Jun 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> > > If we would not have plenty of exercise for the PCRE2 build
> >> > > options, I would be worried. But AFAICT the CI build includes
> >> > > this all the time, so we're fine.
> >> >
> >> > Well, I'd feel safer if it were not "all the time", i.e. we know we
> >> > are testing both sides of the coin.
> >>
> >> AFAIR at least the Linux32 job is built without PCRE2 by default. I
> >> might be wrong on that, though...
> >
> > Actually, it seems that _all_ of the Linux builds in our Azure Pipelin=
e
> > compile without pcre2. It seems you have to pass `USE_LIBPCRE2=3D1` to
> > `make`, and we do not do that in `ci/run-build-and-tests.sh` nor in
> > `azure-pipelines.yml`. I do not even see that for the macOS builds.
> >
> > So we got PCRE2 covered only in the Windows build, it seems.
>
> OK, it sounds like we have sufficient coverage on both fronts.

Maybe not. With the bug I uncovered that is _only_ triggering an error
message if the PCRE2 in question does not support JIT'ed operations, I am
a bit wary now.

But I cannot really see a reasonable way to add those axes to the CI
builds.

Ciao,
Dscho
