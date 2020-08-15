Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39863C433E1
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 00:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 077422074D
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 00:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="J7+ZtAP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHOAV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 20:21:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41572 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbgHOAV2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Aug 2020 20:21:28 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BB6F060129;
        Sat, 15 Aug 2020 00:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597450887;
        bh=sFFDm7rm8eugIQkf3a0RSfTYzxFV1gcLRHXdDKCAsSU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=J7+ZtAP/wU2awBvEurqfJSJouKzqSgjLDr4hSKKtLEXqljtKTj6/OWVKfgWfwsnBu
         /i+F6jfl1E0bAN4Esxr0O8m0eXhT856qkdgv/7FuVLqT2V5ehpMtaeQvIi2hL8UEp5
         iwUoVws7n5g/esgUdzxjPK/fdwWrB+Qdwn2k41sHOzSOb/MPmISfpetg5NNTDw1llr
         D3Gv74EqLkHL5Vhwof/6TxqUp4O0CTWwU3jzsS2QIjgAvUMr5GhM6FIElHcIRXkfn0
         f2frZK77tAKjCdF7ehI/X+e7tRQje5ydQCdkkivuAwxPD2uwU+Eu1KoF2YW5Adf44l
         5gQ5sgHILqaYhwz3Km7Rs6D2vZdSbn5RxvudFQIznKZBqivGJ1XOW9lYuWTc8oR2F6
         gzLkiSRZxkJh1CTCJ9Hyq8PseSzw5oQUXD47FuON2QcsgKYo05W5zM6M5hJSbPPh7V
         Pzfv2gpbKNgwmFTaYHMJ8NHrvd/bxnVzjVTvZyigBdAWtvOIGeo
Date:   Sat, 15 Aug 2020 00:21:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] diff: index-line: respect --abbrev in object's
 name
Message-ID: <20200815002120.GQ8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
References: <cover.1596887883.git.congdanhqx@gmail.com>
 <cover.1597364493.git.congdanhqx@gmail.com>
 <760df7782dad9e9df7bb284ec57249e697a4cc92.1597364493.git.congdanhqx@gmail.com>
 <20200814151815.GA29528@szeder.dev>
 <xmqqwo21xiuy.fsf@gitster.c.googlers.com>
 <xmqqy2mhvys6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3wfpuDtTLg8/Vq6g"
