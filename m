Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CE0C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 14:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CBA20867
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 14:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KGxGFQbS";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VL30dIkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgKDO6p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:58:45 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:33051 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728522AbgKDO6o (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Nov 2020 09:58:44 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C22EA2D5;
        Wed,  4 Nov 2020 09:58:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 04 Nov 2020 09:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm2;
         bh=XogNm9rvWaeM1btw+UUxIyRiEGA5IeU94eFNmVSmBeI=; b=KGxGFQbSKrjk
        kwGUh8XyB6mAkYvXm4/FeJFeXMn6rjaLmGoFBPNGSeqPNfSgyiOF0QQIJFwvobqT
        gG7uf/zjEtn5bo6hxA9c6Vu95IcuK0w77JXDi324MNlN3fd3JJyonPRqzapNNKY+
        oUc4lGnRvH0loIdZhyE+eIuAQntcNrQYwTM1D76jXpnaFMcZwcXcEJ55XtB1gaam
        dvlQfKZMliK4a5e18+7yry8EaSRwyZyB+OOsP/PsZhz4KoYpMTI5Ro3t2UAHH1Pj
        at1ZieFhOGpqDBWuxFpm9tR05irftUCC1pJnwpBW1ESVW+rY7Cos+cAy2O/YK9Af
        MaKmYSIB7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=XogNm9rvWaeM1btw+UUxIyRiEGA5I
        eU94eFNmVSmBeI=; b=VL30dIkDa6KEBCawt7TnC9VIEFL/AuO7OTcNACoBpho5V
        lDOEw97gF89Hc9s9l091M5xZUrSGGJjwPmlM8Iz7GIoGW520BFt7A7HWZwEKUG9j
        4RJAy6vPe2T6OkV8oUS4iQR2jPSH0EaxKOPbBMCRbuhl2cvMJmkYTkSoEgzig+h3
        0MBhZubx5yfJhQxFB/y3oQmMYfc7+YM9Guf5o/YAvoCkPXM+eyGqX52Gji2ShEqD
        2J/oaUH278Ras7+GKpvSrKDKOA4Hf5nI4miaa2JXKAOCT4BKNle0PL8Ro2RYw4AH
        CpINiB6QdZ7W8F1v7kPYFHg1WpZ7NH1ce8LVEz9oA==
X-ME-Sender: <xms:osGiX-izn6s0FTR_DP8OeOkpWRlnROh-nkpxyMMcdV0X-S4trgJB8Q>
    <xme:osGiX_AleOA9MsLm5JecH7Dfll8W2RjUNptJC5aBPRHvI59wLQ0CCNMQCo8gZJ2NR
    qvqiT1Qc4ad8-K9aA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddthedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecukfhppeejjedrudeluddrheegrdehnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:osGiX2Ef3pVckQb0cYrigarlxvXyDN3UN4WlBsLg68sX8ErIj5HtVg>
    <xmx:osGiX3TuE7Bs-r2Jp47rafKzg3sZ-MhJQBZ2P2Gref0ZJjzN3b-WfQ>
    <xmx:osGiX7yD7IcnUVAhYw7mqMiavVjZysVFSI-TfX8eOY-DlOmGX5wlxg>
    <xmx:o8GiX0rUxrFMEHbnkAkAlmNefCuFOtEv8N8BAgBtUagRqJGubJwUqg>
Received: from vm-mail.pks.im (x4dbf3605.dyn.telefonica.de [77.191.54.5])
        by mail.messagingengine.com (Postfix) with ESMTPA id 023E03280392;
        Wed,  4 Nov 2020 09:58:41 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 5a255e8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 4 Nov 2020 14:58:41 +0000 (UTC)
Date:   Wed, 4 Nov 2020 15:58:40 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, gitster@pobox.com
Subject: [PATCH] refs: Always pass old object name to reftx hook
Message-ID: <d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Inputs of the reference-transaction hook currently depends on the
command which is being run. For example if the command `git update-ref
$REF $A $B` is executed, it will receive "$B $A $REF" as input, but if
the command `git update-ref $REF $A` is executed without providing the
old value, then it will receive "0*40 $A $REF" as input. This is due to
the fact that we directly write queued transaction updates into the
hook's standard input, which will not contain the old object value in
case it wasn't provided.

While this behaviour reflects what is happening as part of the
repository, it doesn't feel like it is useful. The main intent of the
reference-transaction hook is to be able to completely audit all
reference updates, no matter where they come from. As such, it makes a
lot more sense to always provide actual values instead of what the user
wanted. Furthermore, it's impossible for the hook to distinguish whether
this is intended to be a branch creation or a branch update without
doing additional digging with the current format.

Fix the issue by storing the old object value into the queued
transaction update operation if it wasn't provided by the caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/githooks.txt       |  6 ++++++
 refs/files-backend.c             |  8 ++++++++
 refs/packed-backend.c            |  2 ++
 t/t1416-ref-transaction-hooks.sh | 12 ++++++------
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 4e097dc4e9..8f3540e2f6 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -492,6 +492,12 @@ receives on standard input a line of the format:
=20
   <old-value> SP <new-value> SP <ref-name> LF
