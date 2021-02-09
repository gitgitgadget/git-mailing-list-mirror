Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40191C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 03:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E471964E4F
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 03:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhBIDHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 22:07:53 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44490 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230131AbhBIDGR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Feb 2021 22:06:17 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 294066079B;
        Tue,  9 Feb 2021 03:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1612839902;
        bh=cyzoT/j8UBF1V7rexLSrvT70UMzsExh9zWAs3GDbwJc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=DvzQUuPJ3asY6uu7ACznw4FA3ykuxmx1iAfRnn9fcVFIOMWEptU4zEMOqQsdNOc3/
         TCLFRC0UfQ2Q3msDDadsvTX92m8F2o9jZL7bwKTc2XISYj8tqJsgj3XhLMVSkYllyL
         xu47q9aRhIjlP9ZoJ+ld7sofjAsD1Q7QR2T87CTWfRV3XRMvKH1wlf3G2R3mHfLn6K
         1U5PvJheN3BhsqCZxV6QXF3AV0GZZ3xzzGeeVvEkhTwiQ38RsNAcQFI+Gr3LYOFhbU
         3xlsIPNGeBWGFr8Af5uzf/z6xf+l64Fault9eFzc6O1IN3A1imqY3qYcE0P6F94B7n
         DwK3bl0uvP3pTDbArjOgch7uRn878LGY1bwcX3zDYeRHEX5o8E7NlssPgvlgle+1Xl
         Rg1R6zdfKE8dmc5a8eHy95MTA5+t88wkWYEAbS+907IY0eyjGNLbIWHIrgsPaY+eSh
         qVvRyX2R4AvKXp1OT85sKCxd+hNOn+4sC04JEwxz1zUL9kfS7RV
Date:   Tue, 9 Feb 2021 03:04:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hariom verma <hariom18599@gmail.com>,
        Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 3/3] ref-filter: use pretty.c logic for trailers
Message-ID: <YCH71+ck1Wmk1Css@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
 <47d89f872314cad6dc6010ff3c8ade43a70bc540.1612602945.git.gitgitgadget@gmail.com>
 <xmqqpn1c8m7u.fsf@gitster.c.googlers.com>
 <CA+CkUQ9-OCiEkMDRTpyF3rp-g1mSSzn4s9MgqJZ2BJY=XJCoEw@mail.gmail.com>
 <xmqqh7mn91w2.fsf@gitster.c.googlers.com>
 <CA+CkUQ9kHhbDVMru=pRO90o+k7cc_ykxN9JRFGMvoG3hkeGJpA@mail.gmail.com>
 <xmqqlfbz7i7i.fsf@gitster.c.googlers.com>
 <CA+CkUQ_cdUmuP+_yUeCytn=6cc8SjMBE1aTLzWJL-U_V01uzog@mail.gmail.com>
 <xmqqv9b25s7f.fsf@gitster.c.googlers.com>
 <xmqqlfby5o9h.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="afNWWTAtyK6HvEAj"
Content-Disposition: inline
In-Reply-To: <xmqqlfby5o9h.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--afNWWTAtyK6HvEAj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-08 at 19:54:18, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > By the way, when merged to 'seen' (you can try the above that shows
> > %(subject) followed by %(trailers) with the tip of 'seen'), it dies
> > like this:
> >
> >     $ git for-each-ref \
> > 	--format=3D"%(subject)%0a%(trailers:key=3DSigned-off-by:)" \
> > 	refs/heads/js/range-diff-wo-dotdot
> >     free(): double free detected in tcache 2
> >     Aborted
> >
> > There must be some interaction with another topic but I didn't dig
> > deeper.
>=20
> It seems brian's bc/signed-objects-with-both-hashes topic alone has
> the double-free issue, without the "trailers" topic.
>=20
>     $ git checkout --detach bc/signed-objects-with-both-hashes
>     $ make git
>     $ ./git for-each-ref --format=3D'%(subject)%(body)' refs/heads/maint
>     free(): double free detected in tcache 2
>     Aborted
>=20
> So for now, you do not have to worry about it in your topic.  Of
> course, you are very much welcome to help debugging and fixing it
> ;-)

I'll send out a fixed patch tomorrow, but for the moment, here's the
gist of the change if you want to an immediate fix to squash in:

------- %< ---------
diff --git a/ref-filter.c b/ref-filter.c
index e6c8106377..5f8a443be5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1344,8 +1344,8 @@ static void grab_sub_body_contents(struct atom_value =
*val, int deref, void *buf)
 		} else if (atom->u.contents.option =3D=3D C_BARE)
 			v->s =3D xstrdup(subpos);
=20
-		free((void *)sigpos);
 	}
+	free((void *)sigpos);
 }
=20
 /*
------- %< ---------

--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--afNWWTAtyK6HvEAj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYCH71wAKCRB8DEliiIei
gRjLAPsGLwA5FoMUOy1MC4qdaTaKF0731KLAg+yoUOSqq5zlQQEAgQPxMSBQbwns
QdAEIx9AtYl6EysZUA9mgNnTTv8QGg4=
=ykVu
-----END PGP SIGNATURE-----

--afNWWTAtyK6HvEAj--
