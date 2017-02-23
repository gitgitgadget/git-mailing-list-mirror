Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA2D2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 18:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbdBWSKr (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 13:10:47 -0500
Received: from kitenet.net ([66.228.36.95]:39556 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751224AbdBWSK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 13:10:28 -0500
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1487873424; bh=BBJzA6T/c8ceitTX6mBMupjMxXFprI76stJBFMPg4P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F4gFjMCKPwWUOlY1zyeGmBWHenCSC2LFZnk7hU4EHjIVOuh7lRpHTDtg7xMpmUw2H
         Gu5YwNc+TSXhyYUmRDNDtCXYKTNefwE/cLlubWyDQ2aojPrjNRXBTzwngoi4LvMKyw
         TlSXal+1mU/cudWWzPVE44b5e0RpmXBkA5ZUxt2Y=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1487873418; bh=BBJzA6T/c8ceitTX6mBMupjMxXFprI76stJBFMPg4P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bwjhgiS4G43/h6V1JnmJdvH+0fDZLV+GkjWfz69wH/rJFD0t5HAW/fHjBjLKtN0RK
         aBOj5meDaiJNTscc83HGfht72IZ/tuhJYSxJzGlc0/Bpuovxd1giZgqhn+YDXv03H3
         ev3S8jD+h2Ur4kSKK1Gw5JsBl2+T5G5/UtkrDnXQ=
Date:   Thu, 23 Feb 2017 14:10:18 -0400
From:   Joey Hess <id@joeyh.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170223181018.ns4vyosgzmuoyiva@kitenet.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <CA+55aFxJGDpJXqpcoPnwvzcn_fB-zaggj=w7P2At-TOt4buOqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2hqzzl4z3tzahsqv"
Content-Disposition: inline
In-Reply-To: <CA+55aFxJGDpJXqpcoPnwvzcn_fB-zaggj=w7P2At-TOt4buOqw@mail.gmail.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2hqzzl4z3tzahsqv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> I haven't seen the attack yet, but git doesn't actually just hash the
> data, it does prepend a type/length field to it. That usually tends to
> make collision attacks much harder, because you either have to make
> the resulting size the same too, or you have to be able to also edit
> the size field in the header.

I have some sha1 collisions (and other fun along these lines) in=20
https://github.com/joeyh/supercollider

That includes two files with the same SHA and size, which do get
different blobs thanks to the way git prepends the header to the
content.

joey@darkstar:~/tmp/supercollider>sha1sum  bad.pdf good.pdf=20
d00bbe65d80f6d53d5c15da7c6b4f0a655c5a86a  bad.pdf
d00bbe65d80f6d53d5c15da7c6b4f0a655c5a86a  good.pdf
joey@darkstar:~/tmp/supercollider>git ls-tree HEAD
100644 blob ca44e9913faf08d625346205e228e2265dd12b65	bad.pdf
100644 blob 5f90b67523865ad5b1391cb4a1c010d541c816c1	good.pdf

While appending identical data to these colliding files does generate
other collisions, prepending data does not.

It would cost 6500 CPU years + 100 GPU years to generate valid colliding
git objects using the methods of the paper's authors. That might be cost
effective if it helped get a backdoor into eg, the kernel.

>  (b) we can probably easily add some extra sanity checks to the opaque
> data we do have, to make it much harder to do the hiding of random
> data that these attacks pretty much always depend on.

For example, git fsck does warn about a commit message with opaque
data hidden after a NUL. But, git show/merge/pull give no indication
that something funky is going on when working with such commits.

--=20
see shy jo

--2hqzzl4z3tzahsqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6FpfY7MdJMHr8NgcyRDZIiUS48cFAlivJYoACgkQyRDZIiUS
48ejOg//YbPNeKikwVYfHkChjjCMksDKcQgfgzD+GesXI+Ejtap/SMB3Nrl9c0nP
g2iehkZemwsa1UAhWP2p8cyskhc9DzPLbmMsLbKc8XzqvbeyG4WKaukDLIul2KGS
+fPAGU81y0oGn31DvxmExkyfYkUYZQo99B2bbfeKnMoxGvJUnv9dvSI6Ul9FRaaq
jMZtDELmpJJcBFhOkL1jASzUIGYfH4jzu1sjRss2YArsotTW0IpK5bS5tS9ZtnZM
O8jh57eYgF1TFZruCfasPUvYE0S2kDNfe8k/nKt62Qat+LtcJ1t6EFaNh+HjFJRt
wXBt6UJ6KPhzVnWoEkKdQuuUeOuEAbfxkbjAOCSSaJ3pUXA7R1j8e4ixl3dGeAO1
F7U1NATh6PU/J2L8+rRDl9ZdXnPK+Ru4J7yyrYbQPv96mLbZqS51JFS6vSTkXNzL
Yfp7LqWrg21doMpP02m3Cs+vnJlVptXgWqqa2rXYIlWG2KrvB/mnjypfXkffjGo6
Cb+KhI2nnv7pAS5wHhZbMXeBS2W/i44ToOCNoNVfyU/JtDR2uYV7MQuW4eMCWcp0
qH5Z9EDQkMbAAMdySQggs5BRE/ehD350pLP78+825b7u5AsWCkdk3uPiAOIqAslm
4AMYOcVO56duC0oeoOQKaJONqXCxLcz+t3GP4Gv99zOmtX7BPRY=
=Y5k3
-----END PGP SIGNATURE-----

--2hqzzl4z3tzahsqv--
