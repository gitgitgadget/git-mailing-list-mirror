Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642EAC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 16:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242344AbiBYQ0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiBYQ0v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 11:26:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251821CDDE4
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645806371;
        bh=IvxSSCc63s2t3YA9Zy4JXbpxM8O0i1uSA38T45SL+XQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aNXzcYI/YaY7/3cwT6OntWoGoMwtbUAwzXLaQDrImSr3QtImc0G9pNrUApIcIk2oG
         T694efoUuvOUjA9vQZbm/G6hWTqdvI7hcMivkzTFQhn9glhWae1sCYDC16Uu3xLLwA
         C8Ygb4DtGzX73kGlASjS1RgHZcFz8LRMl1+6sRdo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7Ka-1nUpDN1wHi-00Bbhe; Fri, 25
 Feb 2022 17:26:11 +0100
Date:   Fri, 25 Feb 2022 17:26:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
In-Reply-To: <CABPp-BG7id0GfpDee_7ETZ_94BC_i-e_=-u=PrYJeD7d4sVbiw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202251706150.11118@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com> <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2202221751550.11118@tvgsbejvaqbjf.bet> <CABPp-BG7id0GfpDee_7ETZ_94BC_i-e_=-u=PrYJeD7d4sVbiw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oJy37fB5tvqxNx0U/blN+RSe3UsVHO9FbmPXW/UZS9Hlz2gHO59
 kEuA87ovdfxX/LmH/kVM5vr/Ftf0OOqTtWmgiUIxiEV/ve+FBaRDIfC5BU36VaqSu9z6ScD
 tLHegKtXMG5Kedij8NCnyImiqDECGbbZHQO9g+j2SlvEW/TxoAQ65hQCThOwQaN7+pTdnvF
 Ng8LyuJOdpXGI1gOuK5ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:03+WX5OST9o=:a9tLU56GTHXH1hKRn015m0
 kddLLi61XhHN763JUYyTnpqIXkW6ziFb6DS2OmLJkDaaA9MEtLzwe+gSjl/rj8BK2TK7NqlEV
 NA/btDQJ6I2hirV/NwinzoLy7DaMKas35CvWwkwPeuSbvB3cCTOKXrkz2gzPJGz3HrajswQkm
 lgEYQbunV02+KGhgYzqLLZ7WVMAeAe2BAVYI0Pzryhu0BCW7RTTx2QSV3wVpE58p0neDehUGq
 mD1cK49sEp2x6aC2pBV7K+jkvFDFOGOZBfBBeoeot9/vPFrl/mFqVB6/6wzAXIvMRWiGOWGPV
 TJbbxkyQyHFmPGNm1S1eMBTQVgYYtlAWv4Hb0Cf55G5zVc0HkGg9mbl8HBBS0JDFpA5UlFHOX
 212uqt8aSxk1PRAdld8gV51ZZeiiBECKjd4hWotlbJo0443J7nczt+OBY4/R+lwRKtP3g6xn0
 4STI/bNTLzKBm+MfbkS7+mB+5YGUDrIVpM21FIUchRA5/cCmFnJRmiAUCHwPy+XKXLZ+XTA+f
 dBluvjt+d3Jq1OFpskuL7+eVb065KU+AF4h8EF8NJ3eKPPk0gsER4EHUvgBA78BScHVKHCAmG
 R5tPnNeR9agmEZP1TCJGzvH2cs/sF3ViToiOE8ZDPnb4L6uYk+4iiGXhwJGAEGldQdphRXT3N
 UnDF8wJ85GoXfwaHgbyl94HacKGukxX3M5BfILgTmxTNUP8W1g/ch/a5y1dx+0sp4qXzecl4/
 za1b6oinb7jcFVob4uV5Rn4stbXNyX8RwZ4An8OCC4WrsIuToDjU0goaWARzn9Dm2ueV0pIsp
 xq3DTlKn2+essag8jRK2lYyKWh+CvBHCLXlFFHahsvSDaGP7if3a9VbXqbtSHK48v8TYv+NP9
 DWBFvQAKeZou0asZd2m7H9zKPNMC4NYrZV0m2dGM9JV0nsce2KtBv7WHJ123lxt3SHKzjqDhN
 vi5Rw8lxf/km0qdPikhXNZOQmPDnYUJIcombfKAKOKt1hLyO7HkdlvLzhLKor2ZDi3XHVibIN
 RweS/nLm0Spvr697Eg9751BS4DCdxzE/9GfiYXR7Ph9y+U8w00jvd5ug5vkTiDvp7Ecarc1bh
 5mRtQdRWU3uuPE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 22 Feb 2022, Elijah Newren wrote:

> On Tue, Feb 22, 2022 at 8:54 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 21 Feb 2022, Johannes Schindelin wrote:
> >
> > > [...] since `merge-tree` is a low-level tool meant to be called by
> > > programs rather than humans, we need to make sure that those message=
s
> > > remain machine-parseable, even if they contain file names.
> > >
> > > [...]
> > >
> > > Do you think we can switch to `sq_quote_buf_pretty()` for these mess=
ages?
> >
> > Or maybe much better: use NUL to separate those messages if `-z` is pa=
ssed
> > to `merge-tree`? That would address the issue in one elegant diff.
> >
> > What do you think?
>
> Separating the combination of messages for a single target path from
> the combination of messages for a different target path by a NUL
> character may make sense.  Would we also want the messages for a path
> to be prepended by the pathname and a NUL character, in this case, to
> make it easier to determine which path the group of messages are for?
>
> I'm not sure if that does exactly what you are asking, though.

The most important thing I am asking for is a way for a program calling
`merge-tree` to figure out whether it knows how to handle all the types of
conflicts encountered in this merge.

So that a web UI could present e.g. simple content conflicts, and even
rename/rename conflicts, but would know that it cannot resolve the
conflicts e.g. when a submodule is affected.

So... I am fairly certain that we're not as close to addressing this as I
had hoped for.

> The thing that is stored (in opt->priv->output) is a strbuf per path,
> not an array of strbufs per path.  So, if we have a rename/delete and
> a rename/add and a mode conflict for the same "path" (A->B on one
> side, other side deletes A and adds a symlink B, resulting in three
> messages for path "B" that are all appended into a single strbuf),
> then we'll have a single "message" which has three newlines.  We can
> add a NUL character at the end of that, but not between the messages
> without restructuring things a bit.
>
> There's also at least one example, with submodules, where there are
> two path_msg() calls for the same individual conflict in order to
> split conflict info from resolution advice, and those really shouldn't
> be thought of as messages for different conflicts.  (I'm starting to
> wonder if the resolution advice should just be tossed; I kept it
> because merge-recursive had it, but it might not make sense with
> merge-ort being used by server side merges.  But even if we toss that
> one, I'm not sure I want to commit to one path_msg() call per "logical
> conflict".)
>
> But...maybe this would be good enough for some kind of use you have?
> Because if you only want to care about "simple" cases, you could
> potentially define those as ones with only one newline  in them.

We cannot rely on newline character parsing because that is a valid
filename character on Unix:

	$ echo a >'with
	> a newline'

	$ ls -la with*
	-rw-r--r-- 1 me me 2 Feb 25 17:10 'with'$'\n''a newline'

I guess we have to work harder on this and add more than just an `strbuf`
so that we can output `<path>NUL<conflict-type>NUL` pairs (where we
promise to keep the `<conflict-type>` strings constant) or something
similar.

Ciao,
Dscho
