Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01EBC6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 13:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjC1NW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjC1NWu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:22:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704E0B756
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680009763; i=johannes.schindelin@gmx.de;
        bh=8gzbe4rjE+A5kecyps+W6Q4hyttSm723F5C1YqBgKXU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UJY5uOk0WXrdEj0luFAploOJPk5Q4Sr73vAqCIFkrDfUFvSLlKxdooSPmNm7viKUr
         iYxeJcVYkA7mryOaWQbq6UmqjhnWu6K6p6EiPX/+aYmvwPO0cEcQqEJbQrEYdNekMq
         euGeVlGemx/FLKIuWBECA6qxw+vKdxQjxgjGWBFrI13L1OuxI03XWFDzDmRerIYlgP
         w7PQakcN8HZDysLwpRQlBD6LWTW8/RZVcI87XpXHtVBJ+Uyk6sgHx2q1rdNTEJlQZL
         ho7LFcCast9xJThaPp4seyOYfSXPuw31Cu8EYwfy639Z9ERtdSnqCd9jAftLs6uVQv
         01C95Q+5d27Hg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bfw-1qW4B33GaU-018558; Tue, 28
 Mar 2023 15:22:43 +0200
Date:   Tue, 28 Mar 2023 15:22:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     ZheNing Hu <adlternative@gmail.com>
cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, t.gummerer@gmail.com
Subject: Re: Question: How range-diff lapjv algorithm work
In-Reply-To: <CAOLTT8QAd_dzmDrkLpyVCZykb_sPzR0VzsPf_jtQqim_NpqZFg@mail.gmail.com>
Message-ID: <f4b5d082-ebff-bfbb-7ede-0838c7b28790@gmx.de>
References: <CAOLTT8TcX6Wit=AOFGNLjA4v9HAvJJxCEtt3JhgUR+3OARycNw@mail.gmail.com> <CAN0heSoVBmkuEOkW3wRNXRRjG7y8UqvORie6ocYnmQRz4jEXkg@mail.gmail.com> <CAOLTT8QAd_dzmDrkLpyVCZykb_sPzR0VzsPf_jtQqim_NpqZFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-610005610-1680009763=:123"
X-Provags-ID: V03:K1:7VbGuHmNjGhOjwu5VjipkqWCoDemxRZUmvo+fuxBW6kiyaHOk3U
 5Z0maPXTiVc2ApGbmNlwG+5Y919+QhoVJWPVr3f3zq2bxDovuKef0qQdxS5MJCcFGel3ip/
 B/qtuk7/89XgvZQSSrOOwWOjwGIA46gnX9wu5H3IeLJjfOzl5S60aIWjbOyrwOzRxGIjGdX
 LiOGgwp7SQa8V6MeGGOtg==
UI-OutboundReport: notjunk:1;M01:P0:TDO7VJIHFfU=;o8DlBi2IcH/H1Fgr0OhG3ZszQI3
 gqm61Bj69XVa38LVAXPbEoEcfMxlXcvSY5rIy8gyAKCrfw56tlcRy4j+3qGFTQIoC6ePkf47+
 eKFwNeQe74S7OiRED5/OKRJpn5P9v2LkiPrNEOJYOWxxaaxqJYs3gdHK66rlFo3DgPOWUf029
 QozZsuXlCM8WrWxoqDl2uMpqCAT3Z7zp+CrfNASnRw5i4KUOKZ+tUx3vdcvVyAElGH0SZUxeY
 oN1E97A9P0/OLa1WyiL4IUO2Bxw6vnmkLsUIhoLayyVB4hxC1WDVFZX623+wyUxONT96cm4T2
 uOm+q/+Zr08VA82JOFb4RI0EnDxnLxFnWtR6oqwjtTW7jvWuaNRY/3tZNPJBBZMV3VusGSzcl
 9RNHHA2DT0vYJI2GsokV7W+/ZHmI7KshgIkoZ9qvrRqAMfSrtT9gv7vgfAghBtU2+blX4rYVh
 /fzA/54alpwyRpV+dfhjwi6epjuZTMpVXIzmb/kvBz0CebMJzbyngGPIZBk0yU6Jxev5UMG6g
 clkDIHDWGJtihRaZkWG1lWkeMsZ6ISCd72/yecXITA6dP7bezKQjXdduIkS2wpj9yM/4rDPqs
 zSzeKntcsyPPFh5//5P5Cya+8Pnt3Uy8XVkY8WobM5gwu6Kx1maC1Y4TLTMI0iKG94J7JELn6
 c9Hc3xY7iYxRBhzE0CXxXaes/mr6Gake45itDTOUvtYTzJ+FoWXP9QNDZdTlgCoPcbRljzmJQ
 4fn+hOPR0S2+eSklQmDIz0rxdDk2p2aJOJ+Rd1jov+II/R+fRW0uNM8z5QbaCVgzDal/vHron
 wYIOFeDjZVBxHnAVEGfxljEl7hD75gTma4uXMiqXOte62SfsUxQa7E3Bi4h/v5HTAskC8X1I2
 Ex0OFHSwxJw9VGsgX2wxvkosfMu9QKa5PFol5KrYR+CJU5YwirfsFr20ZaOtFvZFWcWCckGX9
 Ms8bZ/IUUAK7N39LSGUrnaafhqA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-610005610-1680009763=:123
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 9 Mar 2023, ZheNing Hu wrote:

