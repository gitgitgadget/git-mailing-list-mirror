Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C12C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5A920786
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QWhF7FNr";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h/uJZL5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgKKHFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 02:05:24 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46761 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbgKKHFX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Nov 2020 02:05:23 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F12D5C0415;
        Wed, 11 Nov 2020 02:05:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 11 Nov 2020 02:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Tij9vKDh8SL/dBS6/qN7QHTusd9
        cAX8skAg0QJbvSQQ=; b=QWhF7FNrxrnSB5NGW3nDx+ogkZ7pCORmvdLmwjT8EV4
        eT9xt8zPHlC9CtmzvFtDmMoCKORDkMgmMLs/Ze4DNkdARBIHP031mTKj7e3aW0oo
        qnHqisdYMAZh/4yasw/OwNlZpafucbLPRFtJ/6EikHHeU+V6SOmSss5VLF3oxxwU
        6BrvI3bmcfUU7rhtr/Y8aiMxArLSvpZPbwowyI17rnlJGwhI6daUYGo0rNN9Kqrc
        1Uf9o/bDtYBE2it3aJuPxTtffxdKtyXX11QAml5N2ETYhx3Kz85XxSd5vJy13ESL
        Mny4HHny/GR93h5iYNPExuNn4JRTpZcjOeSuJigXgGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Tij9vK
        Dh8SL/dBS6/qN7QHTusd9cAX8skAg0QJbvSQQ=; b=h/uJZL5vbtz3IBIdtaZ+5D
        yZhAL4XQzphfdEkjRHMzvji2IPHv94XrXbn9ty1j6BrJtjj9PM7dI8LoYqP4uB2c
        yRwpvW6blRBYd62o5RKWb7mRZQKL/s0yTriQjwrha5pZZBF0CLA2fp68u1Zyk4Tj
        R/ISAzbPleQGvagY686N26d2KdzVLJcHMqJvlPvYwl08J+3IEBFAUE/GJYcwsz6B
        yEVQqRIBo2iyzuvrl+m3FqgEzMvY7ptRFEZaXOPHfNzAdN4Q1eWT0shxed9TWGrC
        DSVNWYFU6sgFN4Cc/Ii6Ixp7f281xzUcFbOrGk+6cE4Jl2tPxQ2S5QH1a5OMesNA
        ==
X-ME-Sender: <xms:Mo2rX_-oGQD_9LoxwFKg3g05de3wYicwfAVnube5Vv-G8BbhCmHAYw>
    <xme:Mo2rX7sqzE0OqRJ7v3nZd_3qR4DQH7Egc--3r71aebq4DLkvAWmywPgoC0apErz5b
    c8KPPp4Jkn-oGZ5Xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledrudegrdeivddrkeeknecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:Mo2rX9CLFhSSM3ItFhmJ7JFG-exsAnXpVfLFGGoSPiR98QP7GtogtQ>
    <xmx:Mo2rX7fT2VeSTnR9Fcp9R_ZHb1Pf9N0bHQP97bAVNwlNfqW_8lDKqw>
    <xmx:Mo2rX0NT7Tae6rV3XKfpeNQwHLiVEAE6tGd4W4RD6WcB_hdvMrGxIQ>
    <xmx:Mo2rX-VSGyV1shMbJHsMEpf1C6q6JccWTft7-0iHy1VXT7K0RDf9yg>
Received: from vm-mail.pks.im (dynamic-089-014-062-088.89.14.pool.telefonica.de [89.14.62.88])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5DF94328005D;
        Wed, 11 Nov 2020 02:05:21 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 51b8d91d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 11 Nov 2020 06:58:38 +0000 (UTC)
Date:   Wed, 11 Nov 2020 07:58:38 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH v3 1/4] t1400: avoid touching refs on filesystem
Message-ID: <e66b1bcc62139f62866dc9f25856eaebfe107056.1605077740.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605077740.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Of/RHqbzrqLYTip"
Content-Disposition: inline
In-Reply-To: <cover.1605077740.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/Of/RHqbzrqLYTip
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
 t/t1400-update-ref.sh | 72 +++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 4c01e08551..d7a57488ed 100755
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
@@ -188,27 +194,26 @@ test_expect_success "move $m (by HEAD)" '
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
-cp -f .git/HEAD .git/HEAD.orig
 test_expect_success 'delete symref without dereference' '
