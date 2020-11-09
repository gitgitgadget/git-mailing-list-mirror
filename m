Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E12C4741F
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 10:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFBF20663
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 10:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OL+Hnuuu";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TjJOahdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgKIKHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 05:07:00 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:57399 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728979AbgKIKHA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Nov 2020 05:07:00 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 78D781292;
        Mon,  9 Nov 2020 05:06:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 09 Nov 2020 05:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=nl7nXpnoFLZT+vdMo1UDOwx/RZ1
        fdPSAg/UMRA1RDKM=; b=OL+Hnuuu0eTGrjbMazdM1IpeN1No7pSu128somFUJiq
        VsV7DFl/rrIS6z+VhIM5tlyAu0vRGxFVqPn7Hzfg4qunq/iyRTnUq7284GNlzL8L
        g5oVLpzghzLC6lowwcLQ9w7f09EGAAIzCVR00qXxsTugSihd+Qrr58lJvzj/dmwz
        50Vjz9DF4ErQhTDNJsQaF12D7iMdXVcedcU7VxY8fw3q5SpCEoFaO57G0cvsgVUN
        o3qgDJCMmJcxqY9bf7HpkRk3inhF0gu3A6ABZXXfe4T7DQM4VmajdTBct9kH+Uks
        ncgKXrDgvmY46vdmyOVQ/uWPBLu6G0B7zgSNg3RXcwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nl7nXp
        noFLZT+vdMo1UDOwx/RZ1fdPSAg/UMRA1RDKM=; b=TjJOahdIZk/NX6/kevNOkI
        95p70UafDbaPzMRhDqFvukXgETh08yE5Z3btxpurCKCLmV34n6w6oPnjswg3cxps
        By5G2pOp795bPPxWRwojLI56UqPf0bFQOJPUjCSmVxfb7QN9aVMt69Sn1ftnhL87
        bO8CrzbRKkJCPgX8m3UxnSRTumD2j8QBtEisfrZ1Mjd75+2NgpXAwyg3m4IM9ko1
        A5rwHkwABGdwqzJaz9ObyCrFcErmVK/QC2s5xh7rSfCYdJ6qfIPc8TpAxkCooVkE
        JCebZUGlYWCCHOg7LL428idSJm3lxrA9uq8dPYlGDY2hykLzNYHfQj8lxQaU9dIQ
        ==
X-ME-Sender: <xms:wxSpX9Ru6iOdYBqPyC4zXARNnbTcjOGw_zDAthTCneDeja3Ak9Gt6w>
    <xme:wxSpX2zEyTUhGuVuJDeheyVC8Yo_5RNXmw60rsIiLNFAmIJKH5AbXiqvWPnrxR0z8
    hE98JWjNfvHIefU0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledruddvrdegledrvdduleenucev
    lhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:wxSpXy0CUuCAoobRdor6qfA78mnGepDA0Aa2ETFE0qBRgQm9UMaZnA>
    <xmx:wxSpX1DHPn0tvWyJ2yG34nl4qAc8OCfzeIfXZ9pM7q4ZBNjZg3UwKg>
    <xmx:wxSpX2iB0BQdNb9YvD0BVXevLrb4zADC7YagmZ86IuJO2jjVGdTTkQ>
    <xmx:wxSpX-JXukU0etDjVwIJ1WtHiydMYPMgtL-Oq9LjaWPQeTDTtqHMaQ>
Received: from vm-mail.pks.im (dynamic-089-012-049-219.89.12.pool.telefonica.de [89.12.49.219])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6C1363063082;
        Mon,  9 Nov 2020 05:06:58 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a79a671c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Nov 2020 10:06:58 +0000 (UTC)
Date:   Mon, 9 Nov 2020 11:06:57 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH v2 3/4] p1400: Use `git-update-ref --stdin` to test multiple
 transactions
Message-ID: <e3d61612dba01a297ad9d0471cd5a804e0425339.1604908834.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1604908834.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <cover.1604908834.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--h31gzZEtNLTqOjlF
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


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+pFMAACgkQVbJhu7ck
PpR0/RAAmNg/nRHVjmSze0tyJh+CRvwSa9IFj2UuLRE1AIIVH0/rRKO+0rHDoTQ9
draxM19VyqStSFv9mletpayy+bylmuARdHlmiOozNiEUk3/RxwwVFwcc5K15NuXr
KH9axKU0L9zzLoW36bQXJlnUGm+678VVw7FqdGYpsjA6WxmLdHnk0Bz88BodUTtR
/x8KdfrjVnYR/EzfGeYacR1lpoPo+hZRJjmdG7wo1dbbwsLk0bk/vcSdnuZLFMYp
XcuHsrfbXiS0nTrnGfYDvxj5XnKHI4IkRULv7UvennCo+TuyScnQAmlSrC+4tgye
pVdWDcKuD86kd1Pett8ymBjkUei8Hbv0QhB3Ok1MyMKnvI16KFBz4TqBwWCsH1OR
CHpUBUjPyaJRvWQMDZpTcUh2xbQMdnJgqLKKIJN2eSowf+SLv5/1Tz7QSD5D9NVZ
Y1D461qq7/VmdPIFN1OVIy3bBxvl+Te6StOLZeahk0PazhUzW7sSO/K5pMsxMMS9
IJ9LmX3SKVkoldjqrnXF/j4W+wHlFC2GvMU3bm+9GLNZeaS2mYL4xga3R0und+6a
lpdFfttmcZV9TGTW3MXlWGLwlef+ngWSkFeIrEuP43hl2davc/CGmt7jLpVbrvlD
3P5Ypl1SuHroKy6W57m0v3yhziJDmube9sxwjpLDCEhfj25vZ8w=
=ElMA
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
