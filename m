Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D242FC54FD0
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C3520772
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 09:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MFagwVj0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LKbGD4BU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgCYJx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:53:29 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45985 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbgCYJx3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Mar 2020 05:53:29 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7BA0D5C0105;
        Wed, 25 Mar 2020 05:53:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Mar 2020 05:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=7sx3PFmiU/1+mQzYwYZ7meSU791
        rc9wa6KKO1pYAkGA=; b=MFagwVj0Vo+mf+ncRST7RbKdCIskw0TPdxT4Pd0a9D7
        lDGIN/z3qA4+NXE5rYwf/uAb2E50V58xn7VAo7o1Rn9WE1mzBwF5dnMxUqvxm0Dz
        zoA5BoWA2uIzy6j1In87bcEHQNDFWi/cTTO+ENnLuqUuElLA61lrk4dkhblc1Ooa
        2NaewvE0u+FGOWWfcTIrtJtGrowM33n8EdjO2vr4Vjzm7MWTQtYCXh3VXYK80wZN
        4dFFLik9DI8z+5Ar0MDHpBre2/tdnBJaPCsoGi2BGRcOeeQYCNMcc405ZWKgybV1
        u5xAnFhTXg5uUUFu6pY6zneTQ+BOb4WfZDyLsDDSW/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7sx3PF
        miU/1+mQzYwYZ7meSU791rc9wa6KKO1pYAkGA=; b=LKbGD4BUsgT/S0fNMiYaTI
        YNHc/+xgFOTMDL/EXwmDoMCfYln31QZN6epwdrp4LJKeQSwNmIfsGags1OZP+yUw
        5/9jXhlxQAFlNSQl4I/exbKmM1z3a9KGLCmmiGRf0Bjq0/rmTiJydd4TteC9Mp2T
        4hjEfus0ItZLmIqYU6iIESoe0roGqjWW1q9oTuBDlcJQAbvwQuS5pZhRE8paL92P
        +xRrK7gqr/zgC0wnpzruX4JFelt8k65ylHzIhbBOTng7uoLW7a9qROBLB2TinjU6
        S7Y/GEt5NIuzup7JEELRM7PaMHzL/6ZF4+fg9neK1NKysroTZLVvNdJ4EhtZc4Qw
        ==
X-ME-Sender: <xms:GCp7XlkAaajwD1G1knLgrvp3yBYEEhW3S5ALxsM65ciesT3lLoJElQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehfedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddufe
    drudekhedrjedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:GCp7XrqtSVqf4zToh1bzNh6IK_oR-24CwydNfSOPRTfiadK2ZhfCqw>
    <xmx:GCp7Xp7gE-kOpjuYbpq8B2dVnswDddZKXXT4y0PCUYTVeMU1qQ77pg>
    <xmx:GCp7XlJP1DiFaOeEA-A3hJFkwzZpgzCgcQMdtAMnrgvmUqrv1otKlQ>
    <xmx:GCp7XgD7qHz-FoNcO9uQNOSTUM-EKWdryhz5ooT4FOUhqYLbB_uw6A>
Received: from vm-mail.pks.im (x4d0db948.dyn.telefonica.de [77.13.185.72])
        by mail.messagingengine.com (Postfix) with ESMTPA id 151F33280063;
        Wed, 25 Mar 2020 05:53:27 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 63dcd87f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 25 Mar 2020 09:53:27 +0000 (UTC)
Date:   Wed, 25 Mar 2020 10:53:28 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 1/9] refs: fix segfault when aborting empty transaction
Message-ID: <3c7f8c47f361c46751629b44570657ef811d94d0.1585129842.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <cover.1585129842.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When cleaning up a transaction that has no updates queued, then the
transaction's backend data will not have been allocated. We correctly
handle this for the packed backend, where the cleanup function checks
whether the backend data has been allocated at all -- if not, then there
is nothing to clean up. For the files backend we do not check this and
as a result will hit a segfault due to dereferencing a `NULL` pointer
when cleaning up such a transaction.

Fix the issue by checking whether `backend_data` is set in the files
backend, too.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 561c33ac8a..6516c7bc8c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2565,17 +2565,19 @@ static void files_transaction_cleanup(struct files_=
ref_store *refs,
 		}
 	}
=20
-	if (backend_data->packed_transaction &&
-	    ref_transaction_abort(backend_data->packed_transaction, &err)) {
-		error("error aborting transaction: %s", err.buf);
-		strbuf_release(&err);
+	if (backend_data) {
+		if (backend_data->packed_transaction &&
+		    ref_transaction_abort(backend_data->packed_transaction, &err)) {
+			error("error aborting transaction: %s", err.buf);
+			strbuf_release(&err);
+		}
+
+		if (backend_data->packed_refs_locked)
+			packed_refs_unlock(refs->packed_ref_store);
+
+		free(backend_data);
 	}
=20
-	if (backend_data->packed_refs_locked)
-		packed_refs_unlock(refs->packed_ref_store);
-
-	free(backend_data);
-
 	transaction->state =3D REF_TRANSACTION_CLOSED;
 }
=20
--=20
2.26.0


--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl57KhYACgkQVbJhu7ck
PpQQ7Q/+JBp1JA9ezlmvRYakDVOsKpYAj+r7dMNy0BUAJjEP8EbnoXUg/y3p/Jkk
MEtZWfOPm6pm04FE3XWutrqR7Kct1KjEXZSxA1N9oRMAwZI6lOdbmJTL/lM26lgZ
d8tq4yicj9erbHeASCYqISb9FTlP+GaqXYS3tZDIFBLoUholkbZFQrA2T/QvMBiH
jdFzllmu7kanLLnKzaA1qyRyLaDrHGOevZkvovBMzAWZ+8yF936FNTg1eHuwZGxw
kkwAatpUCTujKqrZB8rmfpCR56zpAY/qrmja2JjyXitpT9qYAutF91v1101zwe1O
pc1vOCAGfBDn5a6xOM+DB7eVzJhiVoGfUqWulgdVzhbNjNPHPBRDS4h3ZzYfb7kG
GEDO2lqNlCPixqZfrvTXK3aOxVK1QfdCGEWNH0UR91RO9PTb7Or7hEgVW2FS/i+P
7T5RNmeNUNsdeDVJfOHbiLmc3PvXrioLkkCc6YCK7nqkmma1d6qpNU+/mcdlbigY
RjTANeefaRQjE6V6VdL99mfBQMtxfwZD+WjnqnOhBETRReiuPk9jlM++8F0nct6g
T7KAsacioQjrl82qJrU77BGlsl+TqnLh/Hh0PsJ+RRa69FkFRJUwmxJ5Zr/QO+RJ
NTUhcNVbWJMHugnsZZvBPrDntKopFe7NhD21g3e1gk2v/7wszwQ=
=3Sc7
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
