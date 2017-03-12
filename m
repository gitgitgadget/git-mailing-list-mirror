Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 287AE202C1
	for <e@80x24.org>; Sun, 12 Mar 2017 16:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934241AbdCLQv2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 12:51:28 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:44556 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933837AbdCLQv0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Mar 2017 12:51:26 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 47C15280AD;
        Sun, 12 Mar 2017 16:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489337484;
        bh=H9Sq8kVQfhXeqlgs3Iki+t7lWGDpGyPUdXyrhz9IwZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zbxh2kGM2vieke+gVlMhFRTLytLYA2j2pwH+z1sZndmINCj8PWSiqBdOvs9QZz/TD
         xf9HjLa7djtMOKP+8oOw3Bdqn7ZsKW2CZtg1wa8bBHoOuory03RXmKdnbkwQ8fs6E5
         VKsKJmz7xiLp1KYQEqzanLxiYEQJW4Fjyn8OFXsDsG7ruvO80Etk3Mf4peor/Al38e
         t6iVPRTkHHXtyUH55dY1c+GqG25o7kP9APyHtI3RNv29ppHm1CDLbFyS6QqkBAvucT
         EHd3YTAk2Q8uwc2qopT5c5JJNbv8EHAwLBQPoiCkVQE5GS02jDcbPTlbDwMDakvX8g
         i1oTDeabjGZDHNO51MMmyS7D+szOfpe1hyVJSmCP+cgaOA85PBzahAspt8wBBbvnOf
         ysMA8al1sZ5ciCeWQfYrCGpiKTYXaoB5S4BshRIs8sbKpaKj61ryQxvpzhyvVW4Uig
         nqavVa5h7+2599bYOWdpHrZsdKJgQE9EnsC5o9JAsJ+ZPE/LQhz
Date:   Sun, 12 Mar 2017 16:51:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] Move SHA-1 implementation selection into a header
 file
Message-ID: <20170312165119.3eokqse4uxdet6yd@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20170311222818.518541-1-sandals@crustytoothpaste.net>
 <20170312130149.czir5hcbosqlmkhb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jsvwfqplgdlxcumn"
Content-Disposition: inline
In-Reply-To: <20170312130149.czir5hcbosqlmkhb@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jsvwfqplgdlxcumn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 12, 2017 at 09:01:49AM -0400, Jeff King wrote:
> On Sat, Mar 11, 2017 at 10:28:18PM +0000, brian m. carlson wrote:
>=20
> > Many developers use functionality in their editors that allows for quick
> > syntax checks, including warning about questionable constructs.  This
> > functionality allows rapid development with fewer errors.  However, such
> > functionality generally does not allow the specification of
> > project-specific defines or command-line options.
> >=20
> > Since the SHA1_HEADER include is not defined in such a case, developers
> > see spurious errors when using these tools.  Furthermore, while using a
> > macro as the argument to #include is permitted by C11, it isn't
> > permitted by C89 and C99, and there are known implementations which
> > reject it.
> >=20
> > Instead of using SHA1_HEADER, create a hash.h header and use #if
> > and #elif to select the desired header.  Have the Makefile pass an
> > appropriate option to help the header select the right implementation to
> > use.
>=20
> This has bit me once or twice in the past[1], too, so I'm happy to see
> somebody tackling it.
>=20
> Your solution does mean that your tool, whatever it is, that runs
> without the same CFLAGS as the Makefile may get a _different_ sha1
> implementation, though. That's probably good enough for some purposes
> but perhaps not for others.

Yeah, my goal was basically to pass -fsyntax-only, not to produce useful
object files.  My patch does basically require that the user have
OpenSSL installed, but I do, so it doesn't matter.

I considered after the fact that I might just do something like:

  #ifdef SHA1_HEADER
  #include SHA1_HEADER
  #else
  #include "block-sha1/sha1.h"
  #endif

That would be the smallest change, but probably not the best.

> The "most correct" solution, I think, would be to stop using "-D" flags
> in favor of actually generating hash.h. Something like the patch
> below[2] (though I think it there are some rough edges with the
> dependencies).

I agree that's a better solution.  I was concerned about avoiding ending
up rebuilding everything when we regenerated the file, but it looks like
you've avoided that with cmp.

> Of course the sha1 header is just one of many such defines. It's the one
> that is most visible because the result is syntactically valid without
> it, but anything you compile without the Makefile's CFLAGS may be subtly
> different than what the Makefile would produce. So arguably the Makefile
> should be writing out a build-options.h with all of the values, and that
> should get pulled in by git-compat-util.h.
>=20
> I don't know if we want to go down that rabbit hole or not. I offer it
> merely as an alternative. I'm OK with your patch as-is if you don't want
> to dump any more time into it.

