Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E64912018A
	for <e@80x24.org>; Fri, 24 Jun 2016 15:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbcFXP16 (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 11:27:58 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41148 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750999AbcFXP15 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2016 11:27:57 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [107.18.82.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EDD5C2809F;
	Fri, 24 Jun 2016 15:27:48 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466782069;
	bh=EidjLzN+Ootr0GubhERz83n7qeGjAdvViedcK42xh4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hD/DfCNkFcN5qrfPx5bGFy2MzcCWUESbBX4PZsdke92/8Fhc40llgve/5gik0N/ZR
	 OAReimpT+O5GwFBDgwHmjUCpL750fVm0cZmAm2Q91KD4Tsp5e78RvRgDgk8uLVBnhP
	 RpOIuT+PH/buMFPiRfyL/fHaHA9g2p7+rYXCTQfDMgDSD75bdILqgLgwPHkt4pOuzC
	 bQjojiEekaG6c+9jj5oM0V2CZ4tIhId9GxS38osy6fmLwP3aABoQE4sOF2bcxv8tWy
	 FW1a+ZUgTVsiiwKmpe3D9NithIXv7dmStMhNrt/bm8MELflsp9SRwl28oOqAqQXZr4
	 WiA0rX9XcB6Nl4QMXJC9tK4W5e+bEYv+oE0Q/xz2HtOz9B6IPylGJf2BVn8txfvxJz
	 7aEQUNxLthSUX7H5qGlTCXk0WvEuCN0EtCcQ5U3v8hgKS3eJwI1zn/TVQGquJCzdKz
	 vLkvE8BxBh6h3TZJIpKwlJ7LqyZHjm9k5OXIxKlLab5ExSgen5l
Date:	Fri, 24 Jun 2016 15:27:42 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/8] Convert struct diff_filespec to struct object_id
Message-ID: <20160624152742.GA10808@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
References: <20160618221407.1046188-1-sandals@crustytoothpaste.net>
 <20160618221407.1046188-4-sandals@crustytoothpaste.net>
 <xmqqmvmenpwz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <xmqqmvmenpwz.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.5.0-2-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 21, 2016 at 03:22:04PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> I was trying to make sure there is no misconversion, but some lines
> that got wrapped were distracting.  For example:
>=20
> > @@ -2721,7 +2722,8 @@ static int diff_populate_gitlink(struct diff_file=
spec *s, int size_only)
> >  	if (s->dirty_submodule)
> >  		dirty =3D "-dirty";
> > =20
> > -	strbuf_addf(&buf, "Subproject commit %s%s\n", sha1_to_hex(s->sha1), d=
irty);
> > +	strbuf_addf(&buf, "Subproject commit %s%s\n",
> > +		    oid_to_hex(&s->oid), dirty);
>=20
> This would have been
>=20
> > -	strbuf_addf(&buf, "Subproject commit %s%s\n", sha1_to_hex(s->sha1), d=
irty);
> > +	strbuf_addf(&buf, "Subproject commit %s%s\n", oid_to_hex(&s->oid), di=
rty);
>=20
> which the conversion made the line _shorter_.  If the original's
> line length was acceptable, there is no reason to wrap the result.

I do tend to agree.  Coccinelle wrapped the line automatically, but I'm
not sure why it did that.  I can see if there's an option that disables
that if you'd like.  I'm a bit reticent to manually fix up the line
wrapping as I want others to be able to run Coccinelle themselves and
get identical output.

> > @@ -2937,7 +2940,7 @@ static struct diff_tempfile *prepare_temp_file(co=
nst char *name,
> >  			if (!one->sha1_valid)
> >  				sha1_to_hex_r(temp->hex, null_sha1);
> >  			else
> > -				sha1_to_hex_r(temp->hex, one->sha1);
> > +				sha1_to_hex_r(temp->hex, one->oid.hash);
>=20
> This suggests that oid_to_hex_r() is needed, perhaps?

Probably so.  I can add that in a reroll.

> > @@ -2952,7 +2955,7 @@ static struct diff_tempfile *prepare_temp_file(co=
nst char *name,
> >  		if (diff_populate_filespec(one, 0))
> >  			die("cannot read data blob for %s", one->path);
> >  		prep_temp_blob(name, temp, one->data, one->size,
> > -			       one->sha1, one->mode);
> > +			       one->oid.hash, one->mode);
>=20
> prep_temp_blob() is a file-scope static with only two callers.  It
> probably would not take too much effort to make it take &one->oid
> instead?

I can certainly do that in a reroll.

> > @@ -3075,8 +3078,8 @@ static void fill_metainfo(struct strbuf *msg,
> >  				abbrev =3D 40;
> >  		}
> >  		strbuf_addf(msg, "%s%sindex %s..", line_prefix, set,
> > -			    find_unique_abbrev(one->sha1, abbrev));
> > -		strbuf_addstr(msg, find_unique_abbrev(two->sha1, abbrev));
> > +			    find_unique_abbrev(one->oid.hash, abbrev));
> > +		strbuf_addstr(msg, find_unique_abbrev(two->oid.hash, abbrev));
>=20
> Good.  As more and more callers of find_unique_abbrev() is converted
> to pass oid.hash to it, eventually we will have only a handful of
> callers that have a raw "const unsigned char sha1[20]" to pass it,
> and we can eventually make the function take &oid.  It seems we are
> not quite there yet, by the looks of 'git grep find_unique_abbrev'
> output, but we are getting closer.

Yes, I'd noticed that as well.  One thing I observed from these
conversions is that it sometimes takes a huge amount of work to get all
the callers to change.  Often, it's only one or two call sites that end
up being a bunch of work.

> > @@ -3134,17 +3137,17 @@ static void diff_fill_sha1_info(struct diff_fil=
espec *one)
> >  		if (!one->sha1_valid) {
> >  			struct stat st;
> >  			if (one->is_stdin) {
> > -				hashcpy(one->sha1, null_sha1);
> > +				hashcpy(one->oid.hash, null_sha1);
> >  				return;
> >  			}
>=20
> oidclr()?
>=20
> Perhaps a preparatory step of
>=20
> 	unsigned char *E1;
>=20
> 	-hashcpy(E1, null_sha1);
>         +hashclr(E1)
>=20
> would help?

Sure.  I can do that.

> > @@ -902,13 +904,13 @@ static struct merge_file_info merge_file_1(struct=
 merge_options *o,
> >  		result.clean =3D 0;
> >  		if (S_ISREG(a->mode)) {
> >  			result.mode =3D a->mode;
> > -			hashcpy(result.sha, a->sha1);
> > +			hashcpy(result.sha, a->oid.hash);
> >  		} else {
> >  			result.mode =3D b->mode;
> > -			hashcpy(result.sha, b->sha1);
> > +			hashcpy(result.sha, b->oid.hash);
>=20
> merge_file_info is a file-scope-static type, and it shouldn't take
> too much effort to replace its sha1 with an oid, I would think.

That's one of the following patches.

> sha_eq() knows that either of its two parameters could be NULL, but
> a->sha1 is diff_filespec.sha1 which cannot be NULL.
>=20
> So !sha_eq() here can become oidcmp().  There are some calls to
> sha_eq() that could pass NULL (e.g. a_sha could be NULL in
> blob_unchanged()), but many other sha_eq() can become !oidcmp().
>=20
> Am I reading the conversion correctly?

I think that's accurate.  I'll make that change.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXbVFuAAoJEL9TXYEfUvaL8zkQAIWm474BnK6KKSiD3FYz2rDO
189rzE1VzcThqo28VbHW8L2UxVbJnHYbz8EMhDEbPflUutI9I2IKDTFDMaCtxcyy
Yvoqpwekf4MAeYPqNNgoVG6MNkTsHLBDNTOIFxjRzkjpg/zmOdzDgPhuqbTtK6Rb
BZNM21MeV/UFXWsY9BqPlaG3+MMay5oCU2PP04Vo+hg/HK7NA1cEapMZ1ZeqrC69
+BEtWvFXmu/PO+OUAQb7xNzuAXX4pfjSdQ3P7KSorqZujzhc28ClGD7BrOWznO+N
LNqmciIzAWv4vbfwdaYpg85uPQd2LsIQN5Vu08KrwVW8UE/1EBX8jwpL+wyiSqhi
9hO0BKzfzqcyCVOpwyOjCzeuK3PXrWEtR7uyxHaF4YNjLmLcbxEBm8DkDuDO87RP
5KUEmB8WacOQAVjjAA1QsCawOEVFFOucfyAkStS84VV2/bVzw5FV8atN4scmc3rb
QEOG09qx0cxvvnQiSkzHteIsR5NJ7yT54/PcymHWTFphgHNjFtwpXzKblLy1dxRv
e3Kch6QSVxE3h/QZRxKGz9VtYtNkUaWZ6SkTn3QJQGDuLmTRE7EH3/EeExd61jej
1OpNZ/P7Wn8vYsd0HCfCG7GwZe5Q5BZPP/ZkpDVUVxbl2WQVvGpkNJsI5CUU2l4z
5uPmaOZxcZD/NW83B+L3
=mqJW
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
