Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ECCC47082
	for <git@archiver.kernel.org>; Sun, 23 May 2021 23:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EDBB60FE6
	for <git@archiver.kernel.org>; Sun, 23 May 2021 23:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhEWX3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 19:29:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47430 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232091AbhEWX3f (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 May 2021 19:29:35 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4E29A60456;
        Sun, 23 May 2021 23:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621812457;
        bh=FpbF1jNeXy5ODqk2fGblRp/6sN3mUH++IbmV+X9PXB0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hpW8YVUlI4qFloS4gkjQqR1d8HHajsG4791cltZfrVy9RVeYoGLoo+K6ltAbMNCse
         i9JlI5Qq5NJlSpxjNwAPQiCLm/n32LMI8EzUUiD/Lr9inPQhyJ+fvlYyUk41MjE8DI
         Pv9xsJMuVGrh89fZW6lAm9LBEr6KTE0ufuIphFN3qm6xAdB+jN59ePbSYzaX2zJpy/
         zpIE69pmYSbaVgdRLFQYeVayafgyWNYYoiK8bJ1Z6TZzlAbQEB9EkSxtgVl9z/N+US
         664HlEIRHlpuU+wgEebudSpXrU8fYy14R7FPqM7kGo9UvvG/Y4dxjYRFUQ4I5bk4BL
         9rEWt/HfSWw28RGjNctne2Jgt+BMD6ff4hyVnRHQNZRlm5lOlCqnhiA2AmtK7b8Lv2
         1WAxDkkglZOfiPcA9cRTeiDc5RnZ1bVQGIdFFmsK09M4eBzjgdyxV/SOE+FHD9nq77
         oXKYEVqMjLjAvmOhG+65enEtqoeFXPKdW/gJRggISijAsDzPQSg
Date:   Sun, 23 May 2021 23:27:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 4/4] maintenance: optionally use systemd timers on
 Linux
Message-ID: <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210520221359.75615-5-lenaic@lhuard.fr>
 <715d8115-641b-5c06-d514-36911eb169ef@gmail.com>
 <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
 <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet>
 <60aaa09aebce4_454920811@natae.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cUMim8yGEW8zpS7U"
Content-Disposition: inline
In-Reply-To: <60aaa09aebce4_454920811@natae.notmuch>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cUMim8yGEW8zpS7U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-23 at 18:36:10, Felipe Contreras wrote:
> Johannes Schindelin wrote:
> > On Fri, 21 May 2021, Derrick Stolee wrote:
> >=20
> > > On 5/21/2021 5:59 AM, Bagas Sanjaya wrote:
> > > > On 21/05/21 05.13, L=C3=A9na=C3=AFc Huard wrote:
> > > >> The existing mechanism for scheduling background maintenance is do=
ne
> > > >> through cron. On Linux systems managed by systemd, systemd provide=
s an
> > > >> alternative to schedule recurring tasks: systemd timers.
> > > >>
> > > >> The main motivations to implement systemd timers in addition to cr=
on
> > > >> are:
> > > >> * cron is optional and Linux systems running systemd might not hav=
e it
> > > >> =C2=A0=C2=A0 installed.
> > > >> * The execution of `crontab -l` can tell us if cron is installed b=
ut not
> > > >> =C2=A0=C2=A0 if the daemon is actually running.
> > > >> * With systemd, each service is run in its own cgroup and its logs=
 are
> > > >> =C2=A0=C2=A0 tagged by the service inside journald. With cron, all=
 scheduled tasks
