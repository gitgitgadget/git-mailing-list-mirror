Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B43CC388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 08:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A729E20936
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 08:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SoftXJuJ";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X+CCH0gE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgKMIMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 03:12:36 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49765 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgKMIMg (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Nov 2020 03:12:36 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 537485C0066;
        Fri, 13 Nov 2020 03:12:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 13 Nov 2020 03:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=jqMZZVdUzHZVPKki0+uHcWr0k77
        UKyvY0dgP84XfD7Y=; b=SoftXJuJ6nS75rzpCQheOlK2WjptXcilPf3aajv/g1C
        uMwAc3bXaYgNfcD/iwEeJGUAol2d3CmxmldZaxF1tmAfISgNX9yRC4SH+dNXM9LD
        r28vlK7uKlKI45wfocKsBFYkwPS/J1Nu+fJJFKU9fY+yHGJhsHACBrMO6vwy37Pb
        LsvP0SsfC9Ag/wj1UQq942GP2KdGt2MrlkPDi+Ll4Vdigt3edrzPEIlvGOxnZQzG
        wPJIqmhhQCLwByJgerU2YvfnFFDmFNE2+7WYnOPSPn2Se45PnU0wnN/UFVbgELdY
        uM3nPLkd0JKBTxpW/BYl5kyOYkGoK01qxSort1jhjZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jqMZZV
        dUzHZVPKki0+uHcWr0k77UKyvY0dgP84XfD7Y=; b=X+CCH0gE/nl9T8UvdEcOO0
        22UfES0X//rs6mmELfItvFxu96evvc0clzxtWObPcYcZ6D9yc73gCRGiFgeZrT3n
        XKsH3DdVXPg3AEabNc3n5YQmdcutivRhNiX21NjQqxQAnuLSU2Ou4oMLWxXymuOs
        drFC6/y9ivwd9igGsLg9RnFik37qfo83laZ9DPEdpyigGdcAwr74Ic3vTzerds+D
        Iqx2Q8mMh9zgrjEoqI/ywvGNqbiEoGc2A8ffz+XAKHtAPtXjjCaJkcpGjWFi6AX1
        EeWv9Cp1ftHPtGLp7dpdkLvZIZKvNFXZlk5U57NWYUGWK7hy8Z9iZGeF/qF1FexA
        ==
X-ME-Sender: <xms:8j-uX-bvCMaRNPNURM2Q0ju4bvwxq_yV307PnuWrQzcmnNxJ20izAQ>
    <xme:8j-uXxblVD3weu-XZy6FmZNK4fJcQPS9Zt85ZlkBzamfmb3J07yfm2MP-aAxWGX6L
    Dw3mSHw4rJIir6VJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepkeelrdduvddrfedurddvfeehnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:8j-uX4-mn55W6Ilo7cQ-sbiNk_OtVlawDSIjibTrRTASNPf9DBPm4Q>
    <xmx:8j-uXwrRVczqcz5VUCQBwiDcI6twgJ4sIjK11ToPN_qn_RSq3hTocQ>
    <xmx:8j-uX5rB1LentutBy2s8jq8Z7nxW6vZfgpEiSWFbZLfKNfjgEYRuXg>
    <xmx:8j-uX6Azris2s_rzqx94JvzTx7rWzkFvy-JGButIDnHzOCXg-xSArw>
