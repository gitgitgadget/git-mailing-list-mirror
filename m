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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FB6B1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 19:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbfJNTdi (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 15:33:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:33365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730297AbfJNTdi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 15:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571081613;
        bh=S+A+aNKJIrODl4ANNS1ymy0NSyQ1USNgwPbUf4UJEpg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XIUWSIyuvShyq0tt/Qh5Nm/crKKmJCSnMHIqwQZ/dLy/bNpI5XOBgyTt3OD9Go+Q6
         Q2BsrEdtzm7wWFAWTH5qsDdFYnof43lUCy9iflu4a7mGgSSsdKbN/8GBXXK+QtLfsZ
         E6TLztsckAt2I0inlSBVoGfBkSLKIvSZ1rmn2QnQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKUv-1idXaU1AwZ-00LqR1; Mon, 14
 Oct 2019 21:33:33 +0200
Date:   Mon, 14 Oct 2019 21:33:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] column: use utf8_strnwidth() to strip out ANSI color
 escapes
In-Reply-To: <a165b244-b18d-0434-42c5-bfe28b8bab51@web.de>
Message-ID: <nycvar.QRO.7.76.6.1910142132360.46@tvgsbejvaqbjf.bet>
References: <9b3f6960-ea75-c3a7-3a24-0554320bb359@web.de> <nycvar.QRO.7.76.6.1910141312010.46@tvgsbejvaqbjf.bet> <a165b244-b18d-0434-42c5-bfe28b8bab51@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1425995918-1571081614=:46"
X-Provags-ID: V03:K1:IXRvgroSWSX2nj48rffnNt6GhCJJkDbxMUQQ1ZbwLu5j8vyL9it
 A+HeTxkFH2nCaKWFSxVE9rS+zS2TeyO5ny+jtxfS9J6BRArIv6Dt1+fZiWg+Gsxk5xK1h7Z
 wMTbbtgKFZSdaItRiP8KIa+bbkTmAU/b2B39qslZKI6TclG28SkTAeazEkky1NINh0mD6HN
 nZQW3zV/JaAM87S1kGELA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b72l6WTVKPE=:Xz4kn0lHmj6FdWNlvmlIur
 gvqicMDY27dpxZhrb4OQrNO1xV+s0JiLDm42c52jOmp8AlK25V68yxuHEzqZB20GGB07Ltfiq
 h+uSXo4ipe1TLFdnyl/YyQwnVGnOoaLh3M8Zv/IhV3ccx9E+c1EvRQsnYKvr/dY73fsxynWfh
 MLx/ED6IuhUFyuK02e3bxBQuB/0XP0iYHQ1I3BVr/JU7iLvWm3niaW6ipBwHvfBmlrbIB7qXr
 ZktbLs1eQXGs2IH9AS9J7m0jvfZDviMvYrnne/Q61PGXdNNOSZVGgAhNfNY3pECzcL2XCtP/H
 uKvlOVEUYUeQ6yNK6pnecDfmmQ5jMcSjH4A8jHpC+3S76mcAsS2bwG5hKKYj7xKM1q36ClR/D
 wHVzDqmq4QXHqr0TMCe6RRL4KBNoVk5zTtII022MpnWbN+QLBK8C41UexEgN0zWhvHA9SokdX
 DqDwoZF6kNz3Tc169UE9w3OWsv6IWPfqbRkYrQr6UkSr/h2pj/FQ2ba33mzcoNw0srP3CcohC
 nh7HF+jpnIPE9kuL6nvLzZSxvyUKuEvOkFYwfuDx85hkCu8HMcQXBu/ZR+xe/VbOGWWaGGACz
 zbNC6mrh6tJrD607Cd1yxvatE5K6Wk+TfY+DWtdmlHlWhuGyx5PDh7KPdkkIZWrTD8Nxdy9oh
 WnnSC3F9BJ4XXrLyFFygnj1VcN+UmRyY2RZ5j5/S1CSR6DqEYjcIRQaij59MMpcDCL36+160f
 noEGyjbKs4TVfbpibVx4sDFs//QCRNdodRQIr/Vje3pNj3CCgYDY2Qp+H+YIzXP4ySN/llzIB
 x1RJ6YIEKESlHv+AZuw7cKtjF/z9Gcxyr4j58Um70FfZ2hkqWW/I/iTTKfLPy6t/agv7Ne3mg
 HYB0bH2Xt1gWvMnmPQAYBghYygrKJ+ajyI0BDF9rxuAL3tMW6dkYSVOYHIuFg63Ab2R3ydFvl
 DJ8Et6rjILoKP+WR74Cs9zUWdo2HVO1VN1LGiYZvW0MX4/gjkcDGu3X0PgHcLYPeb+4PSrXBS
 +TOewtyZ7AnYg7SofqAprmw5FkK9Si79mmvrXpImK+5ufHm5VqeSe9730Xl2FLFDEG/B9C7Y+
 VN+spmt6vEBqB/oDq5se5a0d+CentGB7eHl5S+oGvewIom3CWs2WvBXH/OQsU7o9W+MK2mCka
 fkSX5HD5dVwV3ix9a+Lv5y+vkFQ4MVbKwHq/CRNJh+p5VoOIEdOhqlpeibfYe74tV0vij6dje
 zdfh7ytR7q1hRWpDopPuWBQhYVHStN4WaVMLo2xOkWrXx1RsgJtSZ4CGiaCs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1425995918-1571081614=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Mon, 14 Oct 2019, Ren=C3=A9 Scharfe wrote:

> Am 14.10.19 um 13:13 schrieb Johannes Schindelin:
>
> > On Sun, 13 Oct 2019, Ren=C3=A9 Scharfe wrote:
> >
> >> This changes the behavior, though: The old code skips all kinds of
> >> Control Sequence Introducer sequences, while utf8_strnwidth() only sk=
ips
> >> the Select Graphic Rendition kind, i.e. those ending with "m".  They =
are
> >> used for specifying color and font attributes like boldness.  The onl=
y
> >> other kind of escape sequence we print in Git is Erase in Line, endin=
g
> >> with "K".  That's not used for columnar output, so this difference
> >> actually doesn't matter here.
> >
> > Arguably, the "Erase in Line" thing should re-set the width to 0, no?
> > But as you say, this is not needed for this patch.
>
> It doesn't move the cursor, just clears the characters to the right, to
> the left or both sides, depending on its parameter.  So ignoring it for
> width calculation like	the old code did would be appropriate -- if we'd
> encounter such an escape sequence in text to be shown in columns.

Whoops, you're right. I brainfarted, mistaking it for `\r`... My bad!

Ciao,
Dscho

--8323328-1425995918-1571081614=:46--