I'll take this patch for now and fix it up with the comment I mentioned
below.  If someone wants to improve the situation down the line, then
they can pick that up.

I assume I can apply your sign-off to the resulting patch?

> -Peff
>=20
> [1] I think I hit the problem when trying to debug some internal part of
>     git and writing a one-off "foo.c" that calls the code I want. You
>     can't compile it with "gcc foo.c".
>=20
> [2] Here's what a patch for the generated-header might look like:
>=20
> diff --git a/Makefile b/Makefile
> index 9f0eae428..0d65d50e9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -690,6 +690,7 @@ XDIFF_LIB =3D xdiff/lib.a
>  VCSSVN_LIB =3D vcs-svn/lib.a
> =20
>  GENERATED_H +=3D common-cmds.h
> +GENERATED_H +=3D hash.h
> =20
>  LIB_H =3D $(shell $(FIND) . \
>  	-name .git -prune -o \
> @@ -1639,8 +1640,7 @@ PERLLIB_EXTRA_SQ =3D $(subst ','\'',$(PERLLIB_EXTRA=
))
>  # from the dependency list, that would make each entry appear twice.
>  LIBS =3D $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
> =20
> -BASIC_CFLAGS +=3D -DSHA1_HEADER=3D'$(SHA1_HEADER_SQ)' \
> -	$(COMPAT_CFLAGS)
> +BASIC_CFLAGS +=3D $(COMPAT_CFLAGS)
>  LIB_OBJS +=3D $(COMPAT_OBJS)
> =20
>  # Quote for C
> @@ -1781,7 +1781,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
>  		$(filter %.o,$^) $(LIBS)
> =20
> -help.sp help.s help.o: common-cmds.h
> +help.sp help.s help.o: common-cmds.h hash.h
> =20
>  builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h GIT-PREFIX
>  builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS =3D \
> @@ -1805,6 +1805,10 @@ common-cmds.h: generate-cmdlist.sh command-list.txt
>  common-cmds.h: $(wildcard Documentation/git-*.txt)
>  	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+ &=
& mv $@+ $@
> =20
> +hash.h:
> +	$(QUIET_GEN)echo '#include $(SHA1_HEADER)' >$@+ && \
> +	{ cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; }

I think here we'd want to also "rm -f $@+", so that we don't leave an
extra file behind if we're up-to-date (which is the common case), much
like we do for GIT-BUILD-OPTIONS.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--jsvwfqplgdlxcumn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljFfIcACgkQv1NdgR9S
9otuQw/7BIBhRXNRUs0GR5z37BuBkLhax8nwJoePOF+u6mYGaPebGoir2BiFWl7j
pp1csFg1T+eNOB/F98HD+JWarNbNBpfy+kuEEebIArQkrgXdVHgzSVBLrD8AcsS1
F2mtKhevQ+kpvb0Rct0XId5Ib83WrendcgTl5E6s7F/L+IcCxUcUI5jPoikbeXJw
eqWC+wDCx86gQEQHYOtWwKeEY4K/JyxCpY387B46f5tJYqP5sf8/FL/zRNRoQQHR
2OT96e9Q0xd4iUDNOc1TpCj6nkK/TdaQ5i9l5rxnj3vs8ZmYMHVx5IVdEwPd0Uqj
ilPRut2L5to0EXYJR+iAsvT86N8S5OQ1rAoeIZhmdq9ICiqQqKsfs1umfFqZlo3p
Dkit2wFvlFT7g68HiNucMRMfgQEHNS75hk9FzmGGrHrBSS7x4FQ/Y1pA8Cc6Z4rz
tjO+rO4GKX/LrGJ0WfG/j4E20Nw4UntDs4UMaGSzYfm1gUnC8MHd+Jd2EbiiD0s0
/ncbYzN9/z3SdeA/YT31U6px4NkmYwgWMp/ZfHOCPIyqSpK8GLQ/spIQtCtRVJSB
pEUfhJSRehGH1I5S53dC1bceaWS7GS7QlFnSlWZ7lrT2sVRlfaMGqJWXOJArupUc
X7w0/rLeHlEnfKslHF+2+pIUlrtSB0FSgGEPmYJy0ckXUMrT4jU=
=nuYn
-----END PGP SIGNATURE-----

--jsvwfqplgdlxcumn--