-	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
-	git update-ref --no-deref -d HEAD &&
-	test_path_is_missing .git/HEAD
+	git symbolic-ref SYMREF $m &&
+	git update-ref --no-deref -d SYMREF &&
+	test_must_fail git show-ref --verify -q SYMREF
 '
=20
 test_expect_success 'delete symref without dereference when the referred r=
ef is packed' '
-	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
 	echo foo >foo.c &&
 	git add foo.c &&
 	git commit -m foo &&
+	git symbolic-ref SYMREF $m &&
 	git pack-refs --all &&
-	git update-ref --no-deref -d HEAD &&
-	test_path_is_missing .git/HEAD
+	git update-ref --no-deref -d SYMREF &&
+	test_must_fail git show-ref --verify -q SYMREF
 '
=20
 git update-ref -d $m
@@ -226,25 +231,25 @@ test_expect_success 'update-ref --no-deref -d can del=
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
@@ -254,7 +259,7 @@ test_expect_success '(not) change HEAD with wrong SHA1'=
 '
 	test_must_fail git update-ref HEAD $B $Z
 '
 test_expect_success "(not) changed .git/$m" '
-	test_when_finished "rm -f .git/$m" &&
+	test_when_finished "git update-ref -d $m" &&
 	! test $B =3D $(git show-ref -s --verify $m)
 '
=20
@@ -284,8 +289,8 @@ test_expect_success 'empty directory removal' '
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
@@ -298,8 +303,8 @@ test_expect_success 'symref empty directory removal' '
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
@@ -1388,7 +1393,8 @@ test_expect_success 'handle per-worktree refs in refs=
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
@@ -1500,7 +1506,7 @@ test_expect_success 'transaction can handle abort' '
 	git update-ref --stdin <stdin >actual &&
 	printf "%s: ok\n" start abort >expect &&
 	test_cmp expect actual &&
-	test_path_is_missing .git/$b
+	test_must_fail git show-ref --verify -q $b
 '
=20
 test_expect_success 'transaction aborts by default' '
@@ -1511,7 +1517,7 @@ test_expect_success 'transaction aborts by default' '
 	git update-ref --stdin <stdin >actual &&
 	printf "%s: ok\n" start >expect &&
 	test_cmp expect actual &&
-	test_path_is_missing .git/$b
+	test_must_fail git show-ref --verify -q $b
 '
=20
 test_expect_success 'transaction with prepare aborts by default' '
@@ -1523,7 +1529,7 @@ test_expect_success 'transaction with prepare aborts =
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


--/Of/RHqbzrqLYTip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+ri50ACgkQVbJhu7ck
PpRDaw/9GuIK4nPPCdER+IQk29oT1V8foJle/kbF0w7pz8VFHw7LhRXRWfqT8PCb
aGVqXZjfp/1SY9Ct48jrgJCk3AAHY5Ix6B/Rt3NLyYyAaHdIuIyEdkl32xdd48ru
8Fr/l4kkTycP1hzzgy0cc114SZpoT90NYIhH0xv5w6E0OvJZJRrG3hiLGjZxail7
EWOzaBTfY+HlzXOvONYztQAcuod9I0QicGA0zNEcyqO9R6r7pocxynjollge16Zn
8QuuML0TZwghWViFGKQzPuWhTdw2gpYMJzvkZ448hgTbZMILzQLfX3lhxRO0b78o
b1nAv3Z45IChiwUpatm+g/wYyTVythqa8AztpojGIGucydyDRI2TFWr9vDNDzSMw
HTFi38Af9JqzwrbCs0leS7JaW8KQYaELM1NJgjK21cgOfLrDsSWjpm/Pr44LWIUy
PY8JMF4JE/0FJXWl+pmhq0NZ2tUGtQ9YzOsfq9iByN3EAX1KrEu2+uPXcnLNiNx/
I/fZu1isVV6qqbiI46NGRbAtb8Lsvoj0yVmC1FqaFh8OPUdntqS3r4ZRMG8xOjjX
9ZZt1/1CXClCzNaREmJK7Q/HYtbwJZTfhVhATCV3ytwX3ChWfLtoJWITuIPiFg8A
9dbMX9VcKAt5N0ShrjLPTYVbe5tg7vM5eeA+P9B9Ryh/xupkWDg=
=yF+F
-----END PGP SIGNATURE-----

--/Of/RHqbzrqLYTip--
