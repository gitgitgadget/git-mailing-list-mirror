Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E70BC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 14:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A15D2074B
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 14:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GEkDH63Q";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JP0NWVnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgKDO5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:57:30 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:45631 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730312AbgKDO51 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Nov 2020 09:57:27 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 45D0AA8F;
        Wed,  4 Nov 2020 09:57:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 04 Nov 2020 09:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=tQD+QvMSrXY3HioRPUOQA3ahBpb
        iByd/NpUNpOdR1YE=; b=GEkDH63QvRg2CFLaUqgiodL8JP0pruLacy1+Qb5izZS
        hqRz94qRnMiU9yn5pNZg2YHo3fPTYWrpvfMwpc3gxHQ0yJcw26jQnrUhKyXAN7jP
        MtDNI03euFNf7q+lHWzMvaP+wXXf1aBf+R8KfYdo2mhij+uO80I4pg79BIvTTRx+
        q6DJSTTPZFJoP06bdWiNgVnlaoyxW5m85EiWBZ0uMXCRmKA2RGBZwfiLnN0Iaz7v
        pmiDSZYyRjFFHlgyeXUYqWetKfeGZzLC+LnUXLBzD2yF8PTUV9xbRF75/vuuL0eo
        zdtumq6qdLqephxHyEa/ctTG/dNbOofRU3eNiWvdj4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=tQD+Qv
        MSrXY3HioRPUOQA3ahBpbiByd/NpUNpOdR1YE=; b=JP0NWVnjlNOsMNm/dCV6TS
        z5Wc37CJ+kezQUt7WdnNkDmKdpF7KCnhTx1LM/+Ti1twTbr71CjTj0FprNBYIbN5
        p5EKmjK4Y0mAC9LeuF8Uv+HV9hPBCNi8KWvTQ0B8UY7aVptzZxWG+We/DwNuaSew
        OSYgXE3C0FfoZPnkNdrW1hD19BaDc0E2fBLPLGXyRec/IhHwHMRNU0l0C4dmN996
        PmXEFhV/gCxAtCcGe5yRL4+wUWAv31ri5urj9IUvRhtLkCdSZZTdT3RxW3ggclmW
        A2EAEO0CkqTzWvJduk7OrRHwlZtB0qaEeEEHBje4aXQYCktILZ1Uze9w7Yh6k10A
        ==
X-ME-Sender: <xms:VMGiX1IRWEtFGCtue62s53t1f1QrbhGonihI3aiNyj-J19Ew39WU3w>
    <xme:VMGiXxIonY9l2cyES4Ijp9FmraG3m2eBFZyGi-xIvm256aoe8_pbIi5lu2oXmuT8e
    HyzNSz4eqie8vvGww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddthedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejjedrudeluddrheegrdehnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:VMGiX9uT4ttDrK0O5KW6BfAkwYCj3s3IDM7IGh_iRKlzmMbKQKB_mw>
    <xmx:VMGiX2YiF60eAXSJ4757GCQx4cGbffPqgp9SdoGvjdcW_KEgq9Vd7A>
    <xmx:VMGiX8YNDeK99EvfMil-Vys6uBu-zMS9FBx45DF6ChmYXQSGP2NFQw>
    <xmx:VMGiXy2Lg4cfBpdy5g0fuPv2pIAXpHArUcspti_MMKCphJrU3FwAiQ>
Received: from vm-mail.pks.im (x4dbf3605.dyn.telefonica.de [77.191.54.5])
        by mail.messagingengine.com (Postfix) with ESMTPA id 46CEB328038E;
        Wed,  4 Nov 2020 09:57:24 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e698efc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 4 Nov 2020 14:57:23 +0000 (UTC)
Date:   Wed, 4 Nov 2020 15:57:22 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 2/2] p1400: Use `git-update-ref --stdin` to test multiple
 transactions
