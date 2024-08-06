Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8C51BE853
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934835; cv=none; b=G4w6TJFzs2gx0wBsgo08jgK3f1OwaEjudb4BIUvfHzEFWTOCQVCEateE7FqIs/AGkfBQR6R+7OMOGQjZG3VaY6Uat12kIjf482wzwhTUV/1RFtgyUZsaS8tSAyu/NSzVUVNVqNIoT4ZTrbcDnhQLm3ARnr1tBxfpD/kZcMZJnmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934835; c=relaxed/simple;
	bh=JTdSLCgQ//ks1dpUuOslSZA1e03m4el1V90HTW/48hY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iw4yqcNahu41g1WvKVd6aEvDulFPTmqRpN+z6YWnYe73llD39t2Tc1cLjXdD5HYjKbAlSLAy5a/IDgo/9b7d6g3aI2n6RVthXp11mJwPMc1PHCH/I50124CzPV7AuCyDbiotW2tYAbb/8wKPLkhlHTg800OODzAovMxWKe4N0jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b10l00y2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PAK9Adyn; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b10l00y2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PAK9Adyn"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6A405138FCE9
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:00:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Aug 2024 05:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722934833; x=1723021233; bh=m5CHUumm0g
	uyk1sSBkis4+zw6/KlvQxZ1fJTE5lI1dY=; b=b10l00y2kOkhEE7G2kHaZWU5Qo
	yoqtH1G6YnawNgerYIbOH7+YJbJinCUsB04M5eH04Z8DUEsFF6+Hb1KBNRT+Sn+J
	gCDKFtHGhShFWp3GT8jbucHzEsoX2ZW16EhX7UI8wThM4SBWVrzVxQz8YRRf6Pmt
	fKb9XpKcs2NQWh3g0QOpJvugiFGCQxD96f3gGhF4J8m/kReI/gIs2Ms21G15pVsQ
	OjpKURGtxWiq8pMDkC0MrcDW28pzsHlOFe9p9/0e0cN7JedejSMjFSiG7UMJy4EK
	UvJ9nkWCb9Jx49Wr0Wms5PMAdtGM2YuK0n3JELoqas5Fg0RCTLpDgMoC2SXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722934833; x=1723021233; bh=m5CHUumm0guyk1sSBkis4+zw6/Kl
	vQxZ1fJTE5lI1dY=; b=PAK9AdynVmlr46OoWk9R+eDpO0fc2Hz051cVQMLjgIm7
	ErERUrquN7mBNk5oyjbeTrb/X6V10AqhW/KhoitXmiyRj8pIGDAv7ZMcYhlNILyG
	SX4aeLdDs6uYZL9/BNrLJ8rJSKejZ0wLb5SLuQ9xMCNQEhU6IdB7X3NwmLHqaGj+
	tk9jwFd767JfIFv7Um6KaR9syF6+g0Euw5/Zljuvdkj19E3Pu+ZeJQ6jyjk2BwKE
	qxwlcHiVhU6PGZ/QOdDBFgU1BQoglBd49LQ42dEsx3yuMKOhURcQL3C6Lm4Q0bEz
	qh7pDdgPVUjtY5XEiBzgB8PmqU1psANkM3nOgjNisQ==
X-ME-Sender: <xms:MeaxZtERmFiyv5yfo0coyRYViDbDQqYpxY-nEMwdKgHugoUvS7GMHQ>
    <xme:MeaxZiV4Y0sDlzks8jSd7m3Ra1IgVqDRCT-SZaHp8l0w3-oJwDOFkJ4K1u8Nyqk4P
    tjxabsaMFiZjnztEQ>
