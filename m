Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459AC2095D
	for <e@80x24.org>; Wed, 22 Mar 2017 18:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759269AbdCVSqt (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 14:46:49 -0400
Received: from lb3-smtp-cloud2.xs4all.net ([194.109.24.29]:45593 "EHLO
        lb3-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751109AbdCVSqr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Mar 2017 14:46:47 -0400
Received: from mail.digitalbrains.com ([IPv6:2001:980:a370::3])
        by smtp-cloud2.xs4all.net with ESMTP
        id z6mj1u00J3J12Pc016mkya; Wed, 22 Mar 2017 19:46:45 +0100
Received: from terrence.tun.lucas.digitalbrains.com ([2001:610:6ef:7001::2])
        by mail.digitalbrains.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <peter@digitalbrains.com>)
        id 1cqlHP-0007Gj-47; Wed, 22 Mar 2017 19:46:43 +0100
Subject: Re: Stable GnuPG interface, git should use GPGME
To:     "Bernhard E. Reiter" <bernhard.reiter@intevation.de>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        gnupg-devel@gnupg.org, Lukas Puehringer <luk.puehringer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <201703101100.15214.bernhard.reiter@intevation.de>
 <201703131350.00139.bernhard.reiter@intevation.de>
 <13c66211-9671-5bd3-f3eb-96ffd5c39975@drmicha.warpmail.net>
 <201703171056.10468.bernhard.reiter@intevation.de>
 <87poh9p70n.fsf@wheatstone.g10code.de>
From:   Peter Lebbing <peter@digitalbrains.com>
Openpgp: id=8FA94E79AD6AB56EE38CE5CBAC46EFE6DE500B3E;
 url=http://digitalbrains.com/2012/openpgp-key-peter
X-Enigmail-Draft-Status: N1110
Message-ID: <bec6098f-3016-0a41-02b0-a4e541a66bc4@digitalbrains.com>
Date:   Wed, 22 Mar 2017 19:46:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <87poh9p70n.fsf@wheatstone.g10code.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="A3jsQsAeFFrilRldNc7TTicPWEabSrLsS"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A3jsQsAeFFrilRldNc7TTicPWEabSrLsS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22/03/17 18:15, Werner Koch wrote:
> It actually does.  For the tasks git uses gpg you should not notice a
> difference in gpgme between any of these versions.

Bernhard wrote "interoperability problems between [...] key stores". I'm
under the impression you are actually answering the question "can GPGME
be used in the same way regardless of the GnuPG version" instead?

> Interoperability with 1.4 is a bit cumbersome if you often add new keys=
=2E
> However, "gpg --export | gpg1 --import" is not too complicated.=20

This presumes that

1) Keys are only updated on the 2.1 side
2) Keys are not deleted
3) Secret keys are never changed

right?

1) is trivially solvable. 2) is trickier, but can be done.

3) is because GnuPG 1.4 cannot update a secret key at all. Adding a new
subkey fails with:

gpg: key DCDFDFA4: already in secret keyring
gpg: Total number processed: 1
gpg:       secret keys read: 1
gpg:  secret keys unchanged: 1

You could delete before re-importing, but what if the key on the 1.4
side is actually the newer one? You'd lose all changes. Worst case:
updates of a single key on both sides. But that is perhaps pushing the
limit of sane use. Perhaps not, perhaps the user likes to use two
different frontends which use different GnuPG versions as their backend.

Luckily, expiration extensions are picked up by just transferring the
public key part of a secret key, so that does work.

Peter.

--=20
I use the GNU Privacy Guard (GnuPG) in combination with Enigmail.
You can send me encrypted mail if you want some privacy.
My key is available at <http://digitalbrains.com/2012/openpgp-key-peter>


--A3jsQsAeFFrilRldNc7TTicPWEabSrLsS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEZQCNwiCq4qJXTWzVlp4Bj95s3KEFAljSxoQACgkQlp4Bj95s
3KEw1Af/So3H/ASlV/1jj8MBh0BJbs1evPM2ppkPaUIMYsB4PfVahtiJLjxm4Yzj
9oNMooB0cLqgUg0zs9A44ICbo49PNbzY8PLAofWSCEbjeyaixzT1zSfcB4lk95Fd
zQSMFTw3sxLJJnwZeUA66pagIhmdygHsYgr/cy4LmFzxXVs3XVExCYNq44FFrbr1
wrizjGbJT6X6ZmRNjSQRx6KVNwIoyEcALSvpVGU6gJIjd+Jx6Kw/LVMoS7ltteQs
u8yY8muw/jMMZq1Jk0yPqR1K7bj6733UANtX2i55QZfDZIacP4+XG1ESLzDEz3oJ
V01FYEyonbMDdZoPAspT0pHgrNk7pg==
=n6Wo
-----END PGP SIGNATURE-----

--A3jsQsAeFFrilRldNc7TTicPWEabSrLsS--
