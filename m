Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3A9C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 21:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhLPVUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:20:52 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:43380 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhLPVUu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 16:20:50 -0500
Date:   Thu, 16 Dec 2021 21:20:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1639689647;
        bh=uWdr6hKqKeELdNXCB1Lj0znJ8m3Ce0STW+JB3Jdqo2k=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=ui0aSqg6NOB8UCGUsljgueot+KOiksA0RTVPOCzYISLJmAEkcpCtUnr86+bb/X2Hq
         LPLzYvt3Ik7B+/9nHxg409onFmVK0TaIL6Ws6uwhMf3ZPAxris7xUDG/b5l6IkLYnh
         7U/2kkEEqkbhFKZMK3YG5AcPMQ+ZxKvwI55RWkIj0BLHHR5JhGwOXZAoAmHe7aNJ3O
         Q5fSJZMRj0FpqNiYHdycUmqWDtaq0dOX9z0sCLis888iEXWu4kkmfW1rzz/YSQxm11
         FjnHUC1AtnMGpbNjxKToH1bnJFmud2xTFIEKIue9hzWLNxBQUCw4lXSnB1bjnSS/gC
         0PpeDOPltDOhw==
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
From:   =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim@protonmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: =?utf-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
          <JoaoVictorBonfim@protonmail.com>
Subject: Re: Fw: Curiosity
Message-ID: <xndBIO9EtrXaA932eF-0YkvHCAOL1GOKQQlIigssmcwhtZWqGxhc6I_A-lXt7vMK-j1oDrQMHUIuExlpqFS4v88nWci32qx3W5Xi1_hPpUM=@protonmail.com>
In-Reply-To: <YbqiQ1B9ezF/RPOn@camp.crustytoothpaste.net>
References: <Wlh_w2gSCDQ2ieJnIY7TStWrzxbwP98SNRIFMTYpva7SRFipqk63HEYFVF7wFn1oSHOkQNsjWGOa5L49vyRlvSLbuZqpmvOaDOHmFkdt2zw=@protonmail.com> <wVwq9WVLpVt7MNLmIYOWCFKVSf8l532MD_vu4yTA8hl1fCARnW8nOUJjxYmKSzFw1SnPp5iYRD-aW4gAT2HnyQbC5aLBOvyT6npn88lxwNQ=@protonmail.com> <xmqq8rwl91yf.fsf@gitster.g> <YbqiQ1B9ezF/RPOn@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> To expand on this, if what you're storing is already compressed, like
> Ogg Vorbis files or PNGs, like are found in that repository, then
> generally they will not delta well. This is also true of things like
> Microsoft Office or OpenOffice documents, because they're essentially
> Zip files.
>
> The delta algorithm looks for similarities between files to compress
> them. If a file is already compressed using something like Deflate,
> used in PNGs and Zip files, then even very similar files will generally
> look very different, so deltification will generally be ineffective.

This explain why, also, Git opens a new mode every time an edit is made,
since it cannot recognize any similarities between the files, even
though there are.

> There are two main solutions to this. One is to store your data
> uncompressed in the repository and compress it as part of a build step.
> This makes your checkouts larger, but it makes your repository smaller.
>
> The other is to store them outside of the repository proper. Some folks
> use Git LFS for this, but you could also just store a manifest with file
> names and secure hashes, plus a download location for a public server.

Maybe I am thinking too outside the box, but wouldn't it be quite more
effective for git to identify compressed files, specially on edge cases
where the compression doesn't have a good chemistry with delta compression,
decompress them for repo storage while also storing the compression
algorithm as some metadata tag (like a text string or an ID code decided
beforehand), and, when creating the work mirrors, return the compression
to its default state before checkout?

Of course you would also need reversing functions when you want to
checkout the info back to repo.

Just throwing ideas out there.

-------------------------------

Jo=C3=A3o Victor Bonfim, any pronouns are welcome.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90Original Mes=
sage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

Em quarta-feira, 15 de dezembro de 2021 =C3=A0s 23:19, brian m. carlson <sa=
ndals@crustytoothpaste.net> escreveu:

> On 2021-12-15 at 18:07:20, Junio C Hamano wrote:
>
> > Jo=C3=A3o Victor Bonfim JoaoVictorBonfim@protonmail.com writes:
> >
> > > Since Git is almost used for everything at this point, is there
> > >
> > > any intent on providing better support for non textual file types?
> > >
> > > Why do I say this? Take this game mod which I follow as example ->
> > >
> > > https://github.com/SolariusScorch/XComFiles <- whenever I clone it
> > >
> > > Git takes a significant forever amount of time to download 452 MB
> > >
> > > of files whose some part, from my perspective, isn't being delta
> > >
> > > compressed like the text files are (since, whenever reading a log
> > >
> > > of what changes were made, git creates and undoes modes for all
> > >
> > > binary files, some of which only changed by a pixel from one
> > >
> > > colour to another).
> >
> > Our delta compression does not care whether the contents are text or
> >
> > binary, so if it is not compressed well, so it can be a sign that
> >
> > the contents are not compressible to begin with, at least with the
> >
> > xdelta binary-diff-patch engine we use. Improvement designs,
> >
> > algorithms and patches are always welcome ;-)
>
> To expand on this, if what you're storing is already compressed, like
>
> Ogg Vorbis files or PNGs, like are found in that repository, then
>
> generally they will not delta well. This is also true of things like
>
> Microsoft Office or OpenOffice documents, because they're essentially
>
> Zip files.
>
> The delta algorithm looks for similarities between files to compress
>
> them. If a file is already compressed using something like Deflate,
>
> used in PNGs and Zip files, then even very similar files will generally
>
> look very different, so deltification will generally be ineffective.
>
> There are two main solutions to this. One is to store your data
>
> uncompressed in the repository and compress it as part of a build step.
>
> This makes your checkouts larger, but it makes your repository smaller.
>
> The other is to store them outside of the repository proper. Some folks
>
> use Git LFS for this, but you could also just store a manifest with file
>
> names and secure hashes, plus a download location for a public server.
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------------------
>
> brian m. carlson (he/him or they/them)
>
> Toronto, Ontario, CA
