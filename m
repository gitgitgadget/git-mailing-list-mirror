Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A53C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 21:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjDYVft (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 17:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjDYVfs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 17:35:48 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179991707
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 14:35:47 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 055365A2B2;
        Tue, 25 Apr 2023 21:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1682458546;
        bh=ZmHRaGp7US7mp+61DvRthhBIDGyji0Y9gGWcl7TChJc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hd8jzSGfKg9WB2QdwWlyvNMa34uXLwUc4uSNHyppEXVa5vE8YrT3m4Llb4VSiLLHx
         hnzJ9fROJcr9050YBKzx6hOUSBMdLlZiZbHTCZL1sPDR1sehUiDhCB1ejafWZ8/3su
         K/FVezy2W3Dee8UeynkeavJUdqMnGxjxkloi1e3FML9dob8Ya7lM6Gke5Psu23i2K0
         UVC1UYAHz6pbTnQ3IsTw60Ux2P0ZCyyLrkqFq7r4uoQJuMkQekJcHR+cimADIV95re
         cS6gE8tBquZVKXJN0QHhsdWyJGNeVQBASMVhvjsppqa683voH3nfVO3rserXi7FL13
         791pziNHVp4cl/Cna0e+eMl38q9RoKqqrnHdboc4RXaOPiABK0irrV52NdR77ds9C/
         DnOK46+cAUYfe+azc3az2k2CUeP9ileiIZXCLkMlrvmsStpUpEcAjoATVBRIbKepfK
         WAKKXhXWus2q7ItSIgp6PXJIAClRLqZK8YUGMsMxGn8o95Hp0Li
Date:   Tue, 25 Apr 2023 21:35:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Adam Majer <adamm@zombino.com>,
        git@vger.kernel.org
Subject: Re: git clone of empty repositories doesn't preserve hash
Message-ID: <ZEhHsJh20gtiDBd9@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Adam Majer <adamm@zombino.com>, git@vger.kernel.org
References: <e7a8957e-6251-39f1-5109-87d4dd382e81@zombino.com>
 <xmqqr0syw3pe.fsf@gitster.g>
 <d04c430e-b609-b0a1-fd0f-0f3734d5c3b1@zombino.com>
 <20230405200153.GA525125@coredump.intra.peff.net>
 <xmqqa5zmukp5.fsf@gitster.g>
 <xmqq355euj2i.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dsx/FukRqOJEL0ij"
Content-Disposition: inline
In-Reply-To: <xmqq355euj2i.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dsx/FukRqOJEL0ij
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-04-05 at 21:15:33, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> ----- >8 -----
> Subject: [PATCH] clone: propagate object-format when cloning from void
>=20
> A user could prepare an empty repository and set it to use SHA256 as
> the object format.  The new repository created by "git clone" from
> such a repository however would not record that it is expecting
> objects in the same SHA256 format.  This works as expected if the
> source repository is not empty.
>=20
> Just like we started copying the name of the primary branch from the
> remote repository even if it is unborn in 3d8314f8 (clone: propagate
> empty remote HEAD even with other branches, 2022-07-07), lift the
> code that records the object format out of the block executed only
> when cloning from an instantiated repository, so that it works also
> when cloning from an empty repository.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

So it looks like this has made it into master and works for v2 but
breaks things for v0 and v1.  I noticed because the Git LFS testsuite is
broken and the following test demonstrates it:

----- %< -----
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 6c8d4c6cf1..3be5057579 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -244,6 +244,17 @@ test_expect_success 'push with ssh:// using protocol v=
1' '
 	grep "push< version 1" log
 '
=20
+test_expect_success 'clone propagates object-format from empty repo' '
+	test_when_finished "rm -fr src256 dst256" &&
+
+	echo sha256 >expect &&
+	git init --object-format=3Dsha256 src256 &&
+	git clone src256 dst256 &&
+	git -C dst256 rev-parse --show-object-format >actual &&
+
+	test_cmp expect actual
+'
+
 # Test protocol v1 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
----- %< -----

If nobody looks at this, I'll take a look tomorrow and hopefully send a
patch.  I just wanted to point this out to the list right away in the
interest of getting it noticed.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--dsx/FukRqOJEL0ij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZEhHsAAKCRB8DEliiIei
gQ+CAQC1w1AD6rDRUkVsnvvKMu2FbcdBmZZLaPXSYJ5c+v4XlAEAhRYPV5fH1njH
a2+lhRfdcHe18v3yNFxTUqxEzCY8WwE=
=lcn5
-----END PGP SIGNATURE-----

--dsx/FukRqOJEL0ij--