> Martin =C3=85gren <martin.agren@gmail.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=
=888=E6=97=A5=E5=91=A8=E4=B8=89 15:47=E5=86=99=E9=81=93=EF=BC=9A
>
> > On Wed, 8 Mar 2023 at 07:50, ZheNing Hu <adlternative@gmail.com> wrote=
:
> > >
> > > 3. How does LAPJV work here? [2]
> > >
> > > [1]: https://github.com/git/git/blob/725f57037d81e24eacfda6e59a19c60=
c0b4c8062/range-diff.c#L310
> > > [2]: https://github.com/git/git/blob/725f57037d81e24eacfda6e59a19c60=
c0b4c8062/linear-assignment.c#L15
> >
> > This appears to be based on work by Jonker and Volgenant. Maybe
> > searching for those names online could find something. Maybe not
> > git-specific, but even if it's just the general algorithm as such, it
> > might be possible to find different explanations of the algorithm.
> >
> > I haven't really studied this algorithm, but since it's faster than th=
e
> > Hungarian algorithm, I could imagine that either
> >
> >   * it's super-useful to first understand the Hungarian algorithm, the=
n
> >     understand why and how the Jonker-Volgenant algorithm does better,
> >     or,
> >
> >   * it's completely useless to first understand the Hungarian algorith=
m,
> >     since they're so different.
> >
> > :-)
> >
>
> Ah, I had a look at the Hungarian algorithm earlier, because it is the m=
ost
> typical algorithm in linear assignment problem, it can still be understo=
od.
> I didn't read that paper by Jonker and Volgenant, but I should try to re=
ad
> it later.

Oh wow, what a blast from the past.

As I had briefly mentioned in
https://lore.kernel.org/git/nycvar.QRO.7.76.6.1805032227520.77@tvgsbejvaqb=
jf.bet/,
the code I contributed in
https://lore.kernel.org/git/3f51970cbc44bfe34133c48c0844ed3723e83808.15253=
61419.git.johannes.schindelin@gmx.de/
is a port from some Java code I had written earlier in my life which was
based on the Pascal code provided in the cited paper.

My recollection has faded somewhat in the past 9 years. But maybe the
following helps, or provides at least some entertainment.

My first version of a "linear assignment problem" solver _did_ implement
the Hungarian algorithm, and I cannot even find it anymore, it must have
been in 2010 or 2011. I only remember that the O(n^4) runtime was
prohibitively expensive: I wanted to automatically track cells in
microscope recordings as they migrated over a plate of agar. I _seem_ to
remember that it was kind of okay for up to a couple dozen, but we wanted
to track hundreds, even thousands of cells, for extended amounts of time.
We _could_ do it, kind of, on a ridiculously expensive machine with 128GB
(I _think_), but naturally time on that machine was limited.

So I set out to implement the Munkres & Kuhn algorithm (see
https://github.com/fiji/fiji/blob/7d683d2ad46d22ec2e0bdffe1aa02072ab62e359=
/src-plugins/TrackMate_/fiji/plugin/trackmate/tracking/hungarian/MunkresKu=
hnAlgorithm.java)
because it promised O(n^3) complexity, and it did allow us to track the
amount of cells we were studying at the time.

It took a _week_ to wrap my head around that paper, even if being somewhat
familiar with the Hungarian algorithm probably helped. You will see
extensive notes in the initial code comment that I wrote for my future
self if I ever needed to understand the algorithm _again_. Reading over
those notes after more than a decade, I realize that while they are
helpful for _me_, they probably help others only in conjunction with some
quality time studying the paper.

However, later on our tests revealed that The Munkres & Kuhn algorithm,
while cubic in complexity, was still much slower than the Jonker &
Volgenant algorithm. This algorithm is also cubic in complexity, but with
a lower constant factor, and I could implement much quicker than the
Munkres & Kuhn algorithm because I essentially could cheat a bit by
studying the the paper while taking frequent peeks at the code. That also
explains why I did not take extensive notes this time and only added a
terse code comment, and the commit message is not much better, either:
https://github.com/trackmate-sc/TrackMate/commit/e306a02f76a6b6e383c0d32ef=
aba565aca01a773

My tests must have been quite convincing back then because I already
switched to Jonker & Volgenant on the same day that I finished the
implementation:
https://github.com/trackmate-sc/TrackMate/commit/ad5012827417a40673901a37a=
f44904a2de73095

_Years_ later, I wanted to run `git tbdiff` and couldn't because it
uses not only Python but `numpy`. And `numpy` is largely native code, not
Python, and I had the choice of either getting `numpy` to build on
Windows, or reimplement `tbdiff` in pure C as a new Git built-in, I chose
the latter (because it seemed much easier). And since `tbdiff` used the
`hungarian` algorithm (https://pypi.org/project/hungarian/) that
implements Munkres' algorithm (which I assumed was a slight variation of
Munkres & Kuhn, with the same performance characteristics), I undusted my
Java code and ported it. When I say "undusted", I lie, because it is still
in use today. But it basically went unchanged for years because it is bug
free ;-)

So now that you know about the provenance of the code we're discussing, I
have to admit that I can contribute only very little to understand it,
other than providing a couple of pointers:

https://en.wikipedia.org/wiki/Hungarian_algorithm has a pretty good, if
quite mathematical description of the algorithm. (And now that I read it,
I realize that I probably inadvertently attributed Tomizawa's improvements
to Munkres & Kuhn.)

It is amazingly hard to find good explanations on the 'net that aren't
using hard-code mathematical symbols, but I think I found one that
illustrates how the algorithm works:
https://medium.com/@rajneeshtiwari_22870/linear-assignment-problem-in-metr=
ic-learning-for-computer-vision-eba7d637c5d4

Hopefully that helps.

Ciao,
Johannes

--8323328-610005610-1680009763=:123--
