Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA7F201C2
	for <e@80x24.org>; Mon, 13 Mar 2017 11:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbdCMLOi (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 07:14:38 -0400
Received: from kolab.intevation.de ([212.95.107.133]:38455 "EHLO
        kolab.intevation.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbdCMLOg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 07:14:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by kolab.intevation.de (Postfix) with ESMTP id 769E6625C0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 12:14:34 +0100 (CET)
X-Virus-Scanned: by amavisd-new at intevation.de
Received: from kolab.intevation.de ([127.0.0.1])
        by localhost (kolab.intevation.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q7ZqwWkYycza for <git@vger.kernel.org>;
        Mon, 13 Mar 2017 12:14:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by kolab.intevation.de (Postfix) with ESMTP id 2023762706
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 12:14:32 +0100 (CET)
Received: from ploto.hq.intevation.de (ploto.hq.intevation.de [192.168.11.18])
        (Authenticated sender: bernhard.reiter@intevation.de)
        by kolab.intevation.de (Postfix) with ESMTPSA id EE093625C0;
        Mon, 13 Mar 2017 12:14:31 +0100 (CET)
From:   "Bernhard E. Reiter" <bernhard.reiter@intevation.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Stable GnuPG interface, git should use GPGME
Date:   Mon, 13 Mar 2017 12:14:17 +0100
User-Agent: KMail/1.9.10 (enterprise35 20150610.75555ff)
Cc:     Git Mailing List <git@vger.kernel.org>, gnupg-devel@gnupg.org
References: <201703101100.15214.bernhard.reiter@intevation.de> <CA+55aFxk7F103LADnmwc8wFySYQNiK6TcCQ0WSj+UTP-GihgcQ@mail.gmail.com>
In-Reply-To: <CA+55aFxk7F103LADnmwc8wFySYQNiK6TcCQ0WSj+UTP-GihgcQ@mail.gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3706125.QiT7mOZBRn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201703131214.31588.bernhard.reiter@intevation.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart3706125.QiT7mOZBRn
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag 10 M=C3=A4rz 2017 19:54:19 schrieb Linus Torvalds:
> On Fri, Mar 10, 2017 at 2:00 AM, Bernhard E. Reiter

> > please consider using libgpgme interfacing to GnuPG, because the gpg
> > command-line interface is not considered an official API to GnuPG by the
> > GnuPG-devs and thus potentially unstable.
>
> Quite frankly, I will NAK this just based on previous bad experiences
> with using "helpful" libraries.
>
> Maybe you can lay my worries to rest, but the problems with libraries
> in this context tend to be

As gpgme is not just a helpful library, but the official API to GnuPG, it i=
s=20
well supported by the GnuPG-Initiative itself and stable. Still there could=
=20
be problems and of course in some situations the disadvantages outweigh the=
=20
advantages. On the other hand we have seen a number of systematic problems=
=20
with "just calling gpg" that libgpgme tries to provide a solution to.

So it is too early to say that libgpgme would be right choice for git to me=
,=20
but it should be seriously considered. Grateful that you have written down=
=20
some of your concern, let me try give you some pointers.

>  - hard to personalize.
>
>    At least right now, we just allow people to set their gpg binary.
> I'm betting that the library would pick whatever random preferred
> version, and in the process possibly screwed us.
>
>    Example: what if somebody is actually using another pgp
> implementation entirely for some reason, and is just scripting around
> it?

>    Or maybe he's using the regular gnupg, but using different keys for
> different projects (using "--homedir"). That's trivial with the
> current model. How trivial is that with a library?

https://www.gnupg.org/documentation/manuals/gpgme/Engine-Configuration.html
"
You can change the configuration of a backend engine, and thus change the=20
executable program and configuration directory to be used. You can make the=
se=20
changes the default or set them for some contexts individually.=20
"

Using a completely different OpenPGP implementation maybe a potential use c=
ase=20
for keeping a configuration option around. I did not deeply examine what gi=
t=20
really needs. Usually a different implementation will have quite a differen=
t=20
command line interface, so it may require substaintial work to come up with=
 a=20
wrapper about that other OpenPGP implementation to provide the same command=
=20
line interface as GnuPG.

>  - existing configuration
>
>    This is the main problem I've seen in the past. Using the "ssh"
> _program_ is easy. You add your keys, your config files, whatever, and
> it "just works" (or rather, you fight it once and it definitely
> doesn't "just" work, but then you copy your .ssh directory around for
> the rest of your and forget how it ever worked, but it does).

gpgme via gpg uses the existing configuration files (which you can also rea=
d=20
and modify with gpgconf for implementiong GUIs).

>  - UI
>
>    For things like gpg, the UI is traditionally horrible. But there
> tends to be various things like password agents that help with caching
> passwords and/or add a graphical UI to get the password when
> necessary.

As the gpg binary itself speaks to gpg-agent, this is fully integrated when=
=20
used via gpgme. Our GPA and Kleopatra GUIs work fine with gpgme and others =
as=20
well, because they call come together in the deeper engine functions of=20
GnuPG.

>  - library versioning.
>
>    I don't know why, but I've never *ever* met a library developer who
> realized that libraries were all about stable API's, and the library
> users don't want to fight different versions.

In my experience Werner (the lead GnuPG developers) is quite reasonable abo=
ut=20
keeping APIs stable (he often goes out of his way to keep even the command=
=20
line version stable, maybe he shouldn't do that to the command line options=
=20
so you are more motivated to go to this official API gpgme. >:) )

>    And to make matters worse, the different versions (particularly if
> you end up having to use a development version due to bugs or required
> features etc) are always made horribly bad to even detect at
> built-time automatically with simple #ifdef etc, so now you have to do
> autoconf crap etc.

https://www.gnupg.org/documentation/manuals/gpgme/Library-Version-Check.html
"
The function gpgme_check_version has four purposes. It can be used to retri=
eve=20
the version number of the library. In addition it can verify that the versi=
on=20
number is higher than a certain required version number. In either case, th=
e=20
function initializes some sub-systems, and for this reason alone it must be=
=20
invoked early in your program, before you make use of the other functions i=
n=20
GPGME. The last purpose is to run selftests.

As a side effect for W32 based systems, the socket layer will get initializ=
ed.=20
"

> Now, it may be that the pgpme library "just works" across
> architectures and handles all of the above situations as gracefully as
> the external program does. In that case - but _ONLY_ in that case -
> would a switch-over to the library possibly be a good thing.

At least gpgme aims to fulfill these goals (and is used on many=20
architectures).

> I'd be pleasantly surprised. But I *would* be surprised, because every
> time I've seen that "library vs program" model, I've seen the above
> issues.

Your concerns are understandable, I've seen similiar problems with "library=
 vs=20
program" and the unix tools box approach gives a number of lessons on how t=
o=20
losely couple components. Thanks again for taking the time and writing them=
=20
down. I've given you some pointers why gpgme indeed could be different and=
=20
may be an improvement for git (or other applications). I guess one of the=20
next steps would be for someone to look for specific points or try gpgme fo=
r=20
git purposes. Me and gnupg-devel@ are happy to take your questions or get=20
feedback.

Regards,
Bernhard


=2D-=20
www.intevation.de/~bernhard (CEO)     +49 541 33 508 3-3
Intevation GmbH, Osnabr=C3=BCck, Germany; Amtsgericht Osnabr=C3=BCck, HRB 1=
8998
Owned and run by Frank Koormann, Bernhard Reiter, Dr. Jan-Oliver Wagner

--nextPart3706125.QiT7mOZBRn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJYxn8JAAoJEDxD9Mjv9dQqtxIH/1nj0/HvMdHqaMz4VJjCnxq3
caN0iZwmcGL6y9fco/5j8VgDynEhif2sAT+7E7G0+fxDIH9oLdV8+sAe9fW7aogo
MfMFQ1OEFeFFpgM4r9/WompzFyclI6bF+UB3vVP2GRJeK8FEb5lU3uM70nyG2n9O
jW3GDGZSJJ0AmGfuwa/nBYvKO+CIT/SVENMjqUklaQbEmLVwDODJRCjvrh5PCugQ
/Zpxi2c10ZA/bx+JEdrCALJ0CM0N4NZXAtNulxfddspcxQDDuvUy9O17YSqvSbAX
luvkws4d0JVjjIy9AgLNFFjB+aPEUoeDrqGRaAInk48djW0tUGQ5KXsMpVWk/RY=
=nvLY
-----END PGP SIGNATURE-----

--nextPart3706125.QiT7mOZBRn--
