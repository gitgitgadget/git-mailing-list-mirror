From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH 2/2] blame: introduce -u/--unique option
Date: Thu, 10 Mar 2011 22:58:36 +0900
Message-ID: <1299765516.1499.150.camel@leonhard>
References: <1299581951-4670-1-git-send-email-namhyung@gmail.com>
	 <1299581951-4670-2-git-send-email-namhyung@gmail.com>
	 <7vy64o9ixz.fsf@alter.siamese.dyndns.org>
	 <1299737621.1496.55.camel@leonhard>
	 <7vhbbb5mzo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 14:58:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxgOD-0006FE-Av
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 14:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796Ab1CJN6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 08:58:46 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47623 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab1CJN6o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 08:58:44 -0500
Received: by iyb26 with SMTP id 26so1553535iyb.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 05:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=m7VMdw3EXhD6fR5LGXrhxyS831M/z9MksJmmf9h+C2A=;
        b=TqoiYwyNjzoNxwiAlSTXw90WyYUhwr+AEHO0+Nbz43QJkHTpfqxl5Z5TsqsYOiYXn5
         njjkA1vuPa6FtV7GqQ936GjRJiz6jwknQ+0PhAuTz9LISWbUC31Ch+VaGCKpYZi6mmj5
         8q9/njSXF1A7gj1vpRXJD0UJh0EjMFLIsnn78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Ngn2J9fAiPAMm9dDRo4EEeUyisgN89BiH0xW8w3fsbW1Du8R7xdlWenMc3Cd64XFDD
         0qTOVYUF4arA3+iM45c9aU2PjCBiRC/BP1PBLckjQumwoZ6xIF+ItltaEp3YMj4QGJwm
         CWRsOK+cqxlUm0dbTac9rDBoHxMXUYWWfGAh4=
Received: by 10.43.64.18 with SMTP id xg18mr56334icb.144.1299765523626;
        Thu, 10 Mar 2011 05:58:43 -0800 (PST)
Received: from [118.176.73.109] ([118.176.73.109])
        by mx.google.com with ESMTPS id 19sm2580300ibx.13.2011.03.10.05.58.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2011 05:58:43 -0800 (PST)
In-Reply-To: <7vhbbb5mzo.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168815>

2011-03-10 (=EB=AA=A9), 01:43 -0800, Junio C Hamano:
> Namhyung Kim <namhyung@gmail.com> writes:
>=20
> > Hmm... I thought about that too. But you mean that you only want
> > --abbrev instead of -u, right?
>=20
> Yeah, if it can be shown that ensuring the uniqueness in addition to
> uniform length with negligible cost, I don't think there is any reaso=
n to
> have this as an option.  So perhaps the minimum change would be to ke=
ep
> the current "8" as a hardwired constant to feed find-unique-abbrev wi=
th to
> find the longest unique prefix as your patch did and use that length =
when
> showing the output.  Making "8" configurable would become a separate
> topic.
>=20

OK. But I'm still wonder why the value is "8" instead of
"7" (DEFAULT_ABBREV).


> > My original intention was if user specified --abbrev explicitly, it
> > should be honored regardless of the uniqueness. The guard will not =
be
> > used in this situation because the user gave the exact length [s]he
> > wants to see.
>=20
> Hmm, like giving a ridiculously short --abbrev and forcing the output=
 to
> be ambiguous yet hopefully they can be differenciated by other clues =
like
> author and date?
>=20
> The reason I originally suggested to make the uniqueness an optional
> feature was primarily output performance, but that is linear with the
> number of lines in the file and is dwarfed by the history traversal c=
ost,
> so it is a non-issue, so I then suggested that it doesn't need to be =
an
> option.  But I think you may have a point--an option to decline uniqu=
eness
> would also make sense, especially when you want a very short prefix t=
hat
> you know won't be unique and when you don't care about uniqueness.
>=20
> As all the normal commands that use --abbrev would call f-u-a to ensu=
re
> uniqueness, the current "cut at fixed length" behaviour is an oddball=
=2E  It
> should become an optional behaviour.
>=20
> The current behaviour, when we eventually have both options, would be=
:
>=20
> 	$ git blame --abbrev=3D8 --no-uniq $rev -- $path
>=20
> and should be the default when neither --abbrev=3D$n nor --no-uniq is=
 given
> for backward compatibility.  Porcelains are _not_ supposed to be read=
ing
> from blame output without giving it --porcelain option, but we know w=
e
> cannot expect sanity from people who script around git.
>=20
> When you want to give a very short width that wouldn't guarantee
> uniqueness, and you want to force that width, you would say:
>=20
> 	$ git blame --abbrev=3D4 --no-uniq $rev -- $path
>=20
> Without --no-uniq,=20
>=20
> 	$ git blame --abbrev=3D4 $rev -- $path
>=20
> the command may use more hexdigits than 4 to ensure uniqueness, but a=
ll
> commit names are shown with the same width to ensure alignment as wel=
l.
>=20

Right. But I'm not sure what the end result should be if the guard is
set and/or --no-uniq is given. It might be related to the patch 1/2.

Say the unique length is 4 and the guard is 3. What do you expect from
the following command?

	$ git blame --abbrev=3D5 -- $path
	$ git blame --abbrev=3D5 --no-uniq -- $path

I think it should be 8 and 5. But possible alternatives are (7, 5),
(5, 5), (8, 8) and (7, 8).

Let me think of another example. In this case the unique length is 8,
the guard is 4 and the commands are same.

I think it should be (9, 5). And corresponding alternatives are (12, 5)=
,
(8, 5), (12, 9) and (12, 9).


My logic can be described like:

	default output 	=3D max((c + g), u)
	no-uniq output 	=3D c

where 'l' is the caller-given length, 'g' is the guard length, and 'u'
is the unique length.

Alternatives are:

(a)	default output =3D max((u + g), c)
	no-uniq output =3D c

(b)	default output =3D max(c, u)
	no-uniq output =3D c

(c)	default output =3D (c > u) ? (c + g) : (u + g)
	no-uniq output =3D c + g

(d)	default output =3D max((u + g), c)
	no-uniq output =3D c + g


Maybe we can make more combination if you want. What do you think?



> I kind of like that.  While I don't think "--no-uniq" is the best nam=
e for
> that option, I think --abbrev everywhere else implies uniqueness so i=
t is
> not a good idea to require "-u" option for unique output and give
> ambiguous output without one.  It would hurt consistency in the UI.
>=20

How about "--fixed" ?

Thanks.


--=20
Regards,
Namhyung Kim
