Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691D2C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 14:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbiALOSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 09:18:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:51929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238981AbiALOS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 09:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641997102;
        bh=ToKzEmFNVEzaqmknU80HMWTzr9HpXWcHpsS8P4MRPes=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=a7vAT3C4zZBL17pxKdy75N4Jquvsl/ferh69SDXtYhqXE/udJ42cSOYSl/pp3Dl/r
         lUOSsjj+99mYDxNRAP6ziReoXa9nDgCzgUF7x4lW3Eksw4iosqmXlasHu/A9JjKqhP
         vJNwgeZeJsABEVGDuRJY7OJO1AsxIShREbI12nzI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.215.56]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6qM-1mdnL00nj2-00lRd8; Wed, 12
 Jan 2022 15:18:22 +0100
Date:   Wed, 12 Jan 2022 15:18:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Johannes Sixt <j6t@kdbg.org>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] reftable tests: avoid "int" overflow, use
 "uint64_t"
In-Reply-To: <Yd3njKcopXVZ+69C@nand.local>
Message-ID: <nycvar.QRO.7.76.6.2201121515490.2121@tvgsbejvaqbjf.bet>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com> <patch-3.3-93112305523-20220111T163908Z-avarab@gmail.com> <Yd3aZ5Q9Ph0H+Ijn@nand.local> <CAFQ2z_M0Fjjx8tAd_cXqk9K9q43hwienEy=UsLJi2aW8G3sEwA@mail.gmail.com> <Yd3dao5Qh5yl/cBs@nand.local>
 <45baffd7-c9f3-cc52-47b4-ea0fee0182a8@kdbg.org> <Yd3mCVLyxkVTNcS9@nand.local> <e8e2c37d-39f1-0ae4-7894-07e85628a757@kdbg.org> <Yd3njKcopXVZ+69C@nand.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LuHtiWIirgjOM7dKPT/uGpPSQjh6IhCnZ/+WZblEsUdg32pb49o
 NCCUO0MY/J9cFSXtAkMGis0UBk1m5+meEOy20lrVRPp4MrK7mCI7MYvkx9HMAIskFgk/TsN
 nauY/YpWIJ53xeDNbPvP4zZ8tCusuaErgmzO1W0PUA4iGKhRZmzuJ1n/8zRZzexROE8Qr3m
 n2yHaj+pcARQ1BU1GZoqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J5ffhXtcAe4=:1+Oy6rZkWrbFB5w4DcbJrx
 wnW8ol+4qUpafCRufCwNldRXnihz+2Ix136mp+NXc2QhuoejfcLkomkxS/klbBmYKhPPLja0A
 LyKW/PIYKmWgZRlYRhTOcPRE1tdioyRfBjoNJ/eS5/VdVuXkHJnLr/NC9+JSpbqEigt9RKG9g
 WXx6zg4P+kp8qoymb+LV1VZiP1ciyDZjnhjUuY2UOgWmQi4puAUh+Hb9ymioaRaVihGXTauoS
 UTPEpyuoFGgFOuUALicPv4/dvllcB8ZbVf+d0m7QZZmIGZC2iMMYQc22lUX7toCJdlSbF2NEB
 21eFwDZCJ+fPBNpsA3oJ93fyTSsHTStEQPFrljghrqWLADsY3k5GTksm/Ayw0PbwyU6LFAo9E
 xr5LB9KonVVIavUdHZMtfLP6+GOG43GH0y8A+pW3yheWS8ab3TabE7IziQKhENvgFbM6U3lnZ
 cwLvfJpT+1tM585y0V5Dfylqb5PQH8SQ2pfO6jCCDFiZeU817pXx0WPsPXIOu63Mn/I8paOzz
 my7u+fuLBF6je0UFUNTiFar+GDUSLjUELBMCNtHkEoX5tB6IBgIsIScHV9eLSFHDz1PDaXiWb
 d5bnL4sfWn7L9TLcOGRhTeR3BznJ/hCvzhxF8buLIQ310gZNlG6c9Ahh87ui+NjRH+mEVqt3p
 9c4oVT0XBG2QzmCuJ141YeJPGUQLUZkqXGtyJ4LP/sf+XHdZ998hP9l448PEbFbjMdJOJ4gWo
 CbLqJBTLd3DmtdV/JypQbphzKIfffZeJnWeiC/kMIL0m47V9NpV5h/WBCs6J6CQI4c7zQp7C9
 xjPKB/6dsr2nHTMyvo1mg91M7B5NQAHLqew/5ZJy7L5cmvsJE+dNK/YvTeJqizeuHv1VkR13W
 CI3kr99J7KrhvRmAO3kf9oLIUM69BYRWhLcHQXrdF6gdfKMuOuAA+Cty1rHfPG4JOwk9zX13h
 YnaVgqx8PRpYWk+GZGYlT4ivzEjr1p323rvRfxuiN8LGPLRCvi11CFk0uL2xT5qczgBS2R/d/
 MldSq3Rb3peaMGfqSScU72KKBPlFKXGP+I3L+e7wQtcfVCpRLK1eLhVcvezvaSt4W2tj/YUFl
 U0sE9duPLhc9+s=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Tue, 11 Jan 2022, Taylor Blau wrote:

> On Tue, Jan 11, 2022 at 09:21:11PM +0100, Johannes Sixt wrote:
> > Am 11.01.22 um 21:18 schrieb Taylor Blau:
> > > On Tue, Jan 11, 2022 at 09:08:46PM +0100, Johannes Sixt wrote:
> > >> Am 11.01.22 um 20:41 schrieb Taylor Blau:
> > >>> On Tue, Jan 11, 2022 at 08:31:47PM +0100, Han-Wen Nienhuys wrote:
> > >>>> On Tue, Jan 11, 2022 at 8:28 PM Taylor Blau <me@ttaylorr.com> wro=
te:
> > >>>>> In any case, you're only setting the lower half of `min` high. M=
aybe:
> > >>>>>
> > >>>>>     uint64_t min =3D ~0ul;
> > >>>>
> > >>>> yeah, that works.
> > >>>
> > >>> I'm pretty sure this is OK on 32-bit systems, too, but confirmatio=
n from
> > >>> somebody more confident than I in this area would be welcome :).
> > >>
> > >> It does not work on Windows: unsigned long is 32 bits wide. You hav=
e to
> > >> make it
> > >>
> > >>    uint64_t min =3D ~(uint64_t)0;
> > >
> > > Perfect; this is exactly what I was looking for. Thanks!
> >
> > Actually, on second thought, UINT64_MAX would be even better.
>
> :-). I think that either is probably fine; I couldn't remember if
> UINT64_MAX was part of POSIX or not (and clearly didn't bother to check!=
)

The best solution, of course, would be to `git grep` through the code and
see that UINT64_MAX is not used at all.

And that brings us to the question whether we really need to ensure that
exactly, precisely 64 bit are used for this variable? The answer is: no.
We may need it to be larger than 32-bit, so why not go for `uintmax_t` and
`UINTMAX_MAX`, both of which _are_ already used in Git's source code?

Ciao,
Dscho
