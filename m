Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89211C38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 11:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJ3LnK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3LnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 07:43:09 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9185CB841
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667130180; bh=hUPIERufh2YPKYUYEFtjKEriqayeFlciFf3o4OX2rFY=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=DTUoBa8VGTqcdy0pknLcNcVY4lzElaNoIluMf3ARctN6od3YozP8PEc/e0JiUvz9b
         kW7XebAcFZ9cLVwoCAny9JrGraM1gOv2SpRatn958n57+HV3qs6p804Y+NT/oNUOxP
         mUH/G3QqSYI3PoEIWXRljLa8LAuMu75hbHI3gEowm5YnCmiUd19fuBRzej8OZX3W0D
         Kurq+RO0hUkZR5Q2xcEePGKFQXVvfnAkfFuJW0k94TZSGU4KPBV1dM0AACKyKW6Tbv
         L0XQi4o/Tc5VmWcXKTwAoTs9GWpcKpmYRzs5JrdtURmjRL/dtVGqJupjqfpmBwCq3i
         oIHEagQLNcY3A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXXRL-1oYG0B0tyR-00Yx7b; Sun, 30
 Oct 2022 12:43:00 +0100
Message-ID: <1281ea52-cb10-638b-7612-8fa9dbecc31e@web.de>
Date:   Sun, 30 Oct 2022 12:42:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH v2 01/12] merge: remove always-the-same "verbose" arguments
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
In-Reply-To: <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+Q4TZ8Gm4EnoECWdHuOiEDylQp3kBMmQZ2g+EL8ufoirGSY3aMC
 f8Hkfw0z9jPpQB2i7LktSY1O1b5QyTlAg/Be0MpXNFPZGmURJK4IGcHOpgsE7SvTedcIqeY
 IiXbSKF/vVSFrhk7o7OtLZxn+x6J463/36CqYTNKoVY9hJUAcvdUmGM5ci3WB/8SiUGogNL
 pYZFH1KFeYnjIOH2oPjRQ==
UI-OutboundReport: notjunk:1;M01:P0:KJr2DI4Qqhg=;RqCuGGS0wtNREzE/ZdAIz3sXEhz
 bLqgKu4Nv3ZDOoY2gFFklNODbhvvFUHEhM6TtoEf61uewTP5mL448ujx1902BzUIfoukxOJt+
 sAKiB6ssC5jjm/KEBdOJReRUCC3D/rBcZ9E4G1Kagna5y2700mh/h5PmIG2dl4fzA2TaYtTKd
 FBOjKFNXyDmnzWK0fYMW/NigN6Hyz3Or9H7OpG5JXbF+ZpnFgUnXQjLCMuEM+pt2LNJQo6W0z
 5xnyFQFT70q70vga0bH5urj/layEDRTTyeY7t/CDXjjrQuQeKXWiR2Pq1oJeCuLukl84G5wKt
 DIFlZ8k74WZEWnKzCBTVsgC88aAp0GEAdJlyhqOCkcduHu2CB4ICiw2EJHUpIyPmg3q5k33XY
 +J+6SiyDQ0BAVaKb7Um0DWcaTjT8e5bZmew+jB/MIicuRm7L6s/bBpAJc3QevlD9XFEJpa+yM
 00Vtx9Y4xBq8ORD21NHmdLmVi4M+THfNcEcRnQUkH8kpjBGvll3WjaG9wKwnCdVx9xjyqXy/Q
 hDl+81N9znTMQTrrSgVe3goJxbpBfNIRwMWuusd1t+n1LVGboiBqjNqEBXyr03ZnuMXKLW5W+
 wtHeamAyf0opYE3kb9BoxCgiuZ2mtqzIYRUEMEyyFjYL9v/igBXRqHPaWVkc3lh7HpzKg4uZe
 o3ujOP8DGuD+7QmmoWPZ6Elii7WHuiLGB5ITrPNCR6NPb4TXF0V9SPxFW3ULvWwQPHFZdbfI5
 5fkzYluvpMdS/PJQee60b0IAyc+aqhQb87tHN/beZICf0QZpNSjSptnKZRSVuDFXMgHRZdpHC
 TunEZS6tYnb+HP+OhmL66pESJGF7USqgfKSu7XqVzt8Ms5lwcepT64uDU6+Xcs60qtIHKZcOI
 y6YFJ7TOM/G05Pg9hGBpV+hr8GrKarEVM27QSGq6vYpVpJRhF30Avh1zWUN/088ADn7ydWD3T
 XL1vgulNVB+w83xgNhSr9Pb6tWA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Simplify the code that builds the arguments for the "read-tree"
invocation in reset_hard() and read_empty() to remove the "verbose"
parameter.

Before 172b6428d06 (do not overwrite untracked during merge from
unborn branch, 2010-11-14) there was a "reset_hard()" function that
would be called in two places, one of those passed a "verbose=3D1", the
other a "verbose=3D0".

After 172b6428d06 when read_empty() was split off from reset_hard()
both of these functions only had one caller. The "verbose" in
read_empty() would always be false, and the one in reset_hard() would
always be true.

There was never a good reason for the code to act this way, it
happened because the read_empty() function was a copy/pasted and
adjusted version of reset_hard().

Since we're no longer conditionally adding the "-v" parameter
here (and we'd only add it for "reset_hard()" we'll be able to move to
a simpler and safer run-command API in the subsequent commit.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/merge.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5900b81729..3bb49d805b 100644
=2D-- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -345,14 +345,12 @@ static int save_state(struct object_id *stash)
 	return rc;
 }

-static void read_empty(const struct object_id *oid, int verbose)
+static void read_empty(const struct object_id *oid)
 {
 	int i =3D 0;
 	const char *args[7];

 	args[i++] =3D "read-tree";
-	if (verbose)
-		args[i++] =3D "-v";
 	args[i++] =3D "-m";
 	args[i++] =3D "-u";
 	args[i++] =3D empty_tree_oid_hex();
@@ -363,14 +361,13 @@ static void read_empty(const struct object_id *oid, =
int verbose)
 		die(_("read-tree failed"));
 }

-static void reset_hard(const struct object_id *oid, int verbose)
+static void reset_hard(const struct object_id *oid)
 {
 	int i =3D 0;
 	const char *args[6];

 	args[i++] =3D "read-tree";
-	if (verbose)
-		args[i++] =3D "-v";
+	args[i++] =3D "-v";
 	args[i++] =3D "--reset";
 	args[i++] =3D "-u";
 	args[i++] =3D oid_to_hex(oid);
@@ -385,7 +382,7 @@ static void restore_state(const struct object_id *head=
,
 {
 	struct strvec args =3D STRVEC_INIT;

-	reset_hard(head, 1);
+	reset_hard(head);

 	if (is_null_oid(stash))
 		goto refresh_cache;
@@ -1470,7 +1467,7 @@ int cmd_merge(int argc, const char **argv, const cha=
r *prefix)
 					       check_trust_level);

 		remote_head_oid =3D &remoteheads->item->object.oid;
-		read_empty(remote_head_oid, 0);
+		read_empty(remote_head_oid);
 		update_ref("initial pull", "HEAD", remote_head_oid, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 		goto done;
=2D-
2.38.1
