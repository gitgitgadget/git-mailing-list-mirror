Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE50C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B3B61B50
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbhKQXeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 18:34:12 -0500
Received: from mout.gmx.net ([212.227.15.19]:40053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240122AbhKQXeK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 18:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637191867;
        bh=5TpIi1dkHBF4AWbFRQj5idGE8Q+Nh8GL4fR6gunMyQU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CkuiLw+OZhR0yIbsF9zMWnF3EZva7jcUrK19+mdkfPfNv1OJZ3I4MR163SQ3OZpO8
         3dleWVb4GLU60ugQkYSLVwdKMPitmPEieqwU6FAXchh2HArui7wHNxKhVE1A/iR8b4
         8oMk0twAL/e4cxCsVwVjUrOx9pkG48bPAT0+yH24=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mdeb5-1mDsap3Tft-00Zhvg; Thu, 18
 Nov 2021 00:31:06 +0100
Date:   Thu, 18 Nov 2021 00:31:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] mergesort: avoid left shift overflow
In-Reply-To: <xmqqr1bf2l83.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111180026580.11028@tvgsbejvaqbjf.bet>
References: <5eabbe1c-4c0f-559a-da21-423afec89e7e@web.de> <nycvar.QRO.7.76.6.2111161505500.21127@tvgsbejvaqbjf.bet> <xmqqr1bf2l83.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bxIO5T4OJ5U6R0UaRDGP+KIo7j3s8oKkZK9fVndVb7S6WokFVKJ
 jPT1hau9CYuSh+uwxS+4JiQwnZ2u/hP0PfR6s0pTY+SJjZ6hYV4ifimzsCXZnlrAzQv0xVm
 9M+Z2jwSThlEcokW9SiGi6U01IJ9jpvJ2pwvrjowpcrOqBuBGqa1NTdrfGDo6RN3FhQe69J
 3x2NeYqQKqz+BUtiyBZng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xNqER82il40=:zFRzxOt54dbNzB3fBInS+L
 V71Rmd1m0YCT1xWoljreDFjjcWsB/bk0SmvM4Xx01CuggTArrIbxl27erFBUHlIcfMmg/SKRm
 ATRDCoQyItbUHmGo1cu8Q5CzZrqGJfKvElHZUTxiAz3y2ZG0AEXtVwIH8ACuNpIhKUvo8o+56
 YmeIHUvlbmY4VhT16MkC5fpQOyTuQevHgtzuIKY93qjQnBx3Q0nE+Y60qDiI0v1UwxLREYmKy
 +8uk2+Ow5QKb6WolHjQpVulNalIJeadYcLL2YqOyi3ZnhCjAp7TAo0uQSmdU82yZ+YYsaDXoL
 /Xth0Bim6ZjR3y3rrSuazxPPR65A81gcVZI9S5KjMEjAF7XLHnXn1YNnj02hJ1bm3tZV6TljD
 HDGIIjH0BkQ4yQxDERi8lBNkHAKErPFOcad6lOodWfSdWBideqPGgk0Tjxb/me7z+93BUtk7N
 hyNxe/Xq5hxgJGu/w61gxODYHTLOX1g3XOVCNaLG5TjV8MdQvwDeX3B7dkOdbGryWej96gEa8
 pPnf6QUr/9Be+DLBnIxWTQ5cg/sjpji3RM1xtRVtmlwFsQgR0D6Z/ZYylUPVZVpLhKsyQbYf1
 XCmFkEpORj64seYBteKe+UBOg6I9dKrgQ3o2yUskWbxjFd6rf+VPJOW3emmfHgSxx12etywaF
 T0WgQiIOJ38amSf4W/hD38DGDQi5E7KX0sqbW3Pn2vLjOBddJnkz/DCrsO3kro50bWrwJ2kz+
 K6ej54gw0d+NiJqUpMy+M2MrRbcYvoPll9yP769dOhqth+pDlfcdIqSFhuw+pFhJjE68DgHCf
 07k8y27ez4hocbzN9yNgWqnLl5/aiSNEP8ZjMMlq/fUDuXt5KXVcFQoYAOa8wbIXE5K3Dq4TR
 gnNh4zf37T97XRhSFcap5gA4EP6E/Uhh47v/QmH7FYcPMan382V2IfzRVdN3QRQrJsK3PVYVn
 p2IHJE7orS4wRJ4ueZChuuc8zakNuc1621mnCidZ0q3A1L3FdKK34peSi9en8BQrYx1lh+sTY
 2Rh7w3fXBv6FfqDNGFWJ9uBB8xfGIlVn3vtOkUK4hJSqtxqyerOjJzMSYKxHp9Jn6puMG21oB
 i0W2gxFqp8bEvY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 17 Nov 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> diff --git a/mergesort.c b/mergesort.c
> >> index 6216835566..bd9c6ef8ee 100644
> >> --- a/mergesort.c
> >> +++ b/mergesort.c
> >> @@ -63,7 +63,7 @@ void *llist_mergesort(void *list,
> >>  		void *next =3D get_next_fn(list);
> >>  		if (next)
> >>  			set_next_fn(list, NULL);
> >> -		for (i =3D 0; n & (1 << i); i++)
> >> +		for (i =3D 0; n & ((size_t)1 << i); i++)
> >
> > I was a bit concerned about the operator precedence (some of which I
> > remember by heart, some not), but according to
> > https://en.cppreference.com/w/c/language/operator_precedence the cast =
has
> > a higher precedence than the shift operator.
> >
> > I would have preferred an extra pair of parentheses around `(size_t)1`=
 so
> > that I (and other readers) do not have to remember or look up the oper=
ator
> > precedence, but it _is_ correct.
>
> Interesting.
>
> I do not quite see the need for it myself, but if we wanted to, we
> can smoke them out with this, I think.
>
> 	$ cat >contrib/coccinelle/cast.cocci <<-\EOF
> 	@@
> 	type T;
> 	expression V, C;
> 	@@
> 	-(T) V << C
> 	+((T) V) << C
> 	EOF

Cute.

However, I am not a fan of fixing what ain't broken (the many refactorings
in v2.34.0 did cause quite some fall-out work in git-for-windows/git and
microsoft/git, after all, and at least _I_ do not yet see much benefit to
show for that price we paid for those refactorings).

And the primary benefit of enclosing the left operand in parentheses is to
make reviews easier, so I would prefer to leave existing (read:
_already-reviewed_) code alone.

Thanks,
Dscho

> 	$ make contrib/coccinelle/cast.cocci.patch
> 	$ git apply --stat contrib/coccinelle/cast.cocci.patch
>          compat/mingw.c     |    2 +-
>          compat/mingw.c     |    2 +-
>          ewah/bitmap.c      |    2 +-
>          ewah/ewok_rlw.h    |    6 +++---
>          ewah/ewah_bitmap.c |    8 ++++----
>          ewah/ewok_rlw.h    |    6 +++---
>          ppc/sha1.c         |    2 +-
>          wrapper.c          |    2 +-
>          8 files changed, 15 insertions(+), 15 deletions(-)
>
>
>