Message-ID: <bfaac619112b04aa6545f229ea60433cbf8da73a.1604501265.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <cover.1604501265.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In commit 0a0fbbe3ff (refs: remove lookup cache for
reference-transaction hook, 2020-08-25), a new benchmark was added to
p1400 which has the intention to exercise creation of multiple
transactions in a single process. As git-update-ref wasn't yet able to
create multiple transactions with a single run we instead used git-push.
As its non-atomic version creates a transaction per reference update,
this was the best approximation we could make at that point in time.

Now that `git-update-ref --stdin` supports creation of multiple
transactions, let's convert the benchmark to use that instead. It has
less overhead and it's also a lot clearer what the actual intention is.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/perf/p1400-update-ref.sh | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/t/perf/p1400-update-ref.sh b/t/perf/p1400-update-ref.sh
index ce5ac3ed85..dda8a74866 100755
--- a/t/perf/p1400-update-ref.sh
+++ b/t/perf/p1400-update-ref.sh
@@ -7,13 +7,14 @@ test_description=3D"Tests performance of update-ref"
 test_perf_fresh_repo
=20
 test_expect_success "setup" '
-	git init --bare target-repo.git &&
 	test_commit PRE &&
 	test_commit POST &&
-	printf "create refs/heads/%d PRE\n" $(test_seq 1000) >create &&
-	printf "update refs/heads/%d POST PRE\n" $(test_seq 1000) >update &&
-	printf "delete refs/heads/%d POST\n" $(test_seq 1000) >delete &&
-	git update-ref --stdin <create
+	for i in $(test_seq 5000)
+	do
+		printf "start\ncreate refs/heads/%d PRE\ncommit\n" $i &&
+		printf "start\nupdate refs/heads/%d POST PRE\ncommit\n" $i &&
+		printf "start\ndelete refs/heads/%d POST\ncommit\n" $i
+	done >instructions
 '
=20
 test_perf "update-ref" '
@@ -26,14 +27,7 @@ test_perf "update-ref" '
 '
=20
 test_perf "update-ref --stdin" '
-	git update-ref --stdin <update &&
-	git update-ref --stdin <delete &&
-	git update-ref --stdin <create
-'
-
-test_perf "nonatomic push" '
-	git push ./target-repo.git $(test_seq 1000) &&
-	git push --delete ./target-repo.git $(test_seq 1000)
+	git update-ref --stdin <instructions >/dev/null
 '
=20
 test_done
--=20
2.29.2


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+iwVEACgkQVbJhu7ck
PpTW7hAAnzp5MbuaiMibjDWzIgAzDee2pkEWWhMaJMhcHKz68j+d3U7sIkR8FVxR
KTI29DM92acSrQQ6wxv+pKSTbUUQfJny/TxYVf6MY9kfVFUSPQpEadBo+BgCGg/W
SU/LILPQuAn9jVOiE2kS4fNKEZubXHw467LzCzH+JyF6HUi/92/59hwYz0FZsVN8
Yi9DabDYqonu7wPnet+rfNpiz4D+ubsM3Y6opI5CFVR9vWShG77ENHx8CYzcyPif
xITiGz3hi2XRDLtbc8m1zw+Ecca2Qs06L/GE5Nu9KDlPV7cTOFXg7EKz2g9Vz/xH
C2TAzXQFfRLBxnSOUqAdoEN0lSrc42xYFQfldUWhpc8khvi/fytklWBfl42OXxf7
Tp0hw5NoO8covDw1M9Il3BFXApqoeABpSjtR9AGlSJRPP6dbYC2ElmfpcXUBLoWN
4+gnlMfcMc/ofqUYrB7+3ksnlwuiuraASKbFLIRyMwG7GiOMT6GuddQrIJq9aNUT
V0GHm9iKKKUMxvaN4xXjAACvGCZCF6H2GAQGLeiU6dzv59QPrEVqmbVz6BWkK0iN
MYWrOStVqbu6e0AAgFXb/mVvZz96tTaN28IwzO4e03gNsdVEoJH4cNAcKDjf9/Ch
ilG916Ekp9nolOB6CWMWOFr5N+1iToXjzenSV09N/5Qgl4ABNxI=
=rLiq
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
