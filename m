Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4781A1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 18:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756186AbeASSp3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 13:45:29 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:47412 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756130AbeASSpX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 13:45:23 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 0F6DD335C39
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 18:45:22 +0000 (UTC)
Received: (qmail 12170 invoked by uid 10000); 19 Jan 2018 18:45:20 -0000
Date:   Fri, 19 Jan 2018 18:45:20 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: should any build system legitimately change any tracked files?
Message-ID: <robbat2-20180119T183103-843967451Z@orbis-terrarum.net>
References: <alpine.LFD.2.21.1801191247250.10222@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1801191247250.10222@localhost.localdomain>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 12:51:52PM -0500, Robert P. J. Day wrote:
>=20
>   just finished teaching a couple git courses and, after class, a
> student came up and described a rather weird problem -- in short:
>=20
>   1) before build, "git diff" shows nothing
>   2) do the standard build
>   3) suddenly, "git diff" shows some changes
>=20
> that's all the info i was given, but it *seems* clear that the build
> process itself was making changes to one or more tracked files.
>=20
>   technically, i guess one can design a build system to do pretty
> much anything, but is it fair to say that this is a really poor design
> decision? admittedly, this isn't specifically a git question, but i'm
> open to opinions on something that strikes me as a bad idea.
I have seen what you describe, but it had a good cause:
1. The source repo contained some intermediate generated source,=20
   eg foo.x -> foo.c -> foo.o
2. The output of the tool that did foo.a -> foo.c differed due to some
   factor on the system (different version, different config in /etc etc).
3. The initial checkout caused the mtime of foo.c to be just older
   newer than foo.x, so the build system decided to regen foo.c.
4. (optional) The makefile had conditional rules to skip the regen if the t=
ool was
   not present.

Until the tool output changed, even if the file was regenerated, it was
identical, so it didn't show up in diff.

What are the possible mistakes here?
- The intermediate source possibly should not be committed [depending on
  the tool, this isn't always an option]
- The build system scripts (makefile etc) contains a mistake.
- Some final (non-intermediate/non-source) file was committed.

I've seen similar patterns for GNU Bison, autoconf, and lots of other
tools.=20

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAEBCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlpiPL9fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsT97xAAnclq8adcr061qOyqaGgg0nm8sw251XsGScNBzWZR9NpWmpKH7GvfS+un
xDdJ7DLkdbk0FPzwaE3qY2nI4CyimbzCCNYl26fRW0BjaNkI1jJltbFLTQ5fZjuC
bnmBD6VOvKJzs5W35ulVUQ1GVleL4Ea6Z998l5drezz3RKNl9+Q/iO0Z5Ej2dpKz
bhpXFeAjiDYdBPTjimYcv7IYjIJkXY/ASqkPE1k+T5JsrI7SP95hnHS+cOj21b9P
/n8wJTD3tOCkTi7L3frKQXA8G9BInPXBlY5LH+Wxdljpqu+924Kmn6gmqUo52RMu
YyB5WMNPlnwjTmUm3ZMvcN/VwHZ3D/l1R/DsNzhXk9qPdx2AvVMLklx0rLe5yURM
pDAUoPiSJ3dMrrGlYPsMU80OjBRm8q9j+ppE+dcm8Ph7uxVff8vxAA0aA/pIBKbz
h4mjsJh7whc3yZvVplR8C7dLhx8gj9uFpRAm13yedNqt8LjwxENhUnSOdOy7XEa6
Kai+vaRVbWK5CF9Y5wXke1jls5oWrx/YjRDDUu3Ci2r3G31gTF4LxJoF61RlaZH1
A22O0b8tjsBYaKaL8OfbS5kEj/MpY/k2GOMHrniTNfK603xYJjRm16KtTUAn/rDv
LP3HTHv1Aj5n6895TwmwWkjqnuqVholBpalvKqxZWaLBgHieeds=
=YxqD
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
