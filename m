Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C0EC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 06:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415E5610C8
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 06:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhIQHAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 03:00:35 -0400
Received: from mx1.emlix.com ([136.243.223.33]:39260 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhIQHAe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 03:00:34 -0400
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id BBEB1602F4;
        Fri, 17 Sep 2021 08:59:11 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List Mailing <git@vger.kernel.org>,
        Tobias Ulmer <tu@emlix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: data loss when doing ls-remote and piped to command
Date:   Fri, 17 Sep 2021 08:59:07 +0200
Message-ID: <2722184.bRktqFsmb4@devpool47>
Organization: emlix GmbH
In-Reply-To: <xmqq7dfgtfpt.fsf@gitster.g>
References: <6786526.72e2EbofS7@devpool47> <CAHk-=wgyk0mwYcMRC8HakzoAKL2Y3gwzD433tqKYYhV+r1PLnA@mail.gmail.com> <xmqq7dfgtfpt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2006021.n4l1ccZoEF"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart2006021.n4l1ccZoEF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Junio C Hamano <gitster@pobox.com>
Cc: Git List Mailing <git@vger.kernel.org>, Tobias Ulmer <tu@emlix.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: data loss when doing ls-remote and piped to command
Date: Fri, 17 Sep 2021 08:59:07 +0200
Message-ID: <2722184.bRktqFsmb4@devpool47>
Organization: emlix GmbH
In-Reply-To: <xmqq7dfgtfpt.fsf@gitster.g>
References: <6786526.72e2EbofS7@devpool47> <CAHk-=wgyk0mwYcMRC8HakzoAKL2Y3gwzD433tqKYYhV+r1PLnA@mail.gmail.com> <xmqq7dfgtfpt.fsf@gitster.g>

Am Donnerstag, 16. September 2021, 22:42:22 CEST schrieb Junio C Hamano:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > On Thu, Sep 16, 2021 at 5:17 AM Rolf Eike Beer <eb@emlix.com> wrote:
> >> Am Donnerstag, 16. September 2021, 12:12:48 CEST schrieb Tobias Ulmer:
> >> > > The redirection seems to be an important part of it. I now did:
> >> > >=20
> >> > > git ... 2>&1 | sha256sum
> >> >=20
> >> > I've tried to reproduce this since yesterday, but couldn't until now:
> >> >=20
> >> > 2>&1 made all the difference, took less than a minute.
> >=20
> > So if that redirection is what matters, and what causes problems, I
> > can almost guarantee that the reason is very simple:
> > ...
> > Anyway. That was a long email just to tell people it's almost
> > certainly user error, not the kernel.
>=20
> Yes, 2>&1 will mix messages from the standard error stream at random
> places in the output, which explains the checksum quite well.

If there would be any errors. The point is: if I run the command with ">/de=
v/
null" just to the terminals a hundred times there is never any output on=20
stderr at all. If I pipe stderr into a file it's empty after all of this (y=
es,=20
I did append, not overwrite).

That the particular construct in this case is sort of nonsense is granted, =
I=20
just hit it because some tool here used some very similar construct and=20
suddenly started failing. "less" isn't the original reproducer, it was just=
=20
something I started testing with to be able to easily visually inspect the=
=20
output.

What you need is a _fast_ git server. kernel.org or github.com seem to be t=
oo=20
slow for this if you don't sit somewhere in their datacenter. Use something=
 in=20
your local network, a Xeon E5 with lot's of RAM and connected with 1GBit/s=
=20
Ethernet in my case.

And the reader must be "somewhat" slow. Using sha256sum works reliably for =
me.=20
Using "wc -l" does not, also md5sum and sha1sum are too fast as it seems.

When I run the whole thing with strace I can't see the effect, which isn't=
=20
really surprising. But there is a difference between the cases where I run=
=20
with redirection "2>&1":

ioctl(2, TCGETS, 0x7ffd6f119b10)        =3D -1 ENOTTY (Inappropriate ioctl =
for=20
device)

and without:

ioctl(2, TCGETS, {B38400 opost isig icanon echo ...}) =3D 0

AFAICT this is the only place where fd 2 is used at all during the whole ti=
me.

Regards,

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart2006021.n4l1ccZoEF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYUQ8uwAKCRCr5FH7Xu2t
/KThA/9zN5ZH7uCU9KHb023JfZyJHjaIOTfX6AOuP4ecKP3cSR6mp9S6lO6VhRYS
ThJUwL7ELGvYoRofPlUEkKnG3pJuSIa+213DULXZpZvUg+pircpU8cOJsol7lmZi
WKL0aAKXmlG/myebGu3Qx4zJ7Njv/KUTYOeigMQs8vsgAqnkng==
=7Tka
-----END PGP SIGNATURE-----

--nextPart2006021.n4l1ccZoEF--



