Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AECC433EF
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 00:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhLRARu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 19:17:50 -0500
Received: from mail-40140.protonmail.ch ([185.70.40.140]:18064 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhLRARu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 19:17:50 -0500
Date:   Sat, 18 Dec 2021 00:17:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1639786668;
        bh=8jt0CahJ4DiKGKU1S7HYj6cVM1Sl17rJ6+FAi0FPS1Q=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=M/b9c30w39tSlA9moGMEuIEkyP5IlZOGWhGDlzd2HTcQ6AyTnm+cL4V9m9lv0AX9f
         pX9G6evbv+R9Bc5pGvrWObeCheceCRC7f0XphYTUo4M2LaX7rNrTgX628VvGIttedK
         iY1hNutMfXxpwD9zaGNFa0SBnoiX9hOB0GovqPbUpbxXO963wBMBwf6wuHawtTb7lC
         J7v5cOLJLcEXjSq6b8D62+qrPgdAV55xwsAksmZJVsFfJcN3b4ihOYhl6N1tj5xFC6
         FomrWiOSkV5Ezk8X6b/ptV2ebBWUtWUtRYhjxjsvvvP2+Fpg85F0dKuP4mr2WeltVA
         g8baAduhM9Lcg==
To:     Junio C Hamano <gitster@pobox.com>
From:   =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim@protonmail.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Reply-To: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
          <JoaoVictorBonfim@protonmail.com>
Subject: Re: Fw: Curiosity
Message-ID: <qzxpLxxzy2ooNpnphGZ_IjuF0yj-39e_CR6OiXgthFAz2VR_OKA2HzyY2zznYIv4DyZZFfrBiMa9M1eR_Qwj8iJHZzMBd_QsEoPIYHMEwuo=@protonmail.com>
In-Reply-To: <xmqqtuf88bw6.fsf@gitster.g>
References: <Wlh_w2gSCDQ2ieJnIY7TStWrzxbwP98SNRIFMTYpva7SRFipqk63HEYFVF7wFn1oSHOkQNsjWGOa5L49vyRlvSLbuZqpmvOaDOHmFkdt2zw=@protonmail.com> <wVwq9WVLpVt7MNLmIYOWCFKVSf8l532MD_vu4yTA8hl1fCARnW8nOUJjxYmKSzFw1SnPp5iYRD-aW4gAT2HnyQbC5aLBOvyT6npn88lxwNQ=@protonmail.com> <xmqq8rwl91yf.fsf@gitster.g> <YbqiQ1B9ezF/RPOn@camp.crustytoothpaste.net> <xndBIO9EtrXaA932eF-0YkvHCAOL1GOKQQlIigssmcwhtZWqGxhc6I_A-lXt7vMK-j1oDrQMHUIuExlpqFS4v88nWci32qx3W5Xi1_hPpUM=@protonmail.com> <54fe7ba20109f974b61a7e6c24ba8264@codeaurora.org> <xmqqtuf88bw6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> That is probably too application specific to be in core-git, but it

Application specific as in that it is too much of an edge case to be used b=
y all git users?

> is probably a good application for smudge/clean filters like brian
>
> alluded to?

Perhaps.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

Em quinta-feira, 16 de dezembro de 2021 =C3=A0s 18:42, Junio C Hamano <gits=
ter@pobox.com> escreveu:

> Martin Fick mfick@codeaurora.org writes:
>
> > On 2021-12-16 14:20, Jo=C3=A3o Victor Bonfim wrote:
> >
> > > > To expand on this, if what you're storing is already compressed, li=
ke
> > > >
> > > > Ogg Vorbis files or PNGs, like are found in that repository, then
> > > >
> > > > generally they will not delta well. This is also true of things lik=
e
> > > >
> > > > Microsoft Office or OpenOffice documents, because they're essential=
ly
> > > >
> > > > Zip files.
> > > >
> > > > The delta algorithm looks for similarities between files to
> > > >
> > > > compress
> > > >
> > > > them. If a file is already compressed using something like Deflate,
> > > >
> > > > used in PNGs and Zip files, then even very similar files will
> > > >
> > > > generally
> > > >
> > > > look very different, so deltification will generally be ineffective=
.
> > > >
> > > > ...
> > > >
> > > > Maybe I am thinking too outside the box, but wouldn't it be quite m=
ore
> > > >
> > > > effective for git to identify compressed files, specially on edge c=
ases
> > > >
> > > > where the compression doesn't have a good chemistry with delta
> > > >
> > > > compression,
> > > >
> > > > decompress them for repo storage while also storing the compression
> > > >
> > > > algorithm as some metadata tag (like a text string or an ID code
> > > >
> > > > decided
> > > >
> > > > beforehand), and, when creating the work mirrors, return the
> > > >
> > > > compression
> > > >
> > > > to its default state before checkout?
> >
> > I suspect that for most algorithms and their implementations, this woul=
d
> >
> > not result in repeatable "recompressed" results. Thus the checked-out
> >
> > files might be different every time you checked them out. :(
>
> That is probably too application specific to be in core-git, but it
>
> is probably a good application for smudge/clean filters like brian
>
> alluded to?
