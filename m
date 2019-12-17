Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C22C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 11:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A65C20716
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 11:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VvlkK9RX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfLQLIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:08:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:56971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLQLIk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 06:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576580908;
        bh=Dna6WklwYMNQ+Y2dr5GtB7xiOOaXH9Z0KNL2q7Y+WWo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VvlkK9RXE02Yg1GlFZWz1OCzp5TWHaiik4dMBr30INYFGnUYqwXdz1OeGe8eYAEb4
         QkVMZ5zfE/Vuw67YaG0w3X7mh9Iqv4U0I7e/tzrOOklfz8tg6uufbN8F9sXH52+sC0
         wvP4JceZSbBNJfQEysMgfa4XlhHED+zlcl7s6ekw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbEp-1iZ9xP2KrD-009eb3; Tue, 17
 Dec 2019 12:08:28 +0100
Date:   Tue, 17 Dec 2019 12:08:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v2 6/8] dir: fix checks on common prefix directory
In-Reply-To: <xmqqr213iz9z.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912171157140.46@tvgsbejvaqbjf.bet>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com> <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com> <9839aca00a10b16d96c47db631ac025281ffc864.1576008027.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1912151126030.46@tvgsbejvaqbjf.bet>
 <CABPp-BE04=A9wx1VfWsghn6scy8aaVFoENxV6YiW2AxgM2jhjQ@mail.gmail.com> <CABPp-BGoC_D6LzzMNyf30wFssTU2WA1kTLmFvJ2Do+Tfg4+YQA@mail.gmail.com> <nycvar.QRO.7.76.6.1912170101230.46@tvgsbejvaqbjf.bet> <xmqqr213iz9z.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:B690sCsgJMUXYmJTgp2jV+kW6Ip8u1ANIFrhPn2gqF9HK8RUYsd
 16TWBNiADPG57IGlgMfLrK+DrTXOW+RXoO/ChL3RuImmD6I/E5UPnKbVm7hMzrDgyqgrmyo
 Na/ikWczFKe1IjBai00+xPLqewKTrFV+LhdugwR9YHPeKn4b04VwjGKyMNgWEaEgEwhW0yh
 en7ZM3I+WRk/1kBTbqzaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fkNIbcg8daA=:aYYIkQpVKMQocPxunbhkF1
 Krljfc2CMmrUAVGziBSPKHLvzqEjakovkx1xPkiTMBswXnT68/59BJIT52YR/wfXqaI6UgJtR
 zxN+WM+SkNyK6+Br/Ti71Jut7zD0v0tX2TGzuaZbArhPgPsPLs8tRID5pzfpNyVXSQKVARd5I
 YT4LuAx6Y+2cjGSdB2MrsVMuW8Ch57CLOlX5UfzrQD/ACDkKqKbyGtoyp1MavPfnLcyn2F2Qr
 mrtKxE8+0x4eG2BYVyF3JI7wvtDdqz5qDq4g1R+szBI8IsbspqrwPgwI62nTMRS58SsIdtiRu
 5SoSDmw+/IX6s3F3V0vrsss8ohs2OIUjtvYv1+TbL0UMhIainWOud9PL0MGYr3Wcb04Qr3BlK
 pQLU8WHXszvXSCTdkObUUhP8HF7Y88IW820rzbDtS9c+nWx/jPbeGGBzGT2tXgGj3k+icoqbR
 wg80bLFdWI2t8TJv2hkG2YCSw00cOI56Ot2m7z/2C+879YiR1azAFrMxRuAIzHbKs+kCHWkzX
 9ykLw9J5F9BjlNli8eVmSWa0RpsYe3PAT6kPGlFN7jDdCwAr2JoglGRf2uRzs83oyaJT2IMeJ
 1PpifQkKzmujK8bazGU4n/WhQ/73pkos6PQVl+cmHbNGPEVSTQedeyLT06oHpUnwo5fDMa201
 Vimx3VCbjDNUwNgcTjoZ446ND/gYPxKcQRBowUT5rKRzb9mm+1E1Up0nE4WUs6hvjhJtUhDXi
 oyxUALxfWRSAAzpLQ7JYyhaQ7DIsBvh0nqm/MfapYyBBhhc7LAey8QSq94EAfw7bemWRuTbN1
 0mIXB38UU9jEnCfi5rUGRwUiAwpvTpJwqvVg9ltIwK4gBgKcevj2n/cwgqEen0NkmmHnaxtPA
 X5aftgmmEdEaRC9QWT5uqG3r2k75N182Sjl2KEgUgMTDrjkBO+Vg8MqA2qYjd2tLKbrEmYoEq
 KNK/1OeRdmOAoCBWQE92c1sh9WhymjXdnwr/WL8wWK4TI8xtCIVsFq3kkpp9NH9F55FL7N79g
 Q5pXuR4t43kdYkqJF2Z6guHOm+0cfX+hN5bCTIr6uxazNhATKM0sAburuL3IJZ2LvXvVMyzC7
 gG49suCgbYwci5DLgO71kuiHK3WI5R0uCTWK4tVzPb/wOZHCBzrJqFZzBCNAMkc2/gYF1x4ba
 VBsQuPj50Emtsv9ui94SPbJX4NxTbUIAr32M+fUhBL5vQMeGeqoO06CouzM4YweQzcXD5hJYq
 rE01vAoHM9v1aAB3IoVZzxOb8OfkGT7WZr7tbLxX5Ut6XgzwDmvN6aZUUX2s=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 16 Dec 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > If you care to look at our very own `compat/win32/dirent.h`, you will =
see
> > this:
> >
> > struct dirent {
> >         unsigned char d_type; /* file type to prevent lstat after read=
dir */
> >         char *d_name;         /* file name */
> > };
> >
> > And looking at
> > https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/dirent.h.htm=
l, I
> > do not see any guarantee of that `[256]` at all:
> >
> > The <dirent.h> header shall [...] define the structure dirent which sh=
all
> > include the following members:
> >
> > [XSI][Option Start]
> > ino_t  d_ino       File serial number.
> > [Option End]
> > char   d_name[]    Filename string of entry.
> >
> > You will notice that not even `d_type` is guaranteed.
>
> I am reasonably sure that the code (without Elijah's patches anyway)
> takes the possibility of missing d_type into account already.
>
> Doesn't the above mean d_name[] has to be an in-place array of some
> size (i.e. even a flex-array is OK)?  It does not look to me that it
> allows for it to be a pointer pointing at elsewhere (possibly on
> heap), which may be asking for trouble.

You are right, of course.

I also was not _quite_ spot on, as I had looked at Git for Windows'
`shears/pu` branch, not at the `pu` branch. Alas, we have patches in Git
for Windows that allow for switching to a faster, caching way to access
the stat() and readdir() data (it is called the "FSCache" and it is
responsible for some rather dramatic speed-ups). And these patches change
`struct dirent` to the form that is quoted above, to allow switching back
and forth between two _different_ backends, storing the actual `d_name`
not in `struct dirent` but in `DIR`.

Is this compliant with POSIX? I guess not. Does it work? Yes, it does.

I can't know for sure that it makes a dent, but FSCache is designed for
speed, and it actually does not even store the `d_name` in the `DIR`, but
directly in the cache structure, avoiding copying at all.

In short: if we can allow FSCache to keep operating that way (i.e. keep
`d_name` as a pointer), then that would be helpful to keep the performance
on Windows somewhat within acceptable boundaries.

Ciao,
Dscho