Received: from vm-mail.pks.im (dynamic-089-012-031-235.89.12.pool.telefonica.de [89.12.31.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 71A3D3064AAE;
        Fri, 13 Nov 2020 03:12:33 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ef861b84 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 13 Nov 2020 08:12:31 +0000 (UTC)
Date:   Fri, 13 Nov 2020 09:12:31 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v4 1/4] t1400: avoid touching refs on filesystem
Message-ID: <617d48b00a13c8ef82749f0b610997625f6cf222.1605254957.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605254957.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="id0JYs85SQ5+cqr7"
Content-Disposition: inline
In-Reply-To: <cover.1605254957.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--id0JYs85SQ5+cqr7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The testcase t1400 exercises the git-update-ref(1) utility. To do so,
many tests directly read and write references via the filesystem,
assuming that we always use loose and/or packed references. While this
is true now, it'll change with the introduction of the reftable backend.

Convert those tests to use git-update-ref(1) and git-show-ref(1) where
possible. Furthermore, two tests are converted to not delete HEAD
anymore, as this results in a broken repository. They've instead been
updated to create a non-mandatory symybolic reference and delete that
one instead.

Some tests remain which exercise behaviour with broken references, which
cannot currently be converted to use regular git tooling.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1400-update-ref.sh | 77 +++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 4c01e08551..b782dafff5 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -48,17 +48,17 @@ test_expect_success "fail to delete $m with stale ref" '
 	test $B =3D "$(git show-ref -s --verify $m)"
 '
 test_expect_success "delete $m" '
-	test_when_finished "rm -f .git/$m" &&
+	test_when_finished "git update-ref -d $m" &&
 	git update-ref -d $m $B &&
-	test_path_is_missing .git/$m
+	test_must_fail git show-ref --verify -q $m
 '
=20
 test_expect_success "delete $m without oldvalue verification" '
-	test_when_finished "rm -f .git/$m" &&
+	test_when_finished "git update-ref -d $m" &&
 	git update-ref $m $A &&
 	test $A =3D $(git show-ref -s --verify $m) &&
 	git update-ref -d $m &&
-	test_path_is_missing .git/$m
+	test_must_fail git show-ref --verify -q $m
 '
=20
 test_expect_success "fail to create $n" '
@@ -80,26 +80,26 @@ test_expect_success "fail to delete $m (by HEAD) with s=
tale ref" '
 	test $B =3D $(git show-ref -s --verify $m)
 '
 test_expect_success "delete $m (by HEAD)" '
-	test_when_finished "rm -f .git/$m" &&
+	test_when_finished "git update-ref -d $m" &&
 	git update-ref -d HEAD $B &&
-	test_path_is_missing .git/$m
+	test_must_fail git show-ref --verify -q $m
 '
=20
 test_expect_success "deleting current branch adds message to HEAD's log" '
-	test_when_finished "rm -f .git/$m" &&
+	test_when_finished "git update-ref -d $m" &&
 	git update-ref $m $A &&
 	git symbolic-ref HEAD $m &&
 	git update-ref -m delete-$m -d $m &&
-	test_path_is_missing .git/$m &&
+	test_must_fail git show-ref --verify -q $m &&
 	grep "delete-$m$" .git/logs/HEAD
 '
=20
 test_expect_success "deleting by HEAD adds message to HEAD's log" '
-	test_when_finished "rm -f .git/$m" &&
+	test_when_finished "git update-ref -d $m" &&
 	git update-ref $m $A &&
 	git symbolic-ref HEAD $m &&
 	git update-ref -m delete-by-head -d HEAD &&
-	test_path_is_missing .git/$m &&
+	test_must_fail git show-ref --verify -q $m &&
 	grep "delete-by-head$" .git/logs/HEAD
 '
=20
@@ -188,31 +188,37 @@ test_expect_success "move $m (by HEAD)" '
 	test $B =3D $(git show-ref -s --verify $m)
 '
 test_expect_success "delete $m (by HEAD) should remove both packed and loo=
se $m" '
-	test_when_finished "rm -f .git/$m" &&
+	test_when_finished "git update-ref -d $m" &&
 	git update-ref -d HEAD $B &&
 	! grep "$m" .git/packed-refs &&
-	test_path_is_missing .git/$m
+	test_must_fail git show-ref --verify -q $m
 '
=20
-cp -f .git/HEAD .git/HEAD.orig
 test_expect_success 'delete symref without dereference' '
-	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
-	git update-ref --no-deref -d HEAD &&
-	test_path_is_missing .git/HEAD
+	test_when_finished "git update-ref -d $m" &&
+	echo foo >foo.c &&
+	git add foo.c &&
+	git commit -m foo &&
+	git symbolic-ref SYMREF $m &&
+	git update-ref --no-deref -d SYMREF &&
+	git show-ref --verify -q $m &&
+	test_must_fail git show-ref --verify -q SYMREF &&
+	test_must_fail git symbolic-ref SYMREF
 '
=20
 test_expect_success 'delete symref without dereference when the referred r=
ef is packed' '
-	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
+	test_when_finished "git update-ref -d $m" &&
 	echo foo >foo.c &&
 	git add foo.c &&
 	git commit -m foo &&
+	git symbolic-ref SYMREF $m &&
 	git pack-refs --all &&
-	git update-ref --no-deref -d HEAD &&
-	test_path_is_missing .git/HEAD
+	git update-ref --no-deref -d SYMREF &&
+	git show-ref --verify -q $m &&
+	test_must_fail git show-ref --verify -q SYMREF &&
+	test_must_fail git symbolic-ref SYMREF
 '
=20
-git update-ref -d $m
-
 test_expect_success 'update-ref -d is not confused by self-reference' '
 	git symbolic-ref refs/heads/self refs/heads/self &&
 	test_when_finished "rm -f .git/refs/heads/self" &&
@@ -226,25 +232,25 @@ test_expect_success 'update-ref --no-deref -d can del=
ete self-reference' '
 	test_when_finished "rm -f .git/refs/heads/self" &&
 	test_path_is_file .git/refs/heads/self &&
 	git update-ref --no-deref -d refs/heads/self &&
-	test_path_is_missing .git/refs/heads/self
+	test_must_fail git show-ref --verify -q refs/heads/self
 '
=20
 test_expect_success 'update-ref --no-deref -d can delete reference to bad =
ref' '
 	>.git/refs/heads/bad &&
 	test_when_finished "rm -f .git/refs/heads/bad" &&
 	git symbolic-ref refs/heads/ref-to-bad refs/heads/bad &&
-	test_when_finished "rm -f .git/refs/heads/ref-to-bad" &&
+	test_when_finished "git update-ref -d refs/heads/ref-to-bad" &&
 	test_path_is_file .git/refs/heads/ref-to-bad &&
 	git update-ref --no-deref -d refs/heads/ref-to-bad &&
-	test_path_is_missing .git/refs/heads/ref-to-bad
+	test_must_fail git show-ref --verify -q refs/heads/ref-to-bad
 '
=20
 test_expect_success '(not) create HEAD with old sha1' '
 	test_must_fail git update-ref HEAD $A $B
 '
 test_expect_success "(not) prior created .git/$m" '
-	test_when_finished "rm -f .git/$m" &&
-	test_path_is_missing .git/$m
+	test_when_finished "git update-ref -d $m" &&
+	test_must_fail git show-ref --verify -q $m
 '
=20
 test_expect_success 'create HEAD' '
@@ -254,7 +260,7 @@ test_expect_success '(not) change HEAD with wrong SHA1'=
 '
 	test_must_fail git update-ref HEAD $B $Z
 '
 test_expect_success "(not) changed .git/$m" '
-	test_when_finished "rm -f .git/$m" &&
+	test_when_finished "git update-ref -d $m" &&
 	! test $B =3D $(git show-ref -s --verify $m)
 '
=20
@@ -284,8 +290,8 @@ test_expect_success 'empty directory removal' '
 	test_path_is_file .git/refs/heads/d1/d2/r1 &&
 	test_path_is_file .git/logs/refs/heads/d1/d2/r1 &&
 	git branch -d d1/d2/r1 &&
-	test_path_is_missing .git/refs/heads/d1/d2 &&
-	test_path_is_missing .git/logs/refs/heads/d1/d2 &&
+	test_must_fail git show-ref --verify -q refs/heads/d1/d2 &&
+	test_must_fail git show-ref --verify -q logs/refs/heads/d1/d2 &&
 	test_path_is_file .git/refs/heads/d1/r2 &&
 	test_path_is_file .git/logs/refs/heads/d1/r2
 '
@@ -298,8 +304,8 @@ test_expect_success 'symref empty directory removal' '
 	test_path_is_file .git/refs/heads/e1/e2/r1 &&
 	test_path_is_file .git/logs/refs/heads/e1/e2/r1 &&
 	git update-ref -d HEAD &&
-	test_path_is_missing .git/refs/heads/e1/e2 &&
-	test_path_is_missing .git/logs/refs/heads/e1/e2 &&
+	test_must_fail git show-ref --verify -q refs/heads/e1/e2 &&
+	test_must_fail git show-ref --verify -q logs/refs/heads/e1/e2 &&
 	test_path_is_file .git/refs/heads/e1/r2 &&
 	test_path_is_file .git/logs/refs/heads/e1/r2 &&
 	test_path_is_file .git/logs/HEAD
@@ -1388,7 +1394,8 @@ test_expect_success 'handle per-worktree refs in refs=
/bisect' '
 		git rev-parse refs/bisect/something >../worktree-head &&
 		git for-each-ref | grep refs/bisect/something
 	) &&
