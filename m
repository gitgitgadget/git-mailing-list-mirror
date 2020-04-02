Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF9BC2BA14
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D122078B
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L3ujEh93";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S4yo+W7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbgDBHJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:09:18 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60571 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728612AbgDBHJR (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Apr 2020 03:09:17 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 08E8C5C028F;
        Thu,  2 Apr 2020 03:09:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Apr 2020 03:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=kXhCDV4jmHqEtHWXlMbTY/O6mzR
        l0JCm4WOa10GSc9M=; b=L3ujEh93gUWbzdOK/V7eOOYaCe3+wffIj/hcWecsVw2
        lSZ9n8xs2RiMXVXB9wi8WYwYU+SUSRsO+hQgMyl8cuou8wihYBXlkD7YDUVpOvWk
        WboVX1rfEKkm6FwBHvMDTTdg6TZ+5JFYhMBcl/bkPGtsNWsW75gGN850hp6xYR2f
        t8yKKLBL9fg3eCHY84dr9DMdJ5XOEs2IFzd9DIzi3lpx94fvoztOBkCi9EI3FFli
        5HApLccnslJ/2OK2e9r9a1AhG4RYikXf3qFSRNjAVyno8KZ8zwIdj2/2NdfzV33c
        jmjIL4Ty86LaVn3I56V09qc+Ivd+nkzAK1weRTGen2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kXhCDV
        4jmHqEtHWXlMbTY/O6mzRl0JCm4WOa10GSc9M=; b=S4yo+W7YNAwxuRKCoCbCeo
        2j2xHASPjm/gBdFBQ3jGjg7go7Zh6vjzBC2kw/FOgCi0efMklN7sRRLteDQH/a8X
        657Rp16PIgMiuoNJcqCHDSbkB0f+J6QmFHRTPu1g/Updfs9F6q5N24kk/3BRlZgW
        +oPe7dXRpmn0QuZeb0168w0PlQfanH3o+/M245f8yqxljYlbimjyG5kyi9G1jPBr
        NClW3Bafx8uXprH+Yn3uoI6jErkTkji15Y0sfllMd+EE7aRKGTaVm0o32ID5asUf
        D6UJ9GaRW1e6ExSyy4CkHFfAaUVVWicJLNOZzL8qKZskPKfxZFgS1h+ibqbvvpRw
        ==
X-ME-Sender: <xms:nI-FXkRnubcNxXvhaZzgK7WZtUlUNL4mGoxePTfq-QyN1ZNlDc8Mcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepkeelrdduvd
    drleegrddvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:nI-FXnhVjuJ1QpXb3YanAYXaxmzBVncbTHwgEvC2mPZNUnCoDYWGYg>
    <xmx:nI-FXorVMqeftdJNv10mXXC8syySgh_Rg2ONFxU2Z_euelLvUQl4IA>
    <xmx:nI-FXvN-Rx-472PqJK8FoeuHGgyebnfi3u1ZpQ63VY4TWOUhw6vNEQ>
    <xmx:nY-FXpLtmx4_K_NGq1sm5V9xi5JG2SMxbORX1VKrKblT26X9ta_sHw>
Received: from vm-mail.pks.im (x590c5e1c.dyn.telefonica.de [89.12.94.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id 68B8E306CD75;
        Thu,  2 Apr 2020 03:09:16 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 4dcf2220 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 2 Apr 2020 07:09:15 +0000 (UTC)
Date:   Thu, 2 Apr 2020 09:09:22 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/9] refs: fix segfault when aborting empty transaction
Message-ID: <7a297db4daaee84dc90ddeaa8f77b68a39231ef1.1585811013.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585811013.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <cover.1585811013.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RnlQjJ0d97Da+TV1
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


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6Fj6EACgkQVbJhu7ck
PpTkgQ/+MSnj56osbnikVJdwaUl+Cegx7Rs6mp5c7fMtpxsZsENPp7NZ5QzvDvEv
lMfE8fPH22wIx3IRgiPhehbVI0MusOmgMvubw8Vbd8SOh8PT7qhzAeemUeJramd0
FttjLX8bq8uxLvI4QZPzelfwMYB2aFRj7LMl2YYH+9s7zrcRkOm1Ae7Lf/XtPXZi
gQlrfHxCQhje09NSOkpBHBYW2lpifW+q0+vZ1j2tTn04odkXJmgnAHSGvAXsOzT6
UtOj/W12UQT8pR7Q5cNHPz3L/p5WyiCQzGvEV0m2r1kSFoPFnPwDId6cLGsNvPsa
iVyOi2x6wSaP+sb2SqV9MDorsRtU7GsNh+UbIy6E4/O1DzLr7zdwMS+pzdJtaf/G
yGRW3Eqn8EKSBw/fsB+9l87Y3O9aX6MFhPvd52sbooetrlYdqY3c2y7Rtlyr3ori
MdA+CAd/6JeACvnYsgj7hnG8q1FHNQDUAST486yxWqpMrA8LBmXmDocQpGCyxyIQ
uiQ65SMdNJmGjpPSyybbY/wvTK2Nkx08/2QDAKmL6AG7jV8efwW4DJ0ybae2qgce
HhKvMn/AOh1U9YPHo8ZRupnJZJoRe253dn8DCtsHbsuvaKcXKivSEZvUgB91Vqm0
Lu9GaPE/CkHVZL8ZsielcC4jAv+/5/jMUohamrnvhv/IvYBdU24=
=oEgL
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
