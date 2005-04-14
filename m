From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [patch pasky] update gitcancel.sh to handle modes as well
Date: Fri, 15 Apr 2005 01:04:50 +0200
Message-ID: <1113519890.23299.129.camel@nosferatu.lan>
References: <1113519445.23299.119.camel@nosferatu.lan>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CfGmu6tmHI3k72FTNbgy"
Content-Transfer-Encoding: 8bit
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Apr 15 01:01:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMDKQ-0003rU-6j
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 01:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVDNXD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 19:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVDNXB5
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 19:01:57 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:9119 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S261634AbVDNXBG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 19:01:06 -0400
Received: from gateway.lan (wblv-146-239-208.telkomadsl.co.za [165.146.239.208])
	by ctb-mesg7.saix.net (Postfix) with ESMTP id A1D685C7D;
	Fri, 15 Apr 2005 01:01:02 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 1D2423A26DA;
	Fri, 15 Apr 2005 01:07:07 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32536-04; Fri, 15 Apr 2005 01:07:01 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 7021C3A26DB;
	Fri, 15 Apr 2005 01:07:01 +0200 (SAST)
To: GIT Mailing Lists <git@vger.kernel.org>
In-Reply-To: <1113519445.23299.119.camel@nosferatu.lan>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-CfGmu6tmHI3k72FTNbgy
Content-Type: multipart/mixed; boundary="=-xUlQRhwo3k29yxU4/8eC"


--=-xUlQRhwo3k29yxU4/8eC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-15 at 00:57 +0200, Martin Schlemmer wrote:
> Hi,
>=20
> gitcancel.sh do not handle mode changes:
>=20
> ----
> $ chmod -x Makefile
> $ git cancel
> patch: **** Only garbage was found in the patch input.
> ----
>=20
> Rather use checkout-cache to sync our tree, as should do the right thing
> instead of diffing (cancel imply just blow away everything).
>=20
> Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>
>=20
> gittrack.sh:  03d6db1fb3a70605ef249c632c04e542457f0808
> --- 03d6db1fb3a70605ef249c632c04e542457f0808/gittrack.sh
> +++ uncommitted/gittrack.sh
> @@ -51,6 +51,7 @@
>=20
>         read-tree $(tree-id "$name")
>         gitdiff.sh local "$name" | gitapply.sh
> +       update-cache --refresh
>=20
>  else
>         [ "$tracking" ] || \
> @@ -61,6 +62,7 @@
>         if [ -s ".git/HEAD.local" ]; then
>                 gitdiff.sh "$tracking" local | gitapply.sh
>                 read-tree $(tree-id local)
> +               update-cache --refresh
>=20
>                 head=3D$(cat .git/HEAD)
>                 branchhead=3D$(cat .git/heads/$tracking)

Yes, I am an idiot, and its past 1am already here.

Rather use checkout-cache to sync our tree, as should do the right thing
instead of diffing (cancel imply just blow away everything).

Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>

gitcancel.sh:  839b3c58f20f6eb8412f499a891e007e2e67d114
--- 839b3c58f20f6eb8412f499a891e007e2e67d114/gitcancel.sh
+++ uncommitted/gitcancel.sh
@@ -10,9 +10,8 @@
 #
 # Takes no arguments. Takes the evil changes from the tree.

-# FIXME: Does not revert mode changes!

-show-diff | patch -p0 -R
 rm -f .git/add-queue .git/rm-queue
+checkout-cache -q -f -a

 update-cache --refresh


--=20
Martin Schlemmer


--=-xUlQRhwo3k29yxU4/8eC
Content-Disposition: attachment; filename=git-full-cancel.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=git-full-cancel.patch; charset=UTF-8

Z2l0Y2FuY2VsLnNoOiAgODM5YjNjNThmMjBmNmViODQxMmY0OTlhODkxZTAwN2UyZTY3ZDExNA0K
LS0tIDgzOWIzYzU4ZjIwZjZlYjg0MTJmNDk5YTg5MWUwMDdlMmU2N2QxMTQvZ2l0Y2FuY2VsLnNo
DQorKysgdW5jb21taXR0ZWQvZ2l0Y2FuY2VsLnNoDQpAQCAtMTAsOSArMTAsOCBAQA0KICMNCiAj
IFRha2VzIG5vIGFyZ3VtZW50cy4gVGFrZXMgdGhlIGV2aWwgY2hhbmdlcyBmcm9tIHRoZSB0cmVl
Lg0KIA0KLSMgRklYTUU6IERvZXMgbm90IHJldmVydCBtb2RlIGNoYW5nZXMhDQogDQotc2hvdy1k
aWZmIHwgcGF0Y2ggLXAwIC1SDQogcm0gLWYgLmdpdC9hZGQtcXVldWUgLmdpdC9ybS1xdWV1ZQ0K
K2NoZWNrb3V0LWNhY2hlIC1xIC1mIC1hDQogDQogdXBkYXRlLWNhY2hlIC0tcmVmcmVzaA0K


--=-xUlQRhwo3k29yxU4/8eC--

--=-CfGmu6tmHI3k72FTNbgy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXvcSqburzKaJYLYRAtz+AKCbz3qkcrKrsdZc5VDVsfF/RuZ2vACgi6zy
WvICc/UNF42zRmamAQVpJJQ=
=MLc8
-----END PGP SIGNATURE-----

--=-CfGmu6tmHI3k72FTNbgy--

