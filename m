Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1341A12E1C0
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846673; cv=none; b=Ozg+NAZldxvA2F8janLNuMriF/FHtDyI4zl6K0r93vFsOq8ByRpL1dQcHffYV5Nn826YBp8jYIwqxBKdPiTzIIexE33BAJpPbgctgnyUTykAsKqyJ/zMkfW+IBYcViwGQe7a03308VUV0E6Vi5pRoVckudcSUZEL2A+C7ys/0VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846673; c=relaxed/simple;
	bh=504rxHNROh8V5UdLGZhkWwkZwo2HoWtsKBSEmqKGLZU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvwGYYFwzvr0iuTJ9mhzdHBc1nkpu3tXDVS9xt73toubjUWvDghsXXr1ilp2u1/2MW33EeOYetYsuyH80JUg7onJ5nHpVARW64U+Lme5ohKISsg3BHowSwYfjfF82PdJo2wmOReLdy6EfcD0ImzMJPoI8iXRo1M3H+HfJnfc6mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OeBQVgKG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FQmKGJ9Z; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OeBQVgKG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FQmKGJ9Z"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 32A77138039C
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:04:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 16 May 2024 04:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715846671; x=1715933071; bh=UChDxkO81j
	yTHSnpHwBlFocQtje6/LiE2Ch1C5pFFUk=; b=OeBQVgKG1xv9OutSizOT3xT/6l
	EFExEjuromxWQjvsFU/5xq+ahTcZiyzQW41z4QCJcbwN0YLVqpaR9FJrEmYP8PdB
	mGPDyGEIOSdKmDZsAwuE/xtDFxZAOsMFX+/F9O06Lf8KZaH8J+rMFGfH+rzUjL+v
	M9dgrKinWQ5oA/8SyiNDveKLIBQdgUUtBBR3AHEJM0U/ScBaQJF/ZmPomtPwBUks
	TxZfF6az9lhwyf1BiV3dkYvrZAxMDNcx9GghNrREJHJEkXlceYpyb+FXZMqeuJlh
	PWTVWfd9+hV1gmimChed+P7muwEXD3QrBK01509efi7ygnpPedWrW3/JyFRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715846671; x=1715933071; bh=UChDxkO81jyTHSnpHwBlFocQtje6
	/LiE2Ch1C5pFFUk=; b=FQmKGJ9Z8AY0vRNbD1mYULbEDoA9bJP4GYZLr6qMd0VM
	T6zMTE+vKAoOwKmW1+kJ3wz8MbUUs8detVGKdDW9rlksoSl/v88y99lbDwjGInqL
	BqEyBRB7I1WH9Dn0BMiO4mCZsGGLivGF2Va+YSdGuAEIcX32AbCF/KzBitYi0NdA
	c+6V496ETnrCNEqWEfewsREkG8bKnb4sPIyW2EvY9pKpwZE0Uqtm9etW6B4yCgD/
	2kKkHvVqjJ+5JgfErYlv90VOjfjQ+X37hx0au3RMLTtktrDqznByL2xMMDbjc6LX
	MKoEWEKqaYQoHcLXXeM+A1xaTeG0MQg5gDT1tFjNYA==
X-ME-Sender: <xms:Dr5FZj6h7o_cN9ZYOCiZ1WuL-Ya5kK0YOBdSdiP301f2UM8oQ9CWJw>
    <xme:Dr5FZo53ll6EfGgwOvxYXr9Q9oDwn9_Usg-eP38SoT30XFZzbx-JRqHPLNYVchnHy
    qzudy6nPGv14nAB9g>
X-ME-Received: <xmr:Dr5FZqfTwsfU2sXES24_qMB1YK_92haXWi4A0-LkdbKM9u84_z6MYF4JMR_ljx-PEmqVufqBhjv5MSn5WE7XZFzjorL2gWDBDZkI9VHD337fkx4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:D75FZkKU80y0rqxjmzA4tnLwDQT8PivrKr4X_XsMxFxny5fDkR-Oaw>
    <xmx:D75FZnIwBcC-8WCU5N9MjtF31yJpsWLlDwF7bxRdILvUkH7hEeZ_zQ>
    <xmx:D75FZtyounGS1-ONJbdZeqG4GLtErAs2ZIqnGdt3ouIy9ix-ZIwctQ>
    <xmx:D75FZjIfnQXG3XrPlP1_kbL6JygRU-eQXo7mcHkFxOoUB-13VVqAzA>
    <xmx:D75FZtglXLtlO-ho0DZYFB6NXvEVZuMpI-CReT1Cy37OrjkJlL2SFG4S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:04:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c549adba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:04:06 +0000 (UTC)
Date: Thu, 16 May 2024 10:04:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/16] refs: track ref stores via strmap
Message-ID: <52798936a290ffa64b244f9bbd1c5f17d1b24db3.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Uq/RbOn+EE44bvo0"
Content-Disposition: inline
In-Reply-To: <cover.1715836916.git.ps@pks.im>


--Uq/RbOn+EE44bvo0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The refs code has two global maps that track the submodule and worktree
ref stores. Even though both of these maps track values by strings, we
still use a `struct hashmap` instead of a `struct strmap`. This has the
benefit of saving us an allocation because we can combine key and value
in a single struct. But it does introduce significant complexity that is
completely unneeded.

Refactor the code to use `struct strmap`s instead to reduce complexity.
It's unlikely that this will have any real-world impact on performance
given that most repositories likely won't have all that many ref stores.
Furthermore, this refactoring allows us to de-globalize those maps and
move them into `struct repository` in a subsequent commit more easily.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 71 ++++++++++++----------------------------------------------
 1 file changed, 14 insertions(+), 57 deletions(-)

