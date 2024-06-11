Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347DA16F839
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107142; cv=none; b=FGe4m7Gkj1j7mYwIRV7o+w+yqFfovAj4Hi/LkbsEZ8NJHU4kFPjHsu+btrTk40IXoSYcrqfydclpA/4WXmGAG23X2ad+65IBW9NFpO3j0dhX0RUo9ZBhXnRaweP5o46xhNlMQypysYfBl1jSP5heli6jfizcxKWC0/IhvRNKcBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107142; c=relaxed/simple;
	bh=lUEgPFOgwcGzuvI5FMkrkhQGrA77HJgs6NB2igH615A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bug5CoZzHHhg5sjo1OF+FfUOHDBsg699T8CEEgWMuiz6+qisW288I38pq66HJMWQvfN4nStmw7OjF1w+wll9W8tLNqK/UzNbk2mF9ESTLB/UdTV37n8k/ucHCB+VymIByEdAyxZEHB+Ocsr0fOdo7ic5mFZklOYTqsApyz/T6Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MeUhG9gn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UefZZ4V2; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MeUhG9gn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UefZZ4V2"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 8125B1C000EC
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:59:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 11 Jun 2024 07:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107140; x=1718193540; bh=MMdwDqJlam
	PsmbxBJHiZZprs5fff4Z2Mgt2XXUNXsr0=; b=MeUhG9gnH45Kcx7FqrvUmZkVaE
	n1o0XE3Houpoix6kKoxGMonOsFJIS4/mxcP3K26Qbznan7RqC71oZXqb1Bo1Ojas
	YQtEIsQlh0Iax0LtMtDei7eUTy9Z5/dVWJRWjqD2Y2+R1JyZSXqZlnPNpvoIPqpN
	0l5LmFJUrJ7ic5EmylvdlP/kHqomsRM4btb5NWSeWVuy7rKWejCxnGGumvVrD8Vp
	BCObsUlDGwESLVoKjP73Mr1rexE0TKbEqC7VeBoaDYLf6aUeXH1vuRnF1LqEDAJk
	U7U0DllKHJz/f+ruqHXk/A3aQnmTh6fW7Ymfgp3dt2GRI4hz/3YWU70mskPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107140; x=1718193540; bh=MMdwDqJlamPsmbxBJHiZZprs5fff
	4Z2Mgt2XXUNXsr0=; b=UefZZ4V20kHR8zgrAfTeM+0ajFA+wz/HpGb06wB8QEEF
	40ZhEkke7lhSk27xW3OeyKyl0z+AQxYcQWsedMEf9zg0FjEhOTLUaAww2w0DxeLL
	c42L9JE+zkc9lA/ASMQMiUHHoNbCNAX7Z/rbeRbN45bwZaRm6AgDLpEWnVl2gFyA
	K4tLpJd07zIYgOGTcS+2tMh5w0hF4W4SV3uWCEdnGjcgM6ScI81iHwy0/4GheMl2
	hHfFxwCiByV2h8t/bsR195G5613onOhKEtq992ka+yg56XFKvEyOBLCC8OqnC6xa
	49/jAoAgr5jcVpVUoGsZgUrSXZH5sYBlTGZ6PwkY9A==
X-ME-Sender: <xms:AzxoZpbNAjcxoOXolceX-Om19nCC-GaPm78vFRhTAt5vbYVrVl2HEA>
    <xme:AzxoZgZpJNPYKlbqgRiN_5ITMMVkLWatjY0YHu9OIJ1FHgDU-vhqaBy-k6KNXbT7n
    zj78x4ucqK20nG-HA>
X-ME-Received: <xmr:AzxoZr9zxJlPwRPh4KdYLwwFCAk_A1QCIHdnUb6RCM9pCzVsqPsKUtQNGuwMG83lKNQHQNxsJDsJuq91NXuVipMD97e2c9S9vviWmIjacLeqkDHwlKK3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:BDxoZnpOmpMbt529Oavo8lL4u5YZK6UqJh9TVlr9RwzaK3vvjqp_hg>
    <xmx:BDxoZkrK8NvA2-f0ykeaiOl49HFTLEtBkxy_86DswuRael7Qhx7syw>
    <xmx:BDxoZtQ5YyS1l8_TVvgGu4O6PrJmaTK20E50eZwAWwJi_4E9eZBoUQ>
    <xmx:BDxoZsqoQT5H-CFUduGwNv_ZoJL-pjGEo-Dl5rIDGfhIdAnGjsYoSw>
    <xmx:BDxoZhDvmhYBGSVN8YX4qdel0tdgeY7LtOU_4Ln-LiLaq61z_lWfe24F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 96ed57ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:58:49 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:58:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 18/21] t/helper: fix segfault in "oid-array" command without
 repository
