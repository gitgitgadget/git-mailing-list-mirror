Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3321F20958
	for <e@80x24.org>; Mon, 20 Mar 2017 23:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753273AbdCTXTc (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 19:19:32 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46714 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753235AbdCTXTb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 19:19:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 668C7280AD;
        Mon, 20 Mar 2017 23:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490051878;
        bh=tZanzGNudLWDftL7lvfSqcGGTM1dJxcgYUx9kKZ0b9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kCvBqWEN4g7+ROIkAu/cdTg0lXH/ZcfcNMzMM3dj4hobGEnqrWpzlWYsCv08IU//8
         VqxIAI2YGXpaNfpPkjd0wYkPXYOyHi4h45bqiqSEO4IRxP4ZJOx2FnToG+1VDpBwIi
         tRrcNf0ZTDSVY6KsHUWZGvny9zsrmLM27s/aaevzVKySzkTyFtumPekcYgfr3jsiqH
         2h950mR2fxtF+FWAmyMr0aRQsj43iKHwUaGWG/T/HsuTvNQ5rqzLjeKU/A+G0ppWnC
         S1em6PukMTH8OS4SuT8YCYYaGCtzsBwevTiqqlv5z0bbQeaNnV4Qpv9RlVool5vmXB
         6pmgR2HuFp1szzgtZu8XE+r0LsKgCkmiD9ZPkJkp0aFaLDCnaSpp7PA0FVsbRaL3zx
         kMvK/8+iXfdHFpnfmP241FSX4Y7LQ+d5VesfBpXukHSrF/Y0bQ6xeR8sI2N6uiLS9v
         DyKwIUfyQXNz7N7qA4s47mNkPmYtrH57MIdzufwITu0/5qovn9E
Date:   Mon, 20 Mar 2017 23:17:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/20] builtin/receive-pack: convert portions to struct
 object_id
Message-ID: <20170320231752.gzo2uk6d2qob5ovk@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
 <20170318211954.564030-7-sandals@crustytoothpaste.net>
 <CACsJy8Ch0=ovmmfHikQG04K249TEpA3HONWpknUn_kWbQa=8Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xx7bp2mx5u4q4fo4"
Content-Disposition: inline
In-Reply-To: <CACsJy8Ch0=ovmmfHikQG04K249TEpA3HONWpknUn_kWbQa=8Fw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xx7bp2mx5u4q4fo4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 07:56:17PM +0700, Duy Nguyen wrote:
> On Sun, Mar 19, 2017 at 4:19 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > @@ -1489,23 +1489,24 @@ static struct command **queue_command(struct co=
mmand **tail,
> >                                       const char *line,
> >                                       int linelen)
> >  {
> > -       unsigned char old_sha1[20], new_sha1[20];
> > +       struct object_id old_oid, new_oid;
> >         struct command *cmd;
> >         const char *refname;
> >         int reflen;
> > +       const char *p;
> >
> > -       if (linelen < 83 ||
> > -           line[40] !=3D ' ' ||
> > -           line[81] !=3D ' ' ||
> > -           get_sha1_hex(line, old_sha1) ||
> > -           get_sha1_hex(line + 41, new_sha1))
> > +       if (!linelen ||
>=20
> I think you can skip this. The old code needed "< 83" because of the
> random accesses to [40] and [81] but you don't do that anymore.
> parse_oid_hex() can handle empty hex strings fine.

I just realized this looks fishy:

	while (boc < eoc) {
		const char *eol =3D memchr(boc, '\n', eoc - boc);
		tail =3D queue_command(tail, boc, eol ? eol - boc : eoc - eol);
		boc =3D eol ? eol + 1 : eoc;
	}

If eol is NULL, we subtract it from eoc?  I mean, eol will be zero, so
we get eoc, which seems like what we want.  I think I'm going to send in
a separate patch to fix that, because clearly that's bizarre and not at
all compliant with the C standard.

Going back to linelen, I think it's probably safe to remove, since even
if *boc is a newline (and we get an empty linelen), we're still
guaranteed to have another character, since this is a strbuf.  The
amount of double-checking I had to do there makes me nervous, though.

I'll squash in a change.

> > +           parse_oid_hex(line, &old_oid, &p) ||
> > +           *p++ !=3D ' ' ||
> > +           parse_oid_hex(p, &new_oid, &p) ||
> > +           *p++ !=3D ' ')
>=20
> maybe "|| *p)" as well? I think the old code, with "linelen < 83",
> makes sure reflen is at least one. Not sure what FLEX_ALLOC_MEM would
> do if reflen is zero.

I don't think that line is actually guaranteed to be NUL-terminated.  It
may be terminated instead by a newline, such as by
queue_commands_from_cert.

If we did get an empty reflen, we'd call xcalloc, where we will allocate
exactly the size of the struct otherwise.  We'd then try to memcpy zero
bytes into that location, and succeed.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--xx7bp2mx5u4q4fo4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljQYyAACgkQv1NdgR9S
9otNORAAr8UKrxBpVD53QqJNQyx1FlN/ETv2Offb2ui/j3Xg6la8gsVEBcuDYXCR
MkOoudthQ/7y09BRm1yGZcWR1Xvv7P7eFPHBsgHrUYPDGLTxcTz9AkKfoEdilJVW
Is2aWLvwajkFWx1p9QMbAF6Mvg9ltZeeNUVRRjcBuBFJy7q14z/6oiotKzGRN3YZ
+ipGU6+r6rJNrFJJKzrX8bEFf6qMvfES8nXqjufcSUG2Em6aHElT6hEp1OxdlgYl
PYOzvveNZ4jN6RePtXuG25TVBUv3SL8RsSN6qabfxnS334Ql9btT2voDKGXR6Ruc
3itlQMemCMwojWyj6X5jkBVCUv+G/AtXGY3WY/4+/17YUk6PO3A7wpHjXECvUkNr
m0lv+eplBzjMwbzMOozF7E9Ax0AT4WAkVzPKUX2p93YzVnaq6T9+eS07XW/9BN/u
L6sIHN87/ZngPRazucHKAi7l7n2pHdVZHpEs99N7c4+MkpKTDIFg44uhptswavN5
3drUeZZ43Qy+qxqaLexhwzQct4gcxQtfL/6TX8eyIqKWvqQgMdk8mnrldyX5K96D
w7S4uUhC+ws1ivq/uMi6+Y1a/MdV2YSIZx3Vdt3/RpAfCgcuXq3LBpPUP3YyGq8D
yJVG6ATJRW/cz0KBm8OfyXk6/gejaM4k5/1bkhLO8Qxt7883qxo=
=L5PA
-----END PGP SIGNATURE-----

--xx7bp2mx5u4q4fo4--
