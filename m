From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: [patch pasky] update gitcancel.sh to handle modes as well
Date: Fri, 15 Apr 2005 00:57:25 +0200
Message-ID: <1113519445.23299.119.camel@nosferatu.lan>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-z1dbUpIu1ZdrbZG3UveD"
Content-Transfer-Encoding: 8bit
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:51:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMDBX-0002l3-70
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 00:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVDNWyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 18:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVDNWyy
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 18:54:54 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:62861 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S261624AbVDNWxj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 18:53:39 -0400
Received: from gateway.lan (wblv-146-239-208.telkomadsl.co.za [165.146.239.208])
	by ctb-mesg5.saix.net (Postfix) with ESMTP id AEC9E6AFC;
	Fri, 15 Apr 2005 00:53:34 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id E93B53A26DB;
	Fri, 15 Apr 2005 00:59:39 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22199-20; Fri, 15 Apr 2005 00:59:36 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 159BC3A26DA;
	Fri, 15 Apr 2005 00:59:36 +0200 (SAST)
To: GIT Mailing Lists <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-z1dbUpIu1ZdrbZG3UveD
Content-Type: multipart/mixed; boundary="=-jgIRZSIRwfkLzT62etnJ"


--=-jgIRZSIRwfkLzT62etnJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

gitcancel.sh do not handle mode changes:

----
$ chmod -x Makefile
$ git cancel
patch: **** Only garbage was found in the patch input.
----

Rather use checkout-cache to sync our tree, as should do the right thing
instead of diffing (cancel imply just blow away everything).

Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>

gittrack.sh:  03d6db1fb3a70605ef249c632c04e542457f0808
--- 03d6db1fb3a70605ef249c632c04e542457f0808/gittrack.sh
+++ uncommitted/gittrack.sh
@@ -51,6 +51,7 @@

        read-tree $(tree-id "$name")
        gitdiff.sh local "$name" | gitapply.sh
+       update-cache --refresh

 else
        [ "$tracking" ] || \
@@ -61,6 +62,7 @@
        if [ -s ".git/HEAD.local" ]; then
                gitdiff.sh "$tracking" local | gitapply.sh
                read-tree $(tree-id local)
+               update-cache --refresh

                head=3D$(cat .git/HEAD)
                branchhead=3D$(cat .git/heads/$tracking)


--=20
Martin Schlemmer


--=-jgIRZSIRwfkLzT62etnJ
Content-Disposition: attachment; filename=git-track-update_cache.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=git-track-update_cache.patch; charset=UTF-8

Z2l0dHJhY2suc2g6ICAwM2Q2ZGIxZmIzYTcwNjA1ZWYyNDljNjMyYzA0ZTU0MjQ1N2YwODA4DQot
LS0gMDNkNmRiMWZiM2E3MDYwNWVmMjQ5YzYzMmMwNGU1NDI0NTdmMDgwOC9naXR0cmFjay5zaA0K
KysrIHVuY29tbWl0dGVkL2dpdHRyYWNrLnNoDQpAQCAtNTEsNiArNTEsNyBAQA0KIA0KIAlyZWFk
LXRyZWUgJCh0cmVlLWlkICIkbmFtZSIpDQogCWdpdGRpZmYuc2ggbG9jYWwgIiRuYW1lIiB8IGdp
dGFwcGx5LnNoDQorCXVwZGF0ZS1jYWNoZSAtLXJlZnJlc2gNCiANCiBlbHNlDQogCVsgIiR0cmFj
a2luZyIgXSB8fCBcDQpAQCAtNjEsNiArNjIsNyBAQA0KIAlpZiBbIC1zICIuZ2l0L0hFQUQubG9j
YWwiIF07IHRoZW4NCiAJCWdpdGRpZmYuc2ggIiR0cmFja2luZyIgbG9jYWwgfCBnaXRhcHBseS5z
aA0KIAkJcmVhZC10cmVlICQodHJlZS1pZCBsb2NhbCkNCisJCXVwZGF0ZS1jYWNoZSAtLXJlZnJl
c2gNCiANCiAJCWhlYWQ9JChjYXQgLmdpdC9IRUFEKQ0KIAkJYnJhbmNoaGVhZD0kKGNhdCAuZ2l0
L2hlYWRzLyR0cmFja2luZykNCg==


--=-jgIRZSIRwfkLzT62etnJ--

--=-z1dbUpIu1ZdrbZG3UveD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXvVUqburzKaJYLYRAoabAKCWHuqskVXrt6tfoxDLa6RI2Sjd1wCfSgRF
tGAXcgB4MDJVRzm+7ookAMw=
=cpOG
-----END PGP SIGNATURE-----

--=-z1dbUpIu1ZdrbZG3UveD--

