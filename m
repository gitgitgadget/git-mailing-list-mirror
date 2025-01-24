Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [46.4.70.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544914317E
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.70.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737728285; cv=none; b=nEbZKaVQsih/UTbxx2kMdPzOEzZm9T9UL6IhdTcJmZxt9Hyz9lPUP0aNLTnVtrVzVsZXFzKQwXxXOTk0my7MQZmgVuSxjg5v+51YbZ3sqOK5US5g33+FkRPBsb+OhPtKdTNchqTKXDw86cxXwHJN9sec9Ot9skKifqxhObV1fuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737728285; c=relaxed/simple;
	bh=DEH5QxZZJo9VfX0a/fn3trOZ8YX4SwE0gKRAUHHHUKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZU3GmP5MrP9lpNJRl9/5noS3bQbRe++G8J8KBpAOQ5m19bH25eoag4EcSlTvsHDPO1EbYSdUBKfzkzJ4/t40IBXgc22RH86+poK1Z5kZbjta0NCciN6dkg3kzmpSDrcgVsPa5xnCrqh1q5Sqm3ogu71hNcTzYhfdt0k525Y61SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de; spf=pass smtp.mailfrom=eworm.de; arc=none smtp.client-ip=46.4.70.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eworm.de
Received: from leda.eworm.net (p5085ac4b.dip0.t-ipconnect.de [80.133.172.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id 3925A24BD9D;
	Fri, 24 Jan 2025 15:07:53 +0100 (CET)
Authentication-Results: mx.mylinuxtime.de;
	auth=pass smtp.auth=mail@eworm.de smtp.mailfrom=list@eworm.de
Date: Fri, 24 Jan 2025 15:07:45 +0100
From: Christian Hesse <list@eworm.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: "Christian Hesse" <mail@eworm.de>, Bence Ferdinandy
 <bence@ferdinandy.com>, git@vger.kernel.org
Subject: Re: [PATCH] fetch set_head: fix non-mirror remotes in bare
 repositories
Message-ID: <20250124150745.105593ea@leda.eworm.net>
In-Reply-To: <xmqqr04tqm86.fsf@gitster.g>
References: <20250111202628.0e5894e4@leda.eworm.net>
	<20250112165125.130400-1-bence@ferdinandy.com>
	<xmqqr04tqm86.fsf@gitster.g>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
X-Face: %O:rCSk<c"<MpJ:yn<>HSKf7^4uF|FD$9$I0}g$nbnS1{DYPvs#:,~e`).mzj\$P9]V!WCveE/XdbL,L!{)6v%x4<jA|JaB-SKm74~Wa1m;|\QFlOg>\Bt!b#{;dS&h"7l=ow'^({02!2%XOugod|u*mYBVm-OS:VpZ"ZrRA4[Q&zye,^j;ftj!Hxx\1@;LM)Pz)|B%1#sfF;s;,N?*K*^)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEUZFRFENy6KVTKEd23CiGHeqofJvrX4+vdHgItOAAAACXBIWXMAAA3XAAAN1wFCKJt4AAACUklEQVQ4y2VUTZeqMAxNxXG2Io5uGd64L35unbF9ax0b3OLxgFs4PcLff0lBHeb1QIq5uelNCEJNq/TIFGyeC+iugH0WJr+B1MvzWASpuP4CYHOB0VfoDdddwA7OIFQIEHjXDiCtV5e9QX0WMu8AG0mB7g7WP4GqeqVdsi4vv/5kFBvaF/zD7zDquL4DxbrDGDyAsgNYOsJOYzth4Q9ZF6iLV+6TLAT1pi2kuvgAtZxSjoG8cL+8vIn251uoe1OOEWwbIPU04gHsmMsoxyyhYsD2FdIigF1yxaVbBuSOCAlCoX324I7wNMhrO1bhOLsRoA6DC6wQ5eQiSG5BiWQfM4gN+uItQTRDMaJUhVbGyKWCuaaUGSVFVKpl4PdoDn3yY8J+YxQxyhlHfoYOyPgyDcO+cSQK6Bvabjcy2nwRo3pxgA8jslnCuYw23ESOzHAPYwo4ITNQMaOO+RGPEGhSlPEZBh2jmBEjQ5cKbxmr0ruAe/WCriUxW76I8T3h7vqY5VR5wXLdERodg2rHEzdxxk5KpXTL4FwnarvndKM5/MWDY5CuBBdQ+3/0ivsUJHicuHd+Xh3jOdBL+FjSGq4SPCwco+orpWlERRTNo7BHCvbNXFVSIQMp+P5QsIL9upmr8kMTUOfxEHoanwzKRcNAe76WbjBwex/RkdHu48xT5YqP70DaMOhBcTHmAVDxLaBdle93oJy1QKFUh2GXT4am+YH/GGel1CeI98GdMXsytjCKIq/9cMrlgxFCROv+3/BU1fijNpcVD6DxE8VfLBaxUGr1D5usgDYdjwiPAAAAAElFTkSuQmCC
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.xxW_NYxbnmA_RRNz8hFPWO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Rspamd-Server: mx
X-Rspamd-Queue-Id: 3925A24BD9D
X-Spamd-Bar: /
X-Stat-Signature: 1jzzjn4s3b485qsrnqqersk6qtz5pe9a
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.00 / 15.00]

--Sig_/.xxW_NYxbnmA_RRNz8hFPWO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> on Thu, 2025/01/23 13:00:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>=20
> > In b1b713f722 (fetch set_head: handle mirrored bare repositories,
> > 2024-11-22) it was implicitly assumed that all remotes will be mirrors
> > in a bare repository, thus fetching a non-mirrored remote could lead to
> > HEAD pointing to a non-existent reference. Make sure we only overwrite
> > HEAD if we are in a bare repository and fetching from a mirror.
> > Otherwise, proceed as normally, and create
> > refs/remotes/<nonmirrorremote>/HEAD instead.
> >
> > Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
> > Reported-by: Christian Hesse <list@eworm.de> =20
>=20
> These should be chronological; somebody reports an issue, the patch
> gets written, and finally it is sent out with a Sign-off to certify
> that the patch is not a stolen property.
>=20
> > ---
> >  builtin/fetch.c   | 15 ++++++++-------
> >  t/t5505-remote.sh | 10 ++++++++++
> >  t/t5510-fetch.sh  | 13 +++++++++++++
> >  3 files changed, 31 insertions(+), 7 deletions(-) =20
>=20
> We haven't heard from Chritian; has this been tested OK?

Sorry for the late reply...

Yes, with this patch applied git behaves as expected for me.
Thanks a lot!

> What the patch does does look sensible.  Thanks.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/.xxW_NYxbnmA_RRNz8hFPWO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAmeTnrIACgkQiUUh18yA
9HZ3FQf/ZWU3Wf43fHq4Vc+vFA+HeRNXqO0KmoIecHV6nKvT9ePGeTf+HhB3Pr7a
hkyVKzTdl1V5ub8reu55zJJFflqSG4ZFOC7JGbL1P4WxDZPhUvh9GNfVnUC1AA0u
PBsnWekNI9rmJuAxMmBrwL7NdYzeA+KnrpVOQKMAMVYiZJ8pf9F0NW+PZGcFV+v1
53uI+y/INFwIGuN0+UqyVtbNIuRubkWQBApTnOm27TAGslDxjiZRfiBqgXheCoU6
rUXcvcFYs2azpFWESHFiz+knmm4+D6aVOF4COBXGPJbHmIoGiqLSiX3jXwrac5Bo
Z8VlkcfdMd5zA2UrwaNlPni8YeCNdQ==
=WU8/
-----END PGP SIGNATURE-----

--Sig_/.xxW_NYxbnmA_RRNz8hFPWO--