-	test_path_is_missing .git/refs/bisect &&
+	git show-ref >actual &&
+	! grep 'refs/bisect' actual &&
 	test_must_fail git rev-parse refs/bisect/something &&
 	git update-ref refs/bisect/something HEAD &&
 	git rev-parse refs/bisect/something >main-head &&
@@ -1500,7 +1507,7 @@ test_expect_success 'transaction can handle abort' '
 	git update-ref --stdin <stdin >actual &&
 	printf "%s: ok\n" start abort >expect &&
 	test_cmp expect actual &&
-	test_path_is_missing .git/$b
+	test_must_fail git show-ref --verify -q $b
 '
=20
 test_expect_success 'transaction aborts by default' '
@@ -1511,7 +1518,7 @@ test_expect_success 'transaction aborts by default' '
 	git update-ref --stdin <stdin >actual &&
 	printf "%s: ok\n" start >expect &&
 	test_cmp expect actual &&
-	test_path_is_missing .git/$b
+	test_must_fail git show-ref --verify -q $b
 '
=20
 test_expect_success 'transaction with prepare aborts by default' '
@@ -1523,7 +1530,7 @@ test_expect_success 'transaction with prepare aborts =
by default' '
 	git update-ref --stdin <stdin >actual &&
 	printf "%s: ok\n" start prepare >expect &&
 	test_cmp expect actual &&