Content-Disposition: inline
In-Reply-To: <xmqqy2mhvys6.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3wfpuDtTLg8/Vq6g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-14 at 18:59:53, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Ouch.  These apparently come from
> >
> > process_diffs () {
> > ...
> > }
> >
> > Hash-independence may be good, but it should not munge expected mode
> > bits from 100644 to ffff44, which I think is a bug in the original
> > introduced in 72f936b1 (t4013: make test hash independent,
> > 2020-02-07).
> >
> > When we are adjusting the abbrev length of the index line, of course
> > $_x07 would not be sufficient to match the abbreviated object name
> > in full, so a79 vs 895 can be explained and is a bug in this patch
> > that did not update the process_diffs helper.
> >
> > Another thing that I find somewhat problematic in the original
> > (brian cc'ed) is that it does not special case all-zero object name
> > specially.  By turning any and all instances of $_x40 to $ZERO_OID,
> > we lose the distinction between a random-looking object name which
> > got turned into $ZERO_OID by the processing, and an object name that
> > was $ZERO_OID from the beginning, so we won't catch a possible
> > future bug where new file's preimage object name is not $ZERO_OID
> > (this is plausible when you try to show an intent-to-add entry; the
> > diff between the index and the working tree would be "new file"
> > patch, but the index entry records the object name for an empty
> > blob, e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 instead of $ZERO_OID
> > can easily be emitted by a mistaken implementation).

Yeah, it wasn't intended that we munge mode bits, and I definitely agree
we'd be better off distinguishing between all-zero and non-zero OIDs.

As you might imagine, this is not my favorite test because have a large
amount of diff formats, and even I think the giant list of sed
expressions I wrote is hideous.  It is, however, reasonably
comprehensive, which is pretty much the only nice thing that can be said
about it.

> So here is what I came up with as a possible starting point.  The
> idea is to grab hexadecimal strings at locations the original tried
> to isolate with various contexts, and
>=20
>  - if the input happens to be all zero, use '0', otherwise use 'f'
>=20
>  - if the input is 40-bytes (i.e. unabbreviated object name in the
>    SHA-1 world), repeat the character chosen in the first step as
>    many times as there are chars in $ZERO_OID
>=20
>  - otherwise, repeat the character chosen in the first step as many
>    times as there are chars in the input.
>=20
>  - regardless of all of the above, special case possible in-tree
>    blob modes (100644, 100755 and 120000) and don't munge them.
>=20
> I haven't tried it with the patch that started this discussion
> thread, nor with SHA-256 build, though.

This seems like a sane approach.

> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 43267d6024..b33e60ab9d 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -130,27 +130,43 @@ test_expect_success setup '
>  EOF
> =20
>  process_diffs () {
> -	_x04=3D"[0-9a-f][0-9a-f][0-9a-f][0-9a-f]" &&
> -	_x07=3D"$_x05[0-9a-f][0-9a-f]" &&
> -	sed -e "s/$OID_REGEX/$ZERO_OID/g" \
> -	    -e "s/From $_x40 /From $ZERO_OID /" \
> -	    -e "s/from $_x40)/from $ZERO_OID)/" \
> -	    -e "s/commit $_x40\$/commit $ZERO_OID/" \
> -	    -e "s/commit $_x40 (/commit $ZERO_OID (/" \
> -	    -e "s/$_x40 $_x40 $_x40/$ZERO_OID $ZERO_OID $ZERO_OID/" \
> -	    -e "s/$_x40 $_x40 /$ZERO_OID $ZERO_OID /" \
> -	    -e "s/^$_x40 $_x40$/$ZERO_OID $ZERO_OID/" \
> -	    -e "s/^$_x40 /$ZERO_OID /" \
> -	    -e "s/^$_x40$/$ZERO_OID/" \
> -	    -e "s/$_x07\.\.$_x07/fffffff..fffffff/g" \
> -	    -e "s/$_x07,$_x07\.\.$_x07/fffffff,fffffff..fffffff/g" \
> -	    -e "s/$_x07 $_x07 $_x07/fffffff fffffff fffffff/g" \
> -	    -e "s/$_x07 $_x07 /fffffff fffffff /g" \
> -	    -e "s/Merge: $_x07 $_x07/Merge: fffffff fffffff/g" \
> -	    -e "s/$_x07\.\.\./fffffff.../g" \
> -	    -e "s/ $_x04\.\.\./ ffff.../g" \
> -	    -e "s/ $_x04/ ffff/g" \
> -	    "$1"
> +	perl -e '
> +		my $oid_length =3D length($ARGV[0]);
> +		my $x40 =3D "[0-9a-f]{40}";
> +		my $xab =3D "[0-9a-f]{4,16}";
> +		my $orx =3D "[0-9a-f]" x $oid_length;
> +
> +		sub munge_oid {
> +			my ($oid) =3D @_;
> +			my $x;
> +
> +			if ($oid =3D~ /^(100644|100755|120000)$/) {
> +				return $oid;
> +			}
> +
> +			if ($oid =3D~ /^0*$/) {
> +				$x =3D "0";
> +			} else {
> +				$x =3D "f";
> +			}
> +
> +			if (length($oid) =3D=3D 40) {
> +				return $x x $oid_length;
> +			} else {
> +				return $x x length($oid);
> +			}
> +		}
> +
> +		while (<STDIN>) {
> +			s/($orx)/munge_oid($1)/ge;
> +			s/From ($x40)( |\))/"From " . munge_oid($1) . $2/ge;
> +			s/commit ($x40)($| \()/"commit " . munge_oid($1) . $2/ge;
> +			s/($x40) /munge_oid($1) . " "/ge;
> +			s/^($x40)($| )/munge_oid($1) . $2/e;
> +			s/($xab)(\.\.|,| |\.\.\.|$)/munge_oid($1) . $2/ge;
> +			print;
> +		}
> +	' "$ZERO_OID" <"$1"
>  }

This is much nicer, but I think we need the following on top of it
because we have a couple of tricky cases the original didn't consider:

* Some of our 64-bit object IDs get processed twice, turning them into
  88-character object IDs, which don't match.  We therefore need "\b".
* The new unabbreviated index lines aren't accounted for, so I included
  them by possibly matching "\.\.".
* We have some lines that look like "commit $OID (from $OID)" that
  aren't accounted for.  Because we now have an optional OID in
  munge_oid, I had to account for that as well.

So this is what's on top:

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index b5c7e1a63b..dfc87a0d19 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -140,6 +140,8 @@ process_diffs () {
 			my ($oid) =3D @_;
 			my $x;
=20
+			return "" unless length $oid;
+
 			if ($oid =3D~ /^(100644|100755|120000)$/) {
 				return $oid;
 			}
@@ -160,8 +162,8 @@ process_diffs () {
 		while (<STDIN>) {
 			s/($orx)/munge_oid($1)/ge;
 			s/From ($x40)( |\))/"From " . munge_oid($1) . $2/ge;
-			s/commit ($x40)($| \()/"commit " . munge_oid($1) . $2/ge;
-			s/($x40) /munge_oid($1) . " "/ge;
+			s/commit ($x40)($| \(from )($x40?)/"commit " .  munge_oid($1) . $2 . mu=
nge_oid($3)/ge;
+			s/\b($x40)( |\.\.|$)/munge_oid($1) . $2/ge;
 			s/^($x40)($| )/munge_oid($1) . $2/e;
 			s/($xab)(\.\.|,| |\.\.\.|$)/munge_oid($1) . $2/ge;
 			print;

Or, a fresh original version:

-- %< --
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index e6eb4dd4c7..dfc87a0d19 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -130,27 +130,45 @@ test_expect_success setup '
 EOF
=20
 process_diffs () {
-	_x04=3D"[0-9a-f][0-9a-f][0-9a-f][0-9a-f]" &&
-	_x07=3D"$_x05[0-9a-f][0-9a-f]" &&
-	sed -e "s/$OID_REGEX/$ZERO_OID/g" \
-	    -e "s/From $_x40 /From $ZERO_OID /" \
-	    -e "s/from $_x40)/from $ZERO_OID)/" \
-	    -e "s/commit $_x40\$/commit $ZERO_OID/" \
-	    -e "s/commit $_x40 (/commit $ZERO_OID (/" \
-	    -e "s/$_x40 $_x40 $_x40/$ZERO_OID $ZERO_OID $ZERO_OID/" \
-	    -e "s/$_x40 $_x40 /$ZERO_OID $ZERO_OID /" \
-	    -e "s/^$_x40 $_x40$/$ZERO_OID $ZERO_OID/" \
-	    -e "s/^$_x40 /$ZERO_OID /" \
-	    -e "s/^$_x40$/$ZERO_OID/" \
-	    -e "s/$_x07\.\.$_x07/fffffff..fffffff/g" \
-	    -e "s/$_x07,$_x07\.\.$_x07/fffffff,fffffff..fffffff/g" \
-	    -e "s/$_x07 $_x07 $_x07/fffffff fffffff fffffff/g" \
-	    -e "s/$_x07 $_x07 /fffffff fffffff /g" \
-	    -e "s/Merge: $_x07 $_x07/Merge: fffffff fffffff/g" \
-	    -e "s/$_x07\.\.\./fffffff.../g" \
-	    -e "s/ $_x04\.\.\./ ffff.../g" \
-	    -e "s/ $_x04/ ffff/g" \
-	    "$1"
+	perl -e '
+		my $oid_length =3D length($ARGV[0]);
+		my $x40 =3D "[0-9a-f]{40}";
+		my $xab =3D "[0-9a-f]{4,16}";
+		my $orx =3D "[0-9a-f]" x $oid_length;
+
+		sub munge_oid {
+			my ($oid) =3D @_;
+			my $x;
+
+			return "" unless length $oid;
+
+			if ($oid =3D~ /^(100644|100755|120000)$/) {
+				return $oid;
+			}
+
+			if ($oid =3D~ /^0*$/) {
+				$x =3D "0";
+			} else {
+				$x =3D "f";
+			}
+
+			if (length($oid) =3D=3D 40) {
+				return $x x $oid_length;
+			} else {
+				return $x x length($oid);
+			}
+		}
+
+		while (<STDIN>) {
+			s/($orx)/munge_oid($1)/ge;
+			s/From ($x40)( |\))/"From " . munge_oid($1) . $2/ge;
+			s/commit ($x40)($| \(from )($x40?)/"commit " .  munge_oid($1) . $2 . mu=
nge_oid($3)/ge;
+			s/\b($x40)( |\.\.|$)/munge_oid($1) . $2/ge;
+			s/^($x40)($| )/munge_oid($1) . $2/e;
+			s/($xab)(\.\.|,| |\.\.\.|$)/munge_oid($1) . $2/ge;
+			print;
+		}
+	' "$ZERO_OID" <"$1"
 }
=20
 V=3D$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
-- %< --

Anyone is welcome to have my sign-off if they pick up any part of this
patch.
--=20
brian m. carlson: Houston, Texas, US

--3wfpuDtTLg8/Vq6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXzcqgAAKCRB8DEliiIei
gSo+AP0c24UkYArTpqTEQbeke04sVJ+kzl7OQJbSXU5vsTmP0QEAyQL5m8VAn2WB
Fl/FootTW9+SJoIbWPZKXp3S7lGBIwc=
=fhSq
-----END PGP SIGNATURE-----

--3wfpuDtTLg8/Vq6g--
