From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH 1/3] repack: rewrite the shell script in C
Date: Tue, 17 Sep 2013 22:13:24 +0200
Message-ID: <5238B7E4.6060506@googlemail.com>
References: <1379259202-5042-1-git-send-email-stefanbeller@googlemail.com> <xmqqy56vxqhi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA7D780C5FFBF2721B65F9E70"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 22:13:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM1e5-0003I5-3E
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 22:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593Ab3IQUNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 16:13:07 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:46341 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab3IQUNF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 16:13:05 -0400
Received: by mail-wi0-f175.google.com with SMTP id ez12so5433223wid.8
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 13:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=0qztSwLcxeMA+0nwD9hST4qnHC5ag42Oxd4tj1HL5So=;
        b=zRFnIZpIVMvusqb11sbxvgwFloTOlhYBv9AQXrLH7u36Pw8v86FOcNSc8ypEGabZ9J
         dPNTZK+Lk751Oe64zKev+POIiDvRcN/AcM7D1coM564a2wUU5qFlsHc87cD4BbotFj5m
         rxgCZnptDMkWW80oz7aErH/srKf81VekFPNL6jA7KF1gPSDYKWZhvF812krJcZZpyhSi
         GlGY/X8Gw10iwtsbdWYmhfsJaSFV5zGJfviDrr/2y3CsQ4TJCSxlW5hpmdjnOq6QfNzR
         QkDq4Y3kCIgXtGVXqYmOzhgDbMjRr8YAOZ2wp59V5J9iPXYd9guOev80qRuNB7KWvzd4
         T+Mw==