-	test_path_is_missing .git/$b
+	test_must_fail git show-ref --verify -q $b
 '
=20
 test_done
--=20
2.29.2


--id0JYs85SQ5+cqr7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+uP+4ACgkQVbJhu7ck
PpQxGw//XLi984Ck/4LwIy38Zb+pqgTSi4pCT6Q70oajcJjplKtaaQ/Oo7mGKynd
EmQm3Iwvsozgo0AFFLVWAAjh36MqBkVsHMtiNSAwPEiFiOiTyVaZY8k/dPd3PzYs
Gn8zzYVPEZHD/vUoMhpkZr89Um9o68MgFJtda9yXvKMSZZhaO5WJzE+wQIVEXzxX
OQGumpokWiK9Es5GNKNisx4kqtaA9sWJb1lD80bXFlHDDNjs9YuJUu80qTxgdR8D
a9dL3HBoihWGbwwGziBLFk6olWESJCCS9ntFs1rP9pDt47ZEjCaL8onsvUKzxhKB
gkjfzmmB7eeCJIHF+J0XLPE3QAmh6VWevNBHbJ24/rcCEqrkpZXt/GOkkrg1MW08
EaD9ub8a7DrT1rOfK1bLsDwwFqmW6Ctk/W8QyzIGDGVVE/fyjb3VS6iUhRpi+yFF
YXZryh544SE8x6376aQggw2Kjo1iWQmPgNU4La3GAstNz8hnW/RJm+jv4KYsi6+w
P9ngTXXgRm4ogR0qnSkHxy8Fawqvvx8+KioyNnp5ZXkVPDpdyyM5N9qNldjvi7ny
SfLUJRRfczZVtC3Hj2FEypKGJpCaTbZnJwaF/PL7+XBzgLSAIYng2oBRH07x/VL4
olO37dFGbesOLbu6SXWcUiDNfFgx2vxKE547nypMxd2l95viBuk=
=hfsK
-----END PGP SIGNATURE-----

--id0JYs85SQ5+cqr7--