> > > >> =C2=A0=C2=A0 are running in the cron daemon cgroup and all the log=
s of the
> > > >> =C2=A0=C2=A0 user-scheduled tasks are pretended to belong to the s=
ystem cron
> > > >> =C2=A0=C2=A0 service.
> > > >> =C2=A0=C2=A0 Concretely, a user that doesn=E2=80=99t have access t=
o the system logs won=E2=80=99t
> > > >> =C2=A0=C2=A0 have access to the log of its own tasks scheduled by =
cron whereas he
> > > >> =C2=A0=C2=A0 will have access to the log of its own tasks schedule=
d by systemd
> > > >> =C2=A0=C2=A0 timer.
> > > >
> > > > For gender neutrality, we can use he/she instead.
> > >
> > > Singular "they" is better. Fully accurate and less awkward.
> >=20
> > I agree.
>=20
> I disagree.

I'm fully in support of singular "they".  It provides a useful pronoun
to use in this context, is widely understood and used, is less awkward
than "he/she," and is less sexist than the indefinite "he."

> > If the singular they was good enough for Shakespeare,
>=20
> Shakespeare:
>=20
>  1. Did not know gammar
>  2. Invented words as we went along
>  3. Was no writing prose

The point is that it has been used by native English speakers as part of
the language for over half a millennium and is widely used and
understood.  This usage is specified in Merriam Webster[0]:

  The use of they, their, them, and themselves as pronouns of indefinite
  gender and indefinite number is well established in speech and
  writing, even in literary and formal contexts.

Wiktionary notes[1] (references omitted):

  Usage of they as a singular pronoun began in the 1300s and has been
  common ever since, despite attempts by some grammarians, beginning in
  1795, to condemn it as a violation of traditional (Latinate)
  agreement rules.  Some other grammarians have countered that criticism
  since at least 1896.  Fowler's Modern English Usage (third edition)
  notes that it "is being left unaltered by copy editors" and is "not
  widely felt to lie in a prohibited zone."  Some authors compare use of
  singular they to widespread use of singular you instead of thou.

> The singular they is a controversial topic[1][2], even among linguists.
> This is a software project, we must not make decrees about proper use of
> English language, especially when linguists themselves have not yet
> fully decided.

Linguists fit roughly into two camps: prescriptive and descriptive.  The
former specify rules for people to use, and the latter document language
as it is actually used without forming a judgment.  While I am not a
linguist, I have a B.A. in English, and my views fit firmly into the
descriptivist camp.

Some prescriptivists think it is acceptable, and some do not.  But
descriptivists will rightly note that it is and has been commonly used
in English across countries, cultures, and contexts for an extended
period of time and is therefore generally accepted by most English
speakers as a normal part of the language.  Since we are writing text
for an English language audience who are mostly not linguists, we should
probably consider using the language that most people will use in this
context.

> If you want to use "they", go ahead, other people want to use "he/she".
> The git project should steer cleer of value judgements that one is
> _better_ than the other.

Any time we provide a suggestion in a code review, we are proposing that
we have an idea that may be better than the existing one.  It may or may
not actually be so, but we are proposing it in an effort to make the
code and documentation better.  No good-faith contributor would propose
a suggestion to make the project _worse_.

It's completely fine for a contributor to propose that they think an
idea is better provided that they do so in a respectful and considerate
way, which I think happened here.  As with all matters of opinion,
whether a thing is truly better or not is unknowable, and the best we
can do is to adopt an approach that seems to be the most widely accepted
and most provident.

In this case, given the fact that singular they is accepted in a wide
variety of contexts, including many literary and formal contexts, and
even the relatively stalwart Chicago "recognizes that such usage is
gaining [further] acceptance," I think it should be fine to use singular
they here.  You are, of course, free to feel differently.

[0] https://www.merriam-webster.com/dictionary/they
[1] https://en.wiktionary.org/wiki/they
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--cUMim8yGEW8zpS7U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYKrk4AAKCRB8DEliiIei
gY5eAQChmgFJi6B4VAxFARrjlHopJPqUe7Nwm4qg4J7l7iMxtAEA6VZ6qaIMJAQD
vAfggkThd5B5YPCas54m0hd9R+91pg0=
=9wVH
-----END PGP SIGNATURE-----

--cUMim8yGEW8zpS7U--
