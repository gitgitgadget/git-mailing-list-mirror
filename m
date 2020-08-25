Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45B9C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 10:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A4520715
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 10:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="McgYsLHC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nbuV07TV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgHYKff (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:35:35 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:55195 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729797AbgHYKfe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Aug 2020 06:35:34 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 769FA9FB;
        Tue, 25 Aug 2020 06:35:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 25 Aug 2020 06:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=158/86PVwk/Ejarn37AnNQJpiyt
        qoX3q4bHKDUTRuEU=; b=McgYsLHCpW2sVNs9li8mSSeqSeRAQLmtmirCk5cMJpl
        vERdI/5mUsVFAFjHKSoiS5RabB0ISzj/PI+othYRb6r7K6Rp/5Xa8OBQNeaKYmKW
        yqKfY0NeFXR2zzL2IlKBzC66l3cbkP65d3mp6Q3ZRRJQkhaRPdBvVJTHUVNtv6tV
        C5vor6YOBX9sewcfDX/ZhciMTLNdHgWKZlD5jlNFCmjxh9VNh5R5mXV7CgxMmTEk
        EmGNNlAxGn1k6hmBRECroX9laaNmlDygwIITKITg3oHDcl8L/dIKiBPDYUvmKXh1
        rltEh1M4l1ERILMN1e8ik2KblbfDDAnlb+RTgWGe7Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=158/86
        PVwk/Ejarn37AnNQJpiytqoX3q4bHKDUTRuEU=; b=nbuV07TVrYZY4MmsbyktlM
        5gjdjFkjgP3fv92n6OjeFAyYFaNvuOmclEg7I2tXgFwwYggrQNCtv+7ujh6AhQzM
        xQ/0Whpt2zKAkUugmIgasMONv9Cw3VK68ecASfZpjiIvazc6QkxvWYmUmuMGPVaC
        aNJ/36EEH04cGQ+VKZ4JIzqk5+306X6ZFRhtw+zwVcYvTRNTSZjwrNNTnT56jTgI
        qGk1hZL7c/EF4ybaKnV6+34kQOifzNAwZc6lOEf8lzeJcywgld7g6MEMsEggF34/
        C3qZbOLj7dqIBvZl655lWr5Ado002YsSwf9G59eieVF4L9m2pp7YRv4Ni4XwTRrQ
        ==
X-ME-Sender: <xms:celEX9Qpf7_bpu7QvsOI457jt_67i059wSoOANKf4qmYUDPg0xO3xg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejkedrheegrdegfedrudekkeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:celEX2xjH3gie_MRN05sPLnVfbQ-e-ZvLNwWfwjXCcHn9ykhfBZsbQ>
    <xmx:celEXy21oJ8i1rDmdHt0TaAOId0sYbUSzNbvNAzeLq-ityfqFwBkPQ>
    <xmx:celEX1D-kqr4WFsPC-IBLczmaWtufDm7oTdMr3y_Oc4q8eP4dmCRCA>
    <xmx:culEX-JqDK-rSMI2AlGcVLs7LquilT2AJfv8k-7d2Bm49gtrZfwQGA>