X-ME-Received: <xmr:MeaxZvK9x0ZDcknRbJtzFtjZWeH18fMfvkG5cJfLKN_2YGk5wX7IEIQzEkW52kqsfQDp62C1xHeNBHbK49hf0iOXZa0Cw92zdCXozMcDbbp7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeiiefhtedukefhieeukeejueeivdekudfhfe
    elhedvfeetgedtfeevgfeutdetfeenucffohhmrghinhepughifhhfohhpthdrnhhonecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:MeaxZjG4rtNWMlr-AEmWjxt8Ij0ADumakbwZm9hfAxwjb9X-SfNJSw>
    <xmx:MeaxZjU3UKIWe7xz99uBcZkqGDEGHhRJncotRebS203EMZL-5qSZ6A>
    <xmx:MeaxZuO7g4kzkS8uQMtzPB6yeZ6KHFIVCiN1pbE9p45pbjkEMuvLAA>
    <xmx:MeaxZi2Dxmk4L5y-FfsiTZYKdB9mKTgan_X4v17Kc4n7B6I5aeWodA>
    <xmx:MeaxZqc4WPeqKCSEqR8FZjNxxTBoCwC64rDKJPwhg2xWSIIH7lfzfGf_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 Aug 2024 05:00:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7648cb3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 Aug 2024 09:00:30 +0000 (UTC)
Date: Tue, 6 Aug 2024 11:00:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/22] builtin/fast-export: fix leaking diff options
Message-ID: <660732d29df8be6253f205fbbad2cdcafb0a0bbd.1722933642.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n9qJZo1fc6SlHfqC"
Content-Disposition: inline
In-Reply-To: <cover.1722933642.git.ps@pks.im>


--n9qJZo1fc6SlHfqC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Before caling `handle_commit()` in a loop, we set `diffopt.no_free` such
that its contents aren't getting freed inside of `handle_commit()`. We
never unset that flag though, which means that it'll ultimately leak
when calling `release_revisions()`.

Fix this by unsetting the flag after the loop.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-export.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 4b6e8c6832..fe92d2436c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1278,9 +1278,11 @@ int cmd_fast_export(int argc, const char **argv, con=
st char *prefix)
 	revs.diffopt.format_callback =3D show_filemodify;
 	revs.diffopt.format_callback_data =3D &paths_of_changed_objects;
 	revs.diffopt.flags.recursive =3D 1;
+
 	revs.diffopt.no_free =3D 1;
 	while ((commit =3D get_revision(&revs)))
 		handle_commit(commit, &revs, &paths_of_changed_objects);
+	revs.diffopt.no_free =3D 0;
=20
 	handle_tags_and_duplicates(&extra_refs);
 	handle_tags_and_duplicates(&tag_refs);
--=20
2.46.0.dirty


--n9qJZo1fc6SlHfqC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmax5i0ACgkQVbJhu7ck
PpQ3hRAApxiz+zYKpR2JFa8tgT8eOIBbUoHMKFFPm6beZiBpkS4rMggyd6ikrrRm
wWu3IGUtLY3CiJngtucKLrYgeXs04K/o38sMvNyrqGuNIAejLXWFSoZkUggg7L24
bcURSWiauL1jneZ33FHBE6HjoJF2FqBqzydGh6Nsyc7uCDijMbUFM/5xtQY2nGKg
r5I3jIstRFq+RyOL24FU+M+093YjooJt6yXza5jQreg/snRY2pqMs/hQ32PLQ212
GZj5zG42z1bxubMDXM5zmEIgCT3WCASaDSqNatg7ZZT6WfpH/hHee8obd8iN7JD2
jy6PKJBLSbKxsWpXUEuASm/U4N7fQMs+YT+fFa1qNtmVoIlQAidNguSRXj2ycnFj
RH4kwnDfXfY1uR4NEvk0t3uLvEpxu4ODSFTht/IwWCatRPorW4CiUpDkdNE7BVr1
JBjIJc7/YHuNy6P0NPFMoZEZa/fS2KR/382OHVMZntpZNB130FuAgcfVp7+JVjm7
YyX0DnzfGgw+IoKlRaZkICFgd76U+bhnbospJA328tlsjoDkz+dlJx83Io7Ow2E1
KO6q/2m1cxJ2o2pj3LtEnsWKdjJ7kzEoUiNLg9zkFDLfLzccH36nDN6AStYtBdx8
nJAoaQsh0+4JraA8ySKbLToeCGmt5n61ewJ5Osy4BXsLS8flB9Y=
=tk/r
-----END PGP SIGNATURE-----

--n9qJZo1fc6SlHfqC--