X-Received: by 10.180.9.203 with SMTP id c11mr3955283wib.64.1379448783294;
        Tue, 17 Sep 2013 13:13:03 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id i8sm6924582wiy.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 13:13:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <xmqqy56vxqhi.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234913>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA7D780C5FFBF2721B65F9E70
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/17/2013 08:17 PM, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>=20
>> +	struct option builtin_repack_options[] =3D {
>> +		OPT_BIT('a', NULL, &pack_everything,
>> +				N_("pack everything in a single pack"), ALL_INTO_ONE),
>> +		OPT_BIT('A', NULL, &pack_everything,
>> +				N_("same as -a, and turn unreachable objects loose"),
>> +				   LOOSEN_UNREACHABLE),
>=20
> Micronit.
>=20
> With the current version of the code in cmd_repack() that uses the
> pack_everything variable this may not make a difference, but I think
> this should logically be "LOOSEN_UNREACHABLE | ALL_INTO_ONE" instead,
> and the code should check (pack_evertying & ALL_INTO_ONE) instead of
> checking "!pack_everything".  You may want to add to this flag variable=

> a new bit that does _not_ cause it to pack everything into one.
>=20

I do understand the "LOOSEN_UNREACHABLE | ALL_INTO_ONE" here, as that
is the logical thing we are doing. Combined with your second idea this=20
would result in
---8<---

=46rom 4bbbfb312bf23efa7e702e200fbc2d4479e3477e Mon Sep 17 00:00:00 2001
From: Stefan Beller <stefanbeller@googlemail.com>
Date: Tue, 17 Sep 2013 22:04:35 +0200
Subject: [PATCH 2/2] Suggestions by Junio

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/repack.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index e5f90c6..a0ff5c7 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -143,7 +143,7 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
 				N_("pack everything in a single pack"), ALL_INTO_ONE),
 		OPT_BIT('A', NULL, &pack_everything,
 				N_("same as -a, and turn unreachable objects loose"),
-				   LOOSEN_UNREACHABLE),
+				   LOOSEN_UNREACHABLE | ALL_INTO_ONE),
 		OPT_BOOL('d', NULL, &delete_redundant,
 				N_("remove redundant packs, and run git-prune-packed")),
 		OPT_BOOL('f', NULL, &no_reuse_delta,
@@ -197,10 +197,7 @@ int cmd_repack(int argc, const char **argv, const ch=
ar *prefix)
 	if (no_reuse_object)
 		argv_array_pushf(&cmd_args, "--no-reuse-object");
=20
-	if (!pack_everything) {
-		argv_array_push(&cmd_args, "--unpacked");
-		argv_array_push(&cmd_args, "--incremental");
-	} else {
+	if (pack_everything & ALL_INTO_ONE) {
 		get_non_kept_pack_filenames(&existing_packs);
=20
 		if (existing_packs.nr && delete_redundant) {
@@ -212,6 +209,9 @@ int cmd_repack(int argc, const char **argv, const cha=
r *prefix)
 				argv_array_push(&cmd_args,
 						"--unpack-unreachable");
 		}
+	} else {
+		argv_array_push(&cmd_args, "--unpacked");
+		argv_array_push(&cmd_args, "--incremental");
 	}
=20
 	if (local)
--=20
1.8.4.273.ga194ead


However I assume you mean to even ease up the conditions now, because now=

both -a as well as -A set ALL_INTO_ONE we could apply the following=20
on top of the previous.
---8<---

=46rom 80199368ab6c7ab72f81a5c531f79073a99d2498 Mon Sep 17 00:00:00 2001
From: Stefan Beller <stefanbeller@googlemail.com>
Date: Tue, 17 Sep 2013 22:11:08 +0200
Subject: [PATCH] Further improvements by reducing nested ifs

This may pass --unpacked and --unpack-unreachable to pack-objects in one
command, which is redundant. On the other hand we may gain simplicity in
repack.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/repack.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a0ff5c7..3e56614 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -197,23 +197,23 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
 	if (no_reuse_object)
 		argv_array_pushf(&cmd_args, "--no-reuse-object");
=20
-	if (pack_everything & ALL_INTO_ONE) {
+	if (pack_everything & ALL_INTO_ONE)
 		get_non_kept_pack_filenames(&existing_packs);
-
-		if (existing_packs.nr && delete_redundant) {
-			if (unpack_unreachable)
-				argv_array_pushf(&cmd_args,
-						"--unpack-unreachable=3D%s",
-						unpack_unreachable);
-			else if (pack_everything & LOOSEN_UNREACHABLE)
-				argv_array_push(&cmd_args,
-						"--unpack-unreachable");
-		}
-	} else {
+	else {
 		argv_array_push(&cmd_args, "--unpacked");
 		argv_array_push(&cmd_args, "--incremental");
 	}
=20
+	if (existing_packs.nr && delete_redundant) {
+		if (unpack_unreachable)
+			argv_array_pushf(&cmd_args,
+					"--unpack-unreachable=3D%s",
+					unpack_unreachable);
+		else if (pack_everything & LOOSEN_UNREACHABLE)
+			argv_array_push(&cmd_args,
+					"--unpack-unreachable");
+	}
+
 	if (local)
 		argv_array_push(&cmd_args,  "--local");
 	if (quiet)
--=20
1.8.4.273.ga194ead




--------------enigA7D780C5FFBF2721B65F9E70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSOLfkAAoJEJQCPTzLflhq1r8P/1Lc6zHWZSSs6YMs7LwhvNdC
XF++u5H9I0ye+N1nMEZVGXg7imlqJifQPYZ40jereC5K8cZpuIqLRzjYeMB8zvU/
jUotAUJzbWhMVNmrXR1O2Y75y43EH5SmM0ckZeeHnzVCVXW6kezJ2xKyEPLYmySM
nfBuxr7sI8leqFLgUrQ7Xr2bEmvlONK/hxU0hdVuOfZv50qDIiNzFO8twTuY4kgH
PstLCA1ILok97QhByEaugdnbQg63PT8CLRv/dop9yughi9FfbWoHUrs4HHmUhdBY
uO5cnFe81jVQnDe8ANSAe4Blj80c6y6UwtQ/BJNg4fTuP1+2vzK1npA9OoM5UEur
yT7SE9d/nECh4IgHEUYrDGiDrua52G7NumwEilv5Ke9cGAyPy3ZFOM+pRJZeLsef
q+IAglA4ePGMJqORD1IseqwtIrrfKukV7gMR3UZe9g1Ro4UzAWGDvS72wBSXaPiL
MfSiuBgbbCvY+/UWgTg2INWrnI1xRtzH1GJeOmmbsNt/7uLLRj39Xf90ULjiUu/u
CRwPVsLhTPOJ20yei04fCjOiv/Y+2n0QJtGRNYIskReZm9qnAOkvgrlhEQMqn3Lp
+IfsGVXYjolTW0r7r1ZtQ+3oqYVRujk5wQBWGF9IM6k5FLvK/oRGBlUuPCqqUz52
ClIMfkHyqsq6/ZUBKokd
=3uxW
-----END PGP SIGNATURE-----

--------------enigA7D780C5FFBF2721B65F9E70--