Received: from vm-mail.pks.im (x4e362bbc.dyn.telefonica.de [78.54.43.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id E6F2F306005F;
        Tue, 25 Aug 2020 06:35:28 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 1d6b6a49 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 25 Aug 2020 10:35:25 +0000 (UTC)
Date:   Tue, 25 Aug 2020 12:35:24 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2] refs: remove lookup cache for reference-transaction hook
Message-ID: <c1cae6dd19ffe00e4456e4f96ad92277ceeced27.1598349284.git.ps@pks.im>
References: <0db8ad8cdb69afb9d6453bf60a808e8b82382a4e.1597998473.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <0db8ad8cdb69afb9d6453bf60a808e8b82382a4e.1597998473.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When adding the reference-transaction hook, there were concerns about
the performance impact it may have on setups which do not make use of
the new hook at all. After all, it gets executed every time a reftx is
prepared, committed or aborted, which linearly scales with the number of
reference-transactions created per session. And as there are code paths
like `git push` which create a new transaction for each reference to be
updated, this may translate to calling `find_hook()` quite a lot.

To address this concern, a cache was added with the intention to not
repeatedly do negative hook lookups. Turns out this cache caused a
regression, which was fixed via e5256c82e5 (refs: fix interleaving hook
calls with reference-transaction hook, 2020-08-07). In the process of
discussing the fix, we realized that the cache doesn't really help even
in the negative-lookup case. While performance tests added to benchmark
this did show a slight improvement in the 1% range, this really doesn't
warrent having a cache. Furthermore, it's quite flaky, too. E.g. running
it twice in succession produces the following results:

Test                         master            pks-reftx-hook-remove-cache
--------------------------------------------------------------------------
1400.2: update-ref           2.79(2.16+0.74)   2.73(2.12+0.71) -2.2%
1400.3: update-ref --stdin   0.22(0.08+0.14)   0.21(0.08+0.12) -4.5%

Test                         master            pks-reftx-hook-remove-cache
--------------------------------------------------------------------------
1400.2: update-ref           2.70(2.09+0.72)   2.74(2.13+0.71) +1.5%
1400.3: update-ref --stdin   0.21(0.10+0.10)   0.21(0.08+0.13) +0.0%

One case notably absent from those benchmarks is a single executable
searching for the hook hundreds of times, which is exactly the case for
which the negative cache was added. p1400.2 will spawn a new update-ref
for each transaction and p1400.3 only has a single reference-transaction
for all reference updates. So this commit adds a third benchmark, which
performs an non-atomic push of a thousand references. This will create a
new reference transaction per reference. But even for this case, the
negative cache doesn't consistently improve performance:

Test                         master            pks-reftx-hook-remove-cache
--------------------------------------------------------------------------
1400.4: nonatomic push       6.63(6.50+0.13)   6.81(6.67+0.14) +2.7%
1400.4: nonatomic push       6.35(6.21+0.14)   6.39(6.23+0.16) +0.6%
1400.4: nonatomic push       6.43(6.31+0.13)   6.42(6.28+0.15) -0.2%

So let's just remove the cache altogether to simplify the code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

The only change compared to v1 is that I've addressed the unportable
`branch-{1..1000}` syntax in favor of `test_seq`. I had to setup refs as
part of the setup and change the ordering for "update-ref --stdin" from
create/update/delete to update/delete/create, but I don't think that's
too bad. At least timings didn't seem to really change because of that.

 refs.c                     | 11 ++---------
 t/perf/p1400-update-ref.sh | 13 ++++++++++---
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index cf91711968..cb9bfc5c5c 100644
--- a/refs.c
+++ b/refs.c
@@ -1924,24 +1924,17 @@ int ref_update_reject_duplicates(struct string_list=
 *refnames,
 	return 0;
 }
=20
-static const char hook_not_found;
-static const char *hook;
-
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
 	struct child_process proc =3D CHILD_PROCESS_INIT;
 	struct strbuf buf =3D STRBUF_INIT;
+	const char *hook;
 	int ret =3D 0, i;
=20
-	if (hook =3D=3D &hook_not_found)
-		return ret;
+	hook =3D find_hook("reference-transaction");
 	if (!hook)
-		hook =3D xstrdup_or_null(find_hook("reference-transaction"));
-	if (!hook) {
-		hook =3D &hook_not_found;
 		return ret;
-	}
=20
 	strvec_pushl(&proc.args, hook, state, NULL);
 	proc.in =3D -1;
diff --git a/t/perf/p1400-update-ref.sh b/t/perf/p1400-update-ref.sh
index d275a81248..ce5ac3ed85 100755
--- a/t/perf/p1400-update-ref.sh
+++ b/t/perf/p1400-update-ref.sh
@@ -7,11 +7,13 @@ test_description=3D"Tests performance of update-ref"
 test_perf_fresh_repo
=20
 test_expect_success "setup" '
+	git init --bare target-repo.git &&
 	test_commit PRE &&
 	test_commit POST &&
 	printf "create refs/heads/%d PRE\n" $(test_seq 1000) >create &&
 	printf "update refs/heads/%d POST PRE\n" $(test_seq 1000) >update &&
-	printf "delete refs/heads/%d POST\n" $(test_seq 1000) >delete
+	printf "delete refs/heads/%d POST\n" $(test_seq 1000) >delete &&
+	git update-ref --stdin <create
 '
=20
 test_perf "update-ref" '
@@ -24,9 +26,14 @@ test_perf "update-ref" '
 '
=20
 test_perf "update-ref --stdin" '
-	git update-ref --stdin <create &&
 	git update-ref --stdin <update &&
-	git update-ref --stdin <delete
+	git update-ref --stdin <delete &&
+	git update-ref --stdin <create
+'
+
+test_perf "nonatomic push" '
+	git push ./target-repo.git $(test_seq 1000) &&
+	git push --delete ./target-repo.git $(test_seq 1000)
 '
=20
 test_done
--=20
2.28.0


--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl9E6WsACgkQVbJhu7ck
PpSvsRAAnhQ37F/mCZs5d19NSIclr8vs2TUBtPWKFq8nFxNZmv8CiYxYYFoaRTk3
J83dEAEowVKVywYzCpVavnBCXWRY1opVj0Pt3y+Fn3XVkFIC+C3aZR6zuJAaeMgs
cTCvvFzXuBWxojQh4XSJCYxGxiNaB07b4Kcp6R8/pdE35ntadipfzqVclpilygVC
Xndf+nv8404AWGHj1sn9aKT0zfPgBMDncfb/1IGXi/tn4J85v3/UbbT3uHSJxtB7
dAY0B1TkGebeKnHAgpi7VlyWWzfq3xFpNsGaOaGaumXRgyX3F5+rvD7qEckqE3i3
i/YmRwQON9PxSGrIGNAKlSkq1gtHbIeENzXLK3IiO2TBeatXCoROc3okIJFEvAwM
AuhSKRoPnHtVVMZUAFpwGnoZkh56P4+BAinpHzoJKPNdGe1B9208YkMgxtt8mPCs
YoiR/Taww1ZJgtcp7znp+CtsMT0/AQFsVs+WpS41mc51cFjRKYzvsAmO8PAX1zvo
zaomfToCFCfxhkSYz0VJCxWNjt18v+creYsqyrTUsQccVUXNKtkgu+RB5ajAxZZq
rNgNQhcgFXFN16oD5Ypz4ZZffDaa2DIRdOWkm3VwHO4UliGpeOt5EHgwt0UyCW0g
NZrPKZO24epQHBSJFO/ACVINdvm3y6ZKOXOu/paAX6/hZrgM1LM=
=1EeD
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
