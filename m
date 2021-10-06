Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3950C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97A761152
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 20:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbhJFUmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:42:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:47437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239570AbhJFUmP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 16:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633552821;
        bh=1fpvGHRCq1TVtkwfKbwfevPVpRssR2+CrNuigkF+1sw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KaIJ6D06X/zKr6rOecrQXMv8XboIJWbuFYGu4DSaj7OSBCS72Hx3HeXMy2m/mxJ2U
         coe5uPWVlYe7gwrfB1wS9vOGtwbX7n5K4EnoejCZc6ODS6oXk/W8Etop+2Hsus3B7I
         cukVelXG18Yl2XNA0bufGgKOQnDiLeKVFJuM8IBk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.23.42] ([46.183.103.8]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mirng-1n24oK3as8-00exxx; Wed, 06
 Oct 2021 22:40:21 +0200
Date:   Wed, 6 Oct 2021 22:40:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 08/15] scalar: implement the `clone` subcommand
In-Reply-To: <CABPp-BH0U9+KEHTuMdfu-jhL+y3eRzjyfuRzWy9-jGxka8PH+Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110062238540.395@tvgsbejvaqbjf.bet>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com> <CABPp-BH0U9+KEHTuMdfu-jhL+y3eRzjyfuRzWy9-jGxka8PH+Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wLl6K4r9xdkylwEpYN1CQt67ax0YN1FAqfzUqNRfRNSXXkiAUvU
 qtHILJw5BiYimyAyBuepdvGtxZ22kZKmjyIXpINdFsMMKpqbhFXB3LEBge1QZNfzU7TTIiz
 gwZAx1WrIQ7sPcf4DsrJRK0OB2GLdS8OQTqKjr5DmZCZByxoO8ho6DqgunIg1bwMFvNdXEc
 2Sou2ZL7tv8X06fDd/h6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W14LnOBifvc=:Rfg9r2FKL2Nda9X9+nNzXv
 uaotJjD7RCZqJMYNsTLIglflkuluaRtinpJh7GC29zup+KKfXFRCqkER8hNYpoJ8xeGtrKrl4
 PGaTO47Mj0gFFs9y4vcu8c5dT9USqRkYp8pm3eAu6/OiGuS3o1o1/lrcOohzdhUKN3fTY3+tb
 g/6qfFtbxXNhvKJwKiLhXs4bLbqpNlOBXvVSoOEMEsQMsM9ZSLN03CbK/jpoF9NknHE7lz60y
 DOkyaIc4ahK0M4y15wHsF/gaozSCfoIBRcsE9onyefH5ARrxdWwxIE7wzKliejNokJahPitIa
 SU/lQffveF7JIapuFsKx5Jgt7VPl0htEzpVcVHQwzBn0nfuJvvzsfAMTpAypIHg7qliaD5zPx
 xeKz8MxDfLUpVHKpg7NC5IW20P1A+9K+xXiSWDPF1WAye3DwGjMZtCIVNYagxJCXmdhp3kBc4
 fyl0e6U/gQpjlUfIpDk4o725nKiED6eUv9qirOXeMWSnzPpOGyqh97C/j0yudc//VAMtVyw9/
 OkXNBXB0+EhoH2kKSPJQMZf1XIRMR0QZlF+QN2JdwH2KzQaUjuNncRbHjLY9abh6xXVBPhejn
 D8hAb0bo7EA0iNGGfIJBsFHfKnaJmvTOoqcPLapX0rzDBYiEAXVF0nP7/USbOEpPz78pDpLEr
 sqxsF2YD7wZ1OiieCYc5RAd/MCibefWM9UwJVzGtbiho19T867ytfV1P7esAgvsfnqF25ht3Y
 RWLcYi2KEg1wn1O/F6UneHVrjmm7nVM6hOf+jtCjPtUqc6XVeiO/MqntT9CVzVFiMGR7p8uCM
 D7llQiLA+4U7RIY2ddcc9sjzR7VfOqZ3ytRenkcV+Q8/GGj1FyMXpSZ1qCUy8sdMvns9eUEXA
 a06U+DlCwlCckmaxiKESM3gJdcPynBQIWsD/kB+uCKIPDvztZaOv8J5gWs0WEttQRHYRPOoIz
 R5uoUbpUmlqhVXSxdj1z+Z5c3q1jlpszEpbGLDWuzOBtM1XFejLIzW0jphaZtco8GXcZ9V+t1
 +3oSbwmeXJa+Kt9CPg6pwyaurpSGbeYK41jj3Ky0a8s6YJbEYKxv2npmIfpmQYBLUSBa+43OC
 j+EGX6HWKKnIBmtozW/Y4nbMh/z97vXuL+z
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 27 Sep 2021, Elijah Newren wrote:

> On Mon, Aug 30, 2021 at 2:36 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> ...
> >  COMMANDS
> >  --------
> >
> > +Clone
> > +~~~~~
> > +
> > +clone [<options>] <url> [<enlistment>]::
> > +    Clones the specified repository, similar to linkgit:git-clone[1].=
 By
> > +    default, only commit and tree objects are cloned. Once finished, =
the
> > +    worktree is located at `<enlistment>/src`.
> > ++
> > +The sparse-checkout feature is enabled (except when run with `--full-=
clone`)
> > +and the only files present are those in the top-level directory. Use
> > +`git sparse-checkout set` to expand the set of directories you want t=
o see,
> > +or `git sparse-checkout disable` to expand to all files (see
> > +linkgit:git-sparse-checkout[1] for more details). You can explore the
> > +subdirectories outside your sparse-checkout by using `git ls-tree HEA=
D`.
>
> Should this be `git ls-tree [-r] HEAD`?  Do you expect people to just
> add directories that are found immediately under the toplevel, rather
> than some that are a bit deeper?

I fear that `git ls-tree -r HEAD` in any monorepo might be a bit too
overwhelming for any reader.

But I agree that just looking at HEAD is probably not enough. Maybe we
should use `git ls-tree HEAD[:<dir>]`?

Ciao,
Dscho
