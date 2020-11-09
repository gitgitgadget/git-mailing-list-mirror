Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30679C55ABD
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 10:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C73C20663
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 10:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hAMJ4ObQ";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TkcBEbgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgKIKGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 05:06:52 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:36371 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728979AbgKIKGw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Nov 2020 05:06:52 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 03C3E1216;
        Mon,  9 Nov 2020 05:06:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 09 Nov 2020 05:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=/PLGnEf/Ltjo46XX0EdQa1rQe8d
        radqHAGH5LrIJy6A=; b=hAMJ4ObQdMe6i0rqQIojQ1mnPWe/lRUu03GMn1L8Zha
        C/2XFotRuifj26g6Hr6svVnnjlvZLA0waVamXBrTwzKm31irS0MGLRbtIPzhC55k
        bO1XzwE79FEKNA5MGZSjog344QlvrbywDnHkxNPMUn6Md5aRZMdp8nlPung7ktyG
        y2peous7UyAnmT5of0L8YdyE5w6iZWpzvoINZ91e6rRMSQGsfWjJo7VRHQa16Eqd
        KyeZHfmX4u3gmvnMELQDT671+uqODm6mFkpR4ZM6aYE3H+OvT7s4MkXsCymc2BTE
        EJyJICu0jCOeBfjOvJv4Q/qZporS/zIUJFghY2C7Rog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/PLGnE
        f/Ltjo46XX0EdQa1rQe8dradqHAGH5LrIJy6A=; b=TkcBEbgKtIXIRMmsatAtMq
        L0yXbSDR0D6Gpu9Sl7S0K+8XfYAESX1nFsPU4GH6zzSqMpv5PBzB4xqtLat8sV9n
        aj9Xqu/nB1ADRKk5IxvBd8JFa7ZFf+xfk1YbI2olzJJrnh3hS/SqkwJlkgxhEgf3
        WSf/nNH+mDdM9y2U1jBMEtOMnlnkOkuyAi0YptEr/sSsx6hfJapNdX+DYuFQ4hKo
        atEbNJp0/Eptd+udFFrqe00YLteJ18Nz7oxriRwAympHAuWM/NjZ20IkYsUMIrAW
        2e2eV15RtSW/WEyL7lXsQA50E3Bm/zdckJT2dSE+DOFhr4nKHJ8eA2z9STJnCvyQ
        ==
X-ME-Sender: <xms:uhSpX46pBTYUhJP1y-uYvbd0BIbBpft-hnqwQXh1Sx92hVJcK2sM1w>
    <xme:uhSpX57hnNF47nKm0bvGVmm5C2-XhwRbPQNfy9k6tMiGXgB1S0EmHtIVT73DjMs6X
    vZwiGpU29u-nksSWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledruddvrdegledrvdduleenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:uhSpX3dciCuhU-Hfzb_Dnvnme1M1Xw7vgZKcTHnIbWgPMYx-d0i5pw>
    <xmx:uhSpX9K0ucC1aftSVkMnTikNd7316yDX8DrLFxVpJiO4-XIq88jKZA>
    <xmx:uhSpX8JtYvEfnkrc1C_DpnPfxEch_CZfzUGMvWAqFh0qj4Mw-T_3xQ>
    <xmx:uhSpX2zxgbwre9qwX_-b5hrgBt6VdbhBtoZ-D5-4NAyYOIQPs4DN9A>
Received: from vm-mail.pks.im (dynamic-089-012-049-219.89.12.pool.telefonica.de [89.12.49.219])
        by mail.messagingengine.com (Postfix) with ESMTPA id E62A13063081;
        Mon,  9 Nov 2020 05:06:49 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id fb444a53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Nov 2020 10:06:49 +0000 (UTC)
Date:   Mon, 9 Nov 2020 11:06:47 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH v2 1/4] t1400: Avoid touching refs on filesystem
Message-ID: <9b49e849eaf6786c63016d767d2ad56112d08d51.1604908834.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1604908834.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <cover.1604908834.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The testcase t1400 exercises the git-update-ref(1) utility. To do so,
many tests directly read and write references via the filesystem,
assuming that we always use loose and/or packed references. While this
is true now, it'll change with the introduction of the reftable backend.