diff --git a/refs.c b/refs.c
index edb0a633d1..542acb25ff 100644
--- a/refs.c
+++ b/refs.c
@@ -6,7 +6,7 @@
 #include "advice.h"
 #include "config.h"
 #include "environment.h"
-#include "hashmap.h"
+#include "strmap.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
@@ -1960,66 +1960,27 @@ int resolve_gitlink_ref(const char *submodule, cons=
t char *refname,
 	return 0;
 }
=20
-struct ref_store_hash_entry
-{
-	struct hashmap_entry ent;
-
-	struct ref_store *refs;
-
-	/* NUL-terminated identifier of the ref store: */
-	char name[FLEX_ARRAY];
-};
+/* A strmap of ref_stores, stored by submodule name: */
+static struct strmap submodule_ref_stores;
=20
-static int ref_store_hash_cmp(const void *cmp_data UNUSED,
-			      const struct hashmap_entry *eptr,
-			      const struct hashmap_entry *entry_or_key,
-			      const void *keydata)
-{
-	const struct ref_store_hash_entry *e1, *e2;
-	const char *name;
-
-	e1 =3D container_of(eptr, const struct ref_store_hash_entry, ent);
-	e2 =3D container_of(entry_or_key, const struct ref_store_hash_entry, ent);
-	name =3D keydata ? keydata : e2->name;
-
-	return strcmp(e1->name, name);
-}
-
-static struct ref_store_hash_entry *alloc_ref_store_hash_entry(
-		const char *name, struct ref_store *refs)
-{
-	struct ref_store_hash_entry *entry;
-
-	FLEX_ALLOC_STR(entry, name, name);
-	hashmap_entry_init(&entry->ent, strhash(name));
-	entry->refs =3D refs;
-	return entry;
-}
-
-/* A hashmap of ref_stores, stored by submodule name: */
-static struct hashmap submodule_ref_stores;
-
-/* A hashmap of ref_stores, stored by worktree id: */
-static struct hashmap worktree_ref_stores;
+/* A strmap of ref_stores, stored by worktree id: */
+static struct strmap worktree_ref_stores;
=20
 /*
  * Look up a ref store by name. If that ref_store hasn't been
  * registered yet, return NULL.
  */
-static struct ref_store *lookup_ref_store_map(struct hashmap *map,
+static struct ref_store *lookup_ref_store_map(struct strmap *map,
 					      const char *name)
 {
-	struct ref_store_hash_entry *entry;
-	unsigned int hash;
+	struct strmap_entry *entry;
=20
-	if (!map->tablesize)
+	if (!map->map.tablesize)
 		/* It's initialized on demand in register_ref_store(). */
 		return NULL;
=20
-	hash =3D strhash(name);
-	entry =3D hashmap_get_entry_from_hash(map, hash, name,
-					struct ref_store_hash_entry, ent);
-	return entry ? entry->refs : NULL;
+	entry =3D strmap_get_entry(map, name);
+	return entry ? entry->value : NULL;
 }
=20
 /*
@@ -2064,18 +2025,14 @@ struct ref_store *get_main_ref_store(struct reposit=
ory *r)
  * Associate a ref store with a name. It is a fatal error to call this
  * function twice for the same name.
  */
-static void register_ref_store_map(struct hashmap *map,
+static void register_ref_store_map(struct strmap *map,
 				   const char *type,
 				   struct ref_store *refs,
 				   const char *name)
 {
-	struct ref_store_hash_entry *entry;
-
-	if (!map->tablesize)
-		hashmap_init(map, ref_store_hash_cmp, NULL, 0);
-
-	entry =3D alloc_ref_store_hash_entry(name, refs);
-	if (hashmap_put(map, &entry->ent))
+	if (!map->map.tablesize)
+		strmap_init(map);
+	if (strmap_put(map, name, refs))
 		BUG("%s ref_store '%s' initialized twice", type, name);
 }
=20
--=20
2.45.1.190.g19fe900cfc.dirty


--Uq/RbOn+EE44bvo0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFvgsACgkQVbJhu7ck
PpRqZw//VwfUcTbz4Zi7VCTQR/MOKJeQw6B62zCCQVfa+xLJDqIkUKtgE8waIQpE
330rB7D/yvQpZOxU/BMATh9Lr2ps9xOPpunGnh66B/rll06Ub387p3LHbiZ/jDB7
4KUh3TMgt92MITCqSMWSFoCNTGAS89gU5M6kh14s5ujmnzP8yMTIZxgMJtQslypl
snvxkfVsBF395cZna6Z+FNX2fZ51Gfouprip1GcjQHCVsNf6pAWypqX4udJfY2Yu
S9nEEXhFofZe2Elj3VBe8GJUQ+1dXdy6Ni2qW4f/H6xX1bl+wgUMCt1GbOK7kwdx
ehD3NG2BMffexC3KhVxENJoORyTQjLq0Q8Dn2Agz3aqOuchW6YG5rN75pznMp09p
iHqIl8pz8A0lCxE7oJcDk7ORUqZItiV4Ecz6HHDtBPM9dG4azGULe4v4BPjiyiKz
vK6+fvPhQMoln4Xo2CxeS/+9ZyaTm+82gkhUt6zR8MlXQ4I7/ie5RzJPEkTTgKf8
SviEwmD4CELWv5X3gWKLZkMIDeYavWq+kBoDYCFaofM74pWj1jxiqDRHoPcoAvt8
aY7ogxvQc+DVWW/0pGU/uIH8DhWIQszVjh+7tyq12M9C+uBW3FGewHBg695iogly
FodsfKdC+RxO8wsMYJq80zvRAV7g7tYQPWm/PiqHxOpFqm/Csf4=
=L3yF
-----END PGP SIGNATURE-----

--Uq/RbOn+EE44bvo0--
