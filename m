Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9213CAA2
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452733; cv=none; b=H+sv46iQgmZKetzGzD27uc4Ird2Mx7jd3jT+CcWJehOMcaog2HWSMXjD5AhtirGemtgup5nUvywoef7w19nHXy6UI4M0uTmfgOh6A35xcwVQzqqAdaazK7gyU3kHFCtl1lEg3y7WUIf0T7X8IN3Olk2qNWxlWfG/tzJlqqsycfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452733; c=relaxed/simple;
	bh=bMnvpC40oTAyIvoPb0Siln9sIgnVHtKfjd+K8/dOr2I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmR/TKR79CimEWa7CT+rcXd2fdkrRdlLgetXiU+yRRpCFcPvfDfWAifTS15GRT9NdCE14hSIMdjUdUnTzgs5wsQZUfcz98n9D3vR9zlGyzjxriMMflbCiGRFcPAw1L8fpjbHioAcUfp9C4Hq9FtwNknRwxjHlB1W6H1FMwL5lOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NRg82TMn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jnfxZrV6; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NRg82TMn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jnfxZrV6"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7065318000CF
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:25:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 May 2024 04:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716452730; x=1716539130; bh=btuqqD4A/M
	VuVxr1BlsGSzKMwoA9cKWkZl3wQfnFz10=; b=NRg82TMnlihba9SVbT22PMAhGh
	nhHsxWw2/7V4Gf87lsmXMEV2tC63Erwvo+bibJM3+TplfBUx9zS0rBKYymgc2sPa
	LuGn0O3hsbo9zgRGyaU2doyBtQ3YXqhswAd7XJSFviAlh1cAVOP+NtgpVqEAjiQD
	BGznm5i2891etccFxy0PZENxG/NQlXmjMf+8g7TGoyn8eSwOa1bwKWoTn0W21JBx
	3xyBUzRrJIGnoGFUJbSGnzvGweY1kByB2npU4d/r/+Aw249h/WRkel4QbQY0rPXJ
	VuNYma3py/b+Kfk7k9N+IBfg4j0VDpnQ5zANNWkFUJ49Qe8nJkyrTQIWuloA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716452730; x=1716539130; bh=btuqqD4A/MVuVxr1BlsGSzKMwoA9
	cKWkZl3wQfnFz10=; b=jnfxZrV6FCZoMrkA748wKJuOdz0R/aM1DBEndR9O939/
	FMz8iEHennZDLNhZ1aSlUQn/puzYs7djaO8yzmzBwlPHi5ZsE06PQvY4JhCdf8zu
	qRvQ0CGyHMQZWTlmnG+4QnEspsDBwEWiq7qV8ymupck9yKVCngbNIW3LV+AMDmNu
	jWFvOGbRW/MGApgIit2Duk0BePFa1HNWwgp9S7y2/JBUDb3M/3PAnNKH+Ma1uOy+
	LimmpmViIW+449WGGYGzFg8ms4Wp2DqSGB9U8FQCPYxtbURwxRAMFXWK0pOzsLJ1
	AW3T7NadkupBX7M0DdDfaNQGzTx7zOaMPq/VSzfbjg==
X-ME-Sender: <xms:ef1OZhcqJmvxYmM-e21oviryhrR3GDRWT2fcrQt49PjUoTg00IuDKQ>
    <xme:ef1OZvOxOvC_1HCs6cE-A2WMvIf74-8PMcnMIyYuMJV_jL6bThhe-g5BRHZRRq63a
    _g7ocbC_Fcu0f61ng>
X-ME-Received: <xmr:ef1OZqhuQsKQH1MZyFfH-vnOX5pIftYzLt_Uzowfrtk_lOB2ksG22UtDz3eX-85JjnIJ8IIIbQ8T30PTDMSAod3OPcYSOXhpD4HYwALzqQYheaFAxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ef1OZq95d13h_DY_DTYENVCDfyGgjTWcrkYxq1xRUCqbWWRb_YJ1yg>
    <xmx:ef1OZtvNyU4o7D_nfAsgPSgqW_Ky1Acq1WEuyr83esCSG9fDyzP11A>
    <xmx:ef1OZpEEqguI2QTffygfeLhwLeAfkVV5dElaLy3itteqlyUz4PAJ2w>
    <xmx:ef1OZkPJxx1nF74JZLKjAZyM0gLYnEo8zUe0NwSyCU84jxK5GhO_gQ>
    <xmx:ev1OZuVrnKMsI3CvsC1rWBKpSwhtAYO740mUVtZQqCHD3ZdNqsbF1jPi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 04:25:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7326c9f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 08:25:23 +0000 (UTC)
Date: Thu, 23 May 2024 10:25:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/9] refs: pass storage format to `ref_store_init()`
 explicitly
Message-ID: <6e7b9764f6290fb8ffe5941e33b72081e1c9581f.1716451672.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5V0ij9YTA+JAiDWD"
Content-Disposition: inline
In-Reply-To: <cover.1716451672.git.ps@pks.im>