=20
+where `<old-value>` is the old object name stored in the ref,
+`<new-value>` is the new object name to be stored in the ref and
+`<ref-name>` is the full name of the ref.
+When creating a new ref, `<old-value>` is 40 `0`.
+When deleting an old ref, `<new-value>` is 40 `0`.
+
 The exit status of the hook is ignored for any state except for the
 "prepared" state. In the "prepared" state, a non-zero exit status will
 cause the transaction to be aborted. The hook will not be called with
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 04e85e7002..5b10d3822b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2452,6 +2452,9 @@ static int lock_ref_for_update(struct files_ref_store=
 *refs,
 				ret =3D TRANSACTION_GENERIC_ERROR;
 				goto out;
 			}
+
+			if (!(update->flags & REF_HAVE_OLD))
+				oidcpy(&update->old_oid, &lock->old_oid);
 		} else {
 			/*
 			 * Create a new update for the reference this
@@ -2474,6 +2477,9 @@ static int lock_ref_for_update(struct files_ref_store=
 *refs,
 			goto out;
 		}
=20
+		if (!(update->flags & REF_HAVE_OLD))
+			oidcpy(&update->old_oid, &lock->old_oid);
+
 		/*
 		 * If this update is happening indirectly because of a
 		 * symref update, record the old OID in the parent
@@ -2484,6 +2490,8 @@ static int lock_ref_for_update(struct files_ref_store=
 *refs,
 		     parent_update =3D parent_update->parent_update) {
 			struct ref_lock *parent_lock =3D parent_update->backend_data;
 			oidcpy(&parent_lock->old_oid, &lock->old_oid);
+			if (!(parent_update->flags & REF_HAVE_OLD))
+				oidcpy(&parent_update->old_oid, &lock->old_oid);
 		}
 	}
=20
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b912f2505f..08f0feee3d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1178,6 +1178,8 @@ static int write_with_updates(struct packed_ref_store=
 *refs,
 						    oid_to_hex(&update->old_oid));
 					goto error;
 				}
+			} else {
+				oidcpy(&update->old_oid, iter->oid);
 			}
=20
 			/* Now figure out what to use for the new value: */
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hoo=
ks.sh
index f6e741c6c0..111533682a 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -52,12 +52,12 @@ test_expect_success 'hook gets all queued updates in pr=
epared state' '
 		fi
 	EOF
 	cat >expect <<-EOF &&
-		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/master
+		$PRE_OID $POST_OID HEAD
+		$PRE_OID $POST_OID refs/heads/master
 	EOF
 	git update-ref HEAD POST <<-EOF &&
-		update HEAD $ZERO_OID $POST_OID
-		update refs/heads/master $ZERO_OID $POST_OID
+		update HEAD $PRE_OID $POST_OID
+		update refs/heads/master $PRE_OID $POST_OID
 	EOF
 	test_cmp expect actual
 '
@@ -75,8 +75,8 @@ test_expect_success 'hook gets all queued updates in comm=
itted state' '
 		fi
 	EOF
 	cat >expect <<-EOF &&
-		$ZERO_OID $POST_OID HEAD
-		$ZERO_OID $POST_OID refs/heads/master
+		$PRE_OID $POST_OID HEAD
+		$PRE_OID $POST_OID refs/heads/master
 	EOF
 	git update-ref HEAD POST &&
 	test_cmp expect actual
--=20
2.29.2


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+iwZ8ACgkQVbJhu7ck
PpSHNQ//bLrK9BeM1VKzFzVW6ncE2wrTJJIAGkk9xKnck3kCYcc/xls/I4wLos1l
EBWwOVyvLVOqCRUzI/2LMHkNL5FlPkIqSaep0mfvNkZvxobRDUoF99I0hMPTJo8J
lpGzNxJyCP5Xf80lGswUBpO9jNdNc2F/Q7Eb43YxvL0rSB90u/Opz3HKNAoao5MV
fTOLIZLfL2gAjq7HpUVLcwBsvdqgzQKx9D69b3Tfk0wWYltYw9bTeKC+F9hjwFX6
qvq1qu3AjgQtjRK0vdjobrovty0hyFk6MPuP3gNhS0TwP4D+S7RcbONF2a7O3VE8
v6Vr8sXK3e6x228wTADs0l93dRWr99ZVgld4B5vtlataQID0U1bGSS5N3bhLQImk
KywBV7/UGfVW3Hp4h9DMQCvENE05PP8XaHdum9y4i9dOpfPoH2d7QIdgx2BBAQCv
sjWqpX6FymqhgniRlCNX/w0lV5fHTbN6AXwJZic/+67eyN837ORTbiy98f+pODKQ
4WGg4r3mU0Vks1ITNo0Iz2v+gNVP0mzP7kKdUxSlu4tQPpFfVzjwimvaZmJPwpr2
v+QXa8NeOWm7iImVrFzFlGnro9TNSJ6rz+VYLqaC2q6ekYjid5UYLwkvt9sH0NV5
vaVyR8aleWr8alkluU8VVmgiS19yVZwzXfS0QVap7vkCer5CGu0=
=YBYy
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
