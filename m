Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03B121FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 12:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbdCMMuK (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 08:50:10 -0400
Received: from kolab.intevation.de ([212.95.107.133]:40878 "EHLO
        kolab.intevation.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753235AbdCMMuG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 08:50:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by kolab.intevation.de (Postfix) with ESMTP id 7460C6273B
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 13:50:03 +0100 (CET)
X-Virus-Scanned: by amavisd-new at intevation.de
Received: from kolab.intevation.de ([127.0.0.1])
        by localhost (kolab.intevation.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H6sGDdmdJqIe for <git@vger.kernel.org>;
        Mon, 13 Mar 2017 13:50:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by kolab.intevation.de (Postfix) with ESMTP id B695562782
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 13:50:00 +0100 (CET)
Received: from ploto.hq.intevation.de (ploto.hq.intevation.de [192.168.11.18])
        (Authenticated sender: bernhard.reiter@intevation.de)
        by kolab.intevation.de (Postfix) with ESMTPSA id 78ED362712;
        Mon, 13 Mar 2017 13:50:00 +0100 (CET)
From:   "Bernhard E. Reiter" <bernhard.reiter@intevation.de>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Stable GnuPG interface, git should use GPGME
Date:   Mon, 13 Mar 2017 13:49:47 +0100
User-Agent: KMail/1.9.10 (enterprise35 20150610.75555ff)
Cc:     =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        gnupg-devel@gnupg.org, Lukas Puehringer <luk.puehringer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <201703101100.15214.bernhard.reiter@intevation.de> <CACBZZX4Av-D6hxE9ceDFPuG-_qUQbH_6KW5JKsJf0SuH62jkuQ@mail.gmail.com> <a5161dd2-977b-8195-e558-01787fb3f01b@drmicha.warpmail.net>
In-Reply-To: <a5161dd2-977b-8195-e558-01787fb3f01b@drmicha.warpmail.net>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1975883.3h4N8EFoj4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201703131350.00139.bernhard.reiter@intevation.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart1975883.3h4N8EFoj4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag 13 M=C3=A4rz 2017 11:14:57 schrieb Michael J Gruber:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 10.03.2017 15:=
23:
> > On Fri, Mar 10, 2017 at 11:00 AM, Bernhard E. Reiter

> >> please consider using libgpgme interfacing to GnuPG, because the gpg
> >> command-line interface is not considered an official API to GnuPG by t=
he
> >> GnuPG-devs and thus potentially unstable.

[example of gpg2 vs gpg option incompatibility cut]

> > Using the library sounds good, but a shorter-term immediate fix would
> > be to figure out what bug you encountered in our use of the
> > command-line version, and see if we've fixed that already or not.

> As far as I know, Git handles different GPG versions just fine.

As mentioned before: explicitely setting gpg.program to gpg2 helps if gpg
chokes on the new config. Trying the `gpg2` binary first can be a simple fi=
x.=20
Using libgpgme potentially solves this and other compatility options.

> The problem is the "difficult" upgrade path and mixed installations with
> gpg and gpg2.1+ that some distributions force upon you:
>
> As soon as you start gpg2.1, your (secret) key store is migrated to a
> new format without technically invalidating it. Similarly, users may
> enter gpg2.1+-only comand in the config that is actually shared with
> gpg, throwing off any use of gpg - not just by git, but also by anything
> that your distro requires gpg for (such as packaging tools and the like).

Yes, this is another example why trying `gpg2? first by default or using=20
libgpgme keeps trouble away from users.

> In short: Users will run into problems anyway; git provides the quick
> way out (git config gpg.program gpg2), users won't be as lucky with
> other things that require gpg.

Application using libgpgme will behave fine and many user facing components=
=20
use it already.=20

> As for the library: While - technically speaking - the command line is
> not a stable API for gpg, it does work across versions of gpg, and gpg

=2E.. to some extend.

> 2.2 will be the first real stable branch that uses the new key store
> layout. So I'd rather wait for that to stabilize before going away from
> what turned out to be most stable so far.

It is not just about the key-store change as mentioned before. However
I agree that a potential switch should be done with a current version of gp=
gme=20
that already has support for GnuPG 2.1/2, e.g. gpgme v1.8.0.

> Note that we (git) refrain from parsing ordinary output/return codes of
> gpg and use status-fd as we should (and as documented).

It is good to use --status-fd and --with-colons when calling gpg, you still=
=20
have to parse the results of status-fd as described in doc/DETAILs.=20
https://git.gnupg.org/cgi-bin/gitweb.cgi?p=3Dgnupg.git;a=3Dblob;f=3Ddoc/DET=
AILS;hb=3DHEAD

Regards,
Bernhard

=2D-=20
www.intevation.de/~bernhard (CEO)     +49 541 33 508 3-3
Intevation GmbH, Osnabr=C3=BCck, Germany; Amtsgericht Osnabr=C3=BCck, HRB 1=
8998
Owned and run by Frank Koormann, Bernhard Reiter, Dr. Jan-Oliver Wagner

--nextPart1975883.3h4N8EFoj4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJYxpVrAAoJEDxD9Mjv9dQqMUYH/i5JAM9pv+ys7GFHwAMWbTlL
PdfSv6S6yjiReK+Ld+a6DPWbvySWhunE8zYUHEFV4kLkF8vofP2Y/9T9Ob0H40Oh
Any6IDXwadHYGxzYB4n+BP6mHNX5kslJCpuKvl4WXpv3h9BFErFG4MIM4mCcSafX
+mxE2V/KxXOXRQYCIMZqcKvVNktjr7NibEPTkPvPj1ZFuLhgVrO1+tQrl3N+zner
/pEz7I/po/kG/CGB8qwkjruVajKeYWzbGj1SPGam70V+OxoXwr5Q7lVzBy8LJoJ8
1rwZNVqUhkMk6cp2bIWxB/lhjqOFrW4XJwaATsj3IBPXG9/vntlaBxacdZGLJkA=
=txbJ
-----END PGP SIGNATURE-----

--nextPart1975883.3h4N8EFoj4--
