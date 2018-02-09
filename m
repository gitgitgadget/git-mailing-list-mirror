Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF10B1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 15:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeBIPIg (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 10:08:36 -0500
Received: from fidel.majic.rs ([139.162.212.233]:42404 "EHLO fidel.majic.rs"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751371AbeBIPIg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 10:08:36 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Feb 2018 10:08:35 EST
Received: from majic.rs (c83-250-148-196.bredband.comhem.se [83.250.148.196])
        by fidel.majic.rs (Postfix) with ESMTPSA id 16F111ACE35
        for <git@vger.kernel.org>; Fri,  9 Feb 2018 16:02:05 +0100 (CET)
Date:   Fri, 9 Feb 2018 16:01:47 +0100
From:   Branko Majic <branko@majic.rs>
To:     git@vger.kernel.org
Subject: [BUG] Integer overflow when supplying large context value to  diff
 --unified
Message-ID: <20180209160147.3f54a362@majic.rs>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.YcWJJ/Z92wUzOM1VS1+86L"; protocol="application/pgp-signature"
X-Virus-Scanned: clamav-milter 0.99.3 at fidel
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/.YcWJJ/Z92wUzOM1VS1+86L
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

Git versions tested: 2.13.6, 2.1.4

When passing-in a large context value for the --unified option for
git-diff, Git will produce an invalid-looking range information for
hunks.

For example, if running 'git diff --unified=3D10 HEAD^', the output will
include (this is just a run against my local git repo):

@@ -42,23 +42,23 @@ master_doc =3D 'index'

Note the numbers for denoting begin/end line etc "look fine"(they're
within the expected numeric range).

Now, if we pass on a big value to it (2 to the power of 32 divided by 2,
e.g. enough so that signed long int can't hold it without overflowing),
e.g. 'git diff --unified=3D2147483648 HEAD^', the output will include
(again, just a sample):

@@ -2147483700,4294967295- +2147483700,4294967295- @@

Note that the begin/end line numbers are way out of range. The diff
itself will actually contain no context lines.

Best regards

--=20
Branko Majic
XMPP: branko@majic.rs
Please use only Free formats when sending attachments to me.

=D0=91=D1=80=D0=B0=D0=BD=D0=BA=D0=BE =D0=9C=D0=B0=D1=98=D0=B8=D1=9B
XMPP: branko@majic.rs
=D0=9C=D0=BE=D0=BB=D0=B8=D0=BC =D0=B2=D0=B0=D1=81 =D0=B4=D0=B0 =D0=B4=D0=BE=
=D0=B4=D0=B0=D1=82=D0=BA=D0=B5 =D1=88=D0=B0=D1=99=D0=B5=D1=82=D0=B5 =D0=B8=
=D1=81=D0=BA=D1=99=D1=83=D1=87=D0=B8=D0=B2=D0=BE =D1=83 =D1=81=D0=BB=D0=BE=
=D0=B1=D0=BE=D0=B4=D0=BD=D0=B8=D0=BC =D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=82=
=D0=B8=D0=BC=D0=B0.

--Sig_/.YcWJJ/Z92wUzOM1VS1+86L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYw8GxufDH1PY4FV1K0alpgdqZrEFAlp9t9wACgkQK0alpgdq
ZrHkbxAAnzn5L2LHTH8AUk/SrRI3ugeVnA2u9nYgzgnozBthU5dHYoxWxzzK3Ypl
bceX5z8tIHzyGACEHLDp4SmurXngRpWCUrZPVj2cssDtkkrbFKAT6sJBKSWgv7lT
wLUt0XOdzuGYESyfz+VfKIe+AteZXVNZhCBuAE/BftxHluPsYGwbQlt5mXkZ+gXQ
qm5i6d3dnIYUv5X45YeZMIB8nguiLBBS+0eWKqYoQw2pVZeM7XyK3wlTOs7+dC+f
EDeu7oGBKMpl2qNABukUzVKK4AGQ3RyJOlM7jY+kXozZHa8SfidfekfUhAWnEb4C
9QoD+1J+yPtpgGykN84kYF4Qqr+eft5IQzl2JOpDSfNc5R/7FtE1l5tYcMHBILiW
zS0mRL1hx4u9sDcafTMYCzFtzOcK3xYSwdIrso+KosvFE+6tb9jc7x/rgo5LZXi5
t75yu6Z+RBQZPaw7hSzVcbLxgXfrtV4c6pvueDri3jvfWEQiM0WJ6VIyScinIevH
bEAz1lQtEKsoMAkCSwGW5tfLcWEL+LcfE5E0SKyJr9xdMtw9lBcYXCwgrOFFx0ZF
wyEgmnN0yyKL5f1KpuOyuxcRJXqDb7FFyEb9FpA2erIIzHXG2U/JreBHqqt4hi+6
X4LHvi6ePe475EQiNjmRuuA5n0KchpqB1Q709HMHK423sDvB+nk=
=riaJ
-----END PGP SIGNATURE-----

--Sig_/.YcWJJ/Z92wUzOM1VS1+86L--