Convert those tests to use git-update-ref(1) and git-show-ref(1) where
possible. As some tests exercise behaviour with broken references and
neither of those tools actually allows writing or reading broken
references, this commit doesn't adjust all tests.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1400-update-ref.sh | 63 ++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 4c01e08551..957bef272d 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -14,6 +14,12 @@ n=3D$n_dir/fixes
 outside=3Drefs/foo
 bare=3Dbare-repo
=20
+# Some of the tests delete HEAD, which causes us to not treat the current
+# working directory as a Git repository anymore. To avoid using any potent=
ial
+# parent repository to be discovered, we need to set up the ceiling direct=
ories.
+GIT_CEILING_DIRECTORIES=3D"$PWD/.."
+export GIT_CEILING_DIRECTORIES
+
 create_test_commits ()
 {
 	prfx=3D"$1"
@@ -48,17 +54,17 @@ test_expect_success "fail to delete $m with stale ref" '
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
@@ -80,26 +86,26 @@ test_expect_success "fail to delete $m (by HEAD) with s=
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
@@ -188,17 +194,17 @@ test_expect_success "move $m (by HEAD)" '
 	test $B =3D $(git show-ref -s --verify $m)
 '
 test_expect_success "delete $m (by HEAD) should remove both packed and loo=
se $m" '
-	test_when_finished "rm -f .git/$m" &&
+	test_when_finished "rm -f git update-ref -d $m" &&
 	git update-ref -d HEAD $B &&
 	! grep "$m" .git/packed-refs &&
-	test_path_is_missing .git/$m
+	test_must_fail git show-ref --verify -q $m
 '
=20
 cp -f .git/HEAD .git/HEAD.orig
 test_expect_success 'delete symref without dereference' '
 	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
 	git update-ref --no-deref -d HEAD &&
-	test_path_is_missing .git/HEAD
+	test_must_fail git show-ref --verify -q HEAD
 '
=20
 test_expect_success 'delete symref without dereference when the referred r=
ef is packed' '
@@ -208,7 +214,7 @@ test_expect_success 'delete symref without dereference =
when the referred ref is
 	git commit -m foo &&
 	git pack-refs --all &&
 	git update-ref --no-deref -d HEAD &&
-	test_path_is_missing .git/HEAD
+	test_must_fail git show-ref --verify -q HEAD
 '
=20
 git update-ref -d $m
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


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+pFLcACgkQVbJhu7ck
PpREUQ/+PDId5QbsPuWP1QPQJdQuwK34CAbe/OSFfN1jwizJ3MiONVVymzus+HpS
6ojAUKhm1f2h0hoSqXjFl2Ogp4ojqjMb1BzYan5Fc3wBijuKcYdb2VmYvsgPDLVx
avHjYLr0CVHihdfXWJBnteVYEnYidP4u2Efq0KDT00K14xTeUZOvb45euRKlWgzG
w/o65Z1kdHcHFCl3qnyg3R1we82HJTP2WANZRrFFr7JJIjnTfbFAtZLU8bOOrjCb
f4WkDYq1JpbowI9NObXNqRosRLwJi7Es6GBN12qWlnwBjlCf9M/NO95x7XtgobcU
QQ7wa3UO4NH2WG2R+TnltMDRJ28Sq6ZhWQO2cHnf/v+4hrKkQ364TEhBEXTm58KC
Oqy1llFfgp8SGCKgRhm28HNYfuRVaSUUzXvOTuhpZUwx6pHDg9DCdBucNVt31iF/
U4Jd4Lb6nFczBJEL87f7yM8G/HoLDB/GhjsjiRVXovX9N+dAHq37RWWTl2iGi0Jr
G18t1bhwh/oev8NHuyFdzcNlLJw3UAYfqcHbc1uI0UmL4URMmWm5ALFzbELUusDT
O62zAF4U5vQQpZ1q2OEN9pIxqcxwaBiTkmPNmOJMqE5rKdhU7oWNf23/GhcqR7UP
TA24DwgcWdL6zziCp3A2acmMuYXvcr9VMfEmb6qPRgJZU6ibiks=
=W0y4
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