Message-ID: <2774b8500fdecb0d73543dbfc5ac18c6bb8d8090.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hL20NNmF8MCMg2X4"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--hL20NNmF8MCMg2X4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "oid-array" test helper can supposedly work without a Git
repository, but will in fact crash because `the_repository->hash_algo`
is not initialized. This is because `oid_pos()`, which is used by
`oid_array_lookup()`, depends on `the_hash_algo->rawsz`.

Ideally, we'd adapt `oid_pos()` to not depend on `the_hash_algo`
anymore. That is a bigger untertaking though, so instead we fall back to
SHA1 when there is no repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-oid-array.c |  4 ++++
 t/t0064-oid-array.sh      | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
index aafe398ef0..076b849cbf 100644
--- a/t/helper/test-oid-array.c
+++ b/t/helper/test-oid-array.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "hex.h"
 #include "oid-array.h"
@@ -17,6 +19,8 @@ int cmd__oid_array(int argc UNUSED, const char **argv UNU=
SED)
 	int nongit_ok;
=20
 	setup_git_directory_gently(&nongit_ok);
+	if (nongit_ok)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
=20
 	while (strbuf_getline(&line, stdin) !=3D EOF) {
 		const char *arg;
diff --git a/t/t0064-oid-array.sh b/t/t0064-oid-array.sh
index 88c89e8f48..de74b692d0 100755
--- a/t/t0064-oid-array.sh
+++ b/t/t0064-oid-array.sh
@@ -15,6 +15,24 @@ echoid () {
 	done
 }
=20
+test_expect_success 'without repository' '
+	cat >expect <<-EOF &&
+	4444444444444444444444444444444444444444
+	5555555555555555555555555555555555555555
+	8888888888888888888888888888888888888888
+	aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
+	EOF
+	cat >input <<-EOF &&
+	append 4444444444444444444444444444444444444444
+	append 5555555555555555555555555555555555555555
+	append 8888888888888888888888888888888888888888
+	append aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
+	for_each_unique
+	EOF
+	nongit test-tool oid-array <input >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'ordered enumeration' '
 	echoid "" 44 55 88 aa >expect &&
 	{
--=20
2.45.2.436.gcd77e87115.dirty


--hL20NNmF8MCMg2X4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoO/8ACgkQVbJhu7ck
PpTaMw/9EvtDA1ZZSpuvyq29KfUdqMD2R8fUOA8jIunD8akdV0uEt0fo01xYZcBq
mdBQDPLTADxc13Vt7cAFzvQAiIX+Jk4Q+e/oOktWWxQdDm+rYANVLaG7RNoQaXvl
hRrLT1BOqEIjwQnNHzvbWwGY16GtmSjo7pmt45zk89rrGPsX9FyYebiXYvwbbA1d
alrWLf7KJFc6wmBmp6wg11r5Xs9B15vbccximGjlvX5J5DHoBmOrAeHUBevBo+lv
Fd9sUkm3AmkM+20LYZpUV7uacEdVb5WYbBKMgeVPfMpbW93iEJ/Y0mmeuEIrWKKL
ZtYIZ1I4Q1vG1ep3DpIniRB6wKbNRHy9djkqMmHMMtg7jFAAy94/8q/wnJXstUh3
73mVeu0MYjbqjACa956gt5F0sFh5vzzgYzGO4Pb6MapItrzROJz525BLaw1FEbjz
H2eWnZersIpKUwsqhOAJFnGagRjA8SAtm7uU/FVPHYqCLh7FSBt9nNTCAOYhEbjG
zKjx4ALOvKoOA98DQ7PhsDj9LBqkv4ZqrZEkP8JRFwStp1pbGnsu/eY5irjO79tl
pRK4i4IiBYS4MKURbrdbfbTcjLaHUwxAz+ZaYoHFnoeOdmHfZSN40/c/cEw8I5ty
LUXZCvw7UDwx/LCVNbhT6xcnMA0VCBo6JzI2KM0lJQZXIxUd9ec=
=Fx5D
-----END PGP SIGNATURE-----

--hL20NNmF8MCMg2X4--
