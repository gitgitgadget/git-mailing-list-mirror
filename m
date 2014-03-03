From: Max Horn <max@quendi.de>
Subject: Re: [PATCH V2] commit.c: Use skip_prefix() instead of starts_with()
Date: Mon, 3 Mar 2014 23:59:20 +0100
Message-ID: <176A3D83-AFFB-4EF4-A1CB-3A953F692166@quendi.de>
References: <1393862398-2989-1-git-send-email-tanayabh@gmail.com> <xmqqiorvoyoo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_85E49313-5AC6-44C2-9A53-5708160A414E"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:59:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbpb-0003nB-7B
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287AbaCCW71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:59:27 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:52121 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755005AbaCCW70 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 17:59:26 -0500
Received: from hsi-kbw-46-223-222-244.hsi.kabel-badenwuerttemberg.de ([46.223.222.244] helo=[192.168.50.103]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WKbpU-000894-DV; Mon, 03 Mar 2014 23:59:24 +0100
In-Reply-To: <xmqqiorvoyoo.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1393887566;0d456562;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243299>


--Apple-Mail=_85E49313-5AC6-44C2-9A53-5708160A414E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 03.03.2014, at 20:43, Junio C Hamano <gitster@pobox.com> wrote:

> Tanay Abhra <tanayabh@gmail.com> writes:
>=20
>> @@ -1193,9 +1194,9 @@ static void parse_gpg_output(struct =
signature_check *sigc)
>> 	for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>> 		const char *found, *next;
>>=20
>> -		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) =
{
>> +		if (found =3D skip_prefix(buf, =
sigcheck_gpg_status[i].check + 1)) {
>> 			/* At the very beginning of the buffer */
>> -			found =3D buf + =
strlen(sigcheck_gpg_status[i].check + 1);
>> +			;
>> 		} else {
>> 			found =3D strstr(buf, =
sigcheck_gpg_status[i].check);
>> 			if (!found)
>=20
> This hunk looks good.  It can be a separate patch but they are both
> minor changes so it is OK to have it in a single patch.

Hm, but that hunk also introduces an assignment in a conditional, and =
introduces an empty block. Maybe like this?


diff --git a/commit.c b/commit.c
index 6bf4fe0..0ee0725 100644
--- a/commit.c
+++ b/commit.c
@@ -1193,10 +1193,8 @@ static void parse_gpg_output(struct =
signature_check *sigc)
        for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
                const char *found, *next;

-               if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) =
{
-                       /* At the very beginning of the buffer */
-                       found =3D buf + =
strlen(sigcheck_gpg_status[i].check + 1);
-               } else {
+               found =3D skip_prefix(buf, sigcheck_gpg_status[i].check =
+ 1);
+               if (!found) {
                        found =3D strstr(buf, =
sigcheck_gpg_status[i].check);
                        if (!found)
                                continue;



--Apple-Mail=_85E49313-5AC6-44C2-9A53-5708160A414E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlMVCUwACgkQIpJVslrhe1l27AD9EuLemwKnmaTF/1sNWdzqtgZI
0CZZveEZnEe3E7MSl3IA/2ooC7HMm8aBajvt9pOgstRnU7CGz5XyRBGqfNSKwUbD
=yaWL
-----END PGP SIGNATURE-----

--Apple-Mail=_85E49313-5AC6-44C2-9A53-5708160A414E--
