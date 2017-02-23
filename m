Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C2BB2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 17:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750828AbdBWRhG (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 12:37:06 -0500
Received: from kitenet.net ([66.228.36.95]:37228 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751169AbdBWRhE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 12:37:04 -0500
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1487871407; bh=ic5XPi/6+ingyJh9AHM2CmPnKTKWit/d4G0jXpEnOmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hTqyVshSYtL4HZH0NKm1YscN8Lrhukc6oZd1HHi4sRW6jC7/f1LxWCBz0zqHmPkcs
         l6mcTqWM2G9kN8Yt0OuQ8kuT5wExbuzAntwNgMrB7hOMXPry2OvA9g2DLUbR5rKE6I
         Bhc3p63Fe63LhPgAod1x5ggTvxxMI05U6cQ8Y8PA=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1487871347; bh=ic5XPi/6+ingyJh9AHM2CmPnKTKWit/d4G0jXpEnOmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SASSfG9BmyaAQuNnc+k1Rd7s4dE1BJhtsnXNOV5OTA6bibELOJZvffG7b5bQLzSOL
         e0CvviL9beEwQGBIJWDW6AT/MhjH8jzweZpDaZl1Xakj1EJL2FwgVDruZxnWcEI20W
         7ThaBTSWFN5mlsY7J/UgWQJP2AEFVsBL8v4xV664=
Date:   Thu, 23 Feb 2017 13:35:47 -0400
From:   Joey Hess <id@joeyh.name>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170223173547.qljypk7sdqi37oha@kitenet.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ycj5mvo4eznpkhsi"
Content-Disposition: inline
In-Reply-To: <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ycj5mvo4eznpkhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> On Thu, Feb 23, 2017 at 8:43 AM, Joey Hess <id@joeyh.name> wrote:
> >
> > Since we now have collisions in valid PDF files, collisions in valid git
> > commit and tree objects are probably able to be constructed.
>=20
> That may be true, but
> https://public-inbox.org/git/Pine.LNX.4.58.0504291221250.18901@ppc970.osd=
l.org/

That's about someone replacing an valid object in Linus's repository
with an invalid random blob they found that collides. This SHA1
break doesn't allow generating such a blob anyway. Linus is right,
that's an impractical attack.

Attacks using this SHA1 break will look something more like:

* I push a "bad" object to a repo on github I set up under a
  pseudonym.
* I publish a "good" object in a commit and convince the maintainer to
  merge it.
* I wait for the maintainer to push to github.
* I wait for github to deduplicate and hope they'll replace the good
  object with the bad one I pre-uploaded, thus silently changing the
  content of the good commit the maintainer reviewed and pushed.
* The bad object is pulled from github and deployed.
* The maintainer still has the good object. They may not notice the bad
  object is out there for a long time.

Of course, it doesn't need to involve Github, and doesn't need to
rely on internal details of their deduplication[1];=20
that only let me publish the bad object under a psydonym.

--=20
see shy jo

[1] Which I'm only guessing about, but now that we have colliding
    objects, we can upload them to different repos and see if such
    dedupication happens.

--ycj5mvo4eznpkhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6FpfY7MdJMHr8NgcyRDZIiUS48cFAlivHXEACgkQyRDZIiUS
48dYIw//ariVxwkyBr5LHucunYQS1hCturaUDJ9BO0Ow5eISFDOEsWnMzaP/La6n
f91TxsmddrUWKT8+/HJsNITWYyhzt07TLjJvvRpJH35IYOVZe6915FUf9mvTulWN
eWoApm5/kXi7DzFJZ+5zdlIlYhfxtWl36OQ732Tk0zS9F23I7m8FAB1vtCK6ixe7
u+5enYkWVQcK/E+mDZFAg/DNntjGdduFQki6iK3TUXz2aZg/EHH0Ze1WoN4FS0xE
PH3Y7zuHrZEt/OiApyWE2P5IUeXMgPbCAKRyCt/qkLbr+lIFiGoOez3f0wh9UBHW
CSAi1w0YPLCbpvfvrjiwbxpuLRcZdg2CNHfnXba2qagj9jZeNVZcefylvJKHiyQK
gWnPb0T3egv+bxrkR7oy9L6EVbQTYxLgEs0jjbrgc3NPcCxSPHaun0L42aHUHndJ
yZuCPm8xudhoGLBG0VyyUonYXirNZybQoNHvFE1ScdyTa2ZF0Pl3FIJuOTua/RfB
dZhyGuMZc4C/1eQ0nYf/Pli8hZXcI0oV/XEAakljdoGYcHJHglLmqdhuJw6NAq2T
QAGiNa2Lcyv4le6j/598m2IcnaR1UPep5FfUuTUIgL4deTMN7ivQnnXTm7kdhX+a
ghBXhIsK2u1xiBgNe0G42YLHnu1p918XLvAvwcznb7OHIP/sNaA=
=o5lN
-----END PGP SIGNATURE-----

--ycj5mvo4eznpkhsi--