--5V0ij9YTA+JAiDWD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to introduce logic to migrate refs from one storage format
to another one. This will require us to initialize a ref store with a
different format than the one used by the passed-in repository.

Prepare for this by accepting the desired ref storage format as
parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index e6db85a165..7c3f4df457 100644
--- a/refs.c
+++ b/refs.c
@@ -1894,13 +1894,14 @@ static struct ref_store *lookup_ref_store_map(struc=
t strmap *map,
  * gitdir.
  */
 static struct ref_store *ref_store_init(struct repository *repo,
+					enum ref_storage_format format,
 					const char *gitdir,
 					unsigned int flags)
 {
 	const struct ref_storage_be *be;
 	struct ref_store *refs;
=20
-	be =3D find_ref_storage_backend(repo->ref_storage_format);
+	be =3D find_ref_storage_backend(format);
 	if (!be)
 		BUG("reference backend is unknown");
=20
@@ -1922,7 +1923,8 @@ struct ref_store *get_main_ref_store(struct repositor=
y *r)
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
=20
-	r->refs_private =3D ref_store_init(r, r->gitdir, REF_STORE_ALL_CAPS);
+	r->refs_private =3D ref_store_init(r, r->ref_storage_format,
+					 r->gitdir, REF_STORE_ALL_CAPS);
 	r->refs_private =3D maybe_debug_wrap_ref_store(r->gitdir, r->refs_private=
);
 	return r->refs_private;
 }
@@ -1982,7 +1984,8 @@ struct ref_store *repo_get_submodule_ref_store(struct=
 repository *repo,
 		free(subrepo);
 		goto done;
 	}
-	refs =3D ref_store_init(subrepo, submodule_sb.buf,
+	refs =3D ref_store_init(subrepo, the_repository->ref_storage_format,
+			      submodule_sb.buf,
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&repo->submodule_ref_stores, "submodule",
 			       refs, submodule);
@@ -2011,12 +2014,12 @@ struct ref_store *get_worktree_ref_store(const stru=
ct worktree *wt)
 		struct strbuf common_path =3D STRBUF_INIT;
 		strbuf_git_common_path(&common_path, wt->repo,
 				      "worktrees/%s", wt->id);
-		refs =3D ref_store_init(wt->repo, common_path.buf,
-				      REF_STORE_ALL_CAPS);
+		refs =3D ref_store_init(wt->repo, wt->repo->ref_storage_format,
+				      common_path.buf, REF_STORE_ALL_CAPS);
 		strbuf_release(&common_path);
 	} else {
-		refs =3D ref_store_init(wt->repo, wt->repo->commondir,
-				      REF_STORE_ALL_CAPS);
+		refs =3D ref_store_init(wt->repo, the_repository->ref_storage_format,
+				      wt->repo->commondir, REF_STORE_ALL_CAPS);
 	}
=20
 	if (refs)
--=20
2.45.1.216.g4365c6fcf9.dirty


--5V0ij9YTA+JAiDWD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZO/XYACgkQVbJhu7ck
PpS4zg//f4Eis+dko+/K8rQxx06MNm6p/IEOGdIJj8YwAr0plDWeFAr3m5zD4Fqi
PdS13eKoI42knApK7rLKlee5yrSSh6qkagSUw8BSazhM2wjW+F+vk9GWW1CLZLHC
8TSyKyBLb3pBkv9W2iBGDfSGrDaVnuGcaXOG0T36tfr8aBW5U8tPm426eLAGXGOw
gVNr+U38fn06rFzAqykXrbabfLTp9OPJl8XSUIBdgAdSRw0r4iItbfhWG8xJTqdv
lEDvTFhag30jPJte475LtrE0TW543M1Mx9LupevGcB7AjRJz3k2e9qH73KmFQj7p
DCn6v4qK2+VsN9LfeBNtLhD21U7C1ebEm97zsXO4uFmSKzRCgAhEfJVGsSpExmvS
bg91z+tqNiz9EXhwqs+27dMhRlC3CoNVYwhH4WszFdMdylCGZP+toQKvyjMXE8A2
gvfPif51hP0+sNA14LHOLvu3gGiXzhow7Qhu2Uw3ntAyiizuNQ42cwqShFSTl4+q
bmtWd0yUUnR5EQwiA+5EKD/7l7CQkBHvxVjKYo+SFOlBaSL1QQwO11+C8JIISpNY
BVXH09leyi0WiHZxhaLM1Ez+ByLUeQ8KhrRYI16br1uwYGKmooePe+3TA9r/1jBv
molKFQk9u3Z60NRZXhGD8jzqPhI3LMelk+vp7YD6SjbFmhaJ88Y=
=ad5O
-----END PGP SIGNATURE-----

--5V0ij9YTA+JAiDWD--
